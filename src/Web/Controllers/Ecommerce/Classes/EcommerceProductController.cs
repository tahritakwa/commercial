using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Serilog.Events;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Ecommerce.Classes
{
    [Route("api/ecommerceProduct/")]
    public class EcommerceProductController : BaseController
    {
        private readonly DbSettings _defaultDbSettings;
        private readonly IServiceEcommerce _serviceEcommerce;
        private readonly IServiceJobTable _serviceJobTable;
        protected readonly AppSettings _appSettings;
        protected readonly IServiceCompany _serviceCompany;
        public EcommerceProductController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, 
            ILogger<BaseController> logger, IServiceEcommerce serviceTriggerItem, IServiceJobTable serviceJobTable, IServiceCompany serviceCompany)
            : base(serviceProvider, logger, appSettings)
        {
            _serviceProvider = serviceProvider;
            _serviceEcommerce = serviceTriggerItem;
            _serviceJobTable = serviceJobTable;
            _serviceCompany = serviceCompany;
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings; 
            }

        }


        /// <summary>
        /// synchronize All Products Details
        /// </summary>
        /// <param name="stringData"></param>
        /// <returns></returns>
        [HttpPost("synchronizeAllProductsDetails")]
        public ResponseData SynchronizeAllProductsDetails([FromBody] string stringData)
        {
            
            try
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS);

                bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("UPDATE-ItemEcomm", Request.HttpContext);
                if (!hasRole)
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Warning,
                        Constants.ACCESS_DENIED);
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                List<ItemViewModel> itemViewModels = new List<ItemViewModel>();
                string ecommerceResult = ((dynamic)_serviceEcommerce.SynchronizeAllProductsDetailsAsync(
                    ManageDBConnections.BuildConnectionString(_defaultDbSettings),stringData, itemViewModels)).Result;
                _serviceEcommerce.UpdateAllProductsDetails(ManageDBConnections.BuildConnectionString(_defaultDbSettings), ecommerceResult, itemViewModels);

                ResponseData result = new ResponseData
                {
                    flag = 2,
                    customStatusCode = CustomStatusCode.UpdateSuccessfull
                };
                return result;

            }
            catch (CustomException)
            {
                throw;
            }
            catch (AggregateException ae)
            {
                throw ae.InnerExceptions[0];
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
            finally
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS);
            }
        }
        
        /// <summary>
        /// synchoniser Products
        /// </summary>
        /// <param name="stringData"></param>
        /// <returns></returns>
        [HttpPost("synchonizeIsEcommerceOfProducts")]
        public ResponseData SynchonizeIsEcommerceOfProducts([FromBody] string stringData)
        {            
            try
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.BEGIN_SYNCHRONIZE_IS_ECOMMERCE);
                bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("UPDATE-ItemEcomm", Request.HttpContext);
                if (!hasRole)
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Warning,
                        Constants.ACCESS_DENIED);
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }

                List<ItemViewModel> addItemViewModels = new List<ItemViewModel>();
                List<ItemViewModel> editItemViewModels = new List<ItemViewModel>();
                List<ItemViewModel> editOldItemViewModels = new List<ItemViewModel>();

                ProductsIntListViewModel productsIntListIsEcommerce = new ProductsIntListViewModel();
                ProductsIntListViewModel productsIntListNotIsEcommerce = new ProductsIntListViewModel();
                productsIntListIsEcommerce.ProductsToEdit = new List<int>();
                productsIntListNotIsEcommerce.ProductsToEdit = new List<int>();

                productsIntListIsEcommerce.IsEcommerce = true;
                productsIntListNotIsEcommerce.IsEcommerce = false;

                string ecommerceResult = ((dynamic)_serviceEcommerce.SynchonizeIsEcommerceOfProductsAsync(ManageDBConnections.BuildConnectionString(_defaultDbSettings), stringData,
                    addItemViewModels, editItemViewModels, editOldItemViewModels, productsIntListIsEcommerce, productsIntListNotIsEcommerce)).Result;

                _serviceEcommerce.UpdateIsEcommerceOfProducts(ManageDBConnections.BuildConnectionString(_defaultDbSettings), ecommerceResult, addItemViewModels,
                    editItemViewModels, editOldItemViewModels, productsIntListIsEcommerce, productsIntListNotIsEcommerce);

                ResponseData result = new ResponseData
                {
                    flag = 2,
                    customStatusCode = CustomStatusCode.UpdateSuccessfull
                };
                return result;

            }
            catch (CustomException)
            {
                throw;
            }
            catch (AggregateException ae)
            {
                throw ae.InnerExceptions[0];
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
            finally
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.END_SYNCHRONIZE_IS_ECOMMERCE);
            }
        }


        [HttpPost("synchronizeAllProductsDetailsNow")]
        public ResponseData SynchronizeAllProductsDetailsNow()
        {

            try
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB);
                bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("UPDATE-ItemEcomm", Request.HttpContext);
                if (!hasRole)
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Warning,
                        Constants.ACCESS_DENIED);
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                string generatedConnectionString = ManageDBConnections.BuildConnectionString(_defaultDbSettings);

                bool ecommerceResult = _serviceJobTable.SynchronizeAllProdcutsWithDetailsToEcommerceAsync(generatedConnectionString).Result;

                ResponseData result;

                if (ecommerceResult)
                {
                    result = new ResponseData
                    {
                        flag = 2,
                        customStatusCode = CustomStatusCode.UpdateSuccessfull
                    };
                }
                else
                {
                    result = new ResponseData
                    {
                        flag = 2,
                        customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification
                    };
                }
                return result;

            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
            finally
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB);
            }
        }
        /// <summary>
        /// synchronize With Ecommerce
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("synchronizeWithEcommerce")]
        public ResponseData synchronizeWithEcommerce([FromBody] List<int> listidItem)
        {
            ResponseData result = new ResponseData();


            {
                _serviceEcommerce.SynchronizeWithEcommerce(listidItem);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;

            }
            return result;
        }
        /// <summary>
        /// Magento Response Data
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("MagentoResponseData")]
        public ResponseData MagentoResponseData([FromBody] dynamic response)
        {
            try
            {
                ResponseData result = new ResponseData();
                string stringData = response.ToString();
                ResponseSynchronizedProductViewModel responseSynchronizedProduct = JsonConvert.DeserializeObject<ResponseSynchronizedProductViewModel>(stringData);
                GenericLogger.LogMessage(Constants.ECOMMERCE_RESPONSE_FROM_MAGENTO, LogEventLevel.Information,
                           Constants.RECEIVING_ECOMMERCE_RESPONSE);
                GenericLogger.GenericLog(Constants.ECOMMERCE_SYNCHRONIZE_FILE_NAME, LogEventLevel.Information, new Type[]
                { typeof(Exception), typeof(string) }, new object[] { null, Constants.SENDING_PRODUCTS_TO_SYNCHRONIZE + response }, @"Logs\Ecommerce\ResponseFromMagento");


                {
                    _serviceEcommerce.MagentoResponseData(responseSynchronizedProduct);
                    result.flag = 1;
                    result.customStatusCode = CustomStatusCode.GetSuccessfull;

                }
                return result;
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_RESPONSE_FROM_MAGENTO, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
            finally
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_RESPONSE_FROM_MAGENTO, LogEventLevel.Information,
                        Constants.END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS);
                
            }
        }
        /// <summary>
        /// EcommerceGetDeliveryForms
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("EcommerceGetDeliveryForms")]
        public async Task EcommerceGetDeliveryForms()
        {
            List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
            var generatedConnectionString = ManageDBConnections.BuildConnectionString(_dbConnectionSettings[0], _defaultDbSettings);
            ResponseData result = new ResponseData();
            {
                await _serviceEcommerce.EcommerceGetDeliveryForms(generatedConnectionString);              
            }
        }
        /// <summary>
        /// EcommerceGetDeliveryForms
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("AddTotalShipmentFromMagento")]
        public async Task<bool> AddTotalShipmentFromMagento([FromBody] DocumentViewModel document)
        {
                await _serviceEcommerce.AddTotalShipment( document);
            return true;
        }
        /// <summary>
        /// Synchronize Invoice with Magento
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("AddInvoice")]
        public async Task AddInvoice([FromBody] DocumentViewModel document)
        {
            await _serviceEcommerce.AddInvoice(document);
        }
        /// <summary>
        /// Synchronize Category with magento 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("AddCategoryFromMagento")]
        public async Task<bool> AddCategoryFromMagento([FromBody] FamilyViewModel categoryModel)
        {
            
            
            await _serviceEcommerce.AddCategoryFromMagento(categoryModel);
              
            return true;
        }
        /// <summary>
        /// Update Category with Magento 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("UpdateCategoryFromMagento")]
        public async Task UpdateCategoryFromMagento([FromBody] FamilyViewModel categoryModel)
        {
            await _serviceEcommerce.UpdateCategoryFromMagento(categoryModel);
        }
        /// <summary>
        /// Synchronize Category with magento 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("AddSubCategoryFromMagento")]
        public async Task<bool> AddSubCategoryFromMagento([FromBody] SubFamilyViewModel categorySubModel)
        {


            await _serviceEcommerce.AddSubCategoryFromMagento(categorySubModel);

            return true;
        }
        /// <summary>
        /// Update SubCategory with Magento 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("UpdateSubCategoryFromMagento")]
        public async Task UpdateSubCategoryFromMagento([FromBody] SubFamilyViewModel categorySubModel)
        {
            await _serviceEcommerce.UpdateSubCategoryFromMagento(categorySubModel);
        }

    }
}
