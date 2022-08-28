using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Services.Reporting.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Common;
using ViewModels.DTO.DBConfig;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Utils;

namespace Web.Controllers.GenericController
{
    [Route("api/base")]
    public class BaseController : Controller, IBaseController
    {
        IHttpContextAccessor _httpContextAccessor = null;
        protected const string jsonHeaderType = "application/json";
        protected const string dateFormat = "yyyyMMddHHmmssfffffff";
        protected const string connectionString = "connectionString";
        protected const string downloadReportsApi = "api/customReports/downloadReportsApi";
        private const string printReportsApi = "api/customReports/printReportsApi";
        protected const string multidownloadReportsApi = "api/customReports/multiDownloadDocument";
        private const string multiprintReportsApi = "api/customReports/multiPrintDocument";
        protected readonly AppSettings _appSettings;
        protected readonly PrinterSettings _printerSettings;
        private IServiceJasperReporting _serviceJasperReporting;

        /// <summary>
        /// Instance of the service that will be resolved in runtime
        /// </summary>
        public dynamic _service { get; set; }
        /// <summary>
        /// The ViewModel class
        /// </summary>
        public Type _model { get; set; }
        /// <summary>
        /// The header
        /// </summary>
        protected IHeaderDictionary header { get; set; }
        /// <summary>
        /// The service provider: it will instantiate the service using the interface
        /// and the IOC
        /// </summary>
        public IServiceProvider _serviceProvider { get; set; }
        /// <summary>
        /// The logger
        /// </summary>
        public ILogger<BaseController> _logger { get; set; }
        /// <summary>
        /// model of the current instance
        /// </summary>
        protected string modelName = "";
        /// <summary>
        /// user of the current transaction
        /// </summary>
        protected string userMail = "";
        /// <summary>
        ///  module of the current instance
        /// </summary>
        public string module { get; set; }


        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public BaseController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IOptions<AppSettings> appSettings = null,
            IOptions<PrinterSettings> printerSettings = null)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            module = "";
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
            if (printerSettings != null)
            {
                _printerSettings = printerSettings.Value;
            }

        }

        ///// <summary>
        ///// Initializes a new instance of the <see cref="BaseController"/> class.
        ///// </summary>
        ///// <param name="serviceProvider">The service provider.</param>
        //public BaseController(IServiceProvider serviceProvider, ILogger<BaseController> logger)
        //{
        //    _logger = logger;
        //    _serviceProvider = serviceProvider;
        //    module = "";
        //}



        protected void GetUserMail()
        {
            var user = decryptToken()["user"];
            ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
            if (user != null)
            {
                userMail = user.Email.ToString();
            }
            else
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Please verify the header TModel!");
                throw new Exception("Please verify the header TModel!");
            }
        }
        protected void GetUserMailInvariant()
        {
            var user = decryptToken()["user"];
            ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
            if (user != null)
            {
                userMail = user.Email.ToString();
            }
            else
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Please verify the header TModel!");
                throw new Exception("Please verify the header TModel!");
            }
        }
        /// <summary>
        /// Instantiate the service
        /// based on the model name and the module name
        /// provided from the HTTP header
        /// </summary>
        /// 
        protected string GetExceptionMsg(string exception)
        {
            var x = exception.IndexOf("«");
            var y = exception.IndexOf("»");
            if (x < 0 || y < 0)
            {
                x = exception.IndexOf("'");
                y = exception.IndexOf("'", exception.IndexOf("'") + 1);
            }
            return exception.Substring(x + 1, y - x - 1).Trim();
        }
        protected bool GetServiceName()
        {

            ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
            StringValues modelValue;
            StringValues moduleValue;

            GetUserMail();
            if (Request.Headers.TryGetValue("TModel", out modelValue))
            {
                modelName = modelValue.First();
                modelName = char.ToUpperInvariant(modelName[0]) + modelName.Substring(1);
            }
            else
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Please verify the header TModel!");
                throw new Exception("Please verify the header TModel!");
            }
            string interfaceName;
            if (Request.Headers.TryGetValue("Module", out moduleValue))
            {
                module = moduleValue.First();
                module = char.ToUpperInvariant(module[0]) + module.Substring(1);
                interfaceName = "Services.Specific." + module + ".Interfaces.IService" + modelName;

            }
            else
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Please verify the header Module!");
                throw new Exception("Please verify the header Module!");
            }
            var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);
            if (assemblyInterface == null)
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Can't find the assembly!");
                throw new Exception("Can't find the assembly!");
            }
            Type type = Type.GetType(assemblyInterface);
            if (type == null)
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Can't find the service interface!");
                throw new Exception("Can't find the service interface!");
            }
            Type[] implementedInterfaces = type.GetInterfaces();
            _model = implementedInterfaces[0].GenericTypeArguments[0];
            _service = _serviceProvider.GetRequiredService(type);
            if (_service == null)
            {
                exceptionLogger.ExceptionMethodSimpleMessage("Can't instanciate the service!");
                throw new Exception("Can't instanciate the service!");
            }
            return true;

        }
        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("getPredicate"), Authorize("LIST")]
        public virtual ResponseData GetPredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _service.FindModelBy(model)
                };
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpPost("getSinglePredicate"), Authorize("LIST")]
        public virtual ResponseData GetSinglePredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.FindSingleModelBy(model);
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate containing also grid filters</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// It return object containing a collections of items in listObject.listData attribute and the number of items in the listObject.listData attribut</returns>
        [HttpPost("getDataSourcePredicate")]
        public virtual ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.FindDataSourceModelBy(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST")]

        public virtual ResponseData GetDataDropdown()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetDataDropdown();

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }


        [HttpPost("getDataDropdownWithPredicate")]
        public virtual ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetDataDropdownBy(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }


        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate containing also grid filters</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// It return object containing a collections of items in listObject.listData attribute and the number of items in the listObject.listData attribut</returns>
        [HttpPost("getDataSourcePredicateAsNoTracking"), Authorize("LIST")]
        public virtual ResponseData GetDataSourcePredicateAsNoTracking([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.FindDataSourceModelByAsNoTracking(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpPost("getDataSourcePredicateValueMapper"), Authorize("LIST")]
        public virtual ResponseData GetDataSourcePredicateValueMapper([FromBody] ValueMapperResponseViewModel valueMapperVM)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _service.FindIndiceFromDataSource(valueMapperVM.Predicate, valueMapperVM.ValueMapper)
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        [HttpGet("get"), Authorize("LIST")]
        public virtual ResponseData Get()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _service.GetAllModels()
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }
        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("get"), Authorize("LIST")]
        public virtual ResponseData Get([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.FindDataSourceModelBy(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }

        [HttpGet("getById/{id}")]
        public virtual ResponseData GetById(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.GetModelById(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// Insert the new entity
        /// </summary>
        /// <param name="model"> Entity </param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is added successfully
        /// ResponseJson.Failed if The entity is not added
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpPost("insert"), Authorize("ADD")]
        public virtual ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {

                dynamic instanceType = JsonConvert.DeserializeObject(objectSaved.model.ToString(), type: _model);
                if (objectSaved.verifyUnicity != null)
                {
                    dynamic unictyData = JsonConvert.DeserializeObject(objectSaved.verifyUnicity.ToString());
                    if (this.GetUnicity(unictyData))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { "CODE" , unictyData.value }
                    };
                        throw new CustomException(CustomStatusCode.CodeUnicity, paramtrs);
                    }
                }
                var obj = _service.AddModel(instanceType, objectSaved.EntityAxisValues, userMail, null, objectSaved.isFromModal);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }

        /// <summary>
        /// update the existing entity
        /// </summary>
        /// <param name="model">entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is updated successfully
        /// ResponseJson.Failed if The entity is not updated
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpPut("update"), Authorize("UPDATE")]
        public virtual ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {

                dynamic instanceType = JsonConvert.DeserializeObject(objectSaved.model.ToString(), type: _model);
                if (objectSaved.verifyUnicity != null)
                {
                    dynamic unictyData = JsonConvert.DeserializeObject(objectSaved.verifyUnicity.ToString());
                    if (this.GetUnicity(unictyData))
                    {
                        throw new CustomException(CustomStatusCode.CodeUnicity);
                    }
                }
                var obj = _service.UpdateModel(instanceType, objectSaved.EntityAxisValues, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }
        /// <summary>
        /// delete entity
        /// </summary>
        /// <param name="model"> entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is deleted
        /// ResponseJson.Failed if The entity is not deleted
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpDelete("delete/{id}"), Authorize("DELETE")]
        public virtual ResponseData Delete(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var obj = _service.DeleteModel(id, modelName, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;
                result.objectData = obj;

            }
            return result;
        }

        /// <summary>
        /// update the existing entity
        /// </summary>
        /// <param name="model">entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is updated successfully
        /// ResponseJson.Failed if The entity is not updated
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpPut("updateWithCheck/{property}"), Authorize("UPDATE")]
        public virtual ResponseData PutWithChecking([FromBody] ObjectToSaveViewModel objectToSave, [FromRoute] string property)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                dynamic instanceType = JsonConvert.DeserializeObject(objectToSave.model.ToString(), type: _model);

                List<FilterViewModel> filters = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = instanceType.GetType().GetProperty("Id").GetValue(instanceType) }
                };

                var _oldmodel = _service.FindNoTrackedModelBy(filters)[0];
                var _oldValue = _oldmodel.GetType().GetProperty(property).GetValue(_oldmodel);
                var _propertyValue = instanceType.GetType().GetProperty(property).GetValue(instanceType);
                if (_oldValue != _propertyValue)
                {
                    PredicateFormatViewModel predicate = new PredicateFormatViewModel();
                    filters.Clear();
                    filters.Add(new FilterViewModel { Prop = property, Operation = Operation.Equals, Value = _propertyValue });
                    predicate.Filter = filters;
                    if (_service.CheckExistence(predicate))
                    {
                        throw new CustomException(CustomStatusCode.InternalServerError);
                    }
                }
                _service.UpdateModel(instanceType, objectToSave.EntityAxisValues, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
            }
            return result;
        }
        [HttpPost("getModelByCondition"), Authorize("LIST")]
        public virtual ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData test = new ResponseData
            {
                objectData = _service.GetModelWithRelations(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };

            return test;
        }

        [HttpPost("getUnicity"), Authorize("LIST,LIST_WAREHOUSE,UPDATE_GROUP_TAX,ADD_GROUP_TAX,SHOW_GROUP_TAX")]
        public virtual bool GetUnicity([FromBody] dynamic objectToCheck)
        {
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            UnicityViewModel unicityModel = JsonConvert.DeserializeObject<UnicityViewModel>(objectToCheck.ToString());
            return this._service.CheckUnicity(unicityModel);
        }

        [Route("Forbidden")]
        [HttpGet]
        [AllowAnonymous]
        public object Forbidden(AuthenticationProperties properties, params string[] authenticationSchemes)
        {
            return Forbid(properties, authenticationSchemes);
        }


        [Route("uploadFile"), Authorize("ADD")]
        [HttpPost]
        public virtual FileInfoViewModel UploadFile([FromBody] FileInfoViewModel fileInfoViewModel)
        {

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {

                return _service.Uploadfile(fileInfoViewModel);

            }

        }

        [Route("downloadZipFile"), Authorize("LIST")]
        [HttpPost]
        public ResponseData DownloadDocs([FromBody] int[] model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _service.DownloadZipFile(model.ToList());
            }
            return result;
        }

        //
        // Summary:
        //     Creates a Microsoft.AspNetCore.Mvc.ForbidResult (Microsoft.AspNetCore.Http.StatusCodes.Status403Forbidden
        //     by default).
        //
        // Returns:
        //     The created Microsoft.AspNetCore.Mvc.ForbidResult for the response.
        //
        // Remarks:
        //     Some authentication schemes, such as cookies, will convert Microsoft.AspNetCore.Http.StatusCodes.Status403Forbidden
        //     to a redirect to show a login page.
        [NonAction]
        public override ForbidResult Forbid(AuthenticationProperties properties, params string[] authenticationSchemes)
        {
            var props = new AuthenticationProperties
            {
                RedirectUri = ""
            };
            return new ForbidResult(props);
        }
        #region download methods for Telerik
        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadDocumentReport"), Authorize("PRINT")]
        public async Task<ResponseData> DownloadDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _service.GetDocumentReportSettings(data, HttpContext, userMail, _printerSettings);
            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(downloadReportsApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };
                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("printDocumentReport"), Authorize("PRINT")]
        public async Task<ResponseData> PrintDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _service.GetDocumentReportSettings(data, HttpContext, userMail, _printerSettings);
            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(printReportsApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };
                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("multiDownloadDocumentReport"), Authorize("PRINT")]
        public async Task<ResponseData> MultiDownloadDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _service.GetDocumentReportSettings(data, HttpContext, userMail, _printerSettings);
            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(multidownloadReportsApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };
                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("multiPrintDocumentReport"), Authorize("PRINT")]
        public async Task<ResponseData> MultiPrintDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _service.GetDocumentReportSettings(data, HttpContext, userMail, _printerSettings);
            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(multiprintReportsApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };
                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }
        #endregion

        /// <summary>
        /// Get Jasper Report Document using provided output format
        /// </summary>
        /// <param name="data">Paramater that contain all the required information </param>
        /// <returns></returns>
        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT")]
        public virtual async Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            _serviceJasperReporting = (IServiceJasperReporting)_serviceProvider.GetService(typeof(IServiceJasperReporting));
            if (_service == null)
            {
                _service = (IServiceDocument)_serviceProvider.GetService(typeof(IServiceDocument));
            }
            _service.UpdateReportSettings(data);
            responseData.objectData = await _serviceJasperReporting.ExecuteJasperReport(data, userMail);

            return responseData;
        }
        /// <summary>
        /// return informations of Stark
        /// </summary>
        /// <returns></returns>
        [HttpGet("getStarkInformations")]
        public StarkInformations GetStarkInformations()
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            return new StarkInformations()
            {
                StarkWebSiteUrl = _service.GetStarkWebSiteUrl(),
                StarkLogo = _service.GetStarkLogo()
            };
        }

        /// <summary>
        /// get unicity per month
        /// </summary>
        /// <param name="billingSessionViewModel"></param>
        /// <returns></returns>
        [HttpPost("getUnicityPerMonth"), Authorize("LIST")]
        public bool GetUnicityPerMonth([FromBody] dynamic data)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            return data != null && _service.CheckUnicityPerMonth(data);
        }

        /// <summary>
        /// Check if value precision is lower or equal to current company precision
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        [HttpPost("getCompanyCurrencyPrecision"), Authorize("LIST")]
        public virtual int GetCompanyCurrencyPrecision([FromBody] string value)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            return _service.CheckWithCurrentCompanyCurrencyPrecision(value);
        }


        /// <summary>
        /// Check if value precision is lower or equal to current company precision
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        [HttpPost("getPicture"), Authorize("UPDATE")]
        public virtual byte[] getPicture([FromBody] string path)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            IList<FileInfoViewModel> picture = _service.GetFilesContent(path);
            if (picture != null && picture.Any())
            {
                return picture.First().Data;
            }
            return null;
        }

        /// <summary>
        /// get array of pictures from array of url
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        [HttpPost("getPictures"), Authorize("UPDATE,LIST_ITEM_STOCK")]
        public virtual ResponseData getPictures([FromBody] List<string> paths)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            IList<FileInfoViewModel> pictures = _service.GetFilesContents(paths);
            if (pictures != null && pictures.Any())
            {
                return new ResponseData()
                {
                    objectData = pictures
                };
            }
            return null;
        }

        /// <summary>
        /// Get data with predicate and specific filter
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getDataWithSpecificFilter")]
        public virtual ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetDataWithSpecificFilter(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total,
                    sum = dataSourceResult.sum
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpGet("getModulesSettings")]
        public ModulesSettings GetModulesSettings()
        {
            string envName;
            ModulesSettings modulesSettings;
            using (StreamReader r = new StreamReader($"./Env/env.json"))
            {
                string json = r.ReadToEnd();
                dynamic dataEnv = JsonConvert.DeserializeObject<dynamic>(json);
                envName = dataEnv.EnviromentName.Value;
            };

            using (StreamReader r = new StreamReader(Path.Combine("Env", "env." + envName + ".json")))
            {
                string jsonEnv = r.ReadToEnd();
                dynamic dynamicJsonEnv = JsonConvert.DeserializeObject(jsonEnv);
                Newtonsoft.Json.Linq.JObject appSettingsString = dynamicJsonEnv["AppSettings"];
                AppSettings appSettings = JsonConvert.DeserializeObject<AppSettings>(appSettingsString.ToString());
                modulesSettings = appSettings.ModulesSettings;
            }

            return modulesSettings;
        }

        public dynamic decryptToken()
        {
            Request.Headers.TryGetValue("Authorization", out StringValues userToken);
            var jwt = userToken.ToString().Replace("Bearer ", string.Empty);
            JwtSecurityToken token = new JwtSecurityToken(jwt);
            return token.Payload;

        }

        [HttpPost("generateDataBase")]
        public ResponseData GenerateDataBase([FromBody] DBConfigViewModel informationsUser)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _service.GenerateDataBase(informationsUser, HttpContext.Request);
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }


    }
}
