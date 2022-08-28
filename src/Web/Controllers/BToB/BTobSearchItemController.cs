using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Inventory.Classes.TecDocFactory;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.BToB
{
    [Route("api/B2BSearchItem")]
    [AllowAnonymous]
    public class BTobSearchItemController : BaseController
    {
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceItem _serviceItem;
        private readonly IServiceTecDoc _serviceTecDoc;
        private readonly IServiceSearchItem _serviceSearchItem;

        public BTobSearchItemController(IServiceProvider serviceProvider,
           IServiceDocument serviceBToBDocument,
            ILogger<BTobSearchItemController> logger, IServiceItem serviceItem, IOptions<OtherDataBaseSettings> appSettings, IServiceSearchItem serviceSearchItem) : base(serviceProvider, logger)
        {
            TecDocDBFactory tecDocDBFactory = new TecDocDBFactory();
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceDocument = serviceBToBDocument;
            _serviceItem = serviceItem;
            _serviceTecDoc = tecDocDBFactory.CreateTecDocConnection(serviceItem, appSettings);
            _serviceSearchItem = serviceSearchItem;
        }

        [HttpPost("getItemsListByWarehouseForB2B")]
        public ResponseData GetItemsListByWarehouseForB2B([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceDocument.GetsItemsAfterFilter(predicate);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpPost("getItemTecDocByRefForB2B"), Authorize(Roles = "LIST")]
        public List<TecDocArticleViewModel> GetArticlesByRefForB2B([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            return _serviceTecDoc.GetArticlesByRef(teckDockWithFilter);
        }
        [HttpGet("getReplacementItems/{id}"), Authorize(Roles = "LIST")]
        public ResponseData GetReplacementItems(int id)
        {
            List<ReducedListItemViewModel> itemViewModels = _serviceItem.GetReplacementItems(id);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                listObject = new ListObject
                {
                    listData = itemViewModels,
                    total = itemViewModels.Count
                }
            };


            return result;
        }

        [HttpGet("getKit/{id}"), Authorize(Roles = "LIST")]
        public ResponseData GetKit(int id)
        {
            List<ItemExportPdfViewModel> itemViewModels = _serviceItem.GetKitForB2b(id);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                listObject = new ListObject
                {
                    listData = itemViewModels,
                    total = itemViewModels.Count
                }
            };

            return result;
        }
        [HttpPost("WarehouseFilterForB2B"), Authorize(Roles = "LIST")]
        public virtual ResponseData WarehouseFilter([FromBody] ItemFilterPeerWarehouseViewModel model)
        {
            ResponseData result = new ResponseData();
            model.isB2B = true;
            var dataSourceResult = _serviceItem.WarehouseFilterForB2B(model);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpGet("getMFAs"), Authorize(Roles = "LIST")]
        public object GetManufacturers()
        {
            return _serviceTecDoc.GetManufacturers("");
        }


        [HttpPost("getItemTecDocByRef"), Authorize(Roles = "LIST")]
        public List<TecDocArticleViewModel> GetArticlesByRef([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            return _serviceTecDoc.GetArticlesByRef(teckDockWithFilter);
        }

        [HttpPost("getItemTecDocById"), Authorize(Roles = "LIST")]
        public List<TecDocArticleViewModel> GetArticlesById([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            return _serviceTecDoc.GetArticlesById(teckDockWithFilter);
        }

        [HttpGet("getPassengerCars/{idMFA}/{idModel}"), Authorize(Roles = "LIST")]
        public List<TecDocPassengerCar> GetPassengerCars(int idMFA,int idModel)
        {
            return _serviceTecDoc.GetPassengerCars(idMFA, idModel,"");
        }

        [HttpPost("getItemTecDocByOem"), Authorize(Roles = "LIST")]
        public List<TecDocArticleViewModel> GetArticlesByOem([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            return _serviceTecDoc.GetTecDocByOem(teckDockWithFilter);
        }

        [HttpGet("getProductTree/{id}"), Authorize(Roles = "LIST")]
        public List<TecDocProductTreeViewModel> GetProductTree(int id)
        {
            return _serviceTecDoc.GetProductTree(id,"");
        }
        [HttpGet("getProduct/{idPC}/{idNode}"), Authorize(Roles = "LIST")]
        public List<TecDocProduct> GetProduct(int idPC, int idNode)
        {
            return _serviceTecDoc.GetProduct(idPC, idNode,"");
        }

        [AllowAnonymous]
        [HttpPost("getTeckDockArticles")]
        public List<TecDocArticleViewModel> GetArticles([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            return _serviceTecDoc.GetArticles(teckDockWithFilter);
        }
        [HttpGet("getModelSeriesByMFA/{id}"), Authorize(Roles = "LIST")]
        public List<TecDocModelSeriesViewModel> GetModelSeriesByMFA(int id)
        {
            return _serviceTecDoc.GetModelSeriesByMFA(id,"");
        }


        /// <summary>
        /// Get list of PurchaseOrders that all its line has never been imported and list of balances 
        /// </summary>
        /// <param name="reduisDocument"></param>
        /// <returns></returns>
        [HttpPost("getItemHistoryMovement")]
        public virtual ResponseData GetItemHistoryMovement([FromBody]ItemHistoryViewModel itemHistoryViewModel)
        {
            bool hasPurchaseDeliveryRole = true;
            bool hasSalesDeliveryRole = true;
            if (hasPurchaseDeliveryRole || hasSalesDeliveryRole)
            {
                ItemHistoryViewModel resultBody = _serviceDocument.GetMovementHistoryRelatedToItemB2B(itemHistoryViewModel);
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    objectData = resultBody,
                    customStatusCode = CustomStatusCode.GetByIdSuccessfull
                };
                return result;
            }
            else
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        /// <summary>
        /// Get list of PurchaseOrders that all its line has never been imported and list of balances 
        /// </summary>
        /// <param name="reduisDocument"></param>
        /// <returns></returns>
        [HttpPost("addSearch")]
        public virtual ResponseData AddSearch([FromBody] SearchItemObjectToSaveViewModel searchItemSupplierViewModel)
        {
            GetUserMail();
            _serviceSearchItem.AddSearch(searchItemSupplierViewModel, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;

        }
    }
}
