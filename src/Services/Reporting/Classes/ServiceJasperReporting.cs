using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using PdfSharp.Pdf.IO;
using Persistence.Entities;
using Services.Reporting.Interfaces;
using Services.Specific.Administration.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using Spire.Pdf;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.ReportUtilities;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Reporting.Classes
{
    /// <summary>
    /// This service provide informations for Jasper report
    /// </summary>
    public class ServiceJasperReporting : IServiceJasperReporting, IDisposable
    {
        #region Fields
        protected const string jsonHeaderType = "application/json";
        private const string zip = "zip";
        protected readonly List<string> listOutputFormat = new List<string> { "pdf", "html", "xls" };
        protected readonly AppSettings _appSettings;
        private readonly IServiceCurrency _serviceCurrency;
        private static HttpClient _client;
        private JasperReportingExecutionResponse executionResult;
        private readonly JasperReportingQuery reportQuery;
        private ResourceLookup resourceLookUp;
        private JasperReportingResources reportingResources;

        #endregion
        #region Constructor
        public ServiceJasperReporting(IServiceCurrency serviceCurrency, IOptions<AppSettings> appSettings)
        {
            _serviceCurrency = serviceCurrency;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
            executionResult = new JasperReportingExecutionResponse();
            reportQuery = new JasperReportingQuery();
        }

        #endregion

        #region Methodes

        /// <summary>
        /// initialize the httpClient
        /// </summary>
        public void InitClient()
        {
            _client = new HttpClient
            {
                BaseAddress = _appSettings.JasperReportUrl
            };
            _client.DefaultRequestHeaders.Authorization = null;
            _client.DefaultRequestHeaders.Accept.Clear();
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
            SetClientAuthentication(_appSettings.JasperUser, _appSettings.JasperPassword);
        }

        /// <summary>
        /// Authentication to JasperServer
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void SetClientAuthentication(string username = "jasperadmin", string password = "jasperadmin")
        {
            try
            {
                _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(Encoding.ASCII.GetBytes($"{username}:{password}")));

            }
            catch
            {
                throw new ArgumentNullException();
            }

        }

        /// <summary>
        /// prepare default parameters for any report
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public IList<ReportParameter> PrepareGenericReportParameters(string userMail)
        {
            IList<ReportParameter> reportParams = new List<ReportParameter>
            {
                new ReportParameter()
                {
                    Name = "report_sourceUrl",
                    Value = new List<dynamic> { _appSettings.JasperSourceUrl }
                },
                new ReportParameter()
                {
                    Name = "current_user",
                    Value = new List<dynamic> { userMail }
                },
                new ReportParameter()
                {
                    Name = "telerik",
                    Value = new List<dynamic> { "Telerik" }
                }
            };
            return reportParams;
        }

        /// <summary>
        /// Ensures the download of a single report in pdf format
        /// </summary>
        /// <param name="data"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public async Task<FileInfoViewModel> ExecuteJasperReport(DownloadReportDataViewModel data, string userMail)
        {
            InitClient();
            var reportInfo = await GetReportLookUp(data.ReportName).ConfigureAwait(true);
            // Set report Uri
            reportQuery.ReportUnitUri = reportInfo.Uri;
            SetOutputFormat(data.ReportFormatName);
            SetAsyncExecution(false);
            IList<ReportParameter> reportParams = PrepareGenericReportParameters(userMail);
            foreach (var item in data.Reportparameters)
            {
                reportParams.Add(
                    new ReportParameter()
                    {
                        Name = item.Path,
                        Value = new List<dynamic> { item.Value.ToString() }
                    });
            }
            var dataResult = await ExecuteAndDownloadReport(reportInfo, reportParams, data).ConfigureAwait(true);
            return dataResult;
        }        

        /// <summary>
        /// search and return the report infomations from the JasperServer
        /// </summary>
        /// <param name="reportName"></param>
        /// <returns></returns>
        public async Task<ResourceLookup> GetReportLookUp(string reportName)
        {
            JasperReportingResourcesLookup execResult = new JasperReportingResourcesLookup
            {
                ResourceLookup = new List<ResourceLookup>()
            };
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("resources?type=reportUnit&q=" + reportName, UriKind.Relative),
                Method = HttpMethod.Get
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage).ConfigureAwait(true);
            CheckStatusCode(httpResponseMesssage);
            var json = httpResponseMesssage.Content.ReadAsStringAsync().Result;
            execResult = JsonConvert.DeserializeObject<JasperReportingResourcesLookup>(json);
            resourceLookUp = execResult?.ResourceLookup.First(x => x.Label.Equals(reportName));
            return resourceLookUp;
        }
        
        // Check if Jasper server is available or not
        private void CheckStatusCode(HttpResponseMessage httpResponseMesssage)
        {
            if ((int)httpResponseMesssage.StatusCode != NumberConstant.TwoHundred)
            {
                throw new CustomException(CustomStatusCode.UnreachableJasperServer);
            }
        }

        /// <summary>
        /// get the byte format of the report and tranform it to a FileInfoViewModel object
        /// </summary>
        /// <param name="reportResource"></param>
        /// <param name="reportParams"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public async Task<FileInfoViewModel> ExecuteAndDownloadReport(ResourceLookup reportResource, dynamic reportParams, DownloadReportDataViewModel data = null)
        {
            var byteResult = await ExecuteAndDownloadReportByte(reportResource, data.ReportFormatName, reportParams, data);
            FileInfoViewModel fileInfoViewModel = new FileInfoViewModel()
            {
                Data = byteResult,
                Extension = reportQuery.OutputFormat,
                Name = data != null && !string.IsNullOrWhiteSpace(data.DocumentName) ? data.DocumentName + "." + reportQuery.OutputFormat : executionResult.Exports[0]?.OutputResource?.FileName
            };

            //ProcessStartInfo psInfo = new ProcessStartInfo();
            //psInfo.Arguments = String.Format(" -dPrinted -dBATCH -dNOPAUSE -dNOSAFER -q -dNumCopies=1 -sDEVICE=ljet4 -sOutputFile=\"\\\\spool\\{0}\" \"{1}\"", "Brother MFC-J245", "test");

            //System.IO.File.WriteAllBytes(@"tee.pdf", byteResult);

            //psInfo.FileName = @"tee.pdf";
            //psInfo.UseShellExecute = false;
            //Process process = Process.Start(psInfo);
            //File.Delete(@"tee.pdf");


            //PdfDocument pdfdocument = new PdfDocument();
            //System.IO.File.WriteAllBytes(@"tee.pdf", byteResult);
            //pdfdocument.LoadFromFile(@"tee.pdf");
            //pdfdocument.PrinterName = "Brother MFC-J245";
            ////pdfdocument.PrintDocument.PrintPage = 1;
            //pdfdocument.PrintDocument.Print();
            //File.Delete(@"tee.pdf");
            //pdfdocument.Dispose();

            return fileInfoViewModel;

        }

        /// <summary>
        /// Execute HttpResponseMessage to get the report in byte format
        /// </summary>
        /// <param name="reportResource"></param>
        /// <param name="reportFormat"></param>
        /// <param name="reportParams"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public async Task<byte[]> ExecuteAndDownloadReportByte(ResourceLookup reportResource, string reportFormat, dynamic reportParams, DownloadReportDataViewModel data = null)
        {
            string paramNames = "?";
            foreach (ReportParameter item in reportParams)
            {
                paramNames = paramNames + item.Name + "=" + (item.Value[NumberConstant.Zero] is bool ? item.Value[NumberConstant.Zero].ToString().ToLower() : item.Value[NumberConstant.Zero].ToString()) + "&";
            }
            paramNames = paramNames.TrimEnd('&');
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reports" + reportResource.Uri + "." + reportFormat + paramNames, UriKind.Relative),
                Method = HttpMethod.Get
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage).ConfigureAwait(true);
            CheckStatusCode(httpResponseMesssage);
            var bytearray = httpResponseMesssage.Content.ReadAsByteArrayAsync().Result;
            httpResponseMesssage.EnsureSuccessStatusCode();
            return bytearray;
        }

        /// <summary>
        /// create many reports but make them in the same pdf file
        /// </summary>
        /// <param name="data"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public async Task<FileInfoViewModel> ExecuteMultipleJasperReport(DownloadReportDataViewModel data, string userMail)
        {
            InitClient();
            var reportInfo = await GetReportLookUp(data.ReportName);
            // Set report Uri
            reportQuery.ReportUnitUri = reportInfo.Uri;
            SetOutputFormat(data.ReportFormatName);
            SetAsyncExecution(false);
            var listPdfBytes = new List<byte[]>();
            IList<ReportParameter> reportParams = PrepareGenericReportParameters(userMail);
            reportParams.Add(
               new ReportParameter()
               {
                   Name = "print_type",
                   Value = new List<dynamic> { data.PrintType.ToString() }
               });
            for (int i = 0; i < data.DynamicListIds.Count(); i++)
            {
                var dynamicIdPath = ((Newtonsoft.Json.Linq.JContainer)data.DynamicListIds[i]).First.Path;
                var dynamicIdValue = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)data.DynamicListIds[i]).First).Value.ToString();
                reportParams.Add(
                    new ReportParameter()
                    {
                        Name = dynamicIdPath,
                        Value = new List<dynamic> { dynamicIdValue }
                    });

                var byteResult = await ExecuteAndDownloadReportByte(reportInfo, data.ReportFormatName, reportParams, data);
                listPdfBytes.Add(byteResult);
                reportParams.RemoveAt(reportParams.Count - NumberConstant.One);
            }

            var pdfResult = MergePdf(listPdfBytes);
            FileInfoViewModel dataResult = new FileInfoViewModel()
            {
                Data = pdfResult,
                Extension = reportQuery.OutputFormat,
                Name = data != null && !string.IsNullOrWhiteSpace(data.DocumentName) ? data.DocumentName + "." + reportQuery.OutputFormat : executionResult.Exports[0]?.OutputResource?.FileName
            };
            return dataResult;
        }

        /// <summary>
        /// merge many byte files and return them as one byte object
        /// </summary>
        /// <param name="pdfs"></param>
        /// <returns></returns>
        public static byte[] MergePdf(List<byte[]> pdfs)
        {
            if (pdfs.Any())
            {
                List<PdfSharp.Pdf.PdfDocument> lstDocuments = new List<PdfSharp.Pdf.PdfDocument>();
                foreach (var pdf in pdfs)
                {
                    lstDocuments.Add(PdfReader.Open(new MemoryStream(pdf), PdfDocumentOpenMode.Import));
                }

                using (PdfSharp.Pdf.PdfDocument outPdf = new PdfSharp.Pdf.PdfDocument())
                {
                    for (int i = 1; i <= lstDocuments.Count; i++)
                    {
                        foreach (PdfSharp.Pdf.PdfPage page in lstDocuments[i - 1].Pages)
                        {
                            outPdf.AddPage(page);
                        }
                    }

                    MemoryStream stream = new MemoryStream();
                    outPdf.Save(stream, false);
                    byte[] bytes = stream.ToArray();

                    return bytes;
                }
            }
            throw new CustomException(CustomStatusCode.NoDataToReturn);
            return null;
        }

        /// <summary>
        /// Ensures massive download of reports in a zip file
        /// </summary>
        /// <param name="downloadReportDataViewModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public async Task<FileInfoViewModel> MassiveDownLoad(DownloadReportDataViewModel downloadReportDataViewModel, string userMail)
        {
            if (downloadReportDataViewModel == null)
            {
                throw new ArgumentNullException();
            }
            InitClient();
            ResourceLookup resourceLookup = await GetReportLookUp(downloadReportDataViewModel.ReportName).ConfigureAwait(true);
            IList<ReportParameter> reportParameters = PrepareGenericReportParameters(userMail);
            using (var memoryStream = new MemoryStream())
            {
                using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
                {
                    foreach (var currentReportSetting in downloadReportDataViewModel.DynamicListIds)
                    {
                        if (currentReportSetting.reportParameters != null)
                        {
                            foreach (var item in currentReportSetting.reportParameters)
                            {
                                reportParameters.Add(
                                    new ReportParameter()
                                    {
                                        Name = item.Name,
                                        Value = new List<dynamic> { item.Value.ToString() }
                                    });
                            }
                        }
                        else
                        {
                            var dynamicIdPath = ((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First.Path;
                            var dynamicIdValue = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First).Value.ToString();
                            reportParameters.Add(
                              new ReportParameter()
                              {
                                  Name = dynamicIdPath,
                                  Value = new List<dynamic> { dynamicIdValue }
                              });
                        }
                        downloadReportDataViewModel.DocumentName = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).Last).Value.ToString();
                        FileInfoViewModel taskFileInfo = await ExecuteAndDownloadReport(resourceLookup, reportParameters, downloadReportDataViewModel).ConfigureAwait(true);
                        string fileName = downloadReportDataViewModel.DocumentName + "." + downloadReportDataViewModel.ReportFormatName;
                        var demoFile = archive.CreateEntry(fileName);
                        using (var entryStream = demoFile.Open())
                        using (var streamWriter = new StreamWriter(entryStream))
                        {
                            streamWriter.BaseStream.Write(taskFileInfo.Data, NumberConstant.Zero, taskFileInfo.Data.Length);
                        }
                        reportParameters = PrepareGenericReportParameters(userMail);
                    }
                }
                FileInfoViewModel fileInfoViewModel = new FileInfoViewModel
                {
                    Extension = zip,
                    Name = string.Concat(downloadReportDataViewModel.ZipFolderName, ".", zip),
                    Data = memoryStream.ToArray(),
                };
                return fileInfoViewModel;
            }
        }

        public async Task<Dictionary<Contract, FileInfoViewModel>> GetPayslipReports(DownloadReportDataViewModel downloadReportDataViewModel, IList<Payslip> payslips, string userMail)
        {
            InitClient();
            var reportInfo = await GetReportLookUp(downloadReportDataViewModel.ReportName).ConfigureAwait(true);
            // Set report Uri
            reportQuery.ReportUnitUri = reportInfo.Uri;
            SetOutputFormat(downloadReportDataViewModel.ReportFormatName);
            ResourceLookup resourceLookup = await GetReportLookUp(downloadReportDataViewModel.ReportName).ConfigureAwait(true);
            IList<ReportParameter> reportParameters = PrepareGenericReportParameters(userMail);
            Dictionary<Contract, FileInfoViewModel> payslipReportsDictionary = new Dictionary<Contract, FileInfoViewModel>();
            foreach (var currentReportSetting in downloadReportDataViewModel.DynamicListIds)
            {
                var dynamicIdPath = ((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First.Path;
                var dynamicIdValue = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First).Value.ToString();
                reportParameters.Add(
                    new ReportParameter()
                    {
                        Name = dynamicIdPath,
                        Value = new List<dynamic> { dynamicIdValue }
                    });
                downloadReportDataViewModel.DocumentName = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).Last).Value.ToString();
                FileInfoViewModel taskFileInfo = await ExecuteAndDownloadReport(resourceLookup, reportParameters, downloadReportDataViewModel).ConfigureAwait(true);
                taskFileInfo.Extension = reportQuery.OutputFormat;
                Contract contract = payslips.FirstOrDefault(x => x.Id == short.Parse(dynamicIdValue)).IdContractNavigation;
                payslipReportsDictionary.Add(contract, taskFileInfo);
                reportParameters.RemoveAt(reportParameters.Count - NumberConstant.One);
            }
            return payslipReportsDictionary;
        }

        public async Task<Dictionary<Employee, FileInfoViewModel>> GetSourceDeductionReports(DownloadReportDataViewModel downloadReportDataViewModel, IList<SourceDeduction> sourceDeduction, string userMail)
        {
            InitClient();
            var reportInfo = await GetReportLookUp(downloadReportDataViewModel.ReportName).ConfigureAwait(true);
            // Set report Uri
            reportQuery.ReportUnitUri = reportInfo.Uri;
            SetOutputFormat(downloadReportDataViewModel.ReportFormatName);
            ResourceLookup resourceLookup = await GetReportLookUp(downloadReportDataViewModel.ReportName).ConfigureAwait(true);
            IList<ReportParameter> reportParameters = PrepareGenericReportParameters(userMail);
            Dictionary<Employee, FileInfoViewModel> sourceDeductionReportsDictionary = new Dictionary<Employee, FileInfoViewModel>();
            foreach (var currentReportSetting in downloadReportDataViewModel.DynamicListIds)
            {
                var dynamicIdPath = ((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First.Path;
                var dynamicIdValue = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).First).Value.ToString();
                reportParameters.Add(
                    new ReportParameter()
                    {
                        Name = dynamicIdPath,
                        Value = new List<dynamic> { dynamicIdValue }
                    });
                downloadReportDataViewModel.DocumentName = ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)currentReportSetting).Last).Value.ToString();
                FileInfoViewModel taskFileInfo = await ExecuteAndDownloadReport(resourceLookup, reportParameters, downloadReportDataViewModel).ConfigureAwait(true);
                taskFileInfo.Extension = reportQuery.OutputFormat;
                Employee contract = sourceDeduction.FirstOrDefault(x => x.Id == short.Parse(dynamicIdValue)).IdEmployeeNavigation;
                sourceDeductionReportsDictionary.Add(contract, taskFileInfo);
                reportParameters.RemoveAt(reportParameters.Count - NumberConstant.One);
            }
            return sourceDeductionReportsDictionary;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="outputFormat"></param>
        public void SetOutputFormat(string outputFormat)
        {
            if (listOutputFormat.Contains(outputFormat))
            {
                reportQuery.OutputFormat = outputFormat;
            }
            else
            {
                throw new Exception("The output format is incorrect");
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="asyncRun"></param>
        public void SetAsyncExecution(bool asyncRun)
        {
            reportQuery.Async = asyncRun;
        }

        #region unused methods
        public async Task SetJaspertReportParamsAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams)
        {
            var reportQueryData = new List<ReportParameter>(); ;

            foreach (var item in reportParams)
            {
                reportParams.Add(
                    new ReportParameter()
                    {
                        Name = item.Path,
                        Value = new List<dynamic> { item.Value.ToString() }
                    });
            }
            var jsonContent = JsonConvert.SerializeObject(reportQueryData);
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reportExecutions/" + executionResult.RequestId.ToString() + "/parameters", UriKind.Relative),
                Method = HttpMethod.Post,
                Content = new StringContent(jsonContent, Encoding.UTF8, jsonHeaderType)
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            var json = httpResponseMesssage.Content.ReadAsStringAsync().Result;
            httpResponseMesssage.EnsureSuccessStatusCode();
        }

        public async Task SetJaspertReportParamsInputControlAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams)
        {
            var reportQueryData = new Dictionary<dynamic, dynamic[]>();
            string paramNames = "";
            foreach (var item in reportParams)
            {
                reportQueryData.Add(item.Name, new dynamic[] { item.Value[0].ToString() });

                paramNames = paramNames + item.Name + ";";
            }
            var jsonContent = JsonConvert.SerializeObject(reportQueryData);
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reports" + reportResource.Uri + "/inputControls/" + paramNames + "/values", UriKind.Relative),
                Method = HttpMethod.Post
            };
            httpRequestMessage.Content = new StringContent(jsonContent, Encoding.UTF8, jsonHeaderType);
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            var json = httpResponseMesssage.Content.ReadAsStringAsync().Result;
            httpResponseMesssage.EnsureSuccessStatusCode();
        }

        public async Task ExecuteJaspertReportAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams)
        {
            JasperReportingQuery reportQueryData = new JasperReportingQuery()
            {
                ReportUnitUri = reportResource.Uri,
                OutputFormat = reportFormat,
                Async = false,
                FreshData = true,
                SaveDataSnapshot = false,
                Parameters = new Parameters
                {
                    ReportParameter = reportParams
                }
            };
            var jsonContent = JsonConvert.SerializeObject(reportQueryData);
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reportExecutions", UriKind.Relative),
                Method = HttpMethod.Post,
                Content = new StringContent(jsonContent, Encoding.UTF8, jsonHeaderType)
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            var json = httpResponseMesssage.Content.ReadAsStringAsync().Result;
            httpResponseMesssage.EnsureSuccessStatusCode();
            executionResult = JsonConvert.DeserializeObject<JasperReportingExecutionResponse>(json);
        }

        public async Task<FileInfoViewModel> ExportJasperReportDocument()
        {
            FileInfoViewModel responseData;
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reportExecutions/" + executionResult.RequestId.ToString() + "/exports/", UriKind.Relative),
                Method = HttpMethod.Get,
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            var bytearray = httpResponseMesssage.Content.ReadAsByteArrayAsync().Result;
            httpResponseMesssage.EnsureSuccessStatusCode();
            responseData = new FileInfoViewModel()
            {
                Data = bytearray,
                Extension = "pdf",
                Name = executionResult.Exports[0]?.OutputResource?.FileName
            };
            return responseData;
        }

        public async Task<FileInfoViewModel> DownloadJasperReportDocument(DownloadReportDataViewModel data = null)
        {
            HttpRequestMessage httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("reportExecutions/" + executionResult.RequestId.ToString() +
                    "/exports/" + executionResult.Exports[0].Id.ToString() + "/outputResource", UriKind.Relative),
                Method = HttpMethod.Get,
            };
            HttpResponseMessage httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            httpResponseMesssage.EnsureSuccessStatusCode();
            var bytearray = httpResponseMesssage.Content.ReadAsByteArrayAsync().Result;
            FileInfoViewModel fileInfoViewModel = new FileInfoViewModel()
            {
                Data = bytearray,
                Extension = reportQuery.OutputFormat,
                Name = data != null && !string.IsNullOrWhiteSpace(data.DocumentName) ? data.DocumentName + "." + reportQuery.OutputFormat : executionResult.Exports[0]?.OutputResource?.FileName
            };
            return fileInfoViewModel;
        }

        public async Task<JasperReportingResources> GetReportInfo(string reportName)
        {
            HttpRequestMessage httpRequestMessage;
            HttpResponseMessage httpResponseMesssage;
            List<JasperReportingResources> execResult = new List<JasperReportingResources>();
            httpRequestMessage = new HttpRequestMessage
            {
                RequestUri = new Uri("resources?type=reportUnit&q=" + reportName, UriKind.Relative),
                Method = HttpMethod.Get
            };
            httpResponseMesssage = await _client.SendAsync(httpRequestMessage);
            var json = httpResponseMesssage.Content.ReadAsStringAsync().Result;
            execResult.Add(JsonConvert.DeserializeObject<JasperReportingResources>(json));
            reportingResources = execResult != null && execResult.Count > 0 ? execResult[0] : null;
            return reportingResources;
        }

        public void SetParameter(List<ReportParameter> reportParameters)
        {
            reportQuery.Parameters = reportQuery.Parameters ?? new Parameters();
            reportQuery.Parameters.ReportParameter = reportParameters;
        }

        public void AddParameter(ReportParameter reportParameter)
        {
            reportQuery.Parameters = reportQuery.Parameters ?? new Parameters();
            reportQuery.Parameters.ReportParameter.Add(reportParameter);
        }

        public void RemoveParameter(ReportParameter reportParam)
        {
            if (reportQuery.Parameters == null || reportQuery.Parameters.ReportParameter == null || reportQuery.Parameters.ReportParameter.Count <= 0)
            {
                reportQuery.Parameters = new Parameters();
            }
            else
            {
                reportQuery.Parameters.ReportParameter.Remove(reportParam);
            }
        }
        public async Task<FileInfoViewModel> ExecuteMultipleVatDeclarationReport(DownloadReportDataViewModel data, string userMail)
        {
            InitClient();
            var reportInfo = await GetReportLookUp(data.ReportName).ConfigureAwait(true);
            reportQuery.ReportUnitUri = reportInfo.Uri;
            SetOutputFormat(data.ReportFormatName);
            SetAsyncExecution(false);
            var listPdfBytes = new List<byte[]>();
            IList<ReportParameter> reportParams = PrepareGenericReportParameters(userMail);
            foreach (var item in data.Reportparameters)
            {
                reportParams.Add(
                    new ReportParameter()
                    {
                        Name = item.Path,
                        Value = new List<dynamic> { item.Value.Value }
                    });
            }


            for (int i = 0; i < data.ListIds.Count(); i++)
            {
                reportParams.Add(
                    new ReportParameter()
                    {
                        Name = "idCurrency",
                        Value = new List<dynamic> { data.ListIds[i] }
                    });

                var byteResult = await ExecuteAndDownloadReportByte(reportInfo, data.ReportFormatName, reportParams, data);
                listPdfBytes.Add(byteResult);
                reportParams.RemoveAt(reportParams.Count - NumberConstant.One);
            }

            var pdfResult = MergePdf(listPdfBytes);
            FileInfoViewModel dataResult = new FileInfoViewModel()
            {
                Data = pdfResult,
                Extension = reportQuery.OutputFormat,
                Name = data != null && !string.IsNullOrWhiteSpace(data.DocumentName) ? data.DocumentName + "." + reportQuery.OutputFormat : executionResult.Exports[0]?.OutputResource?.FileName
            };
            return dataResult;
        }



        #endregion


        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    // TODO: dispose managed state (managed objects).
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.
                //_client.Dispose();
                disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~ServiceJasperReporting()
        // {
        //   // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
        //   Dispose(false);
        // }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            Dispose(true);
            // TODO: uncomment the following line if the finalizer is overridden above.
            // GC.SuppressFinalize(this);
        }
        #endregion

        #endregion
    }
}
