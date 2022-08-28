using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Serilog.Events;
using Services.Generic.Classes;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Ecommerce.Classes
{
    public class ServiceEcommerce : Service<JobTableViewModel, JobTable>, IServiceEcommerce
    {
        private new readonly AppSettings _appSettings;
        private readonly IServiceItem _serviceItem;
        private readonly IServiceTiers _serviceTiers;
        private readonly IServiceTaxe _serviceTaxe;
        private readonly IServicePrices _servicePrices;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceDelivery _serviceDelivery;
        private readonly IServiceTriggerItemLog _serviceTriggerItemLog;
        private readonly IRepository<DocumentType> _serviceDocumentType;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IRepository<DocumentLine> _entityDocumentLine;
        private readonly IDocumentLineBuilder _documentLineBuilder;
        private readonly IRepository<Company> entityRepoCompany;
        private readonly IServiceFamily _serviceFamily;
        private readonly IServiceSubFamily _serviceSubFamily;

        public ServiceEcommerce(IRepository<JobTable> entityRepo, IUnitOfWork unitOfWork,
          IJobTableBuilder entityBuilder, IOptions<AppSettings> appSettings,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceItem serviceItem,
           IServiceTiers serviceTiers, IServiceDocument serviceDocument,
           IServiceItemWarehouse serviceItemWarehouse, IRepository<DocumentLine> entityDocumentLine,
           IDocumentLineBuilder documentLineBuilder,
           IServiceSubFamily serviceSubFamily,
           IServiceFamily serviceFamily,
          IRepository<DocumentType> serviceDocumentType, IServiceWarehouse serviceWarehouse, IServiceTriggerItemLog serviceTriggerItemLog, IRepository<Company> entityRepoCompany,
            IServiceTaxe serviceTaxe, IServicePrices servicePrices, IServiceDelivery serviceDelivery)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _appSettings = appSettings.Value;
            _serviceItem = serviceItem;
            _serviceTiers = serviceTiers;
            _serviceDocument = serviceDocument;
            _serviceWarehouse = serviceWarehouse;
            _serviceDocumentType = serviceDocumentType;
            _serviceTriggerItemLog = serviceTriggerItemLog;
            _serviceTaxe = serviceTaxe;
            _servicePrices = servicePrices;
            _serviceDelivery = serviceDelivery;
            _serviceItemWarehouse = serviceItemWarehouse;
            _entityDocumentLine = entityDocumentLine;
            _documentLineBuilder = documentLineBuilder;
            _serviceFamily = serviceFamily;
            _serviceSubFamily = serviceSubFamily;
        }

        /// <summary>
        /// Get Http Response From Request
        /// </summary>
        /// <param name="post"></param>
        /// <param name="uri"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        public async Task<string> GetHttpResponseFromRequest(HttpMethod post, Uri uri, string content, List<ItemViewModel> listProducts)
        {
            using (var httpClient = new HttpClient())
            {
                HttpRequestMessage request = new HttpRequestMessage(post, uri);
                request.Headers.Add("Authorization", "Bearer " + string.Format("{0}", _appSettings.ECommerceConfig.BasicAuthentification));
                request.Headers.Add("X-Requested-With", "XMLHttpRequest");
                if (content != null)
                {
                    request.Content = new StringContent(content, Encoding.UTF8, "application/json");
                }

                try
                {
                    HttpResponseMessage response = await httpClient.SendAsync(request);
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    CheckEcommerceAccessAuthorization(jsonResponse);
                    listProducts = null;
                    return jsonResponse;
                }
                catch (Exception e)
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error, "Ecommerce inexistant");
                    throw new CustomException(CustomStatusCode.EcommerceException, e);
                }
                finally
                {
                    if (listProducts != null)
                    {
                        foreach (ItemViewModel product in listProducts)
                        {
                            if (product.IsEcommerce)
                            {
                                product.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOffline;
                            }
                            else
                            {
                                product.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline;
                            }
                            product.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.UnsynchronizedWithError;

                            TriggerItemLogViewModel triggerItemLogViewModel = new TriggerItemLogViewModel
                            {
                                IdItem = product.Id,
                                Code = "500",
                                Message = "Ecommerce est Introuvable",
                                DateLog = DateTime.UtcNow
                            };
                            _serviceTriggerItemLog.AddModelWithoutTransaction(triggerItemLogViewModel, null, null);

                        }
                        _serviceItem.BulkUpdateModelWithoutTransaction(listProducts, null);
                        EndTransaction();
                    }
                }

            }
        }

        /// <summary>
        /// Check Ecommerce Access Authorization
        /// </summary>
        /// <param name="jsonResponse"></param>
        /// <returns></returns>

        private void CheckEcommerceAccessAuthorization(string jsonResponse)
        {
            try
            {
                InAuthorizedAccesstoECommerceViewModel authorizedAccesstoECommerceViewModel = JsonConvert.DeserializeObject<InAuthorizedAccesstoECommerceViewModel>(jsonResponse);
                if (authorizedAccesstoECommerceViewModel != null && authorizedAccesstoECommerceViewModel.code == (int)CustomStatusCode.Unauthorized)
                {
                    throw new CustomException(CustomStatusCode.Unauthorized, null, null);
                }
            }
            catch { }
        }

        /// <summary>
        /// return list of clients where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public async Task<DataSourceResult<ClientViewModel>> GetEcommerceCustomerListAsync(PredicateFormatViewModel predicateModel)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return null;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.URLListClient);

            string responseString = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, JsonConvert.SerializeObject(predicateModel), null);
            DataSourceResult<ClientViewModel> dataSourceResult = JsonConvert.DeserializeObject<DataSourceResult<ClientViewModel>>(responseString);
            return dataSourceResult;
        }
        /// <summary>
        /// Change Premuim Ecommerce Customer Async
        /// </summary>
        /// <param name="id"></param>
        /// <param name="isPremium"></param>
        /// <returns></returns>
        public async Task<bool> ChangePremuimEcommerceCustomerAsync(int id, bool isPremium)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return false;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.URLIsPremuimClient);
            ClientViewModel clientViewModel = new ClientViewModel
            {
                Id = id,
                IsPremium = isPremium
            };
            string jsonContent = JsonConvert.SerializeObject(clientViewModel);
            string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, jsonContent, null);
            clientViewModel = JsonConvert.DeserializeObject<ClientViewModel>(jsonResponse);
            return clientViewModel.Premium.Equals("success") ? true : false;
        }
        /// <summary>
        /// Ecommerce Movement
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        async Task<string> IServiceEcommerce.EcommerceMovement(string json)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return string.Empty;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.UpdateProductStock);
            string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Put, myUri, json, null);
            List<string> errorsIdStarks = new List<string>();
            string response = "successful";
            return response;
        }
        /// <summary>
        /// Ecommerce Get delivery forms
        /// </summary>
        /// <param name="connectionString"></param>
        /// <returns></returns>
        async Task IServiceEcommerce.EcommerceGetDeliveryForms(string connectionString)
        {
            try
            {
                if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
                {
                    return;
                }
                var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.SENDING_GETTING_DELEVERY_FORMS_REQUEST_FROM_JOB);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.URLEcommerceBL);
                string responseString = await GetHttpResponseFromRequest(HttpMethod.Get, myUri, null, null);

                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.RECEIVING_ECOMMERCE_RESPONSE);
                List<int> listOfVisitedCustomersAutoshopId = new List<int>();

                ListOrdersViewModel listOrdersViewModel = JsonConvert.DeserializeObject<ListOrdersViewModel>(responseString);

                string json = "[";
                foreach (OrderMagentoViewModel orderViewModel in listOrdersViewModel.items)
                {
                    int IdInvoiceEcommerce = orderViewModel.entity_id;
                    try
                    {
                        DocumentViewModel document = new DocumentViewModel();
                        BeginTransactionunReadUncommitted(connectionString);
                        List<DocumentViewModel> documents = _serviceDocument.GetModelsWithConditionsRelations(x => x.IdInvoiceEcommerce == IdInvoiceEcommerce).ToList();
                        EndTransaction();

                        if (documents.Count == 0)
                        {
                            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                            Constants.BEGIN_CREATING_DELEVERY_FORM_FROM_JOB + IdInvoiceEcommerce);
                            BeginTransaction();
                            int idClient = InsertOrUpdateAndGetCustomerOfDelivery(orderViewModel, listOfVisitedCustomersAutoshopId);
                            document = CreateNewDocumentFromEcommerce(orderViewModel.items, IdInvoiceEcommerce, idClient);
                            DocumentType documentType = _serviceDocumentType.GetSingleNotTracked(c => c.CodeType == DocumentEnumerator.SalesOrder);
                            CreatedDataViewModel result = (CreatedDataViewModel)_serviceDocument.AddDocumentWithoutTransaction(null, document, documentType, null, null);
                            EndTransaction();

                            BeginTransaction();
                            DocumentViewModel validatedDocument = _serviceDocument.ValidateDocumentWithoutTransaction(result.Id, null, (int)DocumentStatusEnumerator.Valid, false);
                            EndTransaction();


                            json += PrepareResponseSuccessSynchronizedOrder(IdInvoiceEcommerce, 1);
                            json += ",";
                            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                            Constants.END_CREATING_DELEVERY_FORM_FROM_JOB + IdInvoiceEcommerce);

                        }
                        else
                        {
                            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Warning,
                            Constants.ALREADY_EXIST_DELEVERY_FORM_FROM_JOB + IdInvoiceEcommerce);
                            json += PrepareResponseSuccessSynchronizedOrder(IdInvoiceEcommerce, 1);
                            json += ",";
                        }


                    }
                    catch (Exception ex)
                    {
                        json += PrepareResponseErrorSynchronizedOrder(IdInvoiceEcommerce, 0, Constants.ERROR_CREATING_DELEVERY_FORM_FROM_JOB + ex);
                        json += ",";
                        GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                            Constants.ERROR_CREATING_DELEVERY_FORM_FROM_JOB, ex);
                        RollBackTransaction();
                    }

                }
                json = json.Remove(json.Length - 1);
                json += "]";
                json = json.Replace("'", "\"");

                myUri = new Uri(baseUri, _appSettings.ECommerceConfig.URLEcommerceConfirmationBL);
                responseString = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, json, null);
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                            Constants.ERROR_GENRATE_DELEVERY_FORMS_FROM_JOB, e);
                throw e;
            }

        }


        private string ReturnSuccessResponseWithAramex(int IdInvoiceEcommerce, OrderMagentoViewModel orderMagentoViewModel)
        {
            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                                Constants.ADD_CONFIRMATION_DELEVERY_FORM_FROM_JOB + IdInvoiceEcommerce);
            return "{'id':" + IdInvoiceEcommerce + ",'etat':'success', " +
                    "'Shipments':{" +
                    "'Shipment':{" +
                    "'Shipper':{'AccountNumber':'20016'," +
                    "'PartyAddress':{'Line1':'Mecca St','City':'Amman','PostCode':'','CountryCode':'Jo'}," +
                    "'Contact':{'PersonName':'Michael','CompanyName':'Aramex','PhoneNumber1':'5555555'," +
                    "'CellPhone':'777','EmailAddress':'michael@aramex.com'}}," +
                    "'Consignee':{" +
                    "'PartyAddress':{'Line1':'" + orderMagentoViewModel.billing_address.address_type + "','City':'" + orderMagentoViewModel.billing_address.city + "','PostCode':'" + orderMagentoViewModel.billing_address.postcode + "','CountryCode':'" + orderMagentoViewModel.billing_address.region + "'}," +
                    "'Contact':{'PersonName':'" + orderMagentoViewModel.customer_firstname + " " + orderMagentoViewModel.customer_lastname + "','CompanyName':'','PhoneNumber1':'" + orderMagentoViewModel.billing_address.telephone + "'," +
                    "'CellPhone':'" + orderMagentoViewModel.billing_address.telephone + "','EmailAddress':'" + orderMagentoViewModel.billing_address.email + "'}}," +
                    "'ForeignHAWB':'','TransportType':0," +
                    "'ShippingDateTime':1569940270," +
                    "'Details':{'ActualWeight':{'Value':0.5,'Unit':'Kg'}," +
                    "'ProductGroup':'EXP','ProductType':'PDX','PaymentType':'P','PaymentOptions':''," +
                    "'NumberOfPieces':1,'DescriptionOfGoods':'Docs','GoodsOriginCountry':'Jo','CashOnDeliveryAmount':{'Value':0,'CurrencyCode':''}," +
                    "'InsuranceAmount':{'Value':0,'CurrencyCode':''},'CollectAmount':{'Value':0,'CurrencyCode':''}," +
                    "'CashAdditionalAmount':{'Value':0,'CurrencyCode':''},'CashAdditionalAmountDescription':''," +
                    "'CustomsValueAmount':{'Value':0,'CurrencyCode':''},'Items':[{'PackageType':'Box','Quantity':1,'Weight':{'Value':0.5,'Unit':'Kg'}," +
                    "'Comments':'Docs','Reference':''}]}}}},";
        }

        private DocumentViewModel CreateNewDocumentFromEcommerce(List<ProductMagentoViewModel> Products, int IdInvoiceAutoshop, int idClient)
        {
            DocumentViewModel document = new DocumentViewModel()
            {
                IdDocumentStatus = 1,
                DocumentTypeCode = DocumentEnumerator.SalesOrder,
                IdTiers = idClient,
                IdUsedCurrency = 2,
                IdInvoiceEcommerce = IdInvoiceAutoshop,
                IsTermBilling = true,
                DocumentDate = DateTime.UtcNow,
                DocumentLine = new List<DocumentLineViewModel>()
            };

            DocumentLineViewModel documentLineViewModel;
            WarehouseViewModel warehouseViewModel = _serviceWarehouse.GetModelWithRelationsAsNoTracked(x => x.IsEcommerce == true);

            foreach (ProductMagentoViewModel productViewModel in Products)
            {
                ItemViewModel itemViewModel = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Code == productViewModel.sku, x => x.IdUnitSalesNavigation);
                if (itemViewModel != null)
                {
                    documentLineViewModel = new DocumentLineViewModel()
                    {
                        IdItem = itemViewModel.Id,
                        Designation = itemViewModel.Description.Replace("'", "\'"),
                        MovementQty = productViewModel.qty_ordered,
                        IsChecked = false,
                        IdMeasureUnit = itemViewModel.IdUnitSales,
                        MesureUnitLabel = itemViewModel.IdUnitSalesNavigation.Label,
                        IdWarehouse = warehouseViewModel.Id,
                        HtUnitAmount = productViewModel.price,
                        HtAmount = productViewModel.price,
                        HtUnitAmountWithCurrency = productViewModel.price,
                        HtAmountWithCurrency = productViewModel.price,
                        IsActive = false,
                        DiscountPercentage = 0
                    };

                    document.DocumentLine.Add(documentLineViewModel);
                }
            }
            /*
            DeliveryViewModel deliveryViewModel = _serviceDelivery.GetAllModelsAsNoTracking().Last();

            if (deliveryViewModel != null)
            {
                ItemViewModel itemViewModelAramex = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == deliveryViewModel.IdItem, x => x.TaxeItem);
                TaxeViewModel taxeViewModel = _serviceTaxe.GetModelWithRelationsAsNoTracked(x => x.Id == itemViewModelAramex.TaxeItem.FirstOrDefault().IdTaxe);
                PricesViewModel pricesViewModel = _servicePrices.GetModelAsNoTracked(x => x.IdItem == itemViewModelAramex.Id);

                documentLineViewModel = new DocumentLineViewModel()
                {
                    IdItem = itemViewModelAramex.Id,
                    Designation = itemViewModelAramex.Description.Replace("'", "\'"),
                    MovementQty = 1,
                    IsChecked = false,
                    HtUnitAmount = pricesViewModel.PricesValue,
                    HtAmount = pricesViewModel.PricesValue ?? 0,
                    HtUnitAmountWithCurrency = pricesViewModel.PricesValue,
                    HtAmountWithCurrency = pricesViewModel.PricesValue,
                    IsActive = false
                };

                document.DocumentLine.Add(documentLineViewModel);
            }
            */
            return document;

        }

        private int InsertOrUpdateAndGetCustomerOfDelivery(OrderMagentoViewModel orderViewModel, List<int> listOfVisitedCustomersAutoshopId)
        {
            int idClient = 0;
            CreatedDataViewModel obj = null;
            TiersViewModel instanceType = new TiersViewModel()
            {
                Name = orderViewModel.customer_firstname + " " + orderViewModel.customer_lastname,
                IdCurrency = 2,
                IdTaxeGroupTiers = 2,
                IdTypeTiers = 1,
                IdEcommerceCustomer = orderViewModel.customer_id,
                Email = orderViewModel.billing_address.email,
                Contact = new List<ContactViewModel>(),
                AuthorizedAmountInvoice = 1000000
            };

            ContactViewModel contact = new ContactViewModel()
            {
                FirstName = orderViewModel.customer_firstname,
                LastName = orderViewModel.customer_lastname,
                Tel1 = "216" + orderViewModel.billing_address.telephone,
                Email = orderViewModel.billing_address.email,
                Adress = orderViewModel.billing_address.address_type,
                IsDeleted = false
            };
            instanceType.Contact.Add(contact);

            var idAutoshop = instanceType.IdEcommerceCustomer;
            TiersViewModel tiersViewModel = _serviceTiers.GetModelWithRelationsAsNoTracked(x => x.IdEcommerceCustomer == idAutoshop);

            if (tiersViewModel == null)
            {
                obj = (CreatedDataViewModel)_serviceTiers.AddModelWithoutTransaction(instanceType, null, null, null);
                idClient = obj.Id;
                listOfVisitedCustomersAutoshopId.Add(idClient);
            }
            else
            {
                idClient = tiersViewModel.Id;
                if (!listOfVisitedCustomersAutoshopId.Contains(idClient))
                {
                    instanceType.Id = tiersViewModel.Id;
                    instanceType.CodeTiers = tiersViewModel.CodeTiers;
                    instanceType.Contact = tiersViewModel.Contact;
                    _serviceTiers.UpdateModelWithoutTransaction(instanceType, null, null);
                    listOfVisitedCustomersAutoshopId.Add(idClient);
                }
            }
            return idClient;
        }

        /// <summary>
        /// Get And Update (in stark) Added Products From Ecommerce
        /// </summary>
        /// <param name="connectionString"></param>
        /// <returns></returns>
        public async Task GetAndUpdateAddedProductsFromEcommerce(string connectionString)
        {
            try
            {
                if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
                {
                    return;
                }
                Uri baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.GetAddedProductsFromEcommerceUrl);
                dynamic json_response = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, null, null);


                List<ProductViewModel> products = JsonConvert.DeserializeObject<List<ProductViewModel>>(json_response);

                if (products.Count > 0)
                {
                    string content = UpdateProductAfterSynchronizeEcommerce(products, connectionString, false);
                    myUri = new Uri(baseUri, _appSettings.ECommerceConfig.DeleteProductsOfEcommerceAfterUpdateInStarkUrl);
                    await GetHttpResponseFromRequest(HttpMethod.Post, myUri, content, null);

                }


            }
            catch (Exception e)
            {
                throw e;
            }
        }
        /// <summary>
        /// Update Product After Synchronize Ecommerce
        /// </summary>
        /// <param name="products"></param>
        /// <param name="connectionString"></param>
        private string UpdateProductAfterSynchronizeEcommerce(List<ProductViewModel> products, string connectionString, bool FromSyncNowBtn)
        {
            List<int> UpdatedProducts = new List<int>();
            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.UPDATING_SYNCHRONIZATION_STATUS);
            foreach (ProductViewModel product in products)
            {
                BeginTransaction(connectionString);
                UpdatedProducts.Add(product.IdProductStark);
                ItemViewModel itemViewModel = _serviceItem.GetModelAsNoTracked(p => p.Id == product.IdProductStark);
                if (product.State == "success")
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.SUCCESS_SYNCHRONIZATION + itemViewModel.Code);
                    itemViewModel.ExistInEcommerce = true;
                    if (itemViewModel.OnlineSynchonizationStatus == (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Pended)
                    {
                        itemViewModel.SynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;
                    }

                    if (itemViewModel.OnlineSynchonizationStatus == (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOffline)
                    {
                        itemViewModel.IsEcommerce = false;
                    }
                    else if (itemViewModel.OnlineSynchonizationStatus == (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline)
                    {
                        itemViewModel.IsEcommerce = true;
                    }

                    itemViewModel.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;

                    if (FromSyncNowBtn)
                    { itemViewModel.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed; }

                }
                else
                {
                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                       Constants.ERROR_SYNCHRONIZATION_MESSAGE + product.Message);
                    TriggerItemLogViewModel triggerItemLogViewModel = new TriggerItemLogViewModel
                    {
                        IdItem = product.IdProductStark,
                        Code = product.Code,
                        Message = product.Message,
                        DateLog = DateTime.UtcNow
                    };
                    _serviceTriggerItemLog.AddModelWithoutTransaction(triggerItemLogViewModel, null, null);

                    if (product.IsEcommerce)
                    {
                        itemViewModel.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline;
                    }
                    else
                    {
                        itemViewModel.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOffline;
                    }


                    itemViewModel.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.UnsynchronizedWithError;
                }
                _serviceItem.UpdateModelWithoutTransaction(itemViewModel, null, null);

                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.SUCCESS_UPDATE_STARK + itemViewModel.Code);
                EndTransaction();
            }
            return JsonConvert.SerializeObject(UpdatedProducts);
        }


        /// <summary>
        /// Synchoniser Products Async with Ecommerce application
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="stringData"></param>
        /// <param name="addItemViewModels"></param>
        /// <param name="editItemViewModels"></param>
        /// <param name="editOldItemViewModels"></param>
        /// <param name="updateEditProductsToIsEcommerce"></param>
        /// <param name="updateEditProductsToNotIsEcommerce"></param>
        /// <returns></returns>
        public async Task<string> SynchonizeIsEcommerceOfProductsAsync(string connectionString, string stringData,
            List<ItemViewModel> addItemViewModels, List<ItemViewModel> editItemViewModels, List<ItemViewModel> editOldItemViewModels,
            ProductsIntListViewModel updateEditProductsToIsEcommerce, ProductsIntListViewModel updateEditProductsToNotIsEcommerce)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return string.Empty;
            }
            BeginTransaction(connectionString);

            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.PREPARING_PRODUCTS_TO_SYNCHRONIZE);

            string listProductToSend = PrepareJsonProductToSendEcommerce(stringData, addItemViewModels, editItemViewModels,
            updateEditProductsToIsEcommerce, updateEditProductsToNotIsEcommerce);

            List<ItemViewModel> listeDesProduits = addItemViewModels.Concat(editItemViewModels).ToList();

            EndTransaction();
            try
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.SENDING_PRODUCTS_TO_SYNCHRONIZE);
                Uri baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddAndUpdateProductsUrl);
                string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, listProductToSend, listeDesProduits);

                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.RECEIVING_ECOMMERCE_RESPONSE);

                try
                {
                    return jsonResponse;
                }
                catch
                {

                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                            Convert.ToString(jsonResponse));
                    throw;
                }

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


        }
        /// <summary>
        /// Prepare Json Product To Send to Ecommerce application
        /// </summary>
        /// <param name="stringData"></param>
        /// <param name="addItemViewModels"></param>
        /// <param name="editItemViewModels"></param>
        /// <param name="updateEditProductsToIsEcommerce"></param>
        /// <param name="updateEditProductsToNotIsEcommerce"></param>
        /// <returns></returns>
        private string PrepareJsonProductToSendEcommerce(string stringData, List<ItemViewModel> addItemViewModels,
            List<ItemViewModel> editItemViewModels, ProductsIntListViewModel updateEditProductsToIsEcommerce, ProductsIntListViewModel updateEditProductsToNotIsEcommerce)
        {
            dynamic products = JObject.Parse(stringData)["Products"];

            AddOrEditProductsViewModel addOrEditProductsView = new AddOrEditProductsViewModel
            {
                AddProducts = new List<ProductViewModel>(),
                EditProducts = new EditProductsViewModel
                {
                    IsNotEcommerce = new List<int>(),
                    IsEcommerce = new List<int>()
                }
            };

            foreach (dynamic product in products)
            {
                int.TryParse(product.Name, out int idProduct);
                int isEcommerce = Convert.ToInt32((bool)product.Value);

                ItemViewModel item = _serviceItem.GetModelAsNoTracked(x => x.Id == idProduct, x => x.IdProductItemNavigation, x => x.TaxeItem);

                if (item.TecDocId != null && !string.IsNullOrEmpty(item.TecDocRef))
                {

                    if (!item.ExistInEcommerce)
                    {
                        ProductViewModel productViewModel = ConvertProductToJson(item, (bool)product.Value);
                        addOrEditProductsView.AddProducts.Add(productViewModel);
                        item.IsEcommerce = (bool)product.Value;
                        item.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Pended;
                        item.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed;
                        addItemViewModels.Add(item);

                    }
                    else
                    {
                        item.IsEcommerce = (bool)product.Value;
                        item.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;
                        editItemViewModels.Add(item);
                        if (isEcommerce == 1)
                        {
                            addOrEditProductsView.EditProducts.IsEcommerce.Add(item.Id);
                            updateEditProductsToIsEcommerce.ProductsToEdit.Add(item.Id);
                        }
                        else
                        {
                            addOrEditProductsView.EditProducts.IsNotEcommerce.Add(item.Id);
                            updateEditProductsToNotIsEcommerce.ProductsToEdit.Add(item.Id);
                        }
                    }
                }


            }
            return JsonConvert.SerializeObject(addOrEditProductsView);
        }
        /// <summary>
        /// Convert Product ToJson
        /// </summary>
        /// <param name="item"></param>
        /// <param name="isEcommerce"></param>
        /// <param name="designationOEM"></param>
        /// <returns></returns>
        public ProductViewModel ConvertProductToJson(ItemViewModel item, bool isEcommerce)
        {
            double sumOfTaxes = 1;
            if (item.TaxeItem.Count > 0)
            {
                sumOfTaxes = 0;
                foreach (TaxeItemViewModel taxeItemViewModel in item.TaxeItem)
                {
                    TaxeViewModel taxeViewModel = _serviceTaxe.GetModelAsNoTracked(x => x.Id == taxeItemViewModel.IdTaxe);
                    sumOfTaxes += taxeViewModel.TaxeValue ?? 0;
                }
                sumOfTaxes = 1 + (sumOfTaxes / 100);
            }
            double ttcPrices = Math.Round((item.UnitHtsalePrice ?? 0) * sumOfTaxes, 3);
            double HtPrices = Math.Round(item.UnitHtsalePrice ?? 0, 3);
            item.Description = item.Description.Replace("\t", "");
            item.Code = item.Code.Replace("\t", "");
            //if (item.Oem != null)
            //{ item.Oem = item.Oem.Replace("\t", ""); }

            ProductViewModel productViewModel = new ProductViewModel
            {
                Price = ttcPrices,
                PriceHTStark = HtPrices,
                Code = item.Code,
                IdProductStark = item.Id,
                IsEcommerce = isEcommerce,
                IdProd = item.TecDocId ?? 0,
                //OEM = item.Oem,
                Design = item.Description,
                ImageUrl = item.TecDocImageUrl,
                BrandId = item.TecDocIdSupplier ?? 0,
                BrandName = item.TecDocBrandName

            };

            return productViewModel;
        }

        /// <summary>
        /// Update Products in Stark after validation from Ecommerce Application
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="result"></param>
        /// <param name="addItemViewModels"></param>
        /// <param name="editItemViewModels"></param>
        /// <param name="editOldItemViewModels"></param>
        /// <param name="productsIntListIsEcommerce"></param>
        /// <param name="productsIntListNotIsEcommerce"></param>
        public void UpdateIsEcommerceOfProducts(string connectionString, string result, List<ItemViewModel> addItemViewModels, List<ItemViewModel> editItemViewModels,
            List<ItemViewModel> editOldItemViewModels, ProductsIntListViewModel productsIntListIsEcommerce,
            ProductsIntListViewModel productsIntListNotIsEcommerce)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            BeginTransaction(connectionString);
            try
            {
                ResultOfProductsToAddAndEditViewModel resultOfProductsToAddAndEditViewModel =
                    JsonConvert.DeserializeObject<ResultOfProductsToAddAndEditViewModel>(result);

                if (resultOfProductsToAddAndEditViewModel.ProductsToEdit == "success")
                {
                    if (editItemViewModels != null && editItemViewModels.Any())
                    {
                        GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.SUCCESS_SYNCHRONIZATION_IS_ECOMMERC + "[" + string.Join(",", productsIntListIsEcommerce.ProductsToEdit)
                        + "," + string.Join(",", productsIntListNotIsEcommerce.ProductsToEdit) + "]");
                        UpdateEditedProductsWithSpecificStatus(connectionString, productsIntListIsEcommerce, (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed);
                        UpdateEditedProductsWithSpecificStatus(connectionString, productsIntListNotIsEcommerce, (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed);
                    }
                }
                else
                {
                    if (editItemViewModels != null && editItemViewModels.Any())
                    {
                        GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                        Constants.ERROR_SYNCHRONIZATION_IS_ECOMMERCE + "[" + string.Join(",", productsIntListIsEcommerce.ProductsToEdit)
                        + "," + string.Join(",", productsIntListNotIsEcommerce.ProductsToEdit) + "]");
                        UpdateEditedProductsWithSpecificStatus(connectionString, productsIntListIsEcommerce, (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline);
                        UpdateEditedProductsWithSpecificStatus(connectionString, productsIntListNotIsEcommerce, (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOffline);
                    }
                }
                foreach (int id in resultOfProductsToAddAndEditViewModel.ProductsToAdd.ExistInPsProductToIsEcommerce)
                {
                    ItemViewModel itemViewModel = addItemViewModels.Find(x => x.Id == id);
                    if (itemViewModel != null)
                    {
                        itemViewModel.ExistInEcommerce = true;
                        itemViewModel.IsEcommerce = true;
                        itemViewModel.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;
                    }
                }

                foreach (int id in resultOfProductsToAddAndEditViewModel.ProductsToAdd.ExistInPsProductToNotIsEcommerce)
                {
                    ItemViewModel itemViewModel = addItemViewModels.Find(x => x.Id == id);
                    if (itemViewModel != null)
                    {
                        itemViewModel.ExistInEcommerce = true;
                        itemViewModel.IsEcommerce = false;
                        itemViewModel.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;
                    }
                }

                foreach (int id in resultOfProductsToAddAndEditViewModel.ProductsToAdd.ExistInProductToAdd)
                {
                    ItemViewModel itemViewModel = addItemViewModels.Find(x => x.Id == id);
                    if (itemViewModel != null)
                    {
                        addItemViewModels.Remove(itemViewModel);
                    }
                }

                int numberOfAddedProducts = 0;

                foreach (ProductViewModel ProductToAdd in resultOfProductsToAddAndEditViewModel.ProductsToAdd.Add)
                {
                    if (ProductToAdd.State == "error")
                    {
                        int idProduct = ProductToAdd.IdProductStark;
                        ItemViewModel itemViewModel = addItemViewModels.Find(x => x.Id == idProduct);
                        itemViewModel.ExistInEcommerce = false;
                        itemViewModel.OnlineSynchonizationStatus = itemViewModel.IsEcommerce ?
                                (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline :
                                (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline;

                        TriggerItemLogViewModel triggerItemLogViewModel = new TriggerItemLogViewModel
                        {
                            IdItem = idProduct,
                            Code = "500",
                            Message = ProductToAdd.Message
                        };

                        _serviceTriggerItemLog.AddModelWithoutTransaction(triggerItemLogViewModel, null, null);
                    }
                    else
                    {
                        numberOfAddedProducts++;
                    }
                }
                if (numberOfAddedProducts > 0)
                {
                    Uri baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                    Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddProductsUrl);
                    _ = GetHttpResponseFromRequest(HttpMethod.Post, myUri, null, null);

                    GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                    Constants.WAITING_SYNCHRONIZATION_IS_ECOMMERCE);
                }

                if (addItemViewModels != null && addItemViewModels.Any())
                {
                    _serviceItem.BulkUpdateModelWithoutTransaction(addItemViewModels, null);
                }

                EndTransaction();
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
        }
        /// <summary>
        /// Update Edited Products With Specific Status 
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="updateEditProductsViewModel"></param>
        /// <param name="status"></param>
        private void UpdateEditedProductsWithSpecificStatus(string connectionString, ProductsIntListViewModel updateEditProductsViewModel, int status)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                if (updateEditProductsViewModel.ProductsToEdit.Count() > 0)
                {
                    using (SqlCommand cmd = new SqlCommand(string.Format("UPDATE Inventory.Item SET OnlineSynchonizationStatus = {0}, IsEcommerce = {1} WHERE Id IN ({2})",
                        status, Convert.ToInt32(updateEditProductsViewModel.IsEcommerce), string.Join(",", updateEditProductsViewModel.ProductsToEdit)), conn))
                    {
                        int rows = cmd.ExecuteNonQuery();
                    }
                }

            }

        }
        /// <summary>
        /// Synchronize All Products Details Async
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="stringData"></param>
        /// <param name="itemViewModels"></param>
        /// <returns></returns>
        public async Task<string> SynchronizeAllProductsDetailsAsync(string connectionString, string stringData, List<ItemViewModel> itemViewModels)
        {
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return string.Empty;
            }
            BeginTransaction(connectionString);
            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.PREPARING_PRODUCTS_TO_SYNCHRONIZE);
            dynamic products = JObject.Parse(stringData)["Products"];

            List<ProductViewModel> productViewModels = new List<ProductViewModel>();

            // string productsJson = @"{'products': [";

            foreach (dynamic product in products)
            {
                int.TryParse(product.Name, out int idProduct);
                int isEcommerce = Convert.ToInt32((bool)product.Value);
                ItemViewModel item = _serviceItem.GetModelAsNoTracked(x => x.Id == idProduct, x => x.IdProductItemNavigation, x => x.TaxeItem);
                ProductViewModel productViewModel = ConvertProductToJson(item, (bool)product.Value);
                productViewModels.Add(productViewModel);
                item.IsEcommerce = (bool)product.Value;
                itemViewModels.Add(item);
            }

            ListProductsViewModel listProductsViewModel = new ListProductsViewModel
            {
                Products = productViewModels
            };

            string productsJson = JsonConvert.SerializeObject(listProductsViewModel);
            EndTransaction();
            try
            {
                var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.synchronizeAllProductsDetailsUrl);
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.SENDING_PRODUCTS_TO_SYNCHRONIZE);
                string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, productsJson, itemViewModels);

                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.RECEIVING_ECOMMERCE_RESPONSE);

                return jsonResponse;

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
        }
        /// <summary>
        /// Update All Products Details
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="json_response"></param>
        /// <param name="itemViewModels"></param>
        public void UpdateAllProductsDetails(string connectionString, string jsonResponse, List<ItemViewModel> itemViewModels)
        {
            try
            {
                ListProductsViewModel listProductsViewModel = JsonConvert.DeserializeObject<ListProductsViewModel>(jsonResponse);
                UpdateProductAfterSynchronizeEcommerce(listProductsViewModel.Products, connectionString, true);
            }
            catch
            {

                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                        Convert.ToString(jsonResponse));
                throw;
            }

        }

        public async Task<int> getFailedSalesDeliveryCountAsync()
        {
            try
            {
                if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
                {
                    return 0;
                }
                var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.GetFailedSalesDeliveryCountAsync);

                NumberOfFailedSalesDeliveryViewModel numberOfFailedSalesDelivery = new NumberOfFailedSalesDeliveryViewModel
                {
                    count = 1
                };

                string jsonContent = JsonConvert.SerializeObject(numberOfFailedSalesDelivery);
                string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Get, myUri, jsonContent, null);
                numberOfFailedSalesDelivery = JsonConvert.DeserializeObject<NumberOfFailedSalesDeliveryViewModel>(jsonResponse);
                return numberOfFailedSalesDelivery.count;
            }
            catch (Exception e)
            {
                return 0;
            }

        }

        public async Task<List<OrderMagentoViewModel>> getFailedSalesDeliveryDetailsAsync()
        {

            try
            {
                if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
                {
                    return null;
                }
                var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.URLEcommerceBL);
                string jsonResponse = await GetHttpResponseFromRequest(HttpMethod.Get, myUri, null, null);
                ListOrdersViewModel listOrdersViewModel = new ListOrdersViewModel();
                List<OrderMagentoViewModel> orderMagentoViewModels = new List<OrderMagentoViewModel>();
                if (jsonResponse.Equals("empty"))
                {
                    listOrdersViewModel = null;
                }
                else
                {
                    listOrdersViewModel = JsonConvert.DeserializeObject<ListOrdersViewModel>(jsonResponse);
                    orderMagentoViewModels = listOrdersViewModel.items;
                }
                return orderMagentoViewModels;
            }
            catch (Exception e)
            {
                return null;
            }

        }
        #region synchronize with magento 
        /// <summary>
        /// Synchronize with Ecommerce 
        /// </summary>
        /// <param name="listidItem"></param>
        /// <returns></returns>
        public async Task<string> SynchronizeWithEcommerce(List<int> listidItem)
        {
            string path = @"Logs\Ecommerce\";
            StringBuilder sb = new StringBuilder();
            int year = DateTime.Now.Year;
            string monthName = MonthsEnumerator.GetMonthName(DateTime.Now.Month);
            string jsonPicture = "";
            try
            {
                string json = "[{'product':";
                int numberOfItem = NumberConstant.Zero;
                foreach (var idItem in listidItem)
                {
                    json += PreparationBodyForEcommerce(idItem);
                    jsonPicture += PreparePictureBodyForEcommerce(idItem);
                    jsonPicture = jsonPicture.Replace("'", "\"");
                    jsonPicture = jsonPicture.Replace("/\"", "'");
                    numberOfItem++;
                    if (listidItem.Count > NumberConstant.One && numberOfItem != listidItem.Count)
                    {
                        json += "{'product':";
                    }
                }
                json = json.Remove(json.Length - 1);
                json += "]";
                json = json.Replace("'", "\"");
                json = json.Replace("/\"", "'");

                //Synchronize Product
                var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
                Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddProductsUrl);
                string responseString = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, json, null);
                //Synchronized Picture 
                Uri PictureUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddPictureForProduct);
                string response = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, jsonPicture, null);

                GenericLogger.GenericLog(Constants.ECOMMERCE_SYNCHRONIZE_FILE_NAME, LogEventLevel.Information, new Type[]
                { typeof(Exception), typeof(string) }, new object[] { null, Constants.SENDING_PRODUCTS_TO_SYNCHRONIZE + json + sb.AppendLine("") }, path + @"Synchronized_Product\" + year + @"\" + monthName);

                return responseString;
            }
            catch (Exception e)
            {
                GenericLogger.GenericLog(Constants.ECOMMERCE_SYNCHRONIZE_FILE_NAME, LogEventLevel.Error, new Type[]
               { typeof(Exception), typeof(string) }, new object[] { Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG + sb.AppendLine(""), e }, path + @"Not_Synchronized_Product\" + year + @"\" + monthName);

                throw new CustomException(CustomStatusCode.EcommerceException, e);
            }
        }
        /// <summary>
        /// prepare body for product Ecommerce 
        /// </summary>
        /// <param name="idItem"></param>
        /// <returns></returns>
        public string PreparationBodyForEcommerce(int idItem)
        {
            ItemViewModel item = _serviceItem.GetModelWithRelationsAsNoTracked(y => y.Id == idItem, y => y.IdFamilyNavigation, y => y.IdSubFamilyNavigation);
            item.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Pended;
            _serviceItem.UpdateModelWithoutTransaction(item, null, null);
            var idFamily = item.IdFamilyNavigation != null ? item.IdFamilyNavigation.IdCategoryEcommerce : 2;
            var idSubFamily = item.IdSubFamilyNavigation != null ? item.IdSubFamilyNavigation.IdSubCategoryEcommerce : 4;
            string unitHtsalePrice = item.UnitHtsalePrice.ToString();
            string name = item.Description + " " + item.Code;
            unitHtsalePrice = unitHtsalePrice.Replace(",", ".");
            item.Description = item.Description.Replace("'", "/'");
            item.Code = item.Code.Replace("'", "/'");
            name = name.Replace("'", "/'");
            return
                     "{'sku':" + "'" + item.Code + "'" + "," +
                     "'name':" + "'" + name + "'" + ", " +
                     "'attribute_set_id': 4," +
                     "'price':" + unitHtsalePrice + "," +
                     "'status': 1," +
                     "'visibility': 4," +
                     "'type_id': 'simple'," +
                     "'weight': '0.5'," +
                     "'extension_attributes':{" +
                       "'category_links': [" +
                       " {" +
                        "'position': 0," +
                       "'category_id':" + "'" + idFamily + "'" +
                        "}," +
                        " {" +
                        "'position': 1," +
                        "'category_id':" + "'" + idSubFamily + "'" +
                        "}" +
                        " ]" +
                      "}," +
                "'custom_attributes':[" +
                      "{" +
                      "'attribute_code': 'description'," +
                       "'value':" + "'" + item.Description + "'" +
                       "}," +
                       "{" +
                     "'attribute_code': 'short_description'," +
                      "'value':" + "'" + item.Description + "'" +
                       "}" +
                       "]" +
                       "}" +
                       "},";
        }
        /// <summary>
        /// receive response from magento 
        /// </summary>
        /// <returns></returns>
        public void MagentoResponseData(ResponseSynchronizedProductViewModel responseSynchronizedProduct)
        {
            StringBuilder sb = new StringBuilder();
            string path = @"Logs\Ecommerce\";
            int year = DateTime.Now.Year;
            string monthName = MonthsEnumerator.GetMonthName(DateTime.Now.Month);
            List<ItemViewModel> listerrorProduct = new List<ItemViewModel>();
            List<ItemViewModel> listsuccessProduct = new List<ItemViewModel>();
            List<ItemWarehouseViewModel> listItemWarehouse = new List<ItemWarehouseViewModel>();
            if (responseSynchronizedProduct.ListOfError.Any())
            {
                foreach (ErrorResponseViewModel errorProduct in responseSynchronizedProduct.ListOfError)
                {
                    ItemViewModel productItem = _serviceItem.GetModelAsNoTracked(x => x.Code == errorProduct.sku);
                    productItem.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.ErrorToPutOnline;
                    productItem.LastUpdateEcommerce = DateTime.UtcNow;
                    productItem.IsEcommerce = false;
                    AddTriggerLog(productItem.Id, errorProduct.message);
                    listerrorProduct.Add(productItem);
                }
                _serviceItem.BulkUpdateModelWithoutTransaction(listerrorProduct, null);
                GenericLogger.GenericLog(Constants.ECOMMERCE_SYNCHRONIZE_FILE_NAME, LogEventLevel.Information, new Type[]
               { typeof(Exception), typeof(string) }, new object[] { null, Constants.RECEIVING_ECOMMERCE_RESPONSE + responseSynchronizedProduct.keyvalue + sb.AppendLine("") }, path + @"Error_Synchronized_With_Magento\" + year + @"\" + monthName);
            }
            if (responseSynchronizedProduct.ListOfSuccess.Any())
            {
                foreach (SuccessResponseViewModel successProduct in responseSynchronizedProduct.ListOfSuccess)
                {
                    ItemViewModel productItem = _serviceItem.GetModelAsNoTracked(x => x.Code == successProduct.sku);
                    productItem.IsEcommerce = true;
                    productItem.LastUpdateEcommerce = DateTime.UtcNow;
                    //update status of item 
                    productItem.OnlineSynchonizationStatus = (int)ItemOnlineSynchronizationWithEcommerceStatusEnumerator.Succeed;
                    productItem.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed;
                    listsuccessProduct.Add(productItem);
                }
                _serviceItem.BulkUpdateModelWithoutTransaction(listsuccessProduct, null);
                GenericLogger.GenericLog(Constants.ECOMMERCE_SYNCHRONIZE_FILE_NAME, LogEventLevel.Information, new Type[]
                { typeof(Exception), typeof(string) }, new object[] { null, Constants.RECEIVING_ECOMMERCE_RESPONSE + responseSynchronizedProduct.keyvalue + sb.AppendLine("") }, path + @"Success_Synchronized_With_Magento\" + year + @"\" + monthName);
            }

        }
        /// <summary>
        /// Add partial shipment 
        /// </summary>
        /// <param name="idInvoiceDocument"></param>
        /// <returns></returns>
        public async Task<string> AddPartialShipment(List<int> listIdDocumentLine, int idInvoiceDocument)
        {
            List<DocumentLineViewModel> listDocumentLine = new List<DocumentLineViewModel>();
            listIdDocumentLine.ForEach(y =>
            {
                DocumentLineViewModel documentLine = _entityDocumentLine.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == y)
                    .Include(x => x.IdItemNavigation)
                   .Select(_documentLineBuilder.BuildEntity).FirstOrDefault();
                listDocumentLine.Add(documentLine);
            }
            );
            string json = "{'items': [";
            List<StockQuantityViewModel> listProductForShipment = new List<StockQuantityViewModel>();
            listDocumentLine.ForEach(x =>
            {
                // Controle of Available qte
                StockQuantityViewModel productViewModel = new StockQuantityViewModel
                {
                    sku = x.IdItemNavigation.Code,
                    qty = x.MovementQty
                };
                listProductForShipment.Add(productViewModel);

            });
            json += listProductForShipment;
            json += "]}";
            string jsonContent = JsonConvert.SerializeObject(json);
            string monthName = MonthsEnumerator.GetMonthName(DateTime.Now.Month);
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return null;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddPartialShipment + idInvoiceDocument);

            string responseString = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, json, null);
            return responseString;
        }
        /// <summary>
        /// Add total shipment 
        /// </summary>
        /// <param name="idInvoiceDocument"></param>
        /// <returns></returns>
        public async Task AddTotalShipment(DocumentViewModel document)
        {
            // update document
            _serviceDocument.SetDocumentDelivered(document.Id, true, null);
            //send response to magento 
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddPartialShipment + document.IdInvoiceEcommerce);

            await GetHttpResponseFromRequest(HttpMethod.Post, myUri, null, null);

        }
        /// <summary>
        /// Add Invoice
        /// </summary>
        /// <param name="idOrderDocument"></param>
        /// <returns></returns>
        public async Task AddInvoice(DocumentViewModel document)
        {

            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddInvoice + document.IdInvoiceEcommerce);
            await GetHttpResponseFromRequest(HttpMethod.Post, myUri, null, null);

        }
        /// <summary>
        /// add Trigger Log 
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="message"></param>
        public void AddTriggerLog(int idItem, string message)
        {
            TriggerItemLogViewModel triggerItemLogViewModel = new TriggerItemLogViewModel
            {
                IdItem = idItem,
                Code = "500",
                Message = message,
                DateLog = DateTime.UtcNow
            };
            _serviceTriggerItemLog.AddModelWithoutTransaction(triggerItemLogViewModel, null, null);
        }
        /// <summary>
        /// Prepare Response Error Synchronized Order from magento 
        /// </summary>
        /// <param name="idInvoiceEcommerce"></param>
        /// <param name="isSended"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        public string PrepareResponseErrorSynchronizedOrder(int idInvoiceEcommerce, int isSended, string message)
        {

            ResponseErrorSynchronizedOrderViewModel responseSynchronizedOrderViewModel = new ResponseErrorSynchronizedOrderViewModel
            {
                id = idInvoiceEcommerce,
                is_sended = isSended,
                error_msg = message,
            };
            return JsonConvert.SerializeObject(responseSynchronizedOrderViewModel);

        }
        /// <summary>
        /// Prepare Response Success Synchronized Order from magento
        /// </summary>
        /// <param name="idInvoiceEcommerce"></param>
        /// <param name="isSended"></param>
        /// <returns></returns>
        public string PrepareResponseSuccessSynchronizedOrder(int idInvoiceEcommerce, int isSended)
        {
            ResponseSynchronizedOrderViewModel responseErrorSynchronizedOrderViewModel = new ResponseSynchronizedOrderViewModel
            {
                id = idInvoiceEcommerce,
                is_sended = isSended,
            };
            return JsonConvert.SerializeObject(responseErrorSynchronizedOrderViewModel);
        }
        public string PreparePictureBodyForEcommerce(int idItem)
        {
            byte[] dataPicture = null;
            string base64Picture = "";
            //Get Picture Byte 
            if (string.IsNullOrEmpty(_appSettings.UploadFilePath))
            {
                return null;
            }
            ItemViewModel item = _serviceItem.GetModelAsNoTracked(y => y.Id == idItem);
            if (item.UrlPicture != null)
            {
                FileInfoViewModel picture = GetFilesContent(item.UrlPicture).FirstOrDefault();
                dataPicture = picture.Data;
                base64Picture = Convert.ToBase64String(picture.Data);
                string type = "image" + picture.Extension.Replace(".", "/");
                string disabled = "false";
                string json = "[{'product':";
                return
                                   json + "{'sku':" + "'" + item.Code + "'" + "," +
                                      "'media_gallery_entries': [" +
                                      " {" +
                                       "'media_type': 'image'," +
                                       "'label': 'Image'," +
                                        "'position': 0," +
                                         "'disabled':" + disabled + "," +
                                         "'types':[" +
                                         "'image'," +
                                         "'small_image'," +
                                          "'thumbnail'" +
                                          "]," +
                                           "'content':{" +
                                            "'base64_encoded_data':" + "'" + base64Picture + "'" + "," +
                                            "'type':" + "'" + type + "'" + "," +
                                            "'name':" + "'" + picture.Name + "'"
                                            + "}}]}}]";
            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// Add Category From Magento
        /// </summary>
        /// <param name="idOrderDocument"></param>
        /// <returns></returns>
        public async Task AddCategoryFromMagento(FamilyViewModel familyModel)
        {
            CategoryViewModel categoryViewModel = new CategoryViewModel();
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            string isActive = "true";
            string json = "{'category': {" +
                             "'name':" + "'" + familyModel.Code + "'" + "," +
                             "'parent_id':" + 2 + "," +
                             "'is_active':" + isActive + "}}";
            json = json.Replace("'", "\"");
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddCategory);
            string response = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, json, null);
            categoryViewModel = JsonConvert.DeserializeObject<CategoryViewModel>(response);
            //add idCategoryEcommerce to family model
            familyModel.IdCategoryEcommerce = categoryViewModel.id;
            _serviceFamily.UpdateModelWithoutTransaction(familyModel, null, null);
        }
        /// <summary>
        /// Update Category From Magento
        /// </summary>
        /// <param name="idOrderDocument"></param>
        /// <returns></returns>
        public async Task UpdateCategoryFromMagento(FamilyViewModel categoryModel)
        {

            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            string isActive = "false";
            string json = "{'category': {" +
                             "'is_active':" + isActive + "}}";
            json = json.Replace("'", "\"");
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.UpdateCategory + categoryModel.IdCategoryEcommerce);
            string response = await GetHttpResponseFromRequest(HttpMethod.Put, myUri, json, null);

        }
        /// <summary>
        /// Synchronize sub Category From Magento
        /// </summary>
        /// <param name="idOrderDocument"></param>
        /// <returns></returns>
        public async Task AddSubCategoryFromMagento(SubFamilyViewModel familySubModel)
        {
            CategoryViewModel categoryViewModel = new CategoryViewModel();
            //get IdEcommerce parent 
            FamilyViewModel familyModel = _serviceFamily.GetModelAsNoTracked(x => x.Id == familySubModel.IdFamily);
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            string isActive = "true";
            string json = "{'category': {" +
                             "'name':" + "'" + familySubModel.Code + "'" + "," +
                             "'parent_id':" + "'" + familyModel.IdCategoryEcommerce + "'" + "," +
                             "'is_active':" + isActive + "}}";
            json = json.Replace("'", "\"");
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.AddCategory);
            string response = await GetHttpResponseFromRequest(HttpMethod.Post, myUri, json, null);
            categoryViewModel = JsonConvert.DeserializeObject<CategoryViewModel>(response);
            //add idCategoryEcommerce to Subfamily model
            familySubModel.IdSubCategoryEcommerce = categoryViewModel.id;
            _serviceSubFamily.UpdateModelWithoutTransaction(familySubModel, null, null);
        }
        /// <summary>
        /// Update Sub Category From Magento
        /// </summary>
        /// <param name="idOrderDocument"></param>
        /// <returns></returns>
        public async Task UpdateSubCategoryFromMagento(SubFamilyViewModel familySubModel)
        {
            FamilyViewModel familyModel = _serviceFamily.GetModelAsNoTracked(x => x.Id == familySubModel.IdFamily);
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return;
            }
            string isActive = "false";
            string json = "{'category': {" +
                             "'is_active':" + isActive + "}}";
            json = json.Replace("'", "\"");
            var baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.UpdateCategory + familySubModel.IdSubCategoryEcommerce);
            string response = await GetHttpResponseFromRequest(HttpMethod.Put, myUri, json, null);

        }

        #endregion

    }


}
