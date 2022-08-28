using Infrastruture.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Services.Specific.Inventory.Classes.TecDocFactory;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/item")]
    public class ItemController : BaseController, IItemController
    {

        private readonly IServiceItem _serviceItem;
        private readonly IServiceTecDoc _serviceTecDoc;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ItemController(IServiceProvider serviceProvider, IServiceItem serviceItem, ILogger<ItemController> logger, IOptions<OtherDataBaseSettings> appSettings) : base(serviceProvider, logger)
        {
            TecDocDBFactory tecDocDBFactory = new TecDocDBFactory();
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceItem = serviceItem;
            _serviceTecDoc = tecDocDBFactory.CreateTecDocConnection(serviceItem, appSettings);
        }



        [HttpGet("getById/{id}"), Authorize("ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,LIST_PRICES,DETAILS_ITEM,FABRICATION_PERMISSION")]
        public override ResponseData GetById(int id)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                PredicateFormatViewModel model = new PredicateFormatViewModel();
                List<FilterViewModel> filtersItem = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = id, IsDynamicValue = true }
                };
                model.Filter = filtersItem;
                List<RelationViewModel> relations = new List<RelationViewModel>
                {
                    new RelationViewModel { Prop = "TaxeItem" },
                    new RelationViewModel { Prop ="IdUnitSalesNavigation"},
                    new RelationViewModel { Prop ="IdUnitStockNavigation"},
                    new RelationViewModel { Prop ="ItemWarehouse"}
                };
                model.Relation = relations;
                ResponseData result = base.GetPredicate(model);
                PredicateFormatViewModel predicate = new PredicateFormatViewModel();
                List<FilterViewModel> filters = new List<FilterViewModel>()
                    {
                        new FilterViewModel { Prop = "IdItem", Operation = Operation.Equals, Value = id, IsDynamicValue = true  }
                    };
                predicate.Filter = filters;
                if (result.listObject != null && result.listObject.listData != null
                    && ((dynamic)result.listObject.listData).GetType().GetProperty("Count").GetValue(result.listObject.listData) > 0)
                {
                    result.objectData = ((dynamic)result.listObject.listData)[0];

                }
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
                return result;
            }
        }
        [HttpPost("getItemsDataSourceModel"), Authorize("LIST_ITEM")]
        public ResponseData GetItemsDataSourceModel([FromBody] PredicateFormatViewModel model)
        {
            var dataSourceResult = _serviceItem.GetItemsDataSourceModel(model);
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

        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate containing also grid filters</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// It return object containing a collections of items in listObject.listData attribute and the number of items in the listObject.listData attribut</returns>
        [HttpPost("getItemForList"), Authorize("LIST_ITEM")]
        public virtual ResponseData GetItemsInventoryList([FromBody] PredicateFormatViewModel model)
        {
            var dataSourceResult = _serviceItem.GetItemsInventoryList(model);
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


        [HttpPost("getOnOrderQuantityDetails"), Authorize("DETAILS_ITEM,ADD_PROVISIONING,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData GetOnOrderQuantityDetails([FromBody] int idItem)
        {
            var dataSourceResult = _serviceItem.GetOnOrderQuantityDetails(idItem);
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

        /// <summary>
        /// Get Itrem warhouse related to thi Item
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getItemWarhouse"), Authorize("LIST_ITEM,LIST_QUICK_SALES,LIST_WAREHOUSE,LIST_TRANSFER_MOVEMENT,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,UPDATE_PURCHASE_REQUEST,ADD_PURCHASE_REQUEST," +
            "ADD_EXIT_VOUCHERS,UPDATE_EXIT_VOUCHERS,ADD_ADMISSION_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST," +
            "UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,UPDATE_VALID_ADMISSION_VOUCHERS," +
            "UPDATE_VALID_EXIT_VOUCHERS,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,ADD_PROVISIONING,UPDATE_PROVISIONING,ADD_PRICES,UPDATE_PRICES")]
        public virtual ItemViewModel GetItemsInventoryList([FromBody] ItemViewModel model)
        {
            return _serviceItem.GetItemsInventoryList(model);
        }

        [HttpPost("getReducedItemData"), Authorize("LIST_ITEM,UPDATE_ITEM")]
        public ReducedListItemViewModel GetReducedItemData([FromBody] int Id)
        {
            return _serviceItem.GetReducedItemData(Id);
        }

        /// <summary>
        /// Get Itrem warhouse related to thi Item
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getItemWarhouseOfSelectedItem"), Authorize("SHOW_WAREHOUSE,LIST_QUICK_SALES,DETAILS_ITEM,ADD_ITEM,UPDATE_ITEM")]
        public List<ItemWarehouseListItemViewModel> GetItemWarhouseOfSelectedItem([FromBody] int idItem)
        {
            return _serviceItem.GetItemWarhouseOfSelectedItem(idItem);
        }

        /// <summary>
        /// Specific api for check if warehouse affectation is unique
        /// </summary>
        /// <param name="property"></param>
        /// <param name="value"></param>
        /// <param name="valueBeforUpdate"></param>
        /// <returns></returns>
        [HttpPost("checkWarehouseUnicity"), Authorize("ADD_ITEM,UPDATE_ITEM,DETAILS_ITEM")]
        public List<int> CheckWarehouseUnicity([FromBody] ObjectToSaveViewModel objectSaved)
        {
            IList<ItemWarehouseViewModel> itemWarehouse =
                JsonConvert.DeserializeObject<IList<ItemWarehouseViewModel>>(objectSaved.model.itemWarehouse.ToString());

            if (itemWarehouse == null)
            {
                throw new ArgumentNullException(nameof(itemWarehouse));
            }
            return _serviceItem.CheckWarehouseUnicity(itemWarehouse);
        }

        [HttpGet("getItems"), AllowAnonymous]
        public List<ItemViewModel> GetItems()
        {

            List<ItemViewModel> itemList = new List<ItemViewModel>();
            for (int i = 0; i < 10; i++)
            {
                var item = new ItemViewModel
                {
                    Code = i.ToString(),
                    Description = "Test" + i
                };
                itemList.Add(item);


            }
            return itemList;
        }

        /// <summary>
        /// Get list of model series for the manufacturer of passenger
        /// </summary>
        /// <param name="id"> Id defines the Manufacturers for the model series
        /// </param>
        /// <returns></returns>
        [HttpPost("getModelSeriesByMFA/{id}"), Authorize("LIST_ITEM")]
        public ResponseData GetModelSeriesByMFA(int id, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetModelSeriesByMFA(id, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        /// <summary>
        /// Get list of manufacturers for the passenger cars
        /// </summary>
        /// <returns></returns>
        [HttpPost("getMFAs"), Authorize("LIST_ITEM,LIST_QUICK_SALES, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER," +
            "ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetManufacturers([FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetManufacturers(userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        /// <summary>
        /// Get list of passenger car models for the model series
        /// </summary>
        /// <param name="id"> id is an int that defines the Model serie of the passanger car
        /// </param>
        /// <returns></returns>
        [HttpPost("getPassengerCars/{idMFA}/{idModel}"), Authorize("LIST_ITEM")]
        public ResponseData GetPassengerCars(int idMFA, int idModel, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetPassengerCars(idMFA, idModel, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpGet("testtecdoc/{TeckDockWithFilter}"), AllowAnonymous]
        public ResponseData Test(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetArticles(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getTeckDockArticles"), Authorize("LIST_ITEM")]
        public ResponseData GetArticles([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetArticles(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getItemTecDocByRef"), Authorize("LIST_ITEM")]
        public ResponseData GetArticlesByRef([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetArticlesByRef(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch (Exception)
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getItemTecDocByOem"), Authorize("LIST_ITEM")]
        public ResponseData GetArticlesByOem([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTecDocByOem(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getItemTecDocById"), Authorize("LIST_ITEM")]
        public ResponseData GetArticlesById([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetArticlesById(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getEquivalentTecDoc"), Authorize("LIST_ITEM")]
        public ResponseData GetEquivalentTecDoc([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetEquivalentTecDoc(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }


        [HttpPost("getProduct/{idPC}/{idNode}"), Authorize("LIST_ITEM")]
        public ResponseData GetProduct(int idPC, int idNode, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetProduct(idPC, idNode, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getProductTree/{id}"), Authorize("LIST_ITEM,LIST_QUICK_SALES")]
        public ResponseData GetProductTree(int id, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetProductTree(id, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        /// <summary>get
        /// Get Itrem warhouse related to thi Item
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getItemEquivalence"), Authorize("LIST_ITEM,LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,ADD_CLAIM_PURCHASE," +
            "UPDATE_CLAIM_PURCHASE,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_QUICK_SALES,LIST_PRICES,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE," +
            "ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE," +
            "UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS,ADD_FINANCIAL_ASSET_SALES," +
            "UPDATE_FINANCIAL_ASSET_SALES,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData GetItemEquivalence([FromBody] ItemToGetEquivalentList model)
        {
            IList<ItemViewModel> itemViewModels = _serviceItem.GetItemEquivalence(model);
            ResponseData result = new ResponseData
            {
                objectData = itemViewModels,
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get reduced Item equivalence to the Item
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getReducedItemEquivalence"), Authorize("DETAILS_ITEM,UPDATE_ITEM,ADD_ITEM,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,SHOW_ORDER_QUOTATION_PURCHASE")]
        public virtual ResponseData GetReducedItemEquivalence([FromBody] ItemViewModel model)
        {
            List<ReducedListItemViewModel> itemViewModels = _serviceItem.GetReducedItemEquivalence(model);
            ResponseData result = new ResponseData
            {
                objectData = itemViewModels,
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
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
        [HttpPost("getItemsListByWarehouse"), Authorize("LIST_ITEM")]
        public virtual ResponseData GetItemsListByWarehouse([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceItem.GetItemsListByWarehouse(model);

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
        /// Get Itrem warhouse related to thi Item
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getItemWarhouseBySelectedWarehouse"), Authorize("LIST_ITEM")]
        public virtual ItemViewModel GetItemWarhouseBySelectedWarehouse([FromBody] dynamic model)
        {
            return _serviceItem.GetItemWarhouseBySelectedWarehouse(JsonConvert.DeserializeObject<ItemViewModel>(model.Item.ToString()), (int)model.IdWarehouse.Value);
        }

        /// <summary>
        /// Get Availbel quantity 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getAvailableQuantity"), Authorize("LIST_ITEM,FABRICATION_PERMISSION")]
        public virtual List<AvailableQuantity> GetAvailbleQuantity([FromBody] List<int> listItems)
        {
            return _serviceItem.GetAvailbleQuantity(listItems);
        }

        /// <summary>
        /// Get Availbel quantity 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getAmountPerItem"), Authorize("LIST_ITEM,FABRICATION_PERMISSION")]
        public virtual List<AmountPerItemDetails> GetAmountPerItem([FromBody] List<ItemQuantity> listItems)
        {
            return _serviceItem.GetAmountPerItem(listItems);
        }
        [HttpPost("warehouseFilter"), Authorize("LIST_ITEM,LIST_WAREHOUSE,LIST_SHELFS_AND_STORAGES,LIST_TRANSFER_MOVEMENT,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES," +
            "LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_QUICK_SALES,LIST_PRICES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST," +
            "ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE," +
            "UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS," +
            "ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData WarehouseFilter([FromBody] ItemFilterPeerWarehouseViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceItem.FilterItemsByWarehouse(model);

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

        [HttpPost("getItemsAfterFilter"), Authorize("LIST_ITEM,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_CATEGORY,EDIT_CATEGORY,ADD_OPPORTUNITY,EDIT_OPPORTUNITY,VIEW_OPPORTUNITY,ADD_TIERS")]
        public ResponseData GetItemsAfterFilter([FromBody] List<int> listId)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceItem.GetItemsAfterFilter(listId);

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


        [HttpPost("getItemDropDownListForDataGrid"), Authorize("LIST_PURCHASE_REQUEST,HISTORY_ITEM,LIST_PRICES,ADD_CATEGORY,DETAILS_ITEM,UPDATE_ITEM,ADD_ITEM,ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,SHOW_TRANSFER_MOVEMENT," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "SHOW_ASSET_PURCHASE,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES," +
            "UPDATE_ORDER_SALES,ADD_ORDER_SALES,UPDATE_VALID_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,UPDATE_CLAIM_PURCHASE,ADD_DELIVERY_SALES," +
            "UPDATE_DELIVERY_SALES,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES,UPDATE_EXIT_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,ADD_ADMISSION_VOUCHERS," +
            "ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,FABRICATION_PERMISSION,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST," +
            "SHOW_PURCHASE_REQUEST,UPDATE_INADD_PROVISIONINGTERVENTION,UPDATE_OPERATIONKIT,FABRICATION_PERMISSION,ADD_PROVISIONING,UPDATE_PROVISIONING,LIST_PURCHASE_REQUEST,ADD_CLAIM_PURCHASE, COUNTER_SALES")]
        public virtual ListObject GetItemDropDownListForGrid([FromBody] FiltersItemDropdown model)
        {
            var dataSourceResult = _serviceItem.GetItemDropDownListForDataGrid(model);

            ListObject listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };

            return listObject;
        }


        [HttpPost("getDataSourcePredicateValueMapperForGrid"), Authorize("LIST_ITEM,LIST_PRICES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST," +
            "UPDATE_PRICEREQUEST,LIST_WAREHOUSE,UPDATE_SHELFS_AND_STORAGES")]
        public ResponseData FindIndiceFromDataSourceForGrid([FromBody] ValueMapperResponseViewModel valueMapperVM)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceItem.FindIndiceFromDataSourceForGrid(valueMapperVM.filtersItemDropdown, valueMapperVM.ValueMapper)
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };

            return result;
        }


        //[HttpGet("getReplacementItems/{id},LIST")]
        //public ResponseData GetReplacementItems(int id)
        [HttpPost("getReplacementItems"), Authorize("LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES," +
            "LIST_QUICK_SALES,LIST_PRICES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE," +
            "ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES," +
            "ADD_PROVISIONING,UPDATE_PROVISIONING,SHOW_WAREHOUSE,DETAILS_ITEM,UPDATE_ITEM")]
        public ResponseData GetReplacementItems([FromBody] ItemToGetEquivalentList model)
        {
            List<ReducedListItemViewModel> itemViewModels = _serviceItem.GetReplacementItems(model);
            ResponseData result = new ResponseData

            {
                objectData = itemViewModels,
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("removeEquivalentItem/{id}"), Authorize("LIST_ITEM")]
        public ResponseData RemoveEquivalentItem(int id)
        {
            _serviceItem.RemoveEquivalentItem(id);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new
                {
                    EntityName = "EQUIVALENT_PRODUCT"
                }
            };
            return result;
        }
        [HttpPost("removeReplacementItem/{id}"), Authorize("LIST_ITEM")]
        public ResponseData removeReplacementItem(int id)
        {
            _serviceItem.RemoveReplacementItem(id);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new
                {
                    EntityName = "REPLACEMENT_PRODUCTS"
                }
            };
            return result;
        }
        [HttpPost("removeKitItem/{id}/{idSelectedKit}"), Authorize("LIST_ITEM")]
        public ResponseData removeKitItem(int idSelectedKit, int id)
        {
            _serviceItem.RemoveKitItem(idSelectedKit, id);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new
                {
                    EntityName = "REPLACEMENT_KIT"
                }
            };
            return result;
        }
        [HttpPost("exportPdf"), Authorize("LIST_ITEM")]
        public ResponseData ExportPdf([FromBody] ItemFilterPeerWarehouseViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceItem.ExportPdf(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpPost("getTecdocDetails"), Authorize("LIST_ITEM")]
        public ResponseData GetTecdocDetails([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = _serviceTecDoc.GetTecdocDetails(Itemtecdoc)
                    },
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getTecdocDetailsApi"), Authorize("LIST_ITEM,ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetTecdocDetailsApi([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTecdocDetailsApi(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }



        [HttpPost("getpassengerCar"), Authorize("LIST_ITEM")]
        public ResponseData GetpassengerCar([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetpassengerCarForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getTopPassengerCar"), Authorize("LIST_ITEM")]
        public ResponseData GetTopPassengerCar([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTopPassengerCarForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getTopPassengerCarApi"), Authorize("LIST_ITEM, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetTopPassengerCarApi([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTopPassengerCarApiForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getEngines"), Authorize("LIST_ITEM, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetEngines([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetEnginesForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getMedia"), Authorize("LIST_ITEM, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetMedia([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetMediaForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("getDocument"), Authorize("LIST_ITEM, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetDocument([FromBody] ItemViewModel Itemtecdoc)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetDocumentsForDetails(Itemtecdoc),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getTopBrandInfo/{SupId}"), Authorize("LIST_ITEM")]
        public ResponseData GetTopBrandInfo(int SupId, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTopBrandInfo(SupId, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getBrandInfo/{SupId}"), Authorize("LIST_ITEM")]
        public ResponseData GetBrandInfo(int SupId, [FromBody] string userMail)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetBrandInfo(SupId, userMail),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpGet("getTecDocBrands"), Authorize("LIST_ITEM,LIST_QUICK_SALES, ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT")]
        public ResponseData GetTecDocBrands()
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTecDocBrands(),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }


        [HttpPost("getTecDocItemsByBrand"), Authorize("LIST_ITEM")]
        public ResponseData GetTecDocItemsByBrand([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {

            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetTecDocItemsByBrand(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }

        }

        [HttpPost("getItemKit"), Authorize("LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE," +
            "LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_QUICK_SALES,LIST_PRICES,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE," +
            "ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES," +
            "ADD_PROVISIONING,UPDATE_PROVISIONING,SHOW_WAREHOUSE,DETAILS_ITEM,UPDATE_ITEM")]
        public ResponseData GetItemKit([FromBody] ItemToGetEquivalentList model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceItem.GetItemKit(model);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpPost("updateItemEquivalentDesignation"), Authorize("ADD_ITEM,UPDATE_ITEM")]
        public ResponseData UpdateItemEquivalentDesignation([FromBody] ReducedEquivalentItem itemToUpdate)
        {
            ResponseData result = new ResponseData();
            _serviceItem.UpdateItemEquivalentDesignation(itemToUpdate);
            return result;
        }
        [HttpPost("getItemlistDetailsById"), Authorize("LIST_ITEM,VIEW_CATEGORY")]
        public ResponseData getlistItemById([FromBody] List<int> listItemId)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceItem.GetItemDetails(listItemId),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
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


        [HttpPost("insert_item"), Authorize("ADD_ITEM")]
        public ResponseData PostItem(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                ItemViewModel instanceType = JsonConvert.DeserializeObject<ItemViewModel>(objectSaved.model.ToString());

                var obj = _serviceItem.AddModel(instanceType, objectSaved.EntityAxisValues, userMail);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }
        [HttpPut("update_item"), Authorize("UPDATE_ITEM")]
        public ResponseData PutItem(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                ItemViewModel instanceType = JsonConvert.DeserializeObject<ItemViewModel>(objectSaved.model.ToString());
                instanceType.HavePriceRole = RoleHelper.HasPermission("UPDATE-ITEMPRICE_SA");
                var obj = _serviceItem.UpdateModel(instanceType, objectSaved.EntityAxisValues, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost("affectEquivalentItem"), Authorize("UPDATE_ITEM")]
        public ResponseData AffectEquivalentItem([FromBody] EquivalentItemsViewModel equivalentItems)
        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceItem.AffectEquivalentItem(equivalentItems, userMail),
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }
        [HttpPost("getModelByCondition"), Authorize("ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,DETAILS_ITEM,SHOW_CLAIM_PURCHASE,UPDATE_ITEM")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,LIST_EXPENSE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }


        [HttpPost("getItemsFillingIsAffected/{idPrice}")]
        public virtual DataSourceResultWithSelections<ItemViewModel> GetItemsFillingIsAffected([FromBody] PredicateFormatViewModel model, int idPrice)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            var dataSourceResult = _serviceItem.GetItemsFillingIsAffected(model, idPrice);
            return dataSourceResult;
        }
        [HttpGet("getItemTier/{idItem}"), Authorize("SHOW_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST")]
        public ResponseData GetItemTier(int idItem)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceItem.GetItemTiers(idItem)
            };
            return result;
        }

        [HttpPost("getItemListForGarage")]
        public ResponseData GetItemListForGarage([FromBody] dynamic model)
        {
            List<int> idItems = JsonConvert.DeserializeObject<List<int>>(model.idItems.ToString());
            int? idWarehouse = (int?)model.idWarehouse;
            var dataSourceResult = _serviceItem.GetItemListForGarage(idItems, idWarehouse);
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

        [HttpPost("addOperationAsItem")]
        public ResponseData AddOperationAsItem([FromBody] ItemViewModel item)
        {
            var createdData = _serviceItem.AddOperationAsItem(item, userMail);
            ResponseData result = new ResponseData
            {
                objectData = createdData,
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }

        [HttpPost("updateOperationAsItem")]
        public ResponseData UpdateOperationAsItem([FromBody] ItemViewModel item)
        {
            var createdData = _serviceItem.UpdateOperationAsItem(item, userMail);
            ResponseData result = new ResponseData
            {
                objectData = createdData,
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

        [HttpPost("bulkUpdateOperationAsItem")]
        public ResponseData bulkUpdateOperationAsItem([FromBody] dynamic data)
        {
            List<ItemViewModel> listItems = JsonConvert.DeserializeObject<List<ItemViewModel>>(data.ToString());
            var createdData = _serviceItem.BulkUpdateOperationAsItem(listItems, userMail);
            ResponseData result = new ResponseData
            {
                objectData = createdData,
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

        [HttpPost("getNumberOfItemEquiKit"), Authorize("LIST_QUICK_SALES,SHOW_WAREHOUSE,DETAILS_ITEM,UPDATE_WAREHOUSE,UPDATE_ITEM")]
        public virtual ResponseData getNumberOfItemEquiKit([FromBody] ItemToGetEquivalentList model)
        {
            var count = _serviceItem.getNumberOfItemEquiKit(model);
            ResponseData result = new ResponseData
            {
                objectData = count,
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }


        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_QUICK_SALES,LIST_ITEM,SHOW_WAREHOUSE,UPDATE_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetListDataWithSpecificFilter(model);

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

        [HttpPost("getItemSheetData"), Authorize("DETAILS_ITEM,UPDATE_ITEM")]
        public ResponseData GetItemSheetData([FromBody] int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _service.GetItemSheetData(id);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpPost("getPictures"), Authorize("LIST_QUICK_SALES,LIST_ITEM,ADD_TRANSFER_MOVEMENT,SHOW_TRANSFER_MOVEMENT,SHOW_WAREHOUSE,SHOW_DELIVERY_SALES,UPDATE_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,ADD_DELIVERY_SALES," +
            "UPDATE_DELIVERY_SALES,LIST_ORDER_QUOTATION_PURCHASE,LIST_FINAL_ORDER_PURCHASE,SHOW_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "SHOW_ASSET_PURCHASE,SHOW_INVOICE_PURCHASE,DETAILS_ITEM,UPDATE_ITEM,UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE,SHOW_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_ORDER_QUOTATION_PURCHASE," +
            "UPDATE_FINAL_ORDER_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES,ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_QUOTATION_SALES," +
            "UPDATE_ORDER_SALES,UPDATE_DELIVERY_SALES,UPDATE_INVOICE_SALES,UPDATE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE," +
            "SHOW_QUOTATION_SALES,SHOW_FINANCIAL_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,SHOW_ORDER_SALES," +
            "UPDATE_VALID_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,SHOW_UPDATE_QUOTATION_PRICE_REQUEST,UPDATE_VALID_DELIVERY_SALES,ADD_ADMISSION_VOUCHERS," +
            "UPDATE_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_EXIT_VOUCHERS,ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,"+
            "ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_ITEM,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,COUNTER_SALES")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        /// <summary>
        /// B2B Response Data
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("SynchronizeBToBItems")]
        public ResponseData SynchronizeBToBItems([FromBody] dynamic response)
        {
            ResponseData result = new ResponseData();
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceItem.GetConnectionString();
            var responseData = _serviceItem.SynchronizeBToBItems(SearchDate, connectionString);

            {
                    result.objectData = responseData;
                    result.flag = 1;
                    result.customStatusCode = CustomStatusCode.GetSuccessfull;

            }
                return result;
        }
        [HttpPost("getItemDataWithSpecificFilter"), Authorize("LIST_QUICK_SALES,LIST_ITEM,SHOW_WAREHOUSE,UPDATE_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,UPDATE_CLAIM_PURCHASE,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES," +
            "ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,COUNTER_SALES")]
        public  ResponseData GetItemDataWithSpecificFilter([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                FilterSearchItemViewModel model = JsonConvert.DeserializeObject<FilterSearchItemViewModel>(objectToSave.model.ToString());
                var dataSourceResult = _service.GetItemDataWithSpecificFilter(model);

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

        [HttpPost("generateItemFromEmployee"), Authorize("GENERATE_BILLING_SESSION_INVOICES")]
        public ItemViewModel GenerateItemFromEmployee([FromBody] dynamic objectToReceive)
        {
            EmployeeViewModel employee = JsonConvert.DeserializeObject<EmployeeViewModel>(objectToReceive.Employee.ToString());
            string label = (string)objectToReceive.label;
            return _serviceItem.GenerateItemFromEmployee(employee, label);
        }
        /// <summary>
        /// getListOfIdsByCodeOrDesignation
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
        [HttpPost("getByCodeAndDesignation"), Authorize("FABRICATION_PERMISSION,LIST_ITEM,DETAILS_ITEM,ADD_ITEM,UPDATE_ITEM")]
        public List<int> getByCodeAndDesignation([FromBody] String pattern)
        {
            return _serviceItem.getByCodeAndDesignation(pattern);
        }
        /// <summary>
        /// getItemDetails
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
         [HttpPost("getItemDetails"), Authorize("FABRICATION_PERMISSION,LIST_ITEM,DETAILS_ITEM,ADD_ITEM,UPDATE_ITEM")]
        public List<ItemDetailsViewModel> GetItemDetails([FromBody] List<int> listItems)
        {
            return _serviceItem.GetItemDetailsProd(listItems);
        }
       [HttpPost("getArticlesByGlobalSearch"), Authorize("LIST_ITEM")]
        public ResponseData GetArticlesByGlobalSearch([FromBody] TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData = _serviceTecDoc.GetArticlesByGlobalSearch(teckDockWithFilter),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch (Exception)
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }

        [HttpPost("affectEquivalentItemWithoutResponse"), Authorize("UPDATE_ITEM")]
        public ResponseData AffectEquivalentItemWithoutResponse([FromBody] EquivalentItemsViewModel equivalentItems)
        {
            GetUserMail();
            _serviceItem.AffectEquivalentItemWithoutResponse(equivalentItems, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = equivalentItems,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

    }
}
