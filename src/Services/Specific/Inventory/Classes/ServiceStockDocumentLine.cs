using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceStockDocumentLine : Service<StockDocumentLineViewModel, StockDocumentLine>, IServiceStockDocumentLine
    {
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IRepository<Warehouse> _entityRepoWarehouse;
        private readonly IRepository<StockDocument> _entityStockDocumentRepo;
        private readonly IRepository<Storage> _entityStorageRepo;


        public ServiceStockDocumentLine(IRepository<StockDocumentLine> entityRepo, IUnitOfWork unitOfWork,
          IStockDocumentLineBuilder entityBuilder,
          IServiceItemWarehouse serviceItemWarehouse,
          IRepository<Warehouse> entityRepoWarehouse,
          IServiceDocumentLine serviceDocumentLine,
        IRepository<DocumentLine> entityRepoDocumentLine,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<StockDocument> entityStockDocumentRepo, IRepository<Storage> entityStorageRepo)
            : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceItemWarehouse = serviceItemWarehouse;
            _entityRepoWarehouse = entityRepoWarehouse;
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _entityStockDocumentRepo = entityStockDocumentRepo;
            _serviceDocumentLine = serviceDocumentLine;
            _entityStorageRepo = entityStorageRepo;
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineList(InventoryDocumentViewModel inventoryDocument)
        {

            var listModel = new DataSourceResult<StockDocumentLineViewModel>();
            var relationpredicate = new Expression<Func<StockDocumentLine, object>>[] { x => x.IdWarehouseNavigation, x => x.IdItemNavigation };
            StockDocument stockDocument = _entityStockDocumentRepo.GetAllAsNoTracking().FirstOrDefault(p => p.Id == inventoryDocument.IdStockDocument);

            IQueryable<StockDocumentLine> stockDocumentLineQuery = _entityRepo.GetAllAsNoTracking().Include(p => p.IdWarehouseNavigation).Include(p => p.IdItemNavigation).ThenInclude(p => p.IdUnitStockNavigation)
                 .Where(p => p.IdStockDocument == inventoryDocument.IdStockDocument);
            if (inventoryDocument.Predicate != null)
            {
                var pred = PreparePredicate(inventoryDocument.Predicate);
                stockDocumentLineQuery = stockDocumentLineQuery.Where(pred.PredicateWhere);
            }

            if (inventoryDocument.RefDescription != null)
            {
                stockDocumentLineQuery = stockDocumentLineQuery.Where(p => (p.IdItemNavigation.Code + p.IdItemNavigation.Description).ToUpper().Contains(inventoryDocument.RefDescription.ToUpper()));
            }

            if (stockDocument.IdWarehouseSource != null)
            {
                listModel.data = stockDocumentLineQuery.OrderBy(p => p.Storage).ThenBy(p => p.IdItemNavigation.Code).Skip(inventoryDocument.Skip).Take(inventoryDocument.Take)
                    .Select(line => _builder.BuildEntity(line)).ToList();
            }
            else
            {
                listModel.data = stockDocumentLineQuery.OrderBy(p => p.IdWarehouse).ThenBy(p => p.Shelf).ThenBy(p => p.Storage).ThenBy(p => p.IdItemNavigation.Code).Skip(inventoryDocument.Skip).Take(inventoryDocument.Take)
                    .Select(line => _builder.BuildEntity(line)).ToList();
            }

            listModel.total = stockDocumentLineQuery.Count();
            return listModel;
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineList(InventoryDocumentLineViewModel inventoryDocument, bool isUserInInventoryListRole)
        {
            var listModel = new DataSourceResult<StockDocumentLineViewModel>();
            var relationpredicate = new Expression<Func<StockDocumentLine, object>>[] { x => x.IdItemNavigation.IdNatureNavigation };
            var alldata = GetAllModelsQueryable(x => x.IdStockDocument == inventoryDocument.IdStockDocument, relationpredicate);
            if ((!string.IsNullOrWhiteSpace(inventoryDocument.Code) && !string.IsNullOrWhiteSpace(inventoryDocument.Description))
                || (!string.IsNullOrWhiteSpace(inventoryDocument.Barcode1D) && !string.IsNullOrWhiteSpace(inventoryDocument.Barcode2D)))
            {
                alldata = GetAllModelsQueryable(x => x.IdStockDocument == inventoryDocument.IdStockDocument
                && (x.IdItemNavigation.Code.Contains(inventoryDocument.Code) || x.IdItemNavigation.Description.Contains(inventoryDocument.Description))
                && (x.IdItemNavigation.BarCode1D.Contains(inventoryDocument.Barcode1D) || x.IdItemNavigation.BarCode2D.Contains(inventoryDocument.Barcode2D)), relationpredicate);
            }
            listModel.data = alldata.Skip(inventoryDocument.Skip).Take(inventoryDocument.Take).ToList();
            if (!isUserInInventoryListRole)
            {
                listModel.data.ToList().ForEach(y => y.ActualQuantity = -1);
            }
            listModel.total = alldata.Count();
            return listModel;
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<DailySalesLineViewModel> GetStockDailyDocumentLineList(List<PredicateFormatViewModel> predicateModel, bool isUserInInventoryListRole)
        {
            var allstockDocumenLine = new List<DailySalesLineViewModel>();
            PredicateFilterRelationViewModel<DocumentLine> predicateFilterRelationModel = null;
            PredicateFormatViewModel predIsDefaultPredicate = predicateModel.Where(x => x.IsDefaultPredicate).FirstOrDefault();
            DateTime startDate = new DateTime();
            DateTime endDate = new DateTime();
            int warehouseId = 0;
            if (predIsDefaultPredicate.Filter.Any(x => x.Prop == "StartDocumentDate"))
            {
                startDate = Convert.ToDateTime(predIsDefaultPredicate.Filter.Where(x => x.Prop == "StartDocumentDate").FirstOrDefault().Value);
            }
            if (predIsDefaultPredicate.Filter.Any(x => x.Prop == "EndDocumentDate"))
            {
                endDate = Convert.ToDateTime(predIsDefaultPredicate.Filter.Where(x => x.Prop == "EndDocumentDate").FirstOrDefault().Value);
            }
            warehouseId = predIsDefaultPredicate.Filter.Any(x => x.Prop == "IdWarehouse") ? Convert.ToInt32(predIsDefaultPredicate.Filter.Where(x => x.Prop == "IdWarehouse").FirstOrDefault().Value) : 0;

            predicateFilterRelationModel = _serviceDocumentLine.PreparePredicate(predIsDefaultPredicate);

            IQueryable<DocumentLine> queryItemSalesDelivery = _entityRepoDocumentLine.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .Where(x => (startDate.Year > 1 ? x.IdDocumentNavigation.DocumentDate.Date >= startDate.Date : true) &&
            (endDate.Year > 1 ? x.IdDocumentNavigation.DocumentDate.Date <= endDate.Date : true) && (x.IdWarehouse != null && x.IdWarehouse.Value == warehouseId) && x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional &&
            (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS));

            List<DocumentLine> linesBL = queryItemSalesDelivery.ToList();
            var idWarhouse = predIsDefaultPredicate.Filter.Where(x => x.Prop == "IdWarehouse").FirstOrDefault().Value;
            var allSaleDocumenLine = linesBL?.GroupBy(x => new { x.IdItem, x.IdWarehouse }).ToList();

            if (allSaleDocumenLine != null && allSaleDocumenLine.Any())
            {
                var listOfItem = new List<Item>();
                allSaleDocumenLine.ForEach(y =>
                {
                    listOfItem.Add(y.FirstOrDefault().IdItemNavigation);
                });

                _serviceItemWarehouse.GetAllRealQuantityFolAllItem(listOfItem, Convert.ToDouble(idWarhouse));
                Warehouse warehouse = null;
                if (Convert.ToDouble(idWarhouse) > 0)
                {
                    warehouse = _entityRepoWarehouse.FindSingleBy(x => x.Id == Convert.ToInt32(idWarhouse));
                }
                IQueryable<Storage> storages = _entityStorageRepo.QuerableGetAll(x => x.IdShelfNavigation);
                allSaleDocumenLine.ForEach(a =>
                {
                    var documentLine = a.FirstOrDefault();
                    var linesDeliverValidQty = linesBL.Where(c => c.IdItem == documentLine.IdItem && c.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery && c.IdWarehouse == documentLine.IdWarehouse).Select(y => y.MovementQty).Sum();
                    var linesBSValidQty = linesBL.Where(c => c.IdItem == documentLine.IdItem && c.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS && c.IdWarehouse == documentLine.IdWarehouse).Select(y => y.MovementQty).Sum();
                    var linesAvoirVenteQty = linesBL.Where(c => c.IdItem == documentLine.IdItem && c.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset && c.IdWarehouse == documentLine.IdWarehouse).Select(y => y.MovementQty).Sum();

                    ItemWarehouse itemWarehouseSelected = null;
                    if (documentLine.IdItemNavigation.ItemWarehouse != null && documentLine.IdItemNavigation.ItemWarehouse.Any())
                    {
                        itemWarehouseSelected = documentLine.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == documentLine.IdWarehouse).FirstOrDefault();
                    }

                    allstockDocumenLine.Add(new DailySalesLineViewModel
                    {
                        CodeItem = documentLine.IdItemNavigation.Code,
                        Designation = documentLine.IdItemNavigation.Description,
                        AvailableQty = itemWarehouseSelected != null && itemWarehouseSelected.AvailableQuantity != null ? itemWarehouseSelected.AvailableQuantity : 0,
                        ValidBLQty = linesDeliverValidQty + linesBSValidQty,
                        SoldQty = linesBSValidQty + linesDeliverValidQty - linesAvoirVenteQty,
                        SalesAssetQty = linesAvoirVenteQty,
                        WarehouseCode = warehouse != null ? warehouse.WarehouseCode : (documentLine.IdWarehouseNavigation != null ? documentLine.IdWarehouseNavigation.WarehouseCode : ""),
                        WarehouseName = warehouse != null ? warehouse.WarehouseName : (documentLine.IdWarehouseNavigation != null ? documentLine.IdWarehouseNavigation.WarehouseName : ""),

                        Shelf = itemWarehouseSelected != null && itemWarehouseSelected.Shelf != null && itemWarehouseSelected.Shelf.Length > 0 ? itemWarehouseSelected.Shelf : (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ?
                       storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.IdShelfNavigation.Label).FirstOrDefault() : ""),

                        Storage = itemWarehouseSelected != null && itemWarehouseSelected.Storage != null && itemWarehouseSelected.Storage.Length > 0 ? itemWarehouseSelected.Storage :
                        (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ? storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.Label).FirstOrDefault() : ""),
                    });
                });
            }


            PredicateFormatViewModel predAdvancedOrQuickSearch = predicateModel.Where(x => !x.IsDefaultPredicate).FirstOrDefault();


            Operator key = predAdvancedOrQuickSearch.Operator == 0 ? Operator.And : predAdvancedOrQuickSearch.Operator;
            Expression<Func<DailySalesLineViewModel, bool>> predicateWhere = PredicateUtility<DailySalesLineViewModel>.PredicateFilter(predAdvancedOrQuickSearch, key);
            Expression<Func<DailySalesLineViewModel, object>>[] predicateRelations = PredicateUtility<DailySalesLineViewModel>.PredicateRelation(predAdvancedOrQuickSearch.Relation);
            PredicateFilterRelationViewModel<DailySalesLineViewModel> predicateFilterRelationModelAdvancedOrQuickSearch = new PredicateFilterRelationViewModel<DailySalesLineViewModel>(predicateWhere, predicateRelations);
            return allstockDocumenLine.AsQueryable<DailySalesLineViewModel>().Where(predicateFilterRelationModelAdvancedOrQuickSearch.PredicateWhere).ToList();

        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<DailySalesLineViewModel> GetStockDailyDocumentLineList(int? idwarehouse, DateTime startdate, DateTime endate, bool isUserInInventoryListRole)
        {
            return null;
            var salesInventoryDocumentLineViewModel = new SalesInventoryDocumentLineViewModel
            {
                StartDate = startdate,
                EndDate = endate,
                IdWarehouse = idwarehouse
            };
            // return GetStockDailyDocumentLineList(salesInventoryDocumentLineViewModel, isUserInInventoryListRole);
        }

        public DataSourceResult<StockDocumentLineViewModel> GetStockInventoryDocumentLine(InventoryDocumentViewModel model, bool isUserInInventoryListRole)
        {
            var query = _entityRepo.GetAllAsNoTracking().Include(p => p.IdItemNavigation).Where(p => p.IdStockDocument == model.IdStockDocument);
            return new DataSourceResult<StockDocumentLineViewModel>
            {
                total = query.Count(),
                data = query.Skip(model.Skip).Take(model.Take).Select(p => _builder.BuildEntity(p)).ToList()
            };
        }

        public DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineByIdItem(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<StockDocumentLine> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // Get list of stockDocument
            IQueryable<StockDocumentLine> queryableListOfDocumentLine = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                .OrderByRelation(predicateModel.OrderBy)
                .Where(predicateFilterRelationModel.PredicateWhere);

            return new DataSourceResult<StockDocumentLineViewModel>
            {
                total = queryableListOfDocumentLine.Count(),
                data = queryableListOfDocumentLine.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).Select(p => _builder.BuildEntity(p)).ToList()
            };
        }




    }
}
