using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Serilog.Events;
using Services.Specific.Ecommerce.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Ecommerce;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Ecommerce.Classes
{
    [Route("api/ecommerceSalesDelivery/")]
    public class EcommerceSalesDeliveryController : BaseController
    {
        private readonly IServiceEcommerce _serviceEcommerce;
        public EcommerceSalesDeliveryController(IServiceProvider serviceProvider,
            IServiceEcommerce serviceEcommerce, ILogger<BaseController> logger)
            : base(serviceProvider, logger)
        {
            _serviceEcommerce = serviceEcommerce;
        }
        /// <summary>
        /// get Ecommerce Customer List
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getFailedSalesDeliveryList")]
        public ResponseData GetFailedSalesDeliveryList([FromBody] PredicateFormatViewModel model)
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
                List<OrderMagentoViewModel> dataSourceResult = (List<OrderMagentoViewModel>)((dynamic)_serviceEcommerce.getFailedSalesDeliveryDetailsAsync()).Result;
                ResponseData result = new ResponseData
                {
                    flag = 2,
                    customStatusCode = CustomStatusCode.GetSuccessfull

                };
                long total = dataSourceResult is null ? 0 : dataSourceResult.Count;
                result.listObject = new ListObject
                {
                    listData = dataSourceResult,
                    total = total
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
                       Constants.END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB);
            }
        }


    }
}
