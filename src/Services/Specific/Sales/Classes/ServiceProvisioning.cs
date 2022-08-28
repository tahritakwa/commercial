using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceProvisioning : Service<ProvisioningViewModel, Provisioning>, IServiceProvisioning
    {


        private readonly IRepository<Item> _entityRepoItem;
        private readonly IRepository<TiersProvisioning> _entityTiersProvision;
        private readonly IRepository<ProvisioningDetails> _entityProvisionDetail;
        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IServiceProvisioningDetails _serviceProvisioningDetails;
        private readonly IServiceTiersProvisioning _serviceTiersProvisioning;
        private readonly IRepository<Currency> _entityRepoCurrency;
        private readonly IRepository<ProvisioningOption> _entityRepoProvisioningOption;
        private readonly IProvisioningOptionBuilder _provisioningOptionBuilder;
        private readonly ITiersProvisioningBuilder _tiersProvisioningBuilder;
        private readonly IServiceTiers _serviceTiers;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IProvisioningDetailsBuilder _provisioningDetailsBuilder;
        private readonly IItemBuilder _itemBuilder;
        private readonly IItemTiersBuilder _itemTiersBuilder;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceItem _serviceItem;
        private readonly ITiersBuilder _tiersBuilder;
        internal readonly IRepository<ItemKit> _entityRepoItemKit;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<Tiers> _entityRepoTiers;
        public ServiceProvisioning(IRepository<Provisioning> entityRepo,
           IUnitOfWork unitOfWork,

           IProvisioningBuilder builder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
           IRepository<Item> entityRepoItem,
           IServiceCodification serviceCodification,
            IRepository<DocumentLine> entityRepoDocumentLine,
            IServiceStockMovement serviceStockMovement,
            IRepository<Currency> entityRepoCurrency,
            IRepository<ProvisioningOption> entityRepoProvisioningOption,
             IProvisioningOptionBuilder provisioningOptionBuilder,
             IServiceProvisioningDetails serviceProvisioningDetails,
             IServiceTiersProvisioning serviceTiersProvisioning,
             IServiceTiers serviceTiers,
             ITiersProvisioningBuilder tiersProvisioningBuilder,
             IRepository<TiersProvisioning> entityTiersProvision,
             IRepository<ProvisioningDetails> entityProvisionDetail,
             IProvisioningDetailsBuilder provisioningDetailsBuilder,
             IServiceItemWarehouse serviceItemWarehouse,
             IItemBuilder itemBuilder,
             IServiceWarehouse serviceWarehouse,
             IRepository<ItemKit> entityRepoItemKit,
              ITiersBuilder tiersBuilder,
           IServiceDocument serviceDocument,
           IServiceItem serviceItem,
            IServiceDocumentLine serviceDocumentLine, IServiceCompany serviceCompany, IItemTiersBuilder itemTiersBuilder, IRepository<Tiers> entityRepoTiers) : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
               entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityRepoItem = entityRepoItem;
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _serviceStockMovement = serviceStockMovement;
            _entityRepoCurrency = entityRepoCurrency;
            _entityRepoProvisioningOption = entityRepoProvisioningOption;
            _provisioningOptionBuilder = provisioningOptionBuilder;
            _serviceProvisioningDetails = serviceProvisioningDetails;
            _serviceTiers = serviceTiers;
            _entityTiersProvision = entityTiersProvision;
            _tiersProvisioningBuilder = tiersProvisioningBuilder;
            _entityProvisionDetail = entityProvisionDetail;
            _provisioningDetailsBuilder = provisioningDetailsBuilder;
            _serviceItemWarehouse = serviceItemWarehouse;
            _itemBuilder = itemBuilder;
            _serviceWarehouse = serviceWarehouse;
            _serviceDocument = serviceDocument;
            _entityRepoItemKit = entityRepoItemKit;
            _tiersBuilder = tiersBuilder;
            _serviceItem = serviceItem;
            _serviceDocumentLine = serviceDocumentLine;
            _serviceTiersProvisioning = serviceTiersProvisioning;
            _serviceCompany = serviceCompany;
            _itemTiersBuilder = itemTiersBuilder;
            _entityRepoTiers = entityRepoTiers;
        }

        private void AddProvisiong(ProvisioningViewModel provisioning)
        {
            try
            {
                provisioning.CreationDate = DateTime.Now;
                provisioning.TiersProvisioning = new List<TiersProvisioningViewModel>();
                foreach (var idTier in provisioning.IdTiers)
                {
                    TiersProvisioningViewModel tiersProvision = new TiersProvisioningViewModel
                    {
                        IdTiers = idTier,
                        IdProvisioning = provisioning.Id,
                        Total = provisioning.ProvisioningDetails.Where(x => x.IdTiers == idTier).Sum(x => (x.LastePurchasePrice ?? 0) * x.MvtQty)
                    };
                    provisioning.TiersProvisioning.Add(tiersProvision);
                }
                if(provisioning.ProvisioningDetails.Any())
                {
                    provisioning.ProvisioningDetails.ToList().ForEach( x=> {
                        x.IdItemNavigation = null;
                    });
                }
                var createdData = AddModel(provisioning, null, null) as CreatedDataViewModel;
                provisioning.Id = createdData.Id;
                provisioning.Code = createdData.Code;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }


        public CreatedDataViewModel GenerateProvisioning(ProvisioningViewModel provisioning)
        {
            try
            {
                var filters = provisioning.IdProvisioningOptionNavigation;
                List<ItemViewModel> resultList = new List<ItemViewModel>();
                List<ItemViewModel> itemPurchase = new List<ItemViewModel>();
                List<ItemViewModel> itemSales = new List<ItemViewModel>();
                List<ItemViewModel> InventoryItem = new List<ItemViewModel>();
                if (filters.SearchByQty)
                {
                    var listInventoryItem = new List<Item>();
                    listInventoryItem = _entityRepoItem.QuerableGetAll().Include(f=>f.ItemTiers).ThenInclude(z => z.IdTiersNavigation).Include(c => c.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).Include(x=> x.IdNatureNavigation)
                                        .Where(x => x.ItemTiers.Any(tt => provisioning.IdTiers.Contains(tt.IdTiers)) && x.IdNatureNavigation.IsStockManaged && !x.OnOrder &&
                                        x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity) - ((x.AverageSalesPerDay ?? 0) * 1) <
                                        (x.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ? x.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0)).ToList();

                    InventoryItem = listInventoryItem.Select(
                        p => new ItemViewModel
                        {
                            Id = p.Id,
                            UnitHtpurchasePrice = p.UnitHtpurchasePrice,
                            UnitHtsalePrice=p.UnitHtsalePrice,
                            AllAvailableQuantity = p.ItemWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity),
                            AverageSalesPerDay = p.AverageSalesPerDay,
                            CentralMinQuantity = p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ? p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0,
                            //TiersDeleveryDelay = 5
                            ItemTiers= p.ItemTiers.Select(r=> _itemTiersBuilder.BuildEntity(r)).ToList()
                        }).ToList();
                    if(listInventoryItem.Where(x=> x.IdNatureNavigation.IsStockManaged && ((x.IsForSales == true  && x.IdUnitSales == null)||(x.IsForPurchase == true && x.IdUnitStock == null))).Any())
                    {
                        throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                    }
                    _serviceItemWarehouse.GetAllAvailbleQuantityFolAllItem(InventoryItem);
                }
                if (filters.SearchBySalesHistory)
                {
                    DateTime.TryParse(filters.SalesStartDate.Value.ToShortDateString(), out DateTime startDate);
                    DateTime.TryParse(filters.SalesEndDate.Value.ToShortDateString(), out DateTime endDate);



                    var documentLineSales = _entityRepoDocumentLine.QuerableGetAll().Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).
                        Include(y=> y.IdItemNavigation).ThenInclude(z=> z.ItemTiers).ThenInclude(x=> x.IdTiersNavigation)
                    .Include(x => x.IdDocumentNavigation)
                    .Where(x => x.IdItemNavigation.ItemTiers.Any(z => provisioning.IdTiers.Contains(z.IdTiers)) &&
                    !x.IdItemNavigation.OnOrder && x.IdItemNavigation.IdNatureNavigation.IsStockManaged && x.IdDocumentNavigation.DocumentDate >= startDate && x.IdDocumentNavigation.DocumentDate <= endDate &&
                   (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery)).ToList();


                    //docLines id 
                    var docIds = documentLineSales.Select(x => x.IdItem).ToList();

                    // all solded item Documents selected from BL ( BS , Avoir  , Bon Entree )
                    var soldedDocLines = _entityRepoDocumentLine.QuerableGetAll().Where(x => docIds.Contains(x.IdItem) && (
                     x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset ||
                       x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE));



                    itemSales = documentLineSales.Where(x => x.IdItemNavigation != null)
                        .GroupBy(x => x.IdItem).Select(
                        p => new ItemViewModel
                        {
                            Id = p.Key,
                            UnitHtpurchasePrice = p.First().IdItemNavigation.UnitHtpurchasePrice,
                            AllAvailableQuantity = p.First().IdItemNavigation.ItemWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity),
                            AverageSalesPerDay = p.First().IdItemNavigation.AverageSalesPerDay,
                            AllMovementQuantity = (p.Sum(x => x.MovementQty) +
                            soldedDocLines.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS && x.IdItem == p.Key).Sum(x => x.MovementQty)) - (
                            soldedDocLines.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset && x.IdItem == p.Key).Sum(x => x.MovementQty) +
                            soldedDocLines.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE && x.IdItem == p.Key).Sum(x => x.MovementQty)),
                            ItemTiers = p.First().IdItemNavigation.ItemTiers.ToList().Select(x=> _itemTiersBuilder.BuildEntity(x)).ToList(),

                            //TiersDeleveryDelay = 5,
                            CentralMinQuantity = p.First().IdItemNavigation.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ?
                            p.First().IdItemNavigation.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0,
                            CreatedByDocumentLine = true
                        }).ToList();
                    List<int> ids = itemSales.Select(p => p.Id).ToList();
                    if(documentLineSales.Where(p=> ids.Contains(p.IdItem) && p.IdMeasureUnit == null).Any())
                    {
                        throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                    }
                    resultList = itemSales;

                }
                if (filters.SearchByPurhaseHistory)
                {
                    DateTime.TryParse(filters.PucrahseStartDate.Value.ToShortDateString(), out DateTime startDate);
                    DateTime.TryParse(filters.PucrahseEndDate.Value.ToShortDateString(), out DateTime endDate);
                    List<DocumentLine> documentLinePurshase = new List<DocumentLine>();

                    documentLinePurshase = _entityRepoDocumentLine.QuerableGetAll().Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).
                        Include(y => y.IdItemNavigation).ThenInclude(z => z.ItemTiers).ThenInclude(x => x.IdTiersNavigation)
                     .Include(x => x.IdDocumentNavigation)
                     .Where(x => x.IdItemNavigation.ItemTiers.Any(z => provisioning.IdTiers.Contains(z.IdTiers)) &&
                     x.IdDocumentNavigation.DocumentDate >= startDate &&
                     !x.IdItemNavigation.OnOrder &&
                     x.IdItemNavigation.IdNatureNavigation.IsStockManaged &&
                     x.IdDocumentNavigation.DocumentDate <= endDate && 
                     provisioning.IdTiers.Contains((int)x.IdDocumentNavigation.IdTiers) &&
                     (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE)).ToList();


                    itemPurchase = documentLinePurshase.Where(x => x.IdItemNavigation != null)
                        .OrderBy(x => x.IdItem).GroupBy(x => x.IdItem).Select(p => new ItemViewModel
                        {
                            Id = p.First().IdItem,
                            UnitHtpurchasePrice = p.First().IdItemNavigation.UnitHtpurchasePrice,
                            AllAvailableQuantity = p.First().IdItemNavigation.ItemWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity),
                            AverageSalesPerDay = p.First().IdItemNavigation.AverageSalesPerDay,
                            AllMovementQuantity = p.Sum(x => x.MovementQty),
                            ItemTiers = p.First().IdItemNavigation.ItemTiers.Select(x => _itemTiersBuilder.BuildEntity(x)).ToList(),
                            //TiersDeleveryDelay = 5,
                            CentralMinQuantity = p.First().IdItemNavigation.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ?
                            p.First().IdItemNavigation.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0,
                            CreatedByDocumentLine = true
                        }).ToList();
                    List<int> ids = itemPurchase.Select(p => p.Id).ToList();
                    if (documentLinePurshase.Where(p => ids.Contains(p.IdItem) && p.IdMeasureUnit == null).Any())
                    {
                        throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                    }
                    resultList = itemPurchase;
                }
                if (filters.SearchByPurhaseHistory && filters.SearchBySalesHistory)
                {
                    resultList = itemSales.Union(itemPurchase).ToList();
                }

                resultList = AddMinMaxItems(filters, InventoryItem, resultList).Distinct(new EntityComparator<ItemViewModel>()).ToList();
                resultList = resultList.Union(GenerateNewReferencesList(provisioning)).Distinct(new EntityComparator<ItemViewModel>()).ToList();

                CalculatedQunatityToOrderd(resultList, provisioning);

                AddProvisiong(provisioning);
                return new CreatedDataViewModel { Id = provisioning.Id, EntityName = "PROVISIONING" };


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
        /// <summary>
        /// GenerateNewReferencesList
        /// </summary>
        /// <param name="provisioning"></param>
        /// <returns></returns>
        private List<ItemViewModel> GenerateNewReferencesList(ProvisioningViewModel provisioning)
        {
            var filters = provisioning.IdProvisioningOptionNavigation;
            List<ItemViewModel> newReferencesItem = new List<ItemViewModel>();
            List<ItemViewModel> result = new List<ItemViewModel>();
            
            if (filters.SearchByNewReferences)
            {
                IQueryable<Item> newReferencesItemQuerable = _entityRepoItem.GetAllWithConditionsRelationsQueryable(x => (x.UnitHtpurchasePrice == null || x.UnitHtpurchasePrice == 0 &&
                (x.UnitHtsalePrice == null || x.UnitHtsalePrice == 0)) && x.IdNatureNavigation.IsStockManaged && 
                x.ItemTiers.Any(z => provisioning.IdTiers.Contains(z.IdTiers))).Include(x => x.ItemTiers).ThenInclude(y => y.IdTiersNavigation);
                if (filters.NewReferencesStartDate != null && filters.NewReferencesEndDate != null)
                {
                    newReferencesItemQuerable = newReferencesItemQuerable.Where(x =>
                    x.CreationDate >= filters.NewReferencesStartDate &&
                    x.CreationDate <= filters.NewReferencesEndDate);
                }
                else if (filters.NewReferencesStartDate != null)
                {
                    newReferencesItemQuerable = newReferencesItemQuerable.Where(x =>
                    x.CreationDate >= filters.NewReferencesStartDate);
                }
                else if (filters.NewReferencesEndDate != null)
                {
                    newReferencesItemQuerable = newReferencesItemQuerable.Where(x =>
                    x.CreationDate <= filters.NewReferencesEndDate);
                }

                newReferencesItem = newReferencesItemQuerable.Select(_itemBuilder.BuildEntity).ToList();

            }


            return newReferencesItem;
        }

        private void CalculatedQunatityToOrderd(List<ItemViewModel> articlesViewModel, ProvisioningViewModel provision)
        {
            var result = GetProvisionDetailList(articlesViewModel, provision.Id, 0, (List<int>)provision.IdTiers);
            provision.ProvisioningDetails = result.Where(x => x.MvtQty > 0).ToList();
        }

        /**Verify if min filter is selected*/
        private List<ItemViewModel> AddMinMaxItems(ProvisioningOptionViewModel models, List<ItemViewModel> articles, List<ItemViewModel> resultList)
        {
            List<ItemViewModel> result = resultList;
            if (models.SearchByQty)
            {
                if (resultList != null && resultList.Count > 0)
                {
                    if (models.SearchBySalesHistory)
                    {
                        result = resultList.AsQueryable().Union(articles, new EntityComparator<ItemViewModel>()).ToList();
                    }
                    else
                    {
                        result = articles.AsQueryable().Union(resultList, new EntityComparator<ItemViewModel>()).ToList();
                    }
                }
                else
                {
                    result = articles;
                }
            }
            return result;
        }
        public IList<CreatedDataViewModel> CreateDocument(int idProvision, string userMail)
        {

            IList<CreatedDataViewModel> listOfCreatedDocument = new List<CreatedDataViewModel>();

            var tiersProvisioning = _entityTiersProvision.QuerableGetAll().AsNoTracking().Include(x => x.IdTiersNavigation).Where(x => x.IdProvisioning == idProvision).ToList();
            var provisions = GetModelWithRelationsAsNoTracked(x => x.Id == idProvision, x => x.ProvisioningDetails);

            WarehouseViewModel centralWarhouse = _serviceWarehouse.GetModel(x => x.IsCentral);
            if (provisions.ProvisioningDetails != null)
            {
                foreach (var tiersProvision in tiersProvisioning)
                {
                    var tiersList = provisions.ProvisioningDetails.Where(x => x.IdTiers == tiersProvision.IdTiers);
                    if (tiersList != null && tiersList.Any())
                    {
                        DocumentViewModel document = new DocumentViewModel
                        {
                            IdTiers = tiersProvision.IdTiers,
                            IdUsedCurrency = tiersProvision.IdTiersNavigation.IdCurrency,
                            IdDocumentAssociated = null,
                            DocumentTypeCode = DocumentEnumerator.PurchaseOrder,
                            IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                            DocumentDate = DateTime.Now,
                            DocumentLine = new List<DocumentLineViewModel>(),
                            IdProvision = idProvision
                        };

                        foreach (var itemList in tiersList)
                        {
                            var itemLine = _serviceDocument.GetItemDetails(itemList.IdItem, itemList.IdTiers);
                            itemLine.MovementQty = itemList.MvtQty ?? 1;
                            itemLine.Id = 0;
                            itemLine.IdWarehouse = 0;
                            itemLine.DiscountPercentage = 0;
                            itemLine.IdWarehouse = centralWarhouse.Id;
                            if (itemLine.HtUnitAmountWithCurrency == null)
                            {
                                itemLine.HtUnitAmountWithCurrency = 0;
                            }
                            itemLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                            document.DocumentLine.Add(itemLine);
                        }
                     if( document.DocumentLine.Where(x=> x.IdMeasureUnit == null ).Any())
                        {
                            throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                        }
                        //Recuperate analytical Axis
                        List<EntityAxisValuesViewModel> listOfAxisViewModel = _entityRepoEntityAxisValues.
                            FindBy(c => c.IdEntityItem == document.Id).Select(_builderEntityAxisValues.BuildEntity).ToList();
                        CreatedDataViewModel createdDocument = (CreatedDataViewModel)_serviceDocument.AddDocument(null, document, userMail, listOfAxisViewModel);
                        listOfCreatedDocument.Add(createdDocument);
                    }
                }
                provisions.IsPurchaseOrderGenerated = true;

                UpdateModel(provisions, null, null);
            }

            return listOfCreatedDocument;
        }

        public IList<ProvisioningDetailsViewModel> GetItemDetails(ProvisioningDetailsViewModel provision)
        {
            try
            {
                BeginTransaction();
                List<ProvisioningDetailsViewModel> result;

                var existingItems = _entityProvisionDetail.QuerableGetAll().Where(x => x.IdItem == provision.IdItem && x.IdProvisioning == provision.IdProvisioning);
                if (!provision.IsDeleted)
                {
                    if (provision.Id == 0 && existingItems.Any())
                    {
                        throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                    }
                    // verify CMD
                    var Selecteditem = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == provision.IdItem, x => x.IdUnitStockNavigation);
                    if (!Selecteditem.IdUnitStockNavigation.IsDecomposable && provision.MvtQty.Value != Math.Floor(provision.MvtQty.Value))
                    {
                        throw new CustomException(CustomStatusCode.CmdInvalid);
                    }
                    // used to get remainingQty for the slected item
                    List<int> ItemId = new List<int> { provision.IdItem };
                    var docLines = _serviceItem.GetRemainingQty(ItemId);
                    ItemViewModel InventoryItem = _entityRepoItem.QuerableGetAll().Where(x => x.Id == provision.IdItem).Include(c => c.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).
                        Include(x=> x.ItemTiers).ThenInclude(y=> y.IdTiersNavigation).Select(
                p => new ItemViewModel
                {
                    Id = p.Id,
                    Description = p.Description,
                    Code = p.Code,
                    UnitHtpurchasePrice = p.UnitHtpurchasePrice,
                    AllAvailableQuantity = p.ItemWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity),
                    AverageSalesPerDay = p.AverageSalesPerDay,
                    ItemFloat2 = p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ? p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0,
                    ItemInt1 = 5,
                    ItemTiers = p.ItemTiers.Select(x=> _itemTiersBuilder.BuildEntity(x)).ToList()
                }).FirstOrDefault();
                    if (InventoryItem.AllAvailableQuantity < 0)
                    {
                        InventoryItem.AllAvailableQuantity = 0;
                        _serviceItemWarehouse.LogEroor(InventoryItem.Id);
                    }
                    result = (List<ProvisioningDetailsViewModel>)CalculatedQunatityToOrderdForItem(InventoryItem, provision);
                    var item = docLines.FirstOrDefault(y => y.IdItem == result.First().IdItem);
                    foreach(var res in result)
                    {
                        res.RemainingQty = item != null ? item.ReliquatQty : 0;
                    }
                   
                }
                else
                {
                    if (existingItems.FirstOrDefault() == null || existingItems.FirstOrDefault().IsDeleted)
                    {
                        throw new CustomException(CustomStatusCode.LINE_ALREAD_DELETED);
                    }
                    _serviceProvisioningDetails.DeleteModelwithouTransaction(provision.Id, "ProvisioningDetails", null);
                    // delete tiers_provisioning
                    var existingProvisioningDetails = _serviceProvisioningDetails.FindByAsNoTracking(x => x.IdProvisioning == provision.IdProvisioning && x.IdTiers == provision.IdTiers
                    && x.IsDeleted == false);
                    if (existingProvisioningDetails.Count == 0)
                    {
                        var tiersProvisioningList = _entityTiersProvision.GetAllAsNoTracking().Where(x => x.IdProvisioning == provision.IdProvisioning && x.IsDeleted == false).ToList();
                        if (tiersProvisioningList.Count > 1)
                        {
                            var tiersProvisioningId = tiersProvisioningList.Where(x => x.IdTiers == provision.IdTiers && x.IdProvisioning == provision.IdProvisioning).FirstOrDefault().Id;

                            _serviceTiersProvisioning.DeleteModelwithouTransaction(tiersProvisioningId, "Tiers_Provisioning", null);
                        }

                    }
                    result = null;
                }
                EndTransaction();
                return result;
            }
            catch (CustomException)
            {
                throw;
            }
#pragma warning disable CS0168 // The variable 'e' is declared but never used
            catch (Exception e)
#pragma warning restore CS0168 // The variable 'e' is declared but never used
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }

        }

        /// <summary>
        /// Calculated Qunatity To Orderd For Item
        /// </summary>
        /// <param name="articlesViewModel"></param>
        /// <returns></returns>
        private IList<ProvisioningDetailsViewModel> CalculatedQunatityToOrderdForItem(ItemViewModel articlesViewModel, ProvisioningDetailsViewModel provision)
        {
            int idwarehouse = _serviceWarehouse.GetModel(x => x.IsCentral).Id;
            List<int> idsTiers = _entityTiersProvision.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdProvisioning == provision.IdProvisioning).Select(x => x.IdTiers).ToList();
            List<Tiers> listTiers = _entityRepoTiers.GetAllWithConditionsRelationsQueryableAsNoTracking(x => idsTiers.Contains(x.Id), y => y.IdCurrencyNavigation).ToList();
            var itemsForProvisionnig = new List<ProvisioningDetailsViewModel>();
            if(listTiers != null && listTiers.Any() && provision.Id <= 0)
            {
                foreach(var tier in listTiers)
                {
                    var itemtier = articlesViewModel.ItemTiers.Where(x => x.IdTiers == tier.Id);
                    if (itemtier != null && itemtier.Any())
                    {
                        itemtier.First().IdTiersNavigation = _tiersBuilder.BuildEntity(tier);
                        itemsForProvisionnig.Add(new ProvisioningDetailsViewModel
                        {
                            Id = provision.Id,
                            IdItem = articlesViewModel.Id,
                            IdProvisioning = provision.IdProvisioning,
                            LastePurchasePrice = articlesViewModel.ItemTiers.Where(x => x.IdTiers == tier.Id).First().PurchasePrice,
                            MvtQty = provision.MvtQty,
                            CurrencyCode = tier.IdCurrencyNavigation.Code,
                            CurrencyPrecision = tier.IdCurrencyNavigation.Precision,
                            DeleveryDelay = articlesViewModel.ItemInt1 ?? 0,
                            MinQuantity = articlesViewModel.ItemFloat2 ?? 0,
                            AverageSalesPerDay = articlesViewModel.AverageSalesPerDay ?? 0,
                            OnOrderQuantity = _serviceDocumentLine.GetOrdredQty(provision.IdItem, idwarehouse),
                            IdTiers = tier.Id
                        });
                    }
                }
            }
            else
            {
                var tier = listTiers.Where(x => x.Id == provision.IdTiers).First();
                itemsForProvisionnig.Add(new ProvisioningDetailsViewModel
                {
                    Id = provision.Id,
                    IdItem = articlesViewModel.Id,
                    IdProvisioning = provision.IdProvisioning,
                    LastePurchasePrice = articlesViewModel.ItemTiers.Where(x => x.IdTiers == tier.Id).First().PurchasePrice,
                    MvtQty = provision.MvtQty,
                    CurrencyCode = tier.IdCurrencyNavigation.Code,
                    CurrencyPrecision = tier.IdCurrencyNavigation.Precision,
                    DeleveryDelay = articlesViewModel.ItemInt1 ?? 0,
                    MinQuantity = articlesViewModel.ItemFloat2 ?? 0,
                    AverageSalesPerDay = articlesViewModel.AverageSalesPerDay ?? 0,
                    OnOrderQuantity = _serviceDocumentLine.GetOrdredQty(provision.IdItem, idwarehouse),
                    IdTiers = tier.Id,
                });
            }
            if (provision.Id == 0)
            {
                    _serviceProvisioningDetails.BulkAddWithoutTransaction(itemsForProvisionnig, null, null);
            }
            else
            {
                _serviceProvisioningDetails.BulkUpdateModelWithoutTransaction(itemsForProvisionnig, null);
            }
            foreach (var model in itemsForProvisionnig)
            {
                model.IdItemNavigation = articlesViewModel;
            }
            return itemsForProvisionnig;
        }
        public IList<TiersProvisioningViewModel> SupplierTotalRecap(int idProvision, int idProvisionDetail)
        {
            var provision = _serviceProvisioningDetails.FindModelBy(x => x.Id == idProvisionDetail).FirstOrDefault();
            GetTotal(idProvision, provision);
            var tiersProvision = _entityTiersProvision.QuerableGetAll().Where(x => x.IdProvisioning == idProvision)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdCurrencyNavigation).ToList();
            var result = tiersProvision.Select(x => _tiersProvisioningBuilder.BuildEntity(x)).ToList();
            return result;
        }
        private void GetTotal(int idProvision, ProvisioningDetailsViewModel provision = null)
        {
            var provisionDetails = _entityProvisionDetail.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).ToList();
            var totalPeerSupplier = _entityTiersProvision.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).ToList();
            foreach (var item in totalPeerSupplier)
            {
                item.Total = provisionDetails.Where(x => x.IdTiers == item.IdTiers).Sum(x => x.MvtQty * x.LastePurchasePrice);
            }
            _entityTiersProvision.BulkUpdate(totalPeerSupplier);
            _unitOfWork.Commit();
        }

        public IList<ProvisioningDetailsViewModel> GetEquivalentList(EquivalentItemViewModel equivalentItemViewModel, out int total)
        {

            var companyPrecision = _serviceCompany.GetCompanyCurrencyPrecision();
            var item = _entityRepoItem.GetSingle(x => x.Id == equivalentItemViewModel.IdItem);
            var allInventoryItem = _entityRepoItem.QuerableGetAll()
               .Where(x => x.Id != equivalentItemViewModel.IdItem)
               .Include(c => c.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).Include(x => x.IdProductItemNavigation)
               .Include(x=> x.ItemTiers).ThenInclude(x=> x.IdTiersNavigation)
               .Where(x => x.EquivalenceItem == item.EquivalenceItem && x.ItemTiers != null && x.EquivalenceItem != null).ToList()
               .Where(x => !equivalentItemViewModel.ListOfExisting.Contains(x.Id));

            var listOfKitEquivalent = _entityRepoItemKit.QuerableGetAll().Where(x => allInventoryItem.Select(y => y.Id).Contains(x.IdItem.Value)).Include(
                c => c.IdKitNavigation).ThenInclude(c => c.ItemWarehouse).ThenInclude(c => c.IdWarehouseNavigation).AsEnumerable()
                .GroupBy(z => z.IdKit).Distinct().Select(p => p.FirstOrDefault()).ToList().Select(
                g => g.IdKitNavigation).Where(h => !equivalentItemViewModel.ListOfExisting.Contains(h.Id));

            if (listOfKitEquivalent != null && listOfKitEquivalent.Any())
            {
                allInventoryItem = allInventoryItem.Concat(listOfKitEquivalent).GroupBy(z => z.Id).Distinct().Select(p => p.FirstOrDefault());
            }
            if(equivalentItemViewModel.ValueToFind != null)
            {
                allInventoryItem = allInventoryItem.Where(x => x.Code.ToUpper().Contains(equivalentItemViewModel.ValueToFind.ToUpper()) || x.Description.ToUpper().Contains(equivalentItemViewModel.ValueToFind.ToUpper()));
            }
            var inventoryItem = allInventoryItem.Skip(equivalentItemViewModel.Skip).Take(equivalentItemViewModel.PageSize).ToList();
            var listItemId = inventoryItem.Select(x => x.Id).ToList();
            var docLines = _serviceItem.GetRemainingQty(listItemId);
            var listEquivalentItem = inventoryItem.Select(
            p => new ItemViewModel
            {
                Id = p.Id,
                Description = p.Description,
                Code = p.Code,
                UnitHtpurchasePrice = p.UnitHtpurchasePrice,
                UnitHtsalePrice = p.UnitHtsalePrice,
                ItemFloat1 = p.ItemWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity),
                AverageSalesPerDay = p.AverageSalesPerDay,
                //IdTiers = p.IdTiers,
                //IdTiersNavigation = p.IdTiersNavigation != null ? new TiersViewModel { Id = p.IdTiersNavigation.Id, Name = p.IdTiersNavigation.Name, IdCurrency = p.IdTiersNavigation.IdCurrency,
                //    FormatOption = new NumberFormatOptionsViewModel
                //    {
                //        style = Constants.STYLE_CURRENCY,
                //        currency = p.IdTiersNavigation.IdCurrencyNavigation.Code,
                //        currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                //        minimumFractionDigits = p.IdTiersNavigation.IdCurrencyNavigation.Precision
                //    }
                //} : null,
                ItemFloat2 = p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral) != null ? p.ItemWarehouse.FirstOrDefault(y => y.IdWarehouseNavigation.IsCentral).MinQuantity : 0,
                ItemInt1 = 5,
                LabelVehicule = p.IdProductItemNavigation != null ? p.IdProductItemNavigation.LabelProduct : "",
                ItemTiers = p.ItemTiers != null && p.ItemTiers.Any() ? p.ItemTiers.Select(x=> _itemTiersBuilder.BuildEntity(x)).ToList() : null
            }).ToList();


            total = allInventoryItem.Count();
            _serviceItemWarehouse.GetAllAvailbleQuantityFolAllItem(listEquivalentItem);
            var result = GetProvisionDetailList(listEquivalentItem,0,1);
            result.ForEach(x =>
            {
                var documentItem = docLines.FirstOrDefault(y => y.IdItem == x.IdItem);
                x.MvtQty = 1;
                x.RemainingQty = documentItem != null ? documentItem.ReliquatQty : 0;
                x.CurrencyPrecision = companyPrecision;
            });

            return result.OrderByDescending(x => x.IdItemNavigation.AllAvailableQuantity).ThenByDescending(x => x.IdItemNavigation.CMD)
                .ThenByDescending(x => x.RemainingQty).ThenByDescending(x => x.IdItemNavigation.UnitHtpurchasePrice).ToList();
        }

        public DataSourceResult<ProvisioningViewModel> ProvisioningList(ProvisionPredicateViewModel previsionPredicate)
        {
            PredicateFilterRelationViewModel<Provisioning> predicateFilterRelationModel = PreparePredicate(previsionPredicate.Predicate);
            var allProvisioingList = _entityRepo.QuerableGetAll().Include(x => x.TiersProvisioning).ThenInclude(x => x.IdTiersNavigation).Where(predicateFilterRelationModel.PredicateWhere);
            if (previsionPredicate.StartDate != null)
            {
                allProvisioingList = allProvisioingList.Where(x => x.CreationDate != null &&
              new DateTime(x.CreationDate.Value.Year, x.CreationDate.Value.Month, x.CreationDate.Value.Day) >= new DateTime(previsionPredicate.StartDate.Value.Year, previsionPredicate.StartDate.Value.Month, previsionPredicate.StartDate.Value.Day));
            }
            if (previsionPredicate.EndDate != null)
            {

                allProvisioingList = allProvisioingList.Where(x => x.CreationDate != null &&
                new DateTime(x.CreationDate.Value.Year, x.CreationDate.Value.Month, x.CreationDate.Value.Day) <= new DateTime(previsionPredicate.EndDate.Value.Year, previsionPredicate.EndDate.Value.Month, previsionPredicate.EndDate.Value.Day));
            }
            if (previsionPredicate.IdTiers != null)
            {
                var idProvisions = _entityTiersProvision.QuerableGetAll().Where(x => x.IdTiers == previsionPredicate.IdTiers).Select(x => x.IdProvisioning).ToList();
                allProvisioingList = allProvisioingList.Where(x => idProvisions.Contains(x.Id));
            }
            int total = allProvisioingList.Count();

            var provisioingListToSend = allProvisioingList.OrderByDescending(p => p.Id).Skip(
                (previsionPredicate.Predicate.page - 1) * previsionPredicate.Predicate.pageSize).Take(previsionPredicate.Predicate.pageSize).Select(x => _builder.BuildEntity(x)).ToList();
            DataSourceResult<ProvisioningViewModel> result = new DataSourceResult<ProvisioningViewModel>
            {
                data = provisioingListToSend,
                total = total
            };
            return result;
        }



        public IList<ProvisioningDetailsViewModel> GetItemsWithPaging(int idProvision, PredicateFormatViewModel predicate, out int total)
        {
            int idwarehouse = _serviceWarehouse.GetModel(x => x.IsCentral).Id;
            PredicateFilterRelationViewModel<ProvisioningDetails> predicateFilterRelationModel = _serviceProvisioningDetails.PreparePredicate(predicate);
            //get provision list 
            IQueryable<ProvisioningDetails> allProvisonDetailsList = _entityProvisionDetail.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).Include(x => x.IdItemNavigation).ThenInclude(x => x.IdUnitStockNavigation).Include(x => x.IdTiersNavigation);
            if (predicateFilterRelationModel != null && predicateFilterRelationModel.PredicateWhere != null)
            {
                allProvisonDetailsList = allProvisonDetailsList.Where(predicateFilterRelationModel.PredicateWhere);
            }
            total = allProvisonDetailsList.Count();
            var provisonDetailsList = allProvisonDetailsList.Skip(predicate.page).Take(predicate.pageSize).ToList().Select(x => _provisioningDetailsBuilder.BuildEntity(x)).ToList();

            //used to calculate ReliquatQty
            var IdItemList = provisonDetailsList.Select(x => x.IdItem).ToList();
            var docLines = _serviceItem.GetRemainingQty(IdItemList);



            // used to calculate available quantity
            var items = provisonDetailsList.Select(x => x.IdItemNavigation).ToList();
            _serviceItemWarehouse.GetAllAvailbleQuantityFolAllItem(items);
            IList<OrderQuantitybyItem> toOrderedQuantity = _serviceDocumentLine.GetOrdredQty(items.Select(x => x.Id).ToList(), idwarehouse);

            List<Currency> usedCurrency = _entityRepoCurrency.GetAll().ToList();
            foreach (var provisioningDetail in provisonDetailsList)
            {
                provisioningDetail.IdItemNavigation = items.First(x => x.Id == provisioningDetail.IdItem);
                provisioningDetail.LastePurchasePrice = provisioningDetail.LastePurchasePrice;
                provisioningDetail.LastSalesPrice = provisioningDetail.IdItemNavigation.UnitHtsalePrice;
                provisioningDetail.CurrencyCode = usedCurrency.First(x => x.Id == provisioningDetail.IdTiersNavigation.IdCurrency).Code;
                provisioningDetail.CurrencyPrecision = usedCurrency.First(x => x.Id == provisioningDetail.IdTiersNavigation.IdCurrency).Precision;

                provisioningDetail.OnOrderQuantity = toOrderedQuantity.First(x => x.IdItem == provisioningDetail.IdItem).OnOrderQuantity;

                var item = docLines.FirstOrDefault(y => y.IdItem == provisioningDetail.IdItem);
                provisioningDetail.RemainingQty = item != null ? item.ReliquatQty : 0;
                provisioningDetail.AvailableDateReliquat = item != null ? item.AvailableDate : null;
            }
            return provisonDetailsList;
        }

        public ProvisioningViewModel GetProvision(int idProvision)
        {
            ProvisioningViewModel provisioning = GetModelWithRelations(x => x.Id == idProvision, x => x.IdProvisioningOptionNavigation);
            if (provisioning == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            provisioning.TiersProvisioning = _entityTiersProvision.QuerableGetAll().Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdCurrencyNavigation).Where(x => x.IdProvisioning == provisioning.Id).Select(x => _tiersProvisioningBuilder.BuildEntity(x)).ToList();
            foreach (var tier in provisioning.TiersProvisioning)
            {
                tier.IdTiersNavigation.FormatOption = new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = tier.IdTiersNavigation.IdCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = tier.IdTiersNavigation.IdCurrencyNavigation.Precision
                };
            }
            return provisioning;
        }


        private void TiersProvisioningToAdd(List<int> idTiers, int idProvision)
        {
            try
            {
                var tierProvision = _entityTiersProvision.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).Select(x => x.IdTiers);
                var tiersId = idTiers.Where(x => !tierProvision.Contains(x));
                List<TiersProvisioning> tiersProvisionings = new List<TiersProvisioning>();
                foreach (var idTier in tiersId)
                {
                    TiersProvisioning tiersProvision = new TiersProvisioning
                    {
                        IdProvisioning = idProvision,
                        IdTiers = idTier
                    };
                    tiersProvisionings.Add(tiersProvision);
                }
                _entityTiersProvision.BulkAdd(tiersProvisionings);
                _unitOfWork.Commit();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
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
        private List<ProvisioningDetailsViewModel> GetProvisionDetailList(List<ItemViewModel> articlesViewModel, int provisionId = 0, int MvtQty = 0, List<int> listTiers = null, bool fromEquiv = false)
        {
            List<int> idItems = articlesViewModel.Select(x => x.Id).ToList();
            int idwarehouse = _serviceWarehouse.GetModel(x => x.IsCentral).Id;
            IList<OrderQuantitybyItem> toOrderedQuantity = _serviceDocumentLine.GetOrdredQty(idItems, idwarehouse);

            List<ProvisioningDetailsViewModel> result = new List<ProvisioningDetailsViewModel>();
            if(fromEquiv ==  true)
            {
                foreach (var item in articlesViewModel)
                {
                    var itemTier = item.ItemTiers.ToList();
                    foreach(var tier in itemTier)
                    {
                        var itemForProvisionnig = new ProvisioningDetailsViewModel
                        {
                            IdItem = item.Id,
                            IdProvisioning = provisionId,
                            IdItemNavigation = item,
                            LastePurchasePrice = tier.PurchasePrice,
                            DeleveryDelay = tier.IdTiersNavigation.DeleveryDelay != null ? (double)tier.IdTiersNavigation.DeleveryDelay : 0,
                            MinQuantity = item.CentralMinQuantity ?? 0,
                            AverageSalesPerDay = item.AverageSalesPerDay ?? 0,
                            LastSalesPrice = item.UnitHtsalePrice,
                            LabelVehicule = item.LabelVehicule,
                            //CMD
                            OnOrderQuantity = toOrderedQuantity.First(x => x.IdItem == item.Id).OnOrderQuantity,
                            IdTiers = tier.IdTiers
                        };
                        if (MvtQty > 0)
                        {
                            itemForProvisionnig.MvtQty = MvtQty;
                        }
                        else if (itemForProvisionnig.LastePurchasePrice != null && itemForProvisionnig.LastePurchasePrice > 0 && itemForProvisionnig.LastSalesPrice != null && itemForProvisionnig.LastSalesPrice > 0)
                        {
                            if (item.CreatedByDocumentLine == true)
                            {
                                itemForProvisionnig.MvtQty = item.AllMovementQuantity;
                                itemForProvisionnig.IdItemNavigation = null;
                            }
                            else
                            {
                                itemForProvisionnig.MvtQty = Math.Round(itemForProvisionnig.MinQuantity + (itemForProvisionnig.AverageSalesPerDay * itemForProvisionnig.DeleveryDelay) -
                                                                                    (itemForProvisionnig.IdItemNavigation.AllAvailableQuantity + itemForProvisionnig.OnOrderQuantity));
                                itemForProvisionnig.IdItemNavigation = null;
                            }
                        }
                        else
                        {
                            itemForProvisionnig.MvtQty = 1;
                            itemForProvisionnig.IdItemNavigation = null;
                        }
                        result.Add(itemForProvisionnig);
                    }
                }

            }
            else
            { 
            if (listTiers != null)
            {
                foreach (var tier in listTiers)
                {
                    foreach (var item in articlesViewModel)
                    {
                            if (item.ItemTiers.Any(x => x.IdTiers == tier))
                        {
                            ItemTiersViewModel itemtier = item.ItemTiers.Where(x => x.IdTiers == tier).First();
                            var itemForProvisionnig = new ProvisioningDetailsViewModel
                            {
                                IdItem = item.Id,
                                IdProvisioning = provisionId,
                                IdItemNavigation = item,
                                LastePurchasePrice = itemtier.PurchasePrice,
                                DeleveryDelay = itemtier.IdTiersNavigation.DeleveryDelay != null ? (double)itemtier.IdTiersNavigation.DeleveryDelay : 0,
                                MinQuantity = item.CentralMinQuantity ?? 0,
                                AverageSalesPerDay = item.AverageSalesPerDay ?? 0,
                                LastSalesPrice = item.UnitHtsalePrice,
                                LabelVehicule = item.LabelVehicule,
                                //CMD
                                OnOrderQuantity = toOrderedQuantity.First(x => x.IdItem == item.Id).OnOrderQuantity,
                                IdTiers = tier
                            };
                            if (MvtQty > 0)
                            {
                                itemForProvisionnig.MvtQty = MvtQty;
                                itemForProvisionnig.IdItemNavigation = null;
                            }
                            else if (item.CreatedByDocumentLine == true)
                            {
                                itemForProvisionnig.MvtQty = item.AllMovementQuantity;
                            }
                            else if (itemForProvisionnig.LastePurchasePrice != null && itemForProvisionnig.LastePurchasePrice > 0 && itemForProvisionnig.LastSalesPrice != null && itemForProvisionnig.LastSalesPrice > 0)
                            {
                                itemForProvisionnig.MvtQty = Math.Round(itemForProvisionnig.MinQuantity + (itemForProvisionnig.AverageSalesPerDay * itemForProvisionnig.DeleveryDelay) -
                                                                                    (itemForProvisionnig.IdItemNavigation.AllAvailableQuantity + itemForProvisionnig.OnOrderQuantity));
                                itemForProvisionnig.IdItemNavigation = null;
                                }
                            else
                            {
                                itemForProvisionnig.MvtQty = 1;
                                itemForProvisionnig.IdItemNavigation = null;
                            }

                            result.Add(itemForProvisionnig);
                        }
                    }
                }

            }
            else
            {
                foreach (var item in articlesViewModel)
                {
                    var itemForProvisionnig = new ProvisioningDetailsViewModel
                    {
                        IdItem = item.Id,
                        IdProvisioning = provisionId,
                        IdItemNavigation = item,
                        LastePurchasePrice = item.UnitHtpurchasePrice,
                        DeleveryDelay = item.TiersDeleveryDelay,
                        MinQuantity = item.CentralMinQuantity ?? 0,
                        AverageSalesPerDay = item.AverageSalesPerDay ?? 0,
                        LastSalesPrice = item.UnitHtsalePrice,
                        LabelVehicule = item.LabelVehicule,
                        OnOrderQuantity = toOrderedQuantity.First(x => x.IdItem == item.Id).OnOrderQuantity
                    };
                    if (MvtQty > 0)
                    {
                        itemForProvisionnig.MvtQty = MvtQty;
                    }
                    else if (itemForProvisionnig.LastePurchasePrice != null && itemForProvisionnig.LastePurchasePrice > 0 && itemForProvisionnig.LastSalesPrice != null && itemForProvisionnig.LastSalesPrice > 0)
                    {
                        if (item.CreatedByDocumentLine == true)
                        {
                            itemForProvisionnig.MvtQty = item.AllMovementQuantity;
                        }
                        else
                        {
                            itemForProvisionnig.MvtQty = Math.Round(itemForProvisionnig.MinQuantity + (itemForProvisionnig.AverageSalesPerDay * itemForProvisionnig.DeleveryDelay) -
                                                                                (itemForProvisionnig.IdItemNavigation.AllAvailableQuantity + itemForProvisionnig.OnOrderQuantity));
                        }
                    }
                    else
                    {
                        itemForProvisionnig.MvtQty = 1;
                        itemForProvisionnig.IdItemNavigation = null;
                    }
                    result.Add(itemForProvisionnig);
                }
            }
        }
            return result;
        }
        public void AddEquivalentItemToProvisioningGrid(List<int> idEquivalentItem, int idProvision, int MvtQty)
        {
            try
            {

                //get provision details items
                var existingProvisionDetail = _entityProvisionDetail.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).Select(x => x.IdItem);
                //get provision tiers 
                var provisionTiers = _entityTiersProvision.QuerableGetAll().Where(x => x.IdProvisioning == idProvision).Select(x => x.IdTiers);
                //get items to add
                var itemList = _entityRepoItem.QuerableGetAll().Where(x => idEquivalentItem.Contains(x.Id) && !existingProvisionDetail.Contains(x.Id)).Include(x => x.ItemTiers).
                    ThenInclude(x => x.IdTiersNavigation).AsNoTracking().ToList().Select(x => _itemBuilder.BuildEntity(x)).ToList();
                if (itemList.Count != 0)
                {
                    var provisionDetail = GetProvisionDetailList(itemList, idProvision, MvtQty, null, true).ToList();

                    _serviceProvisioningDetails.BulkAdd(provisionDetail, null);

                    TiersProvisioningToAdd(provisionDetail.Select(x => x.IdTiers).Distinct().ToList(), idProvision);
                    // delete tiers_provisioning with total = 0 if another tiers exist
                    var tiersProvisioning = _entityTiersProvision.GetAllAsNoTracking().Where(x => x.IdProvisioning == idProvision && x.Total == 0).FirstOrDefault();
                    if (tiersProvisioning != null)
                    {
                        var existingProvisioningDetails = _serviceProvisioningDetails.FindByAsNoTracking(x => x.IdProvisioning == idProvision && x.IdTiers == tiersProvisioning.IdTiers);
                        if (existingProvisioningDetails.Count == 0)
                        {

                            _serviceTiersProvisioning.DeleteModelwithouTransaction(tiersProvisioning.Id, "Tiers_Provisioning", null);
                        }


                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                }
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                throw;
            }

        }


        public void importOrderProject(List<int> idProvisionList, int idProvision)
        {
            try
            {
                List<ProvisioningDetails> ExistingItemToUpdate;
                List<ProvisioningDetails> AddedItemToUpdate;
                var ProvisionDetailList = _entityProvisionDetail.QuerableGetAll().AsNoTracking().Where(x => idProvisionList.Contains(x.IdProvisioning) || x.IdProvisioning == idProvision).ToList();

                //current project to save
                var DetailProvision = ProvisionDetailList.Where(x => x.IdProvisioning == idProvision);

                ExistingItemToUpdate = DetailProvision.Select(x => new ProvisioningDetails
                {
                    IdItem = x.IdItem,
                    IdTiers = x.IdTiers,
                    IdProvisioning = idProvision,
                    LastePurchasePrice = x.LastePurchasePrice,
                    MvtQty = ProvisionDetailList.Where(y => y.IdItem == x.IdItem).Sum(y => y.MvtQty) ?? 0
                }).ToList();

                var iditems = ExistingItemToUpdate.Select(x => x.IdItem);

                AddedItemToUpdate = ProvisionDetailList.Distinct(new ProvisioningDetailsComparator()).Where(x => x.IdProvisioning != idProvision && !iditems.Contains(x.IdItem)).Select(x => new ProvisioningDetails
                {
                    Id = 0,
                    IdItem = x.IdItem,
                    IdTiers = x.IdTiers,
                    IdProvisioning = idProvision,
                    LastePurchasePrice = x.LastePurchasePrice,
                    MvtQty = ProvisionDetailList.Where(y => y.IdItem == x.IdItem).Sum(y => y.MvtQty) ?? 0
                }).ToList();


                BeginTransaction();
                _entityProvisionDetail.QuerableGetAll().AsNoTracking().Where(x => x.IdProvisioning == idProvision).UpdateFromQuery(x => new ProvisioningDetails { IsDeleted = true, DeletedToken = Guid.NewGuid().ToString() });
                _entityProvisionDetail.BulkAdd(AddedItemToUpdate);
                _entityProvisionDetail.BulkUpdate(ExistingItemToUpdate);
                _unitOfWork.Commit();
                EndTransaction();
                AddUpdateTiersProvision(AddedItemToUpdate, ExistingItemToUpdate, idProvision);
                //delete imported projects
                DeleteImportedProjects(idProvisionList);

            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }
        private void DeleteImportedProjects(List<int> idProvisionList)
        {
            BeginTransaction();
            _entityRepo.QuerableGetAll().AsNoTracking().Where(x => idProvisionList.Any(y => y == x.Id)).UpdateFromQuery(x => new Provisioning { IsDeleted = true, DeletedToken = Guid.NewGuid().ToString() });
            _unitOfWork.Commit();
            EndTransaction();
        }
        private void AddUpdateTiersProvision(List<ProvisioningDetails> AddedItemToUpdate, List<ProvisioningDetails> ExistingItemToUpdate, int idProvision)
        {
            List<TiersProvisioning> tiersProvisioningsToAdd = new List<TiersProvisioning>();
            List<TiersProvisioning> tiersProvisioningsToUpdate = new List<TiersProvisioning>();


            var allTiesrProvision = AddedItemToUpdate.Concat(ExistingItemToUpdate);
            var allTiesrProvisionId = allTiesrProvision.Select(x => x.IdTiers).Distinct().ToList();
            var existingTiersProvisionToBeUpdate = _entityTiersProvision.QuerableGetAll().AsNoTracking().Where(x => x.IdProvisioning == idProvision).ToList();

            foreach (var tiers in allTiesrProvisionId)
            {
                var existTiers = existingTiersProvisionToBeUpdate.FirstOrDefault(x => x.IdTiers == tiers);
                if (existTiers != null)
                {
                    existTiers.Total = allTiesrProvision.Where(x => x.IdTiers == tiers).Sum(x => x.MvtQty * x.LastePurchasePrice);
                    tiersProvisioningsToUpdate.Add(existTiers);
                }
                else
                {
                    TiersProvisioning tiersProvisioning = new TiersProvisioning
                    {
                        IdTiers = tiers,
                        IdProvisioning = idProvision,
                        Total = allTiesrProvision.Where(x => x.IdTiers == tiers).Sum(x => x.MvtQty * x.LastePurchasePrice)
                    };
                    tiersProvisioningsToAdd.Add(tiersProvisioning);
                }
            }
            _entityTiersProvision.BulkAdd(tiersProvisioningsToAdd);
            _entityTiersProvision.BulkUpdate(tiersProvisioningsToUpdate);
            _unitOfWork.Commit();
        }
        public override DataSourceResult<ProvisioningViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            var p = PreparePredicate(predicateModel[0]);
            int page = predicateModel[0].page;
            int pageSize = predicateModel[0].pageSize;
            predicateModel[0].page = 0;
            predicateModel[0].pageSize = 0;
            DataSourceResult<ProvisioningViewModel> obj = base.GetDataWithSpecificFilter(predicateModel);
            var listProvisioning = obj.data.ToList();
            if (predicateModel != null)
            {
                var predTiers = predicateModel[0].Filter.Where(x => x.Prop == "IdTiers").FirstOrDefault();
                bool isTiersFilter = predTiers != null ? true : false;
                if (isTiersFilter && predTiers.Value != null)
                {
                    listProvisioning = listProvisioning.Where(x => x.TiersProvisioning != null && x.TiersProvisioning.Select(y => y.IdTiers).Contains(Convert.ToInt32(predTiers.Value))).ToList();
                }
                listProvisioning.ToList().ForEach(x =>
                {
                    if (x.TiersProvisioning != null)
                    {
                        x.TiersProvisioning.ToList().ForEach(t =>
                        {
                            if (x.Suppliers == null)
                            {
                                x.Suppliers = t.IdTiersNavigation.Name;
                            }
                            else
                            {
                                x.Suppliers = new StringBuilder().Append(x.Suppliers).Append(",").Append(t.IdTiersNavigation.Name).ToString();
                            }

                        });
                    }
                });
            }

            obj.data = listProvisioning.Skip((page - 1) * pageSize).Take(pageSize).ToList();
            obj.total = listProvisioning.Count;

            return obj;
        }
        }
}