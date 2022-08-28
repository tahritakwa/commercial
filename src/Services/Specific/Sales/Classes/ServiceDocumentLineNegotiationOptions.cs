using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Sales.Classes
{
    public class ServiceDocumentLineNegotiationOptions : Service<DocumentLineNegotiationOptionsViewModel, DocumentLineNegotiationOptions>, IServiceDocumentLineNegotiationOptions
    {
        private readonly IRepository<User> _entityRepoUser;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IServiceDocument _serviceDocument;
        private readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        public ServiceDocumentLineNegotiationOptions(IRepository<DocumentLineNegotiationOptions> entityRepo, IUnitOfWork unitOfWork,
          IDocumentLineNegotiationOptionsBuilder documentLineNegotiationOptionsBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<User> entityRepoUser,
           IServiceDocumentLine serviceDocumentLine, IServiceDocument serviceDocument, IRepository<DocumentType> entityDocumentTypeRepo,
           IServiceCurrencyRate serviceCurrencyRate, IRepository<Company> entityRepoCompany)

           : base(entityRepo, unitOfWork, documentLineNegotiationOptionsBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
            _serviceDocumentLine = serviceDocumentLine;
            _serviceDocument = serviceDocument;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _serviceCurrencyRate = serviceCurrencyRate;
            _entityRepoCompany = entityRepoCompany;
        }

        public object addNegotiationOption(DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel, string userMail)
        {
            if (documentLineNegotiationOptionsViewModel.Id > 0)
            {
                return UpdateModel(documentLineNegotiationOptionsViewModel, null, null);
            }
            else
            {
                documentLineNegotiationOptionsViewModel.IdUser = _entityRepoUser.FindSingleBy(x => x.Email.Equals(userMail)).Id;
                documentLineNegotiationOptionsViewModel.CreationDate = DateTime.Now;
                return AddModel(documentLineNegotiationOptionsViewModel, null, null);
            }

        }

        public void AcceptOrRejectPrice(DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel, string userMail)
        {
            try
            {
                BeginTransaction();
                if (documentLineNegotiationOptionsViewModel.IsAccepted)
                {
                    //udpate document line  price and qty
                    var documentLine = _serviceDocumentLine.GetModelWithRelationsAsNoTracked(x => x.Id == documentLineNegotiationOptionsViewModel.IdDocumentLine, x => x.IdDocumentNavigation);
                    UpdateDocumentLineAndDocumentLinesAssociated(documentLineNegotiationOptionsViewModel, documentLine, userMail, false);

                    //udpate document line associated price and qty
                    var documentLineAssociated = _serviceDocumentLine.GetModelWithRelationsAsNoTracked(x => x.Id == documentLine.IdDocumentLineAssociated,
                        x => x.IdDocumentNavigation);
                    UpdateDocumentLineAndDocumentLinesAssociated(documentLineNegotiationOptionsViewModel, documentLineAssociated, userMail, true);

                }
                UpdateModelWithoutTransaction(documentLineNegotiationOptionsViewModel, null, userMail);
                EndTransaction();
            }
            catch (Exception ex)
            {
                RollBackTransaction();
                throw;
            }
        }

        private void UpdateDocumentLineAndDocumentLinesAssociated(DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel,
            DocumentLineViewModel documentLine, string userMail, bool isForAssociated)
        {
            if (isForAssociated)
            {
                documentLine.HtUnitAmountWithCurrency = documentLineNegotiationOptionsViewModel.PriceSupplier;
            }
            else
            {
                documentLine.UnitPriceFromQuotation = documentLineNegotiationOptionsViewModel.PriceSupplier;
            }
            documentLine.MovementQty = documentLineNegotiationOptionsViewModel.QteSupplier ?? 0;
            ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
            {
                DocumentDate = documentLine.IdDocumentNavigation.DocumentDate,
                DocumentLineViewModel = documentLine,
                DocumentType = documentLine.IdDocumentNavigation.DocumentTypeCode,
                IdCurrency = documentLine.IdDocumentNavigation.IdUsedCurrency ?? 0,
                IdTiers = documentLine.IdDocumentNavigation.IdTiers ?? 0
            };
            _serviceDocument.CheckitemPricesObject(itemPriceViewModel);

            if (isForAssociated)
            {// in the purchase budget no need to calculate the document total so we need just to calculte document line amounts
                _serviceDocument.GetDocumentLinePrice(itemPriceViewModel);
                _serviceDocument.CalculateDocumentLine(itemPriceViewModel);
                _serviceDocumentLine.UpdateModelWithoutTransaction(itemPriceViewModel.DocumentLineViewModel, null, userMail);
            }
            else
            { // in the purchase order we must calculate documentLines and document total prices amounts
                _serviceDocument.InsertUpdateDocumentLineWithoutTransaction(itemPriceViewModel, userMail);
                _serviceDocument.UpdateDocumentAmountsWithoutTransaction(itemPriceViewModel.DocumentLineViewModel.IdDocument, null);
            }
            _unitOfWork.Commit();
        }

        public ReportNegotiationDataViewModel PrintNegotiation(int idDocument)
        {
            var doc = _serviceDocument.GetModelWithRelations(x => x.Id == idDocument, x => x.IdTiersNavigation);
            List<NegotiationDetailsToPrintViewModel> dataToPrint =
                 _entityRepo.QuerableGetAll().Where(x => x.IdDocumentLineNavigation.IdDocument == idDocument && (!x.IsAccepted && !x.IsRejected))
                 .Include(x => x.IdDocumentLineNavigation).Include(x => x.IdItemNavigation)
                 .Select(x => new NegotiationDetailsToPrintViewModel
                 {
                     Designation = x.IdDocumentLineNavigation.Designation,
                     HtPurchasePrice = (double)(x.IdDocumentLineNavigation.UnitPriceFromQuotation != null ? x.IdDocumentLineNavigation.UnitPriceFromQuotation :
                     (x.IdDocumentLineNavigation.HtUnitAmountWithCurrency != null ? x.IdDocumentLineNavigation.HtUnitAmountWithCurrency : 0)),
                     Reference = x.IdItemNavigation.Code,
                     RequestedPrice = x.Price ?? 0,
                     RequestedQuantity = x.Qty ?? 0,
                 }).ToList();

            ReportNegotiationDataViewModel negotiationDetailsToPrintViewModel = new ReportNegotiationDataViewModel
            {
                negotiationDetailsToPrintViewModels = dataToPrint,
                SupplierName = doc.IdTiersNavigation.Name,
                DocumentDate = doc.DocumentDate
            };
            return negotiationDetailsToPrintViewModel;
        }

        public DataSourceResult<DocumentLineNegotiationOptionsViewModel> GetListNegotiationByItem(PredicateFormatViewModel predicateModel)
        {
            var dateFilter = predicateModel.Filter.FirstOrDefault(x => x.Prop == "CreationDate" && (x.Operation != Operation.IsNull
            && x.Operation != Operation.IsNotNull));
            DateTime dateF = default;
            if (dateFilter != null)
            {
                predicateModel.Filter.Remove(dateFilter);
                dateF = (DateTime)dateFilter.Value;
                dateF = new DateTime(dateF.Year, dateF.Month, dateF.Day);
            }
            PredicateFilterRelationViewModel<DocumentLineNegotiationOptions> predicateFilterRelationModel = PreparePredicate(predicateModel);

            var query = _entityRepo.QuerableGetAll().Include(x => x.IdDocumentLineNavigation).ThenInclude(y => y.IdDocumentNavigation)
                .OrderByRelation(predicateModel.OrderBy).Where(predicateFilterRelationModel.PredicateWhere).Where(z => !z.IdDocumentLineNavigation.IsDeleted);
            if (dateFilter != null)
            {
                switch (dateFilter.Operation)
                {
                    case Operation.Equals:
                        query = query.Where(x => x.CreationDate == dateF);
                        break;
                    case Operation.NotEquals:
                        query = query.Where(x => x.CreationDate != dateF);
                        break;
                    case Operation.GreaterThan:
                        query = query.Where(x => x.CreationDate > dateF);
                        break;
                    case Operation.GreaterThanOrEquals:
                        query = query.Where(x => x.CreationDate >= dateF);
                        break;
                    case Operation.LessThan:
                        query = query.Where(x => x.CreationDate < dateF);
                        break;
                    case Operation.LessThanOrEquals:
                        query = query.Where(x => x.CreationDate <= dateF);
                        break;
                    default:
                        break;
                }
            }

            var total = query.Count();
            List<DocumentLineNegotiationOptionsViewModel> listNegotiationByIdItem = query.Skip((predicateModel.page - 1) * predicateModel.pageSize).
                  Take(predicateModel.pageSize).Select(_builder.BuildEntity).ToList();

            if (listNegotiationByIdItem != null && listNegotiationByIdItem.Any())
            {
                listNegotiationByIdItem.ForEach(x =>
                {
                    if (x.IdDocumentLineNavigation != null && x.IdDocumentLineNavigation.IdDocumentNavigation != null)
                    {
                        x.CodeDocument = x.IdDocumentLineNavigation.IdDocumentNavigation.Code;
                        x.DocumentTypeCode = x.IdDocumentLineNavigation.IdDocumentNavigation.DocumentTypeCode;
                        x.StatusDocument = x.IdDocumentLineNavigation.IdDocumentNavigation.IdDocumentStatus;
                        x.IdDocument = x.IdDocumentLineNavigation.IdDocumentNavigation.Id;
                    }
                });
            }
            return new DataSourceResult<DocumentLineNegotiationOptionsViewModel> { data = listNegotiationByIdItem, total = total };
        }
    }
}
