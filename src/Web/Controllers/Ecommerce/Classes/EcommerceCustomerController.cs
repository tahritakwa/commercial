using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Serilog.Events;
using Services.Specific.Ecommerce.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Ecommerce;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Ecommerce.Classes
{
    [Route("api/ecommerceCustomers/")]
    public class EcommerceCustomerController : BaseController
    {
        private readonly IServiceEcommerce _serviceEcommerce;
        public EcommerceCustomerController(IServiceProvider serviceProvider,
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
        [HttpPost("getEcommerceCustomerList")]
        public ResponseData GetEcommerceCustomerList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-TiersEcomm", Request.HttpContext);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            try
            {
                DataSourceResult<ClientViewModel> dataSourceResult = (DataSourceResult<ClientViewModel>)
                    ((dynamic)_serviceEcommerce.GetEcommerceCustomerListAsync(model)).Result;
                ResponseData result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = dataSourceResult.data,
                        total = dataSourceResult.total
                    },
                    flag = 2,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch (CustomException)
            {
                throw;
            }
            catch(AggregateException ae)
            {
                throw ae.InnerExceptions[0];
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
        }
        /// <summary>
        /// change Premuim Ecommerce Customer
        /// </summary>
        /// <param name="id"></param>
        /// <param name="isPremium"></param>
        /// <returns></returns>
        [HttpGet("changePremuimEcommerceCustomer/{id}/{isPremium}")]
        public ResponseData ChangePremuimEcommerceCustomer(int id, bool isPremium)
        {
            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("UPDATE-TiersEcomm", Request.HttpContext);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            ResponseData result = new ResponseData();
            try
            {
                if (((bool)((dynamic)_serviceEcommerce.ChangePremuimEcommerceCustomerAsync(id, isPremium)).Result))
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.SuccessValidation,
                        flag = 1
                    };
                }
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

        }

        
    }
}
