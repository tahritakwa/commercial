using ModelView.B2B;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ItemBuilder : GenericBuilder<ItemViewModel, Item>, IItemBuilder
    {
        #region Fields
        private readonly IItemWarehouseBuilder _itemWarehouse;
        private readonly IItemKitBuilder _itemKit;
        private readonly ITaxeItemBuilder _taxeItemBuilder;
        private readonly IItemTiersBuilder _itemTiersBuilder;
        private readonly IModelOfItemBuilder _modelOfItemBuilder;
        private readonly ISubModelBuilder _subModelBuilder;
        private readonly IOemItemBuilder _oemItemBuilder;
        #endregion
        #region ctor
        public ItemBuilder(IItemWarehouseBuilder itemWarehouse, ITaxeItemBuilder taxeItemBuilder, ITiersBuilder tiersBuilder, IItemKitBuilder itemKit, IItemTiersBuilder itemTiersBuilder,
            IModelOfItemBuilder modelOfItemBuilder, ISubModelBuilder subModelBuilder, IOemItemBuilder oemItemBuilder)
        {
            _itemWarehouse = itemWarehouse;
            _taxeItemBuilder = taxeItemBuilder;
            _itemKit = itemKit;
            _itemTiersBuilder = itemTiersBuilder;
            _modelOfItemBuilder = modelOfItemBuilder;
            _subModelBuilder = subModelBuilder;
            _oemItemBuilder = oemItemBuilder;
        }
        #endregion
        #region Methodes
        public override ItemViewModel BuildEntity(Item entity)
        {
            ItemViewModel model = new ItemViewModel();
            int depth = 0;
            if (entity != null)
            {
                CreateModelViewMapper(entity, model, entity.GetType().Name, depth);
                if (entity.ItemTiers.Count > 0)
                {
                    model.ItemTiers = entity.ItemTiers.Select(x => _itemTiersBuilder.BuildEntity(x)).ToList();
                    model.ListTiers = model.ItemTiers.Select(x => x.IdTiersNavigation).ToList();
                }
                if (entity.ItemKitIdKitNavigation != null)
                {
                    model.ItemKitIdKitNavigation = entity.ItemKitIdKitNavigation.Select(x => _itemKit.BuildEntity(x)).ToList();
                }
                if (entity.IdProductItemNavigation != null && entity.IdProductItemNavigation.LabelProduct != null)
                {
                    model.LabelProduct = entity.IdProductItemNavigation.LabelProduct;
                }
                if (entity.ItemKitIdItemNavigation != null)
                {
                    model.ItemKitIdItemNavigation = entity.ItemKitIdItemNavigation.Select(x => _itemKit.BuildEntity(x)).ToList();
                }
                if (entity.ItemWarehouse != null)
                {
                    model.ItemWarehouse = entity.ItemWarehouse.Select(x => _itemWarehouse.BuildEntity(x)).ToList();
                }
                if (entity.TaxeItem != null)
                {
                    model.TaxeItem = entity.TaxeItem.Select(x => _taxeItemBuilder.BuildEntity(x)).ToList();
                }
                if (model.ItemVehicleBrandModelSubModel == null)
                {
                    model.ItemVehicleBrandModelSubModel = new List<ItemVehicleBrandModelSubModelViewModel>();
                }
                if (entity.ItemVehicleBrandModelSubModel != null && entity.ItemVehicleBrandModelSubModel.Any())
                {
                    model.ItemVehicleBrandModelSubModel.ToList().ForEach(itemVehicle =>
                    {
                        if (entity.ItemVehicleBrandModelSubModel.First(x => x.Id == itemVehicle.Id).IdModelNavigation != null)
                        {
                            itemVehicle.IdModelNavigation = _modelOfItemBuilder.BuildEntity(entity.ItemVehicleBrandModelSubModel.First(x => x.Id == itemVehicle.Id).IdModelNavigation);
                        }
                        if (entity.ItemVehicleBrandModelSubModel.First(x => x.Id == itemVehicle.Id).IdSubModelNavigation != null)
                        {
                            itemVehicle.IdSubModelNavigation = _subModelBuilder.BuildEntity(entity.ItemVehicleBrandModelSubModel.First(x => x.Id == itemVehicle.Id).IdSubModelNavigation);
                        }
                    });
                }
                if (entity.ItemSalesPrice != null)
                {
                    model.ItemSalesPrice.ToList().ForEach(itemSale =>
                    {
                        if (model.UnitHtsalePrice != null && model.UnitHtsalePrice >= 0)
                        {
                            itemSale.Price = (double)(model.UnitHtsalePrice * (1 + (itemSale.Percentage / 100)));
                        }
                    });
                }

                model.RefDesignation = entity.Code + " - " + entity.Description;
            }
            return model;

        }

        public override void CreateModelViewMapper(object model, object viewModel, string modelTypeName, int depth)
        {
            List<PropertyInfo> propertiesInfos = viewModel.GetType().GetProperties(BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).ToList();
            foreach (PropertyInfo viewModelPropertyInfo in propertiesInfos)
            {
                PropertyInfo modelPropertyInfo = model.GetType().GetProperty(viewModelPropertyInfo.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (modelPropertyInfo != null)
                {
                    if (modelPropertyInfo.PropertyType.Namespace.Contains("Persistence.Entities")
                        || modelPropertyInfo.PropertyType.Namespace.Contains("Persistence.CatalogEntities"))
                    {
                        BuildModelViewObjectNavigationForItem(model, viewModel, modelTypeName, depth, viewModelPropertyInfo, modelPropertyInfo);
                    }
                    else if (modelPropertyInfo.PropertyType.Name.Equals("ICollection`1"))
                    {
                        BuildModelViewCollectionNavigation(model, viewModel, modelTypeName, depth, viewModelPropertyInfo, modelPropertyInfo);
                    }
                    else
                    {
                        BuildModelViewProperty(model, viewModel, viewModelPropertyInfo, modelPropertyInfo);
                    }
                }
            }
        }

        private void BuildModelViewObjectNavigationForItem(object model, object viewModel, string modelTypeName, int depth, PropertyInfo viewModelPropertyInfo, PropertyInfo modelPropertyInfo)
        {
            var propertyValue = modelPropertyInfo.GetValue(model);
            object navigationViewModel = null;
            if (propertyValue != null && modelTypeName != modelPropertyInfo.Name && modelTypeName != modelPropertyInfo.PropertyType.Name)
            {
                string assemblyQualifiedName = Assembly.CreateQualifiedName("ViewModels", viewModelPropertyInfo.PropertyType.FullName);
                Type destination = Type.GetType(assemblyQualifiedName);
                navigationViewModel = Activator.CreateInstance(destination);
                CreateModelViewMapper(propertyValue, navigationViewModel, modelTypeName, ++depth);
            }
            viewModelPropertyInfo.SetValue(viewModel, navigationViewModel);
        }
        public override Item BuildModel(ItemViewModel model)
        {
            Item entity = base.BuildModel(model);
            if (model.ItemWarehouse != null)
            {
                entity.ItemWarehouse = model.ItemWarehouse.Select(x => _itemWarehouse.BuildModel(x)).ToList();
            }
            if (model.TaxeItem != null)
            {
                entity.TaxeItem = model.TaxeItem.Select(x => _taxeItemBuilder.BuildModel(x)).ToList();
            }
            if (model.OemItem != null && model.OemItem.Any())
            {
                entity.OemItem.ToList().ForEach(x => x.OemNumberModified = x.OemNumber.Replace(" ", "").Replace(".", "").Replace("-", ""));
            }
            entity.IdProductItemNavigation = null;
            return entity;
        }

        public ItemListViewModel BuildItem(ItemViewModel x)
        {
            return new ItemListViewModel
            {
                Id = x.Id,
                Code = x.Code,
                Description = x.Description,
                UnitHtpurchasePrice = x.UnitHtpurchasePrice,
                UnitHtsalePrice = x.UnitHtsalePrice,
                NameTiers = x.NameTiers != null ? x.NameTiers : (x.ListTiers != null && x.ListTiers.Any() ? x.ListTiers.First().Name : ""),
                LabelProduct = x.LabelProduct != null ? x.LabelProduct : (x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : ""),
                AllAvailableQuantity = x.AllAvailableQuantity,
                IsEcommerce = x.IsEcommerce,
                TecDocRef = x.TecDocRef,
                SynchonizationStatus = x.SynchonizationStatus,
                LabelVehicule = x.LabelVehicule,
                ReliquatQty = x.ReliquatQty,
                CMD = x.CMD,
                CRP = x.CRP,
                WarhouseAvailableQuantity = x.WarhouseAvailableQuantity,
                HaveClaims = x.HaveClaims,
                LabelNature = x.IdNatureNavigation != null ? x.IdNatureNavigation.Label : "",
                AvailableDate = x.AvailableDate,
                TecDocId = x.TecDocId,
                TecDocIdSupplier = x.TecDocIdSupplier,
                IsStockManaged = x.IdNatureNavigation != null ? x.IdNatureNavigation.IsStockManaged : false,
                OnlineSynchonizationStatus = x.OnlineSynchonizationStatus,
                EquivalenceItem = x.EquivalenceItem,
                ListTiers = x.ListTiers
            };
        }

        public ReducedListItemViewModel BuildListItem(Item x, int? idWarhouse = null, List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel = null)
        {
            List<IdItemAndReliquatQtyViewModel> reliquatDatasItems = (idItemAndReliquatQtyViewModel != null && idItemAndReliquatQtyViewModel.Any()) ?
                idItemAndReliquatQtyViewModel.Where(y => y.IdItem == x.Id).ToList() : null;
            IdItemAndReliquatQtyViewModel reliquatDataItem = (reliquatDatasItems != null && reliquatDatasItems.Any()) ? reliquatDatasItems.First() : null;
            return new ReducedListItemViewModel
            {
                Id = x.Id,
                Code = x.Code,
                Description = x.Description,
                UrlPicture = x.UrlPicture,
                UnitHtsalePrice = x.UnitHtsalePrice,
                UnitHtpurchasePrice = x.UnitHtpurchasePrice,
                NamesTiers = (x.ItemTiers != null && x.ItemTiers.Any()) ? x.ItemTiers.Where(z => z.IdTiersNavigation != null).Select(y => y.IdTiersNavigation.Name).ToList() : null,
                LabelProduct = x.IdProductItemNavigation != null ? x.IdProductItemNavigation.LabelProduct : "",
                AllAvailableQuantity = (x.ItemWarehouse != null && x.ItemWarehouse.Any()) ?
                     x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity)
                    : 0,
                WarhouseAvailableQuantity = (x.ItemWarehouse != null && x.ItemWarehouse.Any()) ?
                    (idWarhouse == null ? 0 : x.ItemWarehouse.Where(u => u.IdWarehouse == idWarhouse).Sum(z => z.AvailableQuantity - z.ReservedQuantity))
                    : 0,

                TecDocRef = x.TecDocRef,
                ReliquatQty = reliquatDataItem != null ? reliquatDataItem.ReliquatQty : 0,
                HaveClaims = x.HaveClaims,
                IsStockManeged = x.IdNatureNavigation != null ? x.IdNatureNavigation.IsStockManaged : false,
                AvailableDate = reliquatDataItem != null ? reliquatDataItem.AvailableDate : null,
                TecDocId = x.TecDocId,
                TecDocIdSupplier = x.TecDocIdSupplier,
                QuantityForDocumentLine = 0,
                NumberOfItemEquiKit = 0,
                IsChecked = false,
                IsForSales = (bool)x.IsForSales,
                IsForPurchase = (bool)x.IsForPurchase,
                IsKit = x.IsKit,
                IsFromGarage = x.IsFromGarage,
                EquivalenceItem = x.EquivalenceItem,
                NatureLabel = x.IdNatureNavigation != null ? x.IdNatureNavigation.Label : string.Empty,
                Oem = x.OemItem != null && x.OemItem.Any() ? x.OemItem.Select(y => y.OemNumber).Aggregate((i, j) => i + GenericConstants.Semicolon + j) : null,
                IdsTiers = (x.ItemTiers != null && x.ItemTiers.Any()) ? x.ItemTiers.Where(z => z.IdTiersNavigation != null).Select(y => y.IdTiersNavigation.Id).ToList() : null,

            };
        }


        public ItemSheetViewModel BuildItemSheet(Item item)
        {
            return new ItemSheetViewModel
            {
                Id = item.Id,
                LabelNature = item.IdNatureNavigation != null ? item.IdNatureNavigation.Label : "",
                LabelFamily = item.IdFamilyNavigation != null ? item.IdFamilyNavigation.Label : "",
                LabelSubFamily = item.IdSubFamilyNavigation != null ? item.IdSubFamilyNavigation.Label : "",
                LabelUnitStock = item.IdUnitStockNavigation != null ? item.IdUnitStockNavigation.Label : "",
                LabelUnitSales = item.IdUnitSalesNavigation != null ? item.IdUnitSalesNavigation.Label : "",
                Note = item.Note,
                BarCode1D = item.BarCode1D,
                BarCode2D = item.BarCode2D,
                CoeffConversion = item.CoeffConversion,
                IdPolicyValorization = item.IdPolicyValorization,
                UnitHtsalePrice = item.UnitHtsalePrice,
                UrlBrandPicture = item.IdProductItemNavigation?.UrlPicture,
                ItemVehicleBrandModelSubModel = (item.ItemVehicleBrandModelSubModel != null && item.ItemVehicleBrandModelSubModel.Any()) ?
                item.ItemVehicleBrandModelSubModel.Select(y => new ListItemVehicleBrandModelSubModel
                {
                    LabelVehicleBrand = y.IdVehicleBrandNavigation != null ? y.IdVehicleBrandNavigation.Label : "",
                    LabelModel = y.IdModelNavigation != null ? y.IdModelNavigation.Label : "",
                    LabelSubModel = y.IdSubModelNavigation != null ? y.IdSubModelNavigation.Label : "",
                }).ToList() : null,

                TiersPurchasePrice = (item.ItemTiers != null && item.ItemTiers.Any()) ?
                item.ItemTiers.Select(y => new ListTiersPurchasePrice
                {
                    UrlPicture = y.IdTiersNavigation != null ? y.IdTiersNavigation.UrlPicture : "",
                    Name = y.IdTiersNavigation != null ? y.IdTiersNavigation.Name : "",
                    CodeTiers = y.IdTiersNavigation != null ? y.IdTiersNavigation.CodeTiers : "",
                    PurchasePrice = y.PurchasePrice,
                    FormatOption = y.IdTiersNavigation != null && y.IdTiersNavigation.IdCurrencyNavigation != null ? new NumberFormatOptionsViewModel
                    {
                        style = Constants.STYLE_CURRENCY,
                        currency = y.IdTiersNavigation.IdCurrencyNavigation.Code,
                        currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                        minimumFractionDigits = y.IdTiersNavigation.IdCurrencyNavigation.Precision
                    } : null
                }).ToList() : null,
                TaxesLabel = (item.TaxeItem != null && item.TaxeItem.Any()) ? item.TaxeItem.Where(z => z.IdTaxeNavigation != null).Select(y => y.IdTaxeNavigation.Label).ToList() : null,
                NumberDaysOutOfStock = 0,
                OemItem = (item.OemItem != null && item.OemItem.Any()) ? item.OemItem.Select(x => _oemItemBuilder.BuildEntity(x)).ToList() : null

            };
        }

        public ItemB2bViewModel BuildListItemB2b(ItemViewModel x, DateTime searchDate, List<ItemSalesPriceViewModel> listTtemSalesPrice = null, int Precision = 3, List<EquivalenceItemForBtoBViewModel> listEquivanceItemForBtoB = null)
        {
            List<PriceCategoryViewModel> itemPrices = new List<PriceCategoryViewModel>();
            EquivalenceItemForBtoBViewModel equivalentItem = listEquivanceItemForBtoB.Where(y => y.EquivalenceItem == x.EquivalenceItem && y.IdItem == x.Id).FirstOrDefault();
            if (equivalentItem.EquivalenceItem != null)
            {
                equivalentItem.EquivalenceItems.Remove(x.Id);
            }
            listTtemSalesPrice.ForEach(y =>
            {
                y.Price = Math.Round((double)(((1 + (y.Percentage / 100)) * x.UnitHtsalePrice)), Precision);
                itemPrices.Add(new PriceCategoryViewModel
                {
                    Price = y.Price,
                    IdItem = y.IdItem,
                    IdSalesPrice = y.IdSalesPrice
                });
            });
            if (x.UpdatedDatePicture != null && x.UpdatedDatePicture.HasValue && (DateTime.Compare(x.UpdatedDatePicture.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDatePicture.Value, searchDate) == NumberConstant.Zero &&
             TimeSpan.Compare(x.UpdatedDatePicture.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero)))
            {
                x.IsUpdatedPicture = true;
            }
            return new ItemB2bViewModel
            {
                Code = x.Code,
                Id = x.Id,
                Description = x.Description,
                Htprice = x.Htprice,
                UnitHtsalePrice = x.UnitHtsalePrice,
                UnitTtcpurchasePrice = x.UnitTtcpurchasePrice,
                UnitTtcsalePrice = x.UnitTtcsalePrice,
                IdProductItem = x.IdProductItem,
                IdFamily = x.IdFamily,
                IdSubFamily = x.IdSubFamily,
                ListOfEquivalenceItem = equivalentItem.EquivalenceItems,
                AllAvailableQuantity = (x.ItemWarehouse != null && x.ItemWarehouse.Any()) ?
                     x.ItemWarehouse.Sum(z => z.AvailableQuantity - z.ReservedQuantity)
                    : 0,
                IsForSales = x.IsForSales,
                IsForPurchase = x.IsForPurchase,
                IdItemReplacement = x.IdItemReplacement,
                IsAvailable = x.IsAvailable,
                IsDeleted = x.IsDeleted,
                UrlPicture = x.UrlPicture,
                FilesInfos = x.FilesInfos,
                PictureFileInfo = x.PictureFileInfo,
                LabelProduct = x.LabelProduct,
                ItemSalesPrice = itemPrices,
                IsUpdatedPicture = x.IsUpdatedPicture,
                IdBrands = x.ItemVehicleBrandModelSubModel.Select(y => y.IdVehicleBrand).ToList()


            };
        }

        public ItemViewModel BuildItemEntity(Item entity)
        {
            ItemViewModel model = new ItemViewModel();
            if (entity != null)
            {
                model = base.BuildEntity(entity);
                if (entity.ItemTiers.Count > 0)
                {
                    model.ListTiers = model.ItemTiers.Select(x => x.IdTiersNavigation).ToList();
                }

                if (entity.IdProductItemNavigation != null && entity.IdProductItemNavigation.LabelProduct != null)
                {
                    model.LabelProduct = entity.IdProductItemNavigation.LabelProduct;
                }
                #endregion
            }
            return model;
        }
    }
}