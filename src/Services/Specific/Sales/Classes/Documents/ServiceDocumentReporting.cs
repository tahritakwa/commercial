using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Settings.Config;
using System;
using System.Text;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        public override void UpdateReportSettings(DownloadReportDataViewModel data)
        {
            ReportTemplate reportTemplate = null;
            DocumentType documentType = null;
            if (data.ReportCode != null)
            {
                if(data.ReportName != null)
                {
                    reportTemplate = _entityRepoReportTemplate.FindSingleBy(x => x.ReportCode == data.ReportCode && x.ReportName == data.ReportName);
                }
                else
                {
                    reportTemplate = _entityRepoReportTemplate.FindSingleBy(x => x.ReportCode == data.ReportCode);
                }
                documentType = _entityDocumentTypeRepo.FindSingleBy(x => x.Code == data.ReportCode);
            }
            if (reportTemplate != null)
            {
                data.ReportName = reportTemplate.ReportName;
            }
            base.UpdateReportSettings(data);                              
            Document document = _entityRepo.FindSingleBy(x => x.Id == data.Id);
            if (documentType != null && document != null)
            {
                
                if (data.DocumentName == Constants.REPORT_D_PU)
                {
                    documentType.Description = Constants.PURCHASE_REPORT;
                }
                data.DocumentName = string.Concat(documentType.Description, Constants.Underscore, document.Code, Constants.Underscore, document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            }
            else if (documentType == null && document != null)
            {
                string docName = "";
                if (data.DocumentName == Constants.PURCHASE_DELIV_REPORT)
                {
                    docName = Constants.PURCHASE_REPORT;
                    data.DocumentName = string.Concat(docName, Constants.Underscore, document.Code, Constants.Underscore, document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));

                }else
                if (data.DocumentName == Constants.PURCHASE_DELIV_EXP_REPORT)
                {
                    docName = Constants.PURCHASE_EXPENSE_REPORT;
                    data.DocumentName = string.Concat(docName, Constants.Underscore, document.Code, Constants.Underscore, document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));


                }
                else if (data.DocumentName == Constants.PURCHASE_DELIV_COST_REPORT){

                    docName = Constants.PURCHASE_COST_REPORT;
                    data.DocumentName = string.Concat(docName, Constants.Underscore, document.Code, Constants.Underscore, document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));

                }
                else
                {
                    data.DocumentName = string.Concat(document.Code, Constants.Underscore, document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));

                }
    
            }

        }

        public override ReportSettings GetDocumentReportSettings(DownloadReportDataViewModel data, HttpContext httpContext, string userMail, PrinterSettings printerSettings)
        {
            ReportSettings reportSetting = new ReportSettings();
            CompanyViewModel company = GetCurrentCompany();
            reportSetting.ReportName = data.ReportName + ".trdp";
            reportSetting.Url = _appSettings.BaseUrl.ToString();
            reportSetting.User = userMail;
            reportSetting.Id = data.Id;
            reportSetting.IsFromBL = data.IsFromBl ?? 0;
            reportSetting.NumberofCopies = 1;
            reportSetting._printerSettings = printerSettings;
            if (company != null && company.DataLogoCompany != null)
            {
                reportSetting.IdCompany = company.Id;
                reportSetting.DataLogoCompany = Convert.ToBase64String(company.DataLogoCompany);
            }

            specificDocumenReportInit(reportSetting, data);
            reportSetting.ReportConnectionString = GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.ReportParameters = data.Reportparameters;
            return reportSetting;
        }


        public void specificDocumenReportInit(ReportSettings reportSetting, dynamic data)
        {
            int id = data.Id;
            DocumentViewModel result = GetModelWithRelationsAsNoTracked(x => x.Id == id);
            StringBuilder reportName = new StringBuilder();
            reportName.Append((string)result.GetType().GetProperty("Code").GetValue(result));
            reportSetting.ReportNameToDisplay = reportName.ToString();
            string docTypeCode = (string)result.GetType().GetProperty("DocumentTypeCode").GetValue(result);
            int? InoicingType = (int?)result.GetType().GetProperty("InoicingType")?.GetValue(result);
            InoicingType = InoicingType == null ? -1 : InoicingType;
            if (docTypeCode == DocumentEnumerator.SalesDelivery || docTypeCode == DocumentEnumerator.SalesAsset)
            {
                reportSetting.NumberofCopies = 2;
                reportSetting.ReportName = DocumentConstant.SDReportName;
            }
            else if (docTypeCode == DocumentEnumerator.SalesOrder)
            {
                reportSetting.NumberofCopies = 3;
                reportSetting.ReportName = DocumentConstant.SOReportName;
            }
            else if (docTypeCode == DocumentEnumerator.SalesInvoice && InoicingType == 3)
            {
                reportSetting.ReportName = DocumentConstant.SIOReportName;
            }
            else if (docTypeCode == DocumentEnumerator.SalesInvoice || docTypeCode == DocumentEnumerator.SalesInvoiceAsset)
            {
                reportSetting.ReportName = DocumentConstant.SIReportName;
            }
            else if (docTypeCode == DocumentEnumerator.BS)
            {
                reportSetting.ReportName = DocumentConstant.BSReportName;
            }
            else if (docTypeCode == DocumentEnumerator.BE)
            {
                reportSetting.ReportName = DocumentConstant.BEReportName;
            }
            else if (docTypeCode == DocumentEnumerator.PurchaseAsset || docTypeCode == DocumentEnumerator.PurchaseFinalOrder
                || docTypeCode == DocumentEnumerator.PurchaseOrder || docTypeCode == DocumentEnumerator.PurchaseInvoice)
            {
                reportSetting.ReportName = DocumentConstant.PurchaseDocReportName;
            }

        }

    }
}

