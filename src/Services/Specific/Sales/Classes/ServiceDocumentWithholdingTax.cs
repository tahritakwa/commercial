using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceDocumentWithholdingTax : Service<DocumentWithholdingTaxViewModel, DocumentWithholdingTax>, IServiceDocumentWithholdingTax
    {
        IRepository<Document> _entityDoucmentRepo;
        IServiceCurrencyRate _serviceCurrencyRate;
        IServiceCompany _serviceCompany;
        IServiceFinancialCommitment _serviceFinancialCommitment;
        IDocumentBuilder _documentBuilder;
        internal readonly IRepository<Settlement> _entitySettlementRepo;
        internal readonly IRepository<FinancialCommitment> _entityFinancialCommitmentRepo;
        public ServiceDocumentWithholdingTax(IRepository<DocumentWithholdingTax> entityRepo, IUnitOfWork unitOfWork, IDocumentWithholdingTaxBuilder documentWithholdingTaxsBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
                  IRepository<Document> entityDoucmentRepo, IServiceCurrencyRate serviceCurrencyRate,
                   IServiceFinancialCommitment serviceFinancialCommitment, IServiceCompany serviceCompany,
                   IDocumentBuilder documentBuilder, IRepository<Settlement> entitySettlementRepo, IRepository<FinancialCommitment> entityFinancialCommitmentRepo)
            : base(entityRepo, unitOfWork, documentWithholdingTaxsBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityDoucmentRepo = entityDoucmentRepo;
            _serviceCurrencyRate = serviceCurrencyRate;
            _serviceCompany = serviceCompany;
            _serviceFinancialCommitment = serviceFinancialCommitment;
            _documentBuilder = documentBuilder;
            _entitySettlementRepo = entitySettlementRepo;
            _entityFinancialCommitmentRepo = entityFinancialCommitmentRepo;
        }

        public object AddDocumentWithholdingTax(List<DocumentWithholdingTaxViewModel> model, string userMail)
        {
            try
            {
                if (model != null && model.Any())
                {
                    BeginTransaction();
                    bool haveOnlyDepositInvoice = false;
                    DocumentViewModel document = _entityDoucmentRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == model.ElementAt(0).IdDocument)
                                                                    .Include(x => x.FinancialCommitment)
                                                                    .Include(x => x.DocumentWithholdingTax)
                                                                    .Include(x => x.IdTiersNavigation)
                                                                    .Include(x => x.IdTiersNavigation.IdCurrencyNavigation)
                                                                    .Select(_documentBuilder.BuildEntity)
                                                                    .FirstOrDefault();
                    if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied && document.IdSalesDepositInvoice != null)
                    {
                        List<SettlementCommitment> settlementCommitments = _entityFinancialCommitmentRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocument == document.Id && (x.IdStatus == (int)DocumentStatusEnumerator.TotallySatisfied || x.IdStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
            , z => z.SettlementCommitment).SelectMany(y => y.SettlementCommitment).ToList();
                        List<int> idsSettlement = settlementCommitments.Select(x => x.SettlementId).ToList();
                        haveOnlyDepositInvoice = _entitySettlementRepo.GetAllWithConditionsRelationsAsNoTracking(x => idsSettlement.Contains(x.Id)).Count(x => x.IsDepositSettlement == false) == 0;
                    }
                    // verify if we can change the configuration 
                    if ((document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied && haveOnlyDepositInvoice == false)
                        || document.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied)
                    {
                        throw new CustomException(CustomStatusCode.PaymentHasAlreadyBeenDone);
                    }
                    List<DocumentWithholdingTaxViewModel> oldDocumentsWithholdingTax = document.DocumentWithholdingTax.ToList();
                    oldDocumentsWithholdingTax.ForEach(x => x.IdDocumentNavigation = null);
                    List<DocumentWithholdingTaxViewModel> documentsWithholdingTaxToSave = new List<DocumentWithholdingTaxViewModel>();
                    if (oldDocumentsWithholdingTax != null && oldDocumentsWithholdingTax.Any())
                    {
                        List<DocumentWithholdingTaxViewModel> deletedDocumentsWithholdingTax = oldDocumentsWithholdingTax.Except(model, new DocumentWithholdingTaxComparer()).ToList();

                        if (deletedDocumentsWithholdingTax != null && deletedDocumentsWithholdingTax.Any())
                        {
                            deletedDocumentsWithholdingTax.ToList().ForEach(x => { x.IsDeleted = true; });
                        }
                        documentsWithholdingTaxToSave.AddRange(deletedDocumentsWithholdingTax);
                        if (model.Count != 1 || model.First().IdWithholdingTax != 0)
                        {
                            // new elements
                            List<DocumentWithholdingTaxViewModel> addedDocumentsWithholdingTax = model.Except(oldDocumentsWithholdingTax, new DocumentWithholdingTaxComparer()).ToList();
                            documentsWithholdingTaxToSave.AddRange(addedDocumentsWithholdingTax);
                            // updated elements
                            List<DocumentWithholdingTaxViewModel> updatedDocumentsWithholdingTax = model.Except(addedDocumentsWithholdingTax, new DocumentWithholdingTaxComparer()).ToList();
                            updatedDocumentsWithholdingTax.ForEach(x =>
                            {
                                if (x.Id == 0)
                                {
                                    x.Id = oldDocumentsWithholdingTax.Where(y => y.IdWithholdingTax == x.IdWithholdingTax).FirstOrDefault().Id;
                                }
                            });
                            documentsWithholdingTaxToSave.AddRange(updatedDocumentsWithholdingTax);
                        }
                    }
                    else
                    {
                        documentsWithholdingTaxToSave.AddRange(model);
                    }

                    // Format amount
                    double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
                    int tiersPrecision = document.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? document.IdTiersNavigation.IdCurrencyNavigation.Precision :
                                         document.IdTiersNavigation.IdCurrencyNavigation.Precision;
                    int companyPrecision = document.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision :
                                          _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;
                    documentsWithholdingTaxToSave.ToList().ForEach(x =>
                    {
                        x.AmountWithCurrency = AmountMethods.FormatValue(x.AmountWithCurrency, tiersPrecision);
                        x.Amount = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? exchangeRate * x.AmountWithCurrency : x.AmountWithCurrency), companyPrecision);
                        x.WithholdingTaxWithCurrency = AmountMethods.FormatValue(x.WithholdingTaxWithCurrency, tiersPrecision);
                        x.WithholdingTax = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? exchangeRate * x.WithholdingTaxWithCurrency : x.WithholdingTaxWithCurrency), companyPrecision);
                        x.RemainingWithholdingTaxWithCurrency = x.WithholdingTaxWithCurrency;
                        x.RemainingWithholdingTax = x.WithholdingTax;
                    });
                    model.ForEach(x => {
                        x.IdDocumentNavigation = null;
                        if(x.IdWithholdingTaxNavigation != null)
                        {
                           x.IdWithholdingTaxNavigation.DocumentWithholdingTax = null;
                        }
                    });
                    if (documentsWithholdingTaxToSave != null && documentsWithholdingTaxToSave.Any() && documentsWithholdingTaxToSave.Where(x => x.IdWithholdingTax != 0).Any())
                    {
                        BulkUpdateModelWithoutTransaction(documentsWithholdingTaxToSave, userMail);
                    }
                    // Calculate Financial Commitment withholdingTax
                    document.DocumentWithholdingTax = documentsWithholdingTaxToSave.Where(x => !x.IsDeleted && x.IdWithholdingTax != 0).ToList();
                    _serviceFinancialCommitment.CalculateWithholdingTaxForFinancialCommitmentWithoutTransaction(document, exchangeRate, tiersPrecision, companyPrecision, userMail);

                    EndTransaction();
                }
                DocumentWithholdingTax entity = _builder.BuildModel(model.FirstOrDefault());
                return new CreatedDataViewModel { Id = (int)entity.Id };
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }
    }
}
