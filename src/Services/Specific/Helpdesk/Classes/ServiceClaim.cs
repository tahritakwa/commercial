using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Helpdesk.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Helpdesk.Classes
{
    public class ServiceClaim : Service<ClaimViewModel, Claim>, IServiceClaim
    {

        public readonly IClaimBuilder _entityBuilder;
        internal readonly IRepository<User> _entityRepoUser;
        public readonly IReducedClaimBuilder _reducedBuilder;
        public readonly IDocumentBuilder _documentBuilder;
        public readonly IReducedDocumentBuilder _reducedDocumentBuilder;
        public readonly IReducedDocumentLineBuilder _reducedDocumentLineBuilder;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IServiceItem _serviceItem;
        private readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        private readonly IRepository<Document> _entityDocumentRepo;
        private readonly IRepository<Tiers> _entityTiersRepo;
        private readonly IRepository<Item> _entityItemRepo;
        private readonly IRepository<DocumentLine> _entityDocumentLineRepo;



        private Expression<Func<Claim, object>>[] relationInclude = new Expression<Func<Claim, object>>[]
        {
                p => p.IdClaimStatusNavigation,
                p => p.IdClientNavigation,
                p => p.IdFournisseurNavigation,
                p => p.ClaimTypeNavigation,
                p => p.IdDocumentNavigation,
                p => p.IdWarehouseNavigation,
                p => p.ClaimInteraction,
                p => p.IdItemNavigation,
                p => p.IdMovementInNavigation,
                p => p.IdMovementOutNavigation,
                p => p.IdSalesAssetDocumentNavigation
        };

        public ServiceClaim(IServiceStockMovement serviceStockMovement,
            IServiceItem serviceItem, IServiceDocumentLine serviceDocumentLine, IServiceDocument serviceDocument, IDocumentBuilder documentBuilder, IRepository<Claim> entityRepo, IUnitOfWork unitOfWork, IReducedClaimBuilder reducedBuilder,
            IClaimBuilder reclamationBuilder, IRepository<User> entityRepoUser,
            IReducedDocumentBuilder reducedDocumentBuilder,
            IReducedDocumentLineBuilder reducedDocumentLineBuilder,
            IRepository<DocumentType> entityDocumentTypeRepo, IRepository<Tiers> entityTiersRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Document> entityDocumentRepo, IServiceWarehouse serviceWarehouse,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification, IRepository<Item> entityItemRepo,
            IRepository<DocumentLine> entityDocumentLineRepo, IServiceCurrencyRate serviceCurrencyRate, IRepository<Company> entityRepoCompany)
            : base(entityRepo, unitOfWork, reclamationBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityBuilder = reclamationBuilder;
            _entityRepoEntity = entityRepoEntity;
            _entityRepoUser = entityRepoUser;
            _reducedBuilder = reducedBuilder;
            _documentBuilder = documentBuilder;
            _serviceDocument = serviceDocument;
            _serviceDocumentLine = serviceDocumentLine;
            _serviceStockMovement = serviceStockMovement;
            _serviceItem = serviceItem;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _reducedDocumentBuilder = reducedDocumentBuilder;
            _reducedDocumentLineBuilder = reducedDocumentLineBuilder;
            _entityDocumentRepo = entityDocumentRepo;
            _entityTiersRepo = entityTiersRepo;
            _serviceWarehouse = serviceWarehouse;
            _entityItemRepo = entityItemRepo;
            _entityDocumentLineRepo = entityDocumentLineRepo;
            _serviceCurrencyRate = serviceCurrencyRate;
            _entityRepoCompany = entityRepoCompany;
        }


        /// <summary>
        /// Recuperat elment Related to Id 
        /// </summary>
        /// <param name="id"> Id Item</param>
        /// <returns></returns>
        public virtual ClaimViewModel GetClaimById(int id)
        {
            return GetModelWithRelationsAsNoTracked(x => x.Id == id, relationInclude);
        }


        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<ClaimViewModel> GetClaimList(PredicateFormatViewModel predicateModel)
        {
            // Get list of Claims
            DataSourceResult<ClaimViewModel> listOfReclamation = base.FindDataSourceModelBy(predicateModel);
            return listOfReclamation;
        }

        public ClaimViewModel AddClaim(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();

                if (claimViewModel.ClaimType == HelpDeskEnumerator.Defective)
                {
                    if (FindByAsNoTracking(c => c.ClaimType == claimViewModel.ClaimType
                            && c.IdClient == claimViewModel.IdClient
                            && c.IdClaimStatus == (int)claimViewModel.IdClaimStatus
                            && c.IdItem == claimViewModel.IdItem
                            && c.IdDocumentLine == claimViewModel.IdDocumentLine).Any())
                    {
                        throw new CustomException(CustomStatusCode.AddExistingClaim);
                    }
                }
                else
                {
                    if (FindByAsNoTracking(c => c.ClaimType == claimViewModel.ClaimType
                            && c.IdFournisseur == claimViewModel.IdFournisseur
                            && c.IdClaimStatus == (int)claimViewModel.IdClaimStatus
                            && c.IdItem == claimViewModel.IdItem).Any())
                    {
                        throw new CustomException(CustomStatusCode.AddExistingClaim);
                    }
                }

                if (claimViewModel.IdWarehouse == null)
                {
                    claimViewModel.IdWarehouse = _serviceWarehouse.GetCentralWarehouse().Id;
                }
                if (claimViewModel.ClaimInteraction.Any()
                        && claimViewModel.ClaimInteraction.Count(p => p.IsDeleted == true) != claimViewModel.ClaimInteraction.Count
                        && claimViewModel.IdClaimStatus == (int)ClaimStatusEnumerator.NEW_CLAIM)
                {
                    claimViewModel.IdClaimStatus = (int)ClaimStatusEnumerator.SUBMITTED_CLAIM;
                }
                if (claimViewModel.ClaimType == HelpDeskEnumerator.Defective && claimViewModel.ReferenceOldDocument != null && claimViewModel.ReferenceOldDocument != "")
                {
                    claimViewModel.IdClaimStatus = (int)ClaimStatusEnumerator.ACCEPTED_CLAIM;
                }
               
                var addresult = (CreatedDataViewModel)AddModelWithoutTransaction(claimViewModel, entityAxisValuesModelList, userMail, nameof(claimViewModel.ClaimType));
                claimViewModel.Code = addresult.Code;
                claimViewModel.Id = addresult.Id;
                var result = GetModelAsNoTracked(c => c.Id == addresult.Id, relationInclude);
                claimViewModel = result;
                _serviceItem.UpdateItemClaims((int)claimViewModel.IdItem);
                EndTransaction();
                return claimViewModel;

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

        public ClaimViewModel UpdateClaim(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();

                if (!FindByAsNoTracking(c => c.Id == claimViewModel.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.AddNotExistingClaim);
                }
               
                if(claimViewModel.IdClaimStatus == (int)ClaimStatusEnumerator.ACCEPTED_CLAIM)
                {
                    ClaimViewModel oldClaim = this.GetAllModelsAsNoTracking().Where(x => x.Id == claimViewModel.Id).FirstOrDefault();
                    if(claimViewModel.ClaimQty != oldClaim.ClaimQty)
                    {
                        claimViewModel.ClaimQty = oldClaim.ClaimQty;
                    }
                    if (claimViewModel.IdFournisseur != oldClaim.IdFournisseur)
                    {
                        claimViewModel.IdFournisseur = oldClaim.IdFournisseur;
                    }
                }
                if (claimViewModel.ClaimInteraction.Any()
                    && claimViewModel.ClaimInteraction.Count(p => p.IsDeleted == true) != claimViewModel.ClaimInteraction.Count
                    && claimViewModel.IdClaimStatus == (int)ClaimStatusEnumerator.NEW_CLAIM)
                {
                    claimViewModel.IdClaimStatus = (int)ClaimStatusEnumerator.SUBMITTED_CLAIM;
                }
                if (claimViewModel.ClaimType == HelpDeskEnumerator.Defective && claimViewModel.ReferenceOldDocument != null && claimViewModel.ReferenceOldDocument != "")
                {
                    claimViewModel.IdClaimStatus = (int)ClaimStatusEnumerator.ACCEPTED_CLAIM;
                }

                if (claimViewModel.IdWarehouse == null)
                {
                    claimViewModel.IdWarehouse = _serviceWarehouse.GetCentralWarehouse().Id;
                }
               

                UpdateModelWithoutTransaction(claimViewModel, entityAxisValuesModelList, userMail, nameof(claimViewModel.ClaimType));
                var result = GetModelAsNoTracked(c => c.Id == claimViewModel.Id, relationInclude);
                claimViewModel = result;
                _serviceItem.UpdateItemClaims((int)claimViewModel.IdItem);
                EndTransaction();
                return claimViewModel;

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
        public ClaimViewModel AddClaimTiersAsset(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();

                var claimDocumentLine = _serviceDocumentLine.GetModelWithRelationsAsNoTracked(x => x.Id == claimViewModel.IdDocumentLine,
                    x => x.IdDocumentNavigation,
                    y => y.DocumentLinePrices,
                    h => h.DocumentLineTaxe, r => r.IdDocumentNavigation);
                var claimDocument = claimDocumentLine.IdDocumentNavigation;
                var invoicingType = _entityDocumentRepo.QuerableGetAll().FirstOrDefault(x => x.Id == claimViewModel.IdDocument).InoicingType;
                DocumentViewModel tiersAsset = new DocumentViewModel
                {
                    DocumentDate = DateTime.Now,
                    CreationDate = DateTime.Now,
                    DocumentTypeCode = DocumentEnumerator.SalesAsset,
                    IdTiers = claimViewModel.IdClient,
                    IdUsedCurrency = claimDocument.IdUsedCurrency,
                    IsGenerated = true,
                    DocumentLine = new List<DocumentLineViewModel>(),
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    InoicingType = (invoicingType == (int)InvoicingTypeEnumerator.Other) ? (int)InvoicingTypeEnumerator.Other : (int)InvoicingTypeEnumerator.Cash
                };
                tiersAsset.IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == userMail).Id;

                claimDocumentLine.IdDocumentLineAssociated = claimDocumentLine.Id;
                claimDocumentLine.Id = 0;
                claimDocumentLine.IdDocument = 0;
                claimDocumentLine.StockMovement = null;
                claimDocumentLine.MovementQty = (double)claimViewModel.ClaimQty;
                claimDocumentLine.IdDocumentLineStatus = tiersAsset.IdDocumentStatus;
                if (claimDocumentLine.DocumentLineTaxe != null && claimDocumentLine.DocumentLineTaxe.Count > 0)
                {
                    claimDocumentLine.DocumentLineTaxe.ToList().ForEach(x => { x.Id = 0; x.IdDocumentLine = 0; });
                }
                if (claimDocumentLine.DocumentLinePrices != null && claimDocumentLine.DocumentLinePrices.Count > 0)
                {
                    claimDocumentLine.DocumentLinePrices.ToList().ForEach(x => { x.Id = 0; x.IdDocumentLine = 0; });
                }
                claimDocumentLine.IdWarehouse = claimViewModel.IdWarehouse;
                tiersAsset.DocumentLine.Add(claimDocumentLine);
                tiersAsset.IdDocumentAssociated = claimViewModel.IdDocument;


                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == tiersAsset.DocumentTypeCode);
                CreatedDataViewModel data = (CreatedDataViewModel)_serviceDocument.AddDocumentWithoutTransaction(null, tiersAsset, documentType, userMail, entityAxisValuesModelList);
                claimViewModel.IdSalesAssetDocument = data.Id;
                claimViewModel.IsClaimQtyLocked = true;
                if (claimViewModel.IdWarehouse == null)
                {
                    claimViewModel.IdWarehouse = _serviceWarehouse.GetCentralWarehouse().Id;
                }
                Claim entity = _builder.BuildModel(claimViewModel);
                _entityRepo.Update(entity);
                _unitOfWork.Commit();
                var result = GetModelAsNoTracked(c => c.Id == claimViewModel.Id, relationInclude);
                claimViewModel = result;
                EndTransaction();
                return claimViewModel;

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

        public ClaimViewModel AddClaimTiersMovement(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                if ((claimViewModel.IdMovementIn.HasValue || claimViewModel.IdMovementOut.HasValue))
                {
                    if (claimViewModel.IdMovementIn.HasValue)
                        throw new CustomException(CustomStatusCode.AddExistingClaimTiersMovementIn);
                    if (claimViewModel.IdMovementOut.HasValue)
                        throw new CustomException(CustomStatusCode.AddExistingClaimTiersMovementOut);
                }

                var documentTypeCode = (claimViewModel.ClaimType == HelpDeskEnumerator.Defective || claimViewModel.ClaimType == HelpDeskEnumerator.Missing) ? DocumentEnumerator.BS : DocumentEnumerator.BE;
                if (claimViewModel.IdWarehouse == null)
                {
                    claimViewModel.IdWarehouse = _serviceWarehouse.GetCentralWarehouse().Id;
                }
                DocumentViewModel tiersAsset = new DocumentViewModel
                {
                    DocumentDate = DateTime.Now,
                    CreationDate = DateTime.Now,
                    DocumentTypeCode = documentTypeCode,
                    IdTiers = claimViewModel.IdFournisseur,
                    IsGenerated = true,
                    DocumentLine = new List<DocumentLineViewModel>(),
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                };

                
                tiersAsset.IdUsedCurrency = _entityTiersRepo.GetAllAsNoTracking().FirstOrDefault(p => p.Id == tiersAsset.IdTiers).IdCurrency;
                tiersAsset.IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == userMail).Id;
                var concernedItem = _serviceItem.GetModelWithRelationsAsNoTracked(p => p.Id == claimViewModel.IdItem, x => x.ItemTiers);
                var claimDocumentLine = new DocumentLineViewModel();
                if (claimViewModel.IdSalesAssetDocument != null)
                    claimDocumentLine = _serviceDocumentLine.FindModelBy(p => p.IdDocument == claimViewModel.IdSalesAssetDocument).FirstOrDefault();
                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == tiersAsset.DocumentTypeCode);
                claimDocumentLine.HtUnitAmountWithCurrency= GetPrice(documentType.Code,(int) tiersAsset.IdTiers, concernedItem, tiersAsset.DocumentDate);
               // claimDocumentLine.HtUnitAmountWithCurrency = (claimDocumentLine.HtUnitAmountWithCurrency != null) ? claimDocumentLine.HtUnitAmountWithCurrency : concernedItem.UnitHtsalePrice;
                claimDocumentLine.HtAmountWithCurrency = claimDocumentLine.HtUnitAmountWithCurrency;
                claimDocumentLine.IdDocumentLineAssociated = null;
                claimDocumentLine.Id = 0;
                claimDocumentLine.IdDocument = 0;
                claimDocumentLine.StockMovement = null;
                claimDocumentLine.IdItem = (int)claimViewModel.IdItem;
                claimDocumentLine.IdMeasureUnit = documentType.IsSaleDocumentType ? concernedItem.IdUnitSales : concernedItem.IdUnitStock;
                claimDocumentLine.MovementQty = (double)claimViewModel.ClaimQty;
                claimDocumentLine.IdDocumentLineStatus = tiersAsset.IdDocumentStatus;
                claimDocumentLine.Designation = concernedItem.Description;
                if (claimDocumentLine.DocumentLineTaxe != null && claimDocumentLine.DocumentLineTaxe.Count > 0)
                {
                    claimDocumentLine.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                }
                if (claimDocumentLine.DocumentLinePrices != null && claimDocumentLine.DocumentLinePrices.Count > 0)
                {
                    claimDocumentLine.DocumentLinePrices.ToList().ForEach(x => x.Id = 0);
                }
                claimDocumentLine.IdWarehouse = claimViewModel.IdWarehouse;
                tiersAsset.DocumentLine.Add(claimDocumentLine);
                tiersAsset.IdDocumentAssociated = claimViewModel.IdDocument;


                List<object> codification = getCodification(tiersAsset, "DocumentTypeCode", false, true);

                tiersAsset.Code = codification[2].ToString();

                if (codification.Any() && ((Codification)codification[0]).Id != 0)
                {
                    ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                    _entityRepoCodification.Update(((Codification)codification[0]));
                    _unitOfWork.Commit();
                }

                CreatedDataViewModel data = (CreatedDataViewModel)_serviceDocument.AddDocumentWithoutTransaction(null, tiersAsset, documentType, userMail, entityAxisValuesModelList);

                if (documentTypeCode == DocumentEnumerator.BE)
                {
                    claimViewModel.IdMovementIn = data.Id;
                }
                if (documentTypeCode == DocumentEnumerator.BS)
                {
                    claimViewModel.IdMovementOut = data.Id;
                }
                claimViewModel.IsClaimQtyLocked = true;
                Claim entity = _builder.BuildModel(claimViewModel);
                _entityRepo.Update(entity);
                _unitOfWork.Commit();
                var result = GetModelAsNoTracked(c => c.Id == claimViewModel.Id, relationInclude);
                claimViewModel = result;
                EndTransaction();
                return claimViewModel;

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
          private double? GetPrice(string documentType,int idTiers, ItemViewModel item, DateTime documentDate)
        {
            Tiers tiers = _entityTiersRepo.FindSingleBy(x => x.Id == idTiers);
            if (documentType == DocumentEnumerator.BS && tiers.IdTypeTiers != (int)TiersType.Supplier ||
               (documentType == DocumentEnumerator.BE && tiers.IdTypeTiers == (int)TiersType.Customer))
            {
                if (tiers.IdCurrency == GetCurrentCompany().IdCurrency)
                {
                    return item.UnitHtsalePrice;
                }
                else
                {
                    var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue((int)tiers.IdCurrency, documentDate);
                    int precisionTierValues = _serviceDocument.GetPrecissionValue((int)tiers.IdCurrency, documentType);
                    return AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? item.UnitHtsalePrice / exchangeRate : item.UnitHtsalePrice, precisionTierValues);
                }
            }
            else
            {
                //TODO: return last prices per supplier
                var itemTier = item.ItemTiers.Where(x => x.IdTiers == idTiers);
                return itemTier.Any() && itemTier.First().PurchasePrice.HasValue ? itemTier.First().PurchasePrice.Value : NumberConstant.Zero; 
            }
        }
        /// <summary>
        /// Get list of documents ids by predicate
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public List<int> GetDocumentsIdsWithCondition(PredicateFormatViewModel predicate)
        {
            List<int> listOfDocumentsIds = new List<int>();
            listOfDocumentsIds = base.FindModelBy(predicate).Select(x => x.Id).ToList();
            return listOfDocumentsIds;
        }

        public DataSourceResult<ReducedClaimViewModel> GetDropdownForClaims(PredicateFormatViewModel model)
        {
            var relationinclude = new Expression<Func<Claim, object>>[] { };
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.IdWarehouse == (int)model.Filter.First().Value, relationinclude);
            var count = entities.Count();

            return new DataSourceResult<ReducedClaimViewModel>
            {
                data = entities.GroupBy(y => y.Id).Distinct().Select(c => _reducedBuilder.BuildEntity(c.FirstOrDefault())).ToList(),
                total = count
            };
        }
        /// <summary>
        /// Retrieval of purchase receipt /purchase invoice / BE for claim from idItem and id supplier
        /// </summary>
        /// <param name="model"></param>
        /// <returns>List of document of type sales delivery </returns>
        public bool VerifyExistingPurchaseDocument(ClaimQueryViewModel model)
        {
            return _entityDocumentRepo.GetAllAsNoTracking().Where(p => p.DocumentLine != null
            && p.DocumentLine.Any(v => v.IdItem == model.IdItem)
            && (p.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery || p.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice
             || p.DocumentTypeCode == DocumentEnumerator.BE)
            && (p.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
            && p.IdTiers == model.IdTiers).Count() > 0;
        }


        /// <summary>
        /// Retrieval of sales delivery for claim from idItem and id supplier
        /// </summary>
        /// <param name="model"></param>
        /// <returns>List of document of type sales delivery </returns>
        public DocumentViewModel GetBLFromClaimItem(ClaimQueryViewModel model)
        {
            Document document = _entityDocumentRepo.QuerableGetAll().Where(x => x.DocumentLine != null
            && x.DocumentLine.Any(v => v.IdItem == model.IdItem)
            && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery
            && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
            && x.IdTiers == model.IdTiers).Include(n => n.DocumentLine).OrderByDescending(n => n.CreationDate).FirstOrDefault();
            DocumentViewModel salesDelivery = _documentBuilder.BuildEntity(document);
            return salesDelivery;
        }

        /// <summary>
        /// Retrieval of sales invoice for claim from idItem and id supplier
        /// </summary>
        /// <param name="model"></param>
        /// <returns>List of document of type sales invoice </returns>
        public DocumentViewModel GetSIFromClaimItem(ClaimQueryViewModel model)
        {
            List<Document> listSalesInvoice = _entityDocumentRepo.GetAllAsNoTracking().Include(p => p.DocumentLine).Where(p => p.DocumentLine != null
            && p.DocumentLine.Any(v => v.IdItem == model.IdItem)
            && p.DocumentTypeCode == DocumentEnumerator.SalesInvoice
            && p.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
            && p.IdTiers == model.IdTiers).OrderByDescending(p => p.CreationDate).ToList();

            List<int> idInvoices = _entityRepo.GetAllAsNoTracking().Where(p => p.ClaimType == HelpDeskEnumerator.Defective && p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                                 && p.IdClient == model.IdTiers && p.IdItem == model.IdItem && p.Id != model.Id).Select(p => p.IdDocument ?? 0).Distinct().ToList();

            return _documentBuilder.BuildEntity(listSalesInvoice.FirstOrDefault(p => !idInvoices.Contains(p.Id)));
        }

        /// <summary>
        /// Retrieval of stock movement out for claim from idItem
        /// </summary>
        /// <param name="model"> </param>
        /// <returns>List of stock movement</returns>
        public DocumentViewModel GetBSFromClaimItem(ClaimQueryViewModel model)
        {
            DocumentViewModel bs = _serviceDocument.GetAllModelsQueryable(p => p.DocumentLine != null
           && p.DocumentLine.Any(v => v.IdItem == model.IdItem && !_entityDocumentLineRepo.GetAllAsNoTracking().Any(c => c.IdDocumentLineAssociated == v.Id))
           && p.DocumentTypeCode == DocumentEnumerator.BS
           && p.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
           && p.IdTiers == model.IdTiers, p => p.DocumentLine).ToList().OrderByDescending(p => p.CreationDate).FirstOrDefault();
            return bs;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.GroupBy(y => y.Id).Distinct().Select(v => v.FirstOrDefault()).ToList(),
                total = total
            };
        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                var entity = _entityRepo.GetSingleNotTracked(x => x.Id == id);
                int idItem = (int)entity.IdItem;
                var obj = DeleteModelwithouTransaction(id, tableName, userMail);
                _serviceItem.UpdateItemClaims(idItem);
                EndTransaction();
                return obj;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
        }

        public void UpdateRelatedDocumentToClaim(ItemPriceViewModel itemPriceViewModel)
        {
            try
            {
                BeginTransaction();
                DocumentLine documentLine = _entityDocumentLineRepo.GetSingleNotTracked(p => p.Id == itemPriceViewModel.DocumentLineViewModel.Id);
                if (documentLine == null)
                {
                    throw new CustomException(CustomStatusCode.DELETED_DOCUMENT_LINE);
                }
                if (documentLine.MovementQty < itemPriceViewModel.DocumentLineViewModel.MovementQty)
                {
                    throw new CustomException(CustomStatusCode.UPDATED_QTY_DOCUMENT_LINE);
                }
                _serviceDocument.VerifyBlRelatedToBsWhenDeletedLine(itemPriceViewModel);
                _serviceDocument.InsertUpdateDocumentLineProcess(itemPriceViewModel);
                _serviceDocument.UpdateDocumentAmountsWithoutTransaction(itemPriceViewModel.DocumentLineViewModel.IdDocument, null);
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
        }

        public void UpdateRelatedBSToClaim(ItemPriceViewModel itemPriceViewModel, string userMail)
        {
            try
            {
                BeginTransaction();
                DocumentLine documentLine = _entityDocumentLineRepo.GetSingleNotTracked(p => p.Id == itemPriceViewModel.DocumentLineViewModel.Id);
                if (documentLine == null)
                {
                    throw new CustomException(CustomStatusCode.DELETED_DOCUMENT_LINE);
                }
                if (documentLine.MovementQty < itemPriceViewModel.DocumentLineViewModel.MovementQty)
                {
                    throw new CustomException(CustomStatusCode.UPDATED_QTY_DOCUMENT_LINE);
                }
                _serviceDocument.InsertUpdateBSDocumentLineProcess(itemPriceViewModel);
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw;
            }
        }
    }
}
