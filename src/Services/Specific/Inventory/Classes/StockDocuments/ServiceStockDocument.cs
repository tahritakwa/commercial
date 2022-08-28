using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes.StockDocuments
{
    public partial class ServiceStockDocument : Service<StockDocumentViewModel, StockDocument>, IServiceStockDocument
    {
        public readonly IStockDocumentBuilder _entityBuilder;
        private readonly IServiceStockDocumentLine _serviceStockDocumentLine;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IServiceItem _serviceItem;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IRepository<Tiers> _repoEntityTiers;
        private readonly IRepository<DocumentLine> _repoEntityDocumentLine;
        private readonly IRepository<Document> _repoEntityDocument;
        private readonly IRepository<StockDocument> _repoEntityStockDocument;
        private readonly IRepository<City> _repoEntityCity;
        private readonly IRepository<Company> _repoEntityCompany;
        private readonly IRepository<Country> _repoEntityCountry;
        private readonly IRepository<Warehouse> _repoEntityWarehouse;
        private readonly IRepository<ItemWarehouse> _repoEntityItemWarehouse;
        private readonly IRepository<StockMovement> _entityStockMovementRepo;
        private readonly IRepository<StockDocumentLine> _entityStockDocumentLineRepo;
        private readonly IStockMovementBuilder _stockMovementBuilder;
        private readonly IServiceEcommerce _serviceTriggerItem;
        private readonly IRepository<Item> _entityRepoItem;
        private readonly IServiceShelf _serviceShelf;
        private readonly IServiceStorage _serviceStorage;
        public readonly IStockDocumentLineBuilder _stockDocumentLineBuilder;
        private readonly IRepository<ItemTiers> _entityItemTiersRepo;


        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IRepository<User> _entityUserRepo;
        public ServiceStockDocument(IOptions<AppSettings> appSettings, IRepository<StockDocument> entityRepo, IUnitOfWork unitOfWork, IStockDocumentBuilder stockDocumentBuilder,
            IServiceStockDocumentLine serviceStockDocumentLine, IServiceStockMovement serviceStockMovement, IServiceItemWarehouse serviceItemWarehouse,
            IServiceItem serviceItem,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
            IRepository<StockDocumentLine> entityStockDocumentLineRepo,
            IRepository<Tiers> repoEntityTiers,
            IRepository<DocumentLine> repoEntityDocumentLine,
            IRepository<StockDocument> repoEntityStockDocument,
            IRepository<City> repoEntityCity,
            IRepository<Company> repoEntityCompany,
            IRepository<Country> repoEntityCountry,
            IRepository<Warehouse> repoEntityWarehouse,
            IServiceShelf serviceShelf,
            IServiceDocumentLine serviceDocumentLine,
            IServiceWarehouse serviceWarehouse,
            IServiceEcommerce serviceTriggerItem,
            IServiceDocument serviceDocument,
            IServiceCompany serviceCompany,
            IServiceMsgNotification serviceMessageNotification,
            IRepository<ItemTiers> entityItemTiersRepo,
            IRepository<StockMovement> entityStockMovementRepo, IRepository<Document> repoEntityDocument,
            IStockMovementBuilder stockMovementBuilder, IStockDocumentLineBuilder stockDocumentLineBuilder, IRepository<ItemWarehouse> repoEntityItemWarehouse,
             IRepository<Item> entityRepoItem, IServiceStorage serviceStorage, IServiceMasterUser serviceMasterUser, IRepository<User> entityUserRepo)
            : base(entityRepo, unitOfWork, stockDocumentBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, repoEntityCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityBuilder = stockDocumentBuilder;
            _entityRepoEntity = entityRepoEntity;
            _serviceStockDocumentLine = serviceStockDocumentLine;
            _serviceStockMovement = serviceStockMovement;
            _serviceItemWarehouse = serviceItemWarehouse;
            _serviceItem = serviceItem;
            _serviceDocument = serviceDocument;
            _serviceMessageNotification = serviceMessageNotification;
            _entityStockMovementRepo = entityStockMovementRepo;
            _stockMovementBuilder = stockMovementBuilder;
            _entityItemTiersRepo = entityItemTiersRepo;
            _entityStockDocumentLineRepo = entityStockDocumentLineRepo;
            _repoEntityTiers = repoEntityTiers;
            _repoEntityDocumentLine = repoEntityDocumentLine;
            _repoEntityCity = repoEntityCity;
            _repoEntityCompany = repoEntityCompany;
            _repoEntityCountry = repoEntityCountry;
            _repoEntityWarehouse = repoEntityWarehouse;
            _repoEntityItemWarehouse = repoEntityItemWarehouse;
            _repoEntityDocument = repoEntityDocument;
            _serviceTriggerItem = serviceTriggerItem;
            _entityRepoItem = entityRepoItem;
            _repoEntityStockDocument = repoEntityStockDocument;
            _serviceShelf = serviceShelf;
            _serviceStorage = serviceStorage;
            _serviceCompany = serviceCompany;
            _serviceMasterUser = serviceMasterUser;
            _entityUserRepo = entityUserRepo;
        }
        public DataSourceResult<StockDocumentViewModel> GetInventoryMovementList(PredicateWithDateFilterInformationViewModel model)
        {
            PredicateFilterRelationViewModel<StockDocument> predicateFilterRelationModel = PreparePredicate(model.Predicate);
            // Get list of stockDocument
            IQueryable<StockDocument> queryableListOfStockDocument = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).OrderByRelation(model.Predicate.OrderBy).
                Where(predicateFilterRelationModel.PredicateWhere);

            if (model.StartDate != null && model.EndDate != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
                ((DateTime)x.DocumentDate).Date >= ((DateTime)model.StartDate).Date &&
                ((DateTime)x.DocumentDate).Date <= ((DateTime)model.EndDate).Date);
            }
            else if (model.StartDate != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
                ((DateTime)x.DocumentDate).Date >= ((DateTime)model.StartDate).Date);
            }
            else if (model.EndDate != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
                ((DateTime)x.DocumentDate).Date <= ((DateTime)model.EndDate).Date);
            }
            if (model.IdWarehouseSource != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
               (x.IdWarehouseSource == model.IdWarehouseSource));
            }
            if (model.IdWarehouseDestination != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
               (x.IdWarehouseDestination == model.IdWarehouseDestination));
            }
            if (model.Status != null)
            {
                queryableListOfStockDocument = queryableListOfStockDocument.Where(x =>
               (x.IdDocumentStatus == model.Status));
            }
            int total = queryableListOfStockDocument.Count();
            IList<StockDocumentViewModel> listOfStockDocument = queryableListOfStockDocument.Skip(
                (model.Predicate.page - 1) * model.Predicate.pageSize).Take(model.Predicate.pageSize).Select(_builder.BuildEntity).ToList();
            foreach (StockDocumentViewModel document in listOfStockDocument)
            {
                if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    document.IdDocumentStatusNavigation.Color = "ecb50e";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    document.IdDocumentStatusNavigation.Color = "4dbd74";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed)
                {
                    document.IdDocumentStatusNavigation.Color = "4608a0";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
                {
                    document.IdDocumentStatusNavigation.Color = "20a8d8";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft ||
                           document.IdDocumentStatus == (int)DocumentStatusEnumerator.Transferred || document.IdDocumentStatus == (int)DocumentStatusEnumerator.NotSatisfied ||
                           document.IdDocumentStatus == (int)DocumentStatusEnumerator.ToOrder || document.IdDocumentStatus == (int)DocumentStatusEnumerator.Received)
                {
                    document.IdDocumentStatusNavigation.Color = "0d35a3";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied
                    || document.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)
                {
                    document.IdDocumentStatusNavigation.Color = "816fa5";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Refused)
                {
                    document.IdDocumentStatusNavigation.Color = "f86c6b";
                }
                if (document.IdStorageDestinationNavigation != null && document.IdStorageDestinationNavigation.IdShelf != null)
                {
                    document.shelfDestinationLabel = _serviceShelf.GetModelById(document.IdStorageDestinationNavigation.IdShelf.Value).Label;
                }

                if (document.IdStorageSourceNavigation != null && document.IdStorageSourceNavigation.IdShelf != null)
                {
                    document.shelfSourceLabel = _serviceShelf.GetModelById(document.IdStorageSourceNavigation.IdShelf.Value).Label;
                }
            }
            return new DataSourceResult<StockDocumentViewModel> { data = listOfStockDocument, total = total };
        }

        public override DataSourceResult<StockDocumentViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            DataSourceResult<StockDocumentViewModel> listOfStockDocument = base.GetDataWithSpecificFilter(predicateModel);
            var shelvesIds = listOfStockDocument.data.Where(x => x.IdStorageSourceNavigation != null).Select(x => x.IdStorageSourceNavigation.IdShelf.Value).ToList();
            shelvesIds.AddRange(listOfStockDocument.data.Select(x => x.IdStorageDestinationNavigation.IdShelf.Value).ToList());
            shelvesIds = shelvesIds.Distinct().ToList();
            var o = _serviceShelf.GetModelsWithConditionsRelations(x => shelvesIds.Contains(x.Id));
            foreach (StockDocumentViewModel document in listOfStockDocument.data)
            {
                if (document.IdStorageDestinationNavigation != null && document.IdStorageDestinationNavigation.IdShelf != null)
                {
                    document.shelfDestinationLabel = o.Where(x => x.Id == document.IdStorageDestinationNavigation.IdShelf).FirstOrDefault().Label + (document.IdStorageDestinationNavigation.Label);
                }

                if (document.IdStorageSourceNavigation != null && document.IdStorageSourceNavigation.IdShelf != null)
                {
                    document.shelfSourceLabel = o.Where(x => x.Id == document.IdStorageSourceNavigation.IdShelf).FirstOrDefault().Label + (document.IdStorageSourceNavigation.Label);
                }
            }
            return listOfStockDocument;
        }
        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<StockDocumentViewModel> GetStockDocumentList(PredicateFormatViewModel predicateModel)
        {
            // Get list of stockDocument
            DataSourceResult<StockDocumentViewModel> listOfStockDocument = base.FindDataSourceModelBy(predicateModel);

            foreach (StockDocumentViewModel stockDocumentViewModel in listOfStockDocument.data)
            {
                // if stockDocument is Valide or Solde ==> set CanDelete and CanEdit CanValidate to false
                if (stockDocumentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Valid)
                    || stockDocumentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Balanced)
                    || stockDocumentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Refused))
                {
                    stockDocumentViewModel.CanEdit = false;
                    stockDocumentViewModel.CanValidate = false;
                    stockDocumentViewModel.CanDelete = false;
                }
                // if stockDocument is Provisoire ==> set CanShow to false
                else
                {
                    stockDocumentViewModel.CanShow = false;
                }
            }
            return listOfStockDocument;
        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                dynamic entityToDelete = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == id, x => x.TypeStockDocumentNavigation);
                if (entityToDelete.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional)
                {
                    throw new CustomException(CustomStatusCode.CantDeleteValidInventory);
                }
                if (entityToDelete != null && entityToDelete.TypeStockDocument != null && entityToDelete.TypeStockDocument != DocumentEnumerator.InventoryMovement)
                {
                    DeleteLineOfDoc(id);

                }
                else
                {
                    _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdStockDocument == id).UpdateFromQuery(p => new StockDocumentLine
                    {
                        IsDeleted = true,
                        DeletedToken = Guid.NewGuid().ToString()
                    });
                    int idsStockDocumentLines = entityToDelete.Id;
                    _entityStockMovementRepo.GetAllAsNoTracking().Where(x => x.IdStockDocumentLine != null && ((int)x.IdStockDocumentLine) == idsStockDocumentLines).UpdateFromQuery(x => new StockMovement
                    {
                        IsDeleted = true,
                        DeletedToken = Guid.NewGuid().ToString()
                    });
                    _unitOfWork.Commit();
                }

                var obj = DeleteModelwithouTransaction(entityToDelete, id, tableName, userMail);
                EndTransaction();
                return obj;
            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw ex;
            }
        }

        public object DeleteModelwithouTransaction(dynamic entityToDelete, int id, string tableName, string userMail)
        {

            if (entityToDelete.GetType().GetProperty("IsDeleted") != null)
            {
                //Change value of isDeleted to True
                entityToDelete.IsDeleted = true;
                entityToDelete.DeletedToken = Guid.NewGuid().ToString();
            }
            //Update entity
            _entityRepo.Update(entityToDelete);
            _unitOfWork.Commit();
            return new CreatedDataViewModel { Id = entityToDelete.Id, EntityName = entityToDelete.GetType().Name.ToUpper() + "_" + entityToDelete.TypeStockDocument };
        }

        /// <summary>
        /// Create list of stock movement
        /// </summary>
        /// <param name="stockDocument"></param>
        /// <param name="stockDocumentLinesViewModel"></param>
        public void CreateStockMovement(StockDocumentViewModel stockDocumentViewModel, List<StockDocumentLineViewModel> stockDocumentLinesViewModel, string statusOfLine = null)
        {

            if (stockDocumentViewModel.TypeStockDocument.Equals(DocumentEnumerator.InputMovement))
            {
                CreateInputMovementDocument(stockDocumentLinesViewModel, stockDocumentViewModel.DocumentDate.Value,
                        stockDocumentViewModel.IdWarehouseSource.Value);
            }
            else if (stockDocumentViewModel.TypeStockDocument.Equals(DocumentEnumerator.OutputMovement))
            {
                CreateOutputMovementDocument(stockDocumentLinesViewModel, stockDocumentViewModel.DocumentDate.Value,
                        stockDocumentViewModel.IdWarehouseSource.Value);
            }
            else if (stockDocumentViewModel.TypeStockDocument.Equals(DocumentEnumerator.TransferMovement))
            {
                CreateTransfertMovementDocument(stockDocumentLinesViewModel, stockDocumentViewModel.DocumentDate.Value,
                        stockDocumentViewModel.IdWarehouseSource.Value, stockDocumentViewModel.IdWarehouseDestination.Value, statusOfLine);
            }
            else if (stockDocumentViewModel.TypeStockDocument.Equals(DocumentEnumerator.InventoryMovement))
            {
                CreateInventoryDocument(stockDocumentLinesViewModel, stockDocumentViewModel.DocumentDate.Value,
                        stockDocumentViewModel.IdWarehouseSource.Value);
            }
        }


        public StockDocumentViewModel AddInventoryDocument(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();

                if ((stockDocumentViewModel.IdWarehouseSource != null &&
                     _entityRepo.GetAllAsNoTracking().Any(c => c.TypeStockDocument == DocumentEnumerator.InventoryMovement
                            && c.IdWarehouseSource == stockDocumentViewModel.IdWarehouseSource
                            && ((stockDocumentViewModel.Shelf == null && c.Shelf != null) || c.Shelf == null || c.Shelf == stockDocumentViewModel.Shelf)
                            && (c.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || c.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)))
                    || (stockDocumentViewModel.IdTiers != null && _entityRepo.GetAllAsNoTracking().Any(c => c.TypeStockDocument == DocumentEnumerator.InventoryMovement
                            && c.IdTiers == stockDocumentViewModel.IdTiers
                            && (c.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || c.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft))))
                {
                    throw new CustomException(CustomStatusCode.AddExistingInventory);
                }
                if (!stockDocumentViewModel.FromUserDropdown)
                {
                    var masterUser = _serviceMasterUser.getEntityById(stockDocumentViewModel.IdInputUser1.Value);
                    if (masterUser != null)
                    {
                        var idUser = _entityUserRepo.FindSingleBy(x => x.Email == masterUser.Email).Id;
                        stockDocumentViewModel.IdInputUser1 = idUser;
                    }

                }
                var addresult = (CreatedDataViewModel)AddModelWithoutTransaction(stockDocumentViewModel, entityAxisValuesModelList, userMail, "TypeStockDocument");
                stockDocumentViewModel.Code = addresult.Code;
                stockDocumentViewModel.Id = addresult.Id;
                stockDocumentViewModel.DocumentDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                if (stockDocumentViewModel.IsPlannedInventory != null && !(bool)stockDocumentViewModel.IsPlannedInventory)
                {
                    AddInventoryDocumentLines(stockDocumentViewModel);
                }
                StockDocumentViewModel result = GetModelWithRelationsAsNoTracked(x => x.Id == stockDocumentViewModel.Id, x => x.IdInputUser1Navigation, x => x.IdInputUser2Navigation);
                stockDocumentViewModel.IdInputUser1Navigation = result.IdInputUser1Navigation;
                stockDocumentViewModel.IdInputUser2Navigation = result.IdInputUser2Navigation;
                EndTransaction();
                return stockDocumentViewModel;

            }
            catch (CustomException e)
            {
                RollBackTransaction();
                throw e;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                // thorw the original exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        public void AddInventoryDocumentLines(StockDocumentViewModel model)
        {
            List<StockDocumentLineViewModel> stockDocumentLine = new List<StockDocumentLineViewModel>();
            if (model.IdWarehouseSource != null)
            {
                stockDocumentLine = _repoEntityItemWarehouse.GetAllAsNoTracking().Where(x => x.IdWarehouse == model.IdWarehouseSource
                && (model.Shelf != null ? model.Shelf == x.Shelf : true) && ((bool)model.IsOnlyAvailableQuantity ? x.AvailableQuantity != 0 : true)
                && x.IdItemNavigation.IdNatureNavigation.IsStockManaged).Include(z => z.IdItemNavigation).OrderBy(p => p.Shelf).ThenBy(p => p.Storage).ThenBy(p => p.IdItemNavigation.Code)
                .Select(item => new StockDocumentLineViewModel
                {
                    IdUnitStock = item.IdItemNavigation.IdUnitStock,
                    IdItem = item.IdItem,
                    ForecastQuantity = (bool)model.IsDefaultValue ? item.AvailableQuantity : 0,
                    ForecastQuantity2 = ((bool)model.IsDefaultValue && model.IdInputUser2 != null) ? item.AvailableQuantity : 0,
                    ActualQuantity = item.AvailableQuantity,
                    IdStockDocument = model.Id,
                    Storage = item.Storage,
                    Shelf = (model.Shelf != null) ? null : item.Shelf
                }).ToList();
                VerifConditionsInventory(stockDocumentLine);
                int numberProvStockMvtWithDepot = _entityStockMovementRepo.GetCountWithPredicate(x => x.IdWarehouse == model.IdWarehouseSource
                    && x.Status == DocumentEnumerator.Provisional && x.MovementQty > 0 && (x.IdDocumentLineNavigation != null ? x.IdDocumentLineNavigation.IdDocumentNavigation.DocumentTypeCode != DocumentEnumerator.PurchaseFinalOrder : true) &&
         (x.IdStockDocumentLineNavigation != null ? ((x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.TransferMovement ||
                 x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.TransferShelfStorage) && x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional) : true));
                if (numberProvStockMvtWithDepot > 0)
                {
                    throw new CustomException(CustomStatusCode.ItemsExistInProvisonalStockMovement);
                }

            }
            else
            {

                stockDocumentLine = _repoEntityItemWarehouse.GetAllAsNoTracking().Where(x => x.IdItemNavigation.ItemTiers.Select(z => z.IdTiers).Contains(model.IdTiers ?? 0) &&
                 ((bool)model.IsOnlyAvailableQuantity ? x.AvailableQuantity != 0 : true) && x.IdItemNavigation.IdNatureNavigation.IsStockManaged)
                    .Include(z => z.IdItemNavigation)
                    .OrderBy(p => p.Shelf).ThenBy(p => p.Storage).ThenBy(p => p.IdItemNavigation.Code)
                    .Select(item => new StockDocumentLineViewModel
                    {
                        IdUnitStock = item.IdItemNavigation.IdUnitStock,
                        IdItem = item.IdItem,
                        ForecastQuantity = (bool)model.IsDefaultValue ? item.AvailableQuantity : 0,
                        ForecastQuantity2 = ((bool)model.IsDefaultValue && model.IdInputUser2 != null) ? item.AvailableQuantity : 0,
                        ActualQuantity = item.AvailableQuantity,
                        IdStockDocument = model.Id,
                        IdWarehouse = item.IdWarehouse,
                        Storage = item.Storage,
                        Shelf = item.Shelf
                    }).ToList();
                VerifConditionsInventory(stockDocumentLine);
                int numberProvStockMvt = _entityStockMovementRepo.GetCountWithPredicate(x => ((x.IdItemNavigation.ItemTiers != null && x.IdItemNavigation.ItemTiers.Any()) ? x.IdItemNavigation.ItemTiers.Select(z => z.IdTiers).Contains((int)model.IdTiers) : true) &&
         x.Status == DocumentEnumerator.Provisional && x.MovementQty > 0 && (x.IdDocumentLineNavigation != null ? x.IdDocumentLineNavigation.IdDocumentNavigation.DocumentTypeCode != DocumentEnumerator.PurchaseFinalOrder : true) &&
         (x.IdStockDocumentLineNavigation != null ? ((x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.TransferMovement ||
                 x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.TransferShelfStorage) && x.IdStockDocumentLineNavigation.IdStockDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional) : true));
                if (numberProvStockMvt > 0)
                {
                    throw new CustomException(CustomStatusCode.ItemsExistInProvisonalStockMovement);
                }
            }

            UpdateStatusInventoryItem(stockDocumentLine.Select(x => x.IdItem).Distinct().ToList(), true);
            _serviceStockDocumentLine.BulkAddWithoutTransaction(stockDocumentLine);
        }



        void UpdateStatusInventoryItem(List<int> itemsIds, bool isProvInventory)
        {

            _entityRepoItem.QuerableGetAll().Where(p => itemsIds.Contains(p.Id))
               .UpdateFromQuery(x => new Item { ProvInventory = isProvInventory });
            _unitOfWork.Commit();
        }
        //private double calculateQuantityToUpdate(int iditem, DateTime endate)
        //{
        //    var allSaleDocumenLine = _serviceDocumentLine.GetAllModelsQueryable(x => x.IdItem == iditem &&
        //           x.IdDocumentNavigation.DocumentDate.Date <= endate.Date &&
        //           (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery
        //           || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.Reservation)
        //           && (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
        //           || x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)).Distinct();

        //    var allPurchaseDocumenLine = _serviceDocumentLine.GetAllModelsQueryable(x => x.IdItem == iditem &&
        //           x.IdDocumentNavigation.DocumentDate.Date <= endate.Date &&
        //           (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
        //           && (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
        //           || x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)).Distinct();

        //    var sumquantity = allPurchaseDocumenLine.Sum(x => x.MovementQty) - allSaleDocumenLine.Sum(x => x.MovementQty) - allPurchaseDocumenLine.Sum(x => x.RemainingQuantity);

        //    return sumquantity;
        //}

        private void VerifConditionsInventory(List<StockDocumentLineViewModel> stockDocumentLine)
        {
            if (stockDocumentLine.Count <= 0)
            {
                throw new CustomException(CustomStatusCode.NoRowForThisInventory);
            }

            if (stockDocumentLine.Where(x => x.IdUnitStock == null).Any())
            {
                throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
            }
        }

        public void AddPlannedInventoryDocumentLines(string connectionString)
        {
            try
            {
                BeginTransaction(connectionString);
                var plannedinventory = FindByAsNoTracking(c => c.TypeStockDocument == DocumentEnumerator.InventoryMovement
                    && c.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
                    && c.IsPlannedInventory == true
                    && c.DocumentDate.Value.Day == DateTime.Today.Day
                    && c.DocumentDate.Value.Month == DateTime.Today.Month
                    && c.DocumentDate.Value.Year == DateTime.Today.Year).Distinct().ToList();

                foreach (var model in plannedinventory)
                {
                    AddInventoryDocumentLines(model);
                    model.IsPlannedInventory = false;
                    UpdateModelWithoutTransaction(model, null, null);
                }

                EndTransaction();
            }

            catch (Exception ex)
            {
                RollBackTransaction();
                throw ex;
            }
        }

        public StockDocumentLineViewModel AddInventoryDocumentLine(StockDocumentLineViewModel model, PredicateFormatViewModel predicate, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                StockDocumentLineViewModel result;
                StockDocumentLineViewModel obj = null;

                model.IdStockDocumentNavigation = FindByAsNoTracking(x => x.Id == model.IdStockDocument).FirstOrDefault();
                obj = _serviceStockDocumentLine.FindModelsByNoTracked(c => c.Id == model.Id
                && c.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                && c.IdStockDocumentNavigation.IdWarehouseSource == model.IdStockDocumentNavigation.IdWarehouseSource
                && c.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional,
                y => y.IdStockDocumentNavigation.StockDocumentLine).FirstOrDefault();

                if (obj != null)
                {
                    throw new CustomException(CustomStatusCode.AddExistingInventoryLine);
                }

                obj.ForecastQuantity = model.ForecastQuantity;
                _serviceStockDocumentLine.AddModel(obj, entityAxisValuesModelList, userMail);

                result = _serviceStockDocumentLine.FindModelsByNoTracked(c => c.Id == obj.Id,
                    y => y.IdStockDocumentNavigation.StockDocumentLine).FirstOrDefault();
                return result;

            }
            catch (Exception e)
            {
                // thorw the original exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        public StockDocumentLineViewModel UpdateInventoryDocumentLine(StockDocumentLineViewModel model, PredicateFormatViewModel predicate, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                IQueryable<StockDocument> doc = _repoEntityStockDocument.QuerableGetAll().Include(p => p.StockDocumentLine).Include(z => z.IdInputUser1Navigation)
                    .Include(e => e.IdInputUser2Navigation).Where(p => p.Id == model.IdStockDocument);
                if (!doc.Any())
                {
                    throw new CustomException(CustomStatusCode.CantUpdateDeletedInventory);
                }
                if (doc.Any() && doc.FirstOrDefault().IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    throw new CustomException(CustomStatusCode.CantUpdateValidInventory);
                }
                Item item = _entityRepoItem.GetSingleWithRelationsNotTracked(x => x.Id == model.IdItem, y => y.IdUnitStockNavigation);
                string[] nombre1;
                if (model.ForecastQuantity > Int64.MaxValue)
                {
                    System.Numerics.BigInteger number = (System.Numerics.BigInteger)model.ForecastQuantity;
                    nombre1 = number.ToString().Split(',');
                }
                else
                {
                    nombre1 = model.ForecastQuantity.ToString().Split(',');
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
                if (length1 > item.IdUnitStockNavigation.DigitsAfterComma)
                {
                    throw new CustomException(CustomStatusCode.WrongQty);
                }
                if (doc.FirstOrDefault().IdInputUser2 != null)
                {
                    string[] nombre2 = model.ForecastQuantity2.ToString().Split(',');
                    int length2;
                    if (nombre2.Length == 2)
                    {
                        length2 = nombre2[1].Length;
                    }
                    else
                    {
                        length2 = 0;
                    }
                    if (length2 > item.IdUnitStockNavigation.DigitsAfterComma)
                    {
                        throw new CustomException(CustomStatusCode.WrongQty);
                    }
                }
                if (doc.First().IdInputUser1Navigation.Email.ToUpper().Equals(userMail.ToUpper()))
                {
                    _entityStockDocumentLineRepo.QuerableGetAll().Where(p => p.Id == model.Id).UpdateFromQuery(x => new StockDocumentLine { ForecastQuantity = model.ForecastQuantity });
                }
                else
                {
                    _entityStockDocumentLineRepo.QuerableGetAll().Where(p => p.Id == model.Id).UpdateFromQuery(x => new StockDocumentLine { ForecastQuantity2 = model.ForecastQuantity2 });
                }
                StockDocumentLineViewModel result = _serviceStockDocumentLine.FindModelsByNoTracked(c => c.Id == model.Id).FirstOrDefault();
                return result;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="stockDocumentViewModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object ValidateInventoryDocument(int id, string userMail)
        {
            try
            {
                BeginTransaction();

                CheckValidity(id);
                //CheckAllPreviousInventoryAreValidated(stockDocumentViewModel);

                // Change status of stock document to Valide
                _entityRepo.GetAllAsNoTracking().Where(p => p.Id == id).UpdateFromQuery(p => new StockDocument
                {
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Valid,
                    ValidationDate = DateTime.Now
                });

                StockDocument stockDocument = _entityRepo.GetAllAsNoTracking().FirstOrDefault(p => p.Id == id);
                List<StockDocumentLine> stockDocumentLinesToUpdate = _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdStockDocument == id
                 && x.ForecastQuantity != x.ActualQuantity).Distinct().ToList();
                List<StockDocumentLine> stockDocumentLines = _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdStockDocument == id).Include(y => y.IdItemNavigation).Distinct().ToList();
                if (stockDocumentLines.Where(x => x.IdItemNavigation.IdUnitStock == null).Any())
                {
                    throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                }
                List<int> IdItems = stockDocumentLinesToUpdate.Select(y => y.IdItem).Distinct().ToList();
                List<ItemWarehouse> listItemWarehouse = _repoEntityItemWarehouse.GetAllAsNoTracking().Where(p => IdItems.Contains(p.IdItem)).ToList();
                List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();

                List<StockMovement> stockMovementToAdd = new List<StockMovement>();
                stockDocumentLinesToUpdate.ForEach(line =>
                {
                    int idWarehouse = (stockDocument.IdWarehouseSource.HasValue) ? stockDocument.IdWarehouseSource.Value : line.IdWarehouse.Value;
                    double qty = Math.Abs((line.ActualQuantity ?? 0) - (line.ForecastQuantity ?? 0));
                    ItemWarehouse itemWarehouse = listItemWarehouse.Single(p => p.IdItem == line.IdItem && p.IdWarehouse == idWarehouse);

                    if (line.ActualQuantity > line.ForecastQuantity)
                    {
                        stockMovementToAdd.Add(new StockMovement
                        {
                            Id = 0,
                            IdItem = line.IdItem,
                            IdWarehouse = idWarehouse,
                            MovementQty = qty,
                            Operation = OperationEnumerator.Output,
                            IdStockDocumentLine = line.Id,
                            CreationDate = DateTime.Now,
                            Status = DocumentEnumerator.Real
                        });
                        itemWarehouse.AvailableQuantity -= qty;
                    }
                    else
                    {
                        stockMovementToAdd.Add(new StockMovement
                        {
                            Id = 0,
                            IdItem = line.IdItem,
                            IdWarehouse = idWarehouse,
                            MovementQty = qty,
                            Operation = OperationEnumerator.Input,
                            IdStockDocumentLine = line.Id,
                            CreationDate = DateTime.Now,
                            Status = DocumentEnumerator.Real
                        });
                        itemWarehouse.AvailableQuantity += qty;
                    }
                    itemWarehouseToUpdate.Add(itemWarehouse);
                });

                _entityStockMovementRepo.BulkAdd(stockMovementToAdd);
                _repoEntityItemWarehouse.BulkUpdate(itemWarehouseToUpdate);
                UpdateStatusInventoryItem(stockDocumentLines.Select(x => x.IdItem).Distinct().ToList(), false);
                _unitOfWork.Commit();

                EndTransaction();
                return new CreatedDataViewModel { Id = stockDocument.Id, Code = stockDocument.Code };
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw e;
            }
        }

        private void CheckValidity(int idInventoryDocument)
        {
            List<StockDocument> tt = _repoEntityStockDocument.GetAllWithConditions(x => x.Id == idInventoryDocument).ToList();
            if (tt.Any())
            {
                if (tt[0].IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    throw new CustomException(CustomStatusCode.ThisInventoryIsValidated);
                }
                if (tt[0].IdInputUser2 == null)
                {
                    CheckAllQuantityAreFiled(idInventoryDocument);
                }
                else
                {
                    CheckDoubleInputValid(idInventoryDocument);
                }
            }
            else
            {
                throw new CustomException(CustomStatusCode.ThisInventoryIsDeleted);
            }
        }

        private void CheckDoubleInputValid(int IdStockDocument)
        {
            int countofelements = _entityStockDocumentLineRepo.GetAllAsNoTracking()
                    .Where(x => x.IdStockDocument == IdStockDocument
                    && (x.ForecastQuantity == null)).Count();
            int countofelementsQty = _entityStockDocumentLineRepo.GetAllAsNoTracking()
                    .Where(x => x.IdStockDocument == IdStockDocument
                    && (x.ForecastQuantity2 != x.ForecastQuantity)).Count();
            if (countofelements > 0)
            {
                var list = _serviceStockDocumentLine.GetAllModelsQueryable(x => x.IdStockDocument == IdStockDocument
                && (x.ForecastQuantity == null || x.ForecastQuantity2 != x.ForecastQuantity), y => y.IdItemNavigation).Take(10).ToList();
                StringBuilder codeItem = new StringBuilder();
                foreach (var element in list)
                {
                    codeItem.Append(element.IdItemNavigation.Code);
                    codeItem.Append(" ");
                    codeItem.Append(element.IdItemNavigation.Description);
                    codeItem.Append(", ");
                }
                var paramters = new Dictionary<string, dynamic>
                {
                    ["Code"] = codeItem.ToString().Substring(0, codeItem.ToString().LastIndexOf(","))
                };
                throw new CustomException(CustomStatusCode.ItemNotFiled, paramters);
            }
            if (countofelementsQty > 0)
            {
                var list = _serviceStockDocumentLine.GetAllModelsQueryable(x => x.IdStockDocument == IdStockDocument
                && (x.ForecastQuantity2 != x.ForecastQuantity), y => y.IdItemNavigation).Take(10).ToList();
                StringBuilder codeItem = new StringBuilder();
                foreach (var element in list)
                {
                    codeItem.Append(element.IdItemNavigation.Code);
                    codeItem.Append(" ");
                    codeItem.Append(element.IdItemNavigation.Description);
                    codeItem.Append(", ");
                }
                var paramters = new Dictionary<string, dynamic>
                {
                    ["Code"] = codeItem.ToString().Substring(0, codeItem.ToString().LastIndexOf(","))
                };
                throw new CustomException(CustomStatusCode.CheckItemsQty, paramters);
            }
        }

        private void CheckAllQuantityAreFiled(int id)
        {
            int countofelements = _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdStockDocument == id && x.ForecastQuantity == null).Count();
            if (countofelements > 0)
            {
                var list = _serviceStockDocumentLine.GetAllModelsQueryable(x => x.IdStockDocument == id
                && x.ForecastQuantity == null, y => y.IdItemNavigation).Take(10).ToList();
                StringBuilder codeItem = new StringBuilder();
                foreach (var element in list)
                {
                    codeItem.Append(element.IdItemNavigation.Code);
                    codeItem.Append(" ");
                    codeItem.Append(element.IdItemNavigation.Description);
                    codeItem.Append(", ");
                }
                var paramters = new Dictionary<string, dynamic>
                {
                    ["Code"] = codeItem.ToString().Substring(0, codeItem.ToString().LastIndexOf(","))
                };
                throw new CustomException(CustomStatusCode.ItemNotFiled, paramters);
            }
        }

        private void CheckAllPreviousInventoryAreValidated(StockDocumentViewModel stockDocumentViewModel)
        {
            var countofelements = GetAllModelsQueryable(x => x.IdWarehouseSource == stockDocumentViewModel.IdWarehouseSource
            && x.IdWarehouseDestination == stockDocumentViewModel.IdWarehouseSource
            && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
            && x.TypeStockDocument == DocumentEnumerator.InventoryMovement
            && x.DocumentDate.Value <= stockDocumentViewModel.DocumentDate.Value);
            if (countofelements.Count() > 0 && countofelements.Any(c => c.Id != stockDocumentViewModel.Id))
            {
                var list = countofelements.Where(x => x.DocumentDate.Value.Day <= stockDocumentViewModel.DocumentDate.Value.Day
                && x.DocumentDate.Value.Month <= stockDocumentViewModel.DocumentDate.Value.Month
                && x.DocumentDate.Value.Year <= stockDocumentViewModel.DocumentDate.Value.Year).Take(10).ToList();
                StringBuilder codeItem = new StringBuilder();
                foreach (var element in list)
                {
                    codeItem.Append(element.Code);
                    codeItem.Append(" ");
                    codeItem.Append(element.DocumentDate);
                    codeItem.Append(", ");
                }
                var paramters = new Dictionary<string, dynamic>
                {
                    ["Code"] = codeItem.ToString().Substring(0, codeItem.ToString().LastIndexOf(","))
                };


                throw new CustomException(CustomStatusCode.ExistPendingInventoryDocument, paramters);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="stockDocumentViewModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object ValidateDocument(int id, string userMail)
        {
            try
            {
                BeginTransaction();
                StockDocument stockDocument = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == id, x => x.StockDocumentLine);
                List<int> ids = stockDocument.StockDocumentLine.Select(x => x.IdItem).ToList();
                IQueryable<Item> itemsWithoutUnit = _entityRepoItem.GetAllWithConditionsRelationsQueryableAsNoTracking(x => ids.Contains(x.Id) && x.IdUnitStock == null);
                if (itemsWithoutUnit.Any())
                {
                    throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                }

                StockDocumentViewModel stockDocumentViewModel = _builder.BuildEntity(stockDocument);
                //// Create Stock mvt ==> Status P
                CreateStockMovement(stockDocumentViewModel, stockDocumentViewModel.StockDocumentLine.ToList());
                if (stockDocumentViewModel != null && stockDocumentViewModel.TypeStockDocument != DocumentEnumerator.TransferShelfStorage)
                {
                    // Create or update Item warehouse (Item + warhouse source) and (item + warehouse destination)
                    CreateOrUpdateListOfItemWarehouse(stockDocumentViewModel);
                }
                // Change status of stock document to Valide
                stockDocument.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                // Set date of validation
                stockDocument.ValidationDate = DateTime.Now;
                _entityRepo.Update(stockDocument);
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel() { Id = stockDocument.Id, Code = stockDocument.Code };
            }

            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw e;
            }
        }

        public object ValidatestorageMovementDocument(int id, string userMail)
        {
            try
            {
                BeginTransaction();
                StockDocument stockDocument = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == id, x => x.StockDocumentLine);
                // Change status of stock document to Valide
                int idWarehouse = stockDocument.IdWarehouseSource.Value;
                int IdStorage = stockDocument.IdStorageDestination.Value;
                ShelfStorageViewModel storageDestination = _serviceStorage.GetModelById(IdStorage);
                List<int> ItemsIds = stockDocument.StockDocumentLine.Select(x => x.IdItem).ToList();
                List<ItemWarehouseViewModel> updatedItemWarehouselist = new List<ItemWarehouseViewModel>();
                updatedItemWarehouselist = _serviceItemWarehouse.GetAllModelsQueryableWithRelation(x => ItemsIds.Any(y => y == x.IdItem) && x.IdWarehouse == idWarehouse).AsNoTracking().ToList();


                updatedItemWarehouselist.ForEach(itemWarehouse =>
                {
                    // update shelf and storage
                    itemWarehouse.IdStorage = IdStorage;
                    itemWarehouse.IdShelf = storageDestination.IdShelf;
                });

                _serviceItemWarehouse.BulkUpdateModelWithoutTransaction(updatedItemWarehouselist, userMail);
                // validate document
                stockDocument.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                // Set date of validation
                stockDocument.ValidationDate = DateTime.Now;
                _entityRepo.Update(stockDocument);

                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel() { Id = stockDocument.Id, Code = stockDocument.Code };
            }

            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw e;
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="stockDocumentViewModel"></param>
        /// <param name="operation"></param>
        public void ChangeStatusOfStockMovement(StockDocumentViewModel stockDocumentViewModel, string operation)
        {
            foreach (StockDocumentLineViewModel stockDocumentLine in stockDocumentViewModel.StockDocumentLine)
            {
                List<StockMovementViewModel> movementsViewModel = _serviceStockMovement.
                    FindModelsByNoTracked(mvt => mvt.IdStockDocumentLine == stockDocumentLine.Id).ToList();
                movementsViewModel.ForEach(mvt =>
                {
                    if (mvt.Operation.Equals(operation))
                    {
                        ItemWarehouse itemwarehouse =
                        _repoEntityItemWarehouse.
                        FindByAsNoTracking(x => x.IdItem == mvt.IdItem && x.IdWarehouse == mvt.IdWarehouse).FirstOrDefault();
                        if (itemwarehouse == null)
                        {
                            throw new CustomException(CustomStatusCode.ITEM_NOT_EXIST_IN_WARHOUSE);
                        }
                        if (operation == OperationEnumerator.Output)
                        {
                            itemwarehouse.ReservedQuantity -= mvt.MovementQty;
                        }
                        else
                        {
                            itemwarehouse.OrderedQuantity -= mvt.MovementQty;
                        }
                        _repoEntityItemWarehouse.Update(itemwarehouse);
                        _unitOfWork.Commit();
                        mvt.Status = DocumentEnumerator.Real;
                        _serviceItemWarehouse.UpdateAvailebelQuantity(mvt);
                        _serviceStockMovement.UpdateModelWithoutTransaction(mvt, null, null);

                    }
                });
            }
            var context = _unitOfWork.GetContext();
            var attacheddocument = context.ChangeTracker.Entries<StockDocumentLine>().FirstOrDefault
                (e => e.Entity.IdStockDocument == stockDocumentViewModel.Id);
            if (attacheddocument != null)
            {
                context.Entry(attacheddocument.Entity).State = EntityState.Detached;
            }
        }

        /// <summary>
        /// Gets the model with relations.
        /// The method receive a generic predicate
        /// and return the model with relations according to the predicate
        /// and the where condition included on the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>TModel.</returns>
        public override StockDocumentViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel != null && predicateModel.Relation != null && predicateModel.Relation.Any())
            {
                predicateModel.Relation.Add(new RelationViewModel { Prop = "IdStorageSourceNavigation" });
                predicateModel.Relation.Add(new RelationViewModel { Prop = "IdStorageDestinationNavigation" });
            }
            StockDocumentViewModel stockDocumentViewModel = base.GetModelWithRelations(predicateModel);

            if (stockDocumentViewModel.StockDocumentLine != null)
            {
                stockDocumentViewModel.StockDocumentLine.ToList().ForEach(x => x.IdItemNavigation = _serviceItem.GetModelById(x.IdItem));
            }

            return stockDocumentViewModel;
        }

        public double GetItemQtyInWarehouse(int idItem, int idWarehouse, int idStockDocumentLine)
        {
            return _serviceItemWarehouse.GetItemQtyInWarehouse(idItem, idWarehouse);
        }


        public StockDocumentViewModel SavePlannedInventoryDocument(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                if (FindByAsNoTracking(c => c.TypeStockDocument == DocumentEnumerator.InventoryMovement
                && c.IdWarehouseSource == stockDocumentViewModel.IdWarehouseSource
                && c.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).Any())
                {
                    throw new CustomException(CustomStatusCode.AddExistingInventory);
                }

                stockDocumentViewModel.TypeStockDocument = DocumentEnumerator.InventoryMovement;
                stockDocumentViewModel.IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional;
                stockDocumentViewModel.IsPlannedInventory = true;
                stockDocumentViewModel.Id = 0;
                var addresult = (CreatedDataViewModel)AddModelWithoutTransaction(stockDocumentViewModel, entityAxisValuesModelList, userMail, "TypeStockDocument");
                stockDocumentViewModel.Code = addresult.Code;
                stockDocumentViewModel.Id = addresult.Id;
                var result = FindByAsNoTracking(c => c.Id == addresult.Id).FirstOrDefault();
                stockDocumentViewModel = result;
                EndTransaction();
                return stockDocumentViewModel;



            }
            catch (CustomException e)
            {
                RollBackTransaction();
                throw e;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                // thorw the original exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        /// <summary>
        /// Add stock document
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public StockDocumentViewModel AddModelInRealTime(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList,
            string userMail, string property = null)
        {
            try
            {
                BeginTransaction();
                StockDocumentViewModel createdData = null;
                CreatedDataViewModel addedEntity = null;
                stockDocumentViewModel.StockDocumentLine = null;
                if (stockDocumentViewModel.Id == 0)
                {
                    // Adding system Time to stock document creation date
                    DateTime? dateTimeNow = DateTime.Now;
                    stockDocumentViewModel.DocumentDate = new DateTime(stockDocumentViewModel.DocumentDate.Value.Year, stockDocumentViewModel.DocumentDate.Value.Month
                        , stockDocumentViewModel.DocumentDate.Value.Day, dateTimeNow.Value.Hour, dateTimeNow.Value.Minute, dateTimeNow.Value.Second);
                    // Add stockDocument
                    addedEntity = (CreatedDataViewModel)AddModelWithoutTransaction(stockDocumentViewModel, entityAxisValuesModelList, userMail, "TypeStockDocument");
                    createdData = GetModelAsNoTracked(x => x.Id == addedEntity.Id, x => x.StockDocumentLine);
                }
                else
                {
                    UpdateModelWithoutTransaction(stockDocumentViewModel, entityAxisValuesModelList, userMail);
                    createdData = GetModelAsNoTracked(x => x.Id == stockDocumentViewModel.Id, x => x.StockDocumentLine);
                }
                EndTransaction();
                createdData.EntityName = createdData.EntityName + "_" + createdData.TypeStockDocument;
                return createdData;
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw;
            }
        }


        /// <summary>
        /// Add stock document
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public object AddLineInRealTime(StockDocumentLineViewModel stockDocumentLineViewModel)
        {
            try
            {


                StockDocumentLineViewModel stockDocumentLineWithOldValue = null;
                List<StockDocumentLineViewModel> listStockLine = new List<StockDocumentLineViewModel>();
                BeginTransaction();
                if (stockDocumentLineViewModel.IdStockDocument != 0)
                {


                    StockDocument stockDocument = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == stockDocumentLineViewModel.IdStockDocument, x => x.StockDocumentLine).FirstOrDefault();
                    // Verification quantity
                    ItemWarehouse itemWarehouseSource = _repoEntityItemWarehouse.GetSingleWithRelationsNotTracked(x => x.IdItem == stockDocumentLineViewModel.IdItem && x.IdWarehouse == stockDocument.IdWarehouseSource,
                        y => y.IdItemNavigation, Z => Z.IdItemNavigation.IdNatureNavigation);
                    if (itemWarehouseSource.IdItemNavigation.IdNatureNavigation.IsStockManaged && ((itemWarehouseSource.IdItemNavigation.IsForSales == true && itemWarehouseSource.IdItemNavigation.IdUnitSales == null) ||
                        (itemWarehouseSource.IdItemNavigation.IsForPurchase == true && itemWarehouseSource.IdItemNavigation.IdUnitStock == null)))
                    {
                        throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
                    }
                    Item item = _entityRepoItem.GetSingleWithRelationsNotTracked(x => x.Id == stockDocumentLineViewModel.IdItem, y => y.IdUnitStockNavigation);
                    string[] nombre1;
                    if (stockDocumentLineViewModel.ActualQuantity > Int64.MaxValue)
                    {
                        System.Numerics.BigInteger number = (System.Numerics.BigInteger)stockDocumentLineViewModel.ActualQuantity;
                        nombre1 = number.ToString().Split(',');
                    }
                    else
                    {
                        nombre1 = stockDocumentLineViewModel.ActualQuantity.ToString().Split(',');
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
                    if (length1 > item.IdUnitStockNavigation.DigitsAfterComma)
                    {
                        throw new CustomException(CustomStatusCode.WrongQty);
                    }

                    IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == stockDocumentLineViewModel.IdItem &&
                     x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                     && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                     && (x.IdStockDocumentNavigation.IdTiers != null || (x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseDestination ||
                     x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseSource)));
                    if (inventaireList.Any())
                    {
                        throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                    }
                    // Create new Line
                    if (stockDocumentLineViewModel.Id == 0)
                    {
                        // Check unicity
                        if (stockDocument != null && stockDocument.StockDocumentLine != null && stockDocument.StockDocumentLine.Any())
                        {
                            StockDocumentLine stockDocumentLineOfCurrentItem = stockDocument.StockDocumentLine.Where(y => y.IdItem == stockDocumentLineViewModel.IdItem).FirstOrDefault();
                            if (stockDocumentLineOfCurrentItem != null)
                            {
                                throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                            }
                        }
                        if (itemWarehouseSource != null && stockDocumentLineViewModel.ActualQuantity > (itemWarehouseSource.AvailableQuantity - itemWarehouseSource.ReservedQuantity))
                        {
                            throw new CustomException(CustomStatusCode.InsufficientQuantity);
                        }

                        // Add line
                        CreatedDataViewModel line = (CreatedDataViewModel)_serviceStockDocumentLine.AddModelWithoutTransaction(stockDocumentLineViewModel, null, null);
                        stockDocumentLineViewModel.Id = line.Id;
                        // Recuperate stock document

                    }
                    // Update line
                    else
                    {
                        stockDocumentLineWithOldValue = _serviceStockDocumentLine.GetModelAsNoTracked(x => x.Id == stockDocumentLineViewModel.Id);

                        if (itemWarehouseSource != null && stockDocumentLineViewModel.ActualQuantity > (itemWarehouseSource.AvailableQuantity - itemWarehouseSource.ReservedQuantity + stockDocumentLineWithOldValue.ActualQuantity))
                        {
                            throw new CustomException(CustomStatusCode.InsufficientQuantity);
                        }

                        // Update line
                        _serviceStockDocumentLine.UpdateModelWithoutTransaction(stockDocumentLineViewModel, null, null);
                    }
                }
                EndTransaction();
                //return listStockLine;
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw;
            }
            var entity = _entityRepoItem.GetSingleNotTracked(x => x.Id == stockDocumentLineViewModel.IdItem);
            return new CreatedDataViewModel { Id = entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        private void CreateOrUpdateItemWarehouse(StockDocumentViewModel stockDocumentViewModel, StockDocumentLineViewModel stockDocumentLineViewModel, StockDocumentLineViewModel stockDocumentLineWithOldValue)
        {
            _serviceItem.RestorItemListforDropDown();
            // Recuperate ItemWarehouse (Item + warehouse source)
            ItemWarehouse itemWarehouseSource = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == stockDocumentLineViewModel.IdItem && x.IdWarehouse == stockDocumentViewModel.IdWarehouseSource).FirstOrDefault();
            if (itemWarehouseSource == null)
            {
                // Prepare Itemwarehouse  to add
                ItemWarehouse newItemWarehouse = new ItemWarehouse
                {
                    IdItem = stockDocumentLineViewModel.IdItem,
                    IdWarehouse = (int)stockDocumentViewModel.IdWarehouseSource,
                    ReservedQuantity = stockDocumentLineViewModel.ActualQuantity.Value,
                    MinQuantity = 10,
                    MaxQuantity = 10000
                };
                _repoEntityItemWarehouse.Add(newItemWarehouse);
            }
            else
            {
                itemWarehouseSource.ReservedQuantity += stockDocumentLineViewModel.ActualQuantity.Value - (stockDocumentLineWithOldValue != null ? stockDocumentLineWithOldValue.ActualQuantity.Value : 0);
                _repoEntityItemWarehouse.Update(itemWarehouseSource);
            }

            // Recuperate ItemWarehouse (Item + warehouse destination)
            ItemWarehouse itemWarehouseDestination = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == stockDocumentLineViewModel.IdItem && x.IdWarehouse == stockDocumentViewModel.IdWarehouseDestination).FirstOrDefault();
            if (itemWarehouseDestination == null)
            {
                // Prepare Itemwarehouse  to add
                ItemWarehouse newItemWarehouse = new ItemWarehouse
                {
                    IdItem = stockDocumentLineViewModel.IdItem,
                    IdWarehouse = (int)stockDocumentViewModel.IdWarehouseDestination,
                    OrderedQuantity = stockDocumentLineViewModel.ActualQuantity.Value,
                    MinQuantity = 10,
                    MaxQuantity = 10000
                };
                _repoEntityItemWarehouse.Add(newItemWarehouse);
            }
            else
            {
                itemWarehouseDestination.OrderedQuantity += stockDocumentLineViewModel.ActualQuantity.Value - (stockDocumentLineWithOldValue != null ? stockDocumentLineWithOldValue.ActualQuantity.Value : 0);
                _repoEntityItemWarehouse.Update(itemWarehouseDestination);
            }
            _unitOfWork.Commit();
        }
        private void CreateOrUpdateListOfItemWarehouse(StockDocumentViewModel stockDocumentViewModel)
        {
            List<StockDocumentLineViewModel> stockDocumentLineViewModel = stockDocumentViewModel.StockDocumentLine.ToList();
            if (stockDocumentLineViewModel != null && stockDocumentLineViewModel.Any())
            {
                //remove cash
                _serviceItem.RestorItemListforDropDown();
                // Recuperate list of ItemWarehouse (Item + warehouse source)
                List<int> idsItems = stockDocumentLineViewModel.Select(stockDocLine => stockDocLine.IdItem).ToList();
                IQueryable<ItemWarehouse> itemWarehouseSourceAndDestination = _repoEntityItemWarehouse.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) && (x.IdWarehouse == stockDocumentViewModel.IdWarehouseSource || x.IdWarehouse == stockDocumentViewModel.IdWarehouseDestination));
                List<ItemWarehouse> itemWarehouseToAdd = new List<ItemWarehouse>();
                List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();
                stockDocumentLineViewModel.ForEach(stockDocLine =>
                {
                    // Source
                    ItemWarehouse itemWarehouseSource = itemWarehouseSourceAndDestination.Where(x => x.IdItem == stockDocLine.IdItem && x.IdWarehouse == stockDocumentViewModel.IdWarehouseSource).FirstOrDefault();
                    if (itemWarehouseSource != null)
                    {
                        // Update item warehouse for currenct doc line
                        itemWarehouseSource.ReservedQuantity += stockDocLine.ActualQuantity != null ? stockDocLine.ActualQuantity.Value : 0;
                        itemWarehouseToUpdate.Add(itemWarehouseSource);
                    }
                    else
                    {
                        // Prepare Itemwarehouse  to add
                        ItemWarehouse newItemWarehouse = new ItemWarehouse
                        {
                            IdItem = stockDocLine.IdItem,
                            IdWarehouse = (int)stockDocumentViewModel.IdWarehouseSource,
                            ReservedQuantity = stockDocLine.ActualQuantity != null ? stockDocLine.ActualQuantity.Value : 0,
                            MinQuantity = 10,
                            MaxQuantity = 10000
                        };
                        itemWarehouseToAdd.Add(newItemWarehouse);
                    }

                    // Destination
                    ItemWarehouse itemWarehouseDestination = itemWarehouseSourceAndDestination.Where(x => x.IdItem == stockDocLine.IdItem && x.IdWarehouse == stockDocumentViewModel.IdWarehouseDestination).FirstOrDefault();
                    if (itemWarehouseDestination != null)
                    {
                        // Update item warehouse for currenct doc line
                        itemWarehouseDestination.OrderedQuantity += stockDocLine.ActualQuantity != null ? stockDocLine.ActualQuantity.Value : 0;
                        itemWarehouseToUpdate.Add(itemWarehouseDestination);
                    }
                    else
                    {
                        // Prepare Itemwarehouse  to add
                        ItemWarehouse newItemWarehouse = new ItemWarehouse
                        {
                            IdItem = stockDocLine.IdItem,
                            IdWarehouse = (int)stockDocumentViewModel.IdWarehouseDestination,
                            OrderedQuantity = stockDocLine.ActualQuantity != null ? stockDocLine.ActualQuantity.Value : 0,
                            MinQuantity = 10,
                            MaxQuantity = 10000
                        };
                        itemWarehouseToAdd.Add(newItemWarehouse);
                    }

                });
                if (itemWarehouseToAdd.Any())
                {
                    _repoEntityItemWarehouse.BulkAdd(itemWarehouseToAdd);
                }
                if (itemWarehouseToUpdate.Any())
                {
                    _repoEntityItemWarehouse.BulkUpdate(itemWarehouseToUpdate);
                }
                _unitOfWork.Commit();
            }
        }
        public object DeleteLineInRealTime(int id)
        {

            // Get stock movement to delete 
            List<StockMovement> movementsViewModel = _entityStockMovementRepo.GetAllAsNoTracking().Where(x => x.IdStockDocumentLine == id).ToList();
            StockDocumentLine stockDocumentLine = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == id, x => x.IdStockDocumentNavigation, x => x.IdItemNavigation).FirstOrDefault();


            StockDocument stockDocument = _entityRepo.GetAllWithConditionsRelations(x => x.Id == stockDocumentLine.IdStockDocument).FirstOrDefault();
            IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == stockDocumentLine.IdItem &&
         x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
         && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
         && (x.IdStockDocumentNavigation.IdTiers != null || (x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseDestination ||
         x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseSource)));
            if (inventaireList.Any())
            {
                throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
            }
            // delete list of stock movement => update isDelete = true
            movementsViewModel.ForEach(mvt =>
            {
                mvt.IsDeleted = true;
                mvt.DeletedToken = Guid.NewGuid().ToString();
            });
            _entityStockMovementRepo.BulkUpdate(movementsViewModel);


            // Delete StockDocumentLine
            // Get ItemWarehouse for warehouse source
            ItemWarehouse itemWarehouseSource = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == stockDocumentLine.IdItem && x.IdWarehouse == stockDocumentLine.IdStockDocumentNavigation.IdWarehouseSource).FirstOrDefault();
            // Get ItemWarehouse for warehouse destination
            ItemWarehouse itemWarehouseDestination = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => x.IdItem == stockDocumentLine.IdItem && x.IdWarehouse == stockDocumentLine.IdStockDocumentNavigation.IdWarehouseDestination).FirstOrDefault();
            itemWarehouseSource.ReservedQuantity -= stockDocumentLine.ActualQuantity.Value;
            IList<ItemWarehouse> itemWarehouses = new List<ItemWarehouse>() { itemWarehouseSource };
            if (itemWarehouseDestination != null)
            {
                itemWarehouseDestination.OrderedQuantity -= stockDocumentLine.ActualQuantity.Value;
                itemWarehouses.Add(itemWarehouseDestination);
            }

            if (stockDocumentLine != null)
            {
                stockDocumentLine.IsDeleted = true;
                stockDocumentLine.DeletedToken = Guid.NewGuid().ToString();
                stockDocumentLine.IdStockDocumentNavigation = null;
                _entityStockDocumentLineRepo.Update(stockDocumentLine);
            }
            _repoEntityItemWarehouse.BulkUpdate(itemWarehouses);
            // Commit changes
            _unitOfWork.Commit();

            return new CreatedDataViewModel { Id = stockDocumentLine.Id, EntityName = stockDocumentLine.IdItemNavigation.GetType().Name.ToUpper() };
        }

        public void DeleteLineOfDoc(int idDoc)
        {
            List<StockDocumentLine> stockDocumentLines = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdStockDocument == idDoc, x => x.IdStockDocumentNavigation, x => x.IdItemNavigation).ToList();

            List<int> ids = stockDocumentLines.Select(x => x.Id).ToList();
            // Get stock movement to delete 
            List<StockMovement> movementsViewModel = _entityStockMovementRepo.GetAllAsNoTracking().Where(x => ids.Contains((int)x.IdStockDocumentLine)).ToList();

            if (stockDocumentLines != null && stockDocumentLines.Any())
            {

                StockDocument stockDocument = stockDocumentLines.FirstOrDefault().IdStockDocumentNavigation;
                List<int> idsItems = stockDocumentLines.Select(x => x.IdItem).ToList();
                int idWarehouseSource = (int)stockDocument.IdWarehouseSource;
                List<ItemWarehouse> itemsWarehouseDestination = new List<ItemWarehouse>();
                if (stockDocument.IdWarehouseDestination != null)
                {
                    int idWarehouseDestination = (int)stockDocument.IdWarehouseDestination;
                    // Get ItemWarehouse for warehouse destination
                    itemsWarehouseDestination = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => idsItems.Contains(x.IdItem) && x.IdWarehouse == idWarehouseDestination).ToList();
                }

                IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => idsItems.Contains(x.IdItem) &&
        x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
        && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
        && (x.IdStockDocumentNavigation.IdTiers != null || (x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseDestination ||
        x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseSource)));
                if (inventaireList.Any())
                {
                    throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                }
                // delete list of stock movement => update isDelete = true
                movementsViewModel.ForEach(mvt =>
                {
                    mvt.IsDeleted = true;
                    mvt.DeletedToken = Guid.NewGuid().ToString();
                });
                _entityStockMovementRepo.BulkUpdate(movementsViewModel);

                // Delete StockDocumentLine
                // Get ItemWarehouse for warehouse source
                List<ItemWarehouse> itemsWarehouseSource = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(x => idsItems.Contains(x.IdItem) && x.IdWarehouse == idWarehouseSource).ToList();


                stockDocumentLines.ForEach(stk =>
                {
                    // Get ItemWarehouse for warehouse source
                    ItemWarehouse itemWarehouseSource = itemsWarehouseSource.Where(y => y.IdItem == stk.IdItem).FirstOrDefault();
                    // Get ItemWarehouse for warehouse destination
                    ItemWarehouse itemWarehouseDestination = null;
                    if (itemsWarehouseDestination != null && itemsWarehouseDestination.Any())
                    {
                        itemsWarehouseDestination.Where(y => y.IdItem == stk.IdItem).FirstOrDefault();
                    }
                    itemWarehouseSource.ReservedQuantity -= stk.ActualQuantity.Value;

                    //IList<ItemWarehouse> itemWarehouses = new List<ItemWarehouse>() { itemWarehouseSource };
                    if (itemWarehouseDestination != null)
                    {
                        itemWarehouseDestination.OrderedQuantity -= stk.ActualQuantity.Value;

                    }


                    stk.IsDeleted = true;
                    stk.DeletedToken = Guid.NewGuid().ToString();
                    stk.IdStockDocumentNavigation = null;

                });
                _entityStockDocumentLineRepo.BulkUpdate(stockDocumentLines);
                _repoEntityItemWarehouse.BulkUpdate(itemsWarehouseSource);
                _repoEntityItemWarehouse.BulkUpdate(itemsWarehouseDestination);
                // Commit changes
                _unitOfWork.Commit();
            }






        }

        public void CalculateAvailableQte(List<StockDocumentLineViewModel> StockDocumentLine, int idWarehouseSource)
        {
            StockDocumentLine.ForEach(x =>
            {
                x.AvailableQuantity = 0;
                if (x.IdItemNavigation != null && x.IdItemNavigation.ItemWarehouse != null && x.IdItemNavigation.ItemWarehouse.Any())
                {
                    ItemWarehouseViewModel itemWarehouse = x.IdItemNavigation.ItemWarehouse.Where(y => y.IdWarehouse == idWarehouseSource).FirstOrDefault();
                    if (itemWarehouse != null)
                    {
                        x.AvailableQuantity = itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity;
                    }
                }
            });
        }

        public List<StockDocumentLineViewModel> GetStockDocumentWithStockDocumentLine(DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel, out int total)
        {
            List<StockDocumentLineViewModel> lines = new List<StockDocumentLineViewModel>();
            // Get StockDocument
            StockDocumentViewModel stockDoc = GetModelWithRelationsAsNoTracked(x => x.Id == documentLinesWithPagingViewModel.IdDocument, r => r.IdStorageDestinationNavigation);
            int shelvesIds = 0;

            if (stockDoc != null && stockDoc.IdStorageDestinationNavigation != null && stockDoc.IdStorageDestinationNavigation.IdShelf != null)
            {
                shelvesIds = stockDoc.IdStorageDestinationNavigation.IdShelf.Value;
            }

            var o = _serviceShelf.GetModelsWithConditionsRelations(x => x.Id == shelvesIds);

            if (stockDoc != null && stockDoc.IdStorageDestinationNavigation != null && stockDoc.IdStorageDestinationNavigation.IdShelf != null)
            {
                stockDoc.shelfDestinationLabel = o.Where(x => x.Id == stockDoc.IdStorageDestinationNavigation.IdShelf).FirstOrDefault().Label + (stockDoc.IdStorageDestinationNavigation.Label);
            }


            List<StockDocumentLineViewModel> stockDocLine = _serviceStockDocumentLine.FindModelsByNoTracked(x => x.IdStockDocument == documentLinesWithPagingViewModel.IdDocument,
                            x => x.IdItemNavigation, x => x.IdItemNavigation.ItemWarehouse, x => x.IdItemNavigation.IdUnitStockNavigation).ToList();
            total = stockDocLine.Count();
            List<StockDocumentLineViewModel> stockDocumentLinesModelList = new List<StockDocumentLineViewModel>();
            if (documentLinesWithPagingViewModel.Skip != 0 && documentLinesWithPagingViewModel.pageSize != 0)
            {
                stockDocumentLinesModelList = stockDocLine.Skip(documentLinesWithPagingViewModel.Skip).Take(documentLinesWithPagingViewModel.pageSize).ToList();
            }
            else
            {
                stockDocumentLinesModelList = stockDocLine.ToList();
            }

            if (stockDocumentLinesModelList != null && stockDocumentLinesModelList.Any())
            {
                CalculateAvailableQte(stockDocumentLinesModelList, (int)stockDoc.IdWarehouseSource);
                stockDocumentLinesModelList.ForEach(x => x.IdStockDocumentNavigation = stockDoc);
            }
            return stockDocumentLinesModelList;
        }

        public object ValidateStockDocumentById(int stockDocumentId, string userMail)
        {
            StockDocumentViewModel stockDoc = GetModelAsNoTracked(x => x.Id == stockDocumentId, x => x.StockDocumentLine);
            return ValidateDocument(stockDoc.Id, userMail);
        }









        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public InventoryDocumentReportViewModel GetInventoryDocumentInformations(InventoryDocumentReportQueryViewModel DailySalesQuery)
        {
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var city = _repoEntityCity.GetSingle(x => x.Id == address.IdCity);
            var country = _repoEntityCountry.GetSingle(x => x.Id == address.IdCountry);
            var clientname = _repoEntityTiers.FindSingleBy(x => x.Id == DailySalesQuery.IdTiers);

            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            var queryrequest = _repoEntityStockDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == DailySalesQuery.IdInventory, x => x.IdTiersNavigation);
            if (DailySalesQuery.DocumentDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Value.Date, DailySalesQuery.DocumentDate.Value) >= 0);
            }


            //var allSaleDocument = FilterDocByType(DailySalesQuery, queryrequest)?.ToList();
            //var allDocTypeTitle = GetDocByTypeTitle(DailySalesQuery)?.ToList();
            double? blcount = 0;
            double? alltotalttc = 0;
            double? alltotalht = 0;
            string clientName = string.Empty;
            //string typeDpcs = string.Empty;
            string typeDpcsTitle = string.Empty;
            //if (allSaleDocument != null && allSaleDocument.Any())
            //{
            //    //blcount = allSaleDocument.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery);
            //    blcount = allSaleDocument.Count();
            //    alltotalttc = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum();
            //    alltotalht = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum();
            //    clientName = DailySalesQuery.IdTiers != -1 ? allSaleDocument.First().IdTiersNavigation.Name : "Tous les clients";
            //    //typeDpcs = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "[-1]" ? allSaleDocument.Select(f => f.DocumentTypeCode.ToString()).Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            //    typeDpcsTitle = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "[-1]" ? allDocTypeTitle.Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            //}

            return new InventoryDocumentReportViewModel
            {
                ClientName = DailySalesQuery.IdTiers < 0 ? "" : clientname.Name,
                DocumentDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                PrintedDate = DateTime.Now,
                FromDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                ToDate = DailySalesQuery.EndDate != null ? DailySalesQuery.EndDate.Value.Date : (DateTime?)null,
                WarehouseCode = default,
                WarehouseName = default,
                Name = company.Name,
                Email = company.Email,
                Adress = address != null ? address.PrincipalAddress : string.Empty,
                City = city == null ? string.Empty : city.Label,
                CommercialRegister = company.CommercialRegister,
                MatriculeFisc = company.MatriculeFisc,
                Pays = country == null ? string.Empty : country.Label,
                ZipCode = address != null ? address.IdZipCodeNavigation.Code : string.Empty,
                Tel1 = company.Tel1,
                ClientInfoName = clientName,
                TypeDocs = typeDpcsTitle,
                TypeDocsTitle = typeDpcsTitle,
                DocumentCount = blcount,
                AllTotalHT = alltotalht,
                AllTotalTTC = alltotalttc
            };
        }

        public object UnvalidateInventoryDocument(int id, string userMail)
        {
            try
            {
                BeginTransaction();
                StockDocument stockDocument = _entityRepo.GetAllAsNoTracking().SingleOrDefault(p => p.Id == id);
                _entityRepo.GetAllAsNoTracking().Where(p => p.Id == id).UpdateFromQuery(p => new StockDocument { IdDocumentStatus = (int)DocumentStatusEnumerator.Draft });
                List<StockDocumentLine> stockDocumentLine = _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(p => p.IdStockDocument == id && p.ActualQuantity != p.ForecastQuantity).ToList();
                List<int> listIdDocumentLines = stockDocumentLine.Select(p => p.Id).ToList();
                List<int> listIditems = stockDocumentLine.Select(p => p.IdItem).ToList();
                if (stockDocument.IdTiers != null)
                {
                    IList<int> IdItems = _entityItemTiersRepo.GetAllWithConditionsRelationsQueryable(x => x.IdTiers == stockDocument.IdTiers).Select(x => x.IdItem).ToList();
                    IQueryable<StockMovement> provStockMvt = _entityStockMovementRepo.GetAllWithConditionsRelationsQueryable(x => IdItems.Contains(x.IdItem ?? 0) && x.Status == DocumentEnumerator.Provisional && x.MovementQty > 0);
                    if (provStockMvt.Any())
                    {
                        throw new CustomException(CustomStatusCode.ItemsExistInProvisonalStockMovement);
                    }
                }
                else
                {
                    IQueryable<StockMovement> provStockMvtWithDepot = _entityStockMovementRepo.GetAllWithConditionsRelationsQueryable(x => x.IdWarehouse == stockDocument.IdWarehouseSource
                   && x.Status == DocumentEnumerator.Provisional && x.MovementQty > 0);
                    if (provStockMvtWithDepot.Any())
                    {
                        throw new CustomException(CustomStatusCode.ItemsExistInProvisonalStockMovement);
                    }
                }
                _entityStockMovementRepo.GetAllAsNoTracking().Where(p => listIdDocumentLines.Contains(p.IdStockDocumentLine ?? 0)).UpdateFromQuery(p => new StockMovement
                {
                    IsDeleted = true,
                    DeletedToken = Guid.NewGuid().ToString()
                });
                List<StockDocumentLine> stockDocumentLines = _entityStockDocumentLineRepo.GetAllAsNoTracking().Where(p => p.IdStockDocument == id).ToList();

                List<ItemWarehouse> listItemWarehouse = _repoEntityItemWarehouse.GetAllAsNoTracking().Where(p => listIditems.Contains(p.IdItem)).ToList();
                List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();

                List<StockMovement> stockMovementToAdd = new List<StockMovement>();
                stockDocumentLine.ForEach(line =>
                {
                    int idWarehouse = (stockDocument.IdWarehouseSource.HasValue) ? stockDocument.IdWarehouseSource.Value : line.IdWarehouse.Value;
                    double qty = Math.Abs((line.ActualQuantity ?? 0) - (line.ForecastQuantity ?? 0));
                    ItemWarehouse itemWarehouse = listItemWarehouse.Single(p => p.IdItem == line.IdItem && p.IdWarehouse == idWarehouse);

                    if (line.ActualQuantity > line.ForecastQuantity)
                    {
                        itemWarehouse.AvailableQuantity += qty;
                    }
                    else
                    {
                        itemWarehouse.AvailableQuantity -= qty;
                    }
                    itemWarehouseToUpdate.Add(itemWarehouse);
                });
                _repoEntityItemWarehouse.BulkUpdate(itemWarehouseToUpdate);
                UpdateStatusInventoryItem(stockDocumentLines.Select(x => x.IdItem).Distinct().ToList(), true);
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel { Id = stockDocument.Id, Code = stockDocument.Code };
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw e;
            }
        }
        public override void UpdateReportSettings(DownloadReportDataViewModel data)
        {
            StockDocument stockDocument = _entityRepo.FindSingleBy(x => x.Id == data.Id);
            if (stockDocument != null)
            {
                data.DocumentName = string.Concat(data.DocumentName, Constants.Underscore, stockDocument.Code, Constants.Underscore, stockDocument.DocumentDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            }
            base.UpdateReportSettings(data);
        }

    }
}
