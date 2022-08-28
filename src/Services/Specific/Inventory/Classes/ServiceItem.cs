using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.B2B;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceItem : Service<ItemViewModel, Item>, IServiceItem
    {
        #region Fields
        const string idWarehouseConst = "IdWarehouse";
        const string idTiersConst = "IdTiers";
        const string isForSaleConts = "IsForSales";
        const string isForPurchaseConst = "IsForPurchase";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceTaxeItem _serviceTaxeItem;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IRepository<ItemWarehouse> _itemWarehouseRepo;
        private readonly IRepository<Nature> _natureRepo;
        private readonly IRepository<Warehouse> _warehouseRepo;
        private readonly IServiceItemTiers _serviceItemTiers;
        private readonly IReducedItemBuilder _reducedBuilder;
        private readonly IReducedItemViewModelBuilder _reducedItemViewModelBuilder;
        private readonly IServiceItemKit _serviceItemKit;
        private readonly IRepository<ItemKit> _itemKitRepo;
        private readonly IRepository<Tiers> _tierRepo;
        private readonly IRepository<Expense> _expenseRepo;
        private readonly IRepository<ItemVehicleBrandModelSubModel> _itemVehicleBrandModelSubModelRepo;
        private readonly IServiceItemVehicleBrandModelSubModel _serviceItemVehicleBrandModelSubModel;
        private readonly IRepository<Claim> _entityRepoClaim;
        private readonly IRepository<Provisioning> _repoProvisioning;
        private readonly IRepository<DocumentLine> _repoDocumentLine;
        private readonly IRepository<StockMovement> _repoStockMovement;
        private readonly IRepository<ItemTiers> _repoItemTiers;
        private readonly ITiersBuilder _TiersBuilder;
        private readonly IRepository<Claim> _repoClaim;
        private readonly IItemBuilder _ItemListBuilder;
        private readonly IItemWarehouseBuilder _itemWarehouseBuilder;
        private readonly IRepository<Taxe> _taxeRepo;
        internal readonly IServiceItemPrices _serviceItemPrices;
        private readonly IServiceNature _serviceNature;
        private readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<OemItem> _repoOemItem;
        private readonly IServiceOemItem _serviceOemItem;
        private readonly IServiceItemSalesPrice _serviceItemSalesPrice;
        private readonly IRepository<ItemSalesPrice> _repoItemSalesPrice;
        private readonly IServiceCompany _serviceCompany;
        #endregion
        public ServiceItem(IServiceTaxeItem serviceTaxeItem, IRepository<Item> entityRepo,
            IUnitOfWork unitOfWork,
            IItemBuilder builder, IServiceItemWarehouse serviceItemWarehouse,
            IRepository<Nature> natureRepo,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues, IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IReducedItemBuilder reducedBuilder,
            IRepository<Codification> entityRepoCodification,
            IReducedItemViewModelBuilder reducedItemViewModelBuilder,
            IRepository<Warehouse> warehouseRepo,
            IRepository<ItemWarehouse> itemWarehouseRepo,
            IRepository<Claim> entityRepoClaim,
            IServiceItemKit serviceItemKit,
            IRepository<ItemKit> itemKitRepo,
            IRepository<Tiers> tierRepo,
            IRepository<Expense> expenseRepo,
            IServiceItemVehicleBrandModelSubModel serviceItemVehicleBrandModelSubModel,
            IRepository<ItemVehicleBrandModelSubModel> itemVehicleBrandModelSubModelRepo,
            IRepository<Provisioning> repoProvisioning,
            IRepository<DocumentLine> repoDocumentLine,
            IRepository<StockMovement> repoStockMovement,
            IServiceNature serviceNature,
            IMemoryCache memoryCache, ITiersBuilder tiersBuilder, IRepository<Claim> repoClaim,
            ICompanyBuilder companyBuilder, IRepository<Taxe> taxeRepo, IRepository<ItemTiers> repoItemTiers,
            IServiceItemPrices serviceItemPrices, IServiceProvider serviceProvider,
            IServiceItemTiers serviceItemTiers, IItemWarehouseBuilder itemWarehouseBuilder, IRepository<User> entityRepoUser, IRepository<OemItem> repoOemItem, IServiceOemItem serviceOemItem, IServiceItemSalesPrice serviceItemSalesPrice,
            IRepository<ItemSalesPrice> repoItemSalesPrice, IServiceCompany serviceCompany)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification, companyBuilder,
                  memoryCache)
        {
            _serviceTaxeItem = serviceTaxeItem;
            _serviceItemWarehouse = serviceItemWarehouse;
            _warehouseRepo = warehouseRepo;
            _itemWarehouseRepo = itemWarehouseRepo;
            _reducedBuilder = reducedBuilder;
            _serviceItemKit = serviceItemKit;
            _reducedItemViewModelBuilder = reducedItemViewModelBuilder;
            _natureRepo = natureRepo;
            _itemKitRepo = itemKitRepo;
            _tierRepo = tierRepo;
            _expenseRepo = expenseRepo;
            _itemVehicleBrandModelSubModelRepo = itemVehicleBrandModelSubModelRepo;
            _serviceItemVehicleBrandModelSubModel = serviceItemVehicleBrandModelSubModel;
            _entityRepoClaim = entityRepoClaim;
            _repoProvisioning = repoProvisioning;
            _repoDocumentLine = repoDocumentLine;
            _repoStockMovement = repoStockMovement;
            _TiersBuilder = tiersBuilder;
            _repoClaim = repoClaim;
            _ItemListBuilder = builder;
            _serviceItemPrices = serviceItemPrices;
            _serviceProvider = serviceProvider;
            _serviceItemTiers = serviceItemTiers;
            _repoItemTiers = repoItemTiers;
            _taxeRepo = taxeRepo;
            _serviceNature = serviceNature;
            _itemWarehouseBuilder = itemWarehouseBuilder;
            _entityRepoUser = entityRepoUser;
            _repoOemItem = repoOemItem;
            _serviceOemItem = serviceOemItem;
            _serviceItemSalesPrice = serviceItemSalesPrice;
            _repoItemSalesPrice = repoItemSalesPrice;
            _serviceCompany = serviceCompany;
        }


        #region Methods

        private IQueryable<ItemForSearche> GetItemListforDropDown(IQueryable<Item> query, int idSalesPrice = 0)
        {
            try
            {
                var company = GetCurrentCompany();
                if (idSalesPrice == 0)
                {
                    return query.Select(x => new ItemForSearche
                    {
                        Id = x.Id,
                        Code = x.Code,
                        Description = x.Description,
                        UnitHtsalePrice = x.UnitHtsalePrice,
                        TierList = x.ItemTiers != null ? x.ItemTiers.Select(z => z.IdTiers).ToList() : new List<int>(),
                        IsForSales = x.IsForSales ?? false,
                        IsForPurchase = x.IsForPurchase ?? false,
                        IdNature = x.IdNature ?? 0,
                        WarehouseList = x.ItemWarehouse != null ? x.ItemWarehouse.Select(z => z.IdWarehouse).ToList() : new List<int>(),
                        ExistInEcommerce = x.ExistInEcommerce,
                        BarCode1D = x.BarCode1D ?? "",
                        BarCode2D = x.BarCode2D ?? "",
                        IsEcommerce = x.IsEcommerce,
                        isDecomposable = x.IdUnitStockNavigation != null ? x.IdUnitStockNavigation.IsDecomposable : false,
                        DigitsAfterComma = x.IdUnitStockNavigation != null ? x.IdUnitStockNavigation.DigitsAfterComma : 0,
                        Marque = x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : null,
                    }).OrderBy(p => p.Id);
                }
                else
                {
                    return query.Select(x => new ItemForSearche
                    {
                        Id = x.Id,
                        Code = x.Code,
                        Description = x.Description,
                        UnitHtsalePrice = Math.Round((double)((x.ItemSalesPrice.Any(y => y.IdSalesPrice == idSalesPrice)) ? ((1 + (x.ItemSalesPrice.Where(y => y.IdSalesPrice == idSalesPrice).First().Percentage / 100)) * x.UnitHtsalePrice) : x.UnitHtsalePrice), company.IdCurrencyNavigation.Precision),
                        TierList = x.ItemTiers != null ? x.ItemTiers.Select(z => z.IdTiers).ToList() : new List<int>(),
                        IsForSales = x.IsForSales ?? false,
                        IsForPurchase = x.IsForPurchase ?? false,
                        IdNature = x.IdNature ?? 0,
                        WarehouseList = x.ItemWarehouse != null ? x.ItemWarehouse.Select(z => z.IdWarehouse).ToList() : new List<int>(),
                        ExistInEcommerce = x.ExistInEcommerce,
                        BarCode1D = x.BarCode1D ?? "",
                        BarCode2D = x.BarCode2D ?? "",
                        IsEcommerce = x.IsEcommerce,
                        isDecomposable = x.IdUnitStockNavigation != null ? x.IdUnitStockNavigation.IsDecomposable : false,
                        DigitsAfterComma = x.IdUnitStockNavigation != null ? x.IdUnitStockNavigation.DigitsAfterComma : 0,
                        Marque = x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : null,
                    }).OrderBy(p => p.Id);
                }

            }
            catch (Exception e)
            {
                return null;
            }
        }
        public void RestorItemListforDropDown()
        {
            var company = GetCurrentCompany();
            StringBuilder stringBuilder = new StringBuilder();
            if (company != null)
            {
                stringBuilder.Append("listofItem").Append(company.Code).ToString();
                _cache.Remove(stringBuilder);
            }
        }


        public List<int> CheckWarehouseUnicity(IList<ItemWarehouseViewModel> itemWarehouse)
        {
            List<int> listNotDeletedWarehouseId = itemWarehouse.Where(x => x.IsDeleted == false).Select(p => p.IdWarehouse).ToList();
            List<int> listDeletedWarehouseId = itemWarehouse.Where(x => x.IsDeleted == true).Select(p => p.IdWarehouse).ToList();
            int itemId = itemWarehouse.FirstOrDefault().IdItem;
            if (listNotDeletedWarehouseId.Count() != listNotDeletedWarehouseId.Distinct().Count())
            {
                throw new CustomException(CustomStatusCode.WarehouseUnicity);
            }
            List<int> listLockedWarehouse = _repoStockMovement.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == itemId).Select(x => x.IdWarehouse).Distinct().ToList();

            listLockedWarehouse.Where(x => listNotDeletedWarehouseId.Any(y => y != x));

            if (listDeletedWarehouseId.Intersect(listLockedWarehouse).Count() != 0)
            {
                throw new CustomException(CustomStatusCode.ItemAlreadyExistsInWarehouse);
            }
            return (listLockedWarehouse);
        }

        public void CheckItemUnicity(ItemViewModel item)
        {
            if (_entityRepo.FindSingleBy(p => p.Id != item.Id && p.Code.Equals(item.Code)) != null)
            {
                throw new CustomException(CustomStatusCode.ItemUnicity);
            }
        }

        private void UpdateGroupeEquivalence(ItemViewModel model, string userMail)
        {
            if (model.ListOfEquivalenceItem == null || !model.ListOfEquivalenceItem.Any())
            {
                return;
            }
            if (model.EquivalenceItem == null)
            {
                model.EquivalenceItem = Guid.NewGuid();
            }
            IList<int> listGroupEquivalence = model.ListOfEquivalenceItem.Where(x => x.EquivalenceItem != model.EquivalenceItem).Select(x => x.Id).ToList();

            var updateGREquivalante = _entityRepo.GetAllAsNoTracking().Where(x => listGroupEquivalence.Contains(x.Id)).ToList();
            updateGREquivalante.ToList().ForEach(p => p.EquivalenceItem = model.EquivalenceItem);
            // update entity
            _entityRepo.BulkUpdate(updateGREquivalante);
            // commit 
            _unitOfWork.Commit();
        }
        private void AddCentralWarehouseAffectation(ItemViewModel model)
        {
            var centralItemWarehouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == model.Id && x.IdWarehouseNavigation.IsCentral);
            Warehouse central = _warehouseRepo.FindByAsNoTracking(p => p.IsCentral).FirstOrDefault();
            var warehouse = model.ItemWarehouse.FirstOrDefault(p => p.IdWarehouse == central.Id);

            if (centralItemWarehouse != null && warehouse == null)
            {
                throw new CustomException(CustomStatusCode.CENTRAL_CANNOT_BE_DELETED);
            }
            else if (warehouse != null)
            {
                if (warehouse.IsDeleted)
                {
                    throw new CustomException(CustomStatusCode.CENTRAL_CANNOT_BE_DELETED);
                }
            }
            else
            {
                if (model.ItemWarehouse != null && model.ItemWarehouse.Any())
                {
                    List<ItemWarehouseViewModel> ItemsWarehouses = new List<ItemWarehouseViewModel>();
                    ItemsWarehouses.Add(new ItemWarehouseViewModel
                    {
                        IdWarehouse = central.Id,
                        MinQuantity = 10,
                        MaxQuantity = 10000
                    });
                    ItemsWarehouses.AddRange(model.ItemWarehouse);
                    model.ItemWarehouse = ItemsWarehouses;
                }
                else
                {
                    model.ItemWarehouse.Add(new ItemWarehouseViewModel
                    {
                        IdWarehouse = central.Id,
                        MinQuantity = 10,
                        MaxQuantity = 10000
                    });
                }
            }
        }
        private void SpecificItemTreatment(ItemViewModel model, string userMail)
        {
            if (_natureRepo.FindSingleBy(p => p.Id == model.IdNature).IsStockManaged)
            {
                // add warehouse central affectation
                AddCentralWarehouseAffectation(model);
                //verify ItemWarehouse unicity
                CheckWarehouseUnicity(model.ItemWarehouse.ToList());
            }
            else
            {
                // clear itemWarehouse affectation
                model.ItemWarehouse.Clear();
            }
            //update grp equivalence item
            UpdateGroupeEquivalence(model, userMail);
            // check theresn't replacement loop
            if (model.IdItemReplacement != null)
            {
                CheckReplacementLoop(model);
            }


        }
        private void AddExpense(ItemViewModel model, CreatedDataViewModel addedEntity = null)
        {
            if (model.IdNature == _natureRepo.FindSingleBy(nature => nature.Code == Constants.EXPENSE).Id)
            {
                if (model.TaxeItem == null || model.TaxeItem.Count == 0)
                {
                    throw new CustomException(CustomStatusCode.TaxRequiredError);
                }
                Expense oldExpense = _expenseRepo.GetSingleNotTracked(p => p.IdItem == model.Id);
                if (oldExpense == null)
                {
                    Expense expense = new Expense
                    {
                        Id = 0,
                        IdItem = (model.Id == 0) ? addedEntity.Id : model.Id,
                        Description = model.Description
                    };
                    if (model.TaxeItem.Count > 0)
                    {
                        expense.IdTaxe = model.TaxeItem.FirstOrDefault().IdTaxe;
                    }

                    // Generate Codification
                    List<object> codification = getCodification(expense, null, false, false);
                    expense.Code = codification[2].ToString();

                    if (codification.Any() && (expense != null && ((Codification)codification[0]).Id != 0))
                    {
                        ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                        _entityRepoCodification.Update(((Codification)codification[0]));
                        _unitOfWork.Commit();
                    }

                    _expenseRepo.Add(expense);
                }
                else
                {
                    oldExpense.Description = model.Description;
                    if (model.TaxeItem.Count > 0)
                    {
                        oldExpense.IdTaxe = model.TaxeItem.FirstOrDefault().IdTaxe;
                    }
                    _expenseRepo.Update(oldExpense);
                }
                _unitOfWork.Commit();
            }
        }
        private void CheckReplacementLoop(ItemViewModel model)
        {
            List<int> listReplacementItems = new List<int>
            {
                model.Id
            };
            Item replacementItem = _entityRepo.GetSingleNotTracked(p => p.Id == model.IdItemReplacement);

            while (replacementItem != null)
            {
                if (!listReplacementItems.Contains(replacementItem.Id))
                {
                    listReplacementItems.Add(replacementItem.Id);
                    replacementItem = _entityRepo.GetSingleNotTracked(p => p.Id == replacementItem.IdItemReplacement);
                }
                else
                {
                    throw new CustomException(CustomStatusCode.ItemReplacementLoop);
                }
            }

        }

        public override object AddModel(ItemViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();

                model.TaxeItem = model.TaxeItem.Where(x => x.IdTaxe != 0).ToList();
                CheckItemUnicityPerBrand(model);
                var nature = _natureRepo.FindSingleBy(x => x.Id == model.IdNature);
                if (nature.IsStockManaged && model.ListTiers.Count == 0)
                {
                    throw new CustomException(CustomStatusCode.SupplierRquiredError);
                }
                if (nature.IsStockManaged && ((model.IsForSales && model.IdUnitSales == null) || (model.IsForPurchase && model.IdUnitStock == null)))
                {
                    throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
                }

                if (model.TaxeItem != null)
                {
                    var amountTax = _taxeRepo.GetAllAsNoTracking().Where(x => model.TaxeItem.Select(z => z.IdTaxe).Contains(x.Id));
                    var verifTax = amountTax.ToList().Where(x => x.IsCalculable.Equals(false));
                    if (verifTax != null && verifTax.Any() && model.TaxeItem.Count > 1)
                    {
                        throw new CustomException(CustomStatusCode.ItemWithAmountTaxOnly);
                    }
                    verifTax = amountTax.Where(x => x.TaxeType == (int)TaxTypeEnumerator.Vat);
                    if (amountTax != null && verifTax != null && verifTax.ToList().Count == NumberConstant.Zero && amountTax.ToList().Count > NumberConstant.Zero && amountTax.First().IsCalculable)
                    {
                        throw new CustomException(CustomStatusCode.ItemWithFodecOnly);
                    }
                }
                if (model.ItemVehicleBrandModelSubModel?.Count > NumberConstant.One)
                {
                    CheckUnicityOfVehicleBrandModelSubModel(model.ItemVehicleBrandModelSubModel.ToList());
                }
                if (model.OemItem != null && model.OemItem.Any())
                {
                    model.OemItem = model.OemItem.Distinct().ToList();
                    CheckOemItemUnicity(model.OemItem.ToList());
                }

                SpecificItemTreatment(model, userMail);
                if (model.ItemKitIdKitNavigation != null)
                {
                    model.ItemKitIdKitNavigation.ToList().ForEach(x => x.Id = 0);
                }
                if (model.ItemKitIdItemNavigation != null)
                {
                    model.ItemKitIdItemNavigation.ToList().ForEach(x => x.Id = 0);
                }
                if (model.ItemTiers != null)
                {
                    model.ItemTiers.ToList().ForEach(x =>
                    {
                        x.Id = 0;
                        x.IdTiersNavigation = null;
                    });
                }
                if (model.ItemSalesPrice != null)
                {
                    model.ItemSalesPrice.ToList().ForEach(x =>
                    {
                        x.Id = 0;
                        x.IdSalesPriceNavigation = null;
                    });
                }
                model.CreationDate = DateTime.Now;
                if (model.FilesInfos != null && model.FilesInfos.Count > 0)
                {
                    model.UpdatedDatePicture = DateTime.Now;
                }
                //save pictures
                ManagePicture(model);
                if (model.ItemSalesPrice != null && model.ItemSalesPrice.Any())
                {
                    foreach (ItemSalesPriceViewModel itemSalesPrice in model.ItemSalesPrice)
                    {
                        itemSalesPrice.IdSalesPriceNavigation = null;
                    }
                }
                CreatedDataViewModel addedEntity = (CreatedDataViewModel)AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                // add expense
                AddExpense(model, addedEntity);
                EndTransaction();
                return addedEntity;
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


        public override object AddModelWithoutTransaction(ItemViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            RestorItemListforDropDown();
            if (string.IsNullOrEmpty(model.UrlPicture))
            {
                //save pictures
                ManagePicture(model);
            }

            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModel(ItemViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                // begin transaction
                _unitOfWork.BeginTransaction();
                //
                // recuperate old Item 
                Item oldItem = _entityRepo.GetSingleNotTracked(x => x.Id == model.Id);
                if (oldItem.IdProductItem == null && model.IdProductItem != null ||
                    oldItem.IdProductItem != null && model.IdProductItem == null ||
                    oldItem.IdProductItem != null && model.IdProductItem != null && oldItem.IdProductItem.Value != model.IdProductItem.Value ||
                    oldItem.Code != model.Code)
                {
                    CheckItemUnicityPerBrand(model);
                }
                model.UpdatedDate = DateTime.Now;
                var nature = _natureRepo.FindSingleBy(x => x.Id == model.IdNature);
                if (nature.IsStockManaged)
                {
                    if (model.ItemTiers == null || (model.ItemTiers != null && !model.ItemTiers.Any()))
                    {
                        throw new CustomException(CustomStatusCode.SupplierRquiredError);
                    }
                    if ((model.IsForSales && model.IdUnitSales == null) || (model.IsForPurchase && model.IdUnitStock == null))
                    {
                        throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
                    }
                }
                if (model.TaxeItem != null && nature.Code != Constants.ADVANCE_PAYEMENT)
                {
                    var amountTax = _taxeRepo.GetAllAsNoTracking().Where(x => model.TaxeItem.Select(z => z.IdTaxe).Contains(x.Id));
                    var verifTax = amountTax.ToList().Where(x => x.IsCalculable.Equals(false));
                    if (verifTax != null && verifTax.Any() && model.TaxeItem.Count > 1)
                    {
                        throw new CustomException(CustomStatusCode.ItemWithAmountTaxOnly);
                    }
                    verifTax = amountTax.Where(x => x.TaxeType == (int)TaxTypeEnumerator.Vat);
                    if (verifTax.ToList().Count == 0 && amountTax.First().IsCalculable)
                    {
                        throw new CustomException(CustomStatusCode.ItemWithFodecOnly);
                    }
                }
                else if (model.TaxeItem != null && nature.Code == Constants.ADVANCE_PAYEMENT)
                {
                    int idAdvanceTaxe = _taxeRepo.FindSingleBy(x => x.CodeTaxe == "TVA_Avance0%").Id;
                    if (model.TaxeItem.Count() == 1 && model.TaxeItem.First().IdTaxe != idAdvanceTaxe)
                    {
                        model.TaxeItem.First().IdTaxe = idAdvanceTaxe;
                    }
                    else if (model.TaxeItem.Count() > 1)
                    {
                        List<TaxeItemViewModel> newTaxeItem = new List<TaxeItemViewModel>();
                        newTaxeItem.Add(model.TaxeItem.First());
                        newTaxeItem.First().IdTaxe = idAdvanceTaxe;
                        model.TaxeItem = newTaxeItem;
                    }
                }
                if (model.ItemVehicleBrandModelSubModel?.Count > NumberConstant.One)
                {
                    CheckUnicityOfVehicleBrandModelSubModel(model.ItemVehicleBrandModelSubModel.ToList());
                }
                if (model.OemItem != null && model.OemItem.Any())
                {
                    model.OemItem = model.OemItem.Distinct().ToList();
                    CheckOemItemUnicity(model.OemItem.ToList());
                }
                /*if (model.FilesInfos != null && model.FilesInfos.Count > 0)
                {
                    model = VerifyUpdatedPicture(model);
                }*/
                //update with files pictures 
                ManagePicture(model);



                SpecificItemTreatment(model, userMail);
                // save entity traceability
                Item entity = _builder.BuildModel(model);



                UpdateTaxeCollection(model);
                _serviceItemWarehouse.UpdateItemWarehouseCollection(model);
                // Update list of Items of kit 
                UpdateItemsKit(model, userMail, entity);
                UpdateItemTiers(model, userMail, entity);
                UpdateItemSalesPrice(model, userMail, entity);
                UpdateItemsBrand(model, userMail, entity);
                DeleteOldOemItem(model);
                entity.TaxeItem.Clear();
                entity.ItemWarehouse.Clear();
                //entity.ItemTiers.Clear();
                UpdateCollections(entity, userMail);

                _unitOfWork.Commit();

                //recuperatet AverageSalesPerDay 
                var olditem = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == model.Id);
                entity.AverageSalesPerDay = olditem.AverageSalesPerDay;
                if (entity.UnitHtsalePrice != olditem.UnitHtsalePrice && !model.HavePriceRole)
                {
                    entity.UnitHtsalePrice = olditem.UnitHtsalePrice;
                }
                if (olditem.UnitHtpurchasePrice == null || (olditem.UnitHtpurchasePrice != null && olditem.UnitHtpurchasePrice != entity.UnitHtpurchasePrice))
                {
                    entity.UnitHtpurchasePrice = olditem.UnitHtpurchasePrice;
                }

                entity.UrlPicture = model.UrlPicture;
                // update entity
                _entityRepo.Update(entity);

                //AddExpense
                AddExpense(model);
                // commit transaction
                _unitOfWork.Commit();
                _unitOfWork.CommitTransaction();
                RestorItemListforDropDown();
                return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
            }
#pragma warning disable CS0168 // The variable 'es' is declared but never used
            catch (Exception es)
#pragma warning restore CS0168 // The variable 'es' is declared but never used
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }

        /// <summary>
        /// Check oem item unicity
        /// </summary>
        /// <param name="model"></param>
        private void CheckOemItemUnicity(List<OemItemViewModel> oemItems)
        {
            var duplicatedOemItems = oemItems.Where(x => oemItems.Any(y => ((y.Id != x.Id) || (y.Id == 0 && x.Id == 0 && oemItems.IndexOf(x) != oemItems.IndexOf(y)))
                && y.OemNumber.ToUpperInvariant().Equals(x.OemNumber.ToUpperInvariant()) && y.IdBrand == x.IdBrand));
            if (duplicatedOemItems.Any())
            {
                foreach (var itemtoremove in duplicatedOemItems)
                {
                    oemItems.RemoveAll(x => x.IdItem == itemtoremove.Id && x.IdItem == 0);
                }
            }

        }

        /// <summary>
        /// Delete old oemItems
        /// </summary>
        /// <param name="model"></param>
        private void DeleteOldOemItem(ItemViewModel model)
        {
            // Select curremnt oem item ids and fetch old oeam item to delete
            List<OemItem> oemItemsToDelte = _repoOemItem.FindByAsNoTracking(x => x.IdItem == model.Id && !model.OemItem.Select(y => y.Id).Contains(x.Id)).ToList();
            if (oemItemsToDelte.Any())
            {
                _repoOemItem.RemoveRange(oemItemsToDelte.ToArray());
            }
        }


        private void UpdateItemTiers(ItemViewModel model, string userMail, Item entity)
        {
            List<ItemTiersViewModel> ItemTiersToDelete = new List<ItemTiersViewModel>();
            List<ItemTiersViewModel> oldItemTiers = _serviceItemTiers.FindModelsByNoTracked(x => x.IdItem == model.Id).ToList();

            List<ItemTiersViewModel> newItemTiers = model.ItemTiers != null ? model.ItemTiers.ToList() : null;
            if (newItemTiers != null && newItemTiers.Any())
            {
                List<ItemTiersViewModel> ItemTiersToAdd = newItemTiers.FindAll(x => x.Id == 0);
                foreach (ItemTiersViewModel itemTier in ItemTiersToAdd)
                {
                    itemTier.IdItemNavigation = null;
                    itemTier.IdTiersNavigation = null;
                    itemTier.IdItem = model.Id;
                    _serviceItemTiers.AddModelWithoutTransaction(itemTier, new List<EntityAxisValuesViewModel>(), userMail);
                }
                ItemTiersToDelete = oldItemTiers.FindAll(x => !newItemTiers.Select(y => y.Id).Contains(x.Id));

                List<ItemTiers> ItemTiersToUpdate = entity.ItemTiers != null ? entity.ItemTiers.ToList() : null;
                if (ItemTiersToUpdate != null && ItemTiersToUpdate.Any())
                {
                    entity.ItemTiers = ItemTiersToUpdate.FindAll(x => x.Id != 0);
                    foreach (ItemTiers itemTier in entity.ItemTiers)
                    {
                        itemTier.IdItemNavigation = null;
                        itemTier.IdTiersNavigation = null;
                    }
                    entity.ItemTiers.ToList().ForEach(x => _repoItemTiers.Update(x));

                }
            }
            else
            {
                ItemTiersToDelete = oldItemTiers;
            }


            if (ItemTiersToDelete != null && ItemTiersToDelete.Any())
            {
                foreach (ItemTiersViewModel itemTier in ItemTiersToDelete)
                {
                    _serviceItemTiers.DeleteModelPhysicallyWhithoutTransaction(itemTier.Id, userMail);
                }
            }
            entity.ItemTiers.Clear();
        }

        public override object UpdateModelWithoutTransaction(ItemViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            if (model.FilesInfos != null)
            {
                ManagePicture(model);
            }
            RestorItemListforDropDown();
            return result;
        }


        private void UpdateTaxeCollection(ItemViewModel model)
        {
            //recuperate collection before update
            List<TaxeItemViewModel> oldTaxeItems = _serviceTaxeItem.FindModelsByNoTracked(x => x.IdItem == model.Id).ToList();

            List<TaxeItemViewModel> newTaxeItems = model.TaxeItem.ToList();
            newTaxeItems.ForEach(x => x.IdItem = model.Id);
            List<TaxeItemViewModel> addedTaxeItem = newTaxeItems.Except(oldTaxeItems).ToList();
            List<TaxeItemViewModel> deletedTaxeItem = oldTaxeItems.Except(newTaxeItems).ToList();
            foreach (TaxeItemViewModel taxeItem in addedTaxeItem)
            {
                taxeItem.IdItem = model.Id;
                _serviceTaxeItem.AddModelWithoutTransaction(taxeItem, new List<EntityAxisValuesViewModel>(), null);
            }
            foreach (TaxeItemViewModel taxeItem in deletedTaxeItem)
            {
                _serviceTaxeItem.DeleteModelwithouTransaction(taxeItem.Id, "TaxeItem", null);
            }
        }

        public void UpdateItemsKit(ItemViewModel model, string userMail, Item entity)
        {
            List<ItemKitViewModel> kitItemToDelete = new List<ItemKitViewModel>();
            List<ItemKitViewModel> oldKitItems = _serviceItemKit.FindModelsByNoTracked(x => x.IdKit == model.Id).ToList();
            if (model.IsKit)
            {
                List<ItemKitViewModel> newKitItems = model.ItemKitIdKitNavigation != null ? model.ItemKitIdKitNavigation.ToList() : null;
                if (newKitItems != null && newKitItems.Any())
                {
                    List<ItemKitViewModel> kitItemToAdd = newKitItems.FindAll(x => x.Id == 0);
                    foreach (ItemKitViewModel kitItem in kitItemToAdd)
                    {
                        _serviceItemKit.AddModelWithoutTransaction(kitItem, new List<EntityAxisValuesViewModel>(), userMail);
                    }
                    kitItemToDelete = oldKitItems.FindAll(x => !newKitItems.Select(y => y.Id).Contains(x.Id));

                    List<ItemKit> kitItemToUpdate = entity.ItemKitIdKitNavigation != null ? entity.ItemKitIdKitNavigation.ToList() : null;
                    if (kitItemToUpdate != null && kitItemToUpdate.Any())
                    {
                        entity.ItemKitIdKitNavigation = kitItemToUpdate.FindAll(x => x.Id != 0);
                        foreach (ItemKit itemKit in entity.ItemKitIdKitNavigation)
                        {
                            itemKit.IdKitNavigation = null;
                            itemKit.IdItemNavigation = null;
                        }
                        entity.ItemKitIdKitNavigation.ToList().ForEach(x => _itemKitRepo.Update(x));

                    }
                }
                else
                {
                    kitItemToDelete = oldKitItems;
                }
            }
            else
            {
                kitItemToDelete = oldKitItems;
            }

            if (kitItemToDelete != null && kitItemToDelete.Any())
            {
                foreach (ItemKitViewModel kitItem in kitItemToDelete)
                {
                    _serviceItemKit.DeleteModelPhysicallyWhithoutTransaction(kitItem.Id, userMail);
                }
            }
            entity.ItemKitIdKitNavigation.Clear();

        }

        public void UpdateItemsBrand(ItemViewModel model, string userMail, Item entity)
        {
            List<ItemVehicleBrandModelSubModelViewModel> itemVehicleBrandModelSubModelToDelete = new List<ItemVehicleBrandModelSubModelViewModel>();
            List<ItemVehicleBrandModelSubModelViewModel> oldItemVehicleBrandModelSubModel = _serviceItemVehicleBrandModelSubModel.FindModelsByNoTracked(x => x.IdItem == model.Id).ToList();

            List<ItemVehicleBrandModelSubModelViewModel> newItemVehicleBrandModelSubModelViewModel = model.ItemVehicleBrandModelSubModel != null ? model.ItemVehicleBrandModelSubModel.ToList() : null;
            if (newItemVehicleBrandModelSubModelViewModel != null && newItemVehicleBrandModelSubModelViewModel.Any())
            {
                List<ItemVehicleBrandModelSubModelViewModel> itemVehicleBrandModelSubModelToAdd = newItemVehicleBrandModelSubModelViewModel.FindAll(x => x.Id == 0);
                foreach (ItemVehicleBrandModelSubModelViewModel itemVehicleBrandModelSubModel in itemVehicleBrandModelSubModelToAdd)
                {
                    itemVehicleBrandModelSubModel.IdItem = entity.Id;
                    _serviceItemVehicleBrandModelSubModel.AddModelWithoutTransaction(itemVehicleBrandModelSubModel, new List<EntityAxisValuesViewModel>(), userMail);
                }
                itemVehicleBrandModelSubModelToDelete = oldItemVehicleBrandModelSubModel.FindAll(x => !newItemVehicleBrandModelSubModelViewModel.Select(y => y.Id).Contains(x.Id));

                List<ItemVehicleBrandModelSubModel> itemVehicleBrandModelSubModelToUpdate = entity.ItemVehicleBrandModelSubModel != null ? entity.ItemVehicleBrandModelSubModel.ToList() : null;
                if (itemVehicleBrandModelSubModelToUpdate != null && itemVehicleBrandModelSubModelToUpdate.Any())
                {
                    entity.ItemVehicleBrandModelSubModel = itemVehicleBrandModelSubModelToUpdate.FindAll(x => x.Id != 0);
                    entity.ItemVehicleBrandModelSubModel.ToList().ForEach(x => _itemVehicleBrandModelSubModelRepo.Update(x));

                }
            }
            else
            {
                itemVehicleBrandModelSubModelToDelete = oldItemVehicleBrandModelSubModel;
            }


            if (itemVehicleBrandModelSubModelToDelete != null && itemVehicleBrandModelSubModelToDelete.Any())
            {
                foreach (ItemVehicleBrandModelSubModelViewModel itemVehicleBrandModelSubModel in itemVehicleBrandModelSubModelToDelete)
                {
                    _serviceItemVehicleBrandModelSubModel.DeleteModelPhysicallyWhithoutTransaction(itemVehicleBrandModelSubModel.Id, userMail);
                }
            }
            entity.ItemVehicleBrandModelSubModel.Clear();

        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<ItemViewModel> GetItemsDataSourceModel(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<Item, bool>> predicateWhere = PredicateUtility<Item>.PredicateFilter(predicateModel, key);
            Expression<Func<Item, object>>[] predicateRelations = PredicateUtility<Item>.PredicateRelation(predicateModel.Relation);
            IEnumerable<Item> entities = new List<Item>();
            int idWarehouse;
            int.TryParse(predicateModel.Filter.FirstOrDefault(x => x.Prop == "IdWarehouse").Value.ToString(), out idWarehouse);
            Expression<Func<Item, bool>> idWarehouseCondition = x => x.ItemWarehouse.Any(y => y.IdWarehouse == idWarehouse);
            // 
            if (idWarehouse > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateRelations).BuildOrderBysQue(predicateModel.OrderBy)
                    .Where(predicateWhere).Where(idWarehouseCondition).Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
                var total = _entityRepo.GetCountWithPredicates(predicateRelations, predicateWhere, idWarehouseCondition);
                return new DataSourceResult<ItemViewModel> { data = entities.Select(c => _builder.BuildEntity(c)).ToList(), total = total };
            }
            else
            {
                return new DataSourceResult<ItemViewModel> { data = entities.Select(c => _builder.BuildEntity(c)).ToList(), total = 0 };
            }
        }

        public List<TecDocArticleViewModel> ExistsInDataBase(List<TecDocArticleViewModel> Articles, TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            var list = Articles.Select(x => x.Id).ToList();
            IQueryable<Item> entities = null;
            entities = _entityRepo.QuerableGetAll().Include(s => s.IdNatureNavigation).Include(s => s.IdProductItemNavigation)
                .Include(s => s.ItemWarehouse).ThenInclude(s => s.IdWarehouseNavigation).Include(x => x.ItemTiers).ThenInclude(x => x.IdTiersNavigation).Where(r => list.Contains(r.TecDocId ?? 0));
            if (teckDockWithFilter.filterSearchItem != null ) { 
            entities = SearchItems(entities, teckDockWithFilter.filterSearchItem);
            }
            IList<Item> itemList =  entities.ToList();
            foreach (TecDocArticleViewModel itemTecDoc in Articles)
            {
                var articleViewModel = itemList.FirstOrDefault(x => x.TecDocId == itemTecDoc.Id);
                itemTecDoc.IsInDb = articleViewModel != null;
                if (itemTecDoc.IsInDb)
                {
                    itemTecDoc.ItemInDB = _ItemListBuilder.BuildListItem(articleViewModel, 1);
                }
            }
            return Articles.OrderByDescending(x => x.IsInDb).ToList();
        }

        public List<TecDocArticleViewModel> ExistsInDataBaseForB2B(List<TecDocArticleViewModel> Articles, TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            var list = Articles.Select(x => x.Id).ToList();
            List<ItemExportPdfViewModel> itemList = _entityRepo.QuerableGetAll().Include(s => s.IdNatureNavigation).Include(s => s.IdProductItemNavigation)
                .Include(s => s.ItemWarehouse).ThenInclude(s => s.IdWarehouseNavigation).Where(r => list.Contains(r.TecDocId ?? 0)).Select(x => new
                ItemExportPdfViewModel
                {
                    Code = x.Code,
                    IdItem = x.Id,
                    Description = x.Description,
                    EquivalenceItem = x.EquivalenceItem,
                    LabelProduct = x.IdProductItemNavigation.LabelProduct,
                    UnitHtsalePrice = x.UnitHtsalePrice ?? 0,
                    TecDocId = x.TecDocId,
                    TecDocRef = x.TecDocRef,
                    TecDocIdSupplier = x.TecDocIdSupplier,
                    isCommnadInProgress = x.ItemWarehouse != null ? x.ItemWarehouse.Sum(z => z.OrderedQuantity) > 0 : false,
                }).ToList();
            foreach (TecDocArticleViewModel itemTecDoc in Articles)
            {
                var articleViewModel = itemList.FirstOrDefault(x => x.TecDocId == itemTecDoc.Id);
                itemTecDoc.IsInDb = articleViewModel != null;
                itemTecDoc.B2bItems = new ItemExportPdfViewModel();
                if (itemTecDoc.IsInDb)
                {
                    itemTecDoc.B2bItems = articleViewModel;
                }
            }
            return Articles.OrderByDescending(x => x.IsInDb).ToList();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DataSourceResult<ItemViewModel> GetItemsInventoryList(PredicateFormatViewModel model)
        {
            return FindDataSourceModelBy(model);
        }

        /// <summary>
        /// GetItemsInventoryList
        /// </summary>
        /// <param name="model">ItemViewModel</param>
        /// <returns></returns>
        public ItemViewModel GetItemsInventoryList(ItemViewModel model)
        {
            return _serviceItemWarehouse.GetItemWarehouseInventory(model, null);
        }


        public override object DeleteModel(int id, string tableName, string userMail)
        {
            ItemViewModel model = GetModelAsNoTracked(m => m.Id.Equals(id));
            model.UpdatedDate = DateTime.Now;
            base.UpdateModel(model, null, userMail);
            var obj = base.DeleteModel(id, tableName, userMail);
            RestorItemListforDropDown();
            return obj;
        }

        /// <summary>
        /// Get item Related to this  
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public IList<ItemViewModel> GetItemEquivalence(ItemToGetEquivalentList model)
        {
            IList<ItemViewModel> allItemEquivalance = new List<ItemViewModel>();
            if (model != null)
            {
                allItemEquivalance = GetEquivalenceData(model.EquivalenceItem, model.Id, model.IdSelectedWarehouse, model.SearchString);
                SetCmdCrpBalanceQtyItem(allItemEquivalance.ToList(), model.IdSelectedWarehouse, model.IsForPurchase);
            }
            return allItemEquivalance.OrderByDescending(x => x.AllAvailableQuantity == 0 ? 0 : x.AllAvailableQuantity).ThenByDescending(x => x.CRP == null ? "" : x.CRP.Substring(0, x.CRP.IndexOf('/'))).ThenByDescending(x => x.CMD == 0 ? 0 : x.CMD).ToList();
        }

        private IList<ItemViewModel> GetEquivalenceData(Guid? EquivalenceItem, int Id, double? IdWarehouse = null, string SearchString = "")
        {
            List<ItemViewModel> allItemEquivalance = new List<ItemViewModel>();
            IQueryable<ItemViewModel> itemEquivalance = GetAllModelsQueryableWithRelation(x => x.EquivalenceItem == EquivalenceItem
             && x.Id != Id, x => x.IdNatureNavigation, x => x.IdProductItemNavigation, x => x.ItemWarehouse);

            if (EquivalenceItem.HasValue)
            {
                if (SearchString != null)
                {
                    itemEquivalance = GetAllModelsQueryableWithRelation(x => x.EquivalenceItem == EquivalenceItem
               && x.Id != Id && (x.Code.Contains((string)SearchString) || x.Description.Contains((string)SearchString)), x => x.IdNatureNavigation, x => x.IdProductItemNavigation);
                }
                else
                {
                    itemEquivalance = GetAllModelsQueryableWithRelation(x => x.EquivalenceItem == EquivalenceItem
                                   && x.Id != Id, x => x.IdNatureNavigation, x => x.IdProductItemNavigation);
                }


                allItemEquivalance = itemEquivalance.ToList();
            }

            GetAllAvailbleQuantity(allItemEquivalance, IdWarehouse);
            return allItemEquivalance;
        }
        public List<ReducedListItemViewModel> GetReducedItemEquivalence(ItemViewModel model)
        {
            List<ReducedListItemViewModel> allItemEquivalance = new List<ReducedListItemViewModel>();
            List<Item> itemEquivalance;
            if (model != null && model.Id>0)
            {
                Item item = _entityRepo.GetSingleNotTracked(x => x.Id == model.Id);
                if (item!=null && item.EquivalenceItem!=null && item.EquivalenceItem.HasValue)
                {
                    itemEquivalance = _entityRepo.GetAllWithConditionsRelationsQueryable(x => ((model.SearchString.NotNullOrEmpty()
                        && (x.Code.ToUpperInvariant().Contains(model.SearchString.ToUpperInvariant()) || x.Description.ToUpperInvariant().Contains(model.SearchString.ToUpperInvariant())))


                        || !model.SearchString.NotNullOrEmpty())
                        
                        && x.EquivalenceItem == item.EquivalenceItem
                    && x.Id != model.Id, x => x.IdNatureNavigation, x => x.IdProductItemNavigation, x => x.ItemWarehouse).Include(x => x.ItemTiers)
                    .ThenInclude(x => x.IdTiersNavigation).ToList();
                    allItemEquivalance = itemEquivalance.Select(x => _ItemListBuilder.BuildListItem(x)).ToList();

                }
            }
            return allItemEquivalance.ToList();
        }

        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public DataSourceResult<ItemViewModel> GetItemsListByWarehouse(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            int idWarehouse = PreparePredicateForItemsRelatedToWarehouse(predicateModel);
            PredicateFilterRelationViewModel<ItemWarehouse> predicateFilterRelationModel = _serviceItemWarehouse.PreparePredicate(predicateModel);
            List<Warehouse> listOfWarehouse = GetListOfWarehouse(idWarehouse);

            List<int> listOfIdItems = _itemWarehouseRepo.QuerableGetAll()
                 .Where(x => listOfWarehouse.Any(y => y.Id == x.IdWarehouse) && x.IdItemNavigation.IdNatureNavigation.IsStockManaged)
                 .Where(predicateFilterRelationModel.PredicateWhere).OrderBy(p => p.IdItem)
                 .Select(x => x.IdItem).Distinct()
                 .Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();

            // Total of returned list
            var total = _itemWarehouseRepo.QuerableGetAll()
                 .Where(x => listOfWarehouse.Any(y => y.Id == x.IdWarehouse) && x.IdItemNavigation.IdNatureNavigation.IsStockManaged)
                 .Where(predicateFilterRelationModel.PredicateWhere).OrderBy(p => p.IdItem)
                 .Select(x => x.IdItem).Distinct().Count();

            // Return list of Items and total
            var relationPredicate = new Expression<Func<Item, object>>[] { x => x.IdNatureNavigation, x => x.IdProductItemNavigation };
            return new DataSourceResult<ItemViewModel>
            {

                data = GetModelsWithConditionsRelations(x => listOfIdItems.Any(y => y == x.Id), relationPredicate).ToList(),
                total = total
            };
        }

        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public DataSourceResult<ItemViewModel> GetAllItemsListByWarehouse(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            int idWarehouse = PreparePredicateForItemsRelatedToWarehouse(predicateModel);
            PredicateFilterRelationViewModel<ItemWarehouse> predicateFilterRelationModel = _serviceItemWarehouse.PreparePredicate(predicateModel);
            List<Warehouse> listOfWarehouse = GetListOfWarehouse(idWarehouse);

            List<int> listOfIdItems = _itemWarehouseRepo.QuerableGetAll()
                 .Where(x => listOfWarehouse.Any(y => y.Id == x.IdWarehouse) && x.IdItemNavigation.IdNatureNavigation.IsStockManaged)
                 .Where(predicateFilterRelationModel.PredicateWhere).OrderBy(p => p.IdItem)
                 .Select(x => x.IdItem).Distinct()
                 .ToList();

            // Total of returned list
            var total = _itemWarehouseRepo.QuerableGetAll()
                 .Where(x => listOfWarehouse.Any(y => y.Id == x.IdWarehouse) && x.IdItemNavigation.IdNatureNavigation.IsStockManaged)
                 .Where(predicateFilterRelationModel.PredicateWhere).OrderBy(p => p.IdItem)
                 .Select(x => x.IdItem).Distinct().Count();

            // Return list of Items and total
            var relationPredicate = new Expression<Func<Item, object>>[] { x => x.IdNatureNavigation };
            return new DataSourceResult<ItemViewModel>
            {

                data = GetModelsWithConditionsRelations(x => listOfIdItems.Any(y => y == x.Id), relationPredicate).ToList(),
                total = total
            };
        }
        /// <summary>
        /// Return the list of warehouse recursively
        /// </summary>
        /// <param name="idWarehouse"></param>
        /// <param name="listOfWarehouse"></param>
        /// <param name="listOfAllWarehouse"></param>
        public void GetWarehouseList(int idWarehouse, IList<Warehouse> listOfWarehouse, IList<Warehouse> listOfAllWarehouse)
        {
            var t = listOfAllWarehouse.Where(x => x.IdWarehouseParent == idWarehouse);

            foreach (var warehouse in t)
            {
                if (warehouse.IsWarehouse)
                {
                    listOfWarehouse.Add(warehouse);
                }
                else
                {
                    GetWarehouseList(warehouse.Id, listOfWarehouse, listOfAllWarehouse);
                }
            }
        }

        /// <summary>
        /// GetItemWarhouseBySelectedWarehouse
        /// </summary>
        /// <param name="item"></param>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        public ItemViewModel GetItemWarhouseBySelectedWarehouse(ItemViewModel item, int idWarehouse)
        {
            List<Warehouse> listOfWarehouse = GetListOfWarehouse(idWarehouse);
            return _serviceItemWarehouse.GetItemWarehouseInventory(item, listOfWarehouse.Select(x => x.Id).ToList());
        }

        /// <summary>
        /// getListOfWarehouse
        /// </summary>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        private List<Warehouse> GetListOfWarehouse(int idWarehouse)
        {
            List<Warehouse> listOfWarehouse = new List<Warehouse>();
            var listOfAllWarehouse = _warehouseRepo.GetAll();
            listOfWarehouse.Add(listOfAllWarehouse.Where(x => x.Id == idWarehouse).FirstOrDefault());
            GetWarehouseList(idWarehouse, listOfWarehouse, listOfAllWarehouse.ToList());
            return listOfWarehouse;
        }
        private int PreparePredicateForItemsRelatedToWarehouse(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            int idWarehouse = Convert.ToInt32(predicateModel.Filter
                                   .FirstOrDefault(p => p.Prop == idWarehouseConst).Value, CultureInfo.InvariantCulture);
            // prepare predicate : adjust the filter to be execut on serviceItemWarehouse
            predicateModel.Filter.Remove(predicateModel.Filter
                    .FirstOrDefault(p => p.Prop == idWarehouseConst));
            predicateModel.Filter.ToList().ForEach(p =>
            {
                p.Prop = "IdItemNavigation." + p.Prop;
                p.IsSearchPredicate = true;
            });
            return idWarehouse;
        }
        public DataSourceResult<ItemListViewModel> FilterItemsByWarehouse(ItemFilterPeerWarehouseViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel = PreparePredicate(predicateModel.predicate);
            return GetDataWithWarehouseFilter(predicateModel, predicateFilterRelationModel);
        }
        public DataSourceResult<ItemExportPdfViewModel> WarehouseFilterForB2B(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails)
        {
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel = PreparePredicate(filterByWarehouseDetails.predicate);
            List<ItemExportPdfViewModel> entities = new List<ItemExportPdfViewModel>();
            var totalData = 0;
            if (filterByWarehouseDetails.predicate.page > 0 && filterByWarehouseDetails.predicate.pageSize > 0)
            {
                var data = GetItemFroB2b(filterByWarehouseDetails, predicateFilterRelationModel);
                entities = data.Skip((filterByWarehouseDetails.predicate.page - 1) * filterByWarehouseDetails.predicate.pageSize)
                 .Take(filterByWarehouseDetails.predicate.pageSize).ToList();
                if (filterByWarehouseDetails.isB2B == true)
                {
                    GetAllAvailbleQuantityForB2b(entities, true);
                }
                totalData = data.Count();
            }

            var total = totalData;
            return new DataSourceResult<ItemExportPdfViewModel> { data = entities, total = total };
        }
        private IList<ItemExportPdfViewModel> GetItemExportPdfFromItem(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails, PredicateFilterRelationViewModel<Item> predicateFilterRelationModel)
        {
            IQueryable<Item> queryItem = GetData(filterByWarehouseDetails, predicateFilterRelationModel);

            IList<ItemExportPdfViewModel> data = queryItem.Select(x => new ItemExportPdfViewModel
            {
                Code = x.Code,
                Description = x.Description,
                UnitHtsalePrice = x.UnitHtsalePrice ?? 0,
                LabelProduct = x.IdProductItemNavigation.LabelProduct,
                IdItem = x.Id,
                EquivalenceItem = x.EquivalenceItem
            }).ToList();
            var idItems = data.Select(x => x.IdItem).ToList();


            var itemVehiculeBrand = _itemVehicleBrandModelSubModelRepo.GetAllAsNoTracking().Include(x => x.IdVehicleBrandNavigation)
                .Select(x => new ItemVehicleBrand
                {
                    LabelVehicule = x.IdVehicleBrandNavigation.Code != null ? x.IdVehicleBrandNavigation.Code : "",
                    IdItem = x.IdItem ?? 0,
                }).ToList().Where(z => idItems.Contains(z.IdItem)).ToList();





            foreach (var item in data)
            {
                var iItemVehicleBrandModel = itemVehiculeBrand.FirstOrDefault(x => x.IdItem == item.IdItem);
                if (iItemVehicleBrandModel != null)
                {
                    item.LabelVehicule = iItemVehicleBrandModel.LabelVehicule;
                }

            }
            return data;
        }
        private IQueryable<ItemExportPdfViewModel> GetItemFroB2b(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails, PredicateFilterRelationViewModel<Item> predicateFilterRelationModel)
        {
            IQueryable<Item> queryItem = GetData(filterByWarehouseDetails, predicateFilterRelationModel);
            var data = queryItem.Include(y => y.ItemWarehouse).Select(x => new ItemExportPdfViewModel
            {
                Code = x.Code,
                Description = x.Description,
                AllAvailableQuantity = x.ItemWarehouse != null ? x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity) : 0,
                UnitHtsalePrice = x.UnitHtsalePrice ?? 0,
                LabelProduct = x.IdProductItemNavigation.LabelProduct,
                IdItem = x.Id,
                EquivalenceItem = x.EquivalenceItem,
                isCommnadInProgress = x.ItemWarehouse != null ? x.ItemWarehouse.Sum(z => z.OrderedQuantity) > 0 : false,

            }).OrderByDescending(x => x.AllAvailableQuantity).ThenByDescending(x => x.isCommnadInProgress);
            return data;
        }

        public List<ItemExportPdfViewModel> ExportPdf(ItemFilterPeerWarehouseViewModel model)
        {
            if (model != null)
            {
                PredicateFilterRelationViewModel<Item> predicateFilterRelationModel = PreparePredicate(model.predicate);
                var data = GetItemExportPdfFromItem(model, predicateFilterRelationModel);
                return data.Skip((model.predicate.page - 1) * model.predicate.pageSize)
                        .Take(model.predicate.pageSize).ToList().OrderBy(x => x.Code).ToList();
            }
            else
            {
                throw new CustomException(CustomStatusCode.EMPTY_LIST);
            }
        }
        private IQueryable<Item> GetData(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails,
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel)
        {
            IQueryable<Item> itemList;
            IQueryable<Item> queryItem = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).Include(x => x.ItemTiers).ThenInclude(x => x.IdTiersNavigation)
                .OrderByRelation(filterByWarehouseDetails.predicate.OrderBy).Where(predicateFilterRelationModel.PredicateWhere);
            if (filterByWarehouseDetails.filtersItemDropdown.idNature.HasValue)
            {
                queryItem = queryItem.Where(x => x.IdNature == filterByWarehouseDetails.filtersItemDropdown.idNature);
            }
            if (filterByWarehouseDetails.filtersItemDropdown.idItemToIgnore.HasValue)
            {
                queryItem = queryItem.Where(x => x.Id != filterByWarehouseDetails.filtersItemDropdown.idItemToIgnore.Value && x.IdNatureNavigation.IsStockManaged);
            }
            if (filterByWarehouseDetails.filtersItemDropdown.minUnitHtSalesPrice.HasValue && filterByWarehouseDetails.filtersItemDropdown.maxUnitHtSalesPrice.HasValue)
            {
                queryItem = queryItem.Where(x => x.UnitHtsalePrice >= filterByWarehouseDetails.filtersItemDropdown.minUnitHtSalesPrice
                && x.UnitHtsalePrice <= filterByWarehouseDetails.filtersItemDropdown.maxUnitHtSalesPrice);
            }
            queryItem = PrepareItemQuery(filterByWarehouseDetails.filtersItemDropdown, queryItem);
            if (filterByWarehouseDetails.filtersItemDropdown.idVehicleBrand != null)
            {
                queryItem = queryItem.Where(x => x.ItemVehicleBrandModelSubModel.Select(z => z.IdVehicleBrand).Contains(filterByWarehouseDetails.filtersItemDropdown.idVehicleBrand.Value));
            }
            if (filterByWarehouseDetails.filtersItemDropdown.idModel != null)
            {
                queryItem = queryItem.Where(x => x.ItemVehicleBrandModelSubModel.Select(z => z.IdModel).Contains(filterByWarehouseDetails.filtersItemDropdown.idModel.Value));
            }
            if (filterByWarehouseDetails.filtersItemDropdown.idSubModel != null)
            {
                queryItem = queryItem.Where(x => x.ItemVehicleBrandModelSubModel.Select(z => z.IdSubModel).Contains(filterByWarehouseDetails.filtersItemDropdown.idSubModel.Value));
            }
            if (filterByWarehouseDetails.filtersItemDropdown.isRestaurn == true)
            {
                var nature = _natureRepo.FindSingleBy(n => n.Code == Constants.RESTAURN).Id;
                queryItem = queryItem.Where(x => x.IdNature == nature);
            }

            if (filterByWarehouseDetails.filtersItemDropdown.isOnlyStockManaged)
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation != null && x.IdNatureNavigation.IsStockManaged);
            }
            if (filterByWarehouseDetails.filtersItemDropdown.isCentralOnly)
            {
                itemList = queryItem.Where(x => x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsCentral).Sum(y => y.AvailableQuantity) > 0);
            }
            else if (filterByWarehouseDetails.filtersItemDropdown.fromEcommerce)
            {
                if (filterByWarehouseDetails.filtersItemDropdown.isEcommerceOrNotOnly == null)
                {
                    itemList = queryItem.Where(x => (x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsCentral).
                    Sum(y => y.AvailableQuantity) > 0) || (x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsEcommerce).
                    Sum(y => y.AvailableQuantity) >= 0));
                }
                else if ((bool)filterByWarehouseDetails.filtersItemDropdown.isEcommerceOrNotOnly)
                {

                    itemList = queryItem.Where(x => ((x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsCentral).
                    Sum(y => y.AvailableQuantity) > 0) || (x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsEcommerce).
                    Sum(y => y.AvailableQuantity) >= 0)) && x.ItemWarehouse.Where(z => z.IdItemNavigation.IsEcommerce).Any());
                }
                else
                {
                    itemList = queryItem.Where(x => ((x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsCentral).
                    Sum(y => y.AvailableQuantity) > 0) || (x.ItemWarehouse.Where(z => z.IdWarehouseNavigation.IsEcommerce).
                    Sum(y => y.AvailableQuantity) >= 0)) && x.ItemWarehouse.Where(z => !z.IdItemNavigation.IsEcommerce).Any());
                }
            }
            if (filterByWarehouseDetails.filtersItemDropdown.isWharehouseFilterRequired && filterByWarehouseDetails.filtersItemDropdown.idWarehouse != null)
            {
                var warehouse = _warehouseRepo.FindSingleBy(x => x.Id == filterByWarehouseDetails.filtersItemDropdown.idWarehouse);

                if (warehouse.IsCentral)
                {
                    itemList = queryItem.Where(x => x.ItemWarehouse.Select(y => y.IdWarehouse).
                    Contains((int)filterByWarehouseDetails.filtersItemDropdown.idWarehouse) &&
                    (filterByWarehouseDetails.filtersItemDropdown.isAvailableInStock ? (x.ItemWarehouse.Sum(y => y.AvailableQuantity - y.ReservedQuantity) > 0) : true));
                }
                else
                {
                    itemList = queryItem.Where(x => x.ItemWarehouse.Select(y => y.IdWarehouse).Contains((int)filterByWarehouseDetails.filtersItemDropdown.idWarehouse) &&
                   (filterByWarehouseDetails.filtersItemDropdown.isAvailableInStock ?
                   x.ItemWarehouse.Where(y => y.IdWarehouse == filterByWarehouseDetails.filtersItemDropdown.idWarehouse).Sum(y => y.AvailableQuantity - y.ReservedQuantity) > 0 : true));
                }
            }
            else
            {
                itemList = queryItem.Where(x => filterByWarehouseDetails.filtersItemDropdown.isAvailableInStock ? x.ItemWarehouse.Sum(y => y.AvailableQuantity - y.ReservedQuantity) > 0 : true);
            }
            return itemList;
        }
        private DataSourceResult<ItemListViewModel> GetDataWithWarehouseFilter(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails,
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel)
        {
            if (predicateFilterRelationModel == null)
            {
                throw new ArgumentNullException(nameof(predicateFilterRelationModel));
            }
            IQueryable<Item> entities = Enumerable.Empty<Item>().AsQueryable();
            var totalData = 0;
            List<ItemViewModel> model = new List<ItemViewModel>();
            if (filterByWarehouseDetails.predicate.page > 0 && filterByWarehouseDetails.predicate.pageSize > 0)
            {
                IQueryable<Item> itemList = GetData(filterByWarehouseDetails, predicateFilterRelationModel);

                entities = itemList.Skip((filterByWarehouseDetails.predicate.page - 1) * filterByWarehouseDetails.predicate.pageSize)
                 .Take(filterByWarehouseDetails.predicate.pageSize);
                if (filterByWarehouseDetails.filtersItemDropdown.isFromExportExcel)
                {
                    List<int> idsTiers = entities.Where(z => z.ItemTiers != null && z.ItemTiers.Any()).Select(y => y.ItemTiers.First().IdTiers).ToList();
                    List<Tiers> tiers = _tierRepo.GetAllWithConditions(y => idsTiers.Contains(y.Id)).ToList();
                    entities = itemList;
                    model = entities.Select(
                        x => new ItemViewModel
                        {
                            Id = x.Id,
                            NameTiers = (x.ItemTiers != null && x.ItemTiers.Any() && x.ItemTiers.First().IdTiers > 0) ? tiers.Where(y => y.Id == x.ItemTiers.First().IdTiers).FirstOrDefault().Name : "",
                            Code = x.Code,
                            Description = x.Description,
                            AllAvailableQuantity = x.AllAvailableQuantity,
                            LabelProduct = x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : "",
                            TecDocRef = x.TecDocRef,
                            UnitHtsalePrice = x.UnitHtsalePrice
                        }).ToList();
                }
                else if (filterByWarehouseDetails.filtersItemDropdown.isSelectOrDeselectAllEcommerce)
                {
                    entities = itemList;
                    model = entities.Select(_builder.BuildEntity).ToList();
                }
                else
                {
                    model = entities.Select(_builder.BuildEntity).ToList();

                }

                totalData = itemList.Count();
            }

            if (filterByWarehouseDetails.filtersItemDropdown.fromEcommerce)
            {
                if (model.Count > 0)
                {
                    Warehouse warehouse = _warehouseRepo.FindSingleBy(x => x.IsEcommerce);
                    List<int> idsItems = model.Select(x => x.Id).ToList();
                    IQueryable<ItemWarehouse> listItemsWarehouse = _itemWarehouseRepo.GetAllWithConditionsQueryable(
                        x => idsItems.Contains(x.IdItem) && x.IdWarehouse == warehouse.Id);

                    model.ForEach(x =>
                    {
                        x.AllAvailableQuantity = 0;
                        ItemWarehouse itemWarehouse = listItemsWarehouse.Where(y => y.IdItem == x.Id).FirstOrDefault();
                        if (itemWarehouse != null)
                        {
                            x.AllAvailableQuantity = _serviceItemWarehouse.GetItemQtyInWarehouse(x.Id, itemWarehouse);
                        }

                    });
                }
            }
            else
            {
                GetAllAvailbleQuantity(model, filterByWarehouseDetails.filtersItemDropdown.idWarehouse);
                SetCmdCrpBalanceQtyItem(model, filterByWarehouseDetails.filtersItemDropdown.idWarehouse, filterByWarehouseDetails.filtersItemDropdown.isForPurchase);
            }
            var orderByQuantity = filterByWarehouseDetails.predicate.OrderBy.FirstOrDefault(x => x.Prop.ToString().ToUpper().Equals("AllAvailableQuantity".ToUpper()));
            if (orderByQuantity != null)
            {
                model = orderByQuantity.Direction == OrderByDirection.DESC ? model.OrderByDescending(x => x.AllAvailableQuantity).ToList() : model.OrderBy(x => x.AllAvailableQuantity).ToList();
            }
            var total = totalData;

            return new DataSourceResult<ItemListViewModel> { data = model.Select(_ItemListBuilder.BuildItem).ToList(), total = total };
        }

        public void SetCmdCrpBalanceQtyItem(List<ItemViewModel> model, int? idWarehouse, bool isForPurchase = false)
        {
            List<int> idsItems = model.Select(y => y.Id).ToList();
            List<DocumentLine> listPurchaseDeliveryProv = _repoDocumentLine.QuerableGetAll().Where(x =>
                x.IdWarehouse == idWarehouse &&
                idsItems.Contains(x.IdItem) &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
                Include(x => x.IdDocumentNavigation).ToList();

            List<StockMovement> listStockMvt = _repoStockMovement.QuerableGetAll().Where(c => c.Operation == OperationEnumerator.Output &&
              idsItems.Contains((int)c.IdItem) && c.IdWarehouse == idWarehouse &&
              c.Status == DocumentEnumerator.Reservation).ToList();
            List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQty = new List<IdItemAndReliquatQtyViewModel>();
            if (isForPurchase)
            {
                idItemAndReliquatQty.AddRange(GetRemainingQty(model.Select(p => p.Id).ToList()));

            }
            model.ForEach(x =>
            {
                // Calcul CMD=(ordredQte- Sum(BR prov)) AND CPR=(Sum(BR prov) - Sum(stock mvt reserved) )
                List<DocumentLine> listPurchaseDeliveryProvByItem = listPurchaseDeliveryProv.Where(y => y.IdItem == x.Id).ToList();
                x.CRP = "0/0";
                double crp = 0;
                double sumMvtQtePurchaseDeliveryP = 0;
                if (listPurchaseDeliveryProvByItem != null && listPurchaseDeliveryProvByItem.Any())
                {
                    sumMvtQtePurchaseDeliveryP = listPurchaseDeliveryProvByItem.Sum(z => z.MovementQty);

                }
                List<StockMovement> listStockMvtByItem = listStockMvt.Where(y => y.IdItem == x.Id).ToList();

                crp = sumMvtQtePurchaseDeliveryP;
                if (listStockMvtByItem != null && listStockMvtByItem.Any())
                {
                    crp = sumMvtQtePurchaseDeliveryP - listStockMvtByItem.Sum(z => z.MovementQty ?? 0);
                }
                x.CRP = crp + "/" + sumMvtQtePurchaseDeliveryP;
                x.CMD = x.OrderedQuantity - sumMvtQtePurchaseDeliveryP;
                if (x.ItemWarehouse != null && x.ItemWarehouse.Any())
                {
                    x.ItemWarehouse.ToList().ForEach(z =>
                    {
                        z.CMD = z.OrderedQuantity;
                        List<DocumentLine> listPurchaseDeliveryProvByItemByWarehouse = listPurchaseDeliveryProvByItem.Where(r => r.IdWarehouse == z.IdWarehouse).ToList();
                        if (listPurchaseDeliveryProvByItemByWarehouse != null && listPurchaseDeliveryProvByItemByWarehouse.Any())
                        {
                            z.CMD = z.CMD - listPurchaseDeliveryProvByItemByWarehouse.Sum(u => u.MovementQty);
                        }
                    });
                }
                if (isForPurchase)
                {
                    x.ReliquatQty = idItemAndReliquatQty.Any(p => p.IdItem == x.Id) ? idItemAndReliquatQty.FirstOrDefault(p => p.IdItem == x.Id).ReliquatQty : 0;
                    x.AvailableDate = idItemAndReliquatQty.Any(p => p.IdItem == x.Id) ? idItemAndReliquatQty.FirstOrDefault(p => p.IdItem == x.Id).AvailableDate : default;
                }

            });
        }
        /// <summary>
        /// get availble quantity for List of Itrm
        /// </summary>
        /// <param name="listItems"></param>
        /// <returns></returns>
        public List<AvailableQuantity> GetAvailbleQuantity(List<int> listItems)
        {
            var listItem = _entityRepo.QuerableGetAll().Include(x => x.ItemWarehouse).Where(x => listItems.Contains(x.Id)).ToList();
            return listItem.Select(p => new AvailableQuantity
            {
                IdItem = p.Id,
                AvailableQuantityValue = p.ItemWarehouse.Sum(x => x.AvailableQuantity),
            }).ToList();
        }

        /// <summary>
        /// Get Irtem Details
        /// </summary>
        /// <param name="listItems"></param>
        /// <returns></returns>
        public List<AmountPerItemDetails> GetAmountPerItem(List<ItemQuantity> listItems)
        {
            var itemlist = listItems.Select(y => y.IdItem);
            var listItem = _entityRepo.QuerableGetAll().Include(x => x.ItemWarehouse).Include(x => x.ItemWarehouse)
                .Include(x => x.IdUnitStockNavigation)
                .Where(x => itemlist.Contains(x.Id)).ToList();
            var company = GetCurrentCompany();

            List<AmountPerItemDetails> result = new List<AmountPerItemDetails>();
            foreach (var item in listItems)
            {

                var iteminList = listItem.FirstOrDefault(x => x.Id == item.IdItem);
                if (iteminList != null)
                {
                    var amountPerItemDetails = new AmountPerItemDetails
                    {
                        IdItem = iteminList.Id,
                        Description = iteminList.Description,
                        Code = listItem.First(x => x.Id == item.IdItem).Code,
                        AvailableQuantity = iteminList.ItemWarehouse.Sum(x => x.AvailableQuantity),
                        AmountWithCurrency = iteminList.UnitHtpurchasePrice ?? 0,
                        TotalAmountWithCurrency = (iteminList.UnitHtpurchasePrice ?? 0) * item.Quantity,
                        Quantity = item.Quantity,
                        CurrencySymbole = company.IdCurrencyNavigation.Symbole,
                        PrecisionCurrency = company.IdCurrencyNavigation.Precision,
                        MesureUnitDescription = iteminList.IdUnitStockNavigation.MeasureUnitCode,
                        MesureUnitPrescion = 0,
                    };
                    result.Add(amountPerItemDetails);
                };
            }
            return result;

        }

        public override DataSourceResult<ItemViewModel> GetListWithSpecificPredicat(PredicateFormatViewModel predicateModel,
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            if (predicateFilterRelationModel == null)
            {
                throw new ArgumentNullException(nameof(predicateFilterRelationModel));
            }
            IList<Item> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }

            IList<ItemViewModel> model = entities.Select(_builder.BuildEntity).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<ItemViewModel> { data = model, total = total };
        }

        public List<ItemViewModel> GetItemDetails(IEnumerable<int> itemsList)
        {
            return _entityRepo.QuerableGetAll().Include(x => x.IdUnitSalesNavigation).Include(x => x.TaxeItem)
                .ThenInclude(x => x.IdTaxeNavigation).Include(x => x.ItemTiers).Where(x => itemsList.Contains(x.Id)).Select(y => _builder.BuildEntity(y)).ToList();
        }

        public DataSourceResult<ItemViewModel> GetItemsAfterFilter(List<int> listId)
        {
            var entity = _entityRepo.FindBy(x => listId.Contains(x.Id)).ToList();
            IList<ItemViewModel> model = entity.Select(_builder.BuildEntity).ToList();
            var total = model.Count;
            return new DataSourceResult<ItemViewModel> { data = model, total = total };
        }


        public int FindIndiceFromDataSourceForGrid(FiltersItemDropdown model, ValueMapperViewModel valueMapperModel)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            List<ItemForDataGrid> listOfItems = new List<ItemForDataGrid>();
            IQueryable<Item> queryItem = FindSearche(model);
            IQueryable<ItemForSearche> queryItemForSearch = null;
            if (model != null && model.idSalesPrice > 0)
            {
                queryItemForSearch = GetItemListforDropDown(queryItem, model.idSalesPrice);
            }
            else
            {
                queryItemForSearch = GetItemListforDropDown(queryItem);
            }


            return queryItemForSearch.OrderBy(p => p.Description)
                .Select(x => x.Id).Distinct().ToList().IndexOf(valueMapperModel.Value);
        }


        private IQueryable<Item> PrepareItemQuery(FiltersItemDropdown model, IQueryable<Item> queryItem)
        {
            if (model.isForPurchase)
            {
                queryItem = queryItem.Where(x => x.IsForPurchase == true);
            }
            if (model.isForSale)
            {
                queryItem = queryItem.Where(x => x.IsForSales == true);
            }
            queryItem = RetriveSeachValues(model.valueToSearch, queryItem, model.constaines);
            queryItem = RetriveSeachValues(model.referenceSearch, queryItem, model.constaines);
            queryItem = SearchByDescription(model.designationSearch, queryItem, model.constaines, true);

            if ((GetCurrentCompany().SaleSettings.SaleAllowItemManagedInStock || GetCurrentCompany().PurchaseSettings.PurchaseAllowItemManagedInStock))
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation.IsStockManaged);
            }

            if (!string.IsNullOrEmpty(model.barCodeSearch))
            {
                queryItem = queryItem.Where(x => x.BarCode1D.Equals(model.barCodeSearch) || x.BarCode2D.Equals(model.barCodeSearch));
            }

            return queryItem;
        }
        private IQueryable<Item> SearchByDescription(string model, IQueryable<Item> queryItem, bool isExactValue, bool isDescription)
        {
            if (!string.IsNullOrEmpty(model) && (model.Contains('%') || model.Contains('*')))
            {
                char[] separator = { '%', '*' };
                string[] listSearch = model.Split(separator);
                if (listSearch.Any())
                {
                    foreach (var item in listSearch)
                    {
                        queryItem = queryItem.Where(x => x.Description.ToLower().Contains(item.ToLower()));
                    }
                }
            }
            else if (!string.IsNullOrEmpty(model))
            {
                queryItem = GetSearchResult(model, queryItem, isExactValue, isDescription);
            }
            return queryItem;
        }
        private IQueryable<Item> RetriveSeachValues(string model, IQueryable<Item> queryItem, bool isExactValue, bool isDescription = false)
        {

            if (!string.IsNullOrEmpty(model) && (model.Contains('%') || model.Contains('*')))
            {
                char[] separator = { '%', '*' };
                string[] listSearch = model.Split(separator);
                if (listSearch.Any())
                {
                    foreach (var item in listSearch)
                    {
                        queryItem = queryItem.Where(x => x.Code.ToLower().Contains(item.ToLower()) || x.Description.ToLower().Contains(item.ToLower()));
                    }
                }
            }
            else if (!string.IsNullOrEmpty(model))
            {
                queryItem = GetSearchResult(model, queryItem, isExactValue, isDescription);
            }
            return queryItem;

        }

        private IQueryable<Item> RetriveSeachValuesForGrid(string model, IQueryable<Item> queryItem, bool isExactValue)
        {
            if (!string.IsNullOrEmpty(model) && (model.Contains('%') || model.Contains('*')))
            {
                char[] separator = { '%', '*' };
                string[] listSearch = model.Split(separator);
                if (listSearch.Any())
                {
                    foreach (var item in listSearch)
                    {
                        string expre = item.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "").ToLower();
                        queryItem = queryItem.Where(x => x.Code.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                        .ToLower().Contains(expre)
                        || x.Description.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                        .ToLower().Contains(item.ToLower()));
                    }
                }
            }
            else if (!string.IsNullOrEmpty(model))
            {
                string expre = model.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "").ToLower();

                if (isExactValue)
                {

                    queryItem = queryItem.Where(x => x.Code.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                    .ToLower().Equals(expre) ||
                    x.Description.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                    .ToLower().Equals(expre) ||
                    x.BarCode1D.Equals(model) ||
                    x.BarCode2D.Equals(model));
                }
                else
                {
                    queryItem = queryItem.Where(x => x.Code.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                    .ToLower().Contains(expre) ||
                    x.Description.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                    .ToLower().Contains(expre) ||
                    x.BarCode1D.Equals(model) ||
                    x.BarCode2D.Equals(model));
                }
            }
            return queryItem;
        }
        private IQueryable<Item> GetSearchResult(string model, IQueryable<Item> queryItem, bool isExactValue, bool isDescription = false)
        {
            if (isExactValue && !isDescription)
            {
                queryItem = queryItem.Where(x => x.Code.Equals(model) || x.Description.Equals(model));
            }
            else
            {
                if (isDescription)
                {
                    queryItem = queryItem.Where(x => x.Description.Contains(model));
                }
                else
                {
                    queryItem = queryItem.Where(x => x.Code.Contains(model) || x.Description.Contains(model));
                }

            }
            return queryItem;
        }

        /// <summary>
        /// Gets the model with relations.
        /// The method receive a generic predicate
        /// and return the model with relations according to the predicate
        /// and the where condition included on the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>TModel.</returns>
        public override ItemViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            FilterViewModel claim = predicateModel.Filter.Where(x => x.Prop == "Claim").FirstOrDefault();
            if (claim != null)
            {
                dynamic claimModel = (dynamic)claim.Value;
                int idit = (int)claimModel["IdItem"].Value;
                string clType = claimModel["ClaimType"].Value;
                int idclt = (int)claimModel["IdClient"].Value;
                int idclaim = (int)claimModel["IdClaim"].Value;
                if (_repoClaim.FindByAsNoTracking(c => c.ClaimType == clType && c.Id != idclaim
                            && c.IdClient == idclt
                            && c.IdItem == idit && c.IdClaimStatus == (int)ClaimStatusEnumerator.NEW_CLAIM).Any())
                {
                    throw new CustomException(CustomStatusCode.AddExistingClaim);
                }
            }
            predicateModel.Filter.Remove(claim);

            Operator key = predicateModel.Operator;
            Expression<Func<Item, bool>> predicate1 = PredicateUtility<Item>.PredicateFilter(predicateModel, key);
            Expression<Func<Item, object>>[] predicate2 = PredicateUtility<Item>.PredicateRelation(predicateModel.Relation);
            var entity = _entityRepo.GetSingleWithRelations(predicate1, predicate2);
            var Listtiers = _tierRepo.GetAllWithConditionsRelationsAsNoTracking(x => entity.ItemTiers.Select(y => y.IdTiers).Contains(x.Id), y => y.IdCurrencyNavigation);
            entity.ItemTiers.ToList().ForEach(x =>
            {
                x.IdTiersNavigation = Listtiers.Where(y => y.Id == x.IdTiers).FirstOrDefault();
            });
            if (entity.ItemKitIdKitNavigation != null && entity.ItemKitIdKitNavigation.Any())
            {
                entity.ItemKitIdKitNavigation.ToList().ForEach(x => x.IdItemNavigation = _entityRepo.FindBy(y => y.Id == x.IdItem).FirstOrDefault());
            }
            if (entity.ItemSalesPrice != null && entity.ItemSalesPrice.Any())
            {
                entity.ItemSalesPrice = _repoItemSalesPrice.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == entity.Id, y => y.IdSalesPriceNavigation).ToList();
            }
            var item = _builder.BuildEntity(entity);
            if (item.ItemSalesPrice != null)
            {
                int precision = GetCompanyCurrencyPrecision();
                item.ItemSalesPrice.ToList().ForEach(itemSale =>
                {
                    itemSale.Price = Math.Round((double)itemSale.Price, precision);
                });
            }


            if (item.UrlPicture != null)
            {
                item.FilesInfos = GetFiles(item.UrlPicture).ToList();
            }
            if (item.OemItem != null && item.OemItem.Any())
            {
                var listOem = _serviceOemItem.GetModelsWithConditionsRelations(x => x.IdItem == item.Id, r => r.IdBrandNavigation);
                item.OemItem = listOem;
            }

            item.IsUsed = _repoStockMovement.QuerableGetAll().Where(x => x.IdItem == entity.Id).Count() > 0 || _repoDocumentLine.QuerableGetAll().Where(x => x.IdItem == entity.Id).Count() > 0;
            if (!RoleHelper.HasPermission("SHOW_PURCHASE_PRICE"))
            {
                item.UnitHtpurchasePrice = null;
            }
            if (!RoleHelper.HasPermission("SHOW_SALES_PRICE"))
            {
                item.UnitHtsalePrice = null;
            }
            return item;
        }
        public List<ReducedListItemViewModel> GetReplacementItems(int id, int? idWarehouse = null)
        {
            ItemToGetEquivalentList model = new ItemToGetEquivalentList
            {
                Id = id,
                IdSelectedWarehouse = idWarehouse
            };
            return GetReplacementItems(model);
        }
        public List<ReducedListItemViewModel> GetReplacementItems(ItemToGetEquivalentList model)
        {

            List<Item> listReplacementItems = new List<Item>();
            List<int> listIdsReplacementItems = new List<int>();
            Item item = _entityRepo.GetSingle(p => p.Id == model.Id);
            Item replacementItem = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.Id == item.IdItemReplacement,
                r => r.IdNatureNavigation, r => r.IdProductItemNavigation, r => r.ItemWarehouse).Include(x => x.ItemTiers)
                   .ThenInclude(x => x.IdTiersNavigation).FirstOrDefault();

            while (replacementItem != null && !listIdsReplacementItems.Contains(replacementItem.Id))
            {
                if (!model.SearchString.NotNullOrEmpty() || (model.SearchString.NotNullOrEmpty() && (replacementItem.Code.ToUpperInvariant().Contains(model.SearchString.ToUpperInvariant())
                        || replacementItem.Description.ToUpperInvariant().Contains(model.SearchString.ToUpperInvariant()))))
                {
                    listReplacementItems.Add(replacementItem);
                }
                listIdsReplacementItems.Add(replacementItem.Id);
                replacementItem = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.Id == replacementItem.IdItemReplacement,
                    r => r.IdNatureNavigation, r => r.IdProductItemNavigation, r => r.ItemWarehouse).Include(x => x.ItemTiers)
                   .ThenInclude(x => x.IdTiersNavigation).FirstOrDefault();
            }
            var AllReplacement = listReplacementItems.Select(p => _ItemListBuilder.BuildListItem(p)).ToList();
            //GetAllAvailbleQuantity(AllReplacement, model.IdSelectedWarehouse);
            //SetCmdCrpBalanceQtyItem(AllReplacement, model.IdSelectedWarehouse, model.IsForPurchase);
            return AllReplacement;
        }

        public void RemoveEquivalentItem(int id)
        {
            BeginTransaction();
            var item = GetModelAsNoTracked(x => x.Id == id);
            if (item != null)
            {
                item.EquivalenceItem = null;
                _entityRepo.Update(_builder.BuildModel(item));
                _unitOfWork.Commit();
            }
            else
            {
                throw new CustomException(CustomStatusCode.NoContent);
            }
            EndTransaction();
        }
        public void RemoveReplacementItem(int id)
        {
            BeginTransaction();
            var item = GetModelAsNoTracked(x => x.Id == id);
            if (item != null)
            {
                item.IdItemReplacement = null;
                _entityRepo.Update(_builder.BuildModel(item));
                _unitOfWork.Commit();
            }
            else
            {
                throw new CustomException(CustomStatusCode.NoContent);
            }
            EndTransaction();
        }
        public void RemoveKitItem(int idSelectedKit, int id)
        {

            var itemkit = _serviceItemKit.GetModelAsNoTracked(y => y.IdItem == idSelectedKit && y.IdKit == id);
            if (itemkit != null)
            {
                _serviceItemKit.DeleteModelPhysically(itemkit.Id, null);
            }
            else
            {
                throw new CustomException(CustomStatusCode.NoContent);
            }

        }

        public IList<ItemViewModel> GenerateItemListFromExcel(Stream excelDataStream, List<string> excelColumnsName)
        {
            IList<ItemViewModel> itemListFromExcel = GetModelListFromExcel(excelDataStream, "Code", excelColumnsName, NumberConstant.Zero);
            IList<ItemViewModel> itemListToReturn = new List<ItemViewModel>();

            foreach (ItemViewModel currentItemFromExcel in itemListFromExcel)
            {
                ItemViewModel existingItem;
                existingItem = GetModelAsNoTracked(x =>
                x.Code.ToLower() == currentItemFromExcel.Code.ToLower());

                // in update employee mode
                if (existingItem != null)
                {
                    itemListToReturn.Add(PatchedExcelItemDataInExistingItem(currentItemFromExcel, existingItem));
                }
            }
            try
            {
                BeginTransaction();
                BulkUpdateModelWithoutTransaction(itemListToReturn, null);
                RestorItemListforDropDown();
                EndTransaction();
            }
            catch
            {
                RollBackTransaction();
            }
            return itemListToReturn;
        }

        private static ItemViewModel PatchedExcelItemDataInExistingItem(ItemViewModel currentItemFromExcel, ItemViewModel existingItem)
        {
            existingItem.Code = currentItemFromExcel.Code;
            existingItem.TecDocId = currentItemFromExcel.TecDocId;
            existingItem.UnitHtsalePrice = currentItemFromExcel.UnitHtsalePrice;
            existingItem.UnitTtcsalePrice = currentItemFromExcel.UnitTtcsalePrice;


            return existingItem;
        }

        private void GetAllAvailbleQuantity(List<ItemViewModel> ItemList, double? idWarehouse = null)
        {
            if (ItemList.Count > 0)
            {
                _serviceItemWarehouse.GetAllAvailbleQuantityFolAllItem(ItemList, false, idWarehouse);
            }
        }

        private void GetAllAvailbleQuantityForB2b(List<ItemExportPdfViewModel> ItemList, bool isB2b = false)
        {
            List<ItemWarehouse> allItemWarehouse;
            if (ItemList.Count > 0)
            {
                var itemIds = ItemList.Select(x => x.IdItem).ToList();
                allItemWarehouse = _itemWarehouseRepo.QuerableGetAll().Include(x => x.IdWarehouseNavigation)
                    .Where(x => itemIds.Contains(x.IdItem)).ToList();
                foreach (var item in ItemList)
                {
                    var allWarehouse = allItemWarehouse.Where(x => x.IdItem == item.IdItem);
                    item.AllAvailableQuantity = allWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity);
                    if (item.AllAvailableQuantity < 0)
                    {
                        item.AllAvailableQuantity = 0;
                    }
                    item.IsAvailable = item.AllAvailableQuantity > 0;
                    if (isB2b)
                    {
                        item.UnitHtsalePrice = (item.IsAvailable || item.isCommnadInProgress) ? item.UnitHtsalePrice : 0;
                    }
                }
            }
        }

        public DataSourceResult<OnOrderQuantityDetailsViewModel> GetOnOrderQuantityDetails(int idItem)
        {
            List<OnOrderQuantityDetailsViewModel> listOnOrderQuantityDetailsViewModel = new List<OnOrderQuantityDetailsViewModel>();

            // Get On Order Quantity Details from Provisioning
            GetOnOrderQuantityDetailsFromProvisioning(idItem, listOnOrderQuantityDetailsViewModel);

            List<DocumentLine> listOfOrderedAndFinalOrderDocumentLineViewModel = _repoDocumentLine
                .QuerableGetAll().Where(x => x.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Refused)
                .Include(x => x.InverseIdDocumentLineAssociatedNavigation)
                .ThenInclude(x => x.IdDocumentNavigation).Include(x => x.IdDocumentNavigation).Where(x => x.IdItem == idItem &&
              (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
            ).ToList();


            if (listOfOrderedAndFinalOrderDocumentLineViewModel != null && listOfOrderedAndFinalOrderDocumentLineViewModel.Any())
            {
                // Get On Order Quantity Details from purchase order
                GetOnOrderQuantityDetailsFromPurchaseOrder(listOfOrderedAndFinalOrderDocumentLineViewModel, listOnOrderQuantityDetailsViewModel);
                // Get On Order Quantity Details from purchase final order
                GetOnOrderQuantityDetailsFromPurchaseFinalOrder(listOfOrderedAndFinalOrderDocumentLineViewModel, listOnOrderQuantityDetailsViewModel);
            }
            return new DataSourceResult<OnOrderQuantityDetailsViewModel> { data = listOnOrderQuantityDetailsViewModel, total = listOnOrderQuantityDetailsViewModel.Count() };
        }

        /// <summary>
        /// getOnOrderQuantityDetailsFromProvisioning
        /// </summary>
        /// <param name="idItem"></param>
        /// <returns></returns>
        List<OnOrderQuantityDetailsViewModel> GetOnOrderQuantityDetailsFromProvisioning(int idItem, List<OnOrderQuantityDetailsViewModel> listOnOrderQuantityDetailsViewModel)
        {
            List<Provisioning> listProvisioningViewModel = _repoProvisioning.GetAllWithConditionsRelations(x => !x.IsPurchaseOrderGenerated &&
             x.ProvisioningDetails.Select(y => y.IdItem).Contains(idItem), x => x.ProvisioningDetails).ToList();
            if (listProvisioningViewModel != null && listProvisioningViewModel.Any())
            {
                foreach (Provisioning provisioningViewModel in listProvisioningViewModel)
                {
                    OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = new OnOrderQuantityDetailsViewModel
                    {
                        Reference = provisioningViewModel.Code,
                        DateDoc = provisioningViewModel.CreationDate ?? (default),
                        Quantity = 0,
                        IdDocumentStatus = 0,
                        IdDocument = provisioningViewModel.Id,
                        IsOrderProject = true,
                        Color = "red"

                    };
                    if (provisioningViewModel.ProvisioningDetails != null && provisioningViewModel.ProvisioningDetails.Any())
                    {
                        onOrderQuantityDetailsViewModel.Quantity = provisioningViewModel.ProvisioningDetails.Where(x => x.IdItem == idItem).FirstOrDefault().MvtQty.Value;
                    }
                    listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                }
            }
            return listOnOrderQuantityDetailsViewModel;
        }


        /// <summary>
        /// getOnOrderQuantityDetailsFromPurchaseOrder
        /// </summary>
        /// <param name="idItem"></param>
        /// <returns></returns>
        List<OnOrderQuantityDetailsViewModel> GetOnOrderQuantityDetailsFromPurchaseOrder(List<DocumentLine> listOfOrderedAndFinalOrderDocumentLineViewModel, List<OnOrderQuantityDetailsViewModel> listOnOrderQuantityDetailsViewModel)
        {
            //Get list order
            List<DocumentLine> listOrderDocumentLineViewModel = listOfOrderedAndFinalOrderDocumentLineViewModel.Where(y => y.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseOrder).ToList();
            if (listOrderDocumentLineViewModel != null && listOrderDocumentLineViewModel.Any())
            {
                // Get list order not imported
                List<DocumentLine> listOrderDocumentLineNotImportedViewModel = listOrderDocumentLineViewModel.Where(y => y.InverseIdDocumentLineAssociatedNavigation == null
                || !y.InverseIdDocumentLineAssociatedNavigation.Any()).ToList();

                foreach (DocumentLine orderDocumentLineNotImportedViewModel in listOrderDocumentLineNotImportedViewModel)
                {
                    OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = PrepareOnOrderQuantityDetailsViewModel(orderDocumentLineNotImportedViewModel, orderDocumentLineNotImportedViewModel.MovementQty, "orange");
                    listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                }

                // Get list order imported
                List<DocumentLine> listOrderDocumentLineImportedViewModel = listOrderDocumentLineViewModel.Where(y => y.InverseIdDocumentLineAssociatedNavigation != null
               && y.InverseIdDocumentLineAssociatedNavigation.Any()).ToList();

                foreach (DocumentLine orderDocumentLineImportedViewModel in listOrderDocumentLineImportedViewModel)
                {
                    double remaingQuantity = orderDocumentLineImportedViewModel.MovementQty - orderDocumentLineImportedViewModel.InverseIdDocumentLineAssociatedNavigation.Sum(c => c.MovementQty);
                    if (remaingQuantity > 0)
                    {
                        OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = PrepareOnOrderQuantityDetailsViewModel(orderDocumentLineImportedViewModel, remaingQuantity, "orange");
                        listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                    }
                }
            }

            return listOnOrderQuantityDetailsViewModel;
        }

        /// <summary>
        /// getOnOrderQuantityDetailsFromPurchaseOrder
        /// </summary>
        /// <param name="idItem"></param>
        /// <returns></returns>
        List<OnOrderQuantityDetailsViewModel> GetOnOrderQuantityDetailsFromPurchaseFinalOrder(List<DocumentLine> listOfOrderedAndFinalOrderDocumentLineViewModel, List<OnOrderQuantityDetailsViewModel> listOnOrderQuantityDetailsViewModel)
        {
            //Get list final order
            List<DocumentLine> listFinalOrderDocumentLineViewModel = listOfOrderedAndFinalOrderDocumentLineViewModel.Where(
                y => y.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder).ToList();
            if (listFinalOrderDocumentLineViewModel != null && listFinalOrderDocumentLineViewModel.Any())
            {
                // Get list final order not imported
                List<DocumentLine> listFinalOrderDocumentLineNotImportedViewModel = listFinalOrderDocumentLineViewModel.Where(y => y.InverseIdDocumentLineAssociatedNavigation == null
                || !y.InverseIdDocumentLineAssociatedNavigation.Any()).ToList();

                foreach (DocumentLine finalOrderDocumentLineNotImportedViewModel in listFinalOrderDocumentLineNotImportedViewModel)
                {
                    OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = PrepareOnOrderQuantityDetailsViewModel(finalOrderDocumentLineNotImportedViewModel, finalOrderDocumentLineNotImportedViewModel.MovementQty, "green");
                    listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                }

                // Get list order imported
                List<DocumentLine> listFinalOrderDocumentLineImportedViewModel = listFinalOrderDocumentLineViewModel.Where(y => y.InverseIdDocumentLineAssociatedNavigation != null
               && y.InverseIdDocumentLineAssociatedNavigation.Any()).ToList();

                foreach (DocumentLine finalOrderDocumentLineImportedViewModel in listFinalOrderDocumentLineImportedViewModel)
                {
                    double remaingQuantity = finalOrderDocumentLineImportedViewModel.MovementQty - finalOrderDocumentLineImportedViewModel.InverseIdDocumentLineAssociatedNavigation.Sum(c => c.MovementQty);
                    if (remaingQuantity > 0)
                    {
                        OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = PrepareOnOrderQuantityDetailsViewModel(finalOrderDocumentLineImportedViewModel, remaingQuantity, "green");
                        listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                    }
                    if (finalOrderDocumentLineImportedViewModel.InverseIdDocumentLineAssociatedNavigation != null && finalOrderDocumentLineImportedViewModel.InverseIdDocumentLineAssociatedNavigation.Any())
                    {
                        List<DocumentLine> listDocLineImportedToBRProv = finalOrderDocumentLineImportedViewModel.InverseIdDocumentLineAssociatedNavigation.Where(y => y.IdDocumentNavigation != null &&
                         y.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).ToList();
                        if (listDocLineImportedToBRProv != null && listDocLineImportedToBRProv.Any())
                        {
                            listDocLineImportedToBRProv.ForEach(z =>
                            {
                                OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = PrepareOnOrderQuantityDetailsViewModel(z, z.MovementQty, "blue");
                                listOnOrderQuantityDetailsViewModel.Add(onOrderQuantityDetailsViewModel);
                            });
                        }

                    }

                }
            }
            return listOnOrderQuantityDetailsViewModel;
        }

        OnOrderQuantityDetailsViewModel PrepareOnOrderQuantityDetailsViewModel(DocumentLine documentLine, double quantity, string color)
        {

            OnOrderQuantityDetailsViewModel onOrderQuantityDetailsViewModel = new OnOrderQuantityDetailsViewModel
            {
                Reference = documentLine.IdDocumentNavigation != null ? documentLine.IdDocumentNavigation.Code : "",
                DateDoc = documentLine.IdDocumentNavigation != null ? documentLine.IdDocumentNavigation.DocumentDate : default,
                Quantity = quantity,
                IdDocumentStatus = documentLine.IdDocumentNavigation != null ? documentLine.IdDocumentNavigation.IdDocumentStatus : default,
                DocumentTypeCode = documentLine.IdDocumentNavigation != null ? documentLine.IdDocumentNavigation.DocumentTypeCode : "",
                IdDocument = documentLine.IdDocumentNavigation != null ? documentLine.IdDocumentNavigation.Id : default,
                IsOrderProject = false,
                Color = color
            };
            return onOrderQuantityDetailsViewModel;
        }

        public void UpdateItemClaims(int idModelToCheck)
        {
            var modelToCheck = _entityRepo.FindSingleBy(x => x.Id == idModelToCheck && x.IsDeleted == false);
            var listclaims = _entityRepoClaim.FindBy(x => x.IdItem == modelToCheck.Id && x.IsDeleted == false);
            modelToCheck.HaveClaims = listclaims.Count() > 0;
            this._entityRepo.Update(modelToCheck);
            this._unitOfWork.Commit();
        }

        public void UpdateItemClaims(Item modelToCheck)
        {
            var listclaims = _entityRepoClaim.FindBy(x => x.IdItem == modelToCheck.Id);
            modelToCheck.HaveClaims = listclaims.Count() > 0;
            this._entityRepo.Update(modelToCheck);
            this._unitOfWork.Commit();
        }

        public void CheckItemClaims(List<Item> entities)
        {
            var identities = entities.Select(x => x.Id).ToList();
            var listclaims = _entityRepoClaim.FindBy(x => identities.Contains((int)x.IdItem));
            List<ItemViewModel> model = entities.Select(x => _builder.BuildEntity(x)).ToList();
            model.ForEach(x => x.HaveClaims = listclaims.Select(p => p.IdItem).Contains(x.Id));
        }

        public DataSourceResult<ItemForDataGrid> GetItemDropDownListForDataGrid(FiltersItemDropdown model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            int page = (model.skip / model.take) + 1;
            int pageSize = model.take;

            List<ItemForDataGrid> listOfItems = new List<ItemForDataGrid>();
            int total = 0;
            Tiers customer = null;
            if (model.idCustomer != null && model.idCustomer > 0)
            {
                customer = _tierRepo.GetSingle(x => x.Id == model.idCustomer.Value);
                if (customer.IdSalesPrice != null && customer.IdSalesPrice > 0)
                {
                    model.idSalesPrice = (int)customer.IdSalesPrice;
                }
                else
                {
                    model.idSalesPrice = 0;
                }
            }
            IQueryable<Item> queryItem = FindSearche(model);
            IQueryable<ItemForSearche> queryItemForSearch = null;
            if (model != null && model.idSalesPrice > 0)
            {
                queryItemForSearch = GetItemListforDropDown(queryItem, model.idSalesPrice);
            }
            else
            {
                queryItemForSearch = GetItemListforDropDown(queryItem);
            }

            if (model.isForReappro)
            {
                listOfItems = queryItemForSearch.Select(x => new ItemForDataGrid
                {
                    Id = x.Id,
                    Code = x.Code,
                    Description = x.Description,
                    IsDecomposable = x.isDecomposable,
                    DigitsAfterComma = x.DigitsAfterComma,
                    Marque = x.Marque,
                })
            .Skip((page - 1) * pageSize).Take(pageSize).ToList();
                total = queryItemForSearch.Count();

                // Return list of Items and total  &
                return new DataSourceResult<ItemForDataGrid>
                {
                    data = listOfItems,
                    total = total
                };
            }
            listOfItems = queryItemForSearch.Select(x => new ItemForDataGrid { Id = x.Id, Code = x.Code, Description = x.Description, UnitHtsalePrice = x.UnitHtsalePrice, Marque = x.Marque })
             .Skip((page - 1) * pageSize).Take(pageSize).ToList();
            total = queryItemForSearch.Count();

            // Return list of Items and total  &
            return new DataSourceResult<ItemForDataGrid>
            {
                data = listOfItems,
                total = total
            };
        }

        private IQueryable<Item> FindSearche(FiltersItemDropdown model)
        {
            IQueryable<Item> queryItem = null;
            if (model != null && model.idSalesPrice > 0)
            {
                queryItem = _entityRepo.QuerableGetAll().Where(x => x.Code != "Remise" && x.Description != "Remise").Include(x => x.ItemWarehouse).Include(x => x.IdUnitStockNavigation).Include(z => z.ItemTiers).Include(x => x.ItemSalesPrice).ThenInclude(x => x.IdSalesPriceNavigation);


                //GetItemListforDropDown(model.idSalesPrice);
            }
            else
            {
                queryItem = _entityRepo.QuerableGetAll().Include(x => x.ItemWarehouse).Include(x => x.IdUnitStockNavigation).Include(z => z.ItemTiers);

                //queryItem = GetItemListforDropDown();
            }
            if (model.isAdvancePaymentNature != null && model.isAdvancePaymentNature == true)
            {
                int natureAvance = _natureRepo.FindSingleBy(n => n.Code == Constants.ADVANCE_PAYEMENT).Id;
                queryItem = queryItem.Where(x => x.IdNature == natureAvance);
            }
            if (model.isForPurchase)
            {
                queryItem = queryItem.Where(x => x.IsForPurchase == true).OrderBy(x => x.Description);
            }
            if (model.isForSale)
            {
                queryItem = queryItem.Where(x => x.IsForSales == true).OrderBy(x => x.Description);
            }
            if (model.isSubFinal)
            {
                queryItem = queryItem.Where(x => x.IsForSales == true && x.IsForPurchase == false).OrderBy(x => x.Description);
            }
            if (model.idWarehouse != null)
            {
                queryItem = queryItem.Where(x => x.ItemWarehouse.Select(y => y.IdWarehouse).Contains((int)model.idWarehouse)).OrderBy(x => x.Description);
            }
            if (model.idTiers != null && model.idTiers.Any())
            {
                queryItem = queryItem.Where(x => x.ItemTiers != null && x.ItemTiers.Any() && x.ItemTiers.Where(y => model.idTiers.Contains(y.IdTiers)).Any());
            }
            if (model.idItemToCharge != null && model.idItemToCharge.Any())
            {
                queryItem = queryItem.Where(x => model.idItemToCharge.Contains(x.Id));
            }
            if (model.isOnlyProductNature)
            {
                var nature = _natureRepo.FindSingleBy(n => n.Code == Constants.PRODUIT).Id;
                queryItem = queryItem.Where(x => x.IdNature == nature).OrderBy(x => x.Description);
            }
            queryItem = RetriveSeachValuesForGrid(model.valueToSearch, queryItem, model.constaines);
            if (model.ignoreCharges == true)
            {
                var nature = _natureRepo.FindSingleBy(n => n.Code == Constants.EXPENSE).Id;
                queryItem = queryItem.Where(x => x.IdNature != nature).OrderBy(x => x.Description);
            }
            if (model.idItemToIgnore.HasValue)
            {
                queryItem = queryItem.Where(x => x.Id != model.idItemToIgnore.Value).OrderBy(x => x.Description);
            }

            if (model.fromEcommerce == true)
            {
                queryItem = queryItem.Where(x => x.ExistInEcommerce == true || x.IsEcommerce == true).OrderBy(x => x.Description);
            }
            if (model.isRestaurn == true)
            {
                Nature nature = _natureRepo.FindSingleBy(n => n.Code == Constants.RESTAURN);
                if (nature != null)
                {
                    queryItem = queryItem.Where(x => x.IdNature == nature.Id).OrderBy(x => x.Description);
                }
            }
            if (model.isOnlyStockManaged)
            {
                List<int> stockManagedNatures = _natureRepo.GetAllWithConditionsRelations(x => x.IsStockManaged).Select(x => x.Id).ToList();
                queryItem = queryItem.Where(x => stockManagedNatures.Contains((int)x.IdNature)).OrderBy(x => x.Description);
            }
            if (model.idStorage.HasValue)
            {
                var ids = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.ItemWarehouse.Where(y => y.IdStorage == model.idStorage).Any()).Select(x => x.Id);
                queryItem = queryItem.Where(x => ids.Contains(x.Id));
            }
            if (model.id.HasValue)
            {
                queryItem = queryItem.Where(x => x.Id == model.id.Value);
            }
            if (model.hasTiers)
            {
                queryItem = queryItem.Where(x => x.ItemTiers.Any());
            }
            return queryItem;
        }


        public List<ReducedListItemViewModel> GetItemKit(ItemToGetEquivalentList model)
        {
            var itemsId = GetKitData(model.Id);
            List<Item> allItemEquivalance = new List<Item>();
            List<ReducedListItemViewModel> allItemKit = new List<ReducedListItemViewModel>();
            if (model.SearchString != null)
            {
                allItemEquivalance = _entityRepo.GetAllWithConditionsRelationsQueryable(x => itemsId.Contains(x.Id) && (x.Code.Contains((string)model.SearchString)
               || x.Description.Contains((string)model.SearchString)),
               x => x.IdNatureNavigation, x => x.IdProductItemNavigation, x => x.ItemWarehouse)
               .Include(x => x.ItemTiers)
                   .ThenInclude(x => x.IdTiersNavigation).ToList();
            }
            else
            {
                allItemEquivalance = _entityRepo.GetAllWithConditionsRelationsQueryable(x => itemsId.Contains(x.Id),
                    x => x.IdNatureNavigation, x => x.IdProductItemNavigation, x => x.ItemWarehouse)
                    .Include(x => x.ItemTiers)
                   .ThenInclude(x => x.IdTiersNavigation).ToList();
            }
            allItemKit = allItemEquivalance.Select(x => _ItemListBuilder.BuildListItem(x)).ToList();

            //GetAllAvailbleQuantity(allItemEquivalance, model.IdSelectedWarehouse);
            //SetCmdCrpBalanceQtyItem(allItemEquivalance, model.IdSelectedWarehouse, model.IsForPurchase);
            return allItemKit;
        }
        private IQueryable<int> GetKitData(int id)
        {
            IQueryable<int> itemsId;
            var item = GetModelWithRelations(x => x.Id == id);
            if (item.IsKit)
            {
                itemsId = _itemKitRepo.GetAllWithConditionsQueryable(x => x.IdItem != null && x.IdKit == item.Id || (item.EquivalenceItem != null && x.IdKitNavigation.EquivalenceItem == item.EquivalenceItem)).Select(x => (int)x.IdItem);
            }
            else
            {
                itemsId = _itemKitRepo.GetAllWithConditionsQueryable(x => x.IdKit != null && x.IdItem == item.Id || (item.EquivalenceItem != null && x.IdItemNavigation.EquivalenceItem == item.EquivalenceItem)).Select(x => (int)x.IdKit);
            }
            return itemsId;
        }

        public List<ItemExportPdfViewModel> GetKitForB2b(int id)
        {
            var itemsId = GetKitData(id);
            var allItemEquivalance = _entityRepo.QuerableGetAll().Include(x => x.IdNatureNavigation)
                .Include(x => x.IdProductItemNavigation).Where(x => itemsId.Contains(x.Id)).Select(x => new ItemExportPdfViewModel
                {
                    Code = x.Code,
                    Description = x.Description,
                    AllAvailableQuantity = x.AllAvailableQuantity,
                    UnitHtsalePrice = x.UnitHtsalePrice ?? 0,
                    LabelProduct = x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : "",
                    IdItem = x.Id,
                    EquivalenceItem = x.EquivalenceItem,
                    IsAvailable = x.AllAvailableQuantity > 0,
                    isCommnadInProgress = x.ItemWarehouse != null ? x.ItemWarehouse.Sum(z => z.OrderedQuantity) > 0 : false,
                }).OrderByDescending(x => x.AllAvailableQuantity).ToList();
            GetAllAvailbleQuantityForB2b(allItemEquivalance, true);
            return allItemEquivalance.OrderByDescending(x => x.AllAvailableQuantity).ToList();
        }

        public List<ItemViewModel> GetItemsInventoryDetails(IList<int> itemIdList)
        {
            List<Item> listofItem = _entityRepo.GetAllAsNoTracking().Where(x => itemIdList.Contains(x.Id)).Include(x => x.ItemWarehouse).Include(x => x.IdNatureNavigation).ToList();
            return listofItem.Select(c => _builder.BuildEntity(c)).ToList();
        }
        public void UpdateItemEquivalentDesignation(ReducedEquivalentItem itemToUpdate)
        {
            _entityRepo.QuerableGetAll().Where(p => p.EquivalenceItem == itemToUpdate.EquivalenceItem)
               .UpdateFromQuery(x => new Item { Description = itemToUpdate.Description });
        }

        public List<IdItemAndReliquatQtyViewModel> GetRemainingQty(List<int> listItemId)
        {

            List<IdItemAndReliquatQtyViewModel> IdItemAndReliquatQtyList = new List<IdItemAndReliquatQtyViewModel>();

            var result = GetBalancedList(0, listItemId);
            foreach (var item in result)
            {
                IdItemAndReliquatQtyViewModel IdItemAndReliquatQty = new IdItemAndReliquatQtyViewModel
                {
                    IdItem = item.IdItem,
                    ReliquatQty = item.QtyBalance,
                    AvailableDate = item.DateDispo
                };
                IdItemAndReliquatQtyList.Add(IdItemAndReliquatQty);
            }

            return IdItemAndReliquatQtyList;
        }


        public List<IdItemAndReliquatQtyViewModel> GetReliquatQty(List<int> idItems)
        {
            List<IdItemAndReliquatQtyViewModel> IdItemAndReliquatQtyList = new List<IdItemAndReliquatQtyViewModel>();

            List<DocumentLine> AllImporterLines = _repoDocumentLine.QuerableGetAll().
            Include(x => x.IdDocumentLineAssociatedNavigation)
            .Include(x => x.IdDocumentNavigation).Where(x => x.IdDocumentLineAssociated != null &&
            x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder &&
            idItems.Contains(x.IdItem) && x.IdDocumentLineAssociatedNavigation != null).ToList();

            if (AllImporterLines != null && AllImporterLines.Any())
            {
                var DocumentIds = AllImporterLines
                  .Select(x => x.IdDocumentLineAssociatedNavigation.IdDocument).ToList();

                var listImpotedLinesQuerable = _repoDocumentLine.QuerableGetAll().Include(x => x.IdItemNavigation).Include(x => x.IdDocumentNavigation).
                ThenInclude(x => x.IdUsedCurrencyNavigation).Include(x => x.IdDocumentNavigation.IdTiersNavigation).Include(p => p.IdMeasureUnitNavigation).
                Where(x => DocumentIds.Contains(x.IdDocument) &&
                (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid ||
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied) &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseOrder &&
                x.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Refused);

                List<DocumentLine> listImpotedLines = listImpotedLinesQuerable.ToList();

                listImpotedLines.ForEach(x =>
                {
                    var importedQuantity = AllImporterLines.Where(y => y.IdDocumentLineAssociated == x.Id && y.IdItem == x.IdItem).Sum(y => y.MovementQty);

                    if (x.MovementQty > importedQuantity)
                    {
                        IdItemAndReliquatQtyViewModel IdItemAndReliquatQty = new IdItemAndReliquatQtyViewModel
                        {
                            IdItem = x.IdItem,
                            ReliquatQty = AmountMethods.FormatValue((x.MovementQty - importedQuantity), x.IdMeasureUnitNavigation != null ? x.IdMeasureUnitNavigation.DigitsAfterComma : 0),
                            AvailableDate = x.DateAvailability
                        };
                        IdItemAndReliquatQtyList.Add(IdItemAndReliquatQty);
                    }
                });

            }
            return IdItemAndReliquatQtyList;
        }


        public List<BalanceDocumentLine> GetBalancedList(int idTiers, List<int> idItems = null,
            string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false)
        {
            List<BalanceDocumentLine> listBalance = new List<BalanceDocumentLine>();

            var AllImporterLinesQuerable = _repoDocumentLine.QuerableGetAll().
            Include(x => x.IdDocumentLineAssociatedNavigation)
            .Include(x => x.IdDocumentNavigation).Where(x => x.IdDocumentLineAssociated != null &&
            x.IdDocumentNavigation.DocumentTypeCode == (importerDocumentType ?? DocumentEnumerator.PurchaseFinalOrder));

            if (AllImporterLinesQuerable != null)
            {
                List<DocumentLine> listImporterLinesFinal = idTiers > 0
                    ? AllImporterLinesQuerable.Where(x => x.IdDocumentNavigation.IdTiers == idTiers).ToList()
                    : AllImporterLinesQuerable.Where(x => idItems.Contains(x.IdItem)).ToList();
                var DocumentIds = listImporterLinesFinal.Where(x => x.IdDocumentLineAssociatedNavigation != null)
                    .Select(x => x.IdDocumentLineAssociatedNavigation.IdDocument).ToList();

                if (listImporterLinesFinal != null && listImporterLinesFinal.Any())
                {
                    var listImpotedLinesQuerable = _repoDocumentLine.QuerableGetAll().Include(x => x.IdItemNavigation).Include(x => x.IdDocumentNavigation).
                        ThenInclude(x => x.IdUsedCurrencyNavigation).Include(x => x.IdDocumentNavigation.IdTiersNavigation).Include(p => p.IdMeasureUnitNavigation).
                        Where(x => DocumentIds.Contains(x.IdDocument) &&
                        (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid ||
                        x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied) &&
                        x.IdDocumentNavigation.DocumentTypeCode == (importedDocumentType ?? DocumentEnumerator.PurchaseOrder) &&
                        x.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Refused);
                    if (isFromB2B)
                    {
                        listImpotedLinesQuerable = listImpotedLinesQuerable.Where(x => (bool)x.IdDocumentNavigation.IsBtoB);
                    }
                    List<DocumentLine> listImpotedLines = listImpotedLinesQuerable.ToList();
                    var isSalesDocument = importerDocumentType != null && importerDocumentType.EndsWith("SA");
                    BalanceDocumentLine balanceDocumentLine;
                    listImpotedLines.ForEach(x =>
                    {
                        var importedQuantity = listImporterLinesFinal.Where(y => y.IdDocumentLineAssociated == x.Id && y.IdItem == x.IdItem).Sum(y => y.MovementQty);

                        if (x.MovementQty > importedQuantity)
                        {
                            _serviceItemWarehouse.GetAvailbleQuantityForItem(x.IdItemNavigation);
                            balanceDocumentLine = new BalanceDocumentLine()
                            {
                                Reference = x.IdItemNavigation.Code,
                                Designation = x.IdItemNavigation.Description,
                                QtyBalance = AmountMethods.FormatValue((x.MovementQty - importedQuantity), x.IdMeasureUnitNavigation != null ? x.IdMeasureUnitNavigation.DigitsAfterComma : 3),
                                QtyStock = x.IdItemNavigation.AllAvailableQuantity,
                                PUPurchase = x.IdItemNavigation.UnitHtpurchasePrice != null && !isSalesDocument ? x.IdItemNavigation.UnitHtpurchasePrice.Value : default,
                                TotalPuPurchase = 0,
                                PUSales = x.IdItemNavigation.UnitHtsalePrice != null && isSalesDocument ? x.IdItemNavigation.UnitHtsalePrice.Value : default,
                                TotalSales = 0,
                                CodeOrderDocument = x.IdDocumentNavigation.Code,
                                StatusDocument = x.IdDocumentNavigation.IdDocumentStatus,
                                DateOrderDocument = x.IdDocumentNavigation.DocumentDate,
                                DateDispo = x.DateAvailability,
                                IdLine = x.Id,
                                IdDocument = x.IdDocument,
                                SymboleCurrency = x.IdDocumentNavigation.IdUsedCurrencyNavigation.Symbole,
                                PrecisionCurrency = x.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision,
                                IdItem = x.IdItem,
                                FormatOption = _TiersBuilder.BuildEntity(x.IdDocumentNavigation.IdTiersNavigation).FormatOption
                            };
                            if (isSalesDocument)
                            {
                                balanceDocumentLine.TotalSales = balanceDocumentLine.PUSales * balanceDocumentLine.QtyBalance;
                            }
                            else
                            {
                                balanceDocumentLine.TotalPuPurchase = balanceDocumentLine.PUPurchase * balanceDocumentLine.QtyBalance;
                            }
                            listBalance.Add(balanceDocumentLine);
                        }
                    });
                }
            }

            return listBalance.OrderByDescending(x => x.DateOrderDocument).ToList();
        }
        /// <summary>
        /// Manget File Delete file and copy new file 
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        public void ManagePicture(ItemViewModel item)
        {  //Mange Observations Files
            StringBuilder codeItem = new StringBuilder();
            codeItem.Append("_").Append(item.Code);
            if (string.IsNullOrEmpty(item.UrlPicture))
            {
                if (item.PictureFileInfo != null)
                {
                    item.UrlPicture = Path.Combine("Inventory", "Item",codeItem.ToString(), Guid.NewGuid().ToString());
                    CopyFiles(item.UrlPicture, item.PictureFileInfo);
                    DownloadFiles(item.UrlPicture, item.TecDocImageList);
                }
                else if (item.FilesInfos != null)
                {
                    item.UrlPicture = Path.Combine("Inventory", "Item", codeItem.ToString(), Guid.NewGuid().ToString());
                    CopyFiles(item.UrlPicture, item.FilesInfos);
                    DownloadFiles(item.UrlPicture, item.TecDocImageList);
                }

            }
            else {
                List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                string seperator = item.UrlPicture.IndexOf('/') != -1 ? "/" : @"\";
                StringBuilder codeWithSeparator = new StringBuilder();
                codeWithSeparator.Append(seperator).Append(item.Code);
                if (!item.UrlPicture.Contains("_" + codeWithSeparator.ToString()))
                {

                    var url = item.UrlPicture.Substring(0, item.UrlPicture.LastIndexOf(seperator));
                    DeleteDirectory(url);
                    item.UrlPicture = Path.Combine("Inventory", "Item", codeItem.ToString(), Guid.NewGuid().ToString());
                    CopyFiles(item.UrlPicture, item.FilesInfos);
                    DownloadFiles(item.UrlPicture, item.TecDocImageList);
                }
                else
                {
                    if (item.PictureFileInfo != null)
                    {
                        fileInfo.Add(item.PictureFileInfo);
                    }
                    if (item.FilesInfos != null)
                    {
                        fileInfo = item.FilesInfos.ToList();
                    }
                    DeleteFiles(item.UrlPicture, fileInfo);
                    CopyFiles(item.UrlPicture, fileInfo);
                    DownloadFiles(item.UrlPicture, item.TecDocImageList);
                }
            }
        }
        public ItemViewModel VerifyUpdatedPicture(ItemViewModel model)
        {
            foreach (var file in model.FilesInfos)
            {
                string nameFile = file.Name;
                //Combine url with name of file
                var fileUrl = Path.Combine(model.UrlPicture, nameFile);
                //If File doesn't exist==> copy file
                if (!File.Exists(fileUrl))
                {
                    model.UpdatedDatePicture = DateTime.Now;
                }
            }
            return model;
        }
        /// <summary>
        /// Affect same GUID to all equivalent products and return masterItem
        /// </summary>
        /// <param name="equivalentItems"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public ItemViewModel AffectEquivalentItem(EquivalentItemsViewModel equivalentItems, string userMail)
        {

            try
            {
                BeginTransaction();

                IList<ItemViewModel> equivalentItemsOfMaster = new List<ItemViewModel>();

                ItemViewModel masterItem = GetModelAsNoTracked(x => x.Id == equivalentItems.IdMasterItem);
                ItemViewModel itemToAffect = GetModelAsNoTracked(x => x.Id == equivalentItems.IdItemToAffect);
                itemToAffect.UpdatedDate = DateTime.Now;
                equivalentItemsOfMaster.Add(itemToAffect);

                if (masterItem.EquivalenceItem == null && itemToAffect.EquivalenceItem == null)
                {
                    masterItem.EquivalenceItem = itemToAffect.EquivalenceItem = Guid.NewGuid(); 
                    UpdateModelWithoutTransaction(masterItem, null, userMail);
                }
                else if (masterItem.EquivalenceItem != null)
                {

                    if (itemToAffect.EquivalenceItem != null)
                    {
                        List<ItemViewModel> equivalentItemsOfItemToAffect = FindByAsNoTracking(x =>
                           x.EquivalenceItem == itemToAffect.EquivalenceItem && x.Id != itemToAffect.Id).ToList();

                        equivalentItemsOfItemToAffect.ForEach(x =>
                        {
                            x.EquivalenceItem = masterItem.EquivalenceItem;
                            x.UpdatedDate = DateTime.Now;
                            equivalentItemsOfMaster.Add(x);
                        });
                    }

                    itemToAffect.EquivalenceItem = masterItem.EquivalenceItem;
                }
                else // itemToAffect.EquivalenceItem != null && masterItem.EquivalenceItem == null
                {
                    masterItem.EquivalenceItem = itemToAffect.EquivalenceItem;
                    UpdateModelWithoutTransaction(masterItem, null, userMail);
                }

                BulkUpdateModelWithoutTransaction(equivalentItemsOfMaster, userMail);
                EndTransaction();
                return masterItem;
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
        /// <summary>
        /// Get Items Filling IsAffected To price
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public DataSourceResultWithSelections<ItemViewModel> GetItemsFillingIsAffected(PredicateFormatViewModel predicateModel, int idPrice)
        {
            int page = predicateModel.page;
            int pageSize = predicateModel.pageSize;
            predicateModel.page = 0;
            predicateModel.pageSize = 0;
            IQueryable<Item> resultItems = null;
            PredicateFilterRelationViewModel<Item> predicateFilter = PreparePredicate(predicateModel);
            if (predicateModel.Filter != null && predicateModel.Filter.Any())
            {
                var tierFilter = predicateModel.Filter.Where(x => x.Prop == "IdTier").FirstOrDefault();
                var marqueFilter = predicateModel.Filter.Where(x => x.Prop == "IdProductItem").FirstOrDefault();
                var itemFilter = predicateModel.Filter.Where(x => x.Prop == "ItemName").FirstOrDefault();
                //Search item 
                resultItems = _entityRepo.QuerableGetAll().Include(x => x.IdProductItemNavigation).Include(x => x.ItemTiers).ThenInclude(y => y.IdTiersNavigation)
               .Where(x => (tierFilter != null ? (x.ItemTiers != null && x.ItemTiers.Any() && x.ItemTiers.Where(y => int.Parse(tierFilter.Value.ToString()) == y.IdTiers).Any()) : true) &&
                           (marqueFilter != null ? x.IdProductItem == int.Parse(marqueFilter.Value.ToString()) : true) &&
                           (itemFilter != null ? ((x.Code != null && x.Code.ToUpper().Contains(itemFilter.Value.ToString().ToUpper())) || (x.Description != null && x.Description.ToUpper().Contains(itemFilter.Value.ToString().ToUpper()))) : true))
                                     ;
            }
            else
            {
                resultItems = _entityRepo.QuerableGetAll().Include(x => x.IdProductItemNavigation).Include(x => x.ItemTiers)
                                               .ThenInclude(y => y.IdTiersNavigation);
            }

            List<ItemViewModel> listOfItemViewodel = resultItems.Skip((page - 1) * pageSize).Take(pageSize).Select(x => _ItemListBuilder.BuildItemEntity(x)).ToList();

            List<int> allItemsIdInPredicate = resultItems.Select(x => x.Id).ToList();

            IList<ItemPricesViewModel> affectedItemPrices = _serviceItemPrices
                .FindByAsNoTracking(x => x.IdPrices == idPrice && allItemsIdInPredicate.Contains(x.IdItem));
            foreach (var item in listOfItemViewodel)
            {
                IList<ItemPricesViewModel> tiersPricesOfCurrentTier = affectedItemPrices.Where(x => x.IdItem == item.Id).ToList();
                item.IsAffected = tiersPricesOfCurrentTier != null && tiersPricesOfCurrentTier.Count > 0;
            }
            return new DataSourceResultWithSelections<ItemViewModel>
            {

                data = listOfItemViewodel,
                total = resultItems.Count(),
                totalSelection = affectedItemPrices.Count
            };
        }
        public ReducedListItemViewModel GetReducedItemData(int id)
        {
            Item item = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.Id == id,
                r => r.IdNatureNavigation, r => r.IdProductItemNavigation, r => r.ItemWarehouse).Include(x => x.ItemTiers)
                   .ThenInclude(x => x.IdTiersNavigation).FirstOrDefault();
            ReducedListItemViewModel reducedItem = _ItemListBuilder.BuildListItem(item);
            return reducedItem;
        }
        public DataSourceResult<ReducedListItemViewModel> GetListDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            var companyCurrency = _serviceCompany.GetCurrentCompanyCurrency();
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Item> entities = null;
            bool predAllAvailableQuantity = false;
            PredicateFilterRelationViewModel<Item> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "Code")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "Description";
                }
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "LabelProduct")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "IdProductItemNavigation.LabelProduct";
                }
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "AllAvailableQuantity")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "";
                    predAllAvailableQuantity = true;
                }
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "NameTiers")
                {
                    if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                    {
                        entities = entities.OrderBy(x => x.ItemTiers.FirstOrDefault().IdTiersNavigation.Name);
                    }
                    else
                    {
                        entities = entities.OrderByDescending(x => x.ItemTiers.FirstOrDefault().IdTiersNavigation.Name);
                    }
                }
                entities = GetEntitiesDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
                var predTiers = predicateModel[0].Filter.Where(x => x.Prop == "IdTiers").FirstOrDefault();
                bool isTiersFilter = predTiers != null ? true : false;
                List<int> tiers = new List<int>();
                if (isTiersFilter)
                {
                    tiers = JsonConvert.DeserializeObject<List<int>>((predTiers.Value).ToString());
                    if (tiers.Count == 1)
                    {
                        entities = entities.Where(x => x.ItemTiers != null && x.ItemTiers.Select(y => y.IdTiers).Contains(tiers.FirstOrDefault()));
                    }
                    else
                    {
                        List<ItemTiers> idItemTiers = entities.Where(x => x.ItemTiers != null && x.ItemTiers.Any()).SelectMany(x => x.ItemTiers).Where(x => tiers.Contains(x.IdTiers)).ToList();
                        List<int> iditems = idItemTiers.Select(x => x.IdItem).Distinct().ToList();
                        entities = entities.Where(x => iditems.Contains(x.Id));
                    }
                }
                var salesPriceFilter = predicateModel[0].Filter.Where(x => x.Prop == "IdSalesPrice").FirstOrDefault();
                if (salesPriceFilter != null)
                {
                    var idSP = salesPriceFilter.Value;
                    entities.ToList().ForEach(x =>
                    {
                        var itemSalesPrice = x.ItemSalesPrice.Where(y => y.IdSalesPrice == (Int64)idSP && y.IdSalesPriceNavigation.IsActivated == true).FirstOrDefault();
                        if (x.ItemSalesPrice != null && itemSalesPrice != null)
                        {
                            x.UnitHtsalePrice = Math.Round((double)((1 + (itemSalesPrice.Percentage / 100)) * x.UnitHtsalePrice), companyCurrency.Precision);
                        }
                    });
                }
                var specificFilter = predicateModel[0].SpecFilter;

                var predIdWarhouse = specificFilter != null && specificFilter.Count > 0 ? specificFilter.FirstOrDefault().Predicate.Filter.FirstOrDefault(x => x.Prop == "IdWarehouse") : null;
                int? idWarhouse = null;
                if (predIdWarhouse != null && predIdWarhouse.Value != null)
                {
                    idWarhouse = JsonConvert.DeserializeObject<int?>((predIdWarhouse.Value).ToString());
                }
                else
                {
                    Warehouse central = _warehouseRepo.GetSingle(x => x.IsCentral);
                    if (central != null)
                    {
                        idWarhouse = central.Id;
                    }
                }

                var predAvailableQty = predicateModel[0].Filter.Where(x => x.Prop == "AvailableQuantity").FirstOrDefault();
                bool isAvailableQty = predAvailableQty != null ? Convert.ToBoolean(predAvailableQty.Value) : false;
                if (isAvailableQty)
                {
                    List<int> idsItems = entities.Select(x => x.Id).ToList();
                    List<ItemWarehouse> itemWarehouses = _itemWarehouseRepo.GetAllWithConditionsQueryable(x => (idWarhouse != null ? x.IdWarehouse == idWarhouse : true) && idsItems.Contains(x.IdItem)).ToList();
                    List<int> listOfAvailableItemQty = new List<int>();
                    if (itemWarehouses != null && itemWarehouses.Any())
                    {
                        idsItems.ForEach(x =>
                        {
                            List<ItemWarehouse> itemWarehouseForCurrentItem = itemWarehouses.Where(y => y.IdItem == x).ToList();
                            if (itemWarehouseForCurrentItem != null && itemWarehouseForCurrentItem.Any())
                            {
                                if (itemWarehouseForCurrentItem.Sum(z => z.AvailableQuantity - z.ReservedQuantity) > 0)
                                {
                                    listOfAvailableItemQty.Add(x);
                                }

                            }
                        });

                    }
                    entities = entities.Where(x => listOfAvailableItemQty.Contains(x.Id));

                }
                var total = entities.Count();
                if (predAllAvailableQuantity)
                {
                    entities = entities.Skip(0).Take(total);
                    entities.ToList().ForEach(x => x.AllAvailableQuantity = (x.ItemWarehouse != null && x.ItemWarehouse.Any()) ?
                     x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity)
                    : 0);
                    if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                    {
                        entities = entities.ToList().OrderBy(x => x.AllAvailableQuantity).AsQueryable();
                    }
                    else
                    {
                        entities = entities.ToList().OrderByDescending(x => x.AllAvailableQuantity).AsQueryable();
                    }
                }
                // Get entities with specific oem
                FilterViewModel predOem = predicateModel[NumberConstant.Zero].Filter.FirstOrDefault(x => x.Prop == Constants.OEM);
                if (predOem != null)
                {
                    string oem = predOem.Value.ToString();
                    List<OemItem> oemItem = _repoOemItem.FindByAsNoTracking(x => x.OemNumber.ToUpperInvariant().Contains(oem.ToUpperInvariant())).ToList();
                    entities = entities.Where(x => oemItem.Select(y => y.IdItem).Contains(x.Id));
                    total = entities.Count();
                }
                if (predicateModelWithSpecificFilters.page > 0 && predicateModelWithSpecificFilters.pageSize > 0)
                {
                    entities = entities.Skip((predicateModelWithSpecificFilters.page - 1) * predicateModelWithSpecificFilters.pageSize).Take(predicateModelWithSpecificFilters.pageSize);
                }
                var predPurchase = predicateModel[0].Filter.Where(x => x.Prop == "IsForPurchase").FirstOrDefault();
                bool isPurchaseFilter = predPurchase != null ? Convert.ToBoolean(predPurchase.Value) : false;
                List<int> idItems = entities.Select(x => x.Id).ToList();
                List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel = GetReliquatQty(idItems);
                List<ReducedListItemViewModel> model = entities.ToList().Select(x => _ItemListBuilder.BuildListItem(x, idWarhouse, idItemAndReliquatQtyViewModel)).ToList();
                bool hasShowPurchasePricePermission = RoleHelper.HasPermission("SHOW_PURCHASE_PRICE");
                bool hasShowSalesPricePermission = RoleHelper.HasPermission("SHOW_SALES_PRICE");
                if (!hasShowPurchasePricePermission)
                {
                    model.ForEach(x => x.UnitHtpurchasePrice = null);
                }
                else if (isPurchaseFilter && tiers != null && tiers.Count == 1)
                {
                    model.ForEach(x =>
                    {
                        x.UnitHtpurchasePrice = entities.Where(y => y.Id == x.Id).Select(z => z.ItemTiers.FirstOrDefault().PurchasePrice).FirstOrDefault();
                    });
                }
                if (!hasShowSalesPricePermission)
                {
                    model.ForEach(x => x.UnitHtsalePrice = null);
                }

                // GetAllAvailbleQuantity(listItem, Convert.ToDouble(idWarhouse));
                return new DataSourceResult<ReducedListItemViewModel> { data = model, total = total };

            }
            return null;

        }



        public override DataSourceResult<ItemViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            var p = PreparePredicate(predicateModel[0]);
            int page = predicateModel[0].page;
            int pageSize = predicateModel[0].pageSize;
            predicateModel[0].page = 0;
            predicateModel[0].pageSize = 0;
            DataSourceResult<ItemViewModel> obj = base.GetDataWithSpecificFilter(predicateModel);
            var listItem = obj.data.ToList();
            var specificFilter = predicateModel[0].SpecFilter;
            var predIdWarhouse = specificFilter != null && specificFilter.Count > 0 ? specificFilter.FirstOrDefault().Predicate.Filter.FirstOrDefault(x => x.Prop == "IdWarehouse") : null;
            var idWarhouse = predIdWarhouse != null ? predIdWarhouse.Value : null;
            GetAllAvailbleQuantity(listItem, Convert.ToDouble(idWarhouse));
            if (predicateModel[0].Filter.Where(x => x.Prop == "AvailableQuantity").Any())
            {
                bool avalableInStock = (bool)predicateModel[0].Filter.Where(x => x.Prop == "AvailableQuantity").FirstOrDefault().Value;
                if (avalableInStock == true)
                {
                    listItem = listItem.Where(x => x.AllAvailableQuantity > 0).ToList();
                }
            }
            SetCmdCrpBalanceQtyItem(listItem, Convert.ToInt32(idWarhouse), true);
            var predTiers = predicateModel[0].Filter.Where(x => x.Prop == "IdTiers").FirstOrDefault();
            bool isTiersFilter = predTiers != null ? true : false;
            if (isTiersFilter)
            {
                List<int> tiers = JsonConvert.DeserializeObject<List<int>>((predTiers.Value).ToString());
                if (tiers.Count == 1)
                {
                    listItem = listItem.Where(x => x.ItemTiers != null && x.ItemTiers.Select(y => y.IdTiers).Contains(tiers.FirstOrDefault())).ToList();
                }
                else
                {
                    listItem = listItem.Where(x => x.ItemTiers != null && ((List<int>)predTiers.Value).Intersect(x.ItemTiers.Select(y => y.IdTiers).ToList()).Any()).ToList();
                }
            }
            var predAvailableQty = predicateModel[0].Filter.Where(x => x.Prop == "AvailableQuantity").FirstOrDefault();
            bool isAvailableQty = predAvailableQty != null ? Convert.ToBoolean(predAvailableQty.Value) : false;
            if (isAvailableQty)
            {
                if (idWarhouse != null)
                {
                    listItem = listItem.Where(x => x.WarhouseAvailableQuantity > 0).ToList();
                }
                else
                {
                    listItem = listItem.Where(x => x.AllAvailableQuantity > 0).ToList();
                }
            }
            obj.data = listItem.Skip((page - 1) * pageSize).Take(pageSize).ToList();
            obj.total = listItem.Count;

            return obj;
        }

        public List<ItemTiersViewModel> GetItemTiers(int itemId)
        {
            List<ItemTiersViewModel> itemTiers = _serviceItemTiers.GetModelsWithConditionsRelations(x => x.IdItem == itemId, r => r.IdTiersNavigation).ToList();
            return itemTiers;
        }
        public List<int> getNumberOfItemEquiKit(ItemToGetEquivalentList model)
        {
            var count = new List<int>()
                { GetItemEquivalence(model).Count,
            GetItemKit(model).Count,
            GetReplacementItems(model).Count };
            return count;
        }
        /// <summary>
        /// check if the collection of brand , model and sub model is already exist 
        /// </summary>
        /// <param name="itemVehicleBrandModelSubModels"></param>
        public void CheckUnicityOfVehicleBrandModelSubModel(IList<ItemVehicleBrandModelSubModelViewModel> itemVehicleBrandModelSubModels)
        {
            int lengthOfList = NumberConstant.Zero;
            ItemVehicleBrandModelSubModelViewModel brandModelSubModelFirstList = new ItemVehicleBrandModelSubModelViewModel();
            brandModelSubModelFirstList = itemVehicleBrandModelSubModels[lengthOfList];
            itemVehicleBrandModelSubModels.RemoveAt(lengthOfList);
            foreach (ItemVehicleBrandModelSubModelViewModel brandModelSubModel in itemVehicleBrandModelSubModels)
            {
                if (brandModelSubModelFirstList.IdModel.Equals(brandModelSubModel.IdModel) && brandModelSubModelFirstList.IdSubModel.Equals(brandModelSubModel.IdSubModel)
                    && brandModelSubModelFirstList.IdVehicleBrand.Equals(brandModelSubModel.IdVehicleBrand))
                {

                    throw new CustomException(CustomStatusCode.CollectionBrandModelSubModelAlreadyExist);
                }
                else if (++lengthOfList > itemVehicleBrandModelSubModels.Count)
                {
                    brandModelSubModelFirstList = itemVehicleBrandModelSubModels[lengthOfList];
                    itemVehicleBrandModelSubModels.RemoveAt(lengthOfList);
                }
            }
        }
        public ItemSheetViewModel GetItemSheetData(int id)
        {
            Item currentItem = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.Id == id, x => x.IdNatureNavigation, x => x.IdProductItemNavigation,
                x => x.IdFamilyNavigation, x => x.IdSubFamilyNavigation, x => x.IdUnitStockNavigation, x => x.IdUnitSalesNavigation)
                .Include(y => y.ItemTiers).ThenInclude(z => z.IdTiersNavigation).ThenInclude(a => a.IdCurrencyNavigation)
                .Include(y => y.ItemVehicleBrandModelSubModel).ThenInclude(z => z.IdVehicleBrandNavigation)
                .Include(y => y.ItemVehicleBrandModelSubModel).ThenInclude(z => z.IdModelNavigation)
                .Include(y => y.ItemVehicleBrandModelSubModel).ThenInclude(z => z.IdSubModelNavigation)
                .Include(y => y.TaxeItem).ThenInclude(z => z.IdTaxeNavigation)
                .Include(y => y.OemItem).ThenInclude(z => z.IdBrandNavigation)
                .FirstOrDefault();
            ItemSheetViewModel itemSheetViewModel = _ItemListBuilder.BuildItemSheet(currentItem);
            return itemSheetViewModel;
        }
        public DataSourceResult<ReducedListItemViewModel> GetItemDataWithSpecificFilter(FilterSearchItemViewModel model)
        {
            BeginTransactionunReadUncommitted();
            IQueryable<Item> entities = null;
            entities = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.Code != "Remise" && x.Description != "Remise").Include(y => y.IdNatureNavigation).Include(y => y.ItemTiers).ThenInclude(y => y.IdTiersNavigation)
            .Include(y => y.ItemWarehouse).Include(y => y.OemItem).Include(y => y.ItemSalesPrice).ThenInclude(z => z.IdSalesPriceNavigation).Include(x => x.IdProductItemNavigation);
            entities = SearchItems(entities, model);
            var total = entities.Count();
            IList<Item> listOfItem = new List<Item>();
            if (model.OrderBy.Count > NumberConstant.Zero)
            {
                if (model.OrderBy.FirstOrDefault().Prop == "NameTiers")
                {
                    if (model.OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                    {
                        entities = entities.OrderBy(x => x.ItemTiers.FirstOrDefault().IdTiersNavigation.Name);
                    }
                    else
                    {
                        entities = entities.OrderByDescending(x => x.ItemTiers.FirstOrDefault().IdTiersNavigation.Name);
                    }
                }
                else
                {
                    entities = entities.OrderByRelation(model.OrderBy);
                }
            }
            if (model.page > NumberConstant.Zero && model.pageSize > NumberConstant.Zero)
            {
                listOfItem = entities.Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
            }
            else
            {
                listOfItem = entities.ToList();
            }
            List<int> idItems = listOfItem.Select(x => x.Id).ToList();
            List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel = GetReliquatQty(idItems);
            listOfItem.ToList().ForEach(x => x.AllAvailableQuantity = (x.ItemWarehouse != null && x.ItemWarehouse.Any()) ?
               x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity)
              : 0);
            if (model.IdSalesPrice != null)
            {
                var companyCurrency = _serviceCompany.GetCurrentCompanyCurrency();
                var idSP = model.IdSalesPrice;
                Tiers currentCustomer = null;
                if (model.IdCustomer != null && model.IdCustomer > 0)
                {
                    currentCustomer = _tierRepo.FindSingleBy(x => x.Id == model.IdCustomer);
                }
                listOfItem.ToList().ForEach(x =>
                {
                    if (currentCustomer != null && currentCustomer.IdSalesPrice != null && x.ItemSalesPrice != null && x.ItemSalesPrice.Any())
                    {
                        ItemSalesPrice itemSalesPrice = x.ItemSalesPrice.Where(x => x.IdSalesPrice == currentCustomer.IdSalesPrice).FirstOrDefault();
                        x.UnitHtsalePrice = itemSalesPrice != null ? Math.Round((double)((1 + (itemSalesPrice.Percentage / 100)) * x.UnitHtsalePrice ?? 0), companyCurrency.Precision) : null;
                    }
                    else
                    {
                        List<ItemSalesPrice> listOfItemSalesPrice = x.ItemSalesPrice.Where(y => y.IdSalesPrice == (Int64)idSP && y.IdSalesPriceNavigation.IsActivated == true).ToList();

                        if (listOfItemSalesPrice != null && listOfItemSalesPrice.Any())
                        {
                            var itemSalesPrice = listOfItemSalesPrice.FirstOrDefault();
                            if (x.ItemSalesPrice != null && itemSalesPrice != null)
                            {
                                x.UnitHtsalePrice = x.UnitHtsalePrice != null ? Math.Round((double)((1 + (itemSalesPrice.Percentage / 100)) * x.UnitHtsalePrice), companyCurrency.Precision) : null;
                            }
                        }
                    }


                });
            }
            List<ReducedListItemViewModel> models = listOfItem.Select(x => _ItemListBuilder.BuildListItem(x, model.IdWarehouse, idItemAndReliquatQtyViewModel)).ToList();
            bool hasShowPurchasePricePermission = RoleHelper.HasPermission("SHOW_PURCHASE_PRICE");
            bool hasShowSalesPricePermission = RoleHelper.HasPermission("SHOW_SALES_PRICE");
            models.ForEach(x =>
            {
                if (!hasShowPurchasePricePermission)
                {
                    x.UnitHtpurchasePrice = null;
                }
                else if (model.isForPurchase == true && model.IdTiers != null && model.IdTiers.Count == 1)
                {
                    x.UnitHtpurchasePrice = listOfItem.First(y => y.Id == x.Id).ItemTiers.First(x => x.IdTiers == model.IdTiers.First()).PurchasePrice ?? 0;
                }
                else
                {
                    x.UnitHtpurchasePrice = listOfItem.First(y => y.Id == x.Id).DefaultUnitHtpurchasePrice ?? 0;
                }
                if (!hasShowSalesPricePermission)
                {
                    x.UnitHtsalePrice = null;
                }
            });
            DataSourceResult<ReducedListItemViewModel> result = new DataSourceResult<ReducedListItemViewModel> { data = models, total = total };
            EndTransaction();
            return result;

        }
        public IQueryable<Item> SearchItems(IQueryable<Item> queryItem, FilterSearchItemViewModel model)
        {
            if (model.isFromSalesHistory && model.IdCustomer != null && model.IdCustomer > 0)
            {
                var idsItems = _repoDocumentLine.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocumentNavigation.IdTiers == model.IdCustomer &&
                    (model.IdVehicle != null && model.IdVehicle > 0 ? x.IdDocumentNavigation.IdVehicle == model.IdVehicle : true)).Select(x => x.IdItem);
                queryItem = queryItem.Where(x => idsItems.Contains(x.Id));

            }
            if (model.GlobalSearchItem != null && model.GlobalSearchItem != String.Empty)
            {
                string[] listSearch = model.GlobalSearchItem.Split(" ");
                StringBuilder searchItem = new StringBuilder();
                if (listSearch.Any())
                {
                    
                    foreach (var item in listSearch)
                    {
                        if (item != string.Empty)
                        {
                            searchItem.Append(item).Append(" ");
                        }
                    }
                }
                model.GlobalSearchItem = searchItem.Length > 0 ? searchItem.ToString().Substring(0, searchItem.Length - 1) : searchItem.ToString();
                if (model.GlobalSearchItem.Length > 0 && model.GlobalSearchItem[model.GlobalSearchItem.Length - 1] == '=')
                {
                    queryItem = SearchByDescriptionAndBarCode(model.GlobalSearchItem, queryItem, true);
                }
                else
                {
                    queryItem = SearchByDescriptionAndBarCode(model.GlobalSearchItem, queryItem, false);
                }
            }
            if (model.IdNature != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation != null && x.IdNatureNavigation.Id == model.IdNature);
            }
            if (model.IsStockManaged == true)
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation != null && x.IdNatureNavigation.IsStockManaged == model.IsStockManaged);
            }
            if (model.IdFamily != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdFamilyNavigation != null && x.IdFamilyNavigation.Id == model.IdFamily);
            }
            if (model.IdSubFamily != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdSubFamilyNavigation != null && x.IdSubFamilyNavigation.Id == model.IdSubFamily);
            }

            if (model.IdProductItem != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdProductItemNavigation != null && x.IdProductItemNavigation.Id == model.IdProductItem);
            }
            if (model.MinUnitHtsalePrice != null && model.MinUnitHtsalePrice != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.UnitHtsalePrice.Value >= model.MinUnitHtsalePrice);
            }
            if (model.MaxUnitHtsalePrice != null && model.MaxUnitHtsalePrice != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.UnitHtsalePrice.Value <= model.MaxUnitHtsalePrice);
            }
            if (model.IdModel != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.ItemVehicleBrandModelSubModel != null && x.ItemVehicleBrandModelSubModel.Select(y => y.IdModelNavigation.Id).Contains(model.IdModel));
            }
            if (model.IdSubModel != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdProductItemNavigation != null && x.ItemVehicleBrandModelSubModel.Select(y => y.IdSubModelNavigation.Id).Contains(model.IdSubModel));
            }
            if (model.IdItem != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.Id == model.IdItem);
            }
            if (model.IdWarehouse != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.ItemWarehouse != null && x.ItemWarehouse.Select(y => y.IdWarehouse).Contains(model.IdWarehouse));
            }
            if (model.IdStorage != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.ItemWarehouse != null && x.ItemWarehouse.Select(y => y.IdStorageNavigation.Id).Contains(model.IdStorage));
            }
            if (model.isForSale == true)
            {
                queryItem = queryItem.Where(x => x.IsForSales == true);
            }
            if (model.isForPurchase == true)
            {
                queryItem = queryItem.Where(x => x.IsForPurchase == true);
            }
            if (model.isExpense == true)
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation.Code != "Expense");
            }
            if (model.isRestaurn == true)
            {
                queryItem = queryItem.Where(x => x.IdNatureNavigation.Code == "Ristourne");
            }
            if (model.BarCodeD != null && model.BarCodeD != String.Empty)
            {
                queryItem = queryItem.Where(x => x.BarCode1D.Contains(model.BarCodeD) || x.BarCode2D.Contains(model.BarCodeD));
            }
            if (model.IdWarehouse == NumberConstant.Zero)
            {
                Warehouse central = _warehouseRepo.GetSingle(x => x.IsCentral);
                if (central != null)
                {
                    model.IdWarehouse = central.Id;
                }
            }
            if (model.AllAvailableQuantity == true)
            {
                queryItem = queryItem.Where(x => x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity) > NumberConstant.Zero);
            }
            if (model.IdTiers != null && model.IdTiers.Count == 1)
            {
                queryItem = queryItem.Where(x => x.ItemTiers != null && x.ItemTiers.Select(y => y.IdTiers).Contains(model.IdTiers.FirstOrDefault()));

            }
            else if (model.IdTiers != null && model.IdTiers.Count > 1)
            {
                List<ItemTiers> idItemTiers = queryItem.Where(x => x.ItemTiers != null && x.ItemTiers.Any()).SelectMany(x => x.ItemTiers).Where(x => model.IdTiers.Contains(x.IdTiers)).ToList();
                List<int> iditems = idItemTiers.Select(x => x.IdItem).Distinct().ToList();
                queryItem = queryItem.Where(x => iditems.Contains(x.Id));
            }
            if (model.IdVehicleBrand != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.ItemVehicleBrandModelSubModel != null && x.ItemVehicleBrandModelSubModel.Select(y => y.IdVehicleBrandNavigation.Id).Contains(model.IdVehicleBrand));
            }
            if (model.Oem != null)
            {
                List<OemItem> oemItem = new List<OemItem>();
                model.Oem = model.Oem.Replace(" ", "");
                if (model.Oem[model.Oem.Length - 1] == '=')
                {
                    model.Oem = model.Oem.Substring(0, model.Oem.Length - 1);
                    oemItem = _repoOemItem.FindByAsNoTracking(x => x.OemNumberModified.ToUpper().Equals(model.Oem.ToUpper())).ToList();
                }
                else
                {
                    oemItem = _repoOemItem.FindByAsNoTracking(x => x.OemNumberModified.ToUpper().Contains(model.Oem.ToUpper())).ToList();
                }
                queryItem = queryItem.Where(x => oemItem.Select(y => y.IdItem).Contains(x.Id));
            }
            return queryItem;
        }

        private void UpdateItemSalesPrice(ItemViewModel model, string userMail, Item entity)
        {
            List<ItemSalesPriceViewModel> ItemSalesPriceToDelete = new List<ItemSalesPriceViewModel>();
            List<ItemSalesPriceViewModel> oldItemSalesPrice = _serviceItemSalesPrice.FindModelsByNoTracked(x => x.IdItem == model.Id).ToList();

            List<ItemSalesPriceViewModel> newItemSalesPrice = model.ItemSalesPrice != null ? model.ItemSalesPrice.ToList() : null;
            if (newItemSalesPrice != null && newItemSalesPrice.Any())
            {
                List<ItemSalesPriceViewModel> ItemSalesPriceToAdd = newItemSalesPrice.FindAll(x => x.Id == 0);
                foreach (ItemSalesPriceViewModel itemSalesPrice in ItemSalesPriceToAdd)
                {
                    itemSalesPrice.IdSalesPriceNavigation = null;
                    itemSalesPrice.IdItem = model.Id;
                    _serviceItemSalesPrice.AddModelWithoutTransaction(itemSalesPrice, new List<EntityAxisValuesViewModel>(), userMail);
                }
                ItemSalesPriceToDelete = oldItemSalesPrice.FindAll(x => !newItemSalesPrice.Select(y => y.Id).Contains(x.Id));

                List<ItemSalesPrice> ItemSalesPriceToUpdate = entity.ItemSalesPrice != null ? entity.ItemSalesPrice.ToList() : null;
                if (ItemSalesPriceToUpdate != null && ItemSalesPriceToUpdate.Any())
                {
                    entity.ItemSalesPrice = ItemSalesPriceToUpdate.FindAll(x => x.Id != 0);
                    foreach (ItemSalesPrice itemSalesPrice in entity.ItemSalesPrice)
                    {
                        itemSalesPrice.IdSalesPriceNavigation = null;
                    }
                    entity.ItemSalesPrice.ToList().ForEach(x => _repoItemSalesPrice.Update(x));

                }
            }
            else
            {
                ItemSalesPriceToDelete = oldItemSalesPrice;
            }


            if (ItemSalesPriceToDelete != null && ItemSalesPriceToDelete.Any())
            {
                foreach (ItemSalesPriceViewModel itemSalesPrice in ItemSalesPriceToDelete)
                {
                    _serviceItemSalesPrice.DeleteModelPhysicallyWhithoutTransaction(itemSalesPrice.Id, userMail);
                }
            }
            entity.ItemSalesPrice.Clear();
        }
        private IQueryable<Item> SearchByDescriptionAndBarCode(string model, IQueryable<Item> queryItem, bool searchExact)
        {
            char[] separator = { '%', '*', '=' };
            string[] listSearch = model.Split(separator);
            if (listSearch.Any())
            {
                if (!searchExact)
                {
                    foreach (var item in listSearch)
                    {
                        var exp = item.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "").ToLower();
                        queryItem = queryItem.Where(x => x.Description.ToLower().Contains(item.ToLower()) ||
                        x.Code.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "").ToLower()
                        .Contains(exp) || x.BarCode1D == item || x.BarCode2D == item);
                    }
                }
                else
                {
                    foreach (var item in listSearch)
                    {
                        var exp = item.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "").ToLower();
                        if (item != string.Empty)
                        {
                            queryItem = queryItem.Where(x => x.Description.ToLower().Equals(item.ToLower()) ||
                            x.Code.Replace("-", "").Replace(" ", "").Replace("*", "").Replace(".", "").Replace("/", "").Replace("\\", "")
                            .ToLower().Equals(exp) || x.BarCode1D == item || x.BarCode2D == item);
                        }
                    }

                }
            }
            return queryItem;
        }
        /// <summary>
        /// getListOfIdsByCodeOrDesignation
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
        public List<int> getByCodeAndDesignation(String pattern)
        {
            List<int> listItem = _entityRepo.QuerableGetAll().Where(x => x.Code.ToLower().Contains(pattern.ToLower()) || x.Description.ToLower().Contains(pattern.ToLower())).Select(x => x.Id).ToList();
            return listItem;
        }

        /// <summary>
        /// getItemDetails
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
        public List<ItemDetailsViewModel> GetItemDetailsProd(List<int> listItems)
        {
            List<ItemDetailsViewModel> itemDetails = new List<ItemDetailsViewModel>();
            var result = _entityRepo.QuerableGetAll().Include(y => y.ItemWarehouse).Where(x => listItems.Contains(x.Id));
            result.ToList().ForEach(y =>
            itemDetails.Add(
            new ItemDetailsViewModel
            {
                Id = y.Id,
                Code = y.Code,
                Description = y.Description,
                CostPrice = y.CostPrice,
                AllAvailableQuantity = GetItemWarhouseOfSelectedItem(y.Id).ToList().FirstOrDefault().AvailableQuantity,
                IdWarehouse = y.ItemWarehouse.FirstOrDefault().IdWarehouse,
                WarehouseCode = (y.ItemWarehouse != null && y.ItemWarehouse.FirstOrDefault().IdWarehouseNavigation != null) ? y.ItemWarehouse.FirstOrDefault().IdWarehouseNavigation.WarehouseCode : string.Empty,
                WarehouseName = (y.ItemWarehouse != null && y.ItemWarehouse.FirstOrDefault().IdWarehouseNavigation != null) ? y.ItemWarehouse.FirstOrDefault().IdWarehouseNavigation.WarehouseName : string.Empty,
                AvailableQuantity = y.ItemWarehouse != null ? y.ItemWarehouse.FirstOrDefault().AvailableQuantity : NumberConstant.Zero,
                IdUnitStock = y.IdUnitStock,
                IdUnitSales = y.IdUnitSales,
            }));
            return itemDetails;
        }
        /// <summary>
        /// method to check if ItemCode already exists in same brand
        /// </summary>
        /// <param name="item"></param>
        public void CheckItemUnicityPerBrand(ItemViewModel item)
        {
            bool itemExist = item.IdProductItem != null ? _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Code == item.Code
            && x.IdProductItem.Value == item.IdProductItem.Value).Any() : _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Code == item.Code
            && x.IdProductItem == null).Any();
            if (itemExist)
            {
                throw new CustomException(CustomStatusCode.ItemAlreadyExist);
            }
        }

        public void AffectEquivalentItemWithoutResponse(EquivalentItemsViewModel equivalentItems, string userMail)
        {

            try
            {
                BeginTransaction();

                IList<ItemViewModel> equivalentItemsOfMaster = new List<ItemViewModel>();

                ItemViewModel masterItem = GetModelAsNoTracked(x => x.Id == equivalentItems.IdMasterItem);
                ItemViewModel itemToAffect = GetModelAsNoTracked(x => x.Id == equivalentItems.IdItemToAffect);
                itemToAffect.UpdatedDate = DateTime.Now;
                equivalentItemsOfMaster.Add(itemToAffect);

                if (masterItem.EquivalenceItem == null && itemToAffect.EquivalenceItem == null)
                {
                    masterItem.EquivalenceItem = itemToAffect.EquivalenceItem = Guid.NewGuid();
                    UpdateModelWithoutTransaction(masterItem, null, userMail);
                }
                else if (masterItem.EquivalenceItem != null)
                {

                    if (itemToAffect.EquivalenceItem != null)
                    {
                        List<ItemViewModel> equivalentItemsOfItemToAffect = FindByAsNoTracking(x =>
                           x.EquivalenceItem == itemToAffect.EquivalenceItem && x.Id != itemToAffect.Id).ToList();

                        equivalentItemsOfItemToAffect.ForEach(x =>
                        {
                            x.EquivalenceItem = masterItem.EquivalenceItem;
                            x.UpdatedDate = DateTime.Now;
                            equivalentItemsOfMaster.Add(x);
                        });
                    }

                    itemToAffect.EquivalenceItem = masterItem.EquivalenceItem;
                }
                else
                {
                    masterItem.EquivalenceItem = itemToAffect.EquivalenceItem;
                    UpdateModelWithoutTransaction(masterItem, null, userMail);
                }

                BulkUpdateModelWithoutTransaction(equivalentItemsOfMaster, userMail);
                EndTransaction();
            }
            catch (CustomException)
            {
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }

        }


        #endregion

        #region garage

        /// <summary>
        /// Add operation comming from garage as item of type service
        /// </summary>
        /// <param name="operation"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object AddOperationAsItem(ItemViewModel item, string userMail)
        {
            if (item == null)
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            CreatedDataViewModel createdDataViewModel = new CreatedDataViewModel();
            // Check if no item with the same reference exist 
            ItemViewModel existingItem = GetModelAsNoTracked(x => x.Code == item.Code);
            if (existingItem != null && existingItem.Id > 0)
            {
                createdDataViewModel = new CreatedDataViewModel { Id = existingItem.Id };
                return createdDataViewModel;
            }
            Nature nature = _natureRepo.FindSingleBy(p => p.Code == Constants.SERVICE);
            item.IdNature = nature?.Id;
            item.Id = 0;
            createdDataViewModel = (CreatedDataViewModel)AddModelWithoutTransaction(item, null, userMail);
            return createdDataViewModel;
        }

        /// <summary>
        /// Update operation comming from garage as item of type service
        /// </summary>
        /// <param name="operation"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object UpdateOperationAsItem(ItemViewModel item, string userMail)
        {
            if (item == null)
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            Nature nature = _natureRepo.FindSingleBy(p => p.Code == Constants.SERVICE);
            item.IdNature = nature?.Id;
            CreatedDataViewModel createdDataViewModel;
            Item olditem = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == item.Id);
            if (olditem != null && olditem.Id > 0)
            {
                createdDataViewModel = (CreatedDataViewModel)UpdateModelWithoutTransaction(item, null, userMail);
                return createdDataViewModel;
            }
            createdDataViewModel = (CreatedDataViewModel)AddOperationAsItem(item, userMail);
            return createdDataViewModel;
        }

        /// <summary>
        /// BulkAddOperationAsItem
        /// </summary>
        /// <param name="operations"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public List<ItemViewModel> BulkAddOperationAsItem(List<ItemViewModel> listItems, string userMail)
        {
            try
            {
                if (listItems == null)
                {
                    throw new CustomException(CustomStatusCode.InternalServerError);
                }
                List<ItemViewModel> resultList = new List<ItemViewModel>();
                // Check if no item with the same reference exist
                List<string> listCode = listItems.Select(s => s.Code).ToList();
                List<ItemViewModel> itemsAlreadyExist = FindByAsNoTracking(x => listCode.Contains(x.Code)).ToList();

                if (itemsAlreadyExist != null && itemsAlreadyExist.Count > 0)
                {
                    resultList = itemsAlreadyExist.Select(s => new ItemViewModel { Id = s.Id, Code = s.Code }).ToList();
                }

                // Add items
                List<ItemViewModel> itemsToAdd = listItems.Where(p => !itemsAlreadyExist.Select(s => s.Code).Contains(p.Code)).ToList();
                IList<Item> entities = new List<Item>();
                if (itemsToAdd != null && itemsToAdd.Count > 0)
                {
                    Nature nature = _natureRepo.FindSingleBy(p => p.Code == Constants.SERVICE);
                    itemsToAdd.ForEach(model =>
                    {
                        model.Id = 0;
                        model.IdNature = nature?.Id;
                        entities.Add(_builder.BuildModel(model));
                    });
                    _entityRepo.BulkAdd(entities);
                }
                _unitOfWork.CommitWithoutTraceability();
                List<ItemViewModel> itemsAdded = entities.Select(s => new ItemViewModel { Id = s.Id, Code = s.Code }).ToList();
                resultList.AddRange(itemsAdded);
                return resultList;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// BulkUpdateOperationAsItem
        /// </summary>
        /// <param name="operations"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public List<ItemViewModel> BulkUpdateOperationAsItem(List<ItemViewModel> listItems, string userMail)
        {
            try
            {
                BeginTransaction();
                if (listItems == null)
                {
                    throw new Exception();
                }
                List<ItemViewModel> resultList = new List<ItemViewModel>();
                IQueryable<Item> listOldItems = _entityRepo.GetAllWithConditionsQueryable(x => listItems.Select(s => s.Id).Contains(x.Id));
                // Update the items if exist            
                List<Item> items = listOldItems.ToList();
                items.ForEach((p) =>
                {
                    p.UnitHtsalePrice = listItems.FirstOrDefault(x => x.Id == p.Id).UnitHtsalePrice;
                });
                _entityRepo.BulkUpdate(items);
                _unitOfWork.CommitWithoutTraceability();
                List<ItemViewModel> listItemsUpdated = items.Select(s => new ItemViewModel { Id = s.Id, Code = s.Code }).ToList();
                resultList.AddRange(listItemsUpdated);

                // Add new items if don't exist
                List<ItemViewModel> listItemsToAdd = listItems.Where(p => !listItemsUpdated.Select(s => s.Id).Contains(p.Id)).ToList();

                if (listItemsToAdd != null && listItemsToAdd.Count > 0)
                {
                    List<ItemViewModel> createdDataList = BulkAddOperationAsItem(listItemsToAdd, userMail);
                    resultList.AddRange(createdDataList);
                }
                EndTransaction();
                return resultList;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Create an itemViewModel with the operaiton comming from garage
        /// </summary>
        /// <param name="operation"></param>
        /// <returns></returns>
        private ItemViewModel ConvertOperationToItem(dynamic operation)
        {
            ICollection<TaxeItemViewModel> taxeItems = new List<TaxeItemViewModel>
            {
                new TaxeItemViewModel
                {
                    Id =  0,
                    IdTaxe = (int)operation.IdTaxe,
                    IdItem = (int)operation.IdItem
                }
            };
            Nature nature = _natureRepo.FindSingleBy(p => p.Code == Constants.SERVICE);
            ItemViewModel itemViewModel = new ItemViewModel
            {
                Id = (int)operation.IdItem,
                Code = (string)operation.Code,
                Description = (string)operation.Name,
                UnitHtsalePrice = (double?)operation.Htprice,
                UnitTtcsalePrice = (double?)operation.Ttcprice,
                IdNature = nature?.Id,
                IsForPurchase = false,
                IsForSales = true,
                IsKit = false,
                IsFromGarage = true,
                HavePriceRole = true,
                TaxeItem = taxeItems
            };

            return itemViewModel;
        }

        /// <summary>
        /// Get item list with remainingQuantity in garageWarehouse
        /// </summary>
        /// <param name="model"></param>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        public DataSourceResult<ItemViewModel> GetItemListForGarage(List<int> idItems, int? idWarehouse)
        {
            DataSourceResult<ItemViewModel> dataSourceResult = new DataSourceResult<ItemViewModel>();
            if (idItems != null && idItems.Count > 0)
            {
                // Get Items
                List<ItemViewModel> listItemViewModel = _entityRepo.GetAllWithConditionsQueryable(p => idItems.Contains(p.Id))
                                            .Include(r => r.IdUnitStockNavigation)
                                            .Include(r => r.ItemWarehouse)
                                            .ToList().Select(_builder.BuildEntity).ToList();
                // Add remaning quantity for each item in garage warehouse
                listItemViewModel.ForEach((item) =>
                {
                    ItemWarehouseViewModel currentItemWarehouse = item.ItemWarehouse?.Where(p => p.IdWarehouse == idWarehouse)?.FirstOrDefault();
                    item.RemainingQuantity = currentItemWarehouse != null ? AmountMethods.FormatValue((currentItemWarehouse.AvailableQuantity
                            - currentItemWarehouse.ReservedQuantity), item.IdUnitStockNavigation.DigitsAfterComma) : 0;
                });
                dataSourceResult.data = listItemViewModel;
                dataSourceResult.total = listItemViewModel.Count;
            }
            return dataSourceResult;
        }

        public List<ItemWarehouseListItemViewModel> GetItemWarhouseOfSelectedItem(int idItem)
        {
            List<ItemWarehouseViewModel> itemWarehouse = new List<ItemWarehouseViewModel>();
            itemWarehouse = _serviceItemWarehouse.GetModelsWithConditionsRelations(x => x.IdItem == idItem,
            x => x.IdWarehouseNavigation).OrderBy(x => x.IdWarehouseNavigation.WarehouseName).ToList();
            if (itemWarehouse.Any())
            {
                List<DocumentLine> listPurchaseDeliveryProvByItem = _repoDocumentLine.QuerableGetAll().Where(x =>
            x.IdItem == idItem &&
            x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
            x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
            Include(x => x.IdDocumentNavigation).ToList();

                _serviceItemWarehouse.CalculatQuantity(idItem, itemWarehouse, listPurchaseDeliveryProvByItem);
                ItemWarehouseViewModel central = itemWarehouse.FirstOrDefault(x => x.IdWarehouseNavigation.IsCentral);
                if (central != null)
                {
                    central.SumOfAvailableQuantity = itemWarehouse.Sum(x => x.AvailableQuantity);
                    _serviceItemWarehouse.MangeStateCentral(central);
                }
                return itemWarehouse.Select(x => _itemWarehouseBuilder.BuildItemWarehouse(x)).ToList();
            }
            return new List<ItemWarehouseListItemViewModel>();

        }

        #endregion
        #region Synchronize With BToB 
        public SynchronizeBToBItemViewModel SynchronizeBToBItems(DateTime searchDate, string connectionString)
        {
            var companyCurrency = _serviceCompany.GetCurrentCompanyCurrency();
            SynchronizeBToBItemViewModel synchronizeBToBItemViewModel = new SynchronizeBToBItemViewModel();
            List<ItemViewModel> items = new List<ItemViewModel>();
            if (searchDate != DateTime.MinValue) {
             items = GetModelsWithConditionsRelations(x => (x.UnitHtsalePrice != null && x.UnitHtsalePrice.HasValue && x.UnitHtsalePrice != 0) && ((x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
             TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
             (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
             TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero)))), r => r.ItemVehicleBrandModelSubModel, r => r.ItemWarehouse, t => t.ItemSalesPrice).ToList();
            }else
            {
              items = GetModelsWithConditionsRelations(x => (x.UnitHtsalePrice != null && x.UnitHtsalePrice.HasValue && x.UnitHtsalePrice != 0) , r => r.ItemVehicleBrandModelSubModel, r => r.ItemWarehouse, t => t.ItemSalesPrice).ToList();
            }
            var listOfItems = items.Select(x => new
            {
                IdItem = x.Id,
                EquivalenceItem = x.EquivalenceItem
            });
            var listOfEquivalenceItems = GetAllModelsQueryableWithRelation(x => listOfItems.Select(y => y.EquivalenceItem).Contains(x.EquivalenceItem)).ToList();
            List<EquivalenceItemForBtoBViewModel> listEquivanceItemForBtoB = new List<EquivalenceItemForBtoBViewModel>();
            listOfItems.Distinct().ToList().ForEach(x =>
            {
                EquivalenceItemForBtoBViewModel equivanceItemForBtoB = new EquivalenceItemForBtoBViewModel
                {
                    IdItem = x.IdItem,
                    EquivalenceItem = x.EquivalenceItem,
                    EquivalenceItems = listOfEquivalenceItems.Where(y => y.EquivalenceItem == x.EquivalenceItem).Select(z => z.Id).ToList()
                };
                listEquivanceItemForBtoB.Add(equivanceItemForBtoB);
            });
            synchronizeBToBItemViewModel.ListOfItem = items.Select(x => _ItemListBuilder.BuildListItemB2b(x, searchDate, x.ItemSalesPrice.ToList(), companyCurrency.Precision, listEquivanceItemForBtoB)).ToList();
            // Get deleted items 
            if (searchDate != DateTime.MinValue) {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.Item where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                    {
                        cmd.Parameters.AddWithValue("@value", searchDate.Date);
                        cmd.Connection = conn;
                        SqlDataReader rdr = cmd.ExecuteReader();
                        while (rdr.Read())
                        {
                            DateTime date = (DateTime)rdr["UpdatedDate"];
                            if (date.AfterDateAndTimeLimitIncluded(searchDate))
                            {
                                ItemB2bViewModel item = new ItemB2bViewModel
                                {
                                    Id = (int)rdr["Id"],
                                    IsDeleted = (bool)rdr["IsDeleted"]
                                };
                                synchronizeBToBItemViewModel.ListOfItem.Add(item);
                            }
                        }
                        conn.Close();
                    }
                }
                }
            return synchronizeBToBItemViewModel;
        }
        /// <summary>
        /// Get Files Contents For BtoB
        /// </summary>
        /// <param name="urls"></param>
        /// <returns></returns>
        public IList<SynchronizeBtobPicturesViewModel> GetFilesContentsForBtoB(List<int> listOfIds)
        {
            IList<SynchronizeBtobPicturesViewModel> filesInfos = new List<SynchronizeBtobPicturesViewModel>();
            List<Item> listOfItem = _entityRepo.FindByAsNoTracking(x => listOfIds.Contains(x.Id)).ToList();
            listOfItem.ForEach(item =>
            {
                if (!string.IsNullOrEmpty(item.UrlPicture))
                {
                    SynchronizeBtobPicturesViewModel fileInfoBtoBViewModel = new SynchronizeBtobPicturesViewModel();
                    fileInfoBtoBViewModel.IdItem = item.Id;
                    string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, item.UrlPicture);
                    if (Directory.Exists(path))
                    {
                        DirectoryInfo directory = new DirectoryInfo(path);
                        fileInfoBtoBViewModel.Data = new List<FileInfoBtoBViewModel>();
                        //Fetch list of uploaded files
                        foreach (FileInfo fileInfo in directory.GetFiles())
                        {
                            var fileInfoViewModel = new FileInfoBtoBViewModel
                            {
                                Name = fileInfo.Name,
                                FulPath = item.UrlPicture
                            };
                            string filePath = Path.Combine(path, fileInfoViewModel.Name);
                            fileInfoViewModel.Data = File.ReadAllBytes(filePath);
                            fileInfoBtoBViewModel.Data.Add(fileInfoViewModel);
                        }
                        filesInfos.Add(fileInfoBtoBViewModel);
                    }

                }
            });
            return filesInfos;
        }

        #endregion

        #region item generation from employee

        /// <summary>
        /// Generate Item for employee prestation on prject
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="labelInInvoice"></param>
        /// <returns></returns>
        public ItemViewModel GenerateItemFromEmployee(EmployeeViewModel employee, string labelInInvoice)
        {
            // Get item of employee if exist
            ItemViewModel itemOfEmployee = GetModelsWithConditionsRelations(x => x.IdEmployee == employee.Id, x => x.IdNatureNavigation, x => x.IdUnitStockNavigation, x => x.IdUnitSalesNavigation).FirstOrDefault();
            // If item not exist ==> create new Item of employee
            if (itemOfEmployee == null)
            {
                ItemViewModel itemViewModel = new ItemViewModel()
                {
                    Description = !string.IsNullOrEmpty(labelInInvoice) ? labelInInvoice : "Prestation de " + employee.FirstName + " " + employee.LastName,
                    Code = employee.FullName + "-" + employee.Matricule,
                    IdNature = _serviceNature.GetModel(nature => nature.Code == Constants.SERVICE).Id,
                    IdEmployee = employee.Id,
                    IsForSales = true,
                };
                CreatedDataViewModel createdItem = (CreatedDataViewModel)AddModelWithoutTransaction(itemViewModel, null, null);
                // Recuperate created item
                itemOfEmployee = GetModelById(createdItem.Id);
            }
            return itemOfEmployee;
        }

        #endregion
    }
}

