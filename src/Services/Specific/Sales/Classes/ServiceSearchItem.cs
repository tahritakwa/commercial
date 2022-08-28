using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceSearchItem : Service<SearchItemViewModel, SearchItem>, IServiceSearchItem
    {

        private readonly IUserBuilder _userBuilder;
        private readonly IServiceDocument _serviceDocument;
        private readonly IRepository<Document> _entityRepoDocument;
        private readonly IServiceTiers _serviceTiers;
        private readonly IRepository<Warehouse> _entityWarehouseRepo;
        public readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        public readonly IServiceDeliveryType _serviceDeliveryType;
        private readonly IRepository<Item> _entityRepoItem;
        private readonly IRepository<StockDocumentLine> _entityStockDocumentLineRepo;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceUser _serviceUser;
        public ServiceSearchItem(IRepository<SearchItem> entityRepo, IUnitOfWork unitOfWork,
            ISearchItemBuilder entityBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IUserBuilder userBuilder, IServiceDocument serviceDocument, IRepository<Item> entityRepoItem,
            IRepository<Warehouse> entityWarehouseRepo,
            IServiceTiers serviceTiers,
            IRepository<Document> entityRepoDocument,
            IRepository<DocumentType> entityDocumentTypeRepo
            , IServiceDeliveryType serviceDeliveryType,
            IRepository<StockDocumentLine> entityStockDocumentLineRepo, IServiceUser serviceUser, IServiceCompany serviceCompany)
              : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _userBuilder = userBuilder;
            _serviceDocument = serviceDocument;
            _entityWarehouseRepo = entityWarehouseRepo;
            _serviceTiers = serviceTiers;
            _entityRepoDocument = entityRepoDocument;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _serviceDeliveryType = serviceDeliveryType;
            _entityRepoItem = entityRepoItem;
            _entityStockDocumentLineRepo = entityStockDocumentLineRepo;
            _serviceUser = serviceUser;
            _serviceCompany = serviceCompany;
        }

        public void AddSearch(SearchItemObjectToSaveViewModel searchItemSupplierViewModel, string userMail)
        {
            var valuesToConvert = searchItemSupplierViewModel.SearchItemSupplierViewModel.GetType().GetProperties()
.Where(pi => pi.GetValue(searchItemSupplierViewModel.SearchItemSupplierViewModel) is string ||
(pi.GetValue(searchItemSupplierViewModel.SearchItemSupplierViewModel) is int && (int)pi.GetValue(searchItemSupplierViewModel.SearchItemSupplierViewModel) > 0))

.Select((pi) => new PropertyNameAndValue
{
    property = pi.Name,
    value = pi.GetValue(searchItemSupplierViewModel.SearchItemSupplierViewModel).ToString()
});

            string searchItemSupplierJsonObject = JsonConvert.SerializeObject(valuesToConvert);
            int iduser = _serviceUser.FindModelBy(x => x.Email == userMail).FirstOrDefault().Id;
            SearchItemViewModel searchItemViewModel = new SearchItemViewModel
            {
                Id = 0,
                IdTiers = searchItemSupplierViewModel.IdTiers,
                IdCashier = searchItemSupplierViewModel.IdCashier,
                SearchMethod = searchItemSupplierJsonObject,
                Date = DateTime.Now,
                IsDeleted = false
            };
            if (iduser != null)
            {
                searchItemViewModel.IdCashier = iduser;
            }
            AddModel(searchItemViewModel, null, userMail);
        }

        public List<ReducedTiersViewModel> GetSearchedSuppliers(PredicateFormatViewModel predicateFormatViewModel, out int total)
        {
            PredicateFilterRelationViewModel<SearchItem> predicateFilterRelationModel = PreparePredicate(predicateFormatViewModel);
            var searchList = _entityRepo.QuerableGetAll().Include(x => x.IdTiersNavigation).Where(predicateFilterRelationModel.PredicateWhere).Select(x => new ReducedTiersViewModel
            {
                Id = x.IdTiersNavigation.Id,
                IdCurrency = x.IdTiersNavigation.IdCurrency,
                Name = x.IdTiersNavigation.Name,
                CodeTiers = x.IdTiersNavigation.CodeTiers,
            }).Distinct().OrderByDescending(x => x.Id);
            total = searchList.Count();
            return searchList
                  .Skip(predicateFormatViewModel.page).Take(predicateFormatViewModel.pageSize).ToList();
        }
        public List<SearchItemObjectToSaveViewModel> GetSerachDetailPeerSupplier(PredicateFormatViewModel predicateFormatViewModel, out int total)
        {
            PredicateFilterRelationViewModel<SearchItem> predicateFilterRelationModel = PreparePredicate(predicateFormatViewModel);
            var searchList = _entityRepo.QuerableGetAll().Include(x => x.IdCashierNavigation).Include(x => x.IdTiersNavigation).Where(predicateFilterRelationModel.PredicateWhere)
                .Select(x => new SearchItemObjectToSaveViewModel
                {
                    Id = x.Id,
                    IdCashierNavigation = _userBuilder.BuildEntity(x.IdCashierNavigation),
                    IdTiers = x.IdTiers,
                    IdCashier = x.IdCashier,
                    Date = x.Date,
                    selectedMethod = x.SearchMethod,
                    TiersName = x.IdTiersNavigation.Name
                }).OrderByDescending(x => x.Id);
            total = searchList.Count();
            var listsearch = searchList.Skip(predicateFormatViewModel.page).Take(predicateFormatViewModel.pageSize).ToList();
            foreach (var itemSearch in listsearch)
            {
                var serelizedData = JsonConvert.DeserializeObject<List<PropertyNameAndValue>>(itemSearch.selectedMethod);
                if (serelizedData.Count > 0)
                {
                    itemSearch.SearchItemSupplierList = serelizedData;
                }
            }
            return listsearch;
        }
        public CreatedDataViewModel GenerateDocument(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel, string userMail)
        {
            try
            {
                BeginTransaction();
                Item item = _entityRepoItem.GetSingleWithRelationsNotTracked(x => x.Id == searchItemToGenerateDocViewModel.IdItem, x => x.IdUnitSalesNavigation, z => z.IdUnitStockNavigation, z => z.IdNatureNavigation);
                var forSales = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.CodeType == searchItemToGenerateDocViewModel.DocumentTypeCode).IsSaleDocumentType;
                if (item.IdNatureNavigation.IsStockManaged)
                {
                    string[] nombre1;
                    if (searchItemToGenerateDocViewModel.QuantityForDocumentLine > Int64.MaxValue)
                    {
                        System.Numerics.BigInteger number = (System.Numerics.BigInteger)searchItemToGenerateDocViewModel.QuantityForDocumentLine;
                        nombre1 = number.ToString().Split(',');
                    }
                    else
                    {
                        nombre1 = searchItemToGenerateDocViewModel.QuantityForDocumentLine.ToString().Split(',');
                    }
                    int length1;
                    if (nombre1.Length == 2)
                    {
                        length1 = nombre1[1].Length;
                    }
                    else
                    {
                        length1 = 0;
                    }
                    if (forSales)
                    {
                        if (item.IdUnitSalesNavigation != null && length1 > item.IdUnitSalesNavigation.DigitsAfterComma)
                        {
                            throw new CustomException(CustomStatusCode.WrongQty);
                        }
                    }
                    else
                    {
                        if (item.IdUnitStockNavigation != null && length1 > item.IdUnitStockNavigation.DigitsAfterComma)
                        {
                            throw new CustomException(CustomStatusCode.WrongQty);
                        }
                    }
                }
                if (searchItemToGenerateDocViewModel.IdTiers == null)
                {
                    throw new CustomException(CustomStatusCode.ClientRquiredError);
                }
                var tiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == searchItemToGenerateDocViewModel.IdTiers);
                DocumentViewModel document = new DocumentViewModel
                {
                    DocumentOtherTaxesWithCurrency = 0,
                    DocumentHtpriceWithCurrency = 0,
                    DocumentTotalVatTaxesWithCurrency = 0,
                    DocumentTtcpriceWithCurrency = 0,
                    DocumentTotalDiscountWithCurrency = 0,
                    DocumentPriceIncludeVatWithCurrency = 0,
                    DocumentTotalExcVatTaxesWithCurrency = 0,
                    DocumentDate = DateTime.Now,
                    CreationDate = DateTime.Now,
                    IdDeliveryType = _serviceDeliveryType.GetModel(x => x.Code == "002").Id,
                    DocumentTypeCode = searchItemToGenerateDocViewModel.DocumentTypeCode,
                    IdTiers = tiers.Id,
                    IdUsedCurrency = tiers.IdCurrency,
                    DocumentOtherTaxes = 0,
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    IsGenerated = true,
                    UserMail = userMail,
                    DocumentLine = new List<DocumentLineViewModel>()
                };
                if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                {
                    if(searchItemToGenerateDocViewModel.IdVehicle != null)
                    {
                        document.IdVehicle = searchItemToGenerateDocViewModel.IdVehicle;
                    }
                    document.IsTermBilling = true;
                    if (tiers.IdDeliveryType != null)
                    {
                        document.IdDeliveryType = tiers.IdDeliveryType;
                    }
                }
                var createdData = _serviceDocument.AddDocumentWithoutTransactionInRealTime(null, document, null, null);
                _unitOfWork.Commit();
                searchItemToGenerateDocViewModel.IdDocument = createdData.Id;
                EndTransaction();
                return createdData;
            }
#pragma warning disable CS0168 // The variable 'e' is declared but never used
            catch (CustomException e)
#pragma warning restore CS0168 // The variable 'e' is declared but never used
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }

        }
        private ItemPriceViewModel GenerateDocumentLineFromIem(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == searchItemToGenerateDocViewModel.DocumentTypeCode);
            ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
            {
                DocumentDate = DateTime.Now,
                IdCurrency = searchItemToGenerateDocViewModel.IdUsedCurrency ?? 0,
                IdTiers = searchItemToGenerateDocViewModel.IdTiers ?? 0,
                DocumentType = searchItemToGenerateDocViewModel.DocumentTypeCode,
                DocumentLineViewModel = new DocumentLineViewModel
                {
                    IdDocument = searchItemToGenerateDocViewModel.IdDocument ?? 0,
                    IsValidReservationFromProvisionalStock = searchItemToGenerateDocViewModel.IsValidReservationFromProvisionalStock,
                    IdItem = searchItemToGenerateDocViewModel.IdItem,
                    MovementQty = searchItemToGenerateDocViewModel.QuantityForDocumentLine,
                    DiscountPercentage = 0,
                    IdWarehouse = searchItemToGenerateDocViewModel.IdWarehouse,
                    IdDocumentLineStatus = searchItemToGenerateDocViewModel.IdDocumentStatus,
                    CodeDocumentLine = ""
                }
            };
            return itemPriceViewModel;
        }

        public void AddItemToDocument(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            insertDocumentLineWithTranscation(searchItemToGenerateDocViewModel);
        }

        private void insertDocumentLineWithTranscation(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            try
            {
                BeginTransactionunReadUncommitted();
                InsertDocumentLineWithoutTranscation(searchItemToGenerateDocViewModel);
                EndTransaction();
            }
            catch (Exception)
            {
                TryRollbackTransaction();
                throw;
            }
        }
        private void InsertDocumentLineWithoutTranscation(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            Document document = _entityRepoDocument.GetSingleWithRelationsNotTracked(x => x.Id == searchItemToGenerateDocViewModel.IdDocument, r => r.IdTiersNavigation);
            if(document == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            Item item = _entityRepoItem.GetSingleWithRelationsNotTracked(x => x.Id == searchItemToGenerateDocViewModel.IdItem, x => x.IdUnitSalesNavigation, z => z.IdUnitStockNavigation, z => z.IdNatureNavigation, x => x.TaxeItem, x => x.ItemWarehouse, x => x.ItemSalesPrice);
            var documentType = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.CodeType == document.DocumentTypeCode);
            var itemPrice = GenerateDocumentLineFromIem(searchItemToGenerateDocViewModel);
            int precisionTierValues = _serviceDocument.GetPrecissionValue((int)document.IdUsedCurrency, document.DocumentTypeCode);
            if (searchItemToGenerateDocViewModel.DocumentTypeCode == DocumentEnumerator.PurchaseOrder || searchItemToGenerateDocViewModel.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder
                    || searchItemToGenerateDocViewModel.DocumentTypeCode == DocumentEnumerator.PurchaseAsset || searchItemToGenerateDocViewModel.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice)
            {
                ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel
                {
                    DocumentLineViewModel = new DocumentLineViewModel { IdItem = searchItemToGenerateDocViewModel.IdItem },
                    IdTiers = searchItemToGenerateDocViewModel.IdTiers.Value
                };
                _serviceDocument.CheckItemTierRelation(itemPricesViewModel);
            }

            if (item.IdNatureNavigation.IsStockManaged)
            {
                string[] nombre1;
                if (searchItemToGenerateDocViewModel.QuantityForDocumentLine > Int64.MaxValue)
                {
                    System.Numerics.BigInteger number = (System.Numerics.BigInteger)searchItemToGenerateDocViewModel.QuantityForDocumentLine;
                    nombre1 = number.ToString(CultureInfo.InvariantCulture).Split('.');
                }
                else
                {
                    nombre1 = searchItemToGenerateDocViewModel.QuantityForDocumentLine.ToString(CultureInfo.InvariantCulture).Split('.');
                }
                int length1;
                if (nombre1.Length == 2)
                {
                    length1 = nombre1[1].Length;
                }
                else
                {
                    length1 = 0;
                }
                if (documentType.IsSaleDocumentType)
                {
                    if (item.IdUnitSalesNavigation != null && !item.IdUnitSalesNavigation.IsDecomposable && length1 > item.IdUnitSalesNavigation.DigitsAfterComma)
                    {
                        throw new CustomException(CustomStatusCode.WrongQty);
                    }
                }
                else
                {
                    if (item.IdUnitStockNavigation != null && !item.IdUnitStockNavigation.IsDecomposable && length1 > item.IdUnitStockNavigation.DigitsAfterComma)
                    {
                        throw new CustomException(CustomStatusCode.WrongQty);
                    }
                }
            }
            if (document.DocumentTypeCode == DocumentEnumerator.BE)
            {
                IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == item.Id &&
                  x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                  && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                  && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSourceNavigation.IsCentral));
                if (inventaireList.Any())
                {
                    throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                }
            }
            if ((document.DocumentTypeCode == DocumentEnumerator.BS || document.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                (document.DocumentTypeCode == DocumentEnumerator.SalesAsset && document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)) && item.ProvInventory)
            {
                IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == item.Id &&
                 x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                 && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                 && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSource == searchItemToGenerateDocViewModel.IdWarehouse));
                if (inventaireList.Any())
                {
                    throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                }
            }

            searchItemToGenerateDocViewModel.IdUsedCurrency = document.IdUsedCurrency ?? 0;
            searchItemToGenerateDocViewModel.IdTiers = document.IdTiers;
            searchItemToGenerateDocViewModel.IdDocumentStatus = document.IdDocumentStatus;
            searchItemToGenerateDocViewModel.DocumentTypeCode = document.DocumentTypeCode;
            searchItemToGenerateDocViewModel.IsRestaurn = (bool)document.IsRestaurn;

            itemPrice.Tiers = document.IdTiersNavigation;
            itemPrice.Document = document;
            itemPrice.DocumentTypeObject = documentType;
            itemPrice.TiersPrecison = precisionTierValues;
            itemPrice.Item = item;

            var documentLineViewModel = _serviceDocument.GetItemPrice(itemPrice);
            documentLineViewModel.DocumentLineTaxe = null;
            documentLineViewModel.Taxe = null;
            documentLineViewModel.IdDocument = searchItemToGenerateDocViewModel.IdDocument ?? 0;
            itemPrice.DocumentLineViewModel = documentLineViewModel;
            if (document.DocumentTypeCode == DocumentEnumerator.BS)
            {
                _serviceDocument.InsertUpdateBSDocumentLineWithoutTransaction(itemPrice);
                // the calculate of document is already exist in InsertUpdateBSDocumentLineWithoutTransaction
            }
            else
            {
                _serviceDocument.InsertUpdateDocumentLineWithoutTransaction(itemPrice, null);
                DocumentViewModel documentViewModel = _serviceDocument.UpdateDocumentAmountsWithoutTransaction(searchItemToGenerateDocViewModel.IdDocument ?? 0, null);
                if (document.IdTiers.HasValue && document.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                      && (document.IdTiersNavigation.AuthorizedAmountInvoice != null)
                      && (_serviceTiers.CalculateTotalAmountOfSalesDelivery(document.IdTiers.Value)
                      + documentViewModel.DocumentTtcpriceWithCurrency) >
                      ((document.IdTiersNavigation.AuthorizedAmountInvoice ?? 0) + (document.IdTiersNavigation.ProvisionalAuthorizedAmountDelivery ?? 0)))
                {
                    throw new CustomException(CustomStatusCode.AuthorizedAmountExceeded);
                }
            }
        }

        public TiersDetailsViewModel TiersDetails(int idTiers)
        {
            CurrencyViewModel currency = _serviceTiers.GetModelWithRelations(x => x.Id == idTiers, x => x.IdCurrencyNavigation).IdCurrencyNavigation;
            int currentMonth = DateTime.Now.Month;
            var tierViewModel = _serviceTiers.GetModelById(idTiers);
            TiersDetailsViewModel tiersDetailsViewModel = new TiersDetailsViewModel
            {
                /*BL valide non facturé */
                ValidBlNotInvoiced = _entityRepoDocument.QuerableGetAll().Where(x => x.IdTiers == idTiers && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid && x.IdDocumentAssociated == null
               && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.DocumentDate.Month == currentMonth).Sum(x => x.DocumentTtcpriceWithCurrency) ?? 0,

                /*chiffer d'affaire facturé*/
                Turnover = _entityRepoDocument.QuerableGetAll().Where(x => x.IdTiers == idTiers && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional
                && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice).Sum(x => x.DocumentTtcpriceWithCurrency) ?? 0,

                /*impée*/
                ImpaidTotal = (_entityRepoDocument.QuerableGetAll().Where(x => x.IdTiers == idTiers && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)).Sum(x => x.DocumentRemainingAmountWithCurrency) ?? 0)
                - (_entityRepoDocument.QuerableGetAll().Where(x => x.IdTiers == idTiers && x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset
                && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional).Sum(x => x.DocumentRemainingAmountWithCurrency) ?? 0),

                /*seuil*/
                MaxThreshold = (tierViewModel.AuthorizedAmountInvoice ?? 0) + (tierViewModel.ProvisionalAuthorizedAmountDelivery ?? 0),

                currencyCode = currency.Code,
                currencyPrecision = currency.Precision
            };
            tiersDetailsViewModel.isGratherThan = tiersDetailsViewModel.ImpaidTotal > tiersDetailsViewModel.MaxThreshold;
            return tiersDetailsViewModel;
        }

        public bool CheckRealAndProvisionalStock(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            ItemPriceViewModel itemPrice;

            if (searchItemToGenerateDocViewModel.DocumentTypeCode != DocumentEnumerator.SalesDelivery)
            {
                return false;
            }

            if (searchItemToGenerateDocViewModel.IdDocument > 0)
            {
                DocumentViewModel document = _serviceDocument.GetModelAsNoTracked(x => x.Id == searchItemToGenerateDocViewModel.IdDocument, r => r.IdTiersNavigation);
                if(document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                searchItemToGenerateDocViewModel.IdUsedCurrency = document.IdUsedCurrency ?? 0;
                searchItemToGenerateDocViewModel.IdTiers = document.IdTiers;
                searchItemToGenerateDocViewModel.IdDocumentStatus = document.IdDocumentStatus;
                searchItemToGenerateDocViewModel.DocumentTypeCode = document.DocumentTypeCode;
                searchItemToGenerateDocViewModel.IsRestaurn = (bool)document.IsRestaurn;
                itemPrice = GenerateDocumentLineFromIem(searchItemToGenerateDocViewModel);
            }
            else
            {
                itemPrice = GenerateDocumentLineFromIem(searchItemToGenerateDocViewModel);
            }
            return _serviceDocument.IsProvisionalStock(itemPrice);
        }
        public bool IsValidDocument(int idDocument)
        {
            BeginTransactionunReadUncommitted();
            Document doc = _entityRepoDocument.GetSingle(x => x.Id == idDocument);
            bool result = false;
            if(doc == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            result = doc.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid;
            EndTransaction();
            return result;
        }
    }
}
