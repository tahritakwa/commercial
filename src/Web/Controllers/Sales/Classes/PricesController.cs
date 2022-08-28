using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/prices")]
    public class PricesController : BaseController
    {
        private readonly IServicePrices _servicePrices;
        public PricesController(IServiceProvider serviceProvider, IServicePrices servicePrices, ILogger<BaseController> logger) : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _servicePrices = servicePrices;
        }
        [HttpPost("getSpecificPrice"), Authorize(Roles = "LIST_PRICES")]
        public ResponseData GetSpecificPrice([FromBody] PriceGetterViewModel price)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _servicePrices.GetSpecificPrice(price),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("getCurrencyByTiers"), Authorize("LIST_PRICES")]
        public ResponseData GetCurrencyByTiers([FromBody] TiersViewModel model)
        {
            if (model != null)
            {
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    objectData = _servicePrices.GetCurrencyByTiers(model.Id),
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
            return new ResponseData();
        }

        [HttpPost("getCurrencyRateByDate"), Authorize("LIST_PRICES")]
        public ResponseData GetCurrencyRateByDate([FromBody] dynamic model)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _servicePrices.GetCurrencyRateByDate(model),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [HttpPost("insert")]
        public override ResponseData Post(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ObjectToSaveViewModel objectToSave;
            if (objectJsonToSave != null)
            {
                objectToSave = JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave);
            }
            else
            {
                objectToSave = objectSaved;
            }
            PricesViewModel instanceType = JsonConvert.DeserializeObject<PricesViewModel>(objectToSave.model.ToString());
            if (files != null && files.Any())
            {
                //Add list of files to document
                instanceType.Files = files;
            }
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = _servicePrices.AddModel(instanceType, objectToSave.EntityAxisValues, userMail),
                flag = 1
            };
            return result;
        }
        [HttpPost("insert_Price"), Authorize("ADD_PRICES")]
        public ResponseData InsertPriceWithoutFiles([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PricesViewModel pricesViewModel = JsonConvert.DeserializeObject<PricesViewModel>(objectToSave.model.ToString());
            var objectData = _servicePrices.AddModelWithObservationFiles(pricesViewModel, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = objectData,
                flag = 1
            };
            return result;

        }
        [HttpPut("update")]
        public override ResponseData Put(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            //if objectJsonToSave(object format json) not null ==> convert objectJsonToSave to ObjectToSaveViewModel
            ObjectToSaveViewModel objectToSave;
            if (objectJsonToSave != null)
            {
                objectToSave = JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave);
            }
            else
            {
                objectToSave = objectSaved;
            }
            PricesViewModel instanceType = JsonConvert.DeserializeObject<PricesViewModel>(objectToSave.model.ToString());
            if (files != null && files.Any())
            {
                //Add list of files to document
                instanceType.Files = files;
            }
            _servicePrices.UpdateModel(instanceType, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPut("update_price"), Authorize("UPDATE_PRICES,ADD_PRICES")]
        public ResponseData UpdatePriceWithoutFiles([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PricesViewModel pricesViewModel = JsonConvert.DeserializeObject<PricesViewModel>(objectToSave.model.ToString());
            var objectData = _servicePrices.UpdateModelWithObservationFiles(pricesViewModel, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = objectData,
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Get customer list affected to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("getPriceCustomers"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public DataSourceResult<TiersViewModel> GetPriceCustomers([FromBody] PriceAffectionViewModel priceAffectionViewModel)
        {
            return _servicePrices.GetPriceCustomers(priceAffectionViewModel);
        }
        /// <summary>
        /// Get item list affected to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("getPriceItems"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public DataSourceResult<ItemViewModel> GetPriceItems([FromBody] PriceAffectionViewModel priceAffectionViewModel)
        {
            return _servicePrices.GetPriceItems(priceAffectionViewModel);
        }
        /// <summary>
        /// Affect customer to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("affectCustomerToPrice"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData AffectCustomerToPrice([FromBody] TiersPricesViewModel model)
        {
            GetUserMail();
            _servicePrices.AffectCustomerToPrice(model, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "CUSTOMER" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Affect item to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("affectItemToPrice"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData AffectItemToPrice([FromBody] ItemPricesViewModel model)
        {
            GetUserMail();
            _servicePrices.AffectItemToPrice(model, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ITEM" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Unaffect customer from price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("unaffectCustomerFromPrice"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData UnaffectCustomerFromPrice([FromBody] TiersPricesViewModel model)
        {
            GetUserMail();
            _servicePrices.UnaffectCustomerFromPrice(model, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UnaffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "CUSTOMER" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Unaffect item from price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("unaffectItemFromPrice"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData UnaffectItemFromPrice([FromBody] ItemPricesViewModel model)
        {
            GetUserMail();
            _servicePrices.UnaffectItemFromPrice(model, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UnaffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ITEM" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Affect all the cusomers to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("affectAllCustomersToPrice/{idPrice}"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData AffectAllCustomersToPrice([FromBody] PredicateFormatViewModel predicateModel, int idPrice)
        {
            GetUserMail();
            _servicePrices.AffectAllCustomersToPrice(predicateModel, idPrice, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ALL_THE_CUSTOMERS" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Affect all the items to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("affectAllItemsToPrice/{idPrice}"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData AffectAllItemsToPrice([FromBody] PredicateFormatViewModel predicateModel, int idPrice)
        {
            GetUserMail();
            _servicePrices.AffectAllItemsToPrice(predicateModel, idPrice, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ALL_THE_ITEMS" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Unaffect all the cusomers from the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("unaffectAllCustomersFromPrice/{idPrice}"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData UnaffectAllCustomersFromPrice([FromBody] PredicateFormatViewModel predicateModel, int idPrice)
        {
            GetUserMail();
            _servicePrices.UnaffectAllCustomersFromPrice(predicateModel, idPrice, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UnaffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ALL_THE_CUSTOMERS" },
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Unaffect all the items from the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("unaffectAllItemsFromPrice/{idPrice}"), Authorize("ADD_PRICES,UPDATE_PRICES,SHOW_PRICES")]
        public ResponseData UnaffectAllItemsFromPrice([FromBody] PredicateFormatViewModel predicateModel,  int idPrice)
        {
            GetUserMail();
            _servicePrices.UnaffectAllItemsFromPrice(predicateModel, idPrice, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UnaffectedSuccessfully,
                objectData = new CreatedDataViewModel { EntityName = "ALL_THE_ITEMS" },
                flag = 1
            };
            return result;
        }


        /// <summary>
        /// Get prices (discounts) list
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        [HttpPost("getPricesList"), Authorize("LIST_PRICES")]
        public ResponseData GetPricesList([FromBody] List<PredicateFormatViewModel> model)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            var dataResult = _servicePrices.FindPriceDataSourceModelBy(model);
            ResponseData result = new ResponseData();
            result.listObject = new ListObject
            {
                listData = dataResult,
                total = dataResult.Count
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

    }
}
