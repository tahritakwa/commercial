using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Constants.TreasuryConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        #region OUTSTANDING_DOCUMENTS

        /// <summary>
        /// Method that retrieve all delivery form outstanding list
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public OutstandingDeliveryFormResultViewModel GetCustomerDeliverFormOutstandingList(PredicateFormatViewModel model)
        {
            OutstandingDeliveryFormResultViewModel outstandingDocumentSourceResult = new OutstandingDeliveryFormResultViewModel();
            if (model != null)
            {
                Expression<Func<DocumentLine, bool>> predicate = GenerateDocumentFilter(model);

                List<OrderByViewModel> documentOderByFromDocumentLineViewModels = GenerateDocumentOrderByFromDocumentLine(model);

                List<OrderByViewModel> documentOderByViewModels = GenerateDocumentOrderBy(model);

                IQueryable<DocumentLine> documentLinesNotBilled = _entityDocumentLineRepo.GetAllAsNoTracking().Where(p =>
                           (p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentEnumerator.SalesDelivery.ToLower()
                            && p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid))
                            .Where(predicate)
                            .OrderByRelation(documentOderByFromDocumentLineViewModels);

                var listDocumentLine = documentLinesNotBilled
                                            .Select(x => new
                                            {
                                                x.IdDocument,
                                                x.TtcTotalLineWithCurrency,
                                                x.TtcTotalLine
                                            }).ToList();

                List<int> idDocumentSelected = new List<int>();

                // Apply Orderby of DocumentTtcpriceWithCurrency
                if (documentOderByViewModels.Any(x => x.Direction.Equals(OrderByDirection.ASC)))
                {
                    idDocumentSelected = listDocumentLine.GroupBy(g => g.IdDocument)
                            .OrderBy(x => x.Sum(y => y.TtcTotalLineWithCurrency))
                            .Select(s => s.Key).Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
                }
                else if (documentOderByViewModels.Any(x => x.Direction.Equals(OrderByDirection.DESC)))
                {
                    idDocumentSelected = listDocumentLine.GroupBy(g => g.IdDocument)
                        .OrderByDescending(x => x.Sum(y => y.TtcTotalLineWithCurrency))
                        .Select(s => s.Key).Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
                }
                else
                {
                    idDocumentSelected = listDocumentLine.GroupBy(g => g.IdDocument)
                        .Select(s => s.Key).Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
                }

                List<Document> listDocumentSelected = _entityRepo.QuerableGetAll().Where(p => idDocumentSelected.Contains(p.Id))
                                                                    .OrderByRelation(model.OrderBy)
                                                                    .Include(x => x.IdTiersNavigation)
                                                                    .Include(x => x.IdUsedCurrencyNavigation).ToList();

                List<OutstandingDeliveryFormViewModel> documentResultData = GenerateDocumentList(listDocumentSelected).ToList();

                documentResultData.ForEach((document) =>
                {
                    document.DocumentRemainingAmountWithCurrency = Math.Round(listDocumentLine.Where(x => x.IdDocument == document.Id)
                                                                                              .Sum(x => x.TtcTotalLineWithCurrency).Value, 3);
                });

                int companyPrecision = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;

                List<int> documentIds = listDocumentLine.Select(s => s.IdDocument).Distinct().ToList();

                outstandingDocumentSourceResult.TotalAmount = Math.Round(_entityRepo.GetAllAsNoTracking()
                                    .Where(p => documentIds.Contains(p.Id))
                                    .Sum(x => x.DocumentTtcprice).Value, companyPrecision);

                outstandingDocumentSourceResult.TotalRemainingAmount = Math.Round(listDocumentLine
                                            .Sum(x => x.TtcTotalLine).Value, companyPrecision);

                outstandingDocumentSourceResult.Data = documentResultData;

                outstandingDocumentSourceResult.Total = listDocumentLine.GroupBy(g => g.IdDocument).Select(s => s.Key).Count();

            }

            return outstandingDocumentSourceResult;
        }

        /// <summary>
        /// Method that retrieve financial commitment or assets outstanding list
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="tiersType"></param>
        /// <param name="documentType"></param>
        /// <returns></returns>
        public OutstandingFinancialCommitmentResultViewModel GetFinancialCommitmentOrAssetsOutstandingDocumentList(PredicateFormatViewModel predicateModel, int tiersType, int documentType)
        {
            OutstandingFinancialCommitmentResultViewModel outstandingFinancialCommitmentResultViewModel = new OutstandingFinancialCommitmentResultViewModel();
            if (predicateModel != null)
            {
                IQueryable<Ticket> ticketQuery = _ticketRepo.GetAllWithConditionsRelationsQueryable(x => x.TicketPayment.Count > 0);
                ticketQuery = ticketQuery.Where(x => x.TicketPayment.Any(y => y.Status != (int)DocumentStatusEnumerator.TotallySatisfied));
                List<int?> idInvoice = ticketQuery.Select(x => x.IdInvoice).ToList();
                /****************** Extract data from financial commitment ******************/
                Expression<Func<FinancialCommitment, bool>> whereCondition = PredicateUtility<FinancialCommitment>.PredicateFilter(predicateModel, Operator.And);

                // Predicate for financial commitment related to Documents
                whereCondition = whereCondition.And(x => (x.IdDocument.HasValue && x.RemainingAmountWithCurrency > 0 &&
                                                         (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                                                          || x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied))
                                                          && !idInvoice.Contains(x.IdDocument));

                if (documentType == (int)OutstandingDocumentTypeEnumerator.InvoiceFinancialCommitment)
                {
                    string DocumentType = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoice : DocumentEnumerator.PurchaseInvoice;
                    whereCondition = whereCondition.And(x => x.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentType.ToLower());
                }
                else
                {
                    string DocumentType = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoiceAsset : DocumentEnumerator.PurchaseAsset;
                    whereCondition = whereCondition.And(x => x.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentType.ToLower());
                }

                // Execute query to get both of commitment types 
                IQueryable<FinancialCommitment> queryFinancialCommitment = _entityFinancialCommitment.GetAllAsNoTracking()
                                                                            .Where(whereCondition)
                                                                            .OrderByRelation(predicateModel.OrderBy)
                                                                            .Include(r => r.IdPaymentMethodNavigation)
                                                                            .Include(r => r.IdTiersNavigation)
                                                                            .Include(r => r.IdCurrencyNavigation)
                                                                            .Include(r => r.IdDocumentNavigation);
                // Result 
                outstandingFinancialCommitmentResultViewModel.Total = queryFinancialCommitment.Count();
                outstandingFinancialCommitmentResultViewModel.Data = queryFinancialCommitment.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList()
                    .Select(x => new OutstandingFinancialCommitmentReducedViewModel(x)).ToList();

                // Apply rounding according to company currency
                var currencyAccorrdingToCompany = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
                int companyPrecision = currencyAccorrdingToCompany.Precision;

                outstandingFinancialCommitmentResultViewModel.TotalAmount = Math.Round(queryFinancialCommitment.Sum(x => x.Amount.Value), companyPrecision);
                outstandingFinancialCommitmentResultViewModel.TotalRemainingAmount = Math.Round(queryFinancialCommitment.Sum(x => x.RemainingAmount), companyPrecision);
            }
            return outstandingFinancialCommitmentResultViewModel;
        }

        /// <summary>
        /// Method that retrieve all invoices not totaly payed
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="tiersType"></param>
        /// <returns></returns>
        public DataSourceResult<OutstandinngInvoiceViewModel> GetInvoicesOutstandingDocumentList(PredicateFormatViewModel predicateModel, int tiersType)
        {

            DataSourceResult<OutstandinngInvoiceViewModel> dataSourceResult = new DataSourceResult<OutstandinngInvoiceViewModel>();

            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = PreparePredicate(predicateModel);

            if (predicateModel != null)
            {
                IQueryable<Ticket> ticketQuery = _ticketRepo.GetAllWithConditionsRelationsQueryable(x => x.TicketPayment.Any(y => y.Status != (int)DocumentStatusEnumerator.TotallySatisfied));
                List<int?> idInvoice = ticketQuery.Select(x => x.IdInvoice).ToList();
                string DocumentType = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoice : DocumentEnumerator.PurchaseInvoice;
                IQueryable<Document> documentQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(
                                                            x => x.DocumentRemainingAmount > 0
                                                            && x.FinancialCommitment != null && x.FinancialCommitment.Any()
                                                            && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                                                               || x.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
                                                            && (x.DocumentTypeCode == DocumentType && !idInvoice.Contains(x.Id)),
                                                            x => x.IdTiersNavigation,
                                                            x => x.IdUsedCurrencyNavigation
                                                          ).Where(predicateFilterRelationModel.PredicateWhere)
                                                         .OrderByRelation(predicateModel.OrderBy)
                                                         .Include(x => x.FinancialCommitment)
                                                         .ThenInclude(x => x.IdCurrencyNavigation);

                dataSourceResult.total = documentQuery.Count();

                IList<Document> data = documentQuery.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();

                dataSourceResult.data = data.Select(x => new OutstandinngInvoiceViewModel(x)).ToList();
            }
            return dataSourceResult;
        }

        /// <summary>
        /// Generate list of type outstandingDocumentViewModel from list of type document
        /// </summary>
        /// <param name="documents"></param>
        /// <returns></returns>
        private IEnumerable<OutstandingDeliveryFormViewModel> GenerateDocumentList(List<Document> documents)
        {
            foreach (Document document in documents)
            {
                yield return new OutstandingDeliveryFormViewModel
                {
                    Id = document.Id,
                    Code = document.Code,
                    DocumentDate = document.DocumentDate,
                    DocumentTtcpriceWithCurrency = (double)document.DocumentTtcpriceWithCurrency,
                    DocumentRemainingAmountWithCurrency = (double)document.DocumentRemainingAmountWithCurrency,
                    IdTiers = (int)document.IdTiers,
                    TiersName = document.IdTiersNavigation.Name,
                    CurrencyCode = document.IdUsedCurrencyNavigation.Code,
                    CurrencyPrecision = document.IdUsedCurrencyNavigation.Precision,
                };
            }
        }
        #endregion

        #region export_api

        /// <summary>
        /// GetCustomerDeliverFormOutstandingForExport
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DataSourceResult<OutstandingDeliveryFormForExportViewModel> GetCustomerDeliverFormOutstandingForExport(PredicateFormatViewModel model)
        {
            DataSourceResult<OutstandingDeliveryFormForExportViewModel> result = new DataSourceResult<OutstandingDeliveryFormForExportViewModel>();
            OutstandingDeliveryFormResultViewModel dataSourceResult = GetCustomerDeliverFormOutstandingList(model);
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            result.data = new List<OutstandingDeliveryFormForExportViewModel>();
            OutstandingDeliveryFormForExportViewModel modelForExport;
            TreasuryConstant treasuryConstant = new TreasuryConstant(company.Culture);
            // Format date and amounts for each result
            dataSourceResult.Data.ToList().ForEach((x) =>
            {
                modelForExport = new OutstandingDeliveryFormForExportViewModel(x);
                modelForExport.DocumentDate = DateUtility.GenerateDateTimeByCulture(x.DocumentDate, company.Culture);
                modelForExport.DocumentTtcpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcpriceWithCurrency,
                            modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);
                modelForExport.DocumentRemainingAmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.DocumentRemainingAmountWithCurrency,
                           modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);
                result.data.Add(modelForExport);
            });
            result.total = dataSourceResult.Total;
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="objectToSaveViewModel"></param>
        /// <returns></returns>
        public DataSourceResult<OutstandinngInvoiceForExportViewModel> GetInvoiceOutstandingDocumentForExport(PredicateFormatViewModel predicateFormatModel)
        {
            DataSourceResult<OutstandinngInvoiceViewModel> dataSourceResult = new DataSourceResult<OutstandinngInvoiceViewModel>();
            DataSourceResult<OutstandinngInvoiceForExportViewModel> result = new DataSourceResult<OutstandinngInvoiceForExportViewModel>();
            if (predicateFormatModel != null)
            {

                // Retrive the tiers type
                int tiersType = Convert.ToInt32(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.TiersType, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);
                tiersType = tiersType != 0 ? tiersType : (int)TiersType.Supplier;

                // Build the predicate
                PredicateFormatViewModel model = new PredicateFormatViewModel()
                {
                    pageSize = predicateFormatModel.pageSize,
                    page = predicateFormatModel.page,
                    Filter = predicateFormatModel.Filter.Where(x => !x.Prop.Equals(TreasuryConstant.TiersType, StringComparison.OrdinalIgnoreCase)).ToList(),
                    OrderBy = predicateFormatModel.OrderBy,
                    Relation = predicateFormatModel.Relation,
                    Operator = predicateFormatModel.Operator,
                    values = predicateFormatModel.values
                };
                // Get the data source result
                dataSourceResult = GetInvoicesOutstandingDocumentList(model, tiersType);
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                result.data = new List<OutstandinngInvoiceForExportViewModel>();
                OutstandinngInvoiceForExportViewModel modelForExport;
                TreasuryConstant treasuryConstant = new TreasuryConstant(company.Culture);
                // Format date and amounts for each result
                dataSourceResult.data.ToList().ForEach((x) =>
                {
                    modelForExport = new OutstandinngInvoiceForExportViewModel(x);
                    if (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                    {
                        modelForExport.IdDocumentStatus = treasuryConstant.Valid;
                    }
                    else
                    {
                        modelForExport.IdDocumentStatus = treasuryConstant.PartiallySatisfied;
                    }
                    modelForExport.NumberOfInvoice = x.FinancialCommitment.Count;
                    modelForExport.DocumentDate = DateUtility.GenerateDateTimeByCulture(x.DocumentDate, company.Culture);
                    modelForExport.DocumentTtcpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcpriceWithCurrency,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);
                    modelForExport.DocumentRemainingAmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.DocumentRemainingAmountWithCurrency,
                               modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);
                    result.data.Add(modelForExport);
                });
                result.total = dataSourceResult.total;
            }

            return result;
        }

        /// <summary>
        /// GetFinancialCommitmentOrAssetsOutstandingDocumentForExport
        /// </summary>
        /// <param name="objectToSaveViewModel"></param>
        /// <returns></returns>
        public DataSourceResult<OutstandingFinancialCommitmentForExportViewModel> GetFinancialCommitmentOrAssetsOutstandingDocumentForExport(PredicateFormatViewModel predicateFormatModel)
        {
            DataSourceResult<OutstandingFinancialCommitmentForExportViewModel> result = new DataSourceResult<OutstandingFinancialCommitmentForExportViewModel>();
            OutstandingFinancialCommitmentResultViewModel dataSourceResult = new OutstandingFinancialCommitmentResultViewModel();
            if (predicateFormatModel != null)
            {
                // Retrive the tiers type
                int tiersType = Convert.ToInt32(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.TiersType, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);
                tiersType = tiersType != 0 ? tiersType : (int)TiersType.Customer;
                // Retrieve document type
                int documentType = Convert.ToInt32(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.DocumentType, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);
                // Build the predicate
                PredicateFormatViewModel model = new PredicateFormatViewModel()
                {
                    pageSize = predicateFormatModel.pageSize,
                    page = predicateFormatModel.page,
                    Filter = predicateFormatModel.Filter.Where(x => !
                        (x.Prop.Equals(TreasuryConstant.TiersType, StringComparison.OrdinalIgnoreCase) ||
                            x.Prop.Equals(TreasuryConstant.DocumentType, StringComparison.OrdinalIgnoreCase))).ToList(),
                    OrderBy = predicateFormatModel.OrderBy,
                    Relation = predicateFormatModel.Relation,
                    Operator = predicateFormatModel.Operator,
                    values = predicateFormatModel.values
                };
                // Get the data source result
                dataSourceResult = GetFinancialCommitmentOrAssetsOutstandingDocumentList(model, tiersType, documentType);
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                result.data = new List<OutstandingFinancialCommitmentForExportViewModel>();
                OutstandingFinancialCommitmentForExportViewModel modelForExport;
                TreasuryConstant treasuryConstant = new TreasuryConstant(company.Culture);
                // Format date and amounts for each result
                dataSourceResult.Data.ToList().ForEach((x) =>
                {
                    modelForExport = new OutstandingFinancialCommitmentForExportViewModel(x);

                    modelForExport.IdDocumentNavigation.DocumentDate = DateUtility.GenerateDateTimeByCulture(x.IdDocumentNavigation.DocumentDate, company.Culture);

                    modelForExport.CommitmentDate = DateUtility.GenerateDateByCulture(x.CommitmentDate, company.Culture);

                    modelForExport.AmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.AmountWithCurrency.HasValue ? x.AmountWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.AmountWithoutWithholdingTaxWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.AmountWithoutWithholdingTaxWithCurrency.HasValue ? x.AmountWithoutWithholdingTaxWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.RemainingAmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.RemainingAmountWithCurrency.HasValue ? x.RemainingAmountWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.WithholdingTaxWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.WithholdingTaxWithCurrency.HasValue ? x.WithholdingTaxWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.RemainingWithholdingTaxWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.RemainingWithholdingTaxWithCurrency.HasValue ? x.RemainingWithholdingTaxWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.WithholdingTaxWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.WithholdingTaxWithCurrency.HasValue ? x.WithholdingTaxWithCurrency.Value : 0,
                                modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    result.data.Add(modelForExport);
                });

                result.total = dataSourceResult.Total;
            }

            return result;
        }

        /// <summary>
        /// GetReceivablesReportsForExport
        /// </summary>
        /// <param name="predicateFormatModel"></param>
        /// <returns></returns>
        public DataSourceResult<TiersTreasuryReportForExportViewModel> GetReceivablesReportsForExport(PredicateFormatViewModel predicateFormatModel)
        {

            TiersTreasuryReportResultViewModel dataSourceResult = new TiersTreasuryReportResultViewModel();
            DataSourceResult<TiersTreasuryReportForExportViewModel> result = new DataSourceResult<TiersTreasuryReportForExportViewModel>();
            if (predicateFormatModel != null)
            {

                int? idTiers = Convert.ToInt32(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.IdTiers, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);
                idTiers = idTiers != 0 ? idTiers : null;

                object start_date = predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.StartDate, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value;

                DateTime? startDate = start_date != null ? Convert.ToDateTime(start_date, CultureInfo.InvariantCulture) : (DateTime?)null;

                object end_date = predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.EndDate, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value;

                DateTime? endDate = end_date != null ? Convert.ToDateTime(start_date, CultureInfo.InvariantCulture) : (DateTime?)null;

                int page = predicateFormatModel.page;

                int pageSize = predicateFormatModel.pageSize;

                int tiersType = Convert.ToInt32(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.TiersType, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);
                tiersType = tiersType != 0 ? tiersType : (int)TiersType.Customer;

                bool deliveryFormNotBilled = Convert.ToBoolean(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.DeliveryFormNotBilled, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);

                bool unpaidFinancialCommitment = Convert.ToBoolean(predicateFormatModel.Filter.Where(x => x.Prop.Equals(TreasuryConstant.UnpaidFinancialCommitment, StringComparison.OrdinalIgnoreCase)).FirstOrDefault().Value,
                                   CultureInfo.InvariantCulture);


                // Get the data source result
                dataSourceResult = GetReceivablesReports(idTiers, startDate, endDate, page, pageSize, tiersType, deliveryFormNotBilled, unpaidFinancialCommitment);
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                result.data = new List<TiersTreasuryReportForExportViewModel>();
                TiersTreasuryReportForExportViewModel modelForExport;
                TreasuryConstant treasuryConstant = new TreasuryConstant(company.Culture);
                // Format date and amounts for each result
                dataSourceResult.Data.ToList().ForEach((x) =>
                {
                    modelForExport = new TiersTreasuryReportForExportViewModel(x);

                    modelForExport.TotalAmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.TotalAmount,
                               modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.TotalOverduePaymentAmountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.TotalOverduePaymentAmountWithCurrency,
                               modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);

                    modelForExport.TotalTurnoverWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(x.TotalTurnoverWithCurrency,
                               modelForExport.CurrencyPrecision, modelForExport.CurrencyCode, company.Culture);
                    result.data.Add(modelForExport);
                });
                result.total = dataSourceResult.Total;
            }
            return result;
        }
        #endregion

        #region EMAIL

        /// <summary>
        /// Send Invoice Revival Mail
        /// </summary>
        /// <param name="financialCommitmentViewModels"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void SendInvoiceRevivalMail(List<FinancialCommitmentViewModel> invoiceFinancialCommitments, string userMail, SmtpSettings smtpSettings)
        {
            EmailViewModel emailViewModel = GenerateInvoiceRevivalMailTemplate(invoiceFinancialCommitments, userMail);
            _serviceEmail.PrepareAndSendEmail(emailViewModel, userMail, smtpSettings);
        }

        /// <summary>
        /// Generate Invoice Revival Mail Template
        /// </summary>
        /// <param name="financialCommitmentViewModels"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public EmailViewModel GenerateInvoiceRevivalMailTemplate(List<FinancialCommitmentViewModel> invoiceFinancialCommitments, string userMail)
        {
            try
            {
                BeginTransaction();
                TiersViewModel tiersViewModel = new TiersViewModel();
                // Verify if the tiers navigation and the tiers contact exist
                if (invoiceFinancialCommitments == null || !invoiceFinancialCommitments.Any() || !invoiceFinancialCommitments.Any(x => x.IdDocumentNavigation != null))
                {
                    throw new CustomException(CustomStatusCode.NoInvoiceAssociateToTheFinancialCommitment);
                }
                else
                {
                    int? idTiers = invoiceFinancialCommitments.FirstOrDefault().IdDocumentNavigation.IdTiers;
                    tiersViewModel = _serviceTiers.GetModelAsNoTracked(x => idTiers.HasValue && x.Id == idTiers.Value);
                    tiersViewModel.Contact = _serviceContact.FindByAsNoTracking(x => x.IdTiers == tiersViewModel.Id).ToList();

                    if (tiersViewModel.Contact == null || tiersViewModel.Contact.Count <= 0)
                    {
                        Dictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>();
                        paramtrs.Add(nameof(Tiers), tiersViewModel.Name);
                        throw new CustomException(CustomStatusCode.NoTiersContactFoundToSendRevivialMail, paramtrs);
                    }
                }
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                User user = _entityRepoUser.GetSingleNotTracked(u => u.Email.ToLower() == userMail.ToLower());

                EmailViewModel generatedMail = new EmailViewModel();
                InvoiceRevivalEmailConstant invoiceRevivalMailConstant = new InvoiceRevivalEmailConstant(user.Lang);

                generatedMail = new EmailViewModel
                {
                    Subject = invoiceRevivalMailConstant.GenerateInvoiceRevivalSubjectByCulture,
                    Body = PrepareOfferMailBody(invoiceRevivalMailConstant, invoiceFinancialCommitments, tiersViewModel, company.Culture, userMail),
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = tiersViewModel.Contact.ToList().FirstOrDefault().Email
                };
                generatedMail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedMail, null, userMail)).Id;
                EndTransaction();
                return generatedMail;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw;
            }
        }
        private string PrepareOfferMailBody(InvoiceRevivalEmailConstant invoiceRevivalEmailConstant, List<FinancialCommitmentViewModel> invoiceFinancialCommitment,
            TiersViewModel tiersViewModel, string culture, string userMail)
        {
            Employee creator = _entityRepoEmployee.GetSingleNotTracked(e =>
               e.Email.ToUpper() == userMail.ToUpper());
            CurrencyViewModel currencyViewModel = _serviceCurrency.FindByAsNoTracking(x => x.Id == tiersViewModel.IdCurrency).FirstOrDefault();

            double totalRemainingAmountWithCurrency = Math.Round(invoiceFinancialCommitment.Sum(x => x.RemainingAmountWithCurrency).Value, currencyViewModel.Precision);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@invoiceRevivalEmailConstant.InvoiceRevivalEmailTemplateByCulture);
            body = body.Replace("{TIERS_FULL_NAME}", tiersViewModel.Contact.FirstOrDefault().FirstName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TOTAL_AMOUNT_WITH_CURRENCY}", GenerateTotalAmountWithCurrency(invoiceFinancialCommitment, currencyViewModel, culture), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TOTAL_REMAININGG_AMOUNT_WITH_CURRENCY}", GenerateTotalRemainingAmountWithCurrency(invoiceFinancialCommitment, currencyViewModel, culture), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INVOICES_TABLE_CONTENT}", InvoiceTableContentByCulture(invoiceFinancialCommitment, currencyViewModel, culture), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", creator != null ? new StringBuilder().Append(creator.FirstName).Append(" ").Append(creator.LastName).ToString() : "", StringComparison.OrdinalIgnoreCase);
            return body;
        }
        private string GenerateTotalAmountWithCurrency(List<FinancialCommitmentViewModel> invoiceFinancialCommitments, CurrencyViewModel currencyViewModel, string culture)
        {
            StringBuilder totalAmountString = new StringBuilder();
            double totalAmountWithCurrency = Math.Round(invoiceFinancialCommitments.Sum(x => x.AmountWithCurrency).Value, currencyViewModel.Precision);
            totalAmountString.Append(CurrencyUtility.GenerateCurrencyByCulture(totalAmountWithCurrency, currencyViewModel.Precision, currencyViewModel.Symbole, culture));

            return totalAmountString.ToString();
        }
        private string GenerateTotalRemainingAmountWithCurrency(List<FinancialCommitmentViewModel> invoiceFinancialCommitments, CurrencyViewModel currencyViewModel, string culture)
        {
            StringBuilder totalRemainingAmountString = new StringBuilder();
            double totalRemainingAmountWithCurrency = Math.Round(invoiceFinancialCommitments.Sum(x => x.RemainingAmountWithCurrency).Value, currencyViewModel.Precision);
            totalRemainingAmountString.Append(CurrencyUtility.GenerateCurrencyByCulture(totalRemainingAmountWithCurrency, currencyViewModel.Precision, currencyViewModel.Symbole, culture));

            return totalRemainingAmountString.ToString();
        }
        private string InvoiceTableContentByCulture(List<FinancialCommitmentViewModel> invoiceFinancialCommitments, CurrencyViewModel currencyViewModel, string culture)
        {
            StringBuilder invoiceTableLineContent = new StringBuilder();
            double documentTtcPrice;
            double documentRemainingAmount;

            List<IGrouping<int?, FinancialCommitmentViewModel>> financialCommitmentByIdDocument = invoiceFinancialCommitments.GroupBy(g => g.IdDocument).ToList();
            bool showRowSpan = true;
            foreach (int idDocument in financialCommitmentByIdDocument.Select(s => s.Key))
            {

                List<FinancialCommitmentViewModel> financialCommitments = financialCommitmentByIdDocument.Where(x => x.Key == idDocument).SelectMany(x => x).ToList();

                foreach (FinancialCommitmentViewModel financialCommitmentViewModel in financialCommitments)
                {
                    invoiceTableLineContent.Append("<tr>");

                    if (showRowSpan)
                    {
                        invoiceTableLineContent.Append("<td style=\"font-family: Times New Roman, sans-serif;\" rowspan=\""
                                                        + financialCommitments.Count + "\">");
                        invoiceTableLineContent.Append(financialCommitmentViewModel.IdDocumentNavigation.Code);
                        invoiceTableLineContent.Append("</td>");
                        showRowSpan = false;
                    }

                    invoiceTableLineContent.Append("<td style=\"font-family: Times New Roman, sans-serif;\">");
                    invoiceTableLineContent.Append(DateUtility.GenerateDateByCulture(financialCommitmentViewModel.CommitmentDate, culture));
                    invoiceTableLineContent.Append("</td>");
                    invoiceTableLineContent.Append("<td style=\"font-family: Times New Roman, sans-serif;\">");
                    documentTtcPrice = Math.Round(financialCommitmentViewModel.AmountWithCurrency.Value, currencyViewModel.Precision);
                    invoiceTableLineContent.Append(CurrencyUtility.GenerateCurrencyByCulture(documentTtcPrice, currencyViewModel.Precision, currencyViewModel.Symbole, culture));
                    invoiceTableLineContent.Append("</td>");
                    invoiceTableLineContent.Append("<td style=\"font-family: Times New Roman, sans-serif;\">");
                    documentRemainingAmount = Math.Round(financialCommitmentViewModel.RemainingAmountWithCurrency.Value, currencyViewModel.Precision);
                    invoiceTableLineContent.Append(CurrencyUtility.GenerateCurrencyByCulture(documentRemainingAmount, currencyViewModel.Precision, currencyViewModel.Symbole, culture));
                    invoiceTableLineContent.Append("</td>");
                    invoiceTableLineContent.Append("</tr>");
                }
                showRowSpan = true;
            }
;
            return invoiceTableLineContent.ToString();
        }

        #endregion

        #region FILTER_ORDER_BY
        /// <summary>
        /// Generate Document Filter for DeliveryFormOutstanding List
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private Expression<Func<DocumentLine, bool>> GenerateDocumentFilter(PredicateFormatViewModel model)
        {
            PredicateFormatViewModel predicateForDocument = new PredicateFormatViewModel();
            predicateForDocument.Filter = new List<FilterViewModel>();
            if (model.Filter.Any(x => x.Prop.Equals(TreasuryConstant.IdTiers, StringComparison.OrdinalIgnoreCase)))
            {
                List<FilterViewModel> listFilters = model.Filter.Where(x => x.Prop.Equals(TreasuryConstant.IdTiers, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new FilterViewModel(m));
                listFilters.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToIdTiers;
                });
                ((List<FilterViewModel>)predicateForDocument.Filter).AddRange(listFilters);
            }
            if (model.Filter.Any(x => x.Prop.Equals(TreasuryConstant.Code, StringComparison.OrdinalIgnoreCase)))
            {

                List<FilterViewModel> listFilters = model.Filter.Where(x => x.Prop.Equals(TreasuryConstant.Code, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new FilterViewModel(m));
                listFilters.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToDocumentCode;
                });
                ((List<FilterViewModel>)predicateForDocument.Filter).AddRange(listFilters);
            }
            if (model.Filter.Any(x => x.Prop.Equals(TreasuryConstant.TiersName, StringComparison.OrdinalIgnoreCase)))
            {
                List<FilterViewModel> listFilters = model.Filter.Where(x => x.Prop.Equals(TreasuryConstant.TiersName, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new FilterViewModel(m));
                listFilters.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToTiersName;
                });
                ((List<FilterViewModel>)predicateForDocument.Filter).AddRange(listFilters);
            }
            if (model.Filter.Any(x => x.Prop.Equals(TreasuryConstant.DocumentDate, StringComparison.OrdinalIgnoreCase)))
            {
                List<FilterViewModel> listFilters = model.Filter.Where(x => x.Prop.Equals(TreasuryConstant.DocumentDate, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new FilterViewModel(m));
                listFilters.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToDocumentDate;
                });
                ((List<FilterViewModel>)predicateForDocument.Filter).AddRange(listFilters);
            }
            if (model.Filter.Any(x => x.Prop.Equals(TreasuryConstant.DocumentTtcpriceWithCurrency, StringComparison.OrdinalIgnoreCase)))
            {
                List<FilterViewModel> listFilters = model.Filter.Where(x => x.Prop.Equals(TreasuryConstant.DocumentTtcpriceWithCurrency, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new FilterViewModel(m));
                listFilters.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToDocumentTtcprice;
                });
                ((List<FilterViewModel>)predicateForDocument.Filter).AddRange(listFilters);
            }
            Expression<Func<DocumentLine, bool>> predicateDocumentLineWhere = PredicateUtility<DocumentLine>.PredicateFilter(predicateForDocument, Operator.And);
            return predicateDocumentLineWhere;
        }

        /// <summary>
        /// Generate Document Order By expression for DeliveryFormOutstanding 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private List<OrderByViewModel> GenerateDocumentOrderBy(PredicateFormatViewModel model)
        {
            List<OrderByViewModel> orderByViewModels = new List<OrderByViewModel>();
            if (model.OrderBy.Any(x => x.Prop.Equals(TreasuryConstant.DocumentTtcpriceWithCurrency, StringComparison.OrdinalIgnoreCase)))
            {
                List<OrderByViewModel> orderBy = model.OrderBy.Where(x => x.Prop.Equals(TreasuryConstant.DocumentTtcpriceWithCurrency, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new OrderByViewModel(m));
                orderByViewModels.AddRange(orderBy);
            }

            return orderByViewModels;
        }

        /// <summary>
        /// GenerateDocumentOrderByFromDocumentLine
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private List<OrderByViewModel> GenerateDocumentOrderByFromDocumentLine(PredicateFormatViewModel model)
        {
            List<OrderByViewModel> orderByViewModels = new List<OrderByViewModel>();
            if (model.OrderBy.Any(x => x.Prop.Equals(TreasuryConstant.Code, StringComparison.OrdinalIgnoreCase)))
            {
                List<OrderByViewModel> orderBy = model.OrderBy.Where(x => x.Prop.Equals(TreasuryConstant.Code, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new OrderByViewModel(m));
                orderBy.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToDocumentCode;
                });
                orderByViewModels.AddRange(orderBy);
            }
            if (model.OrderBy.Any(x => x.Prop.Equals(TreasuryConstant.IdTiersNavigationName, StringComparison.OrdinalIgnoreCase)))
            {
                List<OrderByViewModel> orderBy = model.OrderBy.Where(x => x.Prop.Equals(TreasuryConstant.IdTiersNavigationName, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new OrderByViewModel(m));
                orderBy.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToTiersName;
                });
                orderByViewModels.AddRange(orderBy);
            }
            if (model.OrderBy.Any(x => x.Prop.Equals(TreasuryConstant.DocumentDate, StringComparison.OrdinalIgnoreCase)))
            {
                List<OrderByViewModel> orderBy = model.OrderBy.Where(x => x.Prop.Equals(TreasuryConstant.DocumentDate, StringComparison.OrdinalIgnoreCase)).ToList().ConvertAll(m => new OrderByViewModel(m));
                orderBy.ToList().ForEach(y =>
                {
                    y.Prop = TreasuryConstant.DocumentLineToDocumentDate;
                });
                orderByViewModels.AddRange(orderBy);
            }
            return orderByViewModels;
        }

        #endregion

        #region RECEIVABLES
        /// <summary>
        /// Get tier receivable report
        /// </summary>
        /// <param name="IdTiers"></param>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <param name="tiersType"></param>
        /// <param name="deliveryFormNotBilled"></param>
        /// <param name="unpaidFinancialCommitment"></param>
        /// <returns></returns>
        public TiersTreasuryReportResultViewModel GetReceivablesReports(int? IdTiers, DateTime? StartDate, DateTime? EndDate, int page, int pageSize, int tiersType,
             bool deliveryFormNotBilled, bool unpaidFinancialCommitment)
        {

            TiersTreasuryReportResultViewModel tiersTreasuryReportResultViewModel = new TiersTreasuryReportResultViewModel();

            // Get the recevaible for delivery form, financial commitment and the settlement
            List<TiersTreasuryReport> totalAmountFromDocumentLineByTiers = new List<TiersTreasuryReport>();
            List<TiersTreasuryReport> totalAmountFromFinancialCommitmentByTiers = new List<TiersTreasuryReport>();

            if (tiersType == (int)TiersType.Customer && deliveryFormNotBilled)
            {
                totalAmountFromDocumentLineByTiers = GenerateDeliveryFormOutstandingReport(StartDate, EndDate, IdTiers);
            }
            if (unpaidFinancialCommitment)
            {
                totalAmountFromFinancialCommitmentByTiers = GenerateFinancialCommitmentOutstandingReport(StartDate, EndDate, IdTiers, tiersType);
            }
            // Transform all recevaible to one list
            IList<TiersTreasuryReport> tiersTreasuryReportList = (totalAmountFromDocumentLineByTiers.Concat(totalAmountFromFinancialCommitmentByTiers)).ToList();

            // GetPrecision from company
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            int companyPrecision = companyCurrency.Precision;

            // Calculate total data, total amount, total overdue amount and turnover
            tiersTreasuryReportResultViewModel.Total = tiersTreasuryReportList.GroupBy(g => g.IdTiers).Select(s => s.Key).Count();

            tiersTreasuryReportResultViewModel.SumOfTotalAmount = Math.Round(
                                        Convert.ToDouble(tiersTreasuryReportList.Sum(x => x.TotalAmount)), companyPrecision);

            tiersTreasuryReportResultViewModel.SumOfTotalOverduePaymentAmount = Math.Round(
                                    Convert.ToDouble(tiersTreasuryReportList.Sum(x => x.TotalOverduePaymentAmount)), companyPrecision);

            tiersTreasuryReportResultViewModel.SumOfTurnOver = Math.Round(
               Convert.ToDouble(tiersTreasuryReportList.Sum(x => x.TotalTurnover)), companyPrecision);

            // Generate the data result 
            List<IGrouping<int, TiersTreasuryReport>> tiersDataResultByIdTiers = tiersTreasuryReportList.GroupBy(g => g.IdTiers)
                                                        .Skip((page - 1) * pageSize).Take(pageSize).ToList();
            tiersTreasuryReportResultViewModel.Data = new List<TiersTreasuryReport>();
            List<int> tiersIdsList = tiersDataResultByIdTiers.Select(s => s.Key).ToList();
            // Build the data result  with precision 
            List<TiersViewModel> tiersList = _serviceTiers.GetModelsWithConditionsRelations(x =>
                                            tiersIdsList.Contains(x.Id), y => y.IdCurrencyNavigation).ToList();
            tiersList.ForEach(
              tiers =>
              {
                  int tiersPrecision = tiers.IdCurrencyNavigation.Precision;

                  tiersTreasuryReportResultViewModel.Data.Add(new TiersTreasuryReport
                  {
                      IdTiers = tiers.Id,
                      TiersName = tiers.Name,
                      CodeTiers = tiers.CodeTiers,
                      CurrencyCode = tiers.IdCurrencyNavigation.Code,
                      CurrencyPrecision = tiers.IdCurrencyNavigation.Precision,
                      TotalAmount = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                    .Select(s => s.Sum(x => x.TotalAmount)).FirstOrDefault(), tiersPrecision),

                      TotalAmountWithCurrency = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                    .Select(s => s.Sum(x => x.TotalAmountWithCurrency)).FirstOrDefault(), tiersPrecision),

                      TotalOverduePaymentAmount = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                                            .Select(s => s.Sum(x => x.TotalOverduePaymentAmount)).FirstOrDefault(), tiersPrecision),

                      TotalOverduePaymentAmountWithCurrency = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                                            .Select(s => s.Sum(x => x.TotalOverduePaymentAmountWithCurrency)).FirstOrDefault(), tiersPrecision),

                      TotalTurnover = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                                            .Select(s => s.Sum(x => x.TotalTurnover)).FirstOrDefault(), tiersPrecision),

                      TotalTurnoverWithCurrency = Math.Round(tiersDataResultByIdTiers.Where(p => p.Key == tiers.Id)
                                                            .Select(s => s.Sum(x => x.TotalTurnoverWithCurrency)).FirstOrDefault(), tiersPrecision)
                  });

              });
            return tiersTreasuryReportResultViewModel;
        }


        /// <summary>
        /// Get delivery form  outstanding report
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="idTiers"></param>
        /// <returns></returns>
        List<TiersTreasuryReport> GenerateDeliveryFormOutstandingReport(DateTime? startDate, DateTime? endDate, int? idTiers)
        {
            // Build the predicate for documentLine which come from deliveryForm and which are not billed
            Expression<Func<DocumentLine, bool>> predicateForBL = (p) => p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentEnumerator.SalesDelivery.ToLower()
                                                                         && p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid;
            // Add filters 
            if (idTiers != null)
            {
                predicateForBL = predicateForBL.And((p) => p.IdDocumentNavigation.IdTiers.HasValue && p.IdDocumentNavigation.IdTiers.Value == idTiers);
            }
            if (startDate != null)
            {
                predicateForBL = predicateForBL.And((p) => DateTime.Compare(p.IdDocumentNavigation.DocumentDate.Date, startDate.Value.Date) >= NumberConstant.Zero);
            }
            if (endDate != null)
            {
                predicateForBL = predicateForBL.And((p) => DateTime.Compare(p.IdDocumentNavigation.DocumentDate.Date, endDate.Value.Date) <= NumberConstant.Zero);
            }

            IQueryable<DocumentLine> queryDocumentLineNotBilled = _entityDocumentLineRepo.GetAllAsNoTracking().Where(predicateForBL)
                                                                  .Include(r => r.IdDocumentNavigation)
                                                                  .ThenInclude(r => r.IdTiersNavigation)
                                                                  .Include(r => r.IdDocumentNavigation)
                                                                  .ThenInclude(r => r.IdUsedCurrencyNavigation);
            // Return a new type of object containing the calcul of the receivable amounts for each financial commitment
            List<TiersTreasuryReport> totalAmountFromDocumentLineByTiers = new List<TiersTreasuryReport>();
            if (queryDocumentLineNotBilled != null && queryDocumentLineNotBilled.Any())
            {
                totalAmountFromDocumentLineByTiers = queryDocumentLineNotBilled
                                    .Select(s => new TiersTreasuryReport
                                    {
                                        IdTiers = (int)s.IdDocumentNavigation.IdTiers,
                                        TotalAmount = s.TtcTotalLine.Value,
                                        TotalAmountWithCurrency = s.TtcTotalLineWithCurrency.Value,
                                        TotalOverduePaymentAmount = 0,
                                        TotalOverduePaymentAmountWithCurrency = 0,
                                        TotalTurnover = s.TtcTotalLine.Value,
                                        TotalTurnoverWithCurrency = s.TtcTotalLineWithCurrency.Value
                                    }).ToList();
            }
            return totalAmountFromDocumentLineByTiers;
        }

        /// <summary>
        /// Get financial commitment outstanding report
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <param name="idTiers"></param>
        /// <param name="tiersType"></param>
        /// <returns></returns>
        List<TiersTreasuryReport> GenerateFinancialCommitmentOutstandingReport(DateTime? StartDate, DateTime? EndDate, int? idTiers, int tiersType)
        {
            // Build the predicate for financial commitment which provides from invoices that meet the following requirements:
            // - the invoices must be: purchase or sales or asset
            // - the invoice status must be: valid or partiaalySatisfied or totallySatisfied 
            string DocumentTypeInvoice = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoice : DocumentEnumerator.PurchaseInvoice;
            string DocumentTypeAsset = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoiceAsset : DocumentEnumerator.PurchaseAsset;
            Expression<Func<FinancialCommitment, bool>> predicateFinancialCommitmentWhere =
                                                  (p) => (p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentTypeInvoice.ToLower()
                                                           || p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentTypeAsset.ToLower()
                                                         )
                                                         && (p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                                                             || p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied
                                                             || p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied
                                                         );
            // Add filters
            if (idTiers != null)
            {
                predicateFinancialCommitmentWhere = predicateFinancialCommitmentWhere.And((p) => p.IdTiers.HasValue && p.IdTiers.Value == idTiers);
            }
            if (StartDate != null)
            {
                predicateFinancialCommitmentWhere = predicateFinancialCommitmentWhere.And((p) => DateTime.Compare(p.CommitmentDate.Date, StartDate.Value.Date) >= NumberConstant.Zero);
            }
            if (EndDate != null)
            {
                predicateFinancialCommitmentWhere = predicateFinancialCommitmentWhere.And((p) => DateTime.Compare(p.CommitmentDate.Date, EndDate.Value.Date) <= NumberConstant.Zero);
            }

            IQueryable<FinancialCommitment> queryFinancialCommitment = _entityFinancialCommitment.GetAllAsNoTracking()
                                                                           .Where(predicateFinancialCommitmentWhere)
                                                                           .Include(r => r.IdTiersNavigation)
                                                                           .Include(r => r.IdDocumentNavigation)
                                                                           .ThenInclude(r => r.IdTiersNavigation);

            // Return a new type of object containing the calcul of the receivable amounts for each financial commitment
            List<TiersTreasuryReport> totalAmountFromFinancialCommitmentByTiers = new List<TiersTreasuryReport>();
            if (queryFinancialCommitment != null && queryFinancialCommitment.Any())
            {
                totalAmountFromFinancialCommitmentByTiers = queryFinancialCommitment
                                     .Select(s => new TiersTreasuryReport
                                     {
                                         IdTiers = (int)s.IdTiers,
                                         TotalAmount = s.RemainingAmount > 0 ? (
                                                        (!s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase))
                                                     ? s.RemainingAmount : -s.RemainingAmount) : 0,

                                         TotalAmountWithCurrency = s.RemainingAmount > 0 ? (
                                                        (!s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase))
                                                     ? s.RemainingAmountWithCurrency.Value : -s.RemainingAmountWithCurrency.Value) : 0,

                                         TotalOverduePaymentAmount = (s.RemainingAmount > 0 && s.CommitmentDate.Date.BeforeDateLimitIncluded(DateTime.Now.Date)) ? (
                                                        (!s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase))
                                                     ? s.RemainingAmount : 0) : 0,

                                         TotalOverduePaymentAmountWithCurrency = (s.RemainingAmount > 0 && s.CommitmentDate.Date.BeforeDateLimitIncluded(DateTime.Now.Date)) ? (
                                                        (!s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase))
                                                     ? s.RemainingAmountWithCurrency.Value : 0) : 0,

                                         TotalTurnover = !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase)
                                                     ? s.Amount.Value : -s.Amount.Value,

                                         TotalTurnoverWithCurrency = !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoiceAsset, StringComparison.OrdinalIgnoreCase)
                                                        && !s.IdDocumentNavigation.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseAsset, StringComparison.OrdinalIgnoreCase)
                                                     ? s.AmountWithCurrency.Value : -s.AmountWithCurrency.Value
                                     }).ToList();
            }
            return totalAmountFromFinancialCommitmentByTiers;
        }

        /// <summary>
        /// FinancialCommitmentInReceivableExpandedRows
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="tiersType"></param>
        /// <param name="documentType"></param>
        /// <returns></returns>
        public FinancialCommitmentForReceivableReducedViewModel FinancialCommitmentInReceivableExpandedRows(PredicateFormatViewModel predicateModel, int tiersType, int documentType)
        {
            OutstandingFinancialCommitmentResultViewModel result = GetFinancialCommitmentOrAssetsOutstandingDocumentList(predicateModel, tiersType, documentType);
            FinancialCommitmentForReceivableReducedViewModel dataResult = new FinancialCommitmentForReceivableReducedViewModel();
            dataResult.Data = new List<dynamic>();
            result.Data.ToList().ForEach((x) =>
            {
                dynamic model = new ExpandoObject();
                model.Code = x.Code;
                model.CommitmentDate = x.CommitmentDate;
                model.AmountWithCurrency = x.AmountWithCurrency;
                model.RemainingAmountWithCurrency = x.RemainingAmountWithCurrency;
                model.CurrencyCode = x.IdCurrencyNavigation.Code;
                model.CurrencyPrecision = x.IdCurrencyNavigation.Precision;
                dataResult.Data.Add(model);
            });
            dataResult.Total = result.Total;
            return dataResult;
        }
        #endregion
    }
}
