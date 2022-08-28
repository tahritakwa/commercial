using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Treasury.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Utils.Constants;
using System.Threading;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Reporting.Treasury;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Reporting;
using ViewModels.Builders.Specific.Treasury.Interfaces;

namespace Services.Reporting.Classes
{
    public class TreasuryServiceReporting : ITreasuryServiceReporting
    {
        public const string TOTAL_GENERAL = "TOTAL GENERAL";
        #region Fields
        private readonly IServiceSettlementDocumentWithholdingTax _serviceSettlementDocumentWithholdingTax;
        private readonly IServicePaymentSlip _servicePaymentSlip;
        private readonly IServiceWithholdingTax _serviceWithholdingTax;
        private readonly IRepository<Settlement> _entityRepoSettlement;
        private readonly IServiceTicket _serviceTicket;
        private readonly IRepository<Ticket> _entityRepoTicket;
        private readonly ITicketBuilder _builderTicket;
        private readonly IRepository<TicketPayment> _repoTicketPayment;
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<BankAccount> _repoBankAccount;
        private readonly IServiceSessionCash _serviceSessionCash;
        private readonly IRepository<Company> _entityRepoCompany;
        #endregion
        #region Constructor
        public TreasuryServiceReporting(IServiceSettlementDocumentWithholdingTax serviceSettlementDocumentWithholdingTax,
            IServiceWithholdingTax serviceWithholdingTax, IRepository<Settlement> entityRepoSettlement, IServiceCompany serviceCompany,
            IServiceDocumentWithholdingTax serviceDocumentWithholdingTax, IServicePaymentSlip servicePaymentSlip, IRepository<BankAccount> repoBankAccount,
            IServiceTicket serviceTicket, IRepository<Ticket> entityRepoTicket, ITicketBuilder builderTicket, IRepository<TicketPayment> repoTicketPayment, IServiceSessionCash serviceSessionCash, IRepository<Company> entityRepoCompany)
        {
            _serviceSettlementDocumentWithholdingTax = serviceSettlementDocumentWithholdingTax;
            _serviceWithholdingTax = serviceWithholdingTax;
            _entityRepoSettlement = entityRepoSettlement;
            _serviceCompany = serviceCompany;
            _servicePaymentSlip = servicePaymentSlip;
            _repoBankAccount = repoBankAccount;
            _serviceTicket = serviceTicket;
            _repoTicketPayment = repoTicketPayment;
            _serviceSessionCash = serviceSessionCash;
            _entityRepoTicket = entityRepoTicket;
            _builderTicket = builderTicket;
           _entityRepoCompany = entityRepoCompany;
        }

        #endregion
        #region Methodes
        public WithholdingTaxReportInfoViewModel GetSettlementInfos(int idSettlement)
        {
            WithholdingTaxReportInfoViewModel WithholdingTaxReportInfo = new WithholdingTaxReportInfoViewModel();
            Settlement settlement = _entityRepoSettlement.GetAllWithConditionsQueryable(x => x.Id == idSettlement)
                                    .Include(x => x.IdTiersNavigation).ThenInclude(x=>x.Address)
                                    .Include(x => x.SettlementDocumentWithholdingTax)
                                    .ThenInclude(x => x.IdDocumentWithholdingTaxNavigation)
                                     .ThenInclude(x => x.IdDocumentNavigation)
                                    .FirstOrDefault();
            WithholdingTaxReportInfo.Date = settlement.SettlementDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language);
            WithholdingTaxReportInfo.Code = settlement.Code;
            WithholdingTaxReportInfo.Year = settlement.SettlementDate.Year;
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            string addressCompany = company.Address != null && company.Address.Any() ?
                company.Address.FirstOrDefault().PrincipalAddress : string.Empty;
            string adressTiers = settlement.IdTiersNavigation.Address != null && settlement.IdTiersNavigation.Address.Any() ?
                settlement.IdTiersNavigation.Address.FirstOrDefault().PrincipalAddress : string.Empty;
            bool isSales = settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? true : false;
            // PayingAgency
            TiersWithholdingTaxViewModel payingAgency = new TiersWithholdingTaxViewModel();
            payingAgency.Name = isSales ? settlement.IdTiersNavigation.Name : company.Name;
            payingAgency.MatriculeFisc = isSales ?
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(0, settlement.IdTiersNavigation.MatriculeFiscale.Length - 5)
                : company.MatriculeFisc.Substring(0, company.MatriculeFisc.Length - 5);
            payingAgency.Category = isSales ?
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 4, 1)
                : company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 4, 1);
            payingAgency.VatNumber = isSales ?
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 5, 1)
                : company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 5, 1);
            payingAgency.Adress = isSales ? adressTiers : addressCompany;
            payingAgency.SecondaryEstablishment = isSales ?
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 3)
                : company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 3);
            WithholdingTaxReportInfo.PayingAgency = payingAgency;
            // Beneficiary
            TiersWithholdingTaxViewModel beneficiary = new TiersWithholdingTaxViewModel();
            beneficiary.Name = isSales ? company.Name : settlement.IdTiersNavigation.Name;
            beneficiary.MatriculeFisc = isSales ? company.MatriculeFisc.Substring(0, company.MatriculeFisc.Length - 5) :
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(0, settlement.IdTiersNavigation.MatriculeFiscale.Length - 5);
            beneficiary.Category = isSales ? company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 4, 1) :
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 4, 1)
                ;
            beneficiary.VatNumber = isSales ?
                company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 5, 1) :
                  settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 5, 1);
            beneficiary.Adress = isSales ? addressCompany : adressTiers;
            beneficiary.SecondaryEstablishment = isSales ? company.MatriculeFisc.Substring(company.MatriculeFisc.Length - 3) :
                settlement.IdTiersNavigation.MatriculeFiscale.Substring(settlement.IdTiersNavigation.MatriculeFiscale.Length - 3)
                ;
            WithholdingTaxReportInfo.Beneficiary = beneficiary;
            // Invoices Code 
            StringBuilder strBuilder = new StringBuilder();
            List<Document> documentsList = settlement.SettlementDocumentWithholdingTax.Select(x => x.IdDocumentWithholdingTaxNavigation.IdDocumentNavigation)
                .Distinct().ToList();
            foreach (Document document in documentsList)
            {
                strBuilder.Append(document.Code);
                strBuilder.Append(", ");
            }
            if (documentsList.Count > 0)
            {
                WithholdingTaxReportInfo.InvoicesCodes = strBuilder.ToString().Substring(0, strBuilder.ToString().Length - 2);
            }
            return WithholdingTaxReportInfo;
        }

        public List<SettlementWithholdingTaxViewModel> GetSettlementWithholdingTax(int idSettlement)
        {
            List<SettlementWithholdingTaxViewModel> settlementWithholdingTaxes = new List<SettlementWithholdingTaxViewModel>();
            Settlement settlement = _entityRepoSettlement.GetSingleWithRelationsNotTracked(x => x.Id == idSettlement,
                x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation);
            int tiersPrecision = settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? settlement.IdUsedCurrencyNavigation.Precision :
                settlement.IdUsedCurrencyNavigation.Precision;
            var precisionFormat = string.Concat(Enumerable.Repeat('0', tiersPrecision));
            var stringFormat = string.Concat("{0:0.", precisionFormat, "}");

            var SettlementsDocumentWithholdingTax = _serviceSettlementDocumentWithholdingTax.FindModelsByNoTracked(x => x.IdSettlement == idSettlement, x => x.IdDocumentWithholdingTaxNavigation)
             .GroupBy(x => x.IdDocumentWithholdingTaxNavigation.IdWithholdingTax).ToDictionary(group => group.Key, group => group.ToList());
            IList<WithholdingTaxViewModel> withholdingTaxes = _serviceWithholdingTax.GetAllModels().ToList();
            double totalAmountTTC = 0;
            double totalWithholdingTax = 0;
            withholdingTaxes.ToList().ForEach(
            x =>
            {
                if (x.Percentage > 0)
                {
                    var withholdingTaxe = new SettlementWithholdingTaxViewModel();
                    withholdingTaxe.WithholdingTaxConfigName = x.Designation;
                    // if it exist in dictionnary so calculate amounts 
                    if (SettlementsDocumentWithholdingTax.ContainsKey(x.Id))
                    {
                        var totalAmount = SettlementsDocumentWithholdingTax[x.Id].Sum(y => y.TotalAmountWithCurrency);
                        withholdingTaxe.TotalAmount = string.Concat(string.Format(CultureInfo.InvariantCulture, stringFormat, totalAmount)
                            , ' ', settlement.IdUsedCurrencyNavigation.Code);
                        totalAmountTTC += totalAmount;
                        var withholdingTaxAmount = SettlementsDocumentWithholdingTax[x.Id].Sum(y => y.AssignedWithholdingTaxWithCurrency);
                        withholdingTaxe.WithholdingTaxAmount = string.Concat(string.Format(CultureInfo.InvariantCulture, stringFormat, withholdingTaxAmount)
                            , ' ', settlement.IdUsedCurrencyNavigation.Code);
                        totalWithholdingTax += withholdingTaxAmount;
                        var PaidAmount = string.Format(CultureInfo.InvariantCulture, stringFormat, Math.Round((totalAmount - withholdingTaxAmount), tiersPrecision));
                        withholdingTaxe.PaidAmount = string.Concat(PaidAmount, ' ', settlement.IdUsedCurrencyNavigation.Code);
                    }
                    settlementWithholdingTaxes.Add(withholdingTaxe);
                }
            });
            // the last line will be the totals of the amounts
            var lastLineWithholdingTax = new SettlementWithholdingTaxViewModel();
            lastLineWithholdingTax.WithholdingTaxConfigName = TOTAL_GENERAL;

            var lastLineTotalAmount = string.Format(CultureInfo.InvariantCulture, stringFormat,
                Math.Round(totalAmountTTC, tiersPrecision));
            lastLineWithholdingTax.TotalAmount = string.Concat(lastLineTotalAmount, ' ', settlement.IdUsedCurrencyNavigation.Code);

            var lastLineWithholdingTaxAmount = string.Format(CultureInfo.InvariantCulture, stringFormat,
                Math.Round(totalWithholdingTax, tiersPrecision));
            lastLineWithholdingTax.WithholdingTaxAmount = string.Concat(lastLineWithholdingTaxAmount, ' ', settlement.IdUsedCurrencyNavigation.Code);

            var lastLinePaidAmount = string.Format(CultureInfo.InvariantCulture, stringFormat,
                Math.Round((totalAmountTTC - totalWithholdingTax), tiersPrecision));
            lastLineWithholdingTax.PaidAmount = string.Concat(lastLinePaidAmount, ' ', settlement.IdUsedCurrencyNavigation.Code);

            settlementWithholdingTaxes.Add(lastLineWithholdingTax);
            return settlementWithholdingTaxes;
        }

        public PaymentSlipReportInfoViewModel GetPaymentSlipDetails(int idPaymentSlip)
        {
            PaymentSlipViewModel paymentSlip = _servicePaymentSlip.GetModelWithRelations(x => x.Id == idPaymentSlip, x => x.IdBankAccountNavigation,
                x => x.Settlement);
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            PaymentSlipReportInfoViewModel paymentSlipReportInfo = new PaymentSlipReportInfoViewModel();
            paymentSlipReportInfo.Reference = paymentSlip.Reference;
            paymentSlipReportInfo.Agency = paymentSlip.Agency != null ? paymentSlip.Agency : paymentSlip.IdBankAccountNavigation.Agency;
            paymentSlipReportInfo.SocialReason = paymentSlip.Deposer != null ? paymentSlip.Deposer : company.Name;
            paymentSlipReportInfo.PaymentSlipDate = paymentSlip.Date.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language);
            paymentSlipReportInfo.RIB = paymentSlip.IdBankAccountNavigation.Rib;
            paymentSlipReportInfo.NumberOfSettlement = paymentSlip.Settlement.Count;
            paymentSlipReportInfo.TotalAmountWithLetters = paymentSlip.TotalAmountWithLetters;
            paymentSlipReportInfo.TotalAmountWithNumbers = paymentSlip.TotalAmountWithNumbers.Value;
            return paymentSlipReportInfo;
        }

        public List<CheckInfoViewModel> GetCheckInfo(int idPaymentSlip)
        {
            int counter = 1;
            List<CheckInfoViewModel> result = new List<CheckInfoViewModel>();
            PaymentSlipViewModel paymentSlip = _servicePaymentSlip.GetModelWithRelations(x => x.Id == idPaymentSlip, x => x.Settlement);
            int precision = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;
            var stringFormat = string.Concat("{0:0.", precision, "}");
            paymentSlip.Settlement.ToList().ForEach(x =>
            {
                var checkInfo = new CheckInfoViewModel();
                checkInfo.CheckNumber = x.SettlementReference;
                checkInfo.Amount = string.Format(CultureInfo.InvariantCulture, stringFormat, x.Amount.Value);
                checkInfo.Bank = x.IssuingBank;
                checkInfo.Holder = x.Holder;
                checkInfo.Number = counter;
                result.Add(checkInfo);
                counter++;
            });
            return result;
        }

        public List<DraftInfoViewModel> GetDraftInfo(int idPaymentSlip)
        {
            int counter = 1;
            List<DraftInfoViewModel> result = new List<DraftInfoViewModel>();
            PaymentSlipViewModel paymentSlip = _servicePaymentSlip.GetModelWithRelations(x => x.Id == idPaymentSlip, x => x.Settlement);
            int precision = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;
            var stringFormat = string.Concat("{0:0.", precision, "}");
            paymentSlip.Settlement.ToList().ForEach(x =>
            {
                DraftInfoViewModel draftInfo = new DraftInfoViewModel();
                draftInfo.DraftNumber = x.SettlementReference;
                draftInfo.Amount = string.Format(CultureInfo.InvariantCulture, stringFormat, x.Amount.Value);
                draftInfo.Bank = x.IssuingBank;
                draftInfo.Holder = x.Holder;
                draftInfo.Number = counter;
                draftInfo.CommmitmentDate = x.CommitmentDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language);
                result.Add(draftInfo);
                counter++;
            });
            return result;
        }

        public SettlementInformationViewModel GetSettlementInformation(int idSettlement)
        {
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            Settlement settlementInfo = _entityRepoSettlement.GetAllWithConditionsQueryable(x => x.Id == idSettlement).Include(x => x.IdTiersNavigation).
                Include(x => x.IdPaymentMethodNavigation).Include(x => x.IdUsedCurrencyNavigation).FirstOrDefault();
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            int currency = 0;
            
            if (settlementInfo != null)
            {
                if (currency == 0)
                {
                    currency = settlementInfo.IdUsedCurrencyNavigation != null ?
                   settlementInfo.IdUsedCurrencyNavigation.Precision : settlementInfo.IdUsedCurrencyNavigation.Precision;

                }
                SettlementInformationViewModel settlement = new SettlementInformationViewModel()
                {
                    Code = settlementInfo.Code,
                    Client = settlementInfo.IdTiersNavigation.Name,
                    TotalAmount = CurrencyUtility.GenerateCurrencyByCulture(settlementInfo.AmountWithCurrency, currency, "", company.Culture),
                    Date = settlementInfo.SettlementDate.Date.ToString("dd-MM-yyyy"),
                    SettlementMode = settlementInfo.IdPaymentMethodNavigation.MethodName,
                    StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                    StarkLogo = _serviceCompany.GetStarkLogo(),
                    CurrencyCode = settlementInfo.IdUsedCurrencyNavigation.Code,
                    SettlementTitleFR = settlementInfo.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? "Réglement Client" : "Réglement Fournisseur",
                    SettlementTitleEN = settlementInfo.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? "Customer Settlement" : "Supplier Settlement",
                    Company = companyReportingViewModel,
                    BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                    Rib = bankAccount != null ? bankAccount.Rib : string.Empty
                };
                return settlement;
            }
            else
            {
                return null;
            }


        }

        public List<SettlementDataViewModel> GetSettlementData(int idSettlement)
        {
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            Settlement settlementData = _entityRepoSettlement.GetAllWithConditionsQueryable(x => x.Id == idSettlement)
                                    .Include(x => x.SettlementDocumentWithholdingTax)
                                    .ThenInclude(x => x.IdDocumentWithholdingTaxNavigation)
                                    .ThenInclude(x => x.IdDocumentNavigation).Include(x => x.SettlementCommitment).ThenInclude(x => x.Commitment).ThenInclude(x => x.IdDocumentNavigation)
                                    .Include(x => x.SettlementCommitment).ThenInclude(x => x.Commitment).ThenInclude(x => x.IdCurrencyNavigation)
                                    .FirstOrDefault();
            int currency = 0;
            if (settlementData != null)
            {
                List<SettlementDataViewModel> settlements = new List<SettlementDataViewModel>();
                settlementData.SettlementCommitment.ToList().ForEach(p =>
                {
                    if (currency == 0)
                    {
                        currency = p.Commitment.IdDocumentNavigation.IdUsedCurrencyNavigation != null?
                       p.Commitment.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision : p.Commitment.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision;

                    }
                  
                    SettlementDataViewModel settlement = new SettlementDataViewModel()
                    {
                        Type = (p.Commitment.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice ||
                         p.Commitment.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) ? "Facture" : "Avoir",
                        InvoiceCode = p.Commitment.IdDocumentNavigation.Code,
                        DeadlineCode = p.Commitment.Code,
                        DeadlineDate = p.Commitment.CommitmentDate.Date.ToString("dd-MM-yyyy"),
                        TotalAmount = CurrencyUtility.GenerateCurrencyByCulture(p.Commitment.AmountWithCurrency.Value, currency,"", company.Culture),
                        AssignedAmount = CurrencyUtility.GenerateCurrencyByCulture(p.AssignedAmountWithCurrency.Value, currency, "", company.Culture),
                        Holding = CurrencyUtility.GenerateCurrencyByCulture(p.Commitment.WithholdingTax.Value, currency, "", company.Culture),
                        CurrencyCode = p.Commitment.IdCurrencyNavigation.Code
                    };
                    settlements.Add(settlement);
                });
                return settlements;
            }
            else
            {
                return null;
            }    
        }

        public TicketPosReportViewModel GetTicketPosReport(int idTicket)
        {
            TicketViewModel ticket = _entityRepoTicket.GetAllWithConditionsQueryable(x => x.Id == idTicket)
                                                      .Include(r => r.IdSessionCashNavigation)
                                                      .ThenInclude(r => r.IdCashRegisterNavigation)
                                                      .Include(r => r.IdSessionCashNavigation)
                                                      .ThenInclude(r => r.IdSellerNavigation)
                                                      .Include(r => r.IdDeliveryFormNavigation)
                                                      .ThenInclude(r => r.DocumentLine)
                                                      .Include(r => r.IdDeliveryFormNavigation)
                                                      .ThenInclude(r => r.IdUsedCurrencyNavigation)
                                                      .Select(_builderTicket.BuildEntity)
                                                      .FirstOrDefault();
            DocumentViewModel deliveryForm = ticket?.IdDeliveryFormNavigation; 
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation(); 
            TicketPosReportViewModel ticketPosReportViewModel = new TicketPosReportViewModel();
            ticketPosReportViewModel.Company = companyReportingViewModel;
            ticketPosReportViewModel.CashCode = ticket?.IdSessionCashNavigation?.IdCashRegisterNavigation?.Code;
            ticketPosReportViewModel.TicketCode = ticket?.Code;
            ticketPosReportViewModel.SellerName = ticket?.IdSessionCashNavigation?.IdSellerNavigation?.FullName;
            ticketPosReportViewModel.CreationDate = ticket.CreationDate.ToShortDateString() + " " + ticket.CreationDate.ToShortTimeString().Substring(0, 5);
            ticketPosReportViewModel.TtcAmount = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + deliveryForm?.IdUsedCurrencyNavigation?.Precision + "}", "", deliveryForm?.DocumentTtcprice ?? 0);
            ticketPosReportViewModel.UsedCurrency = deliveryForm?.IdUsedCurrencyNavigation?.Code;
            ticketPosReportViewModel.TotalTicketLine = Convert.ToInt32(deliveryForm?.DocumentLine?.Sum(s => s.MovementQty) ?? 0);
              
            return ticketPosReportViewModel;
        }

        public IList<TicketLineViewModel> GetTicketLines(int idTicket)
        {
            List<TicketLineViewModel> ticketLines = _serviceTicket.GetTicketLines(idTicket).ToList();

            return ticketLines;
        } 

        public IList<TicketPaymentMethodViewModel> GetTicketPayment(int idTicket)
        {
            IQueryable<TicketPayment> ticketPayment = _repoTicketPayment.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdTicket == idTicket)
                    .Include(r => r.IdTicketNavigation)
                    .ThenInclude(r => r.IdDeliveryFormNavigation)
                    .ThenInclude(r => r.IdUsedCurrencyNavigation);

            // Add ticket lines
            List<TicketPaymentMethodViewModel> ticketTaxResume = ticketPayment?.Select(s => new TicketPaymentMethodViewModel
            {
                MethodName = s.IdPaymentTypeNavigation.Label,
                Amount = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + s.IdTicketNavigation.IdDeliveryFormNavigation.IdUsedCurrencyNavigation.Precision + "}", "", s.Amount),
                ReceivedAmount = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + s.IdTicketNavigation.IdDeliveryFormNavigation.IdUsedCurrencyNavigation.Precision + "}", "", s.ReceivedAmount ?? 0),
                ReturnedAmount = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + s.IdTicketNavigation.IdDeliveryFormNavigation.IdUsedCurrencyNavigation.Precision + "}", "", s.AmountReturned ?? 0) 
            }).ToList();

            return ticketTaxResume;
        }
        public SessionPaymentInfosViewModel GetSessionPaymentInfos(int idSession)
        {
            SessionPaymentInfosViewModel sessionPaymentInfos = new SessionPaymentInfosViewModel();
            SessionCashViewModel currentSession = _serviceSessionCash.GetModelAsNoTracked(x => x.Id == idSession, x => x.IdCashRegisterNavigation,
                                                     x => x.IdSellerNavigation);
            sessionPaymentInfos.SessionCode = currentSession?.Code;
            sessionPaymentInfos.SessionCreationDate = currentSession?.OpeningDate.ToShortDateString() + GenericConstants.SPACE + currentSession?.OpeningDate.ToShortTimeString();
            sessionPaymentInfos.SellerName = currentSession?.IdSellerNavigation.FullName;
            sessionPaymentInfos.CashRegisterCode = currentSession?.IdCashRegisterNavigation.Code;
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            sessionPaymentInfos.CompanyLogo = companyReportingViewModel?.CompanyLogo;
            sessionPaymentInfos.CompanyName = companyReportingViewModel?.CompanyName;
            return sessionPaymentInfos;
        }
        public IList<SessionPaymentTicketInfosViewModel> GetSessionPaymentTickets(int idSession) {
            IList<SessionPaymentTicketInfosViewModel> result = new List<SessionPaymentTicketInfosViewModel>();
            // Get all Tickets associated to the current session 
            IList<TicketViewModel> tickets = _entityRepoTicket.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdSessionCash == idSession,
                                              x => x.IdInvoiceNavigation )
                                             .Include(x => x.TicketPayment)
                                             .ThenInclude(x => x.IdPaymentTypeNavigation)
                                             .Include(x => x.IdDeliveryFormNavigation)
                                             .ThenInclude(x => x.IdTiersNavigation)
                                             .ThenInclude(x => x.IdCurrencyNavigation)
                                             .Select(_builderTicket.BuildEntity).ToList();
            tickets?.ToList().ForEach(ticket =>
            {
                SessionPaymentTicketInfosViewModel TicketInfos = new SessionPaymentTicketInfosViewModel();
                StringBuilder dateFomat = new StringBuilder();
                dateFomat.Append(ticket.CreationDate.ToShortDateString()).Append(GenericConstants.SPACE).Append(ticket.CreationDate.ToShortTimeString());
                TicketInfos.CreationDate = dateFomat.ToString();
                TicketInfos.TicketCode = ticket.Code;
                TicketInfos.DeliveryFormCode = ticket.IdDeliveryFormNavigation.Code;
                TicketInfos.InvoiceCode = ticket.IdInvoiceNavigation?.Code;
                if (ticket.TicketPayment != null && ticket.TicketPayment.Any())
                {
                    StringBuilder stringBuilder = new StringBuilder();
                    ticket.TicketPayment.ToList().ForEach(TicketPayment => {
                        stringBuilder.Append(TicketPayment.IdPaymentTypeNavigation.Code).Append(GenericConstants.Comma).Append(GenericConstants.SPACE);
                    });
                    TicketInfos.PaymentMethod = stringBuilder.ToString().Substring(NumberConstant.Zero, stringBuilder.Length - NumberConstant.Two);
                }
                TicketInfos.ClientName = ticket.IdDeliveryFormNavigation.IdTiersNavigation.Name;
                TicketInfos.Amount = ticket.IdDeliveryFormNavigation.DocumentTtcpriceWithCurrency.ToString() + GenericConstants.SPACE +
                                     ticket.IdDeliveryFormNavigation.IdTiersNavigation.IdCurrencyNavigation.Code;
                // Add Ticket To List
                result.Add(TicketInfos);
            });
            return result;
        }

        public IList<SessionPaymentAmountDetailsViewModel> GetSessionTotalAmountByPaymentType(int idSession)
        {
            IList<SessionPaymentAmountDetailsViewModel> result = new List<SessionPaymentAmountDetailsViewModel>();
            var PaymentGroup = _repoTicketPayment.GetAllWithConditionsQueryable(x => x.IdTicketNavigation.IdSessionCash == idSession)
                                                 .Include(x => x.IdTicketNavigation)
                                                 .ThenInclude(x => x.IdDeliveryFormNavigation)
                                                 .ThenInclude(x => x.IdTiersNavigation)
                                                 .ThenInclude(x => x.IdCurrencyNavigation)
                                                 .Include(x => x.IdPaymentTypeNavigation)
                                                 .ToList()
                                                 .GroupBy(x =>  new { x.IdPaymentTypeNavigation.Id, x.IdPaymentTypeNavigation.Label })
                                                 .ToList();
            // for every Payment method count amount depending on currency
            PaymentGroup.ToList().ForEach(x =>
            {
                var groupElements = x.ToList();
                SessionPaymentAmountDetailsViewModel sessionPaymentAmountDetails = new SessionPaymentAmountDetailsViewModel();
                sessionPaymentAmountDetails.PaymentType = x.Key.Label;
                StringBuilder totalAmount = new StringBuilder();
                // regroup element by currency 
                groupElements.GroupBy(y => y.IdTicketNavigation.IdDeliveryFormNavigation.IdTiersNavigation.IdCurrencyNavigation)
                .ToList().ForEach(y => {
                    totalAmount.Append(AmountMethods.FormatValue(y.Sum(y => y.Amount),y.Key.Precision).ToString()).Append(GenericConstants.SPACE)
                    .Append(y.Key.Code).Append(GenericConstants.Comma).Append(GenericConstants.SPACE);
                });
                sessionPaymentAmountDetails.TotalAmount = totalAmount.ToString().Substring(NumberConstant.Zero, totalAmount.Length - NumberConstant.Two);
                result.Add(sessionPaymentAmountDetails);
            });
            return result;
        }

        #endregion
    }
}
