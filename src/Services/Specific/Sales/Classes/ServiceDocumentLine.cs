using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace Services.Specific.Sales.Classes
{
    public class ServiceDocumentLine : Service<DocumentLineViewModel, DocumentLine>, IServiceDocumentLine
    {
        #region Fields
        private readonly IDocumentLineBuilder _documentLineBuilder;
        private readonly IRepository<Item> _entityRepoItem;
        private readonly IRepository<Document> _entityRepoDocument;
        private readonly IRepository<StockMovement> _entityRepoStockMovement;
        private readonly IRepository<ItemWarehouse> _entityRepoItemWarehouse;
        private readonly IItemBuilder _ItemBuilder;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IServiceItem _serviceItem;
        private readonly IServiceNature _serviceNature;
        private readonly IServiceExpense _serviceExpense;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IServiceDocumentLineTaxe _serviceDocumentLineTaxe;
        private readonly IServiceTaxe _serviceTaxe;
        private readonly IRepository<DocumentLineNegotiationOptions> _entityRepoNegotitationOptions;
        private readonly IDocumentBuilder _builderdocument;
        internal readonly IServiceCompany _serviceCompany;
        private readonly IRepository<TaxeGroupTiersConfig> _entityRepoTaxeGroupTiersConfig;
        private readonly IServiceTiers _serviceTiers;
        private readonly ITiersBuilder _tiersBuilder;

        #endregion
        public ServiceDocumentLine(IRepository<DocumentLine> entityRepo, IUnitOfWork unitOfWork,
            IRepository<Document> entityRepoDocument, IRepository<StockMovement> entityRepoStockMovement, IRepository<ItemWarehouse> entityRepoItemWarehouse,
           IDocumentLineBuilder documentLineBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<Item> entityRepoItem, IItemBuilder ItemBuilder, IServiceItemWarehouse serviceItemWarehouse, IServiceItem serviceItem, IServiceNature serviceNature,
             IServiceExpense serviceExpense, IServiceTaxe serviceTaxe, IServiceDocumentLineTaxe serviceDocumentLineTaxe, IServiceStockMovement serviceStockMovement,
              IRepository<DocumentLineNegotiationOptions> entityRepoNegotitationOptions, IDocumentBuilder builderdocument, IServiceCompany serviceCompany, IRepository<TaxeGroupTiersConfig> entityRepoTaxeGroupTiersConfig
            , IServiceTiers serviceTiers, ITiersBuilder tiersBuilder)
           : base(entityRepo, unitOfWork, documentLineBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

            _documentLineBuilder = documentLineBuilder;
            _entityRepoItem = entityRepoItem;
            _ItemBuilder = ItemBuilder;
            _serviceItemWarehouse = serviceItemWarehouse;
            _serviceItem = serviceItem;
            _serviceNature = serviceNature;
            _serviceExpense = serviceExpense;
            _serviceTaxe = serviceTaxe;
            _serviceDocumentLineTaxe = serviceDocumentLineTaxe;
            _serviceStockMovement = serviceStockMovement;
            _entityRepoDocument = entityRepoDocument;
            _entityRepoStockMovement = entityRepoStockMovement;
            _entityRepoItemWarehouse = entityRepoItemWarehouse;
            _entityRepoNegotitationOptions = entityRepoNegotitationOptions;
            _builderdocument = builderdocument;
            _serviceCompany = serviceCompany;
            _entityRepoTaxeGroupTiersConfig = entityRepoTaxeGroupTiersConfig;
            _serviceTiers = serviceTiers;
            _tiersBuilder = tiersBuilder;
        }


        /// <summary>
        /// Account Associeted Quantit
        /// </summary>
        /// <param name="idDocumentLineAssocieted"></param>
        /// <returns></returns>
        public double AccountAssocietedQuantity(int idDocumentLineAssocieted)
        {
            return _entityRepo.GetAllWithConditionsRelationsAsNoTracking(c => c.IdDocumentLineAssociated == idDocumentLineAssocieted).Sum(c => c.MovementQty);
        }

        /// <summary>
        /// Account Associeted Quantit Valid
        /// </summary>
        /// <param name="idDocumentAssocieted"></param>
        /// <returns></returns>
        public double AccountAssocietedQuantityValid(int idDocumentAssocieted)
        {
            return _entityRepo.GetAllWithConditionsRelations(c => c.IdDocumentLineAssociated == idDocumentAssocieted && c.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid).Sum(c => c.MovementQty);

        }
        /// <summary>
        /// Get documment lines
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public IEnumerable<DocumentLineViewModel> GetDocumentLines(int idDocument)
        {
            IList<DocumentLineViewModel> listOfDocumentLine = new List<DocumentLineViewModel>();
            var documentLine = _entityRepo.GetAllWithConditionsRelations(x => x.IdDocument == idDocument, x => x.IdItemNavigation.IdUnitSalesNavigation,
                x => x.IdDocumentNavigation.IdUsedCurrencyNavigation).ToList();
            documentLine.ForEach(x => listOfDocumentLine.Add(_documentLineBuilder.BuildEntity(x)));
            return listOfDocumentLine;
        }

        /// <summary>
        /// UpdateModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        public void UpdateModelWithoutTransaction(DocumentLineViewModel model)
        {
            //build Entity
            dynamic entity = _builder.BuildModel(model);
            _entityRepo.Update(entity);
            _unitOfWork.Commit();
        }


        public int PredpareDocumentLines(DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel, List<DocumentLineViewModel> documentLineViewModels, PredicateFormatViewModel predicate)
        {
            IQueryable<DocumentLine> documentLines = _entityRepo.GetAllWithConditionsQueryable(p => p.IdDocument == documentLinesWithPagingViewModel.IdDocument)
                .Include(p => p.IdItemNavigation).ThenInclude(x => x.IdUnitStockNavigation).Include(x=> x.IdItemNavigation).ThenInclude(x=> x.IdProductItemNavigation)
                .Include(x => x.IdMeasureUnitNavigation)
                .Include(p => p.IdItemNavigation.ItemWarehouse)
                .Include(x => x.IdWarehouseNavigation)
                .Include(x => x.IdStorageNavigation)
                .ThenInclude(x => x.IdShelfNavigation)
                .Include(x => x.DocumentLineNegotiationOptions)
                .Include(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation)
                .Include(p => p.StockMovement);

            if (!string.IsNullOrEmpty(documentLinesWithPagingViewModel.RefDescription))
            {
                documentLines = documentLines.Where(p => (p.IdItemNavigation.Code + p.IdItemNavigation.Description).ToUpper().Contains(documentLinesWithPagingViewModel.RefDescription.ToUpper()));
            }


            if (predicate != null)
            {
                PredicateFilterRelationViewModel<DocumentLine> predicateFilterRelationModel = PreparePredicate(predicate);
                documentLines = documentLines.Where(predicateFilterRelationModel.PredicateWhere);
            }
            documentLines = documentLinesWithPagingViewModel.isSalesDocument == true ? documentLines.OrderByDescending(x => x.Id) : documentLines.OrderBy(x => x.IdItemNavigation.Code);

            int documentLinesNumber = documentLines.Count();

            var documentLinesModelList = documentLines.Skip(documentLinesWithPagingViewModel.Skip).Take(documentLinesWithPagingViewModel.pageSize).ToList();
            var document = _entityRepoDocument.FindSingleBy(x => x.Id == documentLinesWithPagingViewModel.IdDocument);
            if (documentLinesModelList != null && documentLinesModelList.Any())
            {
                string documentType = document.DocumentTypeCode;
                if (documentType == DocumentEnumerator.SalesQuotation || documentType == DocumentEnumerator.SalesOrder
                || documentType == DocumentEnumerator.SalesDelivery || documentType == DocumentEnumerator.SalesInvoice
                || documentType == DocumentEnumerator.SalesAsset || documentType == DocumentEnumerator.SalesInvoiceAsset)
                {
                    documentLinesModelList.ForEach(x => x.IdItemNavigation.UnitHtpurchasePrice = null);
                }
            }
            documentLineViewModels.AddRange(documentLinesModelList.Select(x => _builder.BuildEntity(x)).ToList());
            var idLinesAssociated = documentLines.Select(p => p.IdDocumentLineAssociated).ToList();
            List<DocumentLine> documentLinesAssociated = _entityRepo.GetAllWithConditionsQueryable(p => idLinesAssociated.Contains(p.Id)).ToList();
            List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel = new List<IdItemAndReliquatQtyViewModel>();
            var idItems = documentLineViewModels.Select(x => x.IdItem).ToList();
            if (documentLineViewModels.Count > 0 && document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
            {
                idItemAndReliquatQtyViewModel = _serviceItem.GetRemainingQty(idItems);
            }
            var docNegotiaiton = _entityRepoNegotitationOptions.GetAllWithConditionsQueryable(x => idItems.Contains(x.IdItem) && (x.IsAccepted || x.IsRejected)).Select(x => x.IdItem).ToList();
            var company = _serviceCompany.GetCurrentCompany();
            foreach (DocumentLineViewModel documentLine in documentLineViewModels)
            {
               
                var documentLineModel = documentLinesModelList.First(x => x.Id == documentLine.Id);
                UpdateDocumentLineOperation(documentLine, documentLinesAssociated, documentLineModel);
                GetPucrhaseOrderLinesDetails(documentLine, idItemAndReliquatQtyViewModel, document, company);
                documentLine.IsNegotitatedInOldDocument = docNegotiaiton.Contains(documentLine.IdItem);
            }
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder && documentLineViewModels.Any())
            {
                IList<OrderQuantitybyItem> orderdquantity = GetOrdredQty(documentLineViewModels.Select(x => x.IdItem).ToList(), documentLineViewModels.First().IdWarehouse ?? 0);
                foreach (DocumentLineViewModel documentLine in documentLineViewModels)
                {
                    documentLine.OrderedQty = orderdquantity.First(x => x.IdItem == documentLine.IdItem).OnOrderQuantity;
                }
            }
            return documentLinesNumber;
        }

        public double GetOrdredQty(int idItem, int idWarehouse)
        {
            var item = _serviceItemWarehouse.GetModel(x => x.IdItem == idItem && x.IdWarehouse == idWarehouse);
            if (item != null)
            {
                List<DocumentLine> listPurchaseDeliveryProv = _entityRepo.GetAllWithConditionsQueryable(x =>
                x.IdWarehouse == idWarehouse && x.IdItem == idItem &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
                Include(x => x.IdDocumentNavigation).ToList();

                double sumMvtQtePurchaseDeliveryP = 0;

                if (listPurchaseDeliveryProv != null && listPurchaseDeliveryProv.Any())
                {
                    sumMvtQtePurchaseDeliveryP = listPurchaseDeliveryProv.Sum(z => z.MovementQty);
                }
                return item.OrderedQuantity - sumMvtQtePurchaseDeliveryP;
            }
            return 0;
        }
        public IList<OrderQuantitybyItem> GetOrdredQty(IList<int> idProducts, int idWarehouse)
        {
            var item = _serviceItemWarehouse.GetAllModelsAsNoTracking().Where(x => idProducts.Contains(x.IdItem) && idWarehouse == x.IdWarehouse).ToList();
            IList<OrderQuantitybyItem> result = new List<OrderQuantitybyItem>();
            if (item != null)
            {
                List<DocumentLine> listPurchaseDeliveryProv = _entityRepo.GetAllWithConditionsQueryable(x =>
                x.IdWarehouse == idWarehouse && idProducts.Contains(x.IdItem) &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
                Include(x => x.IdDocumentNavigation).ToList();
                foreach (var productId in idProducts)
                {
                    var order = new OrderQuantitybyItem
                    {
                        IdItem = productId
                    };
                    var itemwarehouse = item.FirstOrDefault(x => x.IdItem == productId);
                    order.OnOrderQuantity = itemwarehouse != null ? itemwarehouse.OrderedQuantity : 0;
                    if (listPurchaseDeliveryProv != null && listPurchaseDeliveryProv.Any())
                    {
                        order.OnOrderQuantity -= listPurchaseDeliveryProv.Where(x => x.IdItem == productId).Sum(z => z.MovementQty);
                    }

                    result.Add(order);
                }
            }
            return result;
        }




        private void GetPucrhaseOrderLinesDetails(DocumentLineViewModel documentLine, List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel, Document document, CompanyViewModel company)
        {
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
            {
                documentLine.NewSalesPrice = AmountMethods.FormatValue((document.Coefficient * documentLine.UnitPriceFromQuotation), company.IdCurrencyNavigation.Precision);
                var dl = idItemAndReliquatQtyViewModel.FirstOrDefault(x => x.IdItem == documentLine.IdItem);
                documentLine.ReliquaQty = dl != null ? dl.ReliquatQty : 0;
                documentLine.DateAvailability = dl != null ? dl.AvailableDate : null;
                if (documentLine.HtUnitAmountWithCurrency > 0 && (documentLine.HtUnitAmountWithCurrency != documentLine.UnitPriceFromQuotation))
                {
                    var increase = (documentLine.UnitPriceFromQuotation - documentLine.HtUnitAmountWithCurrency) / documentLine.HtUnitAmountWithCurrency;
                    documentLine.IncreaseRate = AmountMethods.FormatValue(increase * 100, 3);
                }
                else { documentLine.IncreaseRate = 0; }
                if (documentLine.DocumentLineNegotiationOptions != null)
                {
                    documentLine.IsNegotitated = documentLine.DocumentLineNegotiationOptions.Any();
                    documentLine.IsNegotitationAccpted = documentLine.DocumentLineNegotiationOptions.Any(x => x.IsAccepted);
                    documentLine.IsNegotitatedRefused = documentLine.DocumentLineNegotiationOptions.Any(x => x.IsRejected);
                }

            }
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseBudget && IsDocumentLineNegotiatedFromDocumentLineId(documentLine.Id))
            {
                documentLine.IsNegotitated = true;
            }

        }

        public bool IsDocumentLineNegotiatedFromDocumentLineId(int id)
        {
            return _entityRepoNegotitationOptions.QuerableGetAll().
                    Where(x => x.IdDocumentLineNavigation.IdDocumentLineAssociated == id && x.IsAccepted).Count() > 0;
        }
        public void UpdateDocumentLineOperation(DocumentLineViewModel documentLine, List<DocumentLine> documentLinesAssociated = null, DocumentLine documentLineModel = null)
        {

            if (documentLineModel != null && documentLineModel.IdItemNavigation.ItemWarehouse != null && documentLineModel.IdItemNavigation.ItemWarehouse.Any())
            {
                var itemWarehouse = documentLineModel.IdItemNavigation.ItemWarehouse.FirstOrDefault(x => x.IdItem == documentLine.IdItem && x.IdWarehouse == documentLine.IdWarehouse);
                if (itemWarehouse != null)
                {
                    documentLine.AvailableQuantity = AmountMethods.FormatValue((itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity), documentLine.IdMeasureUnitNavigation != null ? documentLine.IdMeasureUnitNavigation.DigitsAfterComma : 3);
                    if (documentLine.AvailableQuantity < 0)
                    {
                        documentLine.AvailableQuantity = 0;
                        _serviceItemWarehouse.LogEroor(documentLine.IdItem);
                    }
                }
            }
            else if (documentLine.IdWarehouse > 0)
            {
                documentLine.AvailableQuantity = _serviceItemWarehouse.GetItemQtyInWarehouse(documentLine.IdItem, documentLine.IdWarehouse ?? 0);
            }



            if (documentLine.StockMovement != null && documentLine.StockMovement.Any())
            {
                if (documentLine.StockMovement.FirstOrDefault().Status == DocumentEnumerator.Reservation)
                {
                    if (documentLine.AvailableQuantity >= documentLine.MovementQty)
                    {
                        documentLine.IsValidReservationFromProvisionalStock = false;
                    }
                    else
                    {
                        documentLine.IsValidReservationFromProvisionalStock = true;
                    }
                }
            }
            if (documentLine.IdDocumentLineAssociated != null)
            {
                var previousImporteQuantity = AccountAssocietedQuantity((int)documentLine.IdDocumentLineAssociated);
                var digitsNumber = documentLine.IdMeasureUnitNavigation != null ? documentLine.IdMeasureUnitNavigation.DigitsAfterComma : 0;
                if (documentLinesAssociated != null)
                {
                    DocumentLine documentLineAssociated = documentLinesAssociated.FirstOrDefault(p => p.Id == documentLine.IdDocumentLineAssociated);
                    if (documentLineAssociated != null)
                    {
                        documentLine.RemainingQuantity = AmountMethods.FormatValue((documentLineAssociated.MovementQty - previousImporteQuantity), digitsNumber);
                    }
                }
                else
                {
                    DocumentLineViewModel documentLineViewModel = GetModelAsNoTracked(p => p.Id == documentLine.IdDocumentLineAssociated);
                    documentLine.RemainingQuantity = documentLineViewModel != null ? AmountMethods.FormatValue((documentLineViewModel.MovementQty - previousImporteQuantity), digitsNumber) : 0;
                }

            }
            if (documentLine.IdItemNavigation != null)
            {
                documentLine.UnitHtsalePrice = documentLine.IdItemNavigation.UnitHtsalePrice != null ? documentLine.IdItemNavigation.UnitHtsalePrice : 0;
            }
        }
        public List<DocumentLineViewModel> RecalculateAvailableQuantity(int idDocument)
        {
            List<StockMovement> stockMovementList = _entityRepoStockMovement.GetAllWithConditionsQueryable(x => x.IdDocumentLineNavigation.IdDocument == idDocument
             && x.Status == DocumentEnumerator.Reservation).Include(x => x.IdDocumentLineNavigation).ThenInclude(x => x.IdItemNavigation).ToList();
            List<int> listIdItem = stockMovementList.Select(x => x.IdItem.Value).ToList();
            List<int> listIdWarehouse = stockMovementList.Select(x => x.IdWarehouse).ToList();
            List<ItemWarehouse> itemWarehouseList = new List<ItemWarehouse>();


            itemWarehouseList = _entityRepoItemWarehouse.GetAllWithConditionsQueryable(x => listIdItem.Contains(x.IdItem) && listIdWarehouse.Contains(x.IdWarehouse)).ToList();
            if (itemWarehouseList != null && itemWarehouseList.Any())
            {
                var ctx = _unitOfWork.GetContext();
                var attachedEntity = ctx.ChangeTracker.Entries<ItemWarehouse>();
                if (attachedEntity != null)
                {
                    attachedEntity.Select(p => p.Entity).ToList().ForEach(y =>
                    {
                        ctx.Entry(y).State = EntityState.Detached;
                    });
                }
            }
            List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();
            List<StockMovement> stockMovementToUpdate = new List<StockMovement>();
            List<DocumentLineViewModel> updatedReservedLines = new List<DocumentLineViewModel>();
            if (stockMovementList != null && stockMovementList.Any())
            {
                var stockMovementGroupBy = stockMovementList.GroupBy(p => new { p.IdItem, p.IdWarehouse });
                if (stockMovementGroupBy != null && stockMovementGroupBy.Any())
                {
                    stockMovementGroupBy.ToList().ForEach(y =>
                    {
                        y.ToList().ForEach(z =>
                        {
                            if (z.IdDocumentLineNavigation != null)
                            {
                                try
                                {
                                    ItemWarehouse currentItemWarehouse = itemWarehouseList.FirstOrDefault(x => x.IdItem == z.IdDocumentLineNavigation.IdItem && x.IdWarehouse == z.IdDocumentLineNavigation.IdWarehouse);
                                    if (currentItemWarehouse != null)
                                    {
                                        //z.IdDocumentLineNavigation.ShelfAndStorage = currentItemWarehouse.Shelf + " " + currentItemWarehouse.Storage;
                                        var availableQuantity = currentItemWarehouse.AvailableQuantity - currentItemWarehouse.ReservedQuantity;
                                        if (z.IdDocumentLineNavigation.MovementQty <= availableQuantity)
                                        {
                                            currentItemWarehouse.ReservedQuantity += z.IdDocumentLineNavigation.MovementQty;
                                            itemWarehouseToUpdate.Add(currentItemWarehouse);
                                            //_serviceItemWarehouse.UpdateModelWithoutTransaction(currentItemWarehouse, null, null);
                                            z.Status = DocumentEnumerator.Provisional;
                                            updatedReservedLines.Add(_builder.BuildEntity(z.IdDocumentLineNavigation));
                                            z.IdDocumentLineNavigation = null;
                                            stockMovementToUpdate.Add(z);
                                        }
                                    }
                                }
                                catch
                                {

                                }
                            }
                        });
                    });
                }
            }
            _entityRepoStockMovement.BulkUpdate(stockMovementToUpdate);
            _entityRepoItemWarehouse.BulkUpdate(itemWarehouseToUpdate);
            _unitOfWork.Commit();
            return updatedReservedLines;
        }


        /// <summary>
        /// Get ShelfAndStorage Of Item In Warehouse
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        public string GetShelfAndStorageOfItemInWarehouse(int idItem, int? idWarehouse)
        {
            
            StringBuilder shelfAndStorage = new StringBuilder();
            if (idWarehouse != null)
            {
                ItemWarehouseViewModel itemWarehouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == idItem && x.IdWarehouse == idWarehouse);
                if (itemWarehouse != null)
                {
                    shelfAndStorage.Append(itemWarehouse.Shelf).Append(" ").Append(itemWarehouse.Shelf);
                }
            }
            return shelfAndStorage.ToString();
        }

        public dynamic GetDocumentsAssociated(PredicateFormatViewModel predicate)
        {
            BeginTransactionunReadUncommitted();
            var documentFilter = predicate.Filter.FirstOrDefault(x => x.Prop.Contains("Id"));
            int documentId = Convert.ToInt32(documentFilter.Value);

            IList<DocumentAssociatedGeneratedViewModel> entitiesAssociated;
            IList<DocumentAssociatedGeneratedViewModel> entitiesGenerated;

            // Documents associated
            IList<Document> associatedDocuments = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.IdDocument == documentId && x.IdDocumentLineAssociatedNavigation != null
             && x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation != null, x => x.IdDocumentLineAssociatedNavigation, x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation,
             x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation.IdDocumentStatusNavigation, x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation.IdTiersNavigation,
             x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation.IdTiersNavigation.IdCurrencyNavigation)
             .ToList().Select(y => y.IdDocumentLineAssociatedNavigation.IdDocumentNavigation).Distinct().ToList();
            entitiesAssociated = associatedDocuments.Select(x => _builderdocument.BuildDocumentAssociatedGenerated(x)).ToList();
            ChangeColor(entitiesAssociated);

            //Documents generated
            IQueryable<int> idsLignesDoc = _entityRepo.GetAllWithConditionsQueryable(x => x.IdDocument == documentId).Select(y => y.Id);
            IList<Document> generatedDocuments = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.IdDocumentLineAssociated != null && idsLignesDoc.Contains(x.IdDocumentLineAssociated.Value),
                x => x.IdDocumentNavigation, x => x.IdDocumentNavigation.IdDocumentStatusNavigation, x => x.IdDocumentNavigation.IdTiersNavigation,
                x => x.IdDocumentNavigation.IdTiersNavigation.IdCurrencyNavigation).ToList().Select(z => z.IdDocumentNavigation).Distinct().ToList();
            entitiesGenerated = generatedDocuments.Select(x => _builderdocument.BuildDocumentAssociatedGenerated(x)).ToList();

            ChangeColor(entitiesGenerated);


            DocumentListsAssociatedGeneratedViewModel docs = new DocumentListsAssociatedGeneratedViewModel
            {
                AssociatedDocuments = entitiesAssociated,
                GeneratedDocuments = entitiesGenerated,
                IdParentDocument = documentId
            };
            EndTransaction();
            return docs;
        }


        private void ChangeColor(IList<DocumentAssociatedGeneratedViewModel> entities)
        {
            foreach (DocumentAssociatedGeneratedViewModel document in entities)
            {
                if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    document.StatusColer = "ecb50e";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    document.StatusColer = "4dbd74";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed)
                {
                    document.StatusColer = "4608a0";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
                {
                    document.StatusColer = "20a8d8";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft ||
                           document.IdDocumentStatus == (int)DocumentStatusEnumerator.Transferred || document.IdDocumentStatus == (int)DocumentStatusEnumerator.NotSatisfied ||
                           document.IdDocumentStatus == (int)DocumentStatusEnumerator.ToOrder || document.IdDocumentStatus == (int)DocumentStatusEnumerator.Received)
                {
                    document.StatusColer = "0d35a3";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied
                    || document.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)
                {
                    document.StatusColer = "816fa5";
                }
                else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Refused)
                {
                    document.StatusColer = "f86c6b";
                }
            }
        }
        public BalanceDocumentLine CreateBalanceDocumentLine(DocumentLine x, double importedQuantity, bool isSalesDocument)
        {
            BalanceDocumentLine balanceDocumentLine;
            _serviceItemWarehouse.GetAvailbleQuantityForItem(x.IdItemNavigation);
            return balanceDocumentLine = new BalanceDocumentLine()
            {
                Reference = x.IdItemNavigation.Code,
                Designation = x.IdItemNavigation.Description,
                QtyBalance = AmountMethods.FormatValue((x.MovementQty - importedQuantity), x.IdMeasureUnitNavigation != null ? x.IdMeasureUnitNavigation.DigitsAfterComma : NumberConstant.Three),
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
                FormatOption = _tiersBuilder.BuildEntity(x.IdDocumentNavigation.IdTiersNavigation).FormatOption
            };

        }
        public List<BalanceDocumentLine> GetBalancedListWithPredicate(int idTiers, PredicateFormatViewModel predicate, List<int> idItems = null,
           string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false)
        {
            List<BalanceDocumentLine> listBalance = new List<BalanceDocumentLine>();

            var listImporterLinesFinal = GetImporterDocumentToBalanceList(idTiers, idItems,
       importerDocumentType, importedDocumentType);
            if (listImporterLinesFinal != null && listImporterLinesFinal.Any())
            {
                var DocumentIds = listImporterLinesFinal.Where(x => x.IdDocumentLineAssociatedNavigation != null)
                   .Select(x => x.IdDocumentLineAssociatedNavigation.IdDocument).ToList();
                var listImpotedLinesQuerable = _entityRepo.QuerableGetAll().Include(x => x.IdItemNavigation).Include(x => x.IdDocumentNavigation).
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
                if (predicate != null)
                {
                    PredicateFilterRelationViewModel<DocumentLine> predicateFilterRelationModel = PreparePredicate(predicate);
                    listImpotedLinesQuerable = listImpotedLinesQuerable.Where(predicateFilterRelationModel.PredicateWhere);
                }
                List<DocumentLine> listImpotedLines = listImpotedLinesQuerable.ToList();
                var isSalesDocument = importerDocumentType != null && importerDocumentType.EndsWith("SA");
                BalanceDocumentLine balanceDocumentLine;

                listImpotedLines.ForEach(x =>
                {
                    var importedQuantity = listImporterLinesFinal.Where(y => y.IdDocumentLineAssociated == x.Id && y.IdItem == x.IdItem).Sum(y => y.MovementQty);

                    if (x.MovementQty > importedQuantity)
                    {
                        balanceDocumentLine = CreateBalanceDocumentLine(x, importedQuantity, isSalesDocument);

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
            if (predicate != null)
            {
                var predQtyBalance = predicate.Filter.Where(x => x.Prop == "QtyBalance").FirstOrDefault();
                bool isQtyFilter = predQtyBalance != null ? true : false;
                if (isQtyFilter && predQtyBalance.Value != null)
                {
                    listBalance = listBalance.Where(x => x.QtyBalance == (Convert.ToInt32(predQtyBalance.Value))).ToList();
                }
                var predAllAvailableQuantity = predicate.Filter.Where(x => x.Prop == "AllAvailableQuantity").FirstOrDefault();
                bool isAvailableFilter = predAllAvailableQuantity != null ? true : false;
                if (isAvailableFilter && predAllAvailableQuantity.Value != null)
                {
                    listBalance = listBalance.Where(x => x.QtyStock == (Convert.ToInt32(predAllAvailableQuantity.Value))).ToList();
                }
            }

            return listBalance.OrderByDescending(x => x.DateOrderDocument).ToList();
        }
        public List<DocumentLine> GetImporterDocumentToBalanceList(int idTiers, List<int> idItems = null, string importerDocumentType = null, string importedDocumentType = null)
        {
            List<DocumentLine> listImporterLinesFinal = new List<DocumentLine>();
            var AllImporterLinesQuerable = _entityRepo.QuerableGetAll().
           Include(x => x.IdDocumentLineAssociatedNavigation)
           .Include(x => x.IdDocumentNavigation).Where(x => x.IdDocumentLineAssociated != null &&
           x.IdDocumentNavigation.DocumentTypeCode == (importerDocumentType ?? DocumentEnumerator.PurchaseFinalOrder));

            if (AllImporterLinesQuerable != null)
            {
                listImporterLinesFinal = idTiers > 0
                    ? AllImporterLinesQuerable.Where(x => x.IdDocumentNavigation.IdTiers == idTiers).ToList()
                    : AllImporterLinesQuerable.Where(x => idItems.Contains(x.IdItem)).ToList();

            }

            return listImporterLinesFinal;
        }
        public List<BalanceDocumentLine> GetBalancedList(int idTiers, List<int> idItems = null,
           string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false)
        {
            List<BalanceDocumentLine> listBalance = new List<BalanceDocumentLine>();

            var listImporterLinesFinal = GetImporterDocumentToBalanceList(idTiers, idItems,
       importerDocumentType, importedDocumentType);
            if (listImporterLinesFinal != null && listImporterLinesFinal.Any())
            {
                var DocumentIds = listImporterLinesFinal.Where(x => x.IdDocumentLineAssociatedNavigation != null)
                   .Select(x => x.IdDocumentLineAssociatedNavigation.IdDocument).ToList();
                var listImpotedLinesQuerable = _entityRepo.QuerableGetAll().Include(x => x.IdItemNavigation).Include(x => x.IdDocumentNavigation).
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
                        balanceDocumentLine = CreateBalanceDocumentLine(x, importedQuantity, isSalesDocument);
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


            return listBalance.OrderByDescending(x => x.DateOrderDocument).ToList();
        }
    }
}
