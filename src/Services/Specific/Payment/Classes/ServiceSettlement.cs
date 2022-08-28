using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ModelView.Payment;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Reporting.Interfaces;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Treasury.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;

namespace Services.Specific.Payment.Classes
{
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    public class ServiceSettlement : Service<SettlementViewModel, Settlement>, IServiceSettlement
    {
        #region constants
        private const string Module = "Payment";
        private const string Directory = "Settlement";
        private const string CERTIFICAT_RT = "Certificat_RT_";
        private const string PDF = "pdf";
        private const string SETTLEMENT_WITHHOLDING_TAX_REPOT = "SettlementWithholdingTax";
        private const int MAX_WITHHOLDING_TAX = 1000;
        private const double COMMODITY_POURCENTAGE = 1.5;
        #endregion

        #region fields
        internal readonly IRepository<SettlementCommitment> _repoSettlementCommitment;
        internal readonly ISettlementCommitmentBuilder _settlementCommitmentBuilder;
        internal readonly IRepository<FinancialCommitment> _repoFinancialCommitment;
        internal readonly IDocumentBuilder _documentBuilder;
        internal readonly IRepository<Document> _repoDocument;
        internal readonly IServiceFinancialCommitment _serviceFinancialCommitment;
        internal readonly IServiceDocument _serviceDocument;
        internal readonly IServiceCurrencyRate _serviceCurrencyRate;
        internal readonly IServiceCurrency _serviceCurrency;
        internal readonly IServiceSettlementCommitment _serviceSettlementCommitment;
        internal readonly IServicePaymentMethod _servicePaymentMethod;
        internal readonly IRepository<Tiers> _repoTiers;
        internal readonly IRepository<ReflectiveSettlement> _repoReflective;
        internal readonly IServiceCompany _serviceCompany;
        internal readonly IPaymentMethodBuilder _paymentMethodBuilder;
        internal readonly IFinancialCommitmentBuilder _financialCommitmentBuilder;
        internal readonly IServiceReflectiveSettlement _serviceReflectiveSettlement;
        internal readonly IServiceDocumentWithholdingTax _serviceDocumentWithholdingTax;
        internal readonly IRepository<DocumentWithholdingTax> _repoDocumentWithholdingTax;
        internal readonly IDocumentWithholdingTaxBuilder _documentWithholdingTaxBuilder;
        internal readonly IReducedSettlementBuilder _reducedBuilder;
        private IServiceJasperReporting _serviceJasperReporting;
        internal readonly IRepository<BankAccount> _repoBankAccount;
        private readonly ILogger<Settlement> _logger;
        private readonly IServiceSettlementDocumentWithholdingTax _serviceSettlementDocumentWithholdingTax;
        private readonly ISettlementBuilder _settlementBuilder;
        private readonly IServiceTicketPayment _serviceTicketPayment;
        private readonly ITicketPaymentBuilder _ticketPaymentBuilder;
        #endregion

        #region constructor
        public ServiceSettlement(IRepository<Settlement> entityRepo, IRepository<SettlementCommitment> repoSettlementCommitment,
            IUnitOfWork unitOfWork, ISettlementCommitmentBuilder settlementCommitmentBuilder, IDocumentBuilder documentBuilder,
            IRepository<FinancialCommitment> repoFinancialCommitment,
            ISettlementBuilder builder, IServicePaymentMethod servicePaymentMethod,
            IRepository<Entity> entityRepoEntity, IOptions<AppSettings> appSettings, IRepository<Document> repoDocument, IServiceSettlementCommitment serviceSettlementCommitment,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Tiers> entityRepoTiers,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Company> entityRepoCompany,
            IServiceFinancialCommitment serviceFinancialCommitment, IServiceDocument serviceDocument,
            IServiceCurrencyRate serviceCurrencyRate,
            IServiceCurrency serviceCurrency,
            IServiceCompany serviceCompany,
            IFinancialCommitmentBuilder financialCommitmentBuilder,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
            IRepository<ReflectiveSettlement> repoReflective,
            IPaymentMethodBuilder paymentMethodBuilder,
            IServiceReflectiveSettlement serviceReflectiveSettlement,
            IServiceDocumentWithholdingTax serviceDocumentWithholdingTax,
            IRepository<DocumentWithholdingTax> repoDocumentWithholdingTax,
            IDocumentWithholdingTaxBuilder documentWithholdingTaxBuilder,
            IServiceJasperReporting serviceJasperReporting,
            IRepository<BankAccount> repoBankAccount,
            ILogger<Settlement> logger,
            IReducedSettlementBuilder reducedSettlementBuilder,
            IServiceSettlementDocumentWithholdingTax serviceSettlementDocumentWithholdingTax,
            IServiceTicketPayment serviceTicketPayment, ITicketPaymentBuilder ticketPaymentBuilder)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
            entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _repoFinancialCommitment = repoFinancialCommitment;
            _repoSettlementCommitment = repoSettlementCommitment;
            _settlementCommitmentBuilder = settlementCommitmentBuilder;
            _documentBuilder = documentBuilder;
            _repoDocument = repoDocument;
            _serviceFinancialCommitment = serviceFinancialCommitment;
            _serviceDocument = serviceDocument;
            _serviceCurrencyRate = serviceCurrencyRate;
            _serviceCurrency = serviceCurrency;
            _serviceSettlementCommitment = serviceSettlementCommitment;
            _servicePaymentMethod = servicePaymentMethod;
            _repoTiers = entityRepoTiers;
            _repoReflective = repoReflective;
            _serviceCompany = serviceCompany;
            _paymentMethodBuilder = paymentMethodBuilder;
            _financialCommitmentBuilder = financialCommitmentBuilder;
            _serviceReflectiveSettlement = serviceReflectiveSettlement;
            _serviceDocumentWithholdingTax = serviceDocumentWithholdingTax;
            _documentWithholdingTaxBuilder = documentWithholdingTaxBuilder;
            _serviceJasperReporting = serviceJasperReporting;
            _repoBankAccount = repoBankAccount;
            _repoDocumentWithholdingTax = repoDocumentWithholdingTax;
            _reducedBuilder = reducedSettlementBuilder;
            _logger = logger;
            _serviceSettlementDocumentWithholdingTax = serviceSettlementDocumentWithholdingTax;
            _settlementBuilder = builder;
            _serviceTicketPayment = serviceTicketPayment;
            _ticketPaymentBuilder = ticketPaymentBuilder;
        }
        #endregion

        #region generic method
        public override object AddModel(SettlementViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();
                Tiers tiers = _repoTiers.FindBy(x => x.Id == model.IdTiers).FirstOrDefault();
                IList<FinancialCommitmentViewModel> financialCommitments = new List<FinancialCommitmentViewModel>();
                model.SettlementCommitment.ToList().ForEach(p => financialCommitments.Add(p.Commitment));
                model.SettlementCommitment.Clear();
                // verify settlement Amount != 0
                if (model.AmountWithCurrency.IsApproximately(0, within: 0.0001))
                {
                    throw new CustomException(CustomStatusCode.SettlementAmountIsZero);
                }
                // verify if settlement amount = sum of financial commitment allocated amount
                if (!model.AmountWithCurrency.IsApproximately(financialCommitments
                                                                .Where(p => p.IdStatus != (int)DocumentStatusEnumerator.TotallySatisfied)
                                                                .Sum(p => p.AllocatedAmountWithCurrency).Value,
                                                                within: 0.0001))
                {
                    throw new CustomException(CustomStatusCode.SettlementAmountIsGreaterThanSelectedCommitment);
                }

                // get document
                Document document = _repoDocument.GetSingleNotTracked(p => p.Id == financialCommitments.FirstOrDefault().IdDocument);

                if (tiers.PaymentDelay != null)
                {
                    var PaymentDate = document.DocumentDate.AddDays((double)tiers.PaymentDelay);
                    if (tiers.IdTypeTiers == 1 && (PaymentDate.CompareTo(model.SettlementDate) < 0))
                    {
                        throw new CustomException(CustomStatusCode.INVALID_SETTELMENT_DATE);
                    }
                }

                int precision = _serviceDocument.GetPrecissionValue(document.IdUsedCurrency.Value, document.DocumentTypeCode);

                var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, model.SettlementDate, document.ExchangeRate);
                // model calculate amount + currency
                model.IdUsedCurrency = document.IdUsedCurrency.Value;
                model.IdTiers = document.IdTiers.Value;
                model.ExchangeRate = exchangeRate;
                model.Amount = (exchangeRate > 0) ? exchangeRate * model.AmountWithCurrency : model.AmountWithCurrency;

                //recalculate financial commitment remaining amount && assign financial commitment to settlement
                _serviceFinancialCommitment.UpdateAffectedFinancialCommitment(financialCommitments, precision, exchangeRate, model, entityAxisValuesModelList, userMail);
                // Manage files
                ManageFiles(model);
                // add settlement
                object item = AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                // update Document
                _serviceDocument.UpdateDocumentAfterAddSettlement(model, document, precision, exchangeRate);
                EndTransaction();
                return item;
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // throw the error
                VerifyDuplication(e);
                throw;
            }
        }
        /// <summary>
        /// Save Pictures and update the attachement Url
        /// </summary>
        /// <param name="model"></param>
        private void ManageFiles(SettlementViewModel model)
        {
            // Settlement attachment file
            if (string.IsNullOrEmpty(model.AttachmentUrl))
            {
                if (model.ObservationsFilesInfo != null && model.ObservationsFilesInfo.Count > 0)
                {
                    model.AttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            else
            {
                if (model.ObservationsFilesInfo != null)
                {
                    DeleteFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            // With holding tax attachment file
            if (string.IsNullOrEmpty(model.WithholdingTaxAttachmentUrl))
            {
                if (model.WithholdingTaxObservationsFilesInfo != null && model.WithholdingTaxObservationsFilesInfo.Count > 0)
                {
                    model.WithholdingTaxAttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                }
            }
            else
            {
                if (model.WithholdingTaxObservationsFilesInfo != null)
                {
                    DeleteFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                    CopyFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                }
            }
        }

        public IList<SettlementViewModel> GetDocumentSettlements(int idDocument)
        {
            IList<FinancialCommitmentViewModel> financialCommitments = _serviceFinancialCommitment.GetFinancialCommitmentOfCurrentDocument(idDocument).ToList();
            IList<SettlementViewModel> settlementViewModels = new List<SettlementViewModel>();
            if (financialCommitments == null || !financialCommitments.Any())
            {
                return settlementViewModels;
            }
            foreach (FinancialCommitmentViewModel financialCommitment in financialCommitments)
            {
                IList<SettlementCommitmentViewModel> settlementCommitmentViewModels =
                    _serviceSettlementCommitment.GetAllModelsQueryable(p => p.CommitmentId == financialCommitment.Id, r => r.Settlement).ToList();

                settlementCommitmentViewModels.ToList().ForEach(p =>
                {
                    if (!settlementViewModels.Any(c => c.Id == p.Settlement.Id))
                    {
                        p.Settlement.IdPaymentMethodNavigation = _servicePaymentMethod.FindModelBy(c => c.Id == p.Settlement.IdPaymentMethod).SingleOrDefault();
                        settlementViewModels.Add(p.Settlement);
                    }
                });
            }
            return settlementViewModels;
        }

        public List<DocumentPaymentHistoryViewModel> GetDocumentPaymentHisotry(int idDocument)
        {
            List<DocumentPaymentHistoryViewModel> documentPaymentHistoryViewModels = new List<DocumentPaymentHistoryViewModel>();
            // Get all payments of the invoice
            List<SettlementCommitment> settlementCommitment = _repoSettlementCommitment.GetAllWithConditionsRelationsQueryable(x =>
                                                              x.Commitment.IdDocument == idDocument
                                                              && !x.Settlement.HasBeenReplaced
                                                              && x.AssignedAmountWithCurrency > 0)
                                                                .Include(x => x.Settlement)
                                                                .ThenInclude(x => x.IdPaymentMethodNavigation)
                                                                .Include(x => x.Settlement)
                                                                .ThenInclude(x => x.IdTiersNavigation)
                                                                .Include(x => x.Settlement)
                                                                .ThenInclude(x => x.IdUsedCurrencyNavigation)
                                                                .Include(x => x.Commitment)
                                                                .ThenInclude(x => x.IdDocumentNavigation)
                                                                .ToList();
            settlementCommitment.ToList().ForEach(
                x =>
                {
                    DocumentPaymentHistoryViewModel documentPaymentHistoryViewModel = new DocumentPaymentHistoryViewModel();
                    documentPaymentHistoryViewModel.Settlement = _builder.BuildEntity(x.Settlement);
                    documentPaymentHistoryViewModel.AssignedAmount = x.AssignedAmount;
                    documentPaymentHistoryViewModel.AssignedAmountWithCurrency = x.AssignedAmountWithCurrency;
                    documentPaymentHistoryViewModel.AssignedWithholdingTax = x.AssignedWithholdingTax;
                    documentPaymentHistoryViewModel.AssignedWithholdingTaxWithCurrency = x.AssignedWithholdingTaxWithCurrency;
                    // Get all financial commitments associated to the settlement
                    documentPaymentHistoryViewModel.SettlementCommitmentsAssociatedToSettlement = _repoSettlementCommitment.GetAllWithConditionsRelationsQueryableAsNoTracking(y =>
                                                                                     y.SettlementId == x.SettlementId)
                                                                                    .Include(y => y.Commitment)
                                                                                    .ThenInclude(y => y.IdDocumentNavigation)
                                                                                    .Include(y => y.Settlement)
                                                                                    .Select(y => _settlementCommitmentBuilder.BuildEntity(y))
                                                                                    .ToList();
                    documentPaymentHistoryViewModels.Add(documentPaymentHistoryViewModel);
                }
           );
            return documentPaymentHistoryViewModels;
        }

        /// <summary>
        /// Get all payment of the financial commitment
        /// </summary>
        /// <param name="idFinancialCommitment"></param>
        /// <returns></returns>
        public List<SettlementCommitmentViewModel> GetFinancialCommitmentPaymentHistory(int idFinancialCommitment)
        {
            List<SettlementCommitment> settlementCommitment = _repoSettlementCommitment.GetAllWithConditionsRelationsQueryable(x => !x.Settlement.HasBeenReplaced && x.CommitmentId == idFinancialCommitment)
                                                                .Include(x => x.Settlement)
                                                                .ThenInclude(x => x.IdPaymentMethodNavigation)
                                                                .Include(x => x.Settlement)
                                                                .Include(x => x.Commitment)
                                                                .ThenInclude(x => x.IdDocumentNavigation)
                                                                .Include(x => x.Commitment)
                                                                .ThenInclude(x => x.IdCurrencyNavigation)
                                                                .Include(x => x.Settlement)
                                                                .ThenInclude(x => x.IdTiersNavigation)
                                                                .ToList();

            return settlementCommitment.Select(x => _settlementCommitmentBuilder.BuildEntity(x)).ToList();
        }

        /// <summary>
        /// Delete entity with relations
        /// </summary>
        /// <param name="context"></param>
        /// <param name="entityToDelete"></param>
        /// <param name="tableName"></param>
        /// <param name="releatedTableName"></param>
        public override void DeleteRecursive(dynamic context, dynamic entityToDelete, string tableName, string releatedTableName, string userMail)
        {
            base.DeleteRecursive((Object)context, (Object)entityToDelete, tableName, releatedTableName, userMail);
            if (entityToDelete is Settlement)
            {
                Settlement settlementEntity = entityToDelete;
                if (settlementEntity?.SettlementCommitment != null && settlementEntity.SettlementCommitment.Any())
                {
                    //Fetch list of SettlementCommitment and change AllocatedAmount, AllocatedAmountWithCurrency, RemainingAmount, RemainingAmountWithCurrency of financialCommitment
                    foreach (SettlementCommitment settlementCommitment in settlementEntity.SettlementCommitment)
                    {
                        if (settlementCommitment.CommitmentId != 0 && settlementCommitment.Commitment == null)
                        {
                            FinancialCommitment financialCommitment = _repoFinancialCommitment.GetSingle(p => p.Id == settlementCommitment.CommitmentId);
                            //Add AssignedAmount to RemainingAmount 
                            financialCommitment.RemainingAmount = financialCommitment.RemainingAmount + settlementCommitment.AssignedAmount.Value;
                            //Add AssignedAmountWithCurrency to RemainingAmountWithCurrency
                            financialCommitment.RemainingAmountWithCurrency = financialCommitment.RemainingAmountWithCurrency + settlementCommitment.AssignedAmountWithCurrency.Value;
                            //Update financialCommitment
                            _repoFinancialCommitment.Update(financialCommitment);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public override DataSourceResult<SettlementViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<SettlementViewModel> dataSourceResult = base.FindDataSourceModelBy(predicateModel);
            if (dataSourceResult != null && dataSourceResult.data != null)
            {
                foreach (SettlementViewModel settlement in dataSourceResult.data.OfType<SettlementViewModel>())
                {
                    // if settelment is Valide or Solde ==> set CanDelete and CanEdit CanValidate to false
                    if (settlement.IdStatus.Value == ((int)DocumentStatusEnumerator.Valid) || settlement.IdStatus.Value == ((int)DocumentStatusEnumerator.Balanced))
                    {
                        settlement.CanEdit = false;
                        settlement.CanValidate = false;
                        settlement.CanDelete = false;
                    }
                    // if settelment is Provisoire ==> set CanShow to false
                    else
                    {
                        settlement.CanShow = false;
                    }

                    if (settlement.SettlementCommitment != null)
                    {
                        foreach (SettlementCommitmentViewModel settlementCommitment in settlement.SettlementCommitment)
                        {
                            if (settlementCommitment != null && settlementCommitment.CommitmentId != 0 && settlementCommitment.Commitment == null)
                            {
                                FinancialCommitment financialCommitment = _repoFinancialCommitment.GetSingle(p => p.Id == settlementCommitment.CommitmentId);

                                settlementCommitment.Commitment = _financialCommitmentBuilder.BuildEntity(financialCommitment);
                            }
                            // if settlement contains FinancialCommitment with status Valide or Solde ==> set CanDelete to false
                            if (settlementCommitment.Commitment != null && settlementCommitment.Commitment.IdStatus != 0 && settlementCommitment.Commitment.IdStatus == ((int)DocumentStatusEnumerator.Balanced))
                            {
                                settlement.CanDelete = false;
                            }
                        }
                    }
                }
            }
            return dataSourceResult;
        }
        public override IList<SettlementViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IList<SettlementViewModel> model = base.FindModelBy(predicateModel);
            if (model.Any())
            {
                SettlementViewModel price = model.First();
                //attach list of file to current document
                price.FilesInfos = GetFilesContent(price.AttachmentUrl);
            }
            return model;
        }
        public override object UpdateModel(SettlementViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                var result = new Object();
                if (model != null)
                {
                    result = base.UpdateModel(model, entityAxisValuesModelList, userMail);
                    //Delete files from directory
                    DeleteUploadedFiles(model.AttachmentUrl, model.UploadedFiles);
                    //Copy files to specific url
                    if (model.Files != null && model.Files.Any())
                    {
                        CopyFiles(model.AttachmentUrl, model.Files);
                    }
                    //Delete directory if list of file in current directory null
                    DeleteDirectoryFiles(model.AttachmentUrl);

                }
                return result;
            }
            catch (CustomException)
            {
                throw;
            }
        }
        public void UpdateSettlement(ReducedSettlementList model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                if (model != null)
                {
                    if (VerifyIfSettlementIsCashedOrIsLinkedToPaymentSlipOrReconciliation(model))
                    {
                        throw new CustomException();
                    }
                    // manage files
                    ManageFiles(model);
                    SettlementViewModel settlementViewModel = GetModelAsNoTracked(x => x.Id == model.Id);
                    settlementViewModel.CommitmentDate = model.CommitmentDate;
                    settlementViewModel.SettlementDate = model.SettlementDate;
                    settlementViewModel.SettlementReference = model.SettlementReference;
                    settlementViewModel.Holder = model.Holder;
                    settlementViewModel.Label = model.Label;
                    settlementViewModel.IssuingBank = model.IssuingBank;
                    dynamic entity = _builder.BuildModel(settlementViewModel);

                    // recuperate entity before update
                    // update entity
                    _entityRepo.Update(entity);

                    // commit 
                    _unitOfWork.Commit();
                }
            }
            catch (CustomException)
            {
                throw new CustomException(CustomStatusCode.SettlementCannotBeModified);
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }
        private bool VerifyIfSettlementIsCashedOrIsLinkedToPaymentSlipOrReconciliation(ReducedSettlementList settlementViewModel)
        {
            return settlementViewModel != null && (
                        (settlementViewModel.IdPaymentSlip.HasValue && settlementViewModel.IdPaymentSlip.Value > 0)
                    || (settlementViewModel.IdReconciliation.HasValue && settlementViewModel.IdBankAccount.Value > 0)
                    || (settlementViewModel.IdPaymentStatus == (int)PaymentStatusEnumerators.Canceled));
        }


        /// <summary>
        /// Return true if the settlement is linked to paymentSlip or is reconciled otherwise return false 
        /// </summary>
        /// <param name="settlementViewModel"></param>
        /// <returns></returns>
        private bool VerifyIfSettlementIsCashedOrIsLinkedToPaymentSlipOrReconciliation(SettlementViewModel settlementViewModel)
        {
            return settlementViewModel != null && (
                        (settlementViewModel.IdPaymentSlip.HasValue && settlementViewModel.IdPaymentSlip.Value > 0)
                    || (settlementViewModel.IdReconciliation.HasValue && settlementViewModel.IdBankAccount.Value > 0)
                    || (settlementViewModel.IdPaymentStatus == (int)PaymentStatusEnumerators.Canceled));
        }

        public override object UpdateModelWithoutTransaction(SettlementViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model != null)
            {
                // update collection entity                
                UpdateSettlementCommitment(model, entityAxisValuesModelList, userMail);
                // build entity
                dynamic entity = _builder.BuildModel(model);

                // recuperate entity before update
                PredicateFormatViewModel predicate = new PredicateFormatViewModel
                {
                    Filter = new List<FilterViewModel> { new FilterViewModel { Prop = Constants.ID, Value = entity.Id } }
                };
                Expression<Func<Settlement, bool>> predicateWhere = PredicateUtility<Settlement>.PredicateFilter(predicate, Operator.And);
                dynamic entityBeforeUpdate = _entityRepo.FindByAsNoTracking(predicateWhere).SingleOrDefault();
                // Get saved AttachmentUrl
                if (entityBeforeUpdate.AttachmentUrl != null && entityBeforeUpdate.AttachmentUrl != "")
                {
                    model.AttachmentUrl = entityBeforeUpdate.AttachmentUrl;
                }
                else
                {
                    // Add url of attachment files
                    model.AttachmentUrl = Path.Combine("Payment", "Settlement", DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff"));
                }
                // update entity
                _entityRepo.Update(entity);

                // update entityAxesValues
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);

                // commit 
                _unitOfWork.Commit();
                return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
            }
            return new CreatedDataViewModel();
        }

        private void UpdateSettlementCommitment(SettlementViewModel entity, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            foreach (SettlementCommitmentViewModel settlmentCommitment in entity.SettlementCommitment.ToList())
            {
                // settlementCommitment already exist 
                if (settlmentCommitment.Id != 0)
                {
                    // settlementCommitment already exist && is checked && had an assigned amount
                    if (settlmentCommitment.IsChecked && !settlmentCommitment.AssignedAmountWithCurrency.Value.IsApproximately(0, within: 0.0001))
                    {
                        // update commitment
                        _repoFinancialCommitment.Update(_financialCommitmentBuilder.BuildModel(settlmentCommitment.Commitment));
                        // update settlementCommitment
                        _repoSettlementCommitment.Update(_settlementCommitmentBuilder.BuildModel(settlmentCommitment));
                    }
                    else
                    {
                        // update commitment
                        _repoFinancialCommitment.Update(_financialCommitmentBuilder.BuildModel(settlmentCommitment.Commitment));
                        // delete settlementCommitment
                        settlmentCommitment.IsDeleted = true;
                        settlmentCommitment.DeletedToken = Guid.NewGuid().ToString();
                        _repoSettlementCommitment.Update(_settlementCommitmentBuilder.BuildModel(settlmentCommitment));
                    }
                }
                else
                {
                    // new settlementCommitment (is checked and had an assigned amount)
                    if (settlmentCommitment.IsChecked && !settlmentCommitment.AssignedAmountWithCurrency.Value.IsApproximately(0, within: 0.0001))
                    {
                        // update commitment
                        _repoFinancialCommitment.Update(_financialCommitmentBuilder.BuildModel(settlmentCommitment.Commitment));
                        // add settlementCommitment
                        settlmentCommitment.SettlementId = entity.Id;
                        _repoSettlementCommitment.Add(_settlementCommitmentBuilder.BuildModel(settlmentCommitment));
                    }
                }
                entity.SettlementCommitment.Remove(settlmentCommitment);
            }
            entity.SettlementCommitment.Clear();
        }

        public object ValidateSettlement(int idSettlement, string userMail)
        {
            try
            {
                BeginTransaction();
                List<int> invoiceId = new List<int>();
                Settlement settlement = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(c => c.Id == idSettlement, c => c.SettlementCommitment).FirstOrDefault();
                /********************* Settle Commitment if remaining amount is 0 *******************************/
                foreach (SettlementCommitment settlementCommitment in settlement.SettlementCommitment)
                {
                    // get commitment
                    FinancialCommitment financialCommitment = _repoFinancialCommitment.GetSingle(p => p.Id == settlementCommitment.CommitmentId);
                    if (financialCommitment.RemainingAmountWithCurrency.Value.IsApproximately(0, within: 0.0001))
                    {
                        // Settle commitment
                        financialCommitment.IdStatus = (int)DocumentStatusEnumerator.Balanced;
                        // update commitment
                        _repoFinancialCommitment.Update(financialCommitment);
                        invoiceId.Add(financialCommitment.IdDocument.Value);
                    }
                }
                /********************* Setlle Invoice (If all its commitments are settled) *******************************/
                invoiceId = invoiceId.Distinct().ToList();
                foreach (int id in invoiceId)
                {
                    Document document = _repoDocument.GetSingleWithRelations(p => p.Id == id, c => c.FinancialCommitment);
                    // If all its commitments are settled
                    if (document.FinancialCommitment.Count(p => p.IdStatus == (int)DocumentStatusEnumerator.Balanced) ==
                        document.FinancialCommitment.Count)
                    {
                        // Settle invoice 
                        document.IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced;
                        _repoDocument.Update(document);
                    }
                }
                /*********************  validate settlement *******************************/
                settlement.IdStatus = (int)DocumentStatusEnumerator.Valid;
                _entityRepo.Update(settlement);
                // commit 
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel { Id = settlement.Id, Code = "" };
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }
        public override DataSourceResult<SettlementViewModel> GetDataWithSpecificFilterRelation(PredicateFormatViewModel predicateModel, IQueryable<Settlement> entities, PredicateFilterRelationViewModel<Settlement> predicateFilterRelationModel)
        {
            // Add specific relations (include in entities)
            if (predicateModel.SpecificRelation != null && predicateModel.SpecificRelation.Any())
            {
                foreach (string specificRelation in predicateModel.SpecificRelation)
                {
                    entities = entities.Include(specificRelation);
                }
            }

            // Add specific filter to entities search
            if (predicateModel.SpecFilter != null && predicateModel.SpecFilter.Any())
            {
                foreach (SpecificFilterViewModel specificFilter in predicateModel.SpecFilter)
                {
                    dynamic specificService = GetService(specificFilter.Module, specificFilter.Model);
                    if (specificService == null)
                    {
                        throw new Exception("Can't instanciate the service!");
                    }
                    else
                    {
                        List<dynamic> dataOfCurrentEntityToFilter = new List<dynamic>();
                        dataOfCurrentEntityToFilter.AddRange(specificService.FindNoTrackedModelBy((List<FilterViewModel>)specificFilter.Predicate.Filter));
                        List<int> ids = dataOfCurrentEntityToFilter
                            .Where(y => y.GetType().GetProperty(specificFilter.PropertyOfParentEntity).GetValue(y) != null)
                            .Select(y => (int)(y.GetType().GetProperty(specificFilter.PropertyOfParentEntity).GetValue(y))).ToList();

                        if (predicateModel.Operator == Operator.And)
                        {
                            entities = entities.Where(x => ids.Contains((int)x.GetType().GetProperty("Id").GetValue(x)));
                        }
                        else
                        {
                            //get id exclut ids of entities
                            List<int> idsEntities = entities.Select(x => (int)x.GetType().GetProperty("Id").GetValue(x)).ToList();
                            if (ids != null && ids.Any())
                            {
                                List<int> idsSpecificFiltersEntities;
                                if (idsEntities != null && idsEntities.Any())
                                {
                                    idsSpecificFiltersEntities = ids.Where(x => !idsEntities.Contains(x)).ToList();
                                }
                                else
                                {
                                    idsSpecificFiltersEntities = ids;
                                }

                                if (idsSpecificFiltersEntities != null && idsSpecificFiltersEntities.Any())
                                {
                                    IQueryable<Settlement> entitiesToAdd = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
                                                   .Where(x => idsSpecificFiltersEntities.Contains((int)x.GetType().GetProperty("Id").GetValue(x))).AsQueryable();
                                    if (entitiesToAdd != null && entitiesToAdd.Count() > 0)
                                    {
                                        entities = entities.Concat(entitiesToAdd).OrderByRelation(predicateModel.OrderBy);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            var total = entities.Count();
            var sum = entities.Sum(x => x.Amount);
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = entities.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
            }

            List<SettlementViewModel> model = entities.ToList().Select(_builder.BuildEntity).ToList();

            return new DataSourceResult<SettlementViewModel> { data = model, total = total, sum = sum };
        }
        #endregion

        /********************************************************   Generate Settlement From Customer Outstanding   ********************************************************/
        #region Settlement generation From Customer Outstanding & withholding Tax 

        /// <summary>
        /// Generate Settlement from Financial Commitment selected in Custormer Outstanding
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public async Task<SettlementViewModel> GenerateSettlementFromCustomerOutstanding(IntermediateSettlementGeneration model, string userMail, bool isDepositSettlement = false)
        {
            try
            {
                if (model != null)
                {
                    BeginTransaction();
                    // Invoices commitments and payments commitments
                    List<FinancialCommitmentViewModel> invoiceFinancialCommitments = new List<FinancialCommitmentViewModel>();
                    List<FinancialCommitmentViewModel> assetsFinancialCommitments = new List<FinancialCommitmentViewModel>(); // Assets commitments only
                    PrepareFinancialCommitmentAndSettlementList(model, ref invoiceFinancialCommitments, ref assetsFinancialCommitments);
                    // Order the documents which will be settled in descending order of seniority
                    invoiceFinancialCommitments = invoiceFinancialCommitments.OrderBy(x => x.CommitmentDate).ToList();
                    if (invoiceFinancialCommitments.Any())
                    {
                        // Calculate Amounts with currency 
                        var tiers = _repoTiers.GetSingleWithRelationsNotTracked(x => x.Id == model.Settlement.IdTiers, x => x.IdCurrencyNavigation);
                        int tiersCurrencyPrecision = tiers.IdCurrencyNavigation.Precision;
                        int companyCurrencyPrecision = GetCompanyCurrencyPrecision();
                        var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(tiers.IdCurrency ?? 0, model.Settlement.SettlementDate);

                        // Prepare the settlement Info 
                        SettlementViewModel settlementToGenerate = PrepareSettlementToGenerate(model, tiers, tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate);

                        settlementToGenerate.SettlementCommitment = new List<SettlementCommitmentViewModel>();
                        // Sold all assets & update assets 
                        double totalAmountAssets = SoldAssets(assetsFinancialCommitments, invoiceFinancialCommitments, settlementToGenerate, tiersCurrencyPrecision, companyCurrencyPrecision,
                                                   exchangeRate, userMail);

                        // Sold all Financials commitments (invoices, payment) and settlement selected
                        double SettlementToGenerateInitialAmount = settlementToGenerate.AmountWithCurrency;
                        settlementToGenerate.AmountWithCurrency = AmountMethods.FormatValue((settlementToGenerate.AmountWithCurrency + totalAmountAssets), tiersCurrencyPrecision);
                        List<SettlementViewModel> settlementList = new List<SettlementViewModel> { settlementToGenerate };
                        SettlementViewModel gapSettlement = null;
                        if (model.GapValue != 0 && (model.GapManagementMethod == (int)(SettlementGapMethodEnumerator.LossGap) || model.GapManagementMethod == (int)(SettlementGapMethodEnumerator.GainGap)))
                        {
                            gapSettlement = CreateTheGapSettlement(settlementToGenerate, model, tiersCurrencyPrecision, companyCurrencyPrecision);
                            settlementList.Add(gapSettlement);
                        }

                        // Calculate Remaining Amount for every Financial commitment 
                        List<FinancialCommitmentViewModel> financialCommitmentsChanged = SoldFinancialCommitmentAndSettlement(settlementList, settlementToGenerate.WithholdingTax.Value,
                            invoiceFinancialCommitments, tiersCurrencyPrecision, companyCurrencyPrecision, userMail);
                        List<FinancialCommitmentViewModel> financialCommitmentsNotPaid = invoiceFinancialCommitments.Except(financialCommitmentsChanged,
                                                           new EntityComparator<FinancialCommitmentViewModel>()).ToList();

                        // Calculate remaining Withholding Tax For every financial commitment
                        List<FinancialCommitmentViewModel> listFinancialCommitmentToUpdate = SoldWithholdingTax(settlementToGenerate, financialCommitmentsChanged, financialCommitmentsNotPaid,
                            tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate);

                        // update the FinancialCommitment & assets 
                        listFinancialCommitmentToUpdate.AddRange(assetsFinancialCommitments);
                        if (listFinancialCommitmentToUpdate.Count == 1 && listFinancialCommitmentToUpdate.First().IdDocumentNavigation != null)
                        {
                            listFinancialCommitmentToUpdate.First().IdDocumentNavigation = null;
                            var ctx = _unitOfWork.GetContext();
                            var attachedDL = ctx.ChangeTracker.Entries<FinancialCommitment>().FirstOrDefault(e => e.Entity.Id == listFinancialCommitmentToUpdate.First().Id);
                            if (attachedDL != null)
                            {
                                ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                            }
                        }
                        _serviceFinancialCommitment.BulkUpdateModelWithoutTransaction(listFinancialCommitmentToUpdate, userMail);

                        // Update DocumentWithholdingTax 
                        List<SettlementCommitmentViewModel> settlementCommitments = settlementToGenerate.SettlementCommitment.Where(y => y.AssignedWithholdingTaxWithCurrency.HasValue
                                                                                    && y.AssignedWithholdingTaxWithCurrency.Value > 0).ToList();
                        settlementToGenerate.SettlementDocumentWithholdingTax = ConfigureDocumentWithholdingTax(settlementCommitments,
                            tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate, userMail);

                        // add the settlement
                        settlementToGenerate.AmountWithCurrency = SettlementToGenerateInitialAmount;
                        settlementToGenerate.IsDepositSettlement = isDepositSettlement;
                        settlementToGenerate.Id = ((CreatedDataViewModel)base.AddModelWithoutTransaction(settlementToGenerate, null, userMail, null)).Id;

                        // Add ReflectiveSettlement relation if gap value > 0
                        if (gapSettlement != null)
                        {
                            gapSettlement.Id = ((CreatedDataViewModel)base.AddModelWithoutTransaction(gapSettlement, null, userMail, null)).Id;
                            ReflectiveSettlementViewModel refelectiveSettlement = new ReflectiveSettlementViewModel
                            {
                                IdSettlement = settlementToGenerate.Id,
                                IdGapSettlement = gapSettlement.Id
                            };
                            _serviceReflectiveSettlement.AddModelWithoutTransaction(refelectiveSettlement, null, userMail, null);
                        }

                        // list of documents which must be checked after modification
                        List<int> DocumentIds = listFinancialCommitmentToUpdate.Where(x => x.IdDocument.HasValue).Select(x => x.IdDocument.Value).ToList().Distinct().ToList();
                        VerifyDocumentStatusAndWithholdingTax(DocumentIds, tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate);
                        _unitOfWork.Commit();
                        EndTransaction();
                        return settlementToGenerate;
                    }
                }
                return null;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        /// <summary>
        /// Generate Settlement from Tickets selected in Custormer Outstanding
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public async Task<SettlementViewModel> GenerateSettlementFromTicket(IntermediateSettlementGeneration model, string userMail)
        {
            try
            {
                if (model != null)
                {
                    BeginTransaction();
                    // Invoices commitments
                    List<FinancialCommitmentViewModel> invoiceFinancialCommitments = new List<FinancialCommitmentViewModel>();
                    List<FinancialCommitmentViewModel> assetsFinancialCommitments = new List<FinancialCommitmentViewModel>(); // Assets commitments only
                    PrepareFinancialCommitmentAndSettlementList(model, ref invoiceFinancialCommitments, ref assetsFinancialCommitments);

                    if (invoiceFinancialCommitments.Any())
                    {
                        // Calculate Amounts with currency 
                        var tiers = _repoTiers.GetSingleWithRelationsNotTracked(x => x.Id == model.Settlement.IdTiers, x => x.IdCurrencyNavigation);
                        int tiersCurrencyPrecision = tiers.IdCurrencyNavigation.Precision;
                        int companyCurrencyPrecision = GetCompanyCurrencyPrecision();
                        var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(tiers.IdCurrency ?? 0, model.Settlement.SettlementDate);

                        // Prepare the settlement Info 
                        SettlementViewModel settlementToGenerate = PrepareSettlementToGenerate(model, tiers, tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate);

                        settlementToGenerate.SettlementCommitment = new List<SettlementCommitmentViewModel>();


                        // Sold all Financials commitments (invoices, payment) and settlement selected
                        double SettlementToGenerateInitialAmount = settlementToGenerate.AmountWithCurrency;
                        settlementToGenerate.AmountWithCurrency = AmountMethods.FormatValue(settlementToGenerate.AmountWithCurrency, tiersCurrencyPrecision);
                        List<SettlementViewModel> settlementList = new List<SettlementViewModel> { settlementToGenerate };
                        SettlementViewModel gapSettlement = null;
                        if (model.GapValue != 0 && (model.GapManagementMethod == (int)(SettlementGapMethodEnumerator.LossGap) || model.GapManagementMethod == (int)(SettlementGapMethodEnumerator.GainGap)))
                        {
                            gapSettlement = CreateTheGapSettlement(settlementToGenerate, model, tiersCurrencyPrecision, companyCurrencyPrecision);
                            settlementList.Add(gapSettlement);
                        }

                        // Calculate Remaining Amount for every Financial commitment 
                        List<ReducedTicketViewModel> tickets = model.SelectedTicket;
                        List<TicketPaymentViewModel> ticketPayment = _serviceTicketPayment.FindByAsNoTracking(x => tickets.Select(y => y.IdPaymentTicket).Contains(x.Id)).ToList();
                        List<FinancialCommitmentViewModel> financialCommitmentsChanged = SoldFinancialCommitmentAndSettlementForPos(ref tickets, ticketPayment, settlementList,
                            invoiceFinancialCommitments, tiersCurrencyPrecision, companyCurrencyPrecision);
                        List<FinancialCommitmentViewModel> financialCommitmentsNotPaid = invoiceFinancialCommitments.Except(financialCommitmentsChanged,
                                                           new EntityComparator<FinancialCommitmentViewModel>()).ToList();



                        _serviceFinancialCommitment.BulkUpdateModelWithoutTransaction(financialCommitmentsChanged, userMail);

                        _serviceTicketPayment.BulkUpdateModelWithoutTransaction(tickets.Select(x => x.TicketPayment).ToList(), userMail);

                        // Update DocumentWithholdingTax 
                        List<SettlementCommitmentViewModel> settlementCommitments = settlementToGenerate.SettlementCommitment.Where(y => y.AssignedWithholdingTaxWithCurrency.HasValue
                                                                                    && y.AssignedWithholdingTaxWithCurrency.Value > 0).ToList();
                        settlementToGenerate.SettlementDocumentWithholdingTax = ConfigureDocumentWithholdingTax(settlementCommitments,
                            tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate, userMail);

                        // add the settlement
                        settlementToGenerate.AmountWithCurrency = SettlementToGenerateInitialAmount;
                        settlementToGenerate.Id = ((CreatedDataViewModel)base.AddModelWithoutTransaction(settlementToGenerate, null, userMail, null)).Id;

                        // Add ReflectiveSettlement relation if gap value > 0
                        if (gapSettlement != null)
                        {
                            gapSettlement.Id = ((CreatedDataViewModel)base.AddModelWithoutTransaction(gapSettlement, null, userMail, null)).Id;
                            ReflectiveSettlementViewModel refelectiveSettlement = new ReflectiveSettlementViewModel
                            {
                                IdSettlement = settlementToGenerate.Id,
                                IdGapSettlement = gapSettlement.Id
                            };
                            _serviceReflectiveSettlement.AddModelWithoutTransaction(refelectiveSettlement, null, userMail, null);
                        }

                        // list of documents which must be checked after modification
                        List<int> DocumentIds = financialCommitmentsChanged.Where(x => x.IdDocument.HasValue).Select(x => x.IdDocument.Value).ToList().Distinct().ToList();
                        VerifyDocumentStatusAndWithholdingTax(DocumentIds, tiersCurrencyPrecision, companyCurrencyPrecision, exchangeRate);
                        _unitOfWork.Commit();
                        EndTransaction();
                        return settlementToGenerate;
                    }
                }
                return null;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }
        public async Task<SettlementViewModel> ReGenerateWithholdingTaxCertificatAsync(int id, string userMail)
        {
            SettlementViewModel settlement = GetModelAsNoTracked(x => x.Id == id);
            settlement.WithholdingTaxObservationsFilesInfo = GetFiles(settlement.WithholdingTaxAttachmentUrl).ToList();
            if (settlement.WithholdingTaxObservationsFilesInfo != null)
            {
                DeleteFiles(settlement.WithholdingTaxAttachmentUrl, settlement.WithholdingTaxObservationsFilesInfo);
                settlement.WithholdingTaxObservationsFilesInfo = null;
            }
            await GenerateWithholdingTaxReportAsync(settlement, userMail).ConfigureAwait(true);
            // upload files after updating backup directory
            settlement.WithholdingTaxObservationsFilesInfo = GetFiles(settlement.WithholdingTaxAttachmentUrl).ToList();
            return settlement;
        }
        public async Task GenerateWithholdingTaxReportAsync(SettlementViewModel settlementToGenerate, string userMail)
        {
            try
            {
                if (settlementToGenerate != null && settlementToGenerate.WithholdingTax > 0 && (settlementToGenerate.WithholdingTaxObservationsFilesInfo == null ||
                    (settlementToGenerate.WithholdingTaxObservationsFilesInfo != null && settlementToGenerate.WithholdingTaxObservationsFilesInfo.Count == 0)))
                {
                    FileInfoViewModel file = await GenerateCertificateFile(settlementToGenerate, userMail).ConfigureAwait(true);
                    settlementToGenerate.WithholdingTaxObservationsFilesInfo = new List<FileInfoViewModel> { file };
                    // Manage with holding tax attachment files
                    if (file != null)
                    {
                        CopyFiles(settlementToGenerate.WithholdingTaxAttachmentUrl, new List<FileInfoViewModel> { file });
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError("Exception from {1} layer. \r Main error: {2}. \r Inner Exception : {3}. \r Trace : {4}",
                   typeof(Settlement).Name, ex.Message, ex.InnerException, ex.StackTrace);
            }

        }

        public async Task<FileInfoViewModel> GenerateCertificateFile(SettlementViewModel settlement, string userMail)
        {
            if (settlement != null)
            {
                dynamic apiParams = new ExpandoObject();
                apiParams.idSettlement = settlement.Id;
                StringBuilder fileName = new StringBuilder();
                fileName.Append(CERTIFICAT_RT);
                fileName.Append(settlement.Code);
                fileName.Append('_');
                fileName.Append(DateTime.Now.ToString("dd-MM-yyyy-HH-mm-ss", CultureInfo.InvariantCulture));
                DownloadReportDataViewModel data = new DownloadReportDataViewModel()
                {
                    ReportName = SETTLEMENT_WITHHOLDING_TAX_REPOT,
                    DocumentName = fileName.ToString(),
                    ReportType = PDF,
                    ReportFormatName = PDF,
                    Reportparameters = JsonConvert.SerializeObject(apiParams),
                };
                data.Reportparameters = JsonConvert.DeserializeObject(data.Reportparameters);
                return await _serviceJasperReporting.ExecuteJasperReport(data, userMail).ConfigureAwait(true);
            }
            return null;
        }
        public void VerifyDocumentStatusAndWithholdingTax(List<int> DocumentIds, int tiersPrecision, int companyPrecision, double exchangeRate)
        {
            if (DocumentIds.Any())
            {
                // Update Documents status
                List<Document> ListDocuments = _repoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => DocumentIds.Contains(x.Id),
                     x => x.FinancialCommitment).ToList().Distinct().ToList();
                ChangeDocumentStatusAfterChangingFinancialCommitmentStatus(ListDocuments, tiersPrecision, companyPrecision, exchangeRate);
                // verify if all withholding Tax has been paid in case of document has changed to Totally Satisfied
                ListDocuments.ToList().ForEach(x =>
                {
                    if (x.FinancialCommitment != null && x.FinancialCommitment.Any())
                    {
                        var totalRemainingWithholdingTax = x.FinancialCommitment.Where(y => y.RemainingWithholdingTaxWithCurrency.HasValue).Sum(y => y.RemainingWithholdingTaxWithCurrency.Value);
                        totalRemainingWithholdingTax += x.FinancialCommitment.Where(y => y.RemainingVatWithholdingTaxWithCurrency.HasValue).Sum(y => y.RemainingVatWithholdingTaxWithCurrency.Value);
                        totalRemainingWithholdingTax = Math.Round(totalRemainingWithholdingTax, tiersPrecision);
                        if (x.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied && totalRemainingWithholdingTax > 0)
                        {
                            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                                    {
                                         { Constants.DOCUMENT_CODE, x.Code },
                                         { Constants.WITHHOLDING_TAX, totalRemainingWithholdingTax }
                                    };
                            throw new CustomException(CustomStatusCode.unpaidWithholdingTax, paramtrs);
                        }
                    }
                });
            }
        }

        public List<SettlementDocumentWithholdingTaxViewModel> ConfigureDocumentWithholdingTax(List<SettlementCommitmentViewModel> settlementCommitments, int tiersPrecision, int companyPrecision,
            double exchangeRate, string UserMail)
        {
            if (settlementCommitments != null && settlementCommitments.Any())
            {
                List<SettlementDocumentWithholdingTaxViewModel> settlementDocumentWithholdingTaxList = new List<SettlementDocumentWithholdingTaxViewModel>();
                List<int> financialCommitmentsIds = settlementCommitments.Select(x => x.CommitmentId).ToList();
                List<FinancialCommitmentViewModel> financialCommitments = _serviceFinancialCommitment.FindModelsByNoTracked(x => financialCommitmentsIds.Contains(x.Id)).ToList();
                List<int> documentsIds = financialCommitments.Select(x => x.IdDocument.Value).ToList();
                List<DocumentWithholdingTaxViewModel> documentWithholdingTaxViewModels = _repoDocumentWithholdingTax.GetAllWithConditionsRelationsQueryableAsNoTracking(
                                                                                          x => documentsIds.Contains(x.IdDocument))
                                                                                         .Include(x => x.IdWithholdingTaxNavigation)
                                                                                         .Include(x => x.SettlementDocumentWithholdingTax)
                                                                                         .ToList().Select(_documentWithholdingTaxBuilder.BuildEntity).ToList();
                settlementCommitments.ForEach(x =>
                {
                    double remainingAmount = AmountMethods.FormatValue(x.AssignedWithholdingTaxWithCurrency.Value, tiersPrecision);
                    FinancialCommitmentViewModel financialCommitment = financialCommitments.Where(y => y.Id == x.CommitmentId).FirstOrDefault();
                    List<DocumentWithholdingTaxViewModel> documentWithholdingTaxRelatedToCommitment = documentWithholdingTaxViewModels
                    .Where(y => y.IdDocument == financialCommitment.IdDocument && y.RemainingWithholdingTaxWithCurrency.HasValue).ToList();
                    while (remainingAmount > 0 && documentWithholdingTaxRelatedToCommitment.Where(y => y.RemainingWithholdingTaxWithCurrency.Value > 0).Any())
                    {
                        DocumentWithholdingTaxViewModel documentWithholdingTax = null;
                        if (documentWithholdingTaxRelatedToCommitment.Where(y => y.IdWithholdingTaxNavigation.Type == (int)WithholdingTaxType.Ttc && y.RemainingWithholdingTaxWithCurrency.Value > 0).Any())
                        {
                            documentWithholdingTax = documentWithholdingTaxRelatedToCommitment.Where(y => y.IdWithholdingTaxNavigation.Type == (int)WithholdingTaxType.Ttc && y.RemainingWithholdingTaxWithCurrency.Value > 0).FirstOrDefault();
                        }
                        else
                        {
                            documentWithholdingTax = documentWithholdingTaxRelatedToCommitment.Where(y => y.IdWithholdingTaxNavigation.Type == (int)WithholdingTaxType.Vat && y.RemainingWithholdingTaxWithCurrency.Value > 0).FirstOrDefault();
                        }

                        SettlementDocumentWithholdingTaxViewModel settlementDocumentWithholdingTax = new SettlementDocumentWithholdingTaxViewModel();
                        settlementDocumentWithholdingTax.IdDocumentWithholdingTax = documentWithholdingTax.Id;
                        if (remainingAmount >= documentWithholdingTax.RemainingWithholdingTaxWithCurrency.Value)
                        {
                            settlementDocumentWithholdingTax.AssignedWithholdingTaxWithCurrency = AmountMethods.FormatValue(documentWithholdingTax.RemainingWithholdingTaxWithCurrency.Value, tiersPrecision);
                            remainingAmount = AmountMethods.FormatValue((remainingAmount - documentWithholdingTax.RemainingWithholdingTaxWithCurrency.Value), tiersPrecision);
                            documentWithholdingTax.RemainingWithholdingTaxWithCurrency = 0;
                            documentWithholdingTax.RemainingWithholdingTax = 0;
                            settlementDocumentWithholdingTax.TotalAmountWithCurrency = calculateTheLastTotalAmountDocumentWithholdingTax(documentWithholdingTax, settlementDocumentWithholdingTaxList, tiersPrecision);
                        }
                        else
                        {
                            settlementDocumentWithholdingTax.AssignedWithholdingTaxWithCurrency = remainingAmount;
                            documentWithholdingTax.RemainingWithholdingTaxWithCurrency = AmountMethods.FormatValue((documentWithholdingTax.RemainingWithholdingTaxWithCurrency - remainingAmount), tiersPrecision);
                            documentWithholdingTax.RemainingWithholdingTax = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? documentWithholdingTax.RemainingWithholdingTaxWithCurrency.Value * exchangeRate : documentWithholdingTax.RemainingWithholdingTaxWithCurrency.Value), companyPrecision);
                            settlementDocumentWithholdingTax.TotalAmountWithCurrency = AmountMethods.FormatValue((remainingAmount / (documentWithholdingTax.IdWithholdingTaxNavigation.Percentage / 100)), tiersPrecision);
                            remainingAmount = 0;
                        }
                        settlementDocumentWithholdingTax.TotalAmount = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? settlementDocumentWithholdingTax.TotalAmountWithCurrency * exchangeRate : settlementDocumentWithholdingTax.TotalAmountWithCurrency), companyPrecision);
                        settlementDocumentWithholdingTax.AssignedWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? settlementDocumentWithholdingTax.AssignedWithholdingTaxWithCurrency * exchangeRate : settlementDocumentWithholdingTax.AssignedWithholdingTaxWithCurrency), companyPrecision);
                        settlementDocumentWithholdingTaxList.Add(settlementDocumentWithholdingTax);
                    }
                });
                _serviceDocumentWithholdingTax.BulkUpdateModelWithoutTransaction(documentWithholdingTaxViewModels, UserMail);
                return settlementDocumentWithholdingTaxList;
            }
            return null;
        }

        public double calculateTheLastTotalAmountDocumentWithholdingTax(DocumentWithholdingTaxViewModel documentWithholdingTax,
            List<SettlementDocumentWithholdingTaxViewModel> newSettlementDocumentWithholdingTaxList, int tiersPrecision)
        {
            if (documentWithholdingTax != null)
            {
                double totalAmount = AmountMethods.FormatValue(documentWithholdingTax.AmountWithCurrency, tiersPrecision);
                double totalAmountForOldSettlementDocumentWithholdingTaxList = 0;
                if (documentWithholdingTax.SettlementDocumentWithholdingTax != null && documentWithholdingTax.SettlementDocumentWithholdingTax.Any())
                {
                    List<int> settlementAssociatedAndHasNotBeenReplaced = FindModelsByNoTracked(x => documentWithholdingTax.SettlementDocumentWithholdingTax
                        .Select(y => y.IdSettlement).Contains(x.Id) && !x.HasBeenReplaced).Select(x => x.Id).ToList();
                    totalAmountForOldSettlementDocumentWithholdingTaxList = AmountMethods.FormatValue(documentWithholdingTax.SettlementDocumentWithholdingTax
                        .Where(x => settlementAssociatedAndHasNotBeenReplaced.Contains(x.IdSettlement.Value)).Sum(x => x.TotalAmountWithCurrency), tiersPrecision);
                }
                double totalAmountForNewSettlementDocumentWithholdingTaxList = AmountMethods.FormatValue(newSettlementDocumentWithholdingTaxList
                    .Where(x => x.IdDocumentWithholdingTax == documentWithholdingTax.Id).Sum(x => x.TotalAmountWithCurrency), tiersPrecision);
                return AmountMethods.FormatValue((totalAmount - totalAmountForOldSettlementDocumentWithholdingTaxList - totalAmountForNewSettlementDocumentWithholdingTaxList), tiersPrecision);
            }
            return 0;
        }

        public List<FinancialCommitmentViewModel> SoldWithholdingTax(SettlementViewModel settlement, List<FinancialCommitmentViewModel> changedFinancialCommitment,
           List<FinancialCommitmentViewModel> unpaidFinancialCommitment, int tiersPrecision, int companyPrecision, double exchangeRate)
        {
            if (settlement != null && changedFinancialCommitment != null)
            {
                double withholdingTax = settlement.WithholdingTax.Value;

                List<FinancialCommitmentViewModel> listFinancialCommitmentToSoldIt = new List<FinancialCommitmentViewModel>();

                // add old financial commitment wich has the withholding tax not totally paid 
                List<int> idDocumentsRelated = changedFinancialCommitment.Select(x => x.IdDocument.Value).Distinct().ToList();
                List<FinancialCommitmentViewModel> financialCommitmentTotallyPaid = _serviceFinancialCommitment.FindByAsNoTracking(x =>
                                                                               idDocumentsRelated.Contains(x.IdDocument.Value)
                                                                               && x.RemainingWithholdingTaxWithCurrency.HasValue
                                                                               && x.IdStatus.Value == (int)DocumentStatusEnumerator.TotallySatisfied)
                                                                              .OrderBy(x => x.CommitmentDate)
                                                                              .ToList();

                listFinancialCommitmentToSoldIt.AddRange(financialCommitmentTotallyPaid);
                listFinancialCommitmentToSoldIt.AddRange(changedFinancialCommitment.OrderBy(x => x.CommitmentDate).ToList());
                listFinancialCommitmentToSoldIt.AddRange(unpaidFinancialCommitment);
                double selectedFinancialCommitmentWithohldingTax = listFinancialCommitmentToSoldIt.Where(x => x.RemainingWithholdingTaxWithCurrency.HasValue)
                                                                                                  .Sum(x => x.RemainingWithholdingTaxWithCurrency.Value);
                double selectedFinancialCommitmentVatWithohldingTax = listFinancialCommitmentToSoldIt.Where(x => x.RemainingVatWithholdingTaxWithCurrency.HasValue)
                                                                                                  .Sum(x => x.RemainingVatWithholdingTaxWithCurrency.Value);
                double remainingWithholdingTax = selectedFinancialCommitmentWithohldingTax + selectedFinancialCommitmentVatWithohldingTax;
                List<SettlementCommitmentViewModel> newSettlementCommitmentsToAdd = settlement.SettlementCommitment.ToList();
                while (withholdingTax > 0 && remainingWithholdingTax > 0)
                {
                    // sold ttc withholdingTax first
                    SettlementCommitmentViewModel settlementCommitment;
                    FinancialCommitmentViewModel financialCommitment = listFinancialCommitmentToSoldIt.Where(x => x.RemainingWithholdingTaxWithCurrency > 0).FirstOrDefault();
                    if (financialCommitment != null)
                    {
                        settlementCommitment = newSettlementCommitmentsToAdd.Where(x => x.CommitmentId == financialCommitment.Id).FirstOrDefault();
                        if (settlementCommitment == null)
                        {
                            settlementCommitment = new SettlementCommitmentViewModel
                            {
                                CommitmentId = financialCommitment.Id,
                                AssignedAmount = 0,
                                AssignedAmountWithCurrency = 0
                            };
                            newSettlementCommitmentsToAdd.Add(settlementCommitment);
                        }
                        if (financialCommitment.RemainingWithholdingTaxWithCurrency > withholdingTax)
                        {
                            settlementCommitment.AssignedWithholdingTaxWithCurrency = withholdingTax;
                            financialCommitment.RemainingWithholdingTaxWithCurrency = Math.Round((financialCommitment.RemainingWithholdingTaxWithCurrency.Value - withholdingTax), tiersPrecision);
                            withholdingTax = 0;
                        }
                        else
                        {
                            settlementCommitment.AssignedWithholdingTaxWithCurrency = financialCommitment.RemainingWithholdingTaxWithCurrency.Value;
                            withholdingTax = Math.Round((withholdingTax - financialCommitment.RemainingWithholdingTaxWithCurrency.Value), tiersPrecision);
                            financialCommitment.RemainingWithholdingTaxWithCurrency = 0;
                        }
                        financialCommitment.RemainingWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? financialCommitment.RemainingWithholdingTaxWithCurrency.Value * exchangeRate : financialCommitment.RemainingWithholdingTaxWithCurrency.Value), companyPrecision);
                    }
                    else
                    {
                        financialCommitment = listFinancialCommitmentToSoldIt.Where(x => x.RemainingVatWithholdingTaxWithCurrency > 0).FirstOrDefault();
                        settlementCommitment = newSettlementCommitmentsToAdd.Where(x => x.CommitmentId == financialCommitment.Id).FirstOrDefault();
                        if (settlementCommitment == null)
                        {
                            settlementCommitment = new SettlementCommitmentViewModel
                            {
                                CommitmentId = financialCommitment.Id,
                                AssignedAmount = 0,
                                AssignedAmountWithCurrency = 0,
                                AssignedWithholdingTax = 0,
                                AssignedWithholdingTaxWithCurrency = 0
                            };
                            newSettlementCommitmentsToAdd.Add(settlementCommitment);
                        }
                        if (financialCommitment.RemainingVatWithholdingTaxWithCurrency > withholdingTax)
                        {
                            settlementCommitment.AssignedWithholdingTaxWithCurrency += withholdingTax;
                            financialCommitment.RemainingVatWithholdingTaxWithCurrency = Math.Round((financialCommitment.RemainingVatWithholdingTaxWithCurrency.Value - withholdingTax), tiersPrecision);
                            withholdingTax = 0;
                        }
                        else
                        {
                            settlementCommitment.AssignedWithholdingTaxWithCurrency += financialCommitment.RemainingVatWithholdingTaxWithCurrency.Value;
                            withholdingTax = Math.Round((withholdingTax - financialCommitment.RemainingVatWithholdingTaxWithCurrency.Value), tiersPrecision);
                            financialCommitment.RemainingVatWithholdingTaxWithCurrency = 0;
                        }
                        financialCommitment.RemainingVatWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? financialCommitment.RemainingVatWithholdingTaxWithCurrency.Value * exchangeRate : financialCommitment.RemainingVatWithholdingTaxWithCurrency.Value), companyPrecision);
                    }




                    settlementCommitment.AssignedWithholdingTax = Math.Round(((exchangeRate != null && exchangeRate > 0) ? settlementCommitment.AssignedWithholdingTaxWithCurrency.Value * exchangeRate : settlementCommitment.AssignedWithholdingTaxWithCurrency.Value), companyPrecision);


                    selectedFinancialCommitmentWithohldingTax = listFinancialCommitmentToSoldIt.Where(x => x.RemainingWithholdingTaxWithCurrency.HasValue)
                        .Sum(x => x.RemainingWithholdingTaxWithCurrency.Value);
                    selectedFinancialCommitmentVatWithohldingTax = listFinancialCommitmentToSoldIt.Where(x => x.RemainingVatWithholdingTaxWithCurrency.HasValue)
                                                                                                  .Sum(x => x.RemainingVatWithholdingTaxWithCurrency.Value);
                    remainingWithholdingTax = selectedFinancialCommitmentWithohldingTax + selectedFinancialCommitmentVatWithohldingTax;
                }
                settlement.SettlementCommitment = newSettlementCommitmentsToAdd;
                return listFinancialCommitmentToSoldIt;
            }
            return null;
        }

        public SettlementViewModel PrepareSettlementToGenerate(IntermediateSettlementGeneration model, Tiers tiers, int tiersCurrencyPrecision,
            int companyPrecision, double exchangeRate)
        {
            if (model != null && tiers != null)
            {
                SettlementViewModel settlementToGenerate = model.Settlement;
                // model calculate amounts and ExchangeRate
                settlementToGenerate.IdUsedCurrency = tiers.IdCurrency.Value;
                settlementToGenerate.ExchangeRate = exchangeRate;
                settlementToGenerate.AmountWithCurrency = AmountMethods.FormatValue(settlementToGenerate.AmountWithCurrency, tiersCurrencyPrecision);
                settlementToGenerate.Amount = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? exchangeRate * settlementToGenerate.AmountWithCurrency : settlementToGenerate.AmountWithCurrency), companyPrecision);
                // Create Settlement
                VerifySettlementStatus(settlementToGenerate);
                // Manage settlement attachment files
                if (settlementToGenerate.ObservationsFilesInfo != null && settlementToGenerate.ObservationsFilesInfo.Any())
                {
                    settlementToGenerate.AttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(settlementToGenerate.AttachmentUrl, settlementToGenerate.ObservationsFilesInfo);
                }
                settlementToGenerate.WithholdingTaxAttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                // Manage with holding tax attachment files
                if (settlementToGenerate.WithholdingTaxObservationsFilesInfo != null && settlementToGenerate.WithholdingTaxObservationsFilesInfo.Any())
                {
                    CopyFiles(settlementToGenerate.WithholdingTaxAttachmentUrl, settlementToGenerate.WithholdingTaxObservationsFilesInfo);
                }
                return settlementToGenerate;
            }
            return null;
        }

        public SettlementViewModel CreateTheGapSettlement(SettlementViewModel settlementToGenerate, IntermediateSettlementGeneration model, int tiersPrecision,
            int companyPresicion)
        {
            if (settlementToGenerate != null && model != null)
            {
                // Generate new Settlement with Gap type 
                SettlementViewModel gapSettlement = new SettlementViewModel
                {
                    IdStatus = (int)DocumentStatusEnumerator.TotallySatisfied,
                    IdTiers = settlementToGenerate.IdTiers,
                    IdUsedCurrency = settlementToGenerate.IdUsedCurrency,
                    SettlementDate = settlementToGenerate.SettlementDate,
                    ExchangeRate = settlementToGenerate.ExchangeRate,
                    IdPaymentMethod = _servicePaymentMethod.GetModelAsNoTracked(x => x.Code == PaymentMethodEnumerator.ESP).Id,
                    Type = model.GapManagementMethod,
                    ResidualAmount = 0,
                    ResidualAmountWithCurrency = 0,
                    AmountWithCurrency = AmountMethods.FormatValue(model.GapValue, tiersPrecision)
                };
                gapSettlement.Amount = AmountMethods.FormatValue((settlementToGenerate.ExchangeRate * gapSettlement.AmountWithCurrency), companyPresicion);
                VerifySettlementStatus(gapSettlement);
                return gapSettlement;
            }
            return null;
        }

        // In case there is no gap or there is a gap treated by discount
        public List<FinancialCommitmentViewModel> SoldFinancialCommitmentAndSettlement(List<SettlementViewModel> theNewGeneratedSettlement, double withholdingTax,
           List<FinancialCommitmentViewModel> invoiceFinancialCommitmentsSelected, int tiersPrecision, int companyPrecision, string userMail)
        {
            List<FinancialCommitmentViewModel> financialCommitmentsUpdated = new List<FinancialCommitmentViewModel>();
            if (theNewGeneratedSettlement != null && invoiceFinancialCommitmentsSelected != null)
            {
                // the new settlement 
                theNewGeneratedSettlement.ForEach(
                   x =>
                   {
                       List<SettlementCommitmentViewModel> settlementCommitments = new List<SettlementCommitmentViewModel>();
                       var remainingAmount = AmountMethods.FormatValue(x.AmountWithCurrency, tiersPrecision);
                       while (invoiceFinancialCommitmentsSelected.Any() && invoiceFinancialCommitmentsSelected.Where(y => y.IdStatus != (int)DocumentStatusEnumerator.TotallySatisfied).Any() && remainingAmount > 0)
                       {
                           FinancialCommitmentViewModel financialCommitment = invoiceFinancialCommitmentsSelected.Where(y => y.IdStatus != (int)DocumentStatusEnumerator.TotallySatisfied).FirstOrDefault();
                           SettlementCommitmentViewModel newSettlementCommitment = new SettlementCommitmentViewModel();
                           if (remainingAmount >= financialCommitment.RemainingAmountWithCurrency)
                           {
                               newSettlementCommitment.AssignedAmountWithCurrency = AmountMethods.FormatValue(financialCommitment.RemainingAmountWithCurrency.Value, tiersPrecision);
                               remainingAmount = AmountMethods.FormatValue((remainingAmount - financialCommitment.RemainingAmountWithCurrency.Value), tiersPrecision);
                               // Update the financial commitment 
                               financialCommitment.IdStatus = (int)DocumentStatusEnumerator.TotallySatisfied;
                               financialCommitment.RemainingAmountWithCurrency = 0;
                               financialCommitment.RemainingAmount = 0;
                           }
                           else
                           {
                               newSettlementCommitment.AssignedAmountWithCurrency = remainingAmount;
                               // Update the financial commitment 
                               financialCommitment.IdStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                               financialCommitment.RemainingAmountWithCurrency = AmountMethods.FormatValue((financialCommitment.RemainingAmountWithCurrency - remainingAmount), tiersPrecision);
                               financialCommitment.RemainingAmount = AmountMethods.FormatValue((financialCommitment.RemainingAmountWithCurrency.Value * x.ExchangeRate.Value), companyPrecision);
                               remainingAmount = 0;
                           }
                           // change in list  
                           newSettlementCommitment.CommitmentId = financialCommitment.Id;
                           newSettlementCommitment.AssignedAmount = AmountMethods.FormatValue(newSettlementCommitment.AssignedAmountWithCurrency * x.ExchangeRate, companyPrecision);
                           newSettlementCommitment.ExchangeRate = x.ExchangeRate;
                           settlementCommitments.Add(newSettlementCommitment);
                           newSettlementCommitment.AssignedWithholdingTax = 0;
                           newSettlementCommitment.AssignedWithholdingTaxWithCurrency = 0;
                           financialCommitmentsUpdated.Add(financialCommitment);

                       }
                       x.SettlementCommitment.ToList().AddRange(settlementCommitments);
                       settlementCommitments.AddRange(x.SettlementCommitment);
                       x.SettlementCommitment = settlementCommitments;
                   }
                );
            }
            return financialCommitmentsUpdated.Distinct(new EntityComparator<FinancialCommitmentViewModel>()).ToList();
        }

        public List<FinancialCommitmentViewModel> SoldFinancialCommitmentAndSettlementForPos(ref List<ReducedTicketViewModel> listTickets, List<TicketPaymentViewModel> ticketPayment, List<SettlementViewModel> theNewGeneratedSettlement,
           List<FinancialCommitmentViewModel> invoiceFinancialCommitmentsSelected, int tiersPrecision, int companyPrecision)
        {
            List<FinancialCommitmentViewModel> financialCommitmentsUpdated = new List<FinancialCommitmentViewModel>();
            if (theNewGeneratedSettlement != null && invoiceFinancialCommitmentsSelected != null)
            {
                List<SettlementCommitmentViewModel> settlementCommitments = new List<SettlementCommitmentViewModel>();
                listTickets.ForEach(x =>
                {
                    FinancialCommitmentViewModel financialCommitment = invoiceFinancialCommitmentsSelected.Where(y => y.IdDocument == x.IdInvoice && y.IdStatus != (int)DocumentStatusEnumerator.TotallySatisfied).FirstOrDefault();
                    SettlementCommitmentViewModel newSettlementCommitment = new SettlementCommitmentViewModel();
                    if (financialCommitment.RemainingAmountWithCurrency > x.Amount)
                    {
                        newSettlementCommitment.AssignedAmountWithCurrency = AmountMethods.FormatValue(x.Amount, tiersPrecision);
                        financialCommitment.IdStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                        financialCommitment.RemainingAmountWithCurrency = AmountMethods.FormatValue((financialCommitment.RemainingAmountWithCurrency - x.Amount), tiersPrecision);
                        financialCommitment.RemainingAmount = AmountMethods.FormatValue((financialCommitment.RemainingAmountWithCurrency.Value * theNewGeneratedSettlement[0].ExchangeRate.Value), companyPrecision);
                    }
                    else
                    {
                        newSettlementCommitment.AssignedAmountWithCurrency = AmountMethods.FormatValue(financialCommitment.RemainingAmountWithCurrency.Value, tiersPrecision);
                        financialCommitment.IdStatus = (int)DocumentStatusEnumerator.TotallySatisfied;
                        financialCommitment.RemainingAmountWithCurrency = 0;
                        financialCommitment.RemainingAmount = 0;
                    }
                    x.TicketPayment = ticketPayment.Where(y => y.Id == x.IdPaymentTicket).FirstOrDefault();
                    x.TicketPayment.Status = (int)DocumentStatusEnumerator.TotallySatisfied;
                    x.TicketPayment.IdPaymentTypeNavigation = null;
                    // change in list  
                    newSettlementCommitment.CommitmentId = financialCommitment.Id;
                    newSettlementCommitment.AssignedAmount = AmountMethods.FormatValue(newSettlementCommitment.AssignedAmountWithCurrency * theNewGeneratedSettlement[0].ExchangeRate, companyPrecision);
                    newSettlementCommitment.ExchangeRate = theNewGeneratedSettlement[0].ExchangeRate;
                    if (settlementCommitments.Any() && settlementCommitments.Where(x => x.CommitmentId == newSettlementCommitment.CommitmentId) != null && settlementCommitments.Where(x => x.CommitmentId == newSettlementCommitment.CommitmentId).Any())
                    {
                        settlementCommitments.Where(x => x.CommitmentId == newSettlementCommitment.CommitmentId).First().AssignedAmountWithCurrency += AmountMethods.FormatValue(newSettlementCommitment.AssignedAmountWithCurrency, tiersPrecision);
                        settlementCommitments.Where(x => x.CommitmentId == newSettlementCommitment.CommitmentId).First().AssignedAmount += AmountMethods.FormatValue(newSettlementCommitment.AssignedAmount, companyPrecision);
                    }
                    else
                    {
                        settlementCommitments.Add(newSettlementCommitment);
                    }

                    newSettlementCommitment.AssignedWithholdingTax = 0;
                    newSettlementCommitment.AssignedWithholdingTaxWithCurrency = 0;
                    financialCommitmentsUpdated.Add(financialCommitment);
                });
                theNewGeneratedSettlement[0].SettlementCommitment.ToList().AddRange(settlementCommitments);
                settlementCommitments.AddRange(theNewGeneratedSettlement[0].SettlementCommitment);
                theNewGeneratedSettlement[0].SettlementCommitment = settlementCommitments;

            }
            return financialCommitmentsUpdated.Distinct(new EntityComparator<FinancialCommitmentViewModel>()).ToList();
        }

        public double SoldAssets(List<FinancialCommitmentViewModel> assetFinancialCommitmentsSelected, List<FinancialCommitmentViewModel> invoiceFinancialCommitments,
            SettlementViewModel settlementGenerated, int tiersPrecision, int companyPrecision, double exchangeRate, string userMail)
        {
            if (assetFinancialCommitmentsSelected != null)
            {
                assetFinancialCommitmentsSelected.ForEach(x =>
                {
                    x.RemainingAmountWithCurrency = AmountMethods.FormatValue(x.RemainingAmountWithCurrency, tiersPrecision);
                });
                double totalAmountAssets = AmountMethods.FormatValue(assetFinancialCommitmentsSelected.Sum(x => x.RemainingAmountWithCurrency.Value), tiersPrecision);
                double totalAmountToBePaid = AmountMethods.FormatValue(invoiceFinancialCommitments.Sum(x => x.RemainingAmountWithCurrency.Value), tiersPrecision);
                var diff = AmountMethods.FormatValue((totalAmountToBePaid - totalAmountAssets), tiersPrecision);
                double remainingAmount = 0;
                remainingAmount = diff >= 0 ? totalAmountAssets : totalAmountToBePaid;
                var amountToBeAdd = remainingAmount;
                assetFinancialCommitmentsSelected.ForEach(x =>
                {
                    while (remainingAmount > 0 && x.RemainingAmountWithCurrency > 0)
                    {
                        // Create the relation with the generated settlement
                        SettlementCommitmentViewModel newSettlementCommitment = new SettlementCommitmentViewModel();
                        newSettlementCommitment.CommitmentId = x.Id;
                        newSettlementCommitment.ExchangeRate = exchangeRate;
                        if (remainingAmount >= x.RemainingAmountWithCurrency)
                        {
                            newSettlementCommitment.AssignedAmountWithCurrency = AmountMethods.FormatValue(x.RemainingAmountWithCurrency, tiersPrecision);
                            remainingAmount = AmountMethods.FormatValue((remainingAmount - x.RemainingAmountWithCurrency.Value), companyPrecision);
                            x.IdStatus = (int)DocumentStatusEnumerator.TotallySatisfied;
                            x.RemainingAmountWithCurrency = 0;
                            x.RemainingAmount = 0;
                        }
                        else
                        {
                            newSettlementCommitment.AssignedAmountWithCurrency = AmountMethods.FormatValue(remainingAmount, tiersPrecision);
                            x.IdStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                            x.RemainingAmountWithCurrency = AmountMethods.FormatValue((x.RemainingAmountWithCurrency.Value - remainingAmount), tiersPrecision);
                            x.RemainingAmount = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? x.RemainingAmountWithCurrency.Value * exchangeRate : x.RemainingAmountWithCurrency.Value), companyPrecision);
                            remainingAmount = 0;
                        }
                        newSettlementCommitment.AssignedAmount = AmountMethods.FormatValue(((exchangeRate != null && exchangeRate > 0) ? newSettlementCommitment.AssignedAmountWithCurrency * exchangeRate : newSettlementCommitment.AssignedAmountWithCurrency), companyPrecision);
                        settlementGenerated.SettlementCommitment.Add(newSettlementCommitment);
                    }
                });
                return amountToBeAdd;
            }
            return 0;
        }

        public void PrepareFinancialCommitmentAndSettlementList(IntermediateSettlementGeneration model, ref List<FinancialCommitmentViewModel> invoiceFinancialCommitments,
            ref List<FinancialCommitmentViewModel> assetsFinancialCommitments)
        {
            if (model != null)
            {
                if ((model.SelectedFinancialCommitment != null && model.SelectedFinancialCommitment.Any()) || (model.SelectedTicket != null && model.SelectedTicket.Any()))
                {
                    List<FinancialCommitmentViewModel> financialCommitmentTickets = new List<FinancialCommitmentViewModel>();
                    if (model.SelectedTicket != null && model.SelectedTicket.Any())
                    {
                        financialCommitmentTickets = _serviceFinancialCommitment.FindModelsByNoTracked(x => model.SelectedTicket.Select(x => x.IdInvoice).Contains(x.IdDocument)).ToList();
                    }
                    List<FinancialCommitmentViewModel> financialCommitment = model.SelectedFinancialCommitment != null && model.SelectedFinancialCommitment.Any() ? model.SelectedFinancialCommitment :
                        financialCommitmentTickets;
                    List<int> FinancialSelectedIds = financialCommitment.Select(y => y.Id).ToList();
                    // Get Selected Financial Commitment 
                    var financialCommitmentsSelected = _serviceFinancialCommitment.FindModelsByNoTracked(x => FinancialSelectedIds.Contains(x.Id),
                        x => x.IdDocumentNavigation).ToList();

                    // Verify that selected data has not been deleted after invalidating an invoice
                    var CodeDeleted = financialCommitment.Where(x => FinancialSelectedIds.Except(financialCommitmentsSelected.Select(y => y.Id)).Contains(x.Id)
                    ).Select(x => x.Code).ToList();
                    if (CodeDeleted != null && CodeDeleted.Any())
                    {
                        IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic> { { Constants.DOCUMENT_CODE, CodeDeleted } };
                        throw new CustomException(CustomStatusCode.deletedFinancialCommitments, parameters);
                    }

                    // verify that selected data has not been changed (in amount or withholdingTax or status)
                    if (financialCommitment.Except(financialCommitmentsSelected, new FinancialCommitmentComparer()).Any())
                    {
                        throw new CustomException(CustomStatusCode.selectedFinancialCommitmentsHasBeenChanged);
                    }

                    assetsFinancialCommitments = financialCommitmentsSelected.Where(x => x.IdDocument.HasValue &&
                     (x.IdDocumentNavigation.DocumentTypeCode.Contains(DocumentEnumerator.SalesInvoiceAsset)
                     || x.IdDocumentNavigation.DocumentTypeCode.Contains(DocumentEnumerator.PurchaseAsset))).ToList();

                    invoiceFinancialCommitments = financialCommitmentsSelected.Except(assetsFinancialCommitments, new EntityComparator<FinancialCommitmentViewModel>()).ToList();
                }
            }
        }


        public void VerifySettlementStatus(SettlementViewModel settlement)
        {
            if (settlement != null)
            {
                var paymentMethod = _servicePaymentMethod.GetModelAsNoTracked(x => x.Id == settlement.IdPaymentMethod);
                //// If Cash Or credit card
                //if (paymentMethod.Immediate)
                //{
                //    settlement.IdStatus = (int)DocumentStatusEnumerator.TotallySatisfied;
                //    settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Cashed;
                //    settlement.CommitmentDate = null;
                //}
                //else
                //{
                    settlement.IdStatus = (int)DocumentStatusEnumerator.Provisional;
                    settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Settled;
                //}
            }
        }

        public void ChangeDocumentStatusAfterChangingFinancialCommitmentStatus(List<Document> ListDocuments, int tiersCurrencyPrecision, int companyPrecision, double? exchangeRate = null)
        {
            var ctx = _unitOfWork.GetContext();
            ListDocuments.ToList().ForEach(x =>
            {
                var attachedDL = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == x.Id);
                if (attachedDL != null)
                {
                    ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                }
                var document = ListDocuments.Where(y => y.Id == x.Id).FirstOrDefault();
                if (exchangeRate == null)
                {
                    exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
                }
                var amountToBePaid = document.FinancialCommitment.Sum(y => y.AmountWithoutWithholdingTaxWithCurrency.Value);
                var documentRemainingAmountWithCurrency = Math.Round(document.FinancialCommitment.Sum(z => z.RemainingAmountWithCurrency).Value, tiersCurrencyPrecision);
                var documentRemainingWithholdingTaxWithCurrency = Math.Round(document.FinancialCommitment.Sum(z => z.RemainingWithholdingTaxWithCurrency).Value, tiersCurrencyPrecision);
                // update status
                if (documentRemainingAmountWithCurrency == 0)
                {
                    document.IdDocumentStatus = (int)(DocumentStatusEnumerator.TotallySatisfied);
                }
                else if (documentRemainingAmountWithCurrency < amountToBePaid)
                {
                    document.IdDocumentStatus = (int)(DocumentStatusEnumerator.PartiallySatisfied);
                }
                else
                {
                    document.IdDocumentStatus = (int)(DocumentStatusEnumerator.Valid);
                }
                // update Remaining amounts
                document.DocumentAmountPaidWithCurrency = Math.Round((document.DocumentTtcpriceWithCurrency.Value - documentRemainingAmountWithCurrency
                    - documentRemainingWithholdingTaxWithCurrency), tiersCurrencyPrecision);
                document.DocumentAmountPaid = Math.Round(((exchangeRate > 0) ? exchangeRate * document.DocumentAmountPaidWithCurrency : document.DocumentAmountPaidWithCurrency).Value, companyPrecision);
                var sumRemainingToBePaid = Math.Round(documentRemainingAmountWithCurrency + documentRemainingWithholdingTaxWithCurrency, tiersCurrencyPrecision);
                document.DocumentRemainingAmountWithCurrency = sumRemainingToBePaid > 0 ? sumRemainingToBePaid : 0;
                document.DocumentRemainingAmount = Math.Round(((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentRemainingAmountWithCurrency : document.DocumentRemainingAmountWithCurrency).Value, companyPrecision);
                document.FinancialCommitment = null;
                document.DocumentWithholdingTax = null;
                _repoDocument.Update(document);
            });
        }

        /// <summary>
        /// replace settlement by an other settlement
        /// </summary>
        /// <param name="id"></param>
        public void ReplaceSettlement(int id, string userMail)
        {
            try
            {
                BeginTransaction();
                Settlement settlement = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                                        .Include(x => x.IdTiersNavigation)
                                        .Include(x => x.IdUsedCurrencyNavigation)
                                        .Include(x => x.SettlementCommitment)
                                        .ThenInclude(x => x.Commitment)
                                        .ThenInclude(x => x.IdDocumentNavigation)
                                        .Include(x => x.SettlementDocumentWithholdingTax)
                                        .ThenInclude(x => x.IdDocumentWithholdingTaxNavigation)
                                        .FirstOrDefault();
                if (VerifyIfSettlementIsCashedOrIsLinkedToPaymentSlipOrReconciliation(_builder.BuildEntity(settlement)))
                {
                    throw new CustomException();
                }

                if (!settlement.HasBeenReplaced)
                {
                    int tiersCurrencyPrecision = settlement.IdUsedCurrencyNavigation.Precision;
                    int companyCurrencyPrecision = GetCompanyCurrencyPrecision();
                    // change all financial Commitment status
                    settlement.SettlementCommitment.ToList().ForEach(x =>
                    {
                        if (x.AssignedAmountWithCurrency.HasValue && x.AssignedAmount.HasValue)
                        {
                            x.Commitment.RemainingAmountWithCurrency = Math.Round(x.Commitment.RemainingAmountWithCurrency.Value + x.AssignedAmountWithCurrency.Value, tiersCurrencyPrecision);
                            x.Commitment.RemainingAmount = Math.Round(x.Commitment.RemainingAmount + x.AssignedAmount.Value, companyCurrencyPrecision);
                            x.Commitment.IdStatus = x.Commitment.RemainingAmountWithCurrency == x.Commitment.AmountWithoutWithholdingTaxWithCurrency ? (int)DocumentStatusEnumerator.Valid : (int)DocumentStatusEnumerator.PartiallySatisfied;
                        }
                        if (x.AssignedWithholdingTaxWithCurrency.HasValue && x.AssignedWithholdingTax.HasValue)
                        {
                            x.Commitment.RemainingWithholdingTaxWithCurrency = Math.Round(x.Commitment.RemainingWithholdingTaxWithCurrency.Value + x.AssignedWithholdingTaxWithCurrency.Value, tiersCurrencyPrecision);
                            x.Commitment.RemainingWithholdingTax = Math.Round(x.Commitment.RemainingWithholdingTax.Value + x.AssignedWithholdingTax.Value, companyCurrencyPrecision);
                        }
                    });
                    List<FinancialCommitment> financialCommitments = settlement.SettlementCommitment.Select(x => x.Commitment).ToList();
                    financialCommitments.ForEach(x => { x.IdDocumentNavigation = null; x.SettlementCommitment = null; });
                    _repoFinancialCommitment.BulkUpdate(financialCommitments);
                    _unitOfWork.Commit();
                    if (settlement.SettlementDocumentWithholdingTax != null && settlement.SettlementDocumentWithholdingTax.Any())
                    {

                        // change all documentWithholdingTax 
                        settlement.SettlementDocumentWithholdingTax.ToList().ForEach(x =>
                        {
                            x.IdDocumentWithholdingTaxNavigation.RemainingWithholdingTaxWithCurrency = Math.Round(x.IdDocumentWithholdingTaxNavigation.RemainingWithholdingTaxWithCurrency.Value + x.AssignedWithholdingTaxWithCurrency, tiersCurrencyPrecision);
                            x.IdDocumentWithholdingTaxNavigation.RemainingWithholdingTax = Math.Round(x.IdDocumentWithholdingTaxNavigation.RemainingWithholdingTax.Value + x.AssignedWithholdingTax.Value, companyCurrencyPrecision);
                        });
                        List<DocumentWithholdingTax> documentsWithholdingTax = settlement.SettlementDocumentWithholdingTax.Select(x => x.IdDocumentWithholdingTaxNavigation).ToList();
                        documentsWithholdingTax.ForEach(x => { x.IdDocumentNavigation = null; x.SettlementDocumentWithholdingTax = null; });
                        _repoDocumentWithholdingTax.BulkUpdate(documentsWithholdingTax);
                    }
                    // change document status that has been affected
                    List<int> listDocumentIds = settlement.SettlementCommitment.Select(x => x.Commitment.IdDocument.Value).ToList().Distinct().ToList();
                    if (listDocumentIds.Any())
                    {
                        List<Document> ListDocuments = _repoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => listDocumentIds.Contains(x.Id),
                                     x => x.FinancialCommitment).ToList().Distinct().ToList();
                        ChangeDocumentStatusAfterChangingFinancialCommitmentStatus(ListDocuments, tiersCurrencyPrecision, companyCurrencyPrecision);
                    
                        _serviceTicketPayment.GetAllModelsQueryable().Where(x=> listDocumentIds.Contains(x.IdTicketNavigation.IdInvoice??0)).UpdateFromQuery( x => new TicketPayment
                        {
                            Status = (int)DocumentStatusEnumerator.NotSatisfied,                            
                        });

                    }
                    
                    // Update settlement
                    settlement.SettlementCommitment = null;
                    settlement.SettlementDocumentWithholdingTax = null;
                    settlement.IdUsedCurrencyNavigation = null;
                    // change replaced flag to true
                    settlement.HasBeenReplaced = true;
                    settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Canceled;
                    _entityRepo.Update(settlement);
                    _unitOfWork.Commit();
                    EndTransaction();
                }

            }
            catch (CustomException)
            {
                throw new CustomException(CustomStatusCode.SettlementCannotBeModified);
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

        }


        /// <summary>
        /// Calculate Withholding Tax To Be Paid
        /// </summary>
        /// <param name="SelectedFinancialCommitments"></param>
        /// <returns></returns>
        public double CalculateWithholdingTaxToBePaid(List<int> SelectedFinancialCommitments)
        {
            if (SelectedFinancialCommitments != null && SelectedFinancialCommitments.Any())
            {
                double totalWithholdingTaxForSelectedFinancialCommitment = 0;
                double totalWithholdingTaxForFinancialCommitmentTotallyPaid = 0;
                double totalVatWithholdingTaxForSelectedFinancialCommitment = 0;
                double totalVatWithholdingTaxForFinancialCommitmentTotallyPaid = 0;
                List<FinancialCommitment> financialCommitments = _repoFinancialCommitment.GetAllAsNoTracking().Where(x => SelectedFinancialCommitments.Contains(x.Id)
                                                                        && x.IdDocumentNavigation.DocumentTypeCode.ToLower() != DocumentEnumerator.SalesInvoiceAsset.ToLower()
                                                                        && x.IdDocumentNavigation.DocumentTypeCode.ToLower() != DocumentEnumerator.PurchaseAsset.ToLower()).ToList();

                totalWithholdingTaxForSelectedFinancialCommitment = financialCommitments.Where(x => x.RemainingWithholdingTaxWithCurrency.HasValue).Sum(x => x.RemainingWithholdingTaxWithCurrency.Value);
                totalVatWithholdingTaxForSelectedFinancialCommitment = financialCommitments.Where(x => x.RemainingVatWithholdingTaxWithCurrency.HasValue).Sum(x => x.RemainingVatWithholdingTaxWithCurrency.Value);
                List<int> idDocumentsRelated = financialCommitments.Select(x => x.IdDocument.Value).Distinct().ToList();
                totalWithholdingTaxForFinancialCommitmentTotallyPaid = _serviceFinancialCommitment.GetModelsWithConditionsRelations(x => idDocumentsRelated.Contains(x.IdDocument.Value)
                                                                               && x.RemainingWithholdingTaxWithCurrency.HasValue
                                                                               && x.IdStatus.Value == (int)DocumentStatusEnumerator.TotallySatisfied)
                                                                              .Sum(x => x.RemainingWithholdingTaxWithCurrency.Value);
                totalVatWithholdingTaxForFinancialCommitmentTotallyPaid = _serviceFinancialCommitment.GetModelsWithConditionsRelations(x => idDocumentsRelated.Contains(x.IdDocument.Value)
                                                                               && x.RemainingVatWithholdingTaxWithCurrency.HasValue
                                                                               && x.IdStatus.Value == (int)DocumentStatusEnumerator.TotallySatisfied)
                                                                              .Sum(x => x.RemainingVatWithholdingTaxWithCurrency.Value);
                double totalTtc = totalWithholdingTaxForSelectedFinancialCommitment + totalWithholdingTaxForFinancialCommitmentTotallyPaid;
                double totalVat = totalVatWithholdingTaxForSelectedFinancialCommitment + totalVatWithholdingTaxForFinancialCommitmentTotallyPaid;
                double total = totalTtc + totalVat;
                if (total > 0)
                {
                    CurrencyViewModel currency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == financialCommitments.ElementAt(0).IdCurrency);
                    int tiersPrecision = currency.Precision;
                    return Math.Round(total, tiersPrecision);
                }
            }
            return 0;
        }

        public DocumentViewModel ValidateDocumentAndGenerateSettlemnt(SettlementViewModel settlement, int idDocument, int documentStatus, string userMail)
        {
            DocumentViewModel document = _serviceDocument.ValidateOperation(idDocument, userMail, documentStatus, false, true);
            List<FinancialCommitmentViewModel> listFinancialCmmitment = new List<FinancialCommitmentViewModel>();
            FinancialCommitmentViewModel financialCommiitment = _serviceFinancialCommitment.GetModelWithRelationsAsNoTracked(x => x.IdDocument == document.Id, x => x.IdCurrencyNavigation, y => y.IdDocumentNavigation,
               y => y.IdPaymentMethodNavigation, y => y.IdTiersNavigation);
            listFinancialCmmitment.Add(financialCommiitment);
            IntermediateSettlementGeneration settlementToGenerate = new IntermediateSettlementGeneration()
            {
                SelectedFinancialCommitment = listFinancialCmmitment,
                GapManagementMethod = 1,
                GapValue = 0,
                GetWithholdingTax = false,
                NewFinancialCommitmentDate = null,
                Settlement = settlement

            };
            var settlementG = GenerateSettlementFromCustomerOutstanding(settlementToGenerate, userMail, true);
            return document;
        }


        #endregion

        #region accounting

        public DataSourceResult<SettlementAccounting> GetAccountingSettlement(PredicateFormatViewModel settlementAccountingModel)
        {
            DataSourceResult<SettlementAccounting> dataSourceResult = new DataSourceResult<SettlementAccounting>();
            IQueryable<Settlement> query = null;
            settlementAccountingModel.Operator = Operator.And;
            PredicateFilterRelationViewModel<Settlement> predicateFilterRelationModel = PreparePredicate(settlementAccountingModel);
            predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(x => x.SettlementCommitment.Any());
            query = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
                .Include(x => x.SettlementCommitment).ThenInclude(x => x.Commitment.IdDocumentNavigation)
                .Where(x => x.IdPaymentStatus != (int)PaymentStatusEnumerators.Canceled)
                .OrderByRelation(settlementAccountingModel.OrderBy)
                .AsQueryable();
            var bankFilter = settlementAccountingModel.Filter.Where(x => x.Prop == "bankName");
            if (bankFilter.FirstOrDefault() != null && bankFilter.First().Operation == Operation.Equals)
            {
                query = query.Where(x => x.IdBankAccount != null ?
                     x.IdBankAccountNavigation.Agency.ToLower().Contains(bankFilter.First().Value.ToString().ToLower())
                     : x.IssuingBank.ToLower().Contains(bankFilter.First().Value.ToString().ToLower()));
            }

            if (bankFilter.FirstOrDefault() != null && bankFilter.First().Operation == Operation.Contains)
            {
                query = query.Where(x => x.IdBankAccount != null ?
                     x.IdBankAccountNavigation.Agency.ToLower().Contains(bankFilter.First().Value.ToString().ToLower())
                     : x.IssuingBank.ToLower().Contains(bankFilter.First().Value.ToString().ToLower()));
            }

            if (bankFilter.FirstOrDefault() != null && bankFilter.First().Operation == Operation.StartsWith)
            {
                query = query.Where(x => x.IdBankAccount != null ?
                     x.IdBankAccountNavigation.Agency.ToLower().StartsWith(bankFilter.First().Value.ToString().ToLower())
                     : x.IssuingBank.ToLower().StartsWith(bankFilter.First().Value.ToString().ToLower()));
            }

            if (bankFilter.FirstOrDefault() != null && bankFilter.First().Operation == Operation.EndsWith)
            {
                query = query.Where(x => x.IdBankAccount != null ?
                     x.IdBankAccountNavigation.Agency.ToLower().EndsWith(bankFilter.First().Value.ToString().ToLower())
                     : x.IssuingBank.ToLower().EndsWith(bankFilter.First().Value.ToString().ToLower()));
            }
            dataSourceResult.total = query.Count();
            List<int> settlementIds = query.Select(x => x.Id).ToList();
            List<SettlementDocumentWithholdingTaxViewModel> settlementDocumentWithholdingTaxs = _serviceSettlementDocumentWithholdingTax.GetAllModelsQueryableWithRelation(x => settlementIds.Contains(x.IdSettlement), r => r.IdDocumentWithholdingTaxNavigation).ToList();
            if (settlementAccountingModel.page > 0 && settlementAccountingModel.pageSize > 0)
            {
                query = query.Skip((settlementAccountingModel.page - 1) * settlementAccountingModel.pageSize).Take(settlementAccountingModel.pageSize);
            }

            dataSourceResult.data = query.ToList()
                .Select(s => new SettlementAccounting(_builder.BuildEntity(s), settlementDocumentWithholdingTaxs.Where(x => x.IdSettlement == s.Id).ToList()))
                .ToList();
            return dataSourceResult;
        }
        public DataSourceResult<ReducedSettlementList> GetDataWithSpecificFilter(List<PredicateFormatViewModel> model)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Settlement> entities = null;
            PredicateFilterRelationViewModel<Settlement> predicateFilterRelationModel = null;
            GetDataWithGenericFilterRelation(model, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
            entities = GetEntitiesDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
            var total = entities.Count();
            if (predicateModelWithSpecificFilters.page > 0 && predicateModelWithSpecificFilters.pageSize > 0)
            {
                entities = entities.Skip((predicateModelWithSpecificFilters.page - 1) * predicateModelWithSpecificFilters.pageSize).Take(predicateModelWithSpecificFilters.pageSize);
            }
            List<ReducedSettlementList> models = entities.Select(x => _settlementBuilder.BuildEntityToReducedList(x)).ToList();
            var sum = entities.Sum(x => x.Amount);
            return new DataSourceResult<ReducedSettlementList> { data = models, total = total, sum = sum };
        }

        /// <summary>
        /// Update settlement accounted
        /// </summary>
        /// <param name="idSettlement"></param>
        /// <param name="isAccounted"></param>
        public bool ChangeSettlementAccountedStatus(int idSettlement)
        {
            try
            {
                BeginTransaction();
                Settlement settlement = _entityRepo.FindSingleBy(x => x.Id == idSettlement);
                settlement.IsAccounted = !settlement.IsAccounted;
                _entityRepo.Update(settlement);
                _unitOfWork.Commit();
                EndTransaction();
                return true;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

        }
        private void ManageFiles(ReducedSettlementList model)
        {
            // Settlement attachment file
            if (string.IsNullOrEmpty(model.AttachmentUrl))
            {
                if (model.ObservationsFilesInfo != null && model.ObservationsFilesInfo.Count > 0)
                {
                    model.AttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            else
            {
                if (model.ObservationsFilesInfo != null)
                {
                    DeleteFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            // With holding tax attachment file
            if (string.IsNullOrEmpty(model.WithholdingTaxAttachmentUrl))
            {
                if (model.WithholdingTaxObservationsFilesInfo != null && model.WithholdingTaxObservationsFilesInfo.Count > 0)
                {
                    model.WithholdingTaxAttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                }
            }
            else
            {
                if (model.WithholdingTaxObservationsFilesInfo != null)
                {
                    DeleteFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                    CopyFiles(model.WithholdingTaxAttachmentUrl, model.WithholdingTaxObservationsFilesInfo);
                }
            }
        }
        #endregion

        #region settlement history 

        /// <summary>
        /// GetSettlements list
        /// </summary>
        /// <param name="tiersType"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public SettlementHistoryDataResultViewModel GetSettlements(int tiersType, DateTime? startDate, DateTime? endDate,
            List<int> idInvoices, PredicateFormatViewModel predicateModel)
        {
            SettlementHistoryDataResultViewModel settlementsWithTotal = new SettlementHistoryDataResultViewModel();
            if (predicateModel != null)
            {
                PredicateFilterRelationViewModel<Settlement> predicateFilterRelationModel = PreparePredicate(predicateModel);
                IQueryable<Settlement> query = _entityRepo.GetAllAsNoTracking().Include(x => x.IdTiersNavigation)
                                                                               .Include(x => x.IdPaymentMethodNavigation)
                                                                               .Include(x => x.IdUsedCurrencyNavigation)
                                                                               .Include(x => x.IdPaymentStatusNavigation)
                                                                               .Include(x => x.IdBankAccountNavigation)
                                                                               .ThenInclude(x => x.IdBankNavigation)
                                                                               .Include(x => x.SettlementCommitment)
                                                                               .ThenInclude(x => x.Commitment)
                                                                               .ThenInclude(x => x.IdDocumentNavigation)
                                                                               .Where(predicateFilterRelationModel.PredicateWhere)
                                                                               .Where(x => x.IdTiersNavigation.IdTypeTiers.Equals(tiersType)
                                                                                && x.Type.Equals((int)SettlementTypeEnumerator.Settlement))
                                                                               .OrderByDescending(x => x.Id).AsQueryable();
                if (startDate != null)
                {
                    query = query.Where(x => x.SettlementDate.AfterDateLimitIncluded(startDate.Value));
                }
                if (endDate != null)
                {
                    query = query.Where(x => x.SettlementDate.BeforeDateLimitIncluded(endDate.Value));
                }
                if (idInvoices != null && idInvoices.Any())
                {
                    query = query.Where(x => x.SettlementCommitment.Any(y => y.Commitment.IdDocument.HasValue && idInvoices.Contains(y.Commitment.IdDocument.Value)));
                }


                settlementsWithTotal.TotalAmountOfSettlements = Math.Round(query.Sum(x => x.Amount.Value), GetCompanyCurrencyPrecision());

                settlementsWithTotal.Total = query.Count();
                List<Settlement> settlementsList = query.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();

                List<SettlementViewModel> settlementViewModels = settlementsList.Select(s => _builder.BuildEntity(s)).ToList();
                settlementViewModels.ForEach(x =>
                {
                    x.ObservationsFilesInfo = GetFiles(x.AttachmentUrl).ToList();
                });
                settlementViewModels.ForEach(x =>
                {
                    x.WithholdingTaxObservationsFilesInfo = GetFiles(x.WithholdingTaxAttachmentUrl).ToList();
                });

                settlementsWithTotal.Settlements = settlementViewModels;
            }

            return settlementsWithTotal;
        }

        /// <summary>
        /// Get the invoices mentioned in settlements
        /// </summary>
        /// <param name="tiersType"></param>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public dynamic GetInvoivesBySettlement(int tiersType, PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Settlement> predicateFilterRelationModel = PreparePredicate(predicateModel);
            List<int> settlmentIds = _entityRepo.GetAllWithConditionsQueryable(x => x.IdTiersNavigation.IdTypeTiers.Equals(tiersType)
                                                                            && x.Type.Equals((int)SettlementTypeEnumerator.Settlement))
                                                                           .Where(predicateFilterRelationModel.PredicateWhere).Select(x => x.Id).ToList();
            var documentIdAndCode = _repoSettlementCommitment.QuerableGetAll()
                                             .Include(x => x.Settlement)
                                             .Include(x => x.Commitment)
                                             .ThenInclude(x => x.IdDocumentNavigation)
                                             .Where(x => settlmentIds.Contains(x.SettlementId))
                                             .Select(x => new
                                             {
                                                 Id = x.Commitment.IdDocument,
                                                 Code = x.Commitment.IdDocumentNavigation.Code
                                             }).Distinct().ToList();

            return documentIdAndCode;
        }


        #endregion

        #region Reconciliation
        /// <summary>
        ///  Get bankAccount settlements that can be added in reconciliation  and all that settlement ids
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="unreconciledRegulationsValue"></param>
        /// <param name="reconciledRegulationsValue"></param>
        /// <returns></returns>
        public SettlementForReconciliationResultViewModel GetBankAccountReconciliationSettlement(PredicateFormatViewModel predicateModel, int idBankAccount,
            bool unreconciledRegulations, bool reconciledRegulations)
        {
            SettlementForReconciliationResultViewModel dataResult = new SettlementForReconciliationResultViewModel();

            if (predicateModel == null)
            {
                throw new Exception();
            }

            // Build gridState predicate
            PredicateFilterRelationViewModel<Settlement> predicateWhereRelation = PreparePredicate(predicateModel);

            // Build predicate for bankAccount reconciliation
            Expression<Func<Settlement, bool>> expression = (x) => unreconciledRegulations &&
                                        ((x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer &&
                                                x.IdPaymentStatus == (int)PaymentStatusEnumerators.InBank
                                                && x.IdPaymentSlip.HasValue
                                                && x.IdPaymentSlipNavigation.IdBankAccount == idBankAccount
                                                && x.IdPaymentSlipNavigation.State ==
                                                (int)PaymentSlipStatusEnumerator.PaymentSlipBankFeedBack
                                            )
                                        || (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier
                                                && x.IdBankAccount.HasValue && x.IdBankAccount.Value == idBankAccount
                                                && (x.IdPaymentStatus == (int)PaymentStatusEnumerators.Settled
                                                    ||
                                                    x.IdPaymentStatus == (int)PaymentStatusEnumerators.Unpaid)
                                            )
                                        )

                                        || (reconciledRegulations &&
                                            x.IdBankAccount == idBankAccount
                                                    && x.IdPaymentStatus == (int)PaymentStatusEnumerators.Cashed);

            predicateWhereRelation.PredicateWhere = predicateWhereRelation.PredicateWhere.And(expression);

            IQueryable<Settlement> settlementQuery = _entityRepo.GetAllAsNoTracking()
                .Where(predicateWhereRelation.PredicateWhere)
                .OrderByRelation(predicateModel.OrderBy)
                .Include(r => r.IdPaymentSlipNavigation)
                .Include(r => r.IdTiersNavigation)
                .Include(r => r.IdUsedCurrencyNavigation).AsQueryable();

            IQueryable<Settlement> data = settlementQuery.Skip((predicateModel.page - 1) * predicateModel.pageSize)
                                                            .Take(predicateModel.pageSize).AsQueryable();
            List<Settlement> settlementResult = data.ToList();
            dataResult.Data = settlementResult.Select(_reducedBuilder.BuildEntity).ToList();
            dataResult.Total = settlementQuery.Count();
            dataResult.AllSettlementIds = settlementQuery.Select(x => x.Id).ToList();
            return dataResult;
        }

        /// <summary>
        ///  Get the bank account previsionnel sold
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public BankAccountPrevisionnelSoldViewModel GetBankAccountPrevisionnelSold(int idBankAccount)
        {
            BankAccountPrevisionnelSoldViewModel result = new BankAccountPrevisionnelSoldViewModel();

            if (idBankAccount <= 0)
            {
                throw new Exception();
            }
            // Get the company currency
            CurrencyViewModel currentCompany = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;

            // Get the current bank account sold
            BankAccount model = _repoBankAccount.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == idBankAccount).FirstOrDefault();
            result.CurrentBalance = model != null ? Math.Round(model.CurrentBalance, currentCompany.Precision) : NumberConstant.Zero;

            // Calcul the cumul of unreconciled regulations of the bankAccount
            IQueryable<Settlement> queySettlements = _entityRepo.GetAllAsNoTracking()
                                                                .Where(x => (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer &&
                                                                                x.IdPaymentStatus == (int)PaymentStatusEnumerators.InBank
                                                                                && x.IdPaymentSlip.HasValue
                                                                                && x.IdPaymentSlipNavigation.IdBankAccount == model.Id
                                                                                && x.IdPaymentSlipNavigation.State ==
                                                                                    (int)PaymentSlipStatusEnumerator.PaymentSlipBankFeedBack
                                                                            )
                                                                        || (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier
                                                                                && x.IdBankAccount.HasValue && x.IdBankAccount.Value == model.Id
                                                                                && (x.IdPaymentStatus == (int)PaymentStatusEnumerators.Settled
                                                                                    ||
                                                                                x.IdPaymentStatus == (int)PaymentStatusEnumerators.Unpaid)
                                                                            ))
                                                                .Include(r => r.IdPaymentSlipNavigation).AsQueryable();

            double cumulOfUnreconciledRegulations = Math.Round((queySettlements.Where(x => x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer)
                                                                               .Sum(x => x.Amount.Value)
                                                               - queySettlements.Where(x => x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier)
                                                                            .Sum(x => x.Amount.Value)), currentCompany.Precision);

            result.CumulOfUnreconciledRegulations = Math.Round(cumulOfUnreconciledRegulations, currentCompany.Precision);

            // Calcul the forecast balance of the bank account
            result.ForecastBalance = Math.Round(model.CurrentBalance + cumulOfUnreconciledRegulations, currentCompany.Precision);

            return result;
        }

        /// <summary>
        /// Get the sttlement that can be added to new paymentSlip
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public SettlemenToAddInPaymentSlipResultViewModel GetSettlementListToAddInPaymentSlip(PredicateFormatViewModel predicateModel, bool isPaymentSlipStateProvisional, int? idPaymentSlip)
        {
            if (predicateModel == null)
            {
                throw new Exception();
            }

            SettlemenToAddInPaymentSlipResultViewModel dataResult = new SettlemenToAddInPaymentSlipResultViewModel();

            PredicateFilterRelationViewModel<Settlement> predicateWhereRelation = PreparePredicate(predicateModel);
            Expression<Func<Settlement, bool>> expression = predicateWhereRelation.PredicateWhere;
            // If is in update mode and the paymentslip state is provisional get the settlements already added in this paymentSlip
            if (isPaymentSlipStateProvisional && (idPaymentSlip != null && idPaymentSlip > 0))
            {
                expression = expression.Or(x => x.IdPaymentSlip == idPaymentSlip);
            }
            IQueryable<Settlement> settlementQuery = _entityRepo.GetAllAsNoTracking()
                    .Where(expression)
                    .OrderByRelation(predicateModel.OrderBy)
                    .Include(r => r.IdBankAccountNavigation)
                    .Include(r => r.IdTiersNavigation)
                    .Include(r => r.IdUsedCurrencyNavigation);

            IQueryable<Settlement> data = settlementQuery.Skip((predicateModel.page - 1) * predicateModel.pageSize)
                                                                    .Take(predicateModel.pageSize).AsQueryable();
            List<Settlement> settlementResult = data.ToList();

            dataResult.Data = settlementResult.Select(_reducedBuilder.BuildEntity).ToList();

            dataResult.Total = settlementQuery.Count();

            dataResult.AllSettlementIds = settlementQuery.Select(x => x.Id).ToList();

            dataResult.TotalAmount = Math.Round(settlementQuery.Sum(s => s.Amount.Value), GetCompanyCurrencyPrecision());

            return dataResult;
        }

        /// <summary>
        /// GetSettlementNumberToAddPaymentSlip
        /// </summary>
        /// <param name="paymentMethod"></param>
        /// <returns></returns>
        public int GetSettlementNumberToAddPaymentSlip(string paymentMethod)
        {
            IQueryable<int> settlementNumberQuery = _entityRepo.GetAllAsNoTracking()
                    .Where(x => !x.IdPaymentSlip.HasValue
                                && x.IdPaymentMethodNavigation.Code.Contains(paymentMethod)
                                && x.IdPaymentStatus == (int)PaymentStatusEnumerators.Settled
                                && x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer)
                    .Include(r => r.IdPaymentMethodNavigation)
                    .Include(r => r.IdTiersNavigation).Select(s => s.Id).AsQueryable();
            int settlementNumber = settlementNumberQuery.Count();
            return settlementNumber;
        }

        public SettlementViewModel GetModelById(int id)
        {
            SettlementViewModel settlementViewModel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
              .Include(x => x.SettlementCommitment).ThenInclude(x => x.Commitment).ThenInclude(x => x.IdDocumentNavigation)
              .Select(_builder.BuildEntity).FirstOrDefault();
            settlementViewModel.SettlementCommitment.ToList().ForEach(st =>
            {
                st.Settlement = null;
                st.Commitment.SettlementCommitment.Clear();
            });

            return settlementViewModel;
        }
        #endregion

    }

}




