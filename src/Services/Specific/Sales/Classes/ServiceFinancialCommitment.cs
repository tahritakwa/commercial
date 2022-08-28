using Application.Services.Sales.Classes;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Strategy;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceFinancialCommitment : Service<FinancialCommitmentViewModel, FinancialCommitment>, IServiceFinancialCommitment
    {
        #region SettlementTypeStrategy        
        private static Dictionary<string, IFinancialCommitementDateStrategy> _settlementTypeStrategies =
        new Dictionary<string, IFinancialCommitementDateStrategy>
        {
            [SettlementTypeConstant.FinDeMois] = new FinDeMoisDateStrategy(),
            [SettlementTypeConstant.FinDeMoisLe] = new FinDeMoisLeDateStrategy(),
            [SettlementTypeConstant.NetLe] = new NetLeDateStrategy()
        };

        #endregion 
        internal readonly IRepository<User> _entityRepoUser;
        internal readonly IServiceCompany _serviceCompany;
        internal readonly IServiceCurrencyRate _serviceCurrencyRate;
        internal readonly IRepository<SettlementMode> _entityRepoSettlementMode;
        internal readonly IRepository<Currency> _entityRepoCurrency;
        internal readonly IRepository<SettlementType> _entityRepoSettlementType;
        internal readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        internal readonly IRepository<Document> _entitDocument;
        internal readonly IDocumentBuilder _documentBuilder;
        internal readonly IFinancialCommitmentBuilder _builder;
        internal readonly IRepository<Settlement> _entitySettlementRepo;

        public ServiceFinancialCommitment(IServiceCompany serviceCompany, IRepository<Currency> entityRepoCurrency, IRepository<SettlementType> entityRepoSettlementType,
            IRepository<SettlementMode> entityRepoSettlementMode, IRepository<FinancialCommitment> entityRepo,
            IUnitOfWork unitOfWork, IFinancialCommitmentBuilder builder, IDocumentBuilder documentBuilder,
            IRepository<User> entityRepoUser, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<DocumentType> entityDocumentTypeRepo, IRepository<Document> entitDocument, IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification, IServiceCurrencyRate serviceCurrencyRate, IRepository<Settlement> entitySettlementRepo)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
                 entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityRepoUser = entityRepoUser;
            _serviceCompany = serviceCompany;
            _serviceCurrencyRate = serviceCurrencyRate;
            _entityRepoSettlementMode = entityRepoSettlementMode;
            _entityRepoCurrency = entityRepoCurrency;
            _entityRepoSettlementType = entityRepoSettlementType;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _entitDocument = entitDocument;
            _documentBuilder = documentBuilder;
            _builder = builder;
            _entitySettlementRepo = entitySettlementRepo;
        }
        public ICollection<FinancialCommitmentViewModel> GenerateFinancialCommitment(DocumentViewModel document, DocumentType documentType)
        {
            if (documentType == null)
            {
                throw new ArgumentNullException(nameof(documentType));
            }
            double avance = 0;
            if (document != null && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null)
            {
                avance = (double)_entitDocument.FindSingleBy(x => x.Id == document.IdSalesDepositInvoice).DocumentTtcpriceWithCurrency;
            }
                List<FinancialCommitmentViewModel> financialsCommitments = new List<FinancialCommitmentViewModel>();
            FinancialCommitmentViewModel financialCommitment;
            //If document contains a SettlementMode that contains a details ==> fetch list of details and calculate  FinancialCommitment
            if (document != null && document.IdSettlementMode != null && document.IdSettlementMode != 0)
            {
                SettlementMode settlementMode = _entityRepoSettlementMode.GetSingleWithRelationsNotTracked(x => x.Id == document.IdSettlementMode, x => x.DetailsSettlementMode);
                if (settlementMode != null && settlementMode.DetailsSettlementMode != null && settlementMode.DetailsSettlementMode.Any())
                {
                    //Get default currency of company 

                    var company = _serviceCompany.GetCurrentCompany();
                    Currency currencyCompany = _entityRepoCurrency.FindBy(x => x.Id == company.IdCurrency.Value).FirstOrDefault();
                    int companyPrecision = currencyCompany.Precision;
                    //Get currency of document
                    Currency currencyDocument = _entityRepoCurrency.FindBy(x => x.Id == document.IdUsedCurrency.Value).FirstOrDefault();
                    int documentPrecision = currencyDocument.Precision;

                    foreach (DetailsSettlementMode detailSettlementMode in settlementMode.DetailsSettlementMode)
                    {
                        //Prepare FinancialCommitment entity
                        financialCommitment = new FinancialCommitmentViewModel
                        {
                            ////Affect status to financialCommitment entity
                            IdStatus = (int)DocumentStatusEnumerator.Valid,
                            // financialCommitment Direction
                            Direction = documentType.FinancialCommitmentDirection.Value,
                            //Affect DocumentTtcprice of docuement to financialCommitment entity
                            AllocatedAmount = 0,
                            //Affect DocumentTtcpriceWithCurrency of docuement to financialCommitment entity
                            AllocatedAmountWithCurrency = 0,
                            FinancialCommitmentDate = document.DocumentDate,
                            IdTiers = document.IdTiers,
                            IdCurrency = document.IdUsedCurrency
                        };
                        double percentOfAllocatedAmountWithCurrency = 0;
                        if (document != null && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null)
                        {
                            percentOfAllocatedAmountWithCurrency = (document.DocumentTtcpriceWithCurrency.Value - avance) * detailSettlementMode.Percentage.Value / 100;
                        }
                        else
                        {
                            percentOfAllocatedAmountWithCurrency = document.DocumentTtcpriceWithCurrency.Value * detailSettlementMode.Percentage.Value / 100;
                        }
                        if (document.IdUsedCurrency != null)
                        {
                            //Affect RemainingAmountWithCurrency to financialCommitment entity
                            financialCommitment.RemainingAmountWithCurrency = AmountMethods.FormatValue(percentOfAllocatedAmountWithCurrency, documentPrecision);
                            financialCommitment.AmountWithCurrency = AmountMethods.FormatValue(financialCommitment.RemainingAmountWithCurrency, documentPrecision);
                            financialCommitment.WithholdingTaxWithCurrency = 0;
                            financialCommitment.RemainingWithholdingTaxWithCurrency = 0;
                            financialCommitment.RemainingVatWithholdingTaxWithCurrency = 0;
                            financialCommitment.AmountWithoutWithholdingTaxWithCurrency = financialCommitment.AmountWithCurrency;
                        }
                        if (company.IdCurrency != null)
                        {
                            var precision = currencyCompany.Precision;
                            var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
                            financialCommitment.ExchangeRate = exchangeRate;
                            financialCommitment.RemainingAmount = Math.Round((exchangeRate != null && exchangeRate > 0) ? exchangeRate * financialCommitment.RemainingAmountWithCurrency.Value : financialCommitment.RemainingAmountWithCurrency.Value, precision);
                            financialCommitment.Amount = Math.Round((exchangeRate != null && exchangeRate > 0) ? exchangeRate * financialCommitment.AmountWithCurrency.Value : financialCommitment.AmountWithCurrency.Value, precision);
                            financialCommitment.WithholdingTax = 0;
                            financialCommitment.RemainingWithholdingTax = 0;
                            financialCommitment.RemainingVatWithholdingTax = 0;
                            financialCommitment.AmountWithoutWithholdingTax = financialCommitment.Amount;
                        }
                        //Affect IdPaymentMethod of DetailsSettlementMode to financialCommitment entity
                        financialCommitment.IdPaymentMethod = detailSettlementMode.IdPaymentMethod;
                        if (detailSettlementMode.IdSettlementType != null && document.DocumentDate != default(DateTime))
                        {
                            //Get settlement type 
                            SettlementType settlementType = _entityRepoSettlementType.FindBy(x => x.Id == detailSettlementMode.IdSettlementType.Value).FirstOrDefault();
                            //Switch type of settlement to affect CommitmentDate
                            if (settlementType != null)
                            {
                                int nbOfDaysToAdd = 0;
                                financialCommitment.CommitmentDate = document.DocumentDate.Date;
                                if (settlementType.Code != SettlementTypeConstant.Comptant)
                                {
                                    if (detailSettlementMode.NumberDays != null)
                                    {
                                        nbOfDaysToAdd = nbOfDaysToAdd + detailSettlementMode.NumberDays.Value;
                                    }
                                    financialCommitment.CommitmentDate = document.DocumentDate.Date.AddDays(nbOfDaysToAdd);
                                }
                                if (_settlementTypeStrategies.ContainsKey(settlementType.Code))
                                {
                                    _settlementTypeStrategies[settlementType.Code].SetFcDate(financialCommitment, detailSettlementMode.SettlementDay);
                                }
                                financialCommitment.BenefitPeriod = Convert.ToInt32((financialCommitment.CommitmentDate - document.DocumentDate.Date).TotalDays);
                            }
                        }
                        financialsCommitments.Add(financialCommitment);
                    }
                    // adjust the amount for the last financial commitment
                    FinancialCommitmentViewModel lastFinancialCommitment = financialsCommitments.Last();
                    financialsCommitments.RemoveAt(financialsCommitments.IndexOf(lastFinancialCommitment));
                    //Affect RemainingAmountWithCurrency to financialCommitment entity
                    if (document != null && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null)
                    {
                        lastFinancialCommitment.RemainingAmountWithCurrency = AmountMethods.FormatValue(document.DocumentTtcpriceWithCurrency.Value - avance -
                        financialsCommitments.Sum(p => p.RemainingAmountWithCurrency), documentPrecision);
                    }
                    else
                    {
                        lastFinancialCommitment.RemainingAmountWithCurrency = AmountMethods.FormatValue(document.DocumentTtcpriceWithCurrency.Value -
                        financialsCommitments.Sum(p => p.RemainingAmountWithCurrency), documentPrecision);
                    }
                    lastFinancialCommitment.AmountWithCurrency = AmountMethods.FormatValue(lastFinancialCommitment.RemainingAmountWithCurrency, documentPrecision);
                    if (document != null && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null)
                    {
                        lastFinancialCommitment.RemainingAmount = AmountMethods.FormatValue((document.DocumentTtcprice != null ? (document.DocumentTtcprice.Value - avance) : (document.DocumentTtcpriceWithCurrency.Value - avance) * document.ExchangeRate) -
                        financialsCommitments.Sum(p => p.RemainingAmount), companyPrecision);
                    }
                    else
                    {
                        lastFinancialCommitment.RemainingAmount = AmountMethods.FormatValue((document.DocumentTtcprice != null ? document.DocumentTtcprice.Value : document.DocumentTtcpriceWithCurrency.Value * document.ExchangeRate) -
                       financialsCommitments.Sum(p => p.RemainingAmount), companyPrecision);
                    }
                    lastFinancialCommitment.Amount = AmountMethods.FormatValue(lastFinancialCommitment.RemainingAmount, companyPrecision);
                    lastFinancialCommitment.WithholdingTax = 0;
                    lastFinancialCommitment.RemainingWithholdingTax = 0;
                    lastFinancialCommitment.RemainingVatWithholdingTax = 0;
                    lastFinancialCommitment.AmountWithoutWithholdingTax = lastFinancialCommitment.Amount;
                    lastFinancialCommitment.WithholdingTaxWithCurrency = 0;
                    lastFinancialCommitment.RemainingWithholdingTaxWithCurrency = 0;
                    lastFinancialCommitment.RemainingVatWithholdingTaxWithCurrency = 0;
                    lastFinancialCommitment.AmountWithoutWithholdingTaxWithCurrency = lastFinancialCommitment.AmountWithCurrency;
                    financialsCommitments.Add(lastFinancialCommitment);
                }
            }
            return financialsCommitments;
        }


        public void CalculateWithholdingTaxForFinancialCommitmentWithoutTransaction(DocumentViewModel document, double exchangeRate, int tiersPrecision, int companyPrecision, string userMail)
        {
            double totalTTCWithholdingTaxWithCurrency = Math.Round(document.DocumentWithholdingTax.Where(x => x.IdWithholdingTaxNavigation.Type == (int)WithholdingTaxType.Ttc).Sum(x => x.WithholdingTaxWithCurrency), tiersPrecision);
            double totalVATWithholdingTaxWithCurrency = Math.Round(document.DocumentWithholdingTax.Where(x => x.IdWithholdingTaxNavigation.Type == (int)WithholdingTaxType.Vat).Sum(x => x.WithholdingTaxWithCurrency), tiersPrecision);
            double totalWithholdingTaxWithCurrency = Math.Round(document.DocumentWithholdingTax.Sum(x => x.WithholdingTaxWithCurrency), tiersPrecision);
            double traitedWithoholdingTaxWithCurrency = 0;
            double traitedTtcWithoholdingTaxWithCurrency = 0;
            double traitedVatWithoholdingTaxWithCurrency = 0;
            IList<FinancialCommitmentViewModel> financialCommitments = document.FinancialCommitment.ToList();
            if (financialCommitments.Count > 1)
            {
                foreach (FinancialCommitmentViewModel financialCommitment in financialCommitments.SkipLast(1))
                {
                    double paymentPourcentage = Math.Round((financialCommitment.AmountWithCurrency.Value / document.DocumentTtcpriceWithCurrency.Value), tiersPrecision);
                    double TtcwithholdingTaxRelatedToFinancialCommitment = Math.Round((totalTTCWithholdingTaxWithCurrency * paymentPourcentage), tiersPrecision);
                    double VatwithholdingTaxRelatedToFinancialCommitment = Math.Round((totalVATWithholdingTaxWithCurrency * paymentPourcentage), tiersPrecision);
                    double withholdingTaxRelatedToFinancialCommitment = Math.Round((TtcwithholdingTaxRelatedToFinancialCommitment + VatwithholdingTaxRelatedToFinancialCommitment), tiersPrecision);
                    financialCommitment.WithholdingTaxWithCurrency = TtcwithholdingTaxRelatedToFinancialCommitment + VatwithholdingTaxRelatedToFinancialCommitment;
                    financialCommitment.WithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? (TtcwithholdingTaxRelatedToFinancialCommitment + VatwithholdingTaxRelatedToFinancialCommitment) * exchangeRate : TtcwithholdingTaxRelatedToFinancialCommitment + VatwithholdingTaxRelatedToFinancialCommitment), companyPrecision);
                    financialCommitment.TtcWithholdingTaxWithCurrency = TtcwithholdingTaxRelatedToFinancialCommitment;
                    financialCommitment.TtcWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? TtcwithholdingTaxRelatedToFinancialCommitment * exchangeRate : TtcwithholdingTaxRelatedToFinancialCommitment), companyPrecision);
                    financialCommitment.VatWithholdingTaxWithCurrency = VatwithholdingTaxRelatedToFinancialCommitment;
                    financialCommitment.VatWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? VatwithholdingTaxRelatedToFinancialCommitment * exchangeRate : VatwithholdingTaxRelatedToFinancialCommitment), companyPrecision);
                    financialCommitment.RemainingWithholdingTaxWithCurrency = financialCommitment.TtcWithholdingTaxWithCurrency;
                    financialCommitment.RemainingWithholdingTax = financialCommitment.TtcWithholdingTax;
                    financialCommitment.RemainingVatWithholdingTaxWithCurrency = financialCommitment.VatWithholdingTaxWithCurrency;
                    financialCommitment.RemainingVatWithholdingTax = financialCommitment.VatWithholdingTax;
                    financialCommitment.AmountWithoutWithholdingTaxWithCurrency = Math.Round((financialCommitment.AmountWithCurrency.Value - withholdingTaxRelatedToFinancialCommitment), tiersPrecision);
                    financialCommitment.AmountWithoutWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? financialCommitment.AmountWithoutWithholdingTaxWithCurrency.Value * exchangeRate : financialCommitment.AmountWithoutWithholdingTaxWithCurrency.Value), companyPrecision);
                    financialCommitment.RemainingAmountWithCurrency = Math.Round((financialCommitment.AmountWithoutWithholdingTaxWithCurrency.Value), tiersPrecision);
                    financialCommitment.RemainingAmount = Math.Round(((exchangeRate != null && exchangeRate > 0) ? financialCommitment.RemainingAmountWithCurrency.Value * exchangeRate : financialCommitment.RemainingAmountWithCurrency.Value), companyPrecision);
                    traitedWithoholdingTaxWithCurrency = Math.Round((traitedWithoholdingTaxWithCurrency + withholdingTaxRelatedToFinancialCommitment), tiersPrecision);
                    traitedTtcWithoholdingTaxWithCurrency = Math.Round((traitedTtcWithoholdingTaxWithCurrency + TtcwithholdingTaxRelatedToFinancialCommitment), tiersPrecision);
                    traitedVatWithoholdingTaxWithCurrency = Math.Round((traitedVatWithoholdingTaxWithCurrency + VatwithholdingTaxRelatedToFinancialCommitment), tiersPrecision);
                }
            }
            FinancialCommitmentViewModel lastFinancialCommitment = financialCommitments.Last();
            double lastTtcWithholdingTaxWithCurrency = Math.Round((totalTTCWithholdingTaxWithCurrency - traitedTtcWithoholdingTaxWithCurrency), tiersPrecision);
            double lastVatWithholdingTaxWithCurrency = Math.Round((totalVATWithholdingTaxWithCurrency - traitedVatWithoholdingTaxWithCurrency), tiersPrecision);
            double lastWithholdingTaxWithCurrency = Math.Round((totalWithholdingTaxWithCurrency - traitedWithoholdingTaxWithCurrency), tiersPrecision);
            lastFinancialCommitment.WithholdingTaxWithCurrency = lastWithholdingTaxWithCurrency;
            lastFinancialCommitment.WithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? lastWithholdingTaxWithCurrency * exchangeRate : lastWithholdingTaxWithCurrency), companyPrecision);
            lastFinancialCommitment.TtcWithholdingTaxWithCurrency = lastTtcWithholdingTaxWithCurrency;
            lastFinancialCommitment.TtcWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? lastTtcWithholdingTaxWithCurrency * exchangeRate : lastTtcWithholdingTaxWithCurrency), companyPrecision);
            lastFinancialCommitment.VatWithholdingTaxWithCurrency = lastVatWithholdingTaxWithCurrency;
            lastFinancialCommitment.VatWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? lastVatWithholdingTaxWithCurrency * exchangeRate : lastVatWithholdingTaxWithCurrency), companyPrecision);
            lastFinancialCommitment.RemainingWithholdingTaxWithCurrency = lastFinancialCommitment.TtcWithholdingTaxWithCurrency;
            lastFinancialCommitment.RemainingWithholdingTax = lastFinancialCommitment.TtcWithholdingTax;
            lastFinancialCommitment.RemainingVatWithholdingTaxWithCurrency = lastFinancialCommitment.VatWithholdingTaxWithCurrency;
            lastFinancialCommitment.RemainingVatWithholdingTax = lastFinancialCommitment.VatWithholdingTax;
            lastFinancialCommitment.AmountWithoutWithholdingTaxWithCurrency = Math.Round((lastFinancialCommitment.AmountWithCurrency.Value - lastWithholdingTaxWithCurrency), tiersPrecision);
            lastFinancialCommitment.AmountWithoutWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? lastFinancialCommitment.AmountWithoutWithholdingTax.Value * exchangeRate : lastFinancialCommitment.AmountWithoutWithholdingTax.Value), companyPrecision);
            lastFinancialCommitment.RemainingAmountWithCurrency = Math.Round((lastFinancialCommitment.AmountWithoutWithholdingTaxWithCurrency.Value), tiersPrecision);
            lastFinancialCommitment.RemainingAmount = Math.Round(((exchangeRate != null && exchangeRate > 0) ? lastFinancialCommitment.RemainingAmountWithCurrency.Value * exchangeRate : lastFinancialCommitment.RemainingAmountWithCurrency.Value), companyPrecision);
            BulkUpdateModelWithoutTransaction(financialCommitments, userMail);
            _unitOfWork.Commit();
        }


        public ICollection<FinancialCommitmentViewModel> GetFinancialCommitmentOfCurrentDocument(int idDocument)
        {
            ICollection<FinancialCommitmentViewModel> financialCommitments = GetModelsWithConditionsRelations(p => p.IdDocument == idDocument,
                 x => x.IdTiersNavigation, x => x.IdCurrencyNavigation).ToList();
            if (financialCommitments != null && financialCommitments.Any())
            {
                TiersViewModel tiers = financialCommitments.ElementAt(0).IdTiersNavigation;
                CurrencyViewModel currency = financialCommitments.ElementAt(0).IdCurrencyNavigation;
                int precision = tiers.IdTypeTiers == (int)TiersType.Customer ? currency.Precision : currency.Precision;
                financialCommitments.ToList().ForEach(
                  x =>
                  {
                      if (x.WithholdingTaxWithCurrency.HasValue && x.RemainingWithholdingTaxWithCurrency.HasValue)
                      {
                          x.PaidWithholdingTaxWithCurrency = Math.Round((x.WithholdingTaxWithCurrency.Value - x.RemainingWithholdingTaxWithCurrency.Value), precision);
                      }
                  }
                );
            }
            return financialCommitments;
        }

        public void UpdateAffectedFinancialCommitment(IList<FinancialCommitmentViewModel> financialCommitments, int precision, double exchangeRate,
            SettlementViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            if (financialCommitments == null)
            {
                throw new ArgumentNullException(nameof(financialCommitments));
            }
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            var company = _serviceCompany.GetCurrentCompany();
            Currency currencyCompany = _entityRepoCurrency.FindBy(x => x.Id == company.IdCurrency.Value).FirstOrDefault();
            int companyPrecision = (financialCommitments.FirstOrDefault().Direction == (int)PaymentDirectionEnumerator.IncomingSettlement) ?
                currencyCompany.Precision : currencyCompany.Precision;

            //recalculate financial commitment remaining amount && assign financial commitment to settlement
            foreach (FinancialCommitmentViewModel financialCommitment in financialCommitments)
            {
                if (!financialCommitment.AllocatedAmountWithCurrency.Value.IsApproximately(0, within: 0.0001))
                {
                    FinancialCommitmentViewModel originFinancialCommitment =
                    GetModelAsNoTracked(p => p.Id == financialCommitment.Id);
                    // calculate financialcommitment remaining amount 
                    financialCommitment.AmountWithCurrency = AmountMethods.FormatValue(originFinancialCommitment.AmountWithCurrency.Value, precision);
                    financialCommitment.Amount = AmountMethods.
                        FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * financialCommitment.AmountWithCurrency : financialCommitment.AmountWithCurrency, companyPrecision);
                    // allocated amount is greater than remaining amount => custom exception
                    if (originFinancialCommitment.RemainingAmountWithCurrency.Value.CompareTo(financialCommitment.AllocatedAmountWithCurrency.Value) < 0)
                    {
                        throw new CustomException(CustomStatusCode.FinancialCommitmentAllocatedAmountGreaterThanRemaining);
                    }
                    financialCommitment.RemainingAmountWithCurrency = AmountMethods.
                        FormatValue(originFinancialCommitment.RemainingAmountWithCurrency.Value - financialCommitment.AllocatedAmountWithCurrency.Value, precision);
                    financialCommitment.RemainingAmount = AmountMethods.
                        FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * financialCommitment.RemainingAmountWithCurrency.Value : financialCommitment.RemainingAmountWithCurrency.Value, companyPrecision);
                    financialCommitment.IdStatus = (int)(financialCommitment.RemainingAmountWithCurrency.Value.IsApproximately(0, within: 0.0001) ?
                        DocumentStatusEnumerator.TotallySatisfied : DocumentStatusEnumerator.PartiallySatisfied);
                    UpdateModelWithoutTransaction(financialCommitment, entityAxisValuesModelList, userMail);
                    //assign financial commitment to settlement
                    SettlementCommitmentViewModel settlementCommitmentViewModel = new SettlementCommitmentViewModel
                    {
                        AssignedAmountWithCurrency = AmountMethods.FormatValue(financialCommitment.AllocatedAmountWithCurrency.Value, precision),
                        SettlementId = 0,
                        CommitmentId = financialCommitment.Id
                    };
                    settlementCommitmentViewModel.AssignedAmount = (exchangeRate != null && exchangeRate > 0) ? exchangeRate * settlementCommitmentViewModel.AssignedAmountWithCurrency: settlementCommitmentViewModel.AssignedAmountWithCurrency;
                    model.SettlementCommitment.Add(settlementCommitmentViewModel);
                }
            }
        }

        public ICollection<FinancialCommitmentViewModel> UpdateFinancialCommitment(DocumentViewModel document, DocumentViewModel oldDocument, string userMail)
        {
            ICollection<FinancialCommitmentViewModel> financialsCommitments = new List<FinancialCommitmentViewModel>();
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
            if (oldDocument.IdSettlementMode == null)
            {
                //Generate settlement
                financialsCommitments = GenerateFinancialCommitment(document, documentType);
            }
            else if (document.IdSettlementMode == null || oldDocument.IdSettlementMode != document.IdSettlementMode)
            {
                //Delete list of settlement
                ICollection<FinancialCommitment> listOfFinancialCommitment = _entityRepo.GetAllWithConditionsRelations(x => x.IdDocument == document.Id).ToList();
                foreach (FinancialCommitment financialCommitment in listOfFinancialCommitment)
                {
                    financialCommitment.IsDeleted = true;
                    _entityRepo.Update(financialCommitment);
                }
                if (oldDocument.IdSettlementMode != document.IdSettlementMode)
                {
                    //Regenerate settlement
                    financialsCommitments = GenerateFinancialCommitment(document, documentType);
                }
            }
            return financialsCommitments;
        }

        public bool isDcoumentHaveOnlyDepositSettlement(int idDoc)
        {
            List<SettlementCommitment> settlementCommitments = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocument == idDoc &&(x.IdStatus == (int)DocumentStatusEnumerator.TotallySatisfied || x.IdStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
            , z => z.SettlementCommitment).SelectMany(y => y.SettlementCommitment).ToList();
            List<int> idsSettlement = settlementCommitments.Select(x => x.SettlementId).ToList();
            return _entitySettlementRepo.GetAllWithConditionsRelationsAsNoTracking(x => idsSettlement.Contains(x.Id)).Count(x => x.IsDepositSettlement == false) == 0;
        }


    }
}
