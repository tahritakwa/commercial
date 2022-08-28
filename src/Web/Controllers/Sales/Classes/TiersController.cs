using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Persistence;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/tiers")]
    public class TiersController : BaseController
    {
        const string idTypeTiersConst = "IdTypeTiers";
        const int TypeTiersClient = 1;
        const string idConst = "Id";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceTiers _serviceTiers;
        private readonly IServiceCompany _serviceCompany;
        public TiersController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IServiceTiers serviceTiers, IServiceCompany serviceCompany)
            : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceTiers = serviceTiers;
            _serviceCompany = serviceCompany;
        }

        [HttpGet("getTiersById/{id}"), Authorize("SHOW_CUSTOMER,SHOW_SUPPLIER,UPDATE_PRICEREQUEST,OWN_ORGANISATION," +
            "EDIT_ORGANISATION,VIEW_OPPORTUNITY,ADD_SUPPLIER,UPDATE_SUPPLIER,ADD_RECEIPT_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,UPDATE_CUSTOMER,DELETE_SUPPLIER,VIEW_OPPORTUNITY,EDIT_OPPORTUNITY")]
        public new ResponseData GetTiersById(int id)
        {
            return new ResponseData
            {
                flag = 1,
                objectData = _serviceTiers.GetModelWithRelations(x => x.Id == id, x=> x.Vehicle,x => x.IdCurrencyNavigation, x => x.IdPhoneNavigation, x => x.IdTierCategoryNavigation),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
        }

        [HttpGet("getLastTierArticles/{id}")]
        public ResponseData GetLastTierArticles(int id)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceTiers.GetLastTierArticles(id);
            result.objectData = dataSourceResult;
            result.customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification;
            result.flag = 1;
            return result;
        }

        [HttpPost("getDataSourcePredicateTiers")]
        public ResponseData GetDataSourcePredicateTiers([FromBody] PredicateFormatViewModel model)
        {
            if (model != null)
            {
                int idTypeTiers = Convert.ToInt32(model.Filter.FirstOrDefault(p => string.Compare(p.Prop, idTypeTiersConst, stringComparison) == 0).Value, CultureInfo.InvariantCulture);
                bool hasRole;
                if (idTypeTiers == (int)TiersType.Customer)
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_CUSTOMER", "VIEW_ORGANISATION_CLIENT" });
                }
                else
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_SUPPLIER", "VIEW_ORGANISATION_CLIENT" });
                }
                return (hasRole) ? base.GetDataSourcePredicate(model) : new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return new ResponseData();
        }

        [HttpPost("getPredicateTiers"), Authorize("LIST_TIERS")]
        public new ResponseData GetPredicate([FromBody] PredicateFormatViewModel model)
        {
            if (model != null)
            {
                return base.GetPredicate(model);
            }
            return new ResponseData();
        }
        [HttpPost("getModelByConditionTiers"), Authorize("LIST_TIERS")]
        public ResponseData GetModelByConditionTiers([FromBody] PredicateFormatViewModel model)
        {
            if (model != null)
            {
                return base.GetModelByCondition(model);
            }
            return new ResponseData();
        }

        [HttpPost("insert_Tiers")]
        public new ResponseData Post(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, [FromBody] string objectJsonToSave)
        {
            return PostTiers(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("insertTiers")]
        public ResponseData PostTiers(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            ObjectToSaveViewModel objectToSave = (objectJsonToSave != null) ?
                JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave) : objectSaved;
            if (objectToSave.model != null)
            {
                TiersViewModel instanceType = JsonConvert.DeserializeObject<TiersViewModel>(objectToSave.model.ToString());
                int idTypeTiers = instanceType.IdTypeTiers;
                bool hasRole;
                if (idTypeTiers == (int)TiersType.Customer)
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "ADD_CUSTOMER", "ADD_ORGANISATION", "EDIT_ORGANISATION" });
                }
                else
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "ADD_SUPPLIER", "ADD_ORGANISATION", "EDIT_ORGANISATION" });
                }
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {

                    var obj = _serviceTiers.AddModel(instanceType, objectToSave.EntityAxisValues, userMail);
                    result = new ResponseData
                    {
                        customStatusCode = CustomStatusCode.AddSuccessfull,
                        objectData = obj,
                        flag = 1
                    };
                    return result;
                }
            }
            return result;
        }
        [HttpPost("update_Tiers"), Authorize("UPDATE_SUPPLIER,UPDATE_CUSTOMER,EDIT_CONTACT,EDIT_ORGANISATION")]
        public new ResponseData Put(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, [FromBody] string objectJsonToSave)
        {
            return PutTiers(files, objectSaved, objectJsonToSave);
        }
        [HttpPut("updateTiers"), Authorize("UPDATE_SUPPLIER,UPDATE_CUSTOMER,EDIT_CONTACT")]
        public ResponseData PutTiers(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            ObjectToSaveViewModel objectToSave = (objectJsonToSave != null) ?
                JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave) : objectSaved;
            if (objectToSave.model != null)
            {
                TiersViewModel instanceType = JsonConvert.DeserializeObject<TiersViewModel>(objectToSave.model.ToString());
                int idTypeTiers = instanceType.IdTypeTiers;
                bool hasRole;
                if (idTypeTiers == (int)TiersType.Customer)
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "UPDATE_CUSTOMER", "ADD_CONTACT", "EDIT_CONTACT" });
                }
                else
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "UPDATE_SUPPLIER", "ADD_CONTACT", "EDIT_CONTACT" });
                }
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {

                    _serviceTiers.UpdateModel(instanceType, objectToSave.EntityAxisValues, userMail);
                    var entityName = objectToSave.model.IdTypeTiers == 1 ? "CUSTOMER" : objectToSave.model.IdTypeTiers == 2 ? "SUPPLIER" : "TIER";
                    result = new ResponseData
                    {
                        customStatusCode = CustomStatusCode.UpdateSuccessfull,
                        objectData = new { EntityName = entityName },
                        flag = 1
                    };
                    return result;
                }
            }
            return result;
        }
        [HttpDelete("deleteTiers/{id}")]
        public new ResponseData Delete(int id)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel>()
            };
            predicateFormatViewModel.Filter.Add(
                new FilterViewModel
                {
                    Prop = idConst,
                    Value = id,
                    Operation = Operation.Equals
                });
            int idTypeTiers = _serviceTiers.FindSingleModelBy(predicateFormatViewModel).IdTypeTiers;
            bool hasRole;
            if (idTypeTiers == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("DELETE_CUSTOMER");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("DELETE_SUPPLIER");
            }
            var entityName = idTypeTiers == 1 ? "CUSTOMER" : idTypeTiers == 2 ? "SUPPLIER" : "TIER";
            if (hasRole)
            {
                var result = base.Delete(id);
                result.objectData = new { EntityName = entityName };
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

        [HttpGet("getTiersContact"), Authorize("ADD_ACTION,ADD_OPPORTUNITY,EDIT_OPPORTUNITY,OWN_OPPORTUNITY,ADD_CLAIM,EDIT_CLAIM,EDIT_ACTION,ADD_TIERS")]
        public new ResponseData GetTiersContact()
        {
            ResponseData result = new ResponseData();

            var contact = _serviceTiers.GetTierContact(TypeTiersClient);
            result.listObject = new ListObject
            {
                listData = contact,
                total = contact.Count()
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getSupplierDropdownList"), Authorize("LIST_TIERS,ADD_ITEM,UPDATE_ITEM,ADD_INVENTORY_MOVEMENT,RESEARCH_HISTORY,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES," +
            "LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES,LIST_QUICK_SALES,LIST_PRICES,LIST_CLAIM_PURCHASE,UPDATE_PRICEREQUEST,LIST_PROVISIONING,SHOW_BALANCE_PURCHASE,SHOW_UPDATE_BALANCE_PURCHASE," +
            "LIST_ORDER_QUOTATION_PURCHASE,LIST_FINAL_ORDER_PURCHASE,LIST_RECEIPT_PURCHASE,LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE,ADD_EXPENSE,UPDATE_EXPENSE,LIST_ADMISSION_VOUCHERS,LIST_EXIT_VOUCHERS," +
            "LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT,LIST_FUNDS_TRANSFER,LIST_CASH_MANAGEMENT,READONLY_SUPPLIER_PAYMENT_HISTORY,READONLY_CUSTOMER_PAYMENT_HISTORY,LIST_SUPPLIER_PAYMENT_HISTORY," +
            "LIST_CUSTOMER_PAYMENT_HISTORY,LIST_CUSTOMER_RECEIVABLES_STATE,LIST_SUPPLIER_RECEIVABLES_STATE,LIST_DOCUMENT_STATUS_CONTROL,LIST_TIERS_EXTRACT,LIST_CUSTOMERS_VEHICLES,SHOW_WAREHOUSE,LIST_ITEM," +
            "LIST_INVENTORY_MOVEMENT,SHOW_DELIVERY_SALES,UPDATE_CUSTOMER,ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,LIST_CUSTOMER_VEHICLE,SHOW_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,SHOW_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,SHOW_INVOICE_PURCHASE,SHOW_RECEIPT_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,SHOW_ASSET_PURCHASE,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,SHOW_QUOTATION_SALES,ADD_RECEIPT_PURCHASE," +
            "SHOW_FINANCIAL_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,ADD_ORDER_SALES,UPDATE_ORDER_SALES," +
            "SHOW_ORDER_SALES,UPDATE_VALID_ORDER_SALES,SHOW_EXPENSE,UPDATE_EXPENSE,ADD_EXPENSE,SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES," +
            "ADD_INVOICE_SALES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,SHOW_CLAIM_PURCHASE,ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST," +
            "SHOW_PRICEREQUEST,LIST_SERVICES_CONTRACT,ADD_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT,ADD_BILLING_SESSION,UPDATE_BILLING_SESSION,SHOW_BILLING_SESSION,COUNTER_SALES")]
        public ResponseData GetSupplierDropdownList([FromBody] ObjectToSaveViewModel objectToSave)
        {

            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();

            ResponseData result = new ResponseData();
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }

            int? idProject = objectToSave.model.idProject;
            var dataSource = _serviceTiers.GetSupplierDropdownList(predicateFormatViewModel, idProject);
            result.listObject = new ListObject
            {
                listData = dataSource.data,
                total = dataSource.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getTiersListByArray"), Authorize("VIEW_ACTION,VIEW_CONTACT_CLIENT,VIEW_CONTACT_LEAD,OWN_CONTACT,EDIT_CONTACT,VIEW_OPPORTUNITY,VIEW_CLAIM_CLIENT,VIEW_ARCHIVED_ACTION,VIEW_ARCHIVED_CONTACT," +
            "VIEW_ARCHIVED_OPPORTUNITY,VIEW_CLAIM_LEAD")]
        public ResponseData GetTiersListByArray([FromBody] List<int> listTiersId)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceTiers.GetTiersListByArray(listTiersId),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [HttpGet("downloadSupplierExcelTemplate")]
        public FileInfoViewModel DownloadSupplierExcelTemplate()
        {
            return _serviceTiers.DownloadSupplierExcelTemplate();
        }
        [HttpGet("downloadCustomerExcelTemplate")]
        public FileInfoViewModel DownloadCustomerExcelTemplate()
        {
            return _serviceTiers.DownloadCustomerExcelTemplate();
        }
        [HttpPost, DisableRequestSizeLimit, Route("importFileSuppliers")]
        public ResponseData UploadSuppliersFile([FromBody] FileInfoViewModel model)
        {

            ResponseData result = new ResponseData
            {
                flag = 0,
                listObject = new ListObject
                {
                    listData = _serviceTiers.GenerateTiersListFromExcel(model, (int)TiersType.Supplier)
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpPost, DisableRequestSizeLimit, Route("importFileCustomers")]
        public ResponseData UploadCustomersFile([FromBody] FileInfoViewModel model)
        {

            ResponseData result = new ResponseData
            {
                flag = 0,
                listObject = new ListObject
                {
                    listData = _serviceTiers.GenerateTiersListFromExcel(model, (int)TiersType.Customer)
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpPost, Route("insertTiersList"), Authorize("ADD_SUPPLIER,UPDATE_SUPPLIER,ADD_CUSTOMER,UPDATE_CUSTOMER")]
        public ResponseData InsertTiersList([FromBody] IList<TiersViewModel> tiersList)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceTiers.BulkAdd(tiersList.Where(x => x.Id == 0).ToList(), userMail);
                _serviceTiers.BulkUpdateModel(tiersList.Where(x => x.Id != 0).ToList(), userMail);
                result.customStatusCode = CustomStatusCode.DocumentImportedSuccessfully;
                result.flag = 1;
                return result;
            }
        }


        [HttpPost, Route("getGeneralTiers"), Authorize("SHOW_CUSTOMER,UPDATE_CUSTOMER,SHOW_SUPPLIER,UPDATE_SUPPLIER")]
        public ResponseData GetGeneralTiers([FromBody] TiersViewModel tier)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceTiers.GetGeneralTiers(tier);
                result.customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost, Route("getActivitiesTiers"), Authorize("SHOW_CUSTOMER,UPDATE_CUSTOMER,SHOW_SUPPLIER,UPDATE_SUPPLIER")]
        public ResponseData GetActivitiesTiers([FromBody] TiersViewModel tier)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceTiers.GetActivitiesTiers(tier);
                result.customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost("CheckTaxRegistration"), Authorize("ADD_CUSTOMER,UPDATE_CUSTOMER,ADD_SUPPLIER,UPDATE_SUPPLIER")]
        public bool CheckTaxRegistration([FromBody] dynamic objectToCheck)
        {
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            CheckTaxRegistrationViewModel model = JsonConvert.DeserializeObject<CheckTaxRegistrationViewModel>(objectToCheck.ToString());
            bool result = _serviceTiers.CheckTaxRegistration(model);
            return result;
        }

        [HttpPost("getCustomersFillingIsAffectedToPricesWithSpecificFilter/{idPrice}")]
        public virtual DataSourceResultWithSelections<TiersViewModel> GetCustomersFillingIsAffectedToPricesWithSpecificFilter
            ([FromBody] List<PredicateFormatViewModel> model, int idPrice)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            var dataSourceResult = _serviceTiers.GetCustomersFillingIsAffectedToPricesWithSpecificFilter(model, idPrice);


            return dataSourceResult;
        }

        [HttpPost("getTiersAndInvoiceForGarageInterventionList")]
        public ResponseData GetTiersAndInvoiceForGarageInterventionList([FromBody] dynamic model)
        {
            IList<int> idTiersList = JsonConvert.DeserializeObject<IList<int>>(model.idTiersList.ToString());
            IList<int?> idDocumentList = JsonConvert.DeserializeObject<IList<int?>>(model.idDocumentList.ToString());

            var dataSourceResult = _serviceTiers.GetTiersAndInvoiceForGarageInterventionList(idTiersList, idDocumentList);
            ResponseData result = new ResponseData
            {
                objectData = dataSourceResult,
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get data with predicate and specific filter
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_CUSTOMER,LIST_SUPPLIER,VIEW_ORGANISATION_LEAD,VIEW_ORGANISATION_CLIENT")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceTiers.GetDataWithSpecificFilter(model);

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



        [HttpPost("getDataSourcePredicate"), Authorize("VIEW_CONTACT_CLIENT,VIEW_CONTACT_LEAD,ADD_CONTACT,OWN_CONTACT,EDIT_CONTACT,VIEW_CLAIM_CLIENT,ADD_CLAIM,VIEW_ARCHIVED_CONTACT,VIEW_ARCHIVED_CLAIM," +
            "ADD_OPPORTUNITY,EDIT_OPPORTUNITY,OWN_OPPORTUNITY,LIST_CUSTOMER_VEHICLE,LIST_CUSTOMER,LIST_SUPPLIER,SEND_SMS,VIEW_CLAIM_LEAD,ADD_ACTION,EDIT_ACTION,ADD_TIERS")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }


        [HttpPost("getUnicity"), Authorize("ADD_ORGANISATION,EDIT_ORGANISATION,SHOW_CUSTOMER,ADD_CUSTOMER,UPDATE_CUSTOMER,ADD_SUPPLIER,UPDATE_SUPPLIER,SHOW_SUPPLIER")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }

        [HttpGet("getById/{id}"), Authorize("ADD_SUPPLIER,ADD_CUSTOMER,UPDATE_SUPPLIER,UPDATE_CUSTOMER,ADD_CONTACT,UPDATE_COMPANY,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,COUNTER_SALES")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
        [HttpPost("getPictures"), Authorize("LIST_CUSTOMER,LIST_SUPPLIER")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }

        [HttpPost("getPicture"), Authorize("SHOW_SUPPLIER,UPDATE_SUPPLIER,SHOW_CUSTOMER,LIST_CUSTOMER,UPDATE_CUSTOMER,LIST_SUPPLIER")]
        public override byte[] getPicture([FromBody] string path)
        {
            return base.getPicture(path);
        }
        [HttpPost("getPredicateTiersForGarage")]
        public ResponseData GetTiersWithPredicateForGarage([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_TIERS_EXTRACT")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }
        [HttpGet("getFormatOptionsForPurchase/{id}")]
        public NumberFormatOptionsViewModel getFormatOptionsForPurchase([FromRoute] int id)
        {
            return _serviceTiers.getFormatOptionsForPurchase(id);
        }
        [HttpPost("getPredicateTiersForRhPaie")]
        public ResponseData GetTiersWithPredicateForRhPaie([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getTiersByIds"), Authorize("GENERATE_BILLING_SESSION_INVOICES,LIST_SERVICES_CONTRACT,EDIT_CONTACT")]
        public List<TiersViewModel> GetTiersByIds([FromBody] List<int> ids)
        {
            return _serviceTiers.FindByAsNoTracking(x => ids.Contains(x.Id)).ToList();
        }
        #region synchronize with BtoB
        /// <summary>
        /// B2B synchronize Client
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("SynchronizeClientBtoB")]
        public ResponseData SynchronizeClientBToB([FromBody] dynamic response)
        {
            ResponseData result = new ResponseData();
            string stringData = response.ToString();
            SynchronizeClientUserBToBViewModel responseSynchronizedClient = JsonConvert.DeserializeObject<SynchronizeClientUserBToBViewModel>(stringData);

                {
                    result.objectData = _serviceTiers.SynchronizeClientBtoB( responseSynchronizedClient);
                    result.flag = 1;
                    result.customStatusCode = CustomStatusCode.GetSuccessfull;
                }
            return result;
        }
        /// <summary>
        /// B2B synchronize update Client
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("UpdateClientBtoB")]
        public ResponseData UpdateClientBtoB([FromBody] dynamic response)
        {
            ResponseData result = new ResponseData();
            string stringData = response.ToString();
            SynchronizeClientUserBToBViewModel responseSynchronizedClient = JsonConvert.DeserializeObject<SynchronizeClientUserBToBViewModel>(stringData);
            {
                _serviceTiers.UpdateClientBtoB( responseSynchronizedClient);
                {
                    result.flag = 1;
                    result.customStatusCode = CustomStatusCode.GetSuccessfull;
                }
            }
            return result;
        }
        /// <summary>
        /// B2B Response Data
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("getStarkClients")]
        public ResponseData GetStarkClients([FromBody] dynamic response)
        {
            ResponseData result = new ResponseData();
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            var responseData = _serviceTiers.SearchTiersBtob(SearchDate);
            {
                result.objectData = responseData;
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;

            }
            return result;
        }
        #endregion
    }
}
