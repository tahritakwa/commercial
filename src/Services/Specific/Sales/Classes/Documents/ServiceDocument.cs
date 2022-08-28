using Infrastruture.Utility;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.Immobilisation.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.PayRoll.Classes;
using Services.Specific.RH.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Treasury.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Management;
using System.Text;
using System.Transactions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;
using ZXing;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument : Service<DocumentViewModel, Document>, IServiceDocument
    {
        Dictionary<string, string> DocumentsLongName = new Dictionary<string, string>
        {
            { DocumentEnumerator.PurchaseOrder, "Bon de commande" },
            { DocumentEnumerator.SalesOrder, "Bon de commande" },
            { DocumentEnumerator.PurchaseDelivery, "Bon de Réception" },
            { DocumentEnumerator.SalesDelivery, "Bon de Livraison" },
            { DocumentEnumerator.PurchaseQuotation, "Devis" },
            { DocumentEnumerator.SalesQuotation, "Devis" },
            { DocumentEnumerator.PurchaseAsset, "Avoir" },
            { DocumentEnumerator.SalesAsset, "Avoir" },
            { DocumentEnumerator.SalesInvoiceAsset, "Facture Avoir" },
            { DocumentEnumerator.PurchaseInvoice, "Facture"},
            { DocumentEnumerator.SalesInvoice, "Facture" },
            { DocumentEnumerator.PurchaseFinalOrder, "Bond de commande final" },
            { DocumentEnumerator.PurchaseRequest, "Demande d'achat" }
        };

        private readonly static object stockLock = new object();
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceTiers _serviceTiers;
        private readonly IRepository<FinancialCommitment> _entityFinancialCommitment;
        private readonly IServiceFinancialCommitment _serviceFinancialCommitment;
        private readonly IServiceCurrency _serviceCurrency;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IServiceActive _serviceActive;
        private readonly IServiceItem _serviceItem;
        private readonly IServicePurchaseSettings _servicePurchaseSettings;
        private readonly IServiceInformation _serviceInformation;
        private readonly IServiceMessageDocument _serviceMessage;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServicePrices _servicePrices;
        private readonly IServiceDocumentLineTaxe _serviceDocumentLineTaxe;
        private readonly IServiceTaxe _serviceTaxe;
        private readonly IDocumentLineBuilder _documentLineBuilder;
        private readonly IDocumentBuilder _builderdocument;
        private readonly IReducedDocumentLineBuilder _documentLineReducedBuilder;
        private readonly IFinancialCommitmentBuilder _financialCommitmentBuilder;
        private readonly IUnitOfWork _unitOfWorkDocument;
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        private readonly IRepository<DocumentLine> _entityDocumentLineRepo;
        private readonly IRepository<DocumentLineTaxe> _entityDocumentLineTaxeRepo;
        private readonly IRepository<DocumentLinePrices> _entityDocumentLinePricesRepo;
        private readonly IRepository<StockMovement> _entityStockMovementRepo;
        private readonly IRepository<ItemWarehouse> _entityItemWarehouseRepo;
        private readonly IRepository<Axis> _entityRepoAxis;
        private readonly IRepository<AxisValue> _entityRepoAxisValue;
        private readonly IRepository<Currency> _entityRepoCurrency;
        private readonly IRepository<Tiers> _entityRepoTiers;
        private readonly IRepository<Employee> _entityRepoEmployee;
        private readonly IRepository<TaxeGroupTiersConfig> _entityRepoTaxeGroupTiersConfig;
        private readonly IRepository<TaxeGroupTiers> _entityRepoTaxeGroupTiers;
        private readonly IServiceComment _serviceComment;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceDocumentExpenseLine _serviceDocumentExpenseLine;
        private readonly IServicePriceRequest _servicePriceRequest;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IStockMovementBuilder _stockMovementBuilder;
        private readonly IRepository<SalesInvoiceLog> _entityRepoInvoiceLog;
        private readonly IServiceTimeSheetCountDays _serviceTimeSheet;
        private readonly IRepository<BillingEmployee> _entityRepoBillingEmployee;
        private readonly IServiceProject _serviceProject;
        private readonly IHubContext<BillingSessionProgessHub> _billingSessionProgressHubContext;
        private readonly IRepository<Message> _messageRepo;
        private readonly IRepository<Item> _itemEntityRepo;
        private readonly IRepository<ItemTiers> _itemTiersEntityRepo;
        private readonly IItemBuilder _itemBuilder;
        private readonly ITiersBuilder _tiersBuilder;
        private readonly IDocumentLineTaxeBuilder _documentLineTaxeBuilder;
        private readonly IServiceSaleSettings _serviceSaleSettings;
        private readonly ILogger<Document> _logger;
        private readonly IRepository<Provisioning> _entityProvision;
        private readonly IRepository<DocumentExpenseLine> _entityDocumentExpenseLineRepo;
        private readonly IRepository<FinancialCommitment> _entityFinancialCommitmentRepo;
        private readonly IRepository<Settlement> _entitySettlementRepo;
        private readonly IRepository<SettlementMode> _entitySettlementModeRepo;
        private readonly IRepository<Settlement> _settlementRepo;
        private readonly ICurrencyBuilder _currencyBuilder;
        private readonly IRepository<StockDocumentLine> _entityStockDocumentLineRepo;
        private readonly IRepository<Claim> _entityClaimRepo;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceContact _serviceContact;
        private readonly IRepository<DocumentLineNegotiationOptions> _entityRepoDocumentLineNegotiationOptions;
        private readonly IRepository<ReportTemplate> _entityRepoReportTemplate;
        private readonly IRepository<DocumentWithholdingTax> _entityDocumentWithholdingTaxRepo;
        private readonly IRepository<DocumentTaxsResume> _entityDocumentTaxsResume;
        private readonly IDocumentTaxsResumeBuilder _documentTaxsResumeBuilder;
        private readonly IRepository<CurrencyRate> _entityCurrencyRateRepo;
        private readonly IServiceDocumentTaxeResume _serviceDocumentTaxeResume;
        private readonly IRepository<BillingSession> _entityBillingSessionRepo;
        private readonly IServiceItemTiers _serviceItemTiers;
        private readonly IServiceMeasureUnit _serviceMeasureUnit;
        private readonly IRepository<Ticket> _ticketRepo;

        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IRepository<UsersBtob> _repoUsersBtob;
        private readonly IServiceStorage _serviceStorage;
        private readonly IRepository<UserWarehouse> _repoUserWarehouse;
        public ServiceDocument(IServiceCompany serviceCompany, IRepository<FinancialCommitment> entityFinancialCommitment, IServiceFinancialCommitment serviceFinancialCommitment, IRepository<Document> entityRepo,
            IServiceTiers serviceTiers, IRepository<DocumentLine> entityDocumentLineRepo, IRepository<DocumentType> entityDocumentTypeRepo,
            IRepository<DocumentLineTaxe> entityDocumentLineTaxeRepo, IRepository<StockMovement> entityStockMovementRepo, IRepository<ItemWarehouse> entityItemWarehouseRepo,
            IRepository<DocumentLinePrices> entityDocumentLinePricesRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IRepository<User> entityRepoUser, IDocumentBuilder builder,
            IDocumentLineBuilder documentLineBuilder, IRepository<Axis> entityRepoAxis, IRepository<AxisValue> entityRepoAxisValue, IRepository<Tiers> entityRepoTiers,
            IServiceCurrency serviceCurrency, IServiceItem serviceItem, IServicePurchaseSettings servicePurchaseSettings,
            IServiceDocumentLine serviceDocumentLin, IServiceActive serviceActive, IServiceInformation serviceInformation,
            IServicePrices servicePrices, IServiceDocumentLineTaxe ServiceDocumentLineTaxe,
            IServiceTaxe serviceTaxe, IServiceCurrencyRate serviceCurrencyRate,
            IServiceItemWarehouse serviceItemWarehouse, IServiceDocumentExpenseLine serviceDocumentExpenseLine, IRepository<DocumentExpenseLine> entityDocumentExpenseLineRepo,
            IServiceStockMovement serviceStockMovement, IStockMovementBuilder stockMovementBuilder,
            IServiceMessageDocument serviceMessage, IServiceMsgNotification serviceMessageNotification,
            IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IRepository<FinancialCommitment> entityFinancialCommitmentRepo,
            IRepository<BillingEmployee> entityRepoBillingEmployee,
            IHubContext<BillingSessionProgessHub> billingSessionProgressHubContext,
            IRepository<Currency> entityRepoCurrency, IRepository<Employee> entityRepoEmployee,
            IRepository<TaxeGroupTiersConfig> entityRepoTaxeGroupTiersConfig,
            IRepository<TaxeGroupTiers> entityRepoTaxeGroupTiers,
            IRepository<Codification> entityRepoCodification, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IServiceWarehouse serviceWarehouse, IRepository<EntityCodification> entityRepoEntityCodification,
            IServiceComment serviceComment, IServicePriceRequest servicePriceRequest, IServiceProject serviceProject,
            IServiceTimeSheetCountDays serviceTimeSheet, IRepository<SalesInvoiceLog> entityRepoInvoiceLog, ITiersBuilder tiersBuilder,
            IRepository<Message> messageRepo, IRepository<Item> itemEntityRepo, IItemBuilder itemBuilder, ILogger<Document> logger,
            IFinancialCommitmentBuilder financialCommitmentBuilder, IRepository<Settlement> entitySettlementRepo, ICurrencyBuilder currencyBuilder,
            IServiceSaleSettings serviceSaleSettings, IRepository<Provisioning> entityProvision, IReducedDocumentLineBuilder documentLineReducedBuilder,
            IRepository<SettlementMode> entitySettlementModeRepo, IRepository<Settlement> settlementRepo,
            IRepository<StockDocumentLine> entityStockDocumentLineRepo, IRepository<Claim> entityClaimRepo,
            IServiceEmail serviceEmail, IRepository<ReportTemplate> entityRepoReportTemplate,
            IRepository<DocumentWithholdingTax> entityDocumentWithholdingTaxRepo, IRepository<Ticket> ticketRepo,
            IRepository<DocumentTaxsResume> entityDocumentTaxsResume,
            IDocumentTaxsResumeBuilder documentTaxsResumeBuilder,
            IDocumentLineTaxeBuilder documentLineTaxeBuilder,
            IRepository<UsersBtob> repoUsersBtob,
            IServiceContact serviceContact, IRepository<DocumentLineNegotiationOptions> entityRepoNegotitationOptions, ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache, IRepository<CurrencyRate> entityCurrencyRateRepo, IServiceProvider serviceProvider,
            IServiceDocumentTaxeResume serviceDocumentTaxeResume, IRepository<BillingSession> entityBillingSessionRepo, IServiceItemTiers serviceItemTiers, IServiceMeasureUnit serviceMeasureUnit,
            IServiceMasterUser serviceMasterUser, IServiceStorage serviceStorage, IRepository<UserWarehouse> repoUserWarehouse, IRepository<ItemTiers> itemTiersEntityRepo)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                entityRepoEntity, entityRepoEntityCodification, entityRepoCodification, companyBuilder, memoryCache)
        {
            _entityRepoInvoiceLog = entityRepoInvoiceLog;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _entityDocumentLineRepo = entityDocumentLineRepo;
            _entityDocumentLineTaxeRepo = entityDocumentLineTaxeRepo;
            _entityDocumentLinePricesRepo = entityDocumentLinePricesRepo;
            _entityStockMovementRepo = entityStockMovementRepo;
            _documentLineBuilder = documentLineBuilder;
            _entityRepoUser = entityRepoUser;
            _entityRepoAxis = entityRepoAxis;
            _entityRepoAxisValue = entityRepoAxisValue;
            _serviceCompany = serviceCompany;
            _serviceTiers = serviceTiers;
            _serviceCurrency = serviceCurrency;
            _serviceCurrencyRate = serviceCurrencyRate;
            _serviceDocumentLine = serviceDocumentLin;
            _entityRepoCurrency = entityRepoCurrency;
            _entityFinancialCommitment = entityFinancialCommitment;
            _serviceFinancialCommitment = serviceFinancialCommitment;
            _entityRepoEmployee = entityRepoEmployee;
            _serviceActive = serviceActive;
            _serviceItem = serviceItem;
            _servicePurchaseSettings = servicePurchaseSettings;
            _serviceInformation = serviceInformation;
            _serviceMessage = serviceMessage;
            _serviceMessageNotification = serviceMessageNotification;
            _servicePrices = servicePrices;
            _entityRepoTaxeGroupTiersConfig = entityRepoTaxeGroupTiersConfig;
            _entityRepoTaxeGroupTiers = entityRepoTaxeGroupTiers;
            _serviceDocumentLineTaxe = ServiceDocumentLineTaxe;
            _serviceTaxe = serviceTaxe;
            _serviceComment = serviceComment;
            _serviceItemWarehouse = serviceItemWarehouse;
            _serviceDocumentExpenseLine = serviceDocumentExpenseLine;
            _servicePriceRequest = servicePriceRequest;
            _serviceWarehouse = serviceWarehouse;
            _serviceStockMovement = serviceStockMovement;
            _stockMovementBuilder = stockMovementBuilder;
            _serviceTimeSheet = serviceTimeSheet;
            _entityRepoBillingEmployee = entityRepoBillingEmployee;
            _serviceProject = serviceProject;
            _billingSessionProgressHubContext = billingSessionProgressHubContext;
            _messageRepo = messageRepo;
            _itemEntityRepo = itemEntityRepo;
            _itemBuilder = itemBuilder;
            _tiersBuilder = tiersBuilder;
            _serviceSaleSettings = serviceSaleSettings;
            _entityProvision = entityProvision;
            _logger = logger;
            _entityItemWarehouseRepo = entityItemWarehouseRepo;
            _documentLineReducedBuilder = documentLineReducedBuilder;
            _entityFinancialCommitmentRepo = entityFinancialCommitmentRepo;
            _entityDocumentExpenseLineRepo = entityDocumentExpenseLineRepo;
            _entityRepoTiers = entityRepoTiers;
            _financialCommitmentBuilder = financialCommitmentBuilder;
            _entitySettlementRepo = entitySettlementRepo;
            _entitySettlementModeRepo = entitySettlementModeRepo;
            _settlementRepo = settlementRepo;
            _currencyBuilder = currencyBuilder;
            _entityStockDocumentLineRepo = entityStockDocumentLineRepo;
            _entityClaimRepo = entityClaimRepo;
            _serviceEmail = serviceEmail;
            _entityRepoReportTemplate = entityRepoReportTemplate;
            _serviceContact = serviceContact;
            _builderdocument = builder;
            _entityRepoDocumentLineNegotiationOptions = entityRepoNegotitationOptions;
            _entityDocumentWithholdingTaxRepo = entityDocumentWithholdingTaxRepo;
            _serviceProvider = serviceProvider;
            _entityDocumentTaxsResume = entityDocumentTaxsResume;
            _documentTaxsResumeBuilder = documentTaxsResumeBuilder;
            _entityCurrencyRateRepo = entityCurrencyRateRepo;
            _serviceDocumentTaxeResume = serviceDocumentTaxeResume;
            _entityBillingSessionRepo = entityBillingSessionRepo;
            _serviceItemTiers = serviceItemTiers;
            _serviceMeasureUnit = serviceMeasureUnit;
            _documentLineTaxeBuilder = documentLineTaxeBuilder;
            _ticketRepo = ticketRepo;
            _serviceMasterUser = serviceMasterUser;
            _repoUsersBtob = repoUsersBtob;
            _serviceStorage = serviceStorage;
            _repoUserWarehouse = repoUserWarehouse;
            _itemTiersEntityRepo = itemTiersEntityRepo;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idPayslip"></param>
        /// <returns></returns>
        public ReportSettings GetBtoBDocumentReportSettings(int idDocument, HttpContext ctx, string userMail, PrinterSettings printerSettings)
        {
            ReportSettings reportSetting = new ReportSettings();
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            reportSetting.Url = _appSettings.BaseUrl.ToString();
            reportSetting.User = userMail;
            reportSetting.Id = idDocument;
            reportSetting.IdCompany = company.Id;
            reportSetting.NumberofCopies = 1;
            reportSetting._printerSettings = printerSettings;
            if (company.DataLogoCompany != null)
            {
                reportSetting.DataLogoCompany = Convert.ToBase64String(company.DataLogoCompany);
            }
            DocumentViewModel result = GetModelWithRelationsAsNoTracked(x => x.Id == idDocument);
            StringBuilder reportName = new StringBuilder();
            reportName.Append(result.Code);
            reportSetting.ReportNameToDisplay = reportName.ToString();

            reportSetting.NumberofCopies = 1;
            reportSetting.ReportName = DocumentConstant.BtoBDocumentReportName;


            return reportSetting;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idPayslip"></param>
        /// <returns></returns>
        public ReportSettings GetInvoiceReportSettings(int idDocument, HttpContext ctx, string userMail, PrinterSettings printerSettings)
        {
            ReportSettings reportSetting = new ReportSettings();
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            reportSetting.Url = _appSettings.BaseUrl.ToString();
            reportSetting.User = userMail;
            reportSetting.Id = idDocument;
            reportSetting.IdCompany = company.Id;
            reportSetting.NumberofCopies = 1;
            reportSetting._printerSettings = printerSettings;
            if (company.DataLogoCompany != null)
            {
                reportSetting.DataLogoCompany = Convert.ToBase64String(company.DataLogoCompany);
            }
            DocumentViewModel result = GetModelWithRelationsAsNoTracked(x => x.Id == idDocument);
            StringBuilder reportName = new StringBuilder();
            //reportName.Append(DocumentConstant.ReportTitle).Append(result.Code);
            reportName.Append(result.Code);
            reportSetting.ReportNameToDisplay = reportName.ToString();

            if (result.DocumentTypeCode == DocumentEnumerator.SalesDelivery || result.DocumentTypeCode == DocumentEnumerator.SalesAsset)
            {
                reportSetting.NumberofCopies = 2;
                reportSetting.ReportName = DocumentConstant.SDReportName;
            }
            else if (result.DocumentTypeCode == DocumentEnumerator.SalesOrder)
            {
                reportSetting.NumberofCopies = 3;
                reportSetting.ReportName = DocumentConstant.SOReportName;
            }
            else if (result.DocumentTypeCode == DocumentEnumerator.SalesInvoice && result.InoicingType == 3)
            {
                reportSetting.ReportName = DocumentConstant.SIOReportName;
            }
            else if (result.DocumentTypeCode == DocumentEnumerator.SalesInvoice || result.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)
            {
                reportSetting.ReportName = DocumentConstant.SIReportName;
            }
            else if (result.DocumentTypeCode == DocumentEnumerator.BS)
            {
                reportSetting.ReportName = DocumentConstant.BSReportName;
            }
            else if (result.DocumentTypeCode == DocumentEnumerator.BE)
            {
                reportSetting.ReportName = DocumentConstant.BEReportName;
            }
            else
            {
                reportSetting.ReportName = DocumentConstant.ReportName;
            }

            return reportSetting;
        }

        public ReportSettings GetInvoiceReportSettings(HttpContext ctx, string userMail, PrinterSettings printerSettings, string reportType, string documentType, int groupbytiers)
        {
            ReportSettings reportSetting = new ReportSettings();
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            reportSetting.Url = _appSettings.BaseUrl.ToString();
            reportSetting.User = userMail;
            reportSetting.IdCompany = company.Id;
            reportSetting.NumberofCopies = 1;
            reportSetting._printerSettings = printerSettings;
            if (company.DataLogoCompany != null)
            {
                reportSetting.DataLogoCompany = Convert.ToBase64String(company.DataLogoCompany);
            }
            StringBuilder reportName = new StringBuilder();

            if (reportType == "dailysalesdelivery")
            {
                reportName.Append(DocumentConstant.DailySalesDeliveryReportTitle);
                reportSetting.ReportNameToDisplay = reportName.ToString();
                reportSetting.ReportName = DocumentConstant.DailySalesDeliveryReportName;
            }
            else if (reportType == "dailysales")
            {
                reportName.Append(DocumentConstant.DailySalesReportTitle);
                reportSetting.ReportNameToDisplay = reportName.ToString();
                reportSetting.ReportName = DocumentConstant.DailySalesReportName;
            }
            else if (reportType == "documentcontrolstatus")
            {
                reportName.Append(DocumentConstant.DocumentControlStatusReportTitle);
                reportSetting.ReportNameToDisplay = reportName.ToString();
                reportSetting.ReportName = groupbytiers != 1 ? DocumentConstant.DocumentControlStatusReportName : DocumentConstant.InvoiceDocumentControlStatusReportName;
            }

            return reportSetting;
        }


        /// <summary>
        ///  Get an element Related to Id 
        /// </summary>
        /// <param name="id"> Id Item</param>
        /// <returns></returns>
        public override DocumentViewModel GetModelById(int id)
        {
            DocumentViewModel result = GetModelWithRelationsAsNoTracked(x => x.Id == id);
            if (result.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
            {
                result.hasSalesInvoices = CheckHasSalesInvoice(result);
            }
            return result;
        }

        /// <summary>
        /// Get an element Related to Id 
        /// </summary>
        /// <param name="id"> Id Item</param>
        /// <returns></returns>
        public virtual DocumentViewModel GetDocumentById(int id)
        {
            var result = GetModelWithRelationsAsNoTracked(x => x.Id == id);
            if (result.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
            {
                result.hasSalesInvoices = CheckHasSalesInvoice(result);
            }
            return result;
        }

        public object AddDocument(IList<IFormFile> files, DocumentViewModel document, string userMail, IList<EntityAxisValuesViewModel> entityAxisValuesModelList)
        {
            BeginTransaction();
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
            var addDocument = AddDocumentWithoutTransaction(files, document, documentType, userMail, entityAxisValuesModelList);
            EndTransaction();
            return addDocument;
        }

        public object AddDocumentWithoutTransaction(IList<IFormFile> files, DocumentViewModel document,
            DocumentType documentType, string userMail, IList<EntityAxisValuesViewModel> entityAxisValuesModelList)
        {
            if (document.IsBToB != true && userMail != null &&
                (document.IdCreator == null ||
                document.IdCreator == 0))
            {
                document.IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == userMail).Id;
            }

            AddDocumentOperation(files, document, documentType, userMail, "DocumentTypeCode");
            var result = AddModelWithoutTransaction(document, entityAxisValuesModelList, userMail, "DocumentTypeCode");
            return result;
        }

        public DocumentViewModel UpdateDocument(IList<IFormFile> files, DocumentViewModel document, IList<EntityAxisValuesViewModel> entityAxisValues, string userMail, bool manageFile = true)
        {
            try
            {
                DocumentViewModel doc;
                BeginTransaction();
                doc = UpdateDocumentWithoutTransaction(files, document, entityAxisValues, userMail, manageFile);
                EndTransaction();
                return doc;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }
        private DocumentViewModel UpdateDocumentWithoutTransaction(IList<IFormFile> files, DocumentViewModel document, IList<EntityAxisValuesViewModel> entityAxisValues, string userMail, bool manageFile = true)
        {
            DocumentViewModel documentAfterOperations = UpdateDocumentOperation(files, document, entityAxisValues, userMail, manageFile);
            UpdateModelWithoutTransaction(documentAfterOperations, entityAxisValues, userMail);
            return documentAfterOperations;
        }

        public override object UpdateModelWithoutTransaction(DocumentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail,
            string property = null)
        {
            //set remaining amount for invoice and asset
            SetRemainingAmount(model);
            //build Entity
            Document entity = _builder.BuildModel(model);
            UpdateDocumentLine(entity);
            _serviceDocumentExpenseLine.UpdateDocumentExpenseLine(entity.DocumentExpenseLine.ToList());
            entity.DocumentExpenseLine.Clear();
            entity.DocumentLine.Clear();
            entity.IdTiersNavigation = null;
            _entityDocumentTaxsResume.BulkUpdate(entity.DocumentTaxsResume.ToList());
            _entityRepo.Update(entity);
            if (entityAxisValuesModelList != null)
            {
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
            }

            _unitOfWork.Commit();
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        public void UpdateModelWithoutTransaction(DocumentViewModel model)
        {
            //build Entity
            dynamic entity = _builder.BuildModel(model);
            _entityRepo.Update(entity);
            _unitOfWork.Commit();
        }

        public void UpdateModelValidation(DocumentViewModel model, string userMail)
        {
            var ctx = _unitOfWork.GetContext();
            //build Entity
            Document entity = _builder.BuildModel(model);

            //updateDocumentLine
            model.DocumentLine.ToList().ForEach(line =>
            {
                var attachedDL = ctx.ChangeTracker.Entries<DocumentLine>().FirstOrDefault(e => e.Entity.Id == line.Id);
                if (attachedDL != null)
                {
                    ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                }
            });

            _entityDocumentLineRepo.BulkUpdate(entity.DocumentLine.ToList());

            entity.DocumentLine.Clear();

            var attachedEntity = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == entity.Id);
            if (attachedEntity != null)
            {
                ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
            }

            // update entity               
            _entityRepo.Update(entity);
            _unitOfWork.Commit();

        }

        /// <summary>
        /// Find th
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override IList<DocumentViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IEnumerable<DocumentViewModel> listModel = base.FindModelBy(predicateModel);
            if (listModel.Count() == 1)
            {
                DocumentViewModel document = listModel.First();
                //attach list of file to current document
                document.FilesInfos = GetFilesContent(document.AttachmentUrl);
            }
            return listModel.ToList();
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<DocumentViewModel> GetDocumentList(PredicateFormatViewModel predicateModel)
        {
            var listModel = base.FindDataSourceModelBy(predicateModel);
            foreach (DocumentViewModel documentViewModel in listModel.data)
            {
                // if settelment is Valide or Solde ==> set CanDelete and CanEdit CanValidate to false
                if (documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Valid)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Balanced)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.PartiallySatisfied)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Refused))
                {
                    documentViewModel.CanEdit = false;
                    documentViewModel.CanValidate = false;
                    documentViewModel.CanDelete = false;

                }
                // if settelment is Provisoire ==> set CanShow to false
                else
                {
                    documentViewModel.CanShow = false;

                }
            }
            return listModel;

        }
        /// <summary>
        /// Get ShelfAndStorage Of Item In Warehouse
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        public string GetShelfAndStorageOfItemInWarehouse(int idItem, int? idWarehouse)
        {
            return _serviceDocumentLine.GetShelfAndStorageOfItemInWarehouse(idItem, idWarehouse);
        }

        private DocumentViewModel GetDocumentDetails(int id, string userMail)
        {
            var document = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(c => c.Id == id)
              .Include(r => r.IdTiersNavigation)
              .ThenInclude(r => r.IdCurrencyNavigation)
              .Include(r => r.IdTiersNavigation)
              .ThenInclude(r => r.IdPhoneNavigation)
              .Include(r => r.IdTiersNavigation)
              .ThenInclude(r => r.Address)
              .Include(r => r.IdUsedCurrencyNavigation)
              .Include(r => r.DocumentLine).ThenInclude(r => r.IdMeasureUnitNavigation)
              .Include(r => r.DocumentWithholdingTax)
              .ThenInclude(r => r.IdWithholdingTaxNavigation)
              .Include(r => r.DocumentTaxsResume)
              .ThenInclude(r => r.IdTaxNavigation)
              .Include(r => r.FinancialCommitment)
              .ThenInclude(r => r.SettlementCommitment)
              .ThenInclude(r => r.Settlement)
              .Include(r => r.IdSessionCounterSalesNavigation)
              .FirstOrDefault();
            var documentViewModel = _builderdocument.BuildDocumentEntity(document);
            var tier = document.IdTiersNavigation;
            if (document == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            if (document.IdDocumentAssociated != null)
            {
                DocumentViewModel documentAssociated = GetModelById(document.IdDocumentAssociated.Value);
                if (documentAssociated != null)
                {
                    documentViewModel.IdDocumentAssociatedStatus = documentAssociated.IdDocumentStatus;
                }
            }
            documentViewModel.FilesInfos = GetFiles(document.AttachmentUrl).ToList();

            // recalculate document for Sales delivery document // 
            if (document.DocumentTypeCode.Equals(DocumentEnumerator.SalesDelivery)
              && document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
            {
                List<DocumentLineViewModel> updatedReservedLines = _serviceDocumentLine.RecalculateAvailableQuantity(document.Id);
                if (updatedReservedLines.Any())
                {

                    double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
                    List<Item> itemList = _itemEntityRepo.GetAllAsNoTracking().Include(r => r.IdNatureNavigation)
                    .Include(x => x.TaxeItem).Include(x => x.ItemWarehouse).Where(p => updatedReservedLines.Select(z => z.IdItem)
                      .Distinct().Contains(p.Id)).ToList();
                    var tiers = document.IdTiersNavigation;
                    int companyPrecision = GetCompanyCurrencyPrecision();
                    int tiersPrecision = GetPrecissionValue(document.IdUsedCurrency ?? 0, document.DocumentTypeCode);


                    updatedReservedLines.ForEach(x =>
                    {
                        var item = itemList.FirstOrDefault(z => z.Id == x.IdItem);
                        ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
                        {
                            exchangeRate = exchangeRate,
                            DocumentDate = document.DocumentDate,
                            DocumentLineViewModel = x,
                            DocumentType = document.DocumentTypeCode,
                            IdCurrency = document.IdUsedCurrency ?? 0,
                            IdTiers = document.IdTiers ?? 0,
                            Tiers = tiers,
                            Document = document,
                            Item = item,
                        };
                        if (x.IdItemNavigation != null)
                        {
                            SetHTAmount(x, document.IdUsedCurrency ?? 0, document.DocumentDate, tiersPrecision, x.IdItemNavigation.UnitHtsalePrice ?? 0);
                            x.HtAmountWithCurrency = x.HtUnitAmountWithCurrency - x.HtUnitAmountWithCurrency
                                * (x.DiscountPercentage ?? 0) / 100;
                        }
                        CalculateDocumentLine(itemPriceViewModel);
                        x.StockMovement = null;
                    });
                    var ctx = _unitOfWork.GetContext();
                    updatedReservedLines.ForEach(line =>
                    {
                        var attachedEntity = ctx.ChangeTracker.Entries<DocumentLine>().FirstOrDefault(e => e.Entity.Id == line.Id);
                        if (attachedEntity != null)
                        {
                            ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
                        }
                    });
                    _entityDocumentLineRepo.BulkUpdate(updatedReservedLines.Select(x => _documentLineBuilder.BuildModel(x)).ToList());
                    _unitOfWork.Commit();
                    documentViewModel = UpdateDocumentAmountsWithoutTransaction(document.Id, null);


                }
                // RecalculateDocumentLineOnSalesDeliveryOpen(document, userMail);
            }

            if (document.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseRequest))
            {
                documentViewModel.Comments = _serviceComment.GetComments(nameof(Document), id);
            }
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
            {
                documentViewModel.DocumentExpenseLine = _serviceDocumentExpenseLine.FindModelsByNoTracked(p => p.IdDocument == document.Id,
                                                       p => p.IdExpenseNavigation,
                                                       p => p.IdExpenseNavigation.IdItemNavigation,
                                                       p => p.IdTaxeNavigation,
                                                       p => p.IdTiersNavigation,
                                                       p => p.IdCurrencyNavigation).ToList();
            }

            CheckIsSubmited(documentViewModel);
            if (documentViewModel.DocumentTypeCode != DocumentEnumerator.PurchaseRequest)
            {
                documentViewModel.DocumentLine = null;
            }

            return documentViewModel;
        }


        public void UpdateItemWarehouseAndRecalculateDocument(ItemPriceViewModel itemPricesViewModel)
        {

            var document = itemPricesViewModel.Document;
            if (document.DocumentTypeCode.Equals(DocumentEnumerator.SalesDelivery)
              && document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
            {
                List<DocumentLineViewModel> updatedReservedLines = _serviceDocumentLine.RecalculateAvailableQuantity(document.Id);
                if (updatedReservedLines.Any())
                {
                    List<Item> itemList = _itemEntityRepo.GetAllAsNoTracking()
                        .Include(r => r.IdNatureNavigation).Include(x => x.TaxeItem).Include(x => x.ItemWarehouse)
                        .Where(p => updatedReservedLines.Select(z => z.IdItem).
                    Distinct().Contains(p.Id)).ToList();

                    updatedReservedLines.ForEach(x =>
                    {
                        ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
                        {

                            exchangeRate = itemPricesViewModel.exchangeRate,
                            DocumentDate = document.DocumentDate,
                            DocumentLineViewModel = x,
                            DocumentType = document.DocumentTypeCode,
                            IdCurrency = document.IdUsedCurrency ?? 0,
                            IdTiers = document.IdTiers ?? 0,
                            TiersPrecison = itemPricesViewModel.TiersPrecison,
                            CompanyPrecison = itemPricesViewModel.CompanyPrecison,
                            Tiers = itemPricesViewModel.Tiers,
                            Document = document
                        };
                        CheckitemPricesObject(itemPriceViewModel);
                        if (x.IdItemNavigation != null)
                        {
                            SetHTAmount(x, document.IdUsedCurrency ?? 0, document.DocumentDate, itemPricesViewModel.TiersPrecison, x.IdItemNavigation.UnitHtsalePrice ?? 0);
                            x.HtAmountWithCurrency = x.HtUnitAmountWithCurrency - x.HtUnitAmountWithCurrency
                                * x.DiscountPercentage / 100;
                        }
                        CalculateDocumentLine(itemPriceViewModel);
                        x.StockMovement = null;
                    });
                    _entityDocumentLineRepo.BulkUpdate(updatedReservedLines.Select(x => _documentLineBuilder.BuildModel(x)).ToList());
                    _unitOfWork.Commit();
                    UpdateDocumentAmountsWithoutTransaction(document.Id, null);

                }




                // RecalculateDocumentLineOnSalesDeliveryOpen(document, userMail);
            }

        }
        /// <summary>
        /// check if document is submited
        /// </summary>
        /// <param name="document"></param>
        private void CheckIsSubmited(DocumentViewModel document)
        {
            if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
            {
                document.IsSubmited = _messageRepo.GetAllWithConditions(x => x.EntityReference == document.Id).Any();
            }
            else
            {
                document.IsSubmited = true;
            }
        }

        /// <summary>
        /// Find th
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DocumentViewModel FindDocumentWithDocumentLine(int id, string userMail)
        {
            DocumentViewModel document = new DocumentViewModel();
            try
            {

                BeginTransactionunReadUncommitted();
                document = GetDocumentDetails(id, userMail);
                if (document == null)
                {
                    return null;
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                {
                    document.hasSalesInvoices = CheckHasSalesInvoice(document);

                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.IdSalesDepositInvoice != null)
                {
                    document.DepositAmount = GetModelAsNoTracked(x => x.Id == document.IdSalesDepositInvoice).DocumentTtcpriceWithCurrency;
                    document.LeftToPayAmount = Math.Round((double)(document.DocumentTtcpriceWithCurrency - document.DepositAmount), document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 3);
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                {
                    var hasReservedLines = _serviceStockMovement.GetModelsWithConditionsRelations(c => c.Operation == OperationEnumerator.Output &&
             c.Status == DocumentEnumerator.Reservation && c.IdDocumentLineNavigation.IdDocument == id, x => x.IdDocumentLineNavigation)
                 .Select(x => x.IdDocumentLineNavigation.IdDocument).Count() > 0;
                    document.haveReservedLines = hasReservedLines;
                    document.FilesInfos = GetFiles(document.AttachmentUrl).ToList();

                    document.isAbledToMerge = _entityRepo.QuerableGetAll().Where(x => x.IdTiers == document.IdTiers && x.Id != document.Id &&
                     x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery).Count() > 0 && !hasReservedLines;

                }


                if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder && IsDocumentLineNegotiatedFromDocumentId(document.Id))
                {
                    document.IsNegotitated = true;
                }

                EndTransaction();
                document.DocumentTaxsResume = document.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
                if (document.DocumentTtcpriceWithCurrency != null && document.DocumentTtcpriceWithCurrency > 0 && document.IdUsedCurrencyNavigation != null)
                {
                    document.DocumentTtcpriceWithCurrency = Math.Round((double)document.DocumentTtcpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision);
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesOrder && document.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && document.IdSalesDepositInvoice != null)
                {
                    if (document.IdSalesDepositInvoice != null)
                    {
                        DocumentViewModel depositInvoice = GetModelAsNoTracked(x => x.Id == document.IdSalesDepositInvoice);
                        document.DepositInvoiceCode = depositInvoice.Code;
                        document.DepositInvoiceStatusCode = depositInvoice.IdDocumentStatus;
                    }
                    DocumentViewModel invoice = GetModelAsNoTracked(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.IdSalesOrder == document.Id && x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment);
                    if (invoice != null)
                    {
                        document.InvoiceFromDepositOrderCode = invoice.Code;
                        document.IdInvoiceFromDepositOrderCode = invoice.Id;
                        document.InvoiceFromDepositOrderStatusCode = invoice.IdDocumentStatus;
                    }
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType == (int)InvoicingTypeEnumerator.advancePayment)
                {
                    document.DepositOrderCode = GetModelAsNoTracked(x => x.Id == document.IdSalesOrder).Code;
                    document.DepositOrderStatusCode = GetModelAsNoTracked(x => x.Id == document.IdSalesOrder).IdDocumentStatus;
                    DocumentViewModel invoice = GetModelAsNoTracked(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.IdSalesDepositInvoice == document.Id && x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment);
                    if (invoice != null)
                    {
                        document.InvoiceFromDepositOrderCode = invoice.Code;
                        document.IdInvoiceFromDepositOrderCode = invoice.Id;
                        document.InvoiceFromDepositOrderStatusCode = invoice.IdDocumentStatus;
                    }
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType != (int)InvoicingTypeEnumerator.advancePayment && document.IdSalesDepositInvoice != null)
                {
                    List<Document> orderAndDepositInvoice = _entityRepo.GetAllWithConditions(x => x.Id == (int)document.IdSalesOrder || x.Id == (int)document.IdSalesDepositInvoice).ToList();
                    document.DepositOrderCode = orderAndDepositInvoice.Where(x => x.Id == document.IdSalesOrder).First().Code;
                    document.DepositOrderStatusCode = orderAndDepositInvoice.Where(x => x.Id == document.IdSalesOrder).First().IdDocumentStatus;
                    document.DepositInvoiceCode = orderAndDepositInvoice.Where(x => x.Id == document.IdSalesDepositInvoice).First().Code;
                    document.DepositInvoiceStatusCode = orderAndDepositInvoice.Where(x => x.Id == document.IdSalesDepositInvoice).First().IdDocumentStatus;
                }
                return document;
            }
            catch (CustomException ex)
            {
                // rollback transaction
                RollBackTransaction();
                throw ex;
            }
            catch (Exception ex)
            {
                // rollback transaction
                RollBackTransaction();
                throw ex;
            }
        }

        public DocumentViewModel UpdateDocumentAfterChangeTtcPrice(int IdDoc, double documentAmount, string userMail)
        {
            try { 
            Document doc = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == IdDoc).Include(y => y.DocumentLine).ThenInclude(r => r.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation)
                .Include(x => x.DocumentLine).ThenInclude(x => x.IdItemNavigation).ThenInclude(x => x.ItemWarehouse).Include(y=> y.IdUsedCurrencyNavigation).FirstOrDefault();
                ItemViewModel discountProduct = _serviceItem.GetModelAsNoTracked(x => x.Code.Equals("Remise") && x.Description.Equals("Remise"));
                DocumentViewModel resultDocument = new DocumentViewModel();
                if (discountProduct != null)
                {
                    double discountTTC = Math.Round((double)doc.DocumentTtcpriceWithCurrency - documentAmount, doc.IdUsedCurrencyNavigation.Precision);
                    double discountHt = Math.Round((discountTTC / 1.19),doc.IdUsedCurrencyNavigation.Precision);
                    DocumentLineViewModel docLine = new DocumentLineViewModel()
                    {
                        IdItem = discountProduct.Id,
                        IdItemNavigation = discountProduct,
                        CodeDocumentLine = "",
                        CostPrice = 0,
                        DiscountPercentage = 0,
                        HtAmountWithCurrency = discountHt,
                        HtUnitAmount = discountHt,
                        HtUnitAmountWithCurrency = discountHt,
                        Id = 0,
                        IdDocument = doc.Id,
                        IdDocumentLineStatus = 1,
                        Designation = discountProduct.Description,
                        MovementQty = -1,
                    };
                    ItemPriceViewModel itemPrice = new ItemPriceViewModel()
                    {
                        DocumentDate = doc.DocumentDate,
                        DocumentType = doc.DocumentTypeCode,
                        IdCurrency = (int)doc.IdUsedCurrency,
                        IdTiers = (int)doc.IdTiers,
                        RecalculateDiscount = false,
                        DocumentLineViewModel = docLine
                    };
                    resultDocument = InsertUpdateDocumentLine(itemPrice, userMail);
                }
               
            var result = resultDocument;
            result.DocumentTaxsResume = result.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
            return result;
            } catch (CustomException)
            {
                RollBackTransaction();
                throw;
            }
        }



        public bool GetDocumentAvailibilityStockReserved(int id)
        {
            BeginTransactionunReadUncommitted();
            var result = (_entityDocumentLineRepo.GetAllAsNoTracking().Where(p => p.IdDocument == id).Count()
                == _entityDocumentLineRepo.GetAllAsNoTracking().Where(p => p.IdDocument == id && p.StockMovement.FirstOrDefault().Status == DocumentEnumerator.Reservation).Count());
            EndTransaction();
            return result;
        }

        private List<DocumentLineViewModel> GetDocumentAvailibilityStock(DocumentViewModel document)
        {
            var ReservedDocumetnLines = _entityDocumentLineRepo.FindByAsNoTracking(p => p.IdDocument == document.Id && p.StockMovement.FirstOrDefault().Status == DocumentEnumerator.Reservation)
                 .Select(x => _documentLineBuilder.BuildEntity(x)).ToList();
            if (document.DocumentLine.Count == ReservedDocumetnLines.Count)
            {
                document.isAllLinesAreAvailbles = true;
            }
            else
            {
                document.isAllLinesAreAvailbles = false;
            }
            return ReservedDocumetnLines;
        }


        /// <summary>
        /// Find th
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public List<DocumentViewModel> FindDocumentWithDocumentLine(List<int> idDocumentList)
        {
            var document = _entityRepo.QuerableGetAll().Include(x => x.IdTiersNavigation).Include(x => x.DocumentLine)
                .ThenInclude(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).Include(x => x.DocumentLine)
                .ThenInclude(x => x.IdItemNavigation).ThenInclude(x => x.IdNatureNavigation).Include(x => x.DocumentLine)
                .ThenInclude(x => x.IdMeasureUnitNavigation)
                .Where(x => idDocumentList.Contains(x.Id)).Select(x => _builder.BuildEntity(x)).ToList();
            return document;
        }


        /// <summary>
        /// CheckAndChangeDocumentToPrinted
        /// </summary>
        /// <param name="document"></param>
        /// <param name="userEmail"></param>
        /// <returns></returns>
        public object CheckAndChangeDocumentToPrinted(DocumentViewModel document, string userEmail)
        {
            try
            {
                if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                    && document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    BeginTransaction();
                    VerifyIfValidatedOrDeletedDocument(document.Id);
                    ValidateDocumentWithoutTransaction(document.Id, userEmail, (int)DocumentStatusEnumerator.Printed, false);
                    EndTransaction();
                }
                return new CreatedDataViewModel { Id = document.Id, Code = document.Code };
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        public object ValidateDocument(int idDocument, string userMail)
        {
            lock (string.Intern(idDocument.ToString()) as object)
            {
                VerifyIfValidatedOrDeletedDocument(idDocument, (int)DocumentStatusEnumerator.Provisional);
                try
                {
                    BeginTransaction();
                    DocumentViewModel validatedDocument = ValidateDocumentWithoutTransaction(idDocument, userMail, (int)DocumentStatusEnumerator.Valid, false);
                    PurchaseDeliverySpecificOperations(validatedDocument, userMail);
                    EndTransaction();
                    return new CreatedDataViewModel { Id = validatedDocument.Id, Code = validatedDocument.Code };
                }
                catch (Exception e)
                {
                    // rollback transaction
                    RollBackTransaction();
                    throw;
                }
            }

        }

        public List<DocumentViewModel> MassValidateDocuments(List<DocumentViewModel> DocumentList, string userMail)
        {

            try
            {
                BeginTransaction();
                List<DocumentViewModel> resultList = new List<DocumentViewModel>();
                DocumentList.ForEach(x =>
                {
                    DocumentViewModel validatedDocument = ValidateDocumentWithoutTransaction(x.Id, userMail, (int)DocumentStatusEnumerator.Valid, false);
                    resultList.Add(validatedDocument);
                });
                EndTransaction();
                return resultList;

            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }


        }

        /// <summary>
        /// Validate document without transaction
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public DocumentViewModel ValidateDocumentWithoutTransaction(int idDocument, string userMail, int status, bool isFromAssocieteddocument)
        {

            try
            {
                return ValidateOperation(idDocument, userMail, status, isFromAssocieteddocument);
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }


        }

        /// <summary>
        /// Change Document And his Lines To New Status
        /// </summary>
        /// <param name="document"></param>
        /// <param name="tehNewStatus"></param>
        /// <param name="userMail"></param>
        private void ChangeDocumentAndLinesToNewStatus(DocumentViewModel document, int theNewStatus)
        {
            var ctx = _unitOfWork.GetContext();
            if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document != null && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null && theNewStatus == (int)DocumentStatusEnumerator.Valid)
            {
                document.IdDocumentStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                double advanceAmount = (double)GetModelAsNoTracked(x => x.Id == document.IdSalesDepositInvoice).DocumentTtcpriceWithCurrency;
                if (advanceAmount != null && advanceAmount > 0)
                {
                    document.DocumentRemainingAmountWithCurrency = document.DocumentTtcpriceWithCurrency - advanceAmount;
                }
            }
            else
            {
                document.IdDocumentStatus = theNewStatus;
            }
            document.ValidationDate = DateTime.Today;

            _entityDocumentLineRepo.QuerableGetAll().Where(p => p.IdDocument == document.Id && (p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Printed
                                                                                || p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Provisional || p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Draft))
                .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = theNewStatus });
            Document entity = _builder.BuildModel(document);
            var attachedEntity = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == entity.Id);
            if (attachedEntity != null)
            {
                ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
            }
            entity.DocumentLine.Clear();
            entity.IdTiersNavigation = null;
            _entityRepo.Update(entity);
            _unitOfWork.Commit();
        }
#pragma warning disable CS1998 // This async method lacks 'await' operators and will run synchronously. Consider using the 'await' operator to await non-blocking API calls, or 'await Task.Run(...)' to do CPU-bound work on a background thread.
        /// <summary>
        /// PurchaseDeliverySpecificOperations
        /// </summary>
        /// <param name="document"></param>
        /// <param name="userMail"></param>
        private async void PurchaseDeliverySpecificOperations(DocumentViewModel document, string userMail)
#pragma warning restore CS1998 // This async method lacks 'await' operators and will run synchronously. Consider using the 'await' operator to await non-blocking API calls, or 'await Task.Run(...)' to do CPU-bound work on a background thread.
        {
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
            {
                List<int> idItems = document.DocumentLine.Select(p => p.IdItem).Distinct().ToList();
                var idtiers = document.IdTiers;
                List<ItemTiersViewModel> itemsTiers = _serviceItemTiers.GetAllModelsAsNoTracking().Where(x => x.IdTiers == idtiers && idItems.Contains(x.IdItem)).ToList();
                foreach (DocumentLineViewModel currentDocumentLine in document.DocumentLine)
                {
                    //set item information 
                    itemsTiers.Where(x => x.IdItem == currentDocumentLine.IdItem).FirstOrDefault().ExchangeRate = document.ExchangeRate;
                    itemsTiers.Where(x => x.IdItem == currentDocumentLine.IdItem).FirstOrDefault().Margin = currentDocumentLine.PercentageMargin;
                    itemsTiers.Where(x => x.IdItem == currentDocumentLine.IdItem).FirstOrDefault().Cost = currentDocumentLine.CostPrice;
                    itemsTiers.Where(x => x.IdItem == currentDocumentLine.IdItem).FirstOrDefault().PurchasePrice = currentDocumentLine.HtUnitAmountWithCurrency;
                    // get Reservation stock movment of item in warehouse
                    List<StockMovementViewModel> reservedDocumentLineStockMovmentList = _serviceStockMovement.FindModelsByNoTracked(y =>
                   y.IdItem == currentDocumentLine.IdItem &&
                   y.Status == DocumentEnumerator.Reservation).ToList();
                    foreach (StockMovementViewModel currentReservedDocumentLineStockMovment in reservedDocumentLineStockMovmentList)
                    {
                        if ((currentReservedDocumentLineStockMovment != null) &&
                            (_serviceItemWarehouse.GetItemQtyInWarehouse((int)currentReservedDocumentLineStockMovment.IdItem,
                            currentReservedDocumentLineStockMovment.IdWarehouse)
                                >= currentReservedDocumentLineStockMovment.MovementQty)) // If the quantity  cover the document line Stock Movment
                        {
                            ItemViewModel item = _serviceItem.GetModelAsNoTracked(x => x.Id == currentDocumentLine.IdItem, x => x.IdUnitStockNavigation);
                            int idDocumentOfCurrentResrvedStockMovement = _serviceDocumentLine.GetModel(x => x.Id == currentReservedDocumentLineStockMovment.IdDocumentLine).IdDocument;

                            WarehouseViewModel centralWarehouse = _serviceWarehouse.GetModelAsNoTracked(x => x.IsCentral);
                            WarehouseViewModel currentReservedDocumentLineStockMovmentIsWarehouse = _serviceWarehouse.GetModelAsNoTracked(x =>
                                x.Id == currentReservedDocumentLineStockMovment.IdWarehouse);

                            DocumentViewModel reservedStockIsDocument = GetModelAsNoTracked(x => x.Id == idDocumentOfCurrentResrvedStockMovement);

                            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                            {
                                { Constants.RESERVED_QUANTITY_UPPER_CASE, currentReservedDocumentLineStockMovment.MovementQty },
                                { Constants.RECEIVED_QUANTITY_UPPER_CASE, currentDocumentLine.MovementQty },
                                { Constants.UNITY_UPPER_CASE, item.IdUnitStockNavigation !=null ? item.IdUnitStockNavigation.Description:"" },
                                { Constants.ITEM_DESCRIPTION_UPPER_CASE, item.Description },
                                { Constants.CENTRAL_WAREHOUSE_UPPER_CASE, centralWarehouse.WarehouseName },
                                { Constants.ITEM_IS_WAREHOUSE_UPPER_CASE, currentReservedDocumentLineStockMovmentIsWarehouse.WarehouseName },
                                { Constants.DOCUMENT_REFERENCE_UPPER_CASE, reservedStockIsDocument.Code },
                                { Constants.RECEPTION_DOCUMENT_REFERENCE_UPPER_CASE, reservedStockIsDocument.Code },
                                { Constants.STATUS, reservedStockIsDocument.IdDocumentStatus },

                            };
                            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                            if (parameters[Constants.ITEM_IS_WAREHOUSE_UPPER_CASE].Equals(parameters[Constants.CENTRAL_WAREHOUSE_UPPER_CASE]))
                            {
                                _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE,
                                reservedStockIsDocument.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertAvailableProduct, userMail, parameters, null, company.Code);
                            }
                            else
                            {
                                _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE,
                                    reservedStockIsDocument.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertAvailableProduct, userMail, parameters, null, company.Code);
                            }
                        }
                    }
                }
                _serviceItemTiers.BulkUpdateModelWithoutTransaction(itemsTiers, null);
            }
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<DocumentViewModel> GetDocumentList(PredicateFormatViewModel predicateModel, string userMail)
        {
            List<int> listofChildern = new List<int>();
            GetChildrenList(userMail, listofChildern);

            var listModel = base.FindDataSourceModelBy(predicateModel);

            foreach (DocumentViewModel documentViewModel in listModel.data.OfType<DocumentViewModel>())
            {
                if (documentViewModel.DocumentLine != null && documentViewModel.DocumentLine.Any())
                {
                    documentViewModel.DocumentLine.ToList().ForEach(p => p.IdItemNavigation = _serviceItem.GetModelById(p.IdItem));
                    if (documentViewModel.IdTiersNavigation != null)
                    {
                        documentViewModel.FormatOption = documentViewModel.IdTiersNavigation.FormatOption;
                    }
                }
                // if settelment is Valide or Solde ==> set CanDelete and CanEdit CanValidate to false
                if (documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Valid)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Balanced)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.PartiallySatisfied)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.Refused)
                    || documentViewModel.IdDocumentStatus == ((int)DocumentStatusEnumerator.ToOrder))
                {
                    documentViewModel.CanEdit = false;
                    documentViewModel.CanValidate = false;
                    documentViewModel.CanDelete = false;

                }
                // if settelment is Provisoire ==> set CanShow to false
                else
                {
                    documentViewModel.CanShow = false;

                }

                if (documentViewModel.TransactionUserId != 0)
                {
                    User user = _entityRepoUser.GetSingleNotTracked(x => x.Id == documentViewModel.TransactionUserId);
                    User validateur = _entityRepoUser.GetSingleNotTracked(x => x.Id == documentViewModel.IdValidator);
                    documentViewModel.AskedByRequest = (user != null) ? user.FirstName + " " + user.LastName : "";
                    documentViewModel.ApprovedByRequest = (validateur != null) ? validateur.FirstName + " " + validateur.LastName : "";

                }

            }


            return listModel;
        }

        private void GetChildrenList(string userMail, List<int> users)
        {
            User user = _entityRepoUser.GetSingleWithRelations(x => x.Email == userMail, x => x.InverseIdUserParentNavigation);
            users.Add(user.Id);
            if (user.InverseIdUserParentNavigation != null && user.InverseIdUserParentNavigation.Any())
            {
                foreach (var item in user.InverseIdUserParentNavigation)
                {
                    GetChildrenList(item.Email, users);
                }
            }
        }

        public void UpdateIdDocumentAssociated(DocumentViewModel documentViewModel)
        {
            try
            {
                Document document = _entityRepo.GetSingleNotTracked(x => x.Id == documentViewModel.Id);
                document.IdDocumentAssociated = documentViewModel.IdDocumentAssociated;
                _entityRepo.Update(document);
                _unitOfWork.Commit();
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns> the list of documentLines lin related to current document 
        /// </returns>
        public List<DocumentLineViewModel> GetDocumentLinesWithDocument(ReduisDocumentViewModel ReduisDocument)
        {
            List<DocumentLineViewModel> previousDocumentLines = _serviceDocumentLine.GetModelsWithConditionsRelations(x =>
                x.IdDocumentNavigation.IdTiers == ReduisDocument.IdTiers &&
                x.IdDocumentNavigation.DocumentTypeCode == ReduisDocument.DocumentType &&
                !x.IdDocumentNavigation.IsTermBilling
                && x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid,
                x => x.IdDocumentNavigation, x => x.IdItemNavigation, x => x.DocumentLineTaxe, x => x.IdWarehouseNavigation).ToList();

            foreach (DocumentLineViewModel documentLine in previousDocumentLines)
            {
                documentLine.RemainingQuantity = documentLine.MovementQty - _serviceDocumentLine.AccountAssocietedQuantity(documentLine.Id);
                documentLine.RemainingQuantity -= ReduisDocument.DocumentLine.Where(x => x.IdDocumentLineAssociated == documentLine.Id).Sum(x => x.MovementQty);
                if (documentLine.UnitPriceFromQuotation != null && !documentLine.UnitPriceFromQuotation.Equals(0))
                {
                    documentLine.HtUnitAmountWithCurrency = documentLine.UnitPriceFromQuotation;
                }
                SetDocumentLine(documentLine);
            }
            return previousDocumentLines.Where(x => x.RemainingQuantity > 0).ToList();
        }
        public void SetDocumentLine(DocumentLineViewModel dl)
        {
            var docuemntLineTaxe = _serviceDocumentLineTaxe.GetModelsWithConditionsRelations(x => x.IdDocumentLine == dl.Id, x => x.IdTaxeNavigation);
            dl.Taxe.AddRange(docuemntLineTaxe.Select(x => x.IdTaxeNavigation).ToList());

            var itemDL = _serviceItem.GetModelWithRelations(x => x.Id == dl.IdItem,
                x => x.IdUnitStockNavigation, x => x.TaxeItem,
           x => x.IdUnitSalesNavigation, x => x.ItemWarehouse,
           x => x.IdNatureNavigation);
            if (dl.UnitPriceFromQuotation != null && dl.UnitPriceFromQuotation != 0)
            {
                dl.HtUnitAmountWithCurrency = dl.UnitPriceFromQuotation;
            }
            dl.IdItemNavigation = itemDL;
            dl.Taxe = _serviceTaxe.FindModelBy(x => itemDL.TaxeItem.Any(y => x.Id == y.IdTaxe)).ToList();
        }

        public void UpdateDocumentAfterAddSettlement(SettlementViewModel model, Document document, int precision, double exchangeRate)
        {
            if (document == null)
            {
                throw new ArgumentNullException(nameof(document));
            }
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            document.DocumentAmountPaidWithCurrency = (document.DocumentAmountPaidWithCurrency.HasValue) ?
                AmountMethods.FormatValue(document.DocumentAmountPaidWithCurrency.Value, precision) : 0;
            document.DocumentAmountPaidWithCurrency += AmountMethods.FormatValue(model.AmountWithCurrency, precision);
            document.DocumentAmountPaid = (exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentAmountPaidWithCurrency : document.DocumentAmountPaidWithCurrency;
            document.DocumentRemainingAmountWithCurrency = AmountMethods.FormatValue((document.DocumentTtcpriceWithCurrency - document.DocumentAmountPaidWithCurrency).Value, precision);
            document.DocumentRemainingAmount = (exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentRemainingAmountWithCurrency : document.DocumentRemainingAmountWithCurrency;
            document.IdDocumentStatus = (int)(document.DocumentRemainingAmountWithCurrency.Value.IsApproximately(0, within: 0.0001) ?
                DocumentStatusEnumerator.TotallySatisfied : DocumentStatusEnumerator.PartiallySatisfied);
            _entityRepo.Update(document);
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Get Both of order has never been imported and balances in delivery Purchase lines import
        /// </summary>
        /// <param name="reduisDocument"></param>
        /// <returns></returns>
        public ImportDocumentBalancesViewModel GetDocumentsWithBalances(ReduisDocumentViewModel reduisDocument)
        {
            // Initialise the Returned Object
            ImportDocumentBalancesViewModel importPurchaseOrderObject = new ImportDocumentBalancesViewModel
            {
                DocumentsList = new List<DocumentViewModel>(),
                BalancesList = new List<DocumentLineViewModel>()
            };
            List<DocumentLine> docLine = _entityDocumentLineRepo.GetAllWithConditionsRelations(x => x.IdDocument == reduisDocument.CurrentDocumentId).ToList();

            // Get The document lines Ids from The Current Delivery Lines Imported
            var importedDocumentAssociated = docLine.Select(x => x.IdDocumentLineAssociated).Distinct();
            var idsDocLine = docLine.Select(y => y.Id);
            // Find Old document Lines

            List<DocumentLine> oldDocumentLines = _entityDocumentLineRepo.
                  GetAllWithConditionsRelations(x => x.IdDocumentNavigation.IdTiers == reduisDocument.IdTiers
                  && x.IdDocumentNavigation.DocumentTypeCode == reduisDocument.DocumentType
                  && !idsDocLine.Contains(x.Id)).ToList();


            // Get Ids Associated from all the  documents Lines => IdDocumentLineAssociated = Id of the documents associated that has imported
            var documentAssociatedLinesIds = oldDocumentLines.Select(x => x.IdDocumentLineAssociated).Distinct();

            // Add the Old document Line to The Current document Lines Imported to get the list of all documents associated that contains at least one line imported
            importedDocumentAssociated = importedDocumentAssociated.Concat(documentAssociatedLinesIds);

            // Get Document Ids from the old documents lines
            var importedDocumentAssociatedIds = _serviceDocumentLine.GetModelsWithConditionsRelations(
                x => importedDocumentAssociated.Contains(x.Id)
                && (reduisDocument.StartDate != null ? x.IdDocumentNavigation.DocumentDate.Date >= reduisDocument.StartDate.GetDateOfNullableDateTime() : true)
                  && (reduisDocument.EndDate != null ? x.IdDocumentNavigation.DocumentDate.Date <= reduisDocument.EndDate.GetDateOfNullableDateTime() : true)).Select(x => x.IdDocument).Distinct().ToList();

            /** find Document Model **/
            // Search valid Document not imported previousely 
            if (reduisDocument.LinesOnlyForSpecificItem != true)
            {
                importPurchaseOrderObject.DocumentsList = _entityRepo.GetAllWithConditionsRelations(x => x.IdTiers == reduisDocument.IdTiers
                 && x.DocumentTypeCode == reduisDocument.DocumentAssociatedType &&
                 (reduisDocument.DocumentAssociatedType == DocumentEnumerator.SalesOrder ? x.IdSalesDepositInvoice == null : true)
                 && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                 && !importedDocumentAssociatedIds.Contains(x.Id)
                 && (reduisDocument.serachCode != null ? x.Code.Contains(reduisDocument.serachCode) : true)
                 && (reduisDocument.StartDate != null ? x.DocumentDate.Date >= reduisDocument.StartDate.GetDateOfNullableDateTime() : true)
                  && (reduisDocument.EndDate != null ? x.DocumentDate.Date <= reduisDocument.EndDate.GetDateOfNullableDateTime() : true)
                  && (reduisDocument.IdUser != null ? x.IdCreator == reduisDocument.IdUser : true)
                  && (reduisDocument.DocumentType == DocumentEnumerator.SalesAsset ? x.InoicingType != (int)InvoicingTypeEnumerator.Other : true)
                  && (!reduisDocument.BlOnly.HasValue || (reduisDocument.BlOnly.Value && !x.TicketIdDeliveryFormNavigation.Any(y => y.IdDeliveryForm == x.Id))),
                  x => x.IdUsedCurrencyNavigation, y => y.IdCreatorNavigation).OrderByDescending(x => x.Id).ToList().Select(y => _builderdocument.BuildDocumentEntity(y)).ToList();
            }

            // Make new list that contains the new and the old Documents lines 
            List<DocumentLine> AllDeliverylines = new List<DocumentLine>();
            AllDeliverylines.AddRange(oldDocumentLines);
            AllDeliverylines.AddRange(docLine);

            List<DocumentLineViewModel> docLineList;

            // import only lines for specific item
            if (reduisDocument.LinesOnlyForSpecificItem == true)
            {
                docLineList = _serviceDocumentLine.GetModelsWithConditionsRelations(x => x.IdDocumentNavigation.IdTiers == reduisDocument.IdTiers && x.IdItem == reduisDocument.IdItem
                  && x.IdDocumentNavigation.DocumentTypeCode == reduisDocument.DocumentAssociatedType
                  && x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
                  && (reduisDocument.DocumentType == DocumentEnumerator.SalesAsset ? x.IdDocumentNavigation.InoicingType != (int)InvoicingTypeEnumerator.Other : true),
                 x => x.IdDocumentNavigation,
                 x => x.IdDocumentNavigation.IdCreatorNavigation,
                 x => x.IdItemNavigation,
                 x => x.DocumentLineTaxe,
                 x => x.IdWarehouseNavigation,
                 x => x.IdMeasureUnitNavigation)
                 .ToList();
            }
            else if (reduisDocument.BlOnly == true)
            {
                docLineList = new List<DocumentLineViewModel>();
            }
            else
            {
                // Looping in documentAssociated lines List to verify balances 
                docLineList = _serviceDocumentLine.GetModelsWithConditionsRelations(x => x.IdDocumentNavigation.IdTiers == reduisDocument.IdTiers
                && importedDocumentAssociatedIds.Contains(x.IdDocument)
                && x.IdDocumentNavigation.DocumentTypeCode == reduisDocument.DocumentAssociatedType
                && (x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid || x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
                && (reduisDocument.StartDate != null ? x.IdDocumentNavigation.DocumentDate.Date >= reduisDocument.StartDate.GetDateOfNullableDateTime() : true)
                  && (reduisDocument.EndDate != null ? x.IdDocumentNavigation.DocumentDate.Date <= reduisDocument.EndDate.GetDateOfNullableDateTime() : true)
                  && (reduisDocument.IdUser != null ? x.IdDocumentNavigation.IdCreator == reduisDocument.IdUser : true)
                  && (reduisDocument.DocumentType == DocumentEnumerator.SalesAsset ? x.IdDocumentNavigation.InoicingType != (int)InvoicingTypeEnumerator.Other : true),
                x => x.IdDocumentNavigation,
                x => x.IdDocumentNavigation.IdUsedCurrencyNavigation,
                x => x.IdDocumentNavigation.IdCreatorNavigation,
                x => x.IdItemNavigation,
                x => x.IdItemNavigation.IdUnitSalesNavigation,
                x => x.IdItemNavigation.IdUnitStockNavigation,
                x => x.DocumentLineTaxe,
                x => x.IdWarehouseNavigation,
                x => x.IdMeasureUnitNavigation
               )
                .ToList();
            }
            var idsdocLineList = docLineList.Select(x => x.Id);
            var allDocuemntLineTaxe = _serviceDocumentLineTaxe.GetModelsWithConditionsRelations(x => idsdocLineList.Contains(x.IdDocumentLine), x => x.IdTaxeNavigation);
            var idsItemsdocLineList = docLineList.Select(x => x.IdItem);
            var allItemDL = _serviceItem.GetModelsWithConditionsRelations(p => idsItemsdocLineList.Contains(p.Id),
                       p => p.IdUnitStockNavigation, p => p.TaxeItem,
                  p => p.IdUnitSalesNavigation, p => p.ItemWarehouse,
                  p => p.IdNatureNavigation);
            CurrencyViewModel docCurrency = new CurrencyViewModel();
            if (docLineList != null && docLineList.Count() > 0)
            {
                docCurrency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == docLineList.FirstOrDefault().IdDocumentNavigation.IdUsedCurrency);
            }
            List<int> docsWithDiscountLine = new List<int>();
            docLineList.ForEach(x =>
            {
                double importedQuantity = AllDeliverylines.Where(y => y.IdDocumentLineAssociated == x.Id &&
                (y.Id == 0 || (y.Id != 0 && y.IdDocument != reduisDocument.CurrentDocumentId)
                || (y.Id != 0 && y.IdDocument == reduisDocument.CurrentDocumentId && idsDocLine.Contains(y.Id))
                )).Sum(y => y.MovementQty);
                if (x.MovementQty > importedQuantity)
                {
                    x.RemainingQuantity = AmountMethods.FormatValue((x.MovementQty - importedQuantity), x.IdMeasureUnitNavigation != null ? x.IdMeasureUnitNavigation.DigitsAfterComma : 0);

                    var docuemntLineTaxe = allDocuemntLineTaxe.Where(p => p.IdDocumentLine == x.Id);
                    x.Taxe = docuemntLineTaxe.Select(p => p.IdTaxeNavigation).ToList();
                    if (x.UnitPriceFromQuotation != null && x.UnitPriceFromQuotation != 0)
                    {
                        x.HtUnitAmountWithCurrency = x.UnitPriceFromQuotation;
                    }
                    var itemDL = allItemDL.Where(p => p.Id == x.IdItem).FirstOrDefault();
                    x.IdItemNavigation = itemDL;
                    if (docCurrency != null)
                    {
                        x.IdDocumentNavigation.FormatOption = new NumberFormatOptionsViewModel
                        {
                            style = Constants.STYLE_CURRENCY,
                            currency = docCurrency.Code,
                            currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                            minimumFractionDigits = docCurrency.Precision
                        };
                    }
                    importPurchaseOrderObject.BalancesList.Add(x);
                }
                if(x.MovementQty == -1 && importedQuantity == 0)
                {
                    docsWithDiscountLine.Add(x.IdDocument);
                }
            });
            importPurchaseOrderObject.BalancesList.ForEach(line =>
            {
                if (docsWithDiscountLine.Contains(line.IdDocument))
                {
                    line.HaveDiscountLineInDocument = true;
                }
            });
            importPurchaseOrderObject.DocumentsList.ForEach(x =>
            {
                x.FormatOption = new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = x.IdUsedCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = x.IdUsedCurrencyNavigation.Precision
                };
            });
            return importPurchaseOrderObject;
        }
        // generate purchase invoice from purchase delevery charges 
        private void GenerateChargesPurchaseInvoice(DocumentViewModel document)
        {
            document.DocumentExpenseLine = _serviceDocumentExpenseLine.FindModelsByNoTracked(x => x.IdDocument == document.Id, x => x.IdExpenseNavigation,
                  p => p.IdTiersNavigation, x => x.IdTaxeNavigation).ToList();

            var expenseLineResult = document.DocumentExpenseLine.GroupBy(p => p.IdTiers, (key, g) => new { IdTiers = key, expenseLines = g.ToList() });

            var supplier = _serviceTiers.GetModelsWithConditionsRelations(x => expenseLineResult.Select(z => z.IdTiers).Any(y => y == x.Id), x => x.IdCurrencyNavigation);
            var otherTax = _servicePurchaseSettings.GetModelAsNoTracked(x => true).PurchaseOtherTaxes;
            var company = GetCurrentCompany();
            foreach (var expenseLine in expenseLineResult)
            {

                // create document
                DocumentViewModel documentInvoice = new DocumentViewModel
                {
                    DocumentTypeCode = DocumentEnumerator.PurchaseInvoice,
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    CreationDate = DateTime.Now,
                    DocumentDate = DateTime.Now,
                    DocumentInvoicingDate = DateTime.Now,
                    IdUsedCurrency = supplier.First(x => x.Id == expenseLine.IdTiers).IdCurrency,
                    IdTiers = expenseLine.IdTiers,
                    Id = 0,
                    IdDocumentAssociated = document.Id,
                    IsGenerated = true,
                    IdCreator = document.IdCreator,
                    //create document line
                    DocumentLine = new List<DocumentLineViewModel>()
                };
                if (expenseLine.expenseLines != null && expenseLine.expenseLines.Any() && expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation != null &&
                    expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation.IdTaxeGroupTiers != null && expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation.IdTaxeGroupTiers ==
                (int)TaxeGroupEnumerator.NotExempt && (document.DocumentOtherTaxes == null || document.DocumentOtherTaxes == 0) &&
                expenseLine.expenseLines.FirstOrDefault().IdCurrency == company.IdCurrency)
                {
                    documentInvoice.DocumentOtherTaxes = company.FiscalStamp;
                    documentInvoice.DocumentOtherTaxesWithCurrency = company.FiscalStamp;
                }
                if (expenseLine.expenseLines != null && expenseLine.expenseLines.Any() && expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation != null &&
                    expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation.IdTaxeGroupTiers != null && expenseLine.expenseLines.FirstOrDefault().IdTiersNavigation.IdTaxeGroupTiers ==
                   (int)TaxeGroupEnumerator.NotExempt && document.DocumentOtherTaxes != null && document.DocumentOtherTaxes > 0)
                {
                    documentInvoice.DocumentOtherTaxesWithCurrency = document.DocumentOtherTaxes;
                }

                foreach (var documentLine in expenseLine.expenseLines)
                {
                    DocumentLineViewModel line = new DocumentLineViewModel
                    {
                        IdItem = documentLine.IdExpenseNavigation.IdItem,
                        Designation = documentLine.Designation,
                        HtUnitAmount = documentLine.HtAmountLineWithCurrency,
                        HtUnitAmountWithCurrency = documentLine.HtAmountLineWithCurrency,
                        Id = 0,
                        //create document line taxe
                        DocumentLineTaxe = new List<DocumentLineTaxeViewModel>(),
                        Taxe = new List<TaxeViewModel>(),
                        HtAmountWithCurrency = documentLine.HtAmountLineWithCurrency,
                        MovementQty = 1,
                        DiscountPercentage = 0,
                        IsExpenseLine = true,
                        IdDocumentLineStatus = documentInvoice.IdDocumentStatus,
                        TaxeAmoun = documentLine.TaxeAmoun,
                        TaxeAmount = documentLine.TaxeAmount,
                        TtcTotalLine = documentLine.TtcAmoutLine,
                        TtcTotalLineWithCurrency = documentLine.TtcAmountLineWithCurrency
                    };
                    line.Taxe.Add(_serviceTaxe.GetModel(x => x.Id == documentLine.IdTaxe));
                    line.DocumentLineTaxe.Add(CreateDocumentLineTaxe(line.Taxe.FirstOrDefault(), documentLine));

                    // add document line to document
                    documentInvoice.DocumentLine.Add(line);
                }
                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == documentInvoice.DocumentTypeCode);
                AddDocumentWithoutTransaction(null, documentInvoice, documentType, null, new List<EntityAxisValuesViewModel>());
            }
        }
        //create documentLineTaxe from taxe 
        private DocumentLineTaxeViewModel CreateDocumentLineTaxe(TaxeViewModel Taxe, DocumentExpenseLineViewModel documentLine)
        {
            DocumentLineTaxeViewModel DocumentLineTaxe = new DocumentLineTaxeViewModel
            {
                IdTaxe = Taxe.Id,
                TaxeName = Taxe.Label,
                TaxType = Taxe.TaxeType,
                Id = 0
            };
            DocumentLineTaxe.TaxeValue = Taxe.IsCalculable ? ((documentLine.TtcAmountLineWithCurrency / documentLine.HtAmountLineWithCurrency) - 1) * 100 : documentLine.TaxeAmount;
            return DocumentLineTaxe;
        }


        // generate purchase invoice from purchase delevery lines
        private void GeneratePurchaseInvoice(DocumentViewModel document)
        {
            var company = GetCurrentCompany();
            var otherTax = document.IdUsedCurrency == company.IdCurrency ? _servicePurchaseSettings.GetModel(x => true).PurchaseOtherTaxes : 0;
            var dTaxesResume = _serviceDocumentTaxeResume.FindModelsByNoTracked(x => x.IdDocument == document.Id);
            document.DocumentTaxsResume = dTaxesResume;
            DocumentViewModel documentInvoice = document.ShallowCopy();
            documentInvoice.Id = 0;
            documentInvoice.DocumentOtherTaxesWithCurrency = otherTax;
            documentInvoice.DocumentTypeCode = DocumentEnumerator.PurchaseInvoice;
            documentInvoice.IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional;
            documentInvoice.CreationDate = DateTime.Now;
            documentInvoice.DocumentDate = DateTime.Now;
            documentInvoice.DocumentInvoicingDate = documentInvoice.DocumentInvoicingDate == null ? DateTime.Now : documentInvoice.DocumentInvoicingDate;
            documentInvoice.DocumentExpenseLine = null;
            documentInvoice.Code = string.Empty;
            documentInvoice.IdCreator = document.IdCreator;
            documentInvoice.IdDocumentAssociated = document.Id;
            documentInvoice.DocumentTaxsResume.ToList().ForEach(x =>
            {
                x.Id = 0;
                x.IdDocument = documentInvoice.Id;

            });
            documentInvoice.DocumentLine.ToList().ForEach(x =>
            {
                x.IdDocumentLineAssociated = x.Id;
                x.Id = 0;
                x.DocumentLineTaxe = null;
                x.IdDocumentLineStatus = documentInvoice.IdDocumentStatus;
            });

            if (documentInvoice.IdTiersNavigation != null && documentInvoice.IdTiersNavigation.IdTaxeGroupTiers != null && documentInvoice.IdTiersNavigation.IdTaxeGroupTiers ==
                (int)TaxeGroupEnumerator.NotExempt && (documentInvoice.DocumentOtherTaxes == null || documentInvoice.DocumentOtherTaxes == 0) && documentInvoice.IdUsedCurrency == company.IdCurrency)
            {
                documentInvoice.DocumentOtherTaxes = company.FiscalStamp;
                documentInvoice.DocumentOtherTaxesWithCurrency = company.FiscalStamp;
            }
            if (documentInvoice.IdTiersNavigation != null && documentInvoice.IdTiersNavigation.IdTaxeGroupTiers != null && documentInvoice.IdTiersNavigation.IdTaxeGroupTiers ==
               (int)TaxeGroupEnumerator.NotExempt && documentInvoice.DocumentOtherTaxes != null && documentInvoice.DocumentOtherTaxes > 0)
            {
                documentInvoice.DocumentOtherTaxesWithCurrency = documentInvoice.DocumentOtherTaxes;
            }
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == documentInvoice.DocumentTypeCode);
            AddDocumentWithoutTransaction(null, documentInvoice, documentType, null, new List<EntityAxisValuesViewModel>());

        }

        //generate purchase invoice document from purchase delivery
        private void GenerateInvoice(DocumentViewModel document)
        {
            foreach (var documentLine in document.DocumentLine)
            {
                documentLine.StockMovement = null;
            }

            if (document.DocumentExpenseLine != null)
            {
                GenerateChargesPurchaseInvoice(document);
            }

            //GeneratePurchaseInvoice(document);
        }

        /// <summary>
        /// Get Movement History (BL/BR) related to an Item 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ItemHistoryViewModel GetMovementHistoryRelatedToItem(ItemHistoryViewModel model)
        {
            model.Document = new List<DocumentMovementDetail>();
            List<DocumentLineViewModel> lines = new List<DocumentLineViewModel>();
            if (model.IdItem != 0)
            {
                List<StockDocumentLine> listStockDocLine = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == model.IdItem && x.ForecastQuantity != x.ActualQuantity &&
                x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid, x => x.IdStockDocumentNavigation, x => x.IdStockDocumentNavigation.IdTiersNavigation,
                x => x.IdItemNavigation).ToList();
                listStockDocLine.Select(x => { x.ForecastQuantity = x.ForecastQuantity.HasValue ? x.ForecastQuantity.Value : 0; return x; }).ToList();
                List<DocumentMovementDetail> linesStockDocLine = listStockDocLine.Select(x => new DocumentMovementDetail
                {
                    Code = x.IdStockDocumentNavigation.Code,
                    IdDocument = x.IdStockDocument,
                    DocumentDate = x.IdStockDocumentNavigation.DocumentDate,
                    IdTiers = x.IdStockDocumentNavigation.IdTiers,
                    TiersCode = x.IdStockDocumentNavigation.IdTiersNavigation != null ? x.IdStockDocumentNavigation.IdTiersNavigation.CodeTiers : "",
                    TiersName = x.IdStockDocumentNavigation.IdTiersNavigation != null ? x.IdStockDocumentNavigation.IdTiersNavigation.Name : "",
                    DocumentTypeCode = x.IdStockDocumentNavigation.TypeStockDocument,
                    Quantity = x.ActualQuantity - x.ForecastQuantity > 0 ? (double)(x.ActualQuantity - x.ForecastQuantity) : (double)(x.ForecastQuantity - x.ActualQuantity),
                    Status = (int)x.IdStockDocumentNavigation.IdDocumentStatus,
                    SalesAmount = x.ActualQuantity - x.ForecastQuantity > 0 ? (x.IdItemNavigation.UnitHtsalePrice != null ? (double)x.IdItemNavigation.UnitHtsalePrice : 0) : 0,
                    IsSalesDocument = (x.ActualQuantity - x.ForecastQuantity > 0) ? true : false,
                    SalesQuantity = x.ActualQuantity - x.ForecastQuantity > 0 ? (double)(x.ActualQuantity - x.ForecastQuantity) : 0,
                    IsReservedLine = false,
                    PurchaseAmount = x.ActualQuantity - x.ForecastQuantity > 0 ? 0 : (x.IdItemNavigation.UnitHtsalePrice != null ? (double)x.IdItemNavigation.UnitHtsalePrice : 0),
                    PurchaseQuantity = x.ActualQuantity - x.ForecastQuantity > 0 ? 0 : (double)(x.ForecastQuantity - x.ActualQuantity),
                    IsInventoryDocument = true
                }).ToList();
                if (linesStockDocLine != null && linesStockDocLine.Any())
                {
                    model.Document = linesStockDocLine.ToList();
                }

                bool hasHistoryRole = RoleHelper.HasPermission("SHOW_COST_PRICE_ITEM");

                IQueryable<DocumentLine> listDocumentMvtDetail = _entityDocumentLineRepo.QuerableGetAll().Include(x => x.IdDocumentNavigation)
                    .ThenInclude(x => x.IdTiersNavigation).Include(x => x.StockMovement).Where(x => x.IdItem == model.IdItem
                     && DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, model.StartDate.Date) >= 0
                    && DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, model.EndDate.Date) <= 0
                    && (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                    || ((x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery
                    || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset
                    || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset
                    || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS
                    || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE)))
                    );
                IQueryable<DocumentMovementDetail> linesDocMvtDet = listDocumentMvtDetail.Select(x => new DocumentMovementDetail
                {
                    Code = x.IdDocumentNavigation.Code,
                    Reference = x.IdDocumentNavigation.Reference,
                    IdDocument = x.IdDocument,
                    DocumentDate = x.IdDocumentNavigation.DocumentDate,
                    IdTiers = x.IdDocumentNavigation.IdTiers,
                    TiersCode = x.IdDocumentNavigation.IdTiersNavigation != null ? x.IdDocumentNavigation.IdTiersNavigation.CodeTiers : "",
                    TiersName = x.IdDocumentNavigation.IdTiersNavigation != null ? x.IdDocumentNavigation.IdTiersNavigation.Name : "",
                    DocumentTypeCode = x.IdDocumentNavigation.DocumentTypeCode,
                    Quantity = x.MovementQty,
                    Status = x.IdDocumentNavigation.IdDocumentStatus,
                    SalesAmount = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS) ? (double)x.HtUnitAmount :
                    ((x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset) ? (double)(-x.HtUnitAmount) : 0),

                    IsSalesDocument = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset) ? true : false,

                    SalesQuantity = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset) ? x.MovementQty : 0,


                    IsReservedLine = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery) ?
                    (x.StockMovement.Select(z => z.Status).Contains(DocumentEnumerator.Reservation) ? true : false) : false,

                    PurchaseAmount = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery) ?
                    (hasHistoryRole && x.CostPrice != null ? x.CostPrice.Value : 0) :
                    ((x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE) ?
                    ((hasHistoryRole) ? (double)(-x.HtUnitAmount) : 0) :

                    0),


                    PurchaseQuantity = (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset) ? x.MovementQty : 0



                });
                model.Document.AddRange(linesDocMvtDet);
                model.Document = model.Document.OrderBy(x => x.DocumentDate).ToList();
                model.AvailableQty = _serviceItemWarehouse.GetItemQtyInAllWarehouses(model.IdItem, model.EndDate);
                model.StartQuantity = model.AvailableQty;

                model.Document.ForEach(x =>
                {
                    string documentType = x.DocumentTypeCode;

                    if (x.Status != (int)DocumentStatusEnumerator.Provisional && (x.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery || x.DocumentTypeCode == DocumentEnumerator.BE))
                    {
                        model.StartQuantity -= x.Quantity;
                    }
                    else if (x.DocumentTypeCode == DocumentEnumerator.SalesDelivery || (x.DocumentTypeCode == DocumentEnumerator.BS && x.Status != (int)DocumentStatusEnumerator.Provisional))
                    {
                        model.StartQuantity += x.Quantity;
                    }
                    else if (x.Status != (int)DocumentStatusEnumerator.Provisional && x.DocumentTypeCode == DocumentEnumerator.SalesAsset)
                    {
                        model.StartQuantity -= x.Quantity;
                    }
                    else if (x.Status != (int)DocumentStatusEnumerator.Provisional && x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset)
                    {
                        model.StartQuantity += x.Quantity;
                    }
                    else if (x.IsInventoryDocument)
                    {
                        model.StartQuantity -= x.Quantity;
                    }
                });
                if (model.StartQuantity < 0)
                {
                    model.StartQuantity = 0;
                    _serviceItemWarehouse.LogEroor(model.IdItem);
                }




                model.EndPurchaseAmount = hasHistoryRole ? model.Document.Sum(p => p.PurchaseAmount) : default;
                model.EndSaleAmount = model.Document.Sum(p => p.SalesAmount);

                if (model.AvailableQty < 0)
                {
                    model.AvailableQty = 0;
                    _serviceItemWarehouse.LogEroor(model.IdItem);
                }
                model.InQuantity = 0;
                model.OutQuantity = 0;
                if (model.Document.Any())
                {
                    model.InQuantity = model.Document.Sum(x => x.PurchaseQuantity) + model.StartQuantity;
                    model.OutQuantity = model.Document.Sum(x => x.SalesQuantity);
                }
                // Calculate number of days out of stock
                model.NumberDayOutStock = 0;
                model.NumberDayOutStock = CalculateNumberDaysOutStock(model.IdItem, model.EndDate, listDocumentMvtDetail);
            }
            return model;
        }

        public double CalculateNumberDaysOutStockCurrentYear(int idItem)
        {
            double numberDayOutStock = 0;
            IQueryable<DocumentLine> listDocumentMvtDetail = _entityDocumentLineRepo.QuerableGetAll().Include(x => x.IdDocumentNavigation)
                .Where(x => x.IdItem == idItem
                && x.IdDocumentNavigation.DocumentDate.Date.Year.Equals(System.DateTime.Today.Year)
                && (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                || ((x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery
                || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset
                || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset
                || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS
                || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE)))
                );
            numberDayOutStock = CalculateNumberDaysOutStock(idItem, new DateTime(DateTime.Today.Year, 12, 31), listDocumentMvtDetail);
            return numberDayOutStock;
        }

        double CalculateNumberDaysOutStock(int idItem, DateTime endDate, IQueryable<DocumentLine> listDocLine)
        {
            Item item = _itemEntityRepo.FindSingleBy(x => x.Id == idItem);
            int numberDayOutStock = 0;
            double endQuantity = _serviceItemWarehouse.GetItemQtyInAllWarehouses(idItem, endDate);

            if (endQuantity < 0)
            {
                endQuantity = 0;
                _serviceItemWarehouse.LogEroor(idItem);
            }

            IQueryable<Document> docs = listDocLine.Select(x => x.IdDocumentNavigation).Where(x => x.ValidationDate != null).OrderByDescending(y => y.ValidationDate).Distinct();
            int previousDoc = 0;
            List<Document> docNotProv = null;
            if (docs != null && docs.Any())
            {
                docNotProv = docs.Where(x => x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional).ToList();
                double qty = endQuantity;
                double qtyCalculated = 0;

                docNotProv.ForEach(x =>
                {
                    if (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional)
                    {
                        if (x.DocumentTypeCode == DocumentEnumerator.SalesAsset || x.DocumentTypeCode == DocumentEnumerator.BE ||
                            x.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
                        {
                            qtyCalculated = qty - listDocLine.Where(y => y.IdDocument == x.Id).Sum(z => z.MovementQty);

                        }
                        else if (x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset ||
                        x.DocumentTypeCode == DocumentEnumerator.BS || x.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                        {
                            qtyCalculated = qty + listDocLine.Where(y => y.IdDocument == x.Id).Sum(z => z.MovementQty);
                            if (qty <= 0 && qtyCalculated > 0)
                            {
                                if (previousDoc == 0)
                                {
                                    if (endDate.Year >= DateTime.Now.Year)
                                    {
                                        numberDayOutStock += (DateTime.Now - (DateTime)x.ValidationDate).Days;
                                    }
                                    else if (endDate.Year < DateTime.Now.Year)
                                    {
                                        numberDayOutStock += (new DateTime(endDate.Year, 12, 31) - (DateTime)x.ValidationDate).Days;
                                    }
                                }
                                else
                                {
                                    numberDayOutStock += ((DateTime)docs.Where(y => y.Id == previousDoc).FirstOrDefault().ValidationDate - (DateTime)x.ValidationDate).Days;
                                }
                            }
                        }
                        qty = qtyCalculated;
                        previousDoc = x.Id;
                    }
                });
                if (docNotProv != null && docNotProv.Any())
                {

                    if (item.CreationDate != null && item.CreationDate.Value.Year == endDate.Year &&
                        item.CreationDate < docNotProv.Where(x => x.Id == previousDoc).FirstOrDefault().ValidationDate && qty <= 0)
                    {
                        numberDayOutStock += ((DateTime)docNotProv.Where(x => x.Id == previousDoc).FirstOrDefault().ValidationDate - (DateTime)item.CreationDate).Days;
                    }
                    else if ((item.CreationDate == null || item.CreationDate.Value.Year <= endDate.Year) && qty <= 0)
                    {
                        numberDayOutStock += ((DateTime)docNotProv.Where(x => x.Id == previousDoc).FirstOrDefault().ValidationDate - new DateTime(endDate.Year, 1, 1)).Days;
                    }
                }

            }
            if (previousDoc == 0 && (docNotProv == null || !docNotProv.Any()))
            {
                if (item.CreationDate != null)
                {
                    if (endDate.Year >= DateTime.Now.Year)
                    {
                        if (item.CreationDate > new DateTime(endDate.Year, 01, 01))
                        {
                            numberDayOutStock += (DateTime.Now - (DateTime)item.CreationDate).Days;
                        }
                        else
                        {
                            numberDayOutStock += (DateTime.Now - new DateTime(endDate.Year, 01, 01)).Days;
                        }

                    }
                    else if (endDate.Year < DateTime.Now.Year)
                    {
                        if (item.CreationDate < new DateTime(endDate.Year, 12, 31))
                        {
                            numberDayOutStock += (new DateTime(endDate.Year, 12, 31) - (DateTime)item.CreationDate).Days;
                        }


                    }
                }
                else
                {
                    if (endDate.Year >= DateTime.Now.Year)
                    {
                        numberDayOutStock += (DateTime.Now - new DateTime(endDate.Year, 01, 01)).Days;
                    }
                    else if (endDate.Year < DateTime.Now.Year)
                    {
                        numberDayOutStock += (new DateTime(endDate.Year, 12, 31) - new DateTime(endDate.Year, 01, 01)).Days;
                    }

                }

            }
            return numberDayOutStock;
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

        public override List<string> GetFilesPath(IList<int> ids)
        {
            List<string> docsPath = _entityRepo.FindBy(d => ids.Contains(d.Id)).Select(d => d.AttachmentUrl).Where(x => !string.IsNullOrEmpty(x)).ToList();
            return docsPath;
        }
        public List<CreatedDataViewModel> GeneratePurchaseOrderFromPriceRequest
            (List<DocumentLineWithSupplier> documentLineWithSupplier, string userMail)
        {
            List<ItemViewModel> itemsList = _serviceItem.GetModelsWithConditionsRelations(x => documentLineWithSupplier.Select(y => y.DocumentLine.IdItem).Contains(x.Id)).ToList();
            List<DocumentViewModel> documentsList = FindModelsByNoTracked(x => documentLineWithSupplier.Select(y => y.IdDocumentAssocieted).Contains(x.Id), x => x.DocumentLine).ToList();
            int warehouseId = _serviceWarehouse.GetModelAsNoTracked(x => x.IsCentral).Id;

            foreach (var documentLine in documentLineWithSupplier.Select(x => x.DocumentLine))
            {
                documentLine.HtUnitAmountWithCurrency = itemsList.First(x => x.Id == documentLine.IdItem).UnitHtpurchasePrice ?? 0;
                documentLine.IdWarehouse = warehouseId;
                documentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
            }
            List<CreatedDataViewModel> createdDocuments = new List<CreatedDataViewModel>();
            var groupedCustomerList = documentLineWithSupplier.GroupBy(x => x.IdDocumentAssocieted).Select(g => new
            {
                IdDocumentAssocieted = g.Key,
                Idtiers = g.Select(i => i.IdTiers),
                IdUsedCurrency = g.Select(i => i.IdCurrency),
                IdPriceRequest = g.Select(i => i.IdPriceRequest).First(),
                Document = g.Select(i => new
                {
                    documentLine = i.DocumentLine
                }).ToList()

            }).ToList();
            int index = 0;
            foreach (var item in groupedCustomerList)
            {
                DocumentViewModel document = new DocumentViewModel
                {
                    IdPriceRequest = item.IdPriceRequest,
                    DocumentDate = DateTime.Now,
                    CreationDate = DateTime.Now,
                    IdUsedCurrency = item.IdUsedCurrency.FirstOrDefault(),
                    DocumentTypeCode = DocumentEnumerator.PurchaseFinalOrder,
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    IsGenerated = true,
                    DocumentLine = item.Document.Select(x => x.documentLine).ToList()
                };
                document.DocumentLine.ToList().ForEach(x =>
                {
                    x.HtUnitAmountWithCurrency = x.UnitPriceFromQuotation > 0 ?
                        x.UnitPriceFromQuotation : x.HtUnitAmountWithCurrency;
                    x.UnitPriceFromQuotation = 0;
                });
                document.IdTiers = item.Idtiers.FirstOrDefault();
                DocumentViewModel docAssocieted = documentsList.Find(x => x.Id == item.IdDocumentAssocieted);
                if (docAssocieted != null && docAssocieted.DocumentTypeCode == DocumentEnumerator.PurchaseBudget &&
                    docAssocieted.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    docAssocieted.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                    if (docAssocieted.DocumentLine != null && docAssocieted.DocumentLine.Any())
                    {
                        docAssocieted.DocumentLine.ToList().ForEach(x =>
                        {
                            x.IdDocumentLineAssociated = null;
                            x.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid;
                            x.IdDocumentNavigation = null;
                        });
                    }
                    UpdateDocument(null, docAssocieted, null, null, false);
                }
                createdDocuments.Add((CreatedDataViewModel)AddDocument(null, document, userMail, null));
                index++;
            }
            return createdDocuments;
        }

        private double CalculateSalesPricePerItemDependOnSalesPolicy(Item item,
            List<KeyValuePair<double, double>> listOfNewQtyPrice, double availableQty)
        {

            List<KeyValuePair<double, double>> listOfAvailableQtyPrice = new List<KeyValuePair<double, double>>();
            listOfAvailableQtyPrice.AddRange(listOfNewQtyPrice);
            if (item.UnitHtsalePrice != null && item.UnitHtsalePrice > 0)
            {
                listOfAvailableQtyPrice.Add(new KeyValuePair<double, double>(availableQty, item.UnitHtsalePrice ?? 0));
            }
            return listOfAvailableQtyPrice.Sum(p => p.Key * p.Value) / (availableQty + listOfNewQtyPrice.Sum(p => p.Key));

        }


        public void CalculDocument(DocumentViewModel documentViewModel, List<DocumentTaxsResume> UpdatedDocumentTaxsResumes, List<int> documentLinesId, Document document1, bool getTaxResume = true)
        {
            ReduisDocumentViewModel reduisDocument = new ReduisDocumentViewModel
            {
                DocumentType = documentViewModel.DocumentTypeCode,
                DocumentDate = documentViewModel.DocumentDate,
                IdTiers = documentViewModel.IdTiers ?? 0,
                DocumentOtherTaxe = documentViewModel.DocumentOtherTaxesWithCurrency ?? 0,
                DocumentLine = documentViewModel.DocumentLine,
            };
            var totalDocument = GetDocumentTotalPrice(reduisDocument);
            documentViewModel.DocumentHtpriceWithCurrency = totalDocument.DocumentHtpriceWithCurrency;
            documentViewModel.DocumentTotalVatTaxesWithCurrency = totalDocument.DocumentTotalVatTaxesWithCurrency;
            documentViewModel.DocumentTtcpriceWithCurrency = totalDocument.DocumentTtcpriceWithCurrency;
            documentViewModel.DocumentTotalDiscountWithCurrency = totalDocument.DocumentTotalDiscountWithCurrency;
            documentViewModel.DocumentPriceIncludeVatWithCurrency = totalDocument.DocumentPriceIncludeVatWithCurrency;
            documentViewModel.DocumentTotalExcVatTaxesWithCurrency = totalDocument.DocumentTotalExcVatTaxesWithCurrency;
            documentViewModel.DocumentRemainingAmountWithCurrency = totalDocument.DocumentTtcpriceWithCurrency;
            documentViewModel.DocumentOtherTaxesWithCurrency = totalDocument.DocumentOtherTaxesWithCurrency;
            if((documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesQuotation || documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesOrder || documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesInvoice || documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesAsset || documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)
                && documentViewModel.DocumentLine != null && documentViewModel.DocumentLine.Any())
            {
                int idDiscountItem = _itemEntityRepo.GetSingleNotTracked(x => x.Code == "Remise" && x.Description == "Remise").Id;
                if(documentViewModel.DocumentLine.Any(x=> x.IdItem == idDiscountItem))
                {
                    documentViewModel.DocumentTotalDiscountWithCurrency = documentViewModel.DocumentTotalDiscountWithCurrency - documentViewModel.DocumentLine.Where(x => x.IdItem == idDiscountItem).FirstOrDefault().HtTotalLineWithCurrency;
                }
;            }
            //get documentTaxsResume
            IList<DocumentTaxsResume> documentsTaxResume = new List<DocumentTaxsResume>();
            if (getTaxResume == true)
            {
                documentsTaxResume = _entityDocumentTaxsResume.FindByAsNoTracking(x => x.IdDocument == documentViewModel.Id).ToList();
            }
            int tiersPrecision = GetPrecissionValue(documentViewModel.IdUsedCurrency ?? 0, documentViewModel.DocumentTypeCode);
            int companyPrecision = GetCompanyCurrencyPrecision();
            var documentsLineTaxeRecap = document1.DocumentLine.SelectMany(x => x.DocumentLineTaxe).ToList();
            List<int> idTaxes = documentsLineTaxeRecap.Select(x => x.IdTaxe).Distinct().ToList();
            var listTaxes = _serviceTaxe.FindModelsByNoTracked(x => idTaxes.Contains(x.Id));

            var LineTaxeRecap = documentsLineTaxeRecap.GroupBy(x => x.IdTaxe)
                .Select(s => new
                {
                    s.Key,
                    taxeValue = s.Sum(y => y.TaxeValue),
                    taxeBase = s.Sum(y => y.TaxeBase),
                    taxeValueWithCurrency = s.Sum(y => y.TaxeValueWithCurrency),
                    taxeBaseWithCurrency = s.Sum(y => y.TaxeBaseWithCurrency),
                    discountAmountWithCurrency = s.Sum(y => Math.Round(((((y.IdDocumentLineNavigation.UnitPriceFromQuotation != null && !y.IdDocumentLineNavigation.UnitPriceFromQuotation.Value.IsApproximately(0, within: 0.0001)) ?
                                                y.IdDocumentLineNavigation.UnitPriceFromQuotation : y.IdDocumentLineNavigation.HtUnitAmountWithCurrency) ?? 0)
                                        - (y.IdDocumentLineNavigation.HtAmountWithCurrency ?? 0))
                                        * y.IdDocumentLineNavigation.MovementQty
                        , tiersPrecision
                        , MidpointRounding.ToEven)),
                    excVatTaxAmount = listTaxes.First(x => x.Id == s.Key).TaxeType != (int)TaxTypeEnumerator.BaseVat ? s.Sum(y => y.IdDocumentLineNavigation.ExcVatTaxAmount) : 0,
                    excVatTaxAmountWithCurrency = listTaxes.First(x => x.Id == s.Key).TaxeType != (int)TaxTypeEnumerator.BaseVat ? s.Sum(y => y.IdDocumentLineNavigation.ExcVatTaxAmountWithCurrency) : 0
                }).ToList();

            documentsTaxResume.ToList().ForEach(documentTaxe =>
            {
                if (LineTaxeRecap.FirstOrDefault(x => x.Key == documentTaxe.IdTax) == null)
                {
                    documentTaxe.IsDeleted = true;
                    UpdatedDocumentTaxsResumes.Add(documentTaxe);
                }
            });
            //add or update document tax recap
            LineTaxeRecap.ForEach(x =>
            {
                DocumentTaxsResume documentTaxsResume = documentsTaxResume.FirstOrDefault(y => y.IdTax == x.Key);
                if (documentTaxsResume != null && documentTaxsResume.IsDeleted == false)
                {
                    documentTaxsResume.HtAmount = AmountMethods.FormatValue(x.taxeBase, companyPrecision);
                    documentTaxsResume.HtAmountWithCurrency = AmountMethods.FormatValue(x.taxeBaseWithCurrency, tiersPrecision);
                    documentTaxsResume.TaxAmount = AmountMethods.FormatValue(x.taxeValue, companyPrecision);
                    documentTaxsResume.TaxAmountWithCurrency = AmountMethods.FormatValue(x.taxeValueWithCurrency, tiersPrecision);
                    documentTaxsResume.DiscountAmount = AmountMethods.FormatValue(x.discountAmountWithCurrency * (documentViewModel.ExchangeRate ?? 1), companyPrecision);
                    documentTaxsResume.DiscountAmountWithCurrency = AmountMethods.FormatValue(x.discountAmountWithCurrency, tiersPrecision);
                    documentTaxsResume.ExcVatTaxAmount = AmountMethods.FormatValue(x.excVatTaxAmount, companyPrecision);
                    documentTaxsResume.ExcVatTaxAmountWithCurrency = AmountMethods.FormatValue(x.excVatTaxAmountWithCurrency, tiersPrecision);
                    UpdatedDocumentTaxsResumes.Add(documentTaxsResume);
                }

                else
                {
                    UpdatedDocumentTaxsResumes.Add(new DocumentTaxsResume
                    {
                        IdTax = x.Key,
                        IdDocument = documentViewModel.Id,
                        HtAmount = AmountMethods.FormatValue(x.taxeBase, companyPrecision),
                        HtAmountWithCurrency = AmountMethods.FormatValue(x.taxeBaseWithCurrency, tiersPrecision),
                        TaxAmount = AmountMethods.FormatValue(x.taxeValue, companyPrecision),
                        TaxAmountWithCurrency = AmountMethods.FormatValue(x.taxeValueWithCurrency, tiersPrecision),
                        DiscountAmount = AmountMethods.FormatValue(x.discountAmountWithCurrency * (documentViewModel.ExchangeRate ?? 1), companyPrecision),
                        DiscountAmountWithCurrency = AmountMethods.FormatValue(x.discountAmountWithCurrency, tiersPrecision),
                        ExcVatTaxAmount = AmountMethods.FormatValue(x.excVatTaxAmount, companyPrecision),
                        ExcVatTaxAmountWithCurrency = AmountMethods.FormatValue(x.excVatTaxAmountWithCurrency, tiersPrecision)
                    });
                }
            });


            documentViewModel.DocumentTtcpriceWithCurrency = UpdatedDocumentTaxsResumes.Where(x => !x.IsDeleted).Sum(x => x.TaxAmountWithCurrency) + documentViewModel.DocumentHtpriceWithCurrency + (documentViewModel.DocumentOtherTaxesWithCurrency ?? 0);
            documentViewModel.DocumentTtcprice = UpdatedDocumentTaxsResumes.Where(x => !x.IsDeleted).Sum(x => x.TaxAmount) + (documentViewModel.DocumentOtherTaxesWithCurrency ?? 0) +
                AmountMethods.FormatValue(documentViewModel.DocumentLine.Sum(x => x.HtTotalLine.Value), companyPrecision);
            documentViewModel.DocumentTotalVatTaxes = UpdatedDocumentTaxsResumes.Where(x => !x.IsDeleted && listTaxes.First(y => y.Id == x.IdTax).TaxeType != (int)TaxTypeEnumerator.BaseVat).Sum(x => x.TaxAmount);
            documentViewModel.DocumentTotalVatTaxesWithCurrency = UpdatedDocumentTaxsResumes.Where(x => !x.IsDeleted && listTaxes.First(y => y.Id == x.IdTax).TaxeType != (int)TaxTypeEnumerator.BaseVat).Sum(x => x.TaxAmountWithCurrency);
        }

        public DocumentViewModel RecalculateDocumentAfterSetBudgetPurchase(DocumentViewModel purchaseOrderDocument, ItemPriceViewModel itemPricesViewModelBudget)
        {
            BeginTransaction();
            var docLine = _entityDocumentLineRepo.GetSingleNotTracked(x => x.IdDocument == purchaseOrderDocument.Id && x.IdItem == itemPricesViewModelBudget.DocumentLineViewModel.IdItem);
            var documentLine = _documentLineBuilder.BuildEntity(docLine);

            if (documentLine != null)
            {
                documentLine.MovementQty = itemPricesViewModelBudget.DocumentLineViewModel.MovementQty;
                documentLine.DiscountPercentage = itemPricesViewModelBudget.DocumentLineViewModel.DiscountPercentage;
                documentLine.UnitPriceFromQuotation = itemPricesViewModelBudget.DocumentLineViewModel.HtUnitAmountWithCurrency;
                documentLine.TaxeAmount = itemPricesViewModelBudget.DocumentLineViewModel.TaxeAmount;
                documentLine.DocumentLineTaxe = null;
            }

            ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
            {
                DocumentDate = itemPricesViewModelBudget.DocumentDate,
                DocumentLineViewModel = documentLine,
                DocumentType = DocumentEnumerator.PurchaseOrder,
                IdCurrency = itemPricesViewModelBudget.IdCurrency,
                IdTiers = itemPricesViewModelBudget.IdTiers,
                exchangeRate = itemPricesViewModelBudget.exchangeRate,
                Tiers = itemPricesViewModelBudget.Tiers,
            };
            CheckitemPricesObject(itemPriceViewModel);
            GetDocumentLinePrice(itemPriceViewModel);
            CalculateDocumentLine(itemPriceViewModel);
            _serviceDocumentLine.UpdateModelWithoutTransaction(itemPriceViewModel.DocumentLineViewModel, null, null);
            _unitOfWork.Commit(); ;
            var newpurchaseOrderDocument = UpdateDocumentAmountsWithoutTransaction(itemPriceViewModel.DocumentLineViewModel.IdDocument, null);
            _unitOfWork.Commit();

            newpurchaseOrderDocument.DocumentLine = null;
            if (newpurchaseOrderDocument.DocumentTypeCode == DocumentEnumerator.PurchaseOrder && IsDocumentLineNegotiatedFromDocumentId(newpurchaseOrderDocument.Id))
            {
                newpurchaseOrderDocument.IsNegotitated = true;
            }

            newpurchaseOrderDocument.DocumentTaxsResume = _serviceDocumentTaxeResume.FindModelsByNoTracked(x => x.IdDocument == purchaseOrderDocument.Id, x => x.IdTaxNavigation).ToList();
            newpurchaseOrderDocument.DocumentTaxsResume = newpurchaseOrderDocument.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
            EndTransaction();
            return newpurchaseOrderDocument;

        }

        public DocumentViewModel RecalculateDocumentAfterSetBudgetPurchaseDiscount(DocumentViewModel purchaseOrderDocument, List<ItemPriceViewModel> itemPricesViewModelBudget)
        {
            BeginTransaction();
            var docLine = _entityDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdDocument == purchaseOrderDocument.Id);
            var documentLine = docLine.Select(x => _documentLineBuilder.BuildEntity(x));
            List<ItemPriceViewModel> itemPricesViewModel = new List<ItemPriceViewModel>();

            if (documentLine != null && documentLine.Any())
            {
                documentLine.ToList().ForEach(docLine =>
                {
                    var itemprice = itemPricesViewModelBudget.FirstOrDefault(x => x.DocumentLineViewModel.IdItem == docLine.IdItem);
                    docLine.MovementQty = itemprice.DocumentLineViewModel.MovementQty;
                    docLine.DiscountPercentage = itemprice.DocumentLineViewModel.DiscountPercentage;
                    docLine.UnitPriceFromQuotation = itemprice.DocumentLineViewModel.HtUnitAmountWithCurrency;
                    docLine.TaxeAmount = itemprice.DocumentLineViewModel.TaxeAmount;
                    docLine.DocumentLineTaxe = null;

                    ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
                    {
                        DocumentDate = itemprice.DocumentDate,
                        DocumentLineViewModel = docLine,
                        DocumentType = DocumentEnumerator.PurchaseOrder,
                        IdCurrency = itemprice.IdCurrency,
                        IdTiers = itemprice.IdTiers,
                        exchangeRate = itemprice.exchangeRate,
                        Tiers = itemprice.Tiers,
                    };
                    CheckitemPricesObject(itemPriceViewModel);
                    GetDocumentLinePrice(itemPriceViewModel);
                    CalculateDocumentLine(itemPriceViewModel);

                    itemPricesViewModel.Add(itemPriceViewModel);
                });

            }

            _serviceDocumentLine.BulkUpdateModelWithoutTransaction(itemPricesViewModel.Select(x => x.DocumentLineViewModel).ToList(), null);
            _unitOfWork.Commit(); ;
            var newpurchaseOrderDocument = UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.FirstOrDefault().DocumentLineViewModel.IdDocument, null);
            _unitOfWork.Commit();

            newpurchaseOrderDocument.DocumentLine = null;
            if (newpurchaseOrderDocument.DocumentTypeCode == DocumentEnumerator.PurchaseOrder && IsDocumentLineNegotiatedFromDocumentId(newpurchaseOrderDocument.Id))
            {
                newpurchaseOrderDocument.IsNegotitated = true;
            }

            newpurchaseOrderDocument.DocumentTaxsResume = _serviceDocumentTaxeResume.FindModelsByNoTracked(x => x.IdDocument == purchaseOrderDocument.Id, x => x.IdTaxNavigation).ToList();
            newpurchaseOrderDocument.DocumentTaxsResume = newpurchaseOrderDocument.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
            EndTransaction();
            return newpurchaseOrderDocument;

        }

        public List<DocumentLineViewModel> GetDocumentLinesWithPaging(DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel, string userMail, out int total)
        {
            BeginTransactionunReadUncommitted();
            List<DocumentLineViewModel> result = new List<DocumentLineViewModel>();
            // get document lines with paging//
            total = _serviceDocumentLine.PredpareDocumentLines(documentLinesWithPagingViewModel, result, documentLinesWithPagingViewModel.predicate);
            EndTransaction();
            return result;
        }

        public DocumentViewModel SavePurchaseBudgetFromPurchaseOrder(int idDocument, string userMail)
        {
            DocumentViewModel documentQuotation = new DocumentViewModel();
            int idQuotation = default;
            var document = GetModelWithRelationsAsNoTracked(x => x.Id == idDocument);
            document.DocumentLine = _serviceDocumentLine.FindModelsByNoTracked(x => x.IdDocument == document.Id, x => x.DocumentLineTaxe).ToList();
            if (document != null)
            {
                BeginTransaction();
                if (document.IdDocumentAssociated == null)
                {
                    DocumentViewModel purchaseBudget = new DocumentViewModel
                    {
                        DocumentDate = DateTime.Now,
                        CreationDate = DateTime.Now,
                        DocumentTypeCode = DocumentEnumerator.PurchaseBudget,
                        IdTiers = document.IdTiers,
                        IdUsedCurrency = document.IdUsedCurrency,
                        IsGenerated = true,
                        DocumentLine = new List<DocumentLineViewModel>(),
                        IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                        IdCreator = document.IdCreator
                    };
                    if (document.DocumentLine != null && document.DocumentLine.Any())
                    {
                        DocumentLineViewModel docLineViewModel;
                        foreach (var documentLine in document.DocumentLine)
                        {
                            docLineViewModel = new DocumentLineViewModel();
                            _builder.MappingEntity(documentLine, docLineViewModel);
                            docLineViewModel.Id = 0;
                            docLineViewModel.IdDocument = purchaseBudget.Id;
                            docLineViewModel.StockMovement = null;
                            docLineViewModel.UnitPriceFromQuotation = 0;
                            if (documentLine.DocumentLineTaxe != null)
                            {
                                docLineViewModel.DocumentLineTaxe = (List<DocumentLineTaxeViewModel>)documentLine.CloneTaxes();
                                docLineViewModel.DocumentLineTaxe.ToList().ForEach(x => { x.Id = 0; x.IdDocumentLine = docLineViewModel.Id; });
                            }
                            if (documentLine.DiscountPercentage != null)
                            {
                                docLineViewModel.DiscountPercentage = documentLine.DiscountPercentage;
                            }

                            docLineViewModel.IdDocumentLineStatus = purchaseBudget.IdDocumentStatus;
                            purchaseBudget.DocumentLine.Add(docLineViewModel);
                        }

                    }

                    ////add quotation
                    int precision = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;
                    CalculateDocumentAndDocumenLineValues(document);
                    SetDocumentValueCurrency(document, precision);
                    ConvertAmountToLetter(document);

                    idQuotation = ((CreatedDataViewModel)AddModelWithoutTransaction(purchaseBudget, null, userMail, "DocumentTypeCode")).Id;


                    //idQuotation = ((CreatedDataViewModel)AddDocument(null, purchaseBudget, userMail, null)).Id;

                    // update IdAssociated
                    if (idQuotation > 0)
                    {
                        var quotation = _entityRepo.GetAllAsNoTracking().Include(x => x.DocumentLine).FirstOrDefault(x => x.Id == idQuotation);
                        if (document.DocumentLine != null && document.DocumentLine.Any() && quotation.DocumentLine != null && quotation.DocumentLine.Any())
                        {
                            foreach (var documentLine in document.DocumentLine)
                            {
                                DocumentLine docLineQuotation = quotation.DocumentLine.FirstOrDefault(x => x.IdItem == documentLine.IdItem);
                                if (docLineQuotation != null)
                                {
                                    documentLine.IdDocumentLineAssociated = docLineQuotation.Id;
                                    documentLine.UnitPriceFromQuotation = docLineQuotation.HtUnitAmountWithCurrency;
                                }
                                documentLine.IdDocumentNavigation = null;
                            }
                            _serviceDocumentLine.BulkUpdateWithoutTransaction(document.DocumentLine.Select(x => _documentLineBuilder.BuildModel(x)).ToList());

                        }
                        document.DocumentLine = null;
                        document.IdDocumentAssociated = idQuotation;
                        var ctx = _unitOfWork.GetContext();
                        var attachedEntity = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == document.Id);
                        if (attachedEntity != null)
                        {
                            ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
                        }
                        _entityRepo.Update(_builder.BuildModel(document));
                        _unitOfWork.Commit();
                    }
                }
                else
                {
                    DocumentViewModel purchaseBudget = GetModelAsNoTracked(x => x.Id == document.IdDocumentAssociated, x => x.DocumentLine);
                    idQuotation = purchaseBudget.Id;
                    List<DocumentLineViewModel> listDocumentLineViewModelToAdd = new List<DocumentLineViewModel>();
                    List<DocumentLineViewModel> listDocumentLineViewModelToDelete = new List<DocumentLineViewModel>();
                    List<DocumentLineViewModel> listDocumentLineViewModelToUpdate = new List<DocumentLineViewModel>();

                    List<DocumentLineViewModel> listDocumentLineViewModel = _serviceDocumentLine.FindByAsNoTracking(y => y.IdDocument == document.IdDocumentAssociated).ToList();

                    listDocumentLineViewModelToDelete = listDocumentLineViewModel.Where(p => !document.DocumentLine.Any(u => u.IdDocumentLineAssociated == p.Id)).ToList();
                    listDocumentLineViewModelToAdd = document.DocumentLine.Where(p => !listDocumentLineViewModel.Any(u => u.Id == p.IdDocumentLineAssociated)).ToList();
                    listDocumentLineViewModelToUpdate = listDocumentLineViewModel.Where(p => document.DocumentLine.Any(u => u.IdDocumentLineAssociated == p.Id && (p.MovementQty != u.MovementQty || p.DiscountPercentage != u.DiscountPercentage || p.TaxeAmount != u.TaxeAmount))).ToList();

                    if (listDocumentLineViewModelToDelete.Any())
                    {
                        listDocumentLineViewModelToDelete.ForEach(x =>
                        {
                            x.IsDeleted = true;
                            x.DeletedToken = Guid.NewGuid().ToString();
                        });
                        _serviceDocumentLine.BulkUpdateModelWithoutTransaction(listDocumentLineViewModelToDelete, userMail);
                    }
                    if (listDocumentLineViewModelToUpdate.Any())
                    {
                        listDocumentLineViewModelToUpdate.ForEach(x =>
                        {
                            var dl = document.DocumentLine.Where(y => y.IdDocumentLineAssociated == x.Id).First();
                            x.MovementQty = dl.MovementQty;
                            x.HtTotalLine = dl.HtTotalLine;
                            x.TtcTotalLine = dl.TtcTotalLine;
                            x.TtcTotalLineWithCurrency = dl.TtcTotalLineWithCurrency;
                            x.HtTotalLineWithCurrency = dl.HtTotalLineWithCurrency;
                            x.DiscountPercentage = dl.DiscountPercentage;
                            x.TaxeAmount = dl.TaxeAmount;
                        }
                        );
                        _serviceDocumentLine.BulkUpdateModelWithoutTransaction(listDocumentLineViewModelToUpdate, userMail);
                    }
                    if (listDocumentLineViewModelToAdd.Any())
                    {
                        purchaseBudget.DocumentLine = new List<DocumentLineViewModel>();
                        DocumentLineViewModel docLineViewModel;


                        foreach (DocumentLineViewModel documentLineViewModelToAdd in listDocumentLineViewModelToAdd)
                        {
                            docLineViewModel = new DocumentLineViewModel();
                            _builder.MappingEntity(documentLineViewModelToAdd, docLineViewModel);
                            docLineViewModel.Id = 0;
                            docLineViewModel.IdDocument = purchaseBudget.Id;
                            docLineViewModel.StockMovement = null;
                            docLineViewModel.DocumentLineTaxe = null;
                            docLineViewModel.IdDocumentLineStatus = purchaseBudget.IdDocumentStatus;
                            docLineViewModel.IdDocumentNavigation = null;
                            purchaseBudget.DocumentLine.Add(docLineViewModel);
                        }

                        int precision = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation.Precision;
                        CalculateDocumentAndDocumenLineValues(purchaseBudget);
                        SetDocumentValueCurrency(purchaseBudget, precision);
                        ConvertAmountToLetter(purchaseBudget);
                        UpdateModelWithoutTransaction(purchaseBudget, null, userMail);

                        List<DocumentLine> listDocumentLineQuotation = _entityDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocument == purchaseBudget.Id).ToList();
                        List<DocumentLineViewModel> listDocumentLineBCToUpdate = document.DocumentLine.Where(x => listDocumentLineViewModelToAdd.Select(y => y.IdItem).Contains(x.IdItem)).ToList();
                        List<DocumentLineViewModel> listOfBCFToUpdate = new List<DocumentLineViewModel>();
                        foreach (var documentLine in listDocumentLineViewModelToAdd)
                        {
                            DocumentLine docLineQuotation = listDocumentLineQuotation.FirstOrDefault(x => x.IdItem == documentLine.IdItem);
                            if (docLineQuotation != null)
                            {
                                documentLine.IdDocumentLineAssociated = docLineQuotation.Id;
                                documentLine.IdDocumentNavigation = null;
                                listOfBCFToUpdate.Add(documentLine);

                            }

                        }
                        _entityDocumentLineRepo.BulkUpdate(listOfBCFToUpdate.Select(x => _documentLineBuilder.BuildModel(x)).ToList());
                        _unitOfWork.Commit();
                    }

                }

                if (idQuotation > 0)
                {
                    documentQuotation = _entityRepo.GetAllAsNoTracking().Include(x => x.IdTiersNavigation)
                   .Where(x => x.Id == idQuotation).Select(x => _builder.BuildEntity(x)).ToList().FirstOrDefault();
                    //check if the associted purchase order is negotiated 
                    documentQuotation.IsNegotitated = IsDocumentLineNegotiatedFromDocumentId(idDocument);
                }
                EndTransaction();
            }
            return documentQuotation;
        }
        private DataSourceResult<DocumentListViewModel> FindDocumentDataSourceModelBy(PredicateFormatViewModel predicateModel, bool isBTob = false)
        {
            var filterDocType = predicateModel.Filter.FirstOrDefault(p => p.Prop == "DocumentTypeCode");
            if (filterDocType != null && filterDocType.Value.ToString() == DocumentEnumerator.SalesOrder)
            {
                predicateModel.Relation.Add(new RelationViewModel { Prop = "DocumentLine" });
            }
            var dateFilter = predicateModel.Filter.FirstOrDefault(x => x.Prop == "DocumentDate" && (x.Operation != Operation.IsNull && x.Operation != Operation.IsNotNull));
            if (dateFilter != null)
            {
                predicateModel.Filter.Remove(dateFilter);
            }

            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = PreparePredicate(predicateModel);
            return GetListDocumentsWithSpecificPredicat(predicateModel, predicateFilterRelationModel, dateFilter, isBTob);
        }

        private DataSourceResult<DocumentListViewModel> GetListDocumentsWithSpecificPredicat
            (PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Document> predicateFilterRelationModel, FilterViewModel dateFilter, bool isBTob = false)
        {
            IList<DocumentListViewModel> entities;
            DateTime dateF = default;
            if (dateFilter != null)
            {
                dateF = (DateTime)dateFilter.Value;
                dateF = new DateTime(dateF.Year, dateF.Month, dateF.Day);
            }

            IQueryable<Document> docLists = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).AsNoTracking().Include(x => x.IdUsedCurrencyNavigation).OrderByRelation(predicateModel.OrderBy).
                            Where(predicateFilterRelationModel.PredicateWhere);
            if (dateFilter != null)
            {
                switch (dateFilter.Operation)
                {
                    case Operation.Equals:
                        docLists = docLists.Where(x => x.CreationDate == dateF);
                        break;
                    case Operation.NotEquals:
                        docLists = docLists.Where(x => x.CreationDate != dateF);
                        break;
                    case Operation.GreaterThan:
                        docLists = docLists.Where(x => x.CreationDate > dateF);
                        break;
                    case Operation.GreaterThanOrEquals:
                        docLists = docLists.Where(x => x.CreationDate >= dateF);
                        break;
                    case Operation.LessThan:
                        docLists = docLists.Where(x => x.CreationDate < dateF);
                        break;
                    case Operation.LessThanOrEquals:
                        docLists = docLists.Where(x => x.CreationDate <= dateF);
                        break;
                    default:
                        break;
                }
            }

            if (!isBTob)
            {
                if (PredicateUtility<PredicateFormatViewModel>.IsDefaultOrderBy(predicateModel.OrderBy))
                {
                    docLists = docLists.OrderByDescending(x => x.DocumentDate);
                }
                else
                {
                    docLists = docLists.OrderByRelation(predicateModel.OrderBy);
                }
            }

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                List<Document> resultQuery = docLists.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();
                entities = resultQuery.Select(x => _builderdocument.BuildDocument(x)).ToList();
            }
            else
            {
                List<Document> resultQuery = docLists.ToList();
                entities = resultQuery.Select(x => _builderdocument.BuildDocument(x)).ToList();
            }

            IList<DocumentListViewModel> model = entities.ToList();
            var total = docLists.Count();
            return new DataSourceResult<DocumentListViewModel> { data = model, total = total };
        }


        /// <summary>
        /// Find List Of Document
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<DocumentListViewModel> FindDocumentList(PredicateFormatViewModel predicateModel, bool isBTob = false)
        {
            DataSourceResult<DocumentListViewModel> dataSourceResult;

            var tiesrFilter = predicateModel.Filter.FirstOrDefault(x => x.Prop == "IdTiersNavigation.Name");

            if (tiesrFilter != null)
            {
                tiesrFilter.IsSearchPredicate = true;
                var clone = (FilterViewModel)tiesrFilter.Clone();
                clone.Prop = "IdTiersNavigation.CodeTiers";
                predicateModel.Filter.Add(clone);
                dataSourceResult = FindDocumentDataSourceModelBy(predicateModel, isBTob);
            }
            else
            {
                dataSourceResult = FindDocumentDataSourceModelBy(predicateModel, isBTob);
            }

            var documentList = dataSourceResult.data.OfType<DocumentListViewModel>();
            var usedCurency = documentList.Select(x => x.IdUsedCurrency).Distinct().ToList();
            var usedcuency = _serviceCurrency.FindModelBy(x => usedCurency.Contains(x.Id)).ToList();


            var reservedDocumentList = new List<int>();

            if (documentList != null && documentList.Any())
            {
                var IdDocument = documentList.Select(x => x.Id).ToList();

                if (documentList.First().DocumentTypeCode == DocumentEnumerator.SalesDelivery)

                    reservedDocumentList = _entityDocumentLineRepo.GetAllAsNoTracking().Where(p => IdDocument.Contains(p.IdDocument) &&
                                                          p.StockMovement.Any(x => x.Status == DocumentEnumerator.Reservation)).Select(x => x.IdDocument).Distinct().ToList();
            }

            foreach (DocumentListViewModel document in documentList)
            {
                if (!isBTob)
                {
                    if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                    {
                        document.IdDocumentStatusNavigation.Color = "ecb50e";
                        if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                        {
                            document.haveReservedLines = reservedDocumentList.Contains(document.Id);
                            if (document.haveReservedLines)
                            {
                                document.IdDocumentStatusNavigation.Color = "cb7119";
                            }
                        }
                    }
                    else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                    {
                        document.IdDocumentStatusNavigation.Color = "4dbd74";
                        document.isPartiallyLivred = false;
                    }
                    else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed)
                    {
                        document.IdDocumentStatusNavigation.Color = "4608a0";
                    }

                    else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
                    {
                        document.isPartiallyLivred = true;
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
                }

                if (usedcuency.Count(x => x.Id == document.IdUsedCurrency) > 0)
                {
                    var currencyUsed = usedcuency.First(x => x.Id == document.IdUsedCurrency);
                    document.CurrencyCode = currencyUsed.Symbole;
                }



            }
            foreach (var documentListdata in dataSourceResult.data)
            {
                if (documentListdata.IdTiersNavigation != null && documentListdata.IdTiersNavigation.UrlPicture != null)
                {
                    documentListdata.IdTiersNavigation.PictureFileInfo = GetFiles(documentListdata.IdTiersNavigation.UrlPicture).FirstOrDefault();
                }
            }
            return dataSourceResult;
        }

        /// <summary>
        /// Find List Of Document
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public dynamic FindDocumentControlList(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<DocumentListViewModel> dataSourceResult;
            var tiesrFilter = predicateModel.Filter.FirstOrDefault(x => x.Prop == "IdTiersNavigation.Name");
            var typeFilter = predicateModel.Filter.Where(x => x.Prop == "DocumentTypeCode").ToList();

            foreach (var item in typeFilter)
            {
                predicateModel.Filter.Remove(item);
            }

            var docTypeFilters = filterByDocumentType(typeFilter.FirstOrDefault(w => !w.Value.ToString().Contains('-')));
            foreach (var item in docTypeFilters)
            {
                predicateModel.Filter.Add(item);
            }
            if (!predicateModel.Filter.Any())
            {
                predicateModel.Filter.Add(typeFilter.FirstOrDefault());
                predicateModel.Filter.FirstOrDefault().Value = DocumentEnumerator.PurchaseRequest;
                predicateModel.Filter.FirstOrDefault().Operation = Operation.NotEquals;
            }

            if (tiesrFilter != null)
            {
                tiesrFilter.IsSearchPredicate = true;
                var clone = (FilterViewModel)tiesrFilter.Clone();
                clone.Prop = "IdTiersNavigation.CodeTiers";
                predicateModel.Filter.Add(clone);
                dataSourceResult = FindDocumentDataSourceModelBy(predicateModel);
            }
            else
            {
                dataSourceResult = FindDocumentDataSourceModelBy(predicateModel);
            }


            var documentList = dataSourceResult.data.OfType<DocumentListViewModel>();
            var usedCurency = documentList.Select(x => x.IdUsedCurrency).Distinct().ToList();
            var usedcuency = _serviceCurrency.FindModelBy(x => usedCurency.Contains(x.Id)).ToList();

            if (dataSourceResult != null && dataSourceResult.data != null)
            {

                foreach (DocumentListViewModel document in documentList)
                {
                    if (usedcuency.Count(x => x.Id == document.IdUsedCurrency) > 0)
                    {
                        var currencyUsed = usedcuency.First(x => x.Id == document.IdUsedCurrency);
                        document.CurrencyCode = currencyUsed.Symbole;
                    }
                }
            }
            return dataSourceResult;
        }

        public List<FilterViewModel> filterByDocumentType(FilterViewModel filters)
        {
            List<FilterViewModel> finaldata = new List<FilterViewModel>();
            if (filters.Value != null)
            {

                var stringType = filters.Value.ToString().Substring(1, filters.Value.ToString().Length - 2).Trim().Split(',');
                int[] dataType = stringType.Length <= 1 && string.IsNullOrWhiteSpace(stringType[0]) ? null : Array.ConvertAll(stringType, (f => int.Parse(f)));


                if (dataType != null && dataType.Length > 0 && !dataType.Contains(-1))
                {
                    foreach (var item in dataType)
                    {
                        switch (item)
                        {
                            case (int)DocumentTypesEnumerator.SUPPLIER_ASSET:
                                filters.Value = DocumentEnumerator.PurchaseAsset;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.CUSTOMER_ASSET:
                                filters.Value = DocumentEnumerator.SalesAsset;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.BE:
                                filters.Value = DocumentEnumerator.BE;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.BS:
                                filters.Value = DocumentEnumerator.BS;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_QUOTATION:
                                filters.Value = DocumentEnumerator.PurchaseBudget;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.RECEIPT:
                                filters.Value = DocumentEnumerator.PurchaseDelivery;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.DELIVERY_FORM:
                                filters.Value = DocumentEnumerator.SalesDelivery;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_FINAL_ORDER:
                                filters.Value = DocumentEnumerator.PurchaseFinalOrder;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_INVOICE:
                                filters.Value = DocumentEnumerator.PurchaseInvoice;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.SALES_INVOICE:
                                filters.Value = DocumentEnumerator.SalesInvoice;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_ORDER:
                                filters.Value = DocumentEnumerator.PurchaseOrder;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.SALES_ORDER:
                                filters.Value = DocumentEnumerator.SalesOrder;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PRICE_REQUEST:
                                filters.Value = DocumentEnumerator.PurchaseQuotation;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.SALES_QUOTATION:
                                filters.Value = DocumentEnumerator.SalesQuotation;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_REQUEST:
                                filters.Value = DocumentEnumerator.PurchaseRequest;
                                finaldata.Add(filters);
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_TERMBILLING_INVOICE:
                                filters.Value = DocumentEnumerator.PurchaseInvoice;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "InoicingType", Value = 2, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.SALES_TERMBILLING_INVOICE:
                                filters.Value = DocumentEnumerator.SalesInvoice;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "InoicingType", Value = 2, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_ASSET_INVOICE:
                                filters.Value = DocumentEnumerator.PurchaseInvoice;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "InoicingType", Value = 3, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.SALES_ASSET_INVOICE:
                                filters.Value = DocumentEnumerator.SalesInvoiceAsset;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "IsRestaurn", Value = false, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.ALL_ASSETS_FINACIAL:
                                filters.Value = DocumentEnumerator.SalesInvoiceAsset;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "IsRestaurn", Value = true, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.PURCHASE_CASH_INVOICE:
                                filters.Value = DocumentEnumerator.PurchaseInvoice;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "InoicingType", Value = 1, Operation = filters.Operation });
                                break;
                            case (int)DocumentTypesEnumerator.SALES_CASH_INVOICE:
                                filters.Value = DocumentEnumerator.SalesInvoice;
                                finaldata.Add(filters);
                                finaldata.Add(new FilterViewModel { Prop = "InoicingType", Value = 1, Operation = filters.Operation });
                                break;
                            default:
                                break;
                        }
                    }
                }
            }

            return finaldata;
        }

        public double GetAvailbleQuantity(ItemQuantity itemQuantity)
        {
            return _serviceItemWarehouse.GetItemQtyInWarehouse(itemQuantity.IdItem, itemQuantity.IdWarehouse ?? 0);
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            if (_entityDocumentLineRepo.GetAllAsNoTracking().Any(p => p.IdDocument == id
                     && p.StockMovement.Any(x => x.Status == DocumentEnumerator.Reservation)))
            {
                new CustomException(CustomStatusCode.CantDeleteReservedDocument);
            }

            bool isSalesDeliver = _entityRepo.GetAllAsNoTracking().Where(x => x.Id == id && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery).Any();
            if (isSalesDeliver)
            {
                List<StockMovement> stockMovementList = _entityStockMovementRepo.GetAllAsNoTracking().Where(x => x.IdDocumentLineNavigation.IdDocument == id &&
                x.Status == DocumentEnumerator.Provisional).ToList();

                List<ItemWarehouse> itemWarehouseList = _entityItemWarehouseRepo.GetAllAsNoTracking().Where(p => stockMovementList.Select(x => x.IdItem).Contains(p.IdItem)).ToList();
                List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();
                foreach (var stockMovement in stockMovementList)
                {
                    var context = _unitOfWork.GetContext();
                    var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == stockMovement.IdItem
                    && e.Entity.IdWarehouse == stockMovement.IdWarehouse);
                    if (attachedItemwarehouse != null)
                    {
                        context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
                    }
                    ItemWarehouse itemwarehouse = itemWarehouseList.FirstOrDefault(x => x.IdItem == stockMovement.IdItem && x.IdWarehouse == stockMovement.IdWarehouse);
                    itemwarehouse.ReservedQuantity -= stockMovement.MovementQty ?? 0;
                    itemWarehouseToUpdate.Add(itemwarehouse);
                }
                _entityItemWarehouseRepo.BulkUpdate(itemWarehouseToUpdate);
            }
            Document document = _entityRepo.GetSingleNotTracked(x => x.Id == id);
            if (document.IdProvision > 0)
            {
                var documents = _entityRepo.QuerableGetAll().Where(x => x.IdProvision == document.IdProvision && x.Id != document.Id);
                if (documents.Count() == 0)
                {
                    var provision = _entityProvision.GetSingleNotTracked(x => x.Id == document.IdProvision);
                    if (provision != null)
                    {
                        provision.IsPurchaseOrderGenerated = false;
                        _entityProvision.Update(provision);
                    }
                }
            }
            document.IdProvision = null;

            List<int> idDocumentLine = _entityDocumentLineRepo.QuerableGetAll().Where(p => p.IdDocument == id).Select(p => p.Id).ToList();

            _entityStockMovementRepo.QuerableGetAll().Where(p => idDocumentLine.Contains(p.IdDocumentLine ?? 0)).UpdateFromQuery(p => new StockMovement
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });

            _entityDocumentLinePricesRepo.QuerableGetAll().Where(p => idDocumentLine.Contains(p.IdDocumentLine ?? 0)).UpdateFromQuery(p => new DocumentLinePrices
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });

            _entityDocumentLineTaxeRepo.QuerableGetAll().Where(p => idDocumentLine.Contains(p.IdDocumentLine)).UpdateFromQuery(p => new DocumentLineTaxe
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });

            _entityFinancialCommitmentRepo.QuerableGetAll().Where(p => p.IdDocument == id).UpdateFromQuery(p => new FinancialCommitment
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });
            _entityDocumentLineRepo.QuerableGetAll().Where(p => p.IdDocument == id).UpdateFromQuery(p => new DocumentLine
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });

            _entityDocumentExpenseLineRepo.QuerableGetAll().Where(p => p.IdDocument == id).UpdateFromQuery(p => new DocumentExpenseLine
            {
                IsDeleted = true,
                DeletedToken = Guid.NewGuid().ToString()
            });
            if (document != null && document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType == (int)InvoicingTypeEnumerator.advancePayment && document.IdSalesOrder != null)
            {
                _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == document.IdSalesOrder).UpdateFromQuery(p => new Document
                {
                    IdSalesDepositInvoice = null
                });
            }
            document.IsDeleted = true;
            document.DeletedToken = Guid.NewGuid().ToString();
            // delete invoice from ticket
            if (_entityRepo.GetAllAsNoTracking().Where(x => x.Id == id && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice).Any())
            {
                _ticketRepo.QuerableGetAll().Where(x => x.IdInvoice == id).UpdateFromQuery(p => new Ticket
                {
                    IdInvoice = null
                });
            }
            _entityRepo.Update(document);
            _unitOfWork.Commit();
            if (GetPropertyName(document) != null)
            {
                return new CreatedDataViewModel { Id = (int)document.Id, Code = getModelCode(document, GetPropertyName(document)), EntityName = document.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)document.Id, EntityName = document.GetType().Name.ToUpper() };

        }

        public bool CheckHasSalesInvoice(DocumentViewModel modelDoc)
        {
            var entitiesline = _entityDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocument == modelDoc.Id);
            var entitieslineId = entitiesline.Select(y => y.Id).ToList();

            var saleInvoiceLine = _entityDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x => entitieslineId.Contains((int)x.IdDocumentLineAssociated)
            && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice
            && x.IdDocumentNavigation.IdTiers == modelDoc.IdTiers, n => n.IdDocumentNavigation);
            if (saleInvoiceLine.Any(x => x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft))
            {
                return false;
            }
            else
            {
                return saleInvoiceLine.Any();
            }
        }


        /// <summary>
        /// Send mail of price request to suppliers
        /// </summary>
        /// <param name="idPriceRequest"></param>
        /// <param name="informationType"></param>
        /// <param name="user"></param>
        /// <param name="smtpSettings"></param>
        /// <param name="url"></param>
        public object SendPriceRequestMailFromOrder(int idDocument, string informationType, UserViewModel user, SmtpSettings smtpSettings, string url)
        {

            int userId = _entityRepoUser.GetSingleNotTracked(x => x.Email == user.Email).Id;
            // Get information
            InformationViewModel information = _serviceInformation.GetModelWithRelations(x => x.Type == informationType);
            // Get Document
            DocumentViewModel document = GetModelWithRelations(p => p.Id == idDocument, p => p.DocumentLine, p => p.IdContactNavigation, p => p.IdTiersNavigation, p => p.IdTiersNavigation.Contact);
            // If list of tiers of current price request not null ==> recuperate list of mail
            if (document != null && document.IdTiersNavigation != null && document.DocumentLine != null && document.DocumentLine.Any())
            {
                if (document.IdContact == null || document.IdContact == 0)
                {
                    // document without contact
                    throw new CustomException(CustomStatusCode.SendMailErrorDocumentWithoutContact);
                }
                if (document.IdContactNavigation != null && (document.IdContactNavigation.Email == null || document.IdContactNavigation.Email == ""))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "listOfTiersWithoutContactEmail", new List<string>(){ document.IdTiersNavigation.Name } }
                    };
                    // Error of send Mail
                    throw new CustomException(CustomStatusCode.SendMailErrorTiersWithoutContactEmail, paramtrs);
                }

                // Prepare message 
                MessageViewModel message = new MessageViewModel
                {
                    IdCreator = user.Id,
                    IdInformation = information.IdInfo,
                    EntityReference = document.Id,
                    CodeEntity = document.Code,
                    tiers = new List<TiersViewModel>() { document.IdTiersNavigation }
                };
                // Save message in dataBase
                int idMsg = _serviceMessage.AddMessage(message, null, user.Email);

                // Prepare mail to send
                MailBrodcastConfigurationViewModel mailBrodcastConfiguration = new MailBrodcastConfigurationViewModel
                {
                    IdMsg = idMsg,
                    URL = url,
                    Model = new CreatedDataViewModel
                    {
                        Id = document.Id,
                        Code = document.Code
                    },
                    users = new List<string> { document.IdContactNavigation.Email }
                };
                // Config and send mail
                _serviceMessage.ConfigureMail(mailBrodcastConfiguration, smtpSettings);
            }
            var entity = _builder.BuildModel(document);
            return new CreatedDataViewModel { Id = 0, EntityName = entity.GetType().Name.ToUpper() };
        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            Document document = _entityRepo.GetSingleNotTracked(x => x.Id == id);
            if (document != null)
            {
                if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    throw new CustomException(CustomStatusCode.AlreadyValidatedDocument);
                }
                List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllWithConditionsRelations(x => x.IdDocument == id, x => x.IdItemNavigation).ToList();
                List<int> idsItems = documentLines.Where(x => x.IdItemNavigation.ProvInventory).Select(p => p.IdItem).Distinct().ToList();

                if (document.DocumentTypeCode == DocumentEnumerator.BE && idsItems.Any())
                {
                    IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                                      x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                                      && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                                      && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSourceNavigation.IsCentral));
                    if (inventaireList.Any())
                    {
                        throw new CustomException(CustomStatusCode.DocumentHaveItemExistInProvisionalInventory);
                    }
                }
                if ((document.DocumentTypeCode == DocumentEnumerator.BS || document.DocumentTypeCode == DocumentEnumerator.SalesDelivery) && idsItems.Any())
                {
                    List<int?> idsWarehouses = documentLines.Where(x => x.IdItemNavigation.ProvInventory).Select(p => p.IdWarehouse).Distinct().ToList();
                    IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                     x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                     && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                     && (x.IdStockDocumentNavigation.IdTiers != null || idsWarehouses.Contains(x.IdStockDocumentNavigation.IdWarehouseSource)));
                    if (inventaireList.Any())
                    {
                        throw new CustomException(CustomStatusCode.DocumentHaveItemExistInProvisionalInventory);
                    }

                }
                if (document.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseBudget))
                {
                    Document documentToUpdate = _entityRepo.GetSingleNotTracked(x => x.IdDocumentAssociated == id);
                    if (documentToUpdate != null)
                    {
                        documentToUpdate.IdDocumentAssociated = null;
                        _entityRepo.Update(documentToUpdate);
                        _unitOfWork.Commit();
                    }
                    List<DocumentLine> docLines = _entityDocumentLineRepo.GetAllWithConditions(x => x.IdDocument == id).ToList();
                    if (docLines != null && docLines.Any())
                    {
                        List<DocumentLine> docLinesAssoc = _entityDocumentLineRepo.GetAllWithConditions(x => docLines.Select(y => y.Id).Contains((x.IdDocumentLineAssociated != null ? x.IdDocumentLineAssociated.Value : 0))).ToList();
                        if (docLinesAssoc != null && docLinesAssoc.Any())
                        {
                            docLinesAssoc.ForEach(z => z.IdDocumentLineAssociated = null);
                            _entityDocumentLineRepo.BulkUpdate(docLinesAssoc);
                            _unitOfWork.Commit();
                        }
                    }
                }
                else if (document.DocumentTypeCode.Equals(DocumentEnumerator.BS))
                {
                    List<Document> listSalesDelivery = _entityRepo.GetAllAsNoTracking()
                        .Where(y => (_entityDocumentLineRepo.GetAllAsNoTracking()
                        .Where(x => document.Id == x.IdDocument && x.IdDocumentAssociated != null)
                        .Select(x => x.IdDocumentAssociated).Distinct()).Contains(y.Id)).Include(y => y.DocumentLine).ToList();
                    if (listSalesDelivery != null && listSalesDelivery.Any())
                    {
                        _entityDocumentLineRepo.QuerableGetAll().Where(x => document.Id == x.IdDocument)
                                     .UpdateFromQuery(x => new DocumentLine
                                     {
                                         IdDocument = x.IdDocumentAssociated ?? 0,
                                         IdDocumentAssociated = null,
                                         IdDeliveryAssociated = null
                                     });

                        _unitOfWork.Commit();

                        foreach (Document docDelivForm in listSalesDelivery)
                        {
                            UpdateDocumentAmountsWithoutTransaction(docDelivForm.Id, null);
                        }
                    }

                }
                var obj = base.DeleteModel(id, tableName, userMail);
                if (document.DocumentTypeCode.Equals(DocumentEnumerator.PurchaseOrder) && document.IdDocumentAssociated != null)
                {
                    base.DeleteModel(document.IdDocumentAssociated.Value, tableName, userMail);
                }

                // Delete DocumentsTaxeResume
                List<DocumentTaxsResume> documentTaxsResumes = _entityDocumentTaxsResume.FindByAsNoTracking(x => x.IdDocument == document.Id).ToList();
                _entityDocumentTaxsResume.RemoveRange(documentTaxsResumes.ToArray());
                _unitOfWork.Commit();
                return obj;
            }
            return null;
        }

        public void SaveRemplacementItem(int idItem, int idDocumentLine, string code, string description)
        {
            ItemViewModel currentItem = _serviceItem.GetModelAsNoTracked(x => x.Id == idItem, x => x.ItemWarehouse, x => x.TaxeItem, x => x.ItemVehicleBrandModelSubModel, x => x.ItemTiers);
            ItemViewModel duplicatedItem = currentItem.DeepCopyByExpressionTree();
            duplicatedItem.Id = 0;
            duplicatedItem.Code = code;
            duplicatedItem.Description = description;
            duplicatedItem.UnitHtsalePrice = null;
            duplicatedItem.UnitHtpurchasePrice = null;
            duplicatedItem.IdItemReplacement = null;
            duplicatedItem.HaveClaims = false;
            duplicatedItem.TaxeItem = new List<TaxeItemViewModel>();
            duplicatedItem.TecDocId = null;
            duplicatedItem.TecDocRef = null;
            duplicatedItem.TecDocIdSupplier = null;
            duplicatedItem.EquivalenceItem = null;
            duplicatedItem.ListTiers = new List<TiersViewModel>();
            duplicatedItem.UrlPicture = null;
            currentItem.TaxeItem.ToList().ForEach(x =>
            {
                TaxeItemViewModel taxeMapped = new TaxeItemViewModel();
                _builder.MappingEntity(x, taxeMapped);
                taxeMapped.Id = 0;
                taxeMapped.IdItem = duplicatedItem.Id;
                duplicatedItem.TaxeItem.Add(taxeMapped);
            });
            duplicatedItem.ItemTiers.Select(x => { x.Id = 0; x.IdItemNavigation = null; duplicatedItem.ListTiers.Add(x.IdTiersNavigation); x.IdTiersNavigation = null; return x; }).ToList();
            duplicatedItem.ItemWarehouse.Select(x => { x.Id = 0; x.IdItemNavigation = null; x.IdWarehouseNavigation = null; x.AvailableQuantity = 0; return x; }).ToList();
            duplicatedItem.ItemVehicleBrandModelSubModel = new List<ItemVehicleBrandModelSubModelViewModel>();
            currentItem.ItemVehicleBrandModelSubModel.ToList().ForEach(x =>
            {
                ItemVehicleBrandModelSubModelViewModel itemVehicleBrandModelSubModelMapped = new ItemVehicleBrandModelSubModelViewModel();
                _builder.MappingEntity(x, itemVehicleBrandModelSubModelMapped);
                itemVehicleBrandModelSubModelMapped.Id = 0;
                itemVehicleBrandModelSubModelMapped.IdItem = duplicatedItem.Id;
                duplicatedItem.ItemVehicleBrandModelSubModel.Add(itemVehicleBrandModelSubModelMapped);
            });
            CreatedDataViewModel createdDataViewModel = (CreatedDataViewModel)_serviceItem.AddModel(duplicatedItem, null, null);
            currentItem.IdItemReplacement = createdDataViewModel.Id;
            currentItem.ItemWarehouse.ToList().ForEach(x => x.IdItemNavigation = null);
            currentItem.ItemVehicleBrandModelSubModel.ToList().ForEach(x => x.IdItemNavigation = null);
            if (currentItem.UrlPicture != null)
            {
                currentItem.FilesInfos = GetFiles(currentItem.UrlPicture).ToList();
            }
            _serviceItem.UpdateModel(currentItem, null, null);
            List<DocumentLineViewModel> listToUpdate = new List<DocumentLineViewModel>();
            DocumentLineViewModel documentLineViewModel = _serviceDocumentLine.GetModelAsNoTracked(x => x.Id == idDocumentLine);
            if (documentLineViewModel != null)
            {
                documentLineViewModel.IdItem = createdDataViewModel.Id;
                documentLineViewModel.HtUnitAmount = 0;
                documentLineViewModel.HtUnitAmountWithCurrency = 0;
                documentLineViewModel.HtAmount = 0;
                documentLineViewModel.HtAmountWithCurrency = 0;
                documentLineViewModel.HtTotalLine = 0;
                documentLineViewModel.HtTotalLineWithCurrency = 0;
                documentLineViewModel.TtcTotalLine = 0;
                documentLineViewModel.TtcTotalLineWithCurrency = 0;
                documentLineViewModel.Designation = duplicatedItem.Description;
                listToUpdate.Add(documentLineViewModel);
            }
            DocumentLineViewModel purchaseOrderDocumentLine = _serviceDocumentLine.GetModelAsNoTracked(x => x.IdDocumentLineAssociated == documentLineViewModel.Id);
            if (purchaseOrderDocumentLine != null)
            {
                purchaseOrderDocumentLine.IdItem = createdDataViewModel.Id;
                purchaseOrderDocumentLine.HtUnitAmount = 0;
                purchaseOrderDocumentLine.HtUnitAmountWithCurrency = 0;
                purchaseOrderDocumentLine.HtAmount = 0;
                purchaseOrderDocumentLine.HtAmountWithCurrency = 0;
                purchaseOrderDocumentLine.HtTotalLine = 0;
                purchaseOrderDocumentLine.HtTotalLineWithCurrency = 0;
                purchaseOrderDocumentLine.TtcTotalLine = 0;
                purchaseOrderDocumentLine.TtcTotalLineWithCurrency = 0;
                purchaseOrderDocumentLine.Designation = duplicatedItem.Description;
                listToUpdate.Add(purchaseOrderDocumentLine);
            }
            if (listToUpdate.Any())
            {
                _serviceDocumentLine.BulkUpdateModel(listToUpdate, null);
            }
        }

        public List<DocumentLineViewModel> GetDocumentLineByIdDocument(int idDocument)
        {
            return _serviceDocumentLine.FindModelsByNoTracked(x => x.IdDocument == idDocument, x => x.IdDocumentNavigation, x => x.IdItemNavigation).ToList();
        }

        public DataSourceResult<DocumentViewModel> GetValidAssetsAndInvoice(int idClient, dynamic data)
        {
            DocumentPagingViewModel gridstate = JsonConvert.DeserializeObject<DocumentPagingViewModel>(data.Gridstate.ToString());
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(data.Predicate.ToString());
            DateTime? startdate = data.StartDate != null ? Convert.ToDateTime(data.StartDate) : null;
            DateTime? enddate = data.EndDate != null ? Convert.ToDateTime(data.EndDate) : null;
            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<Document> res = _entityRepo.QuerableGetAll().Include(x => x.FinancialCommitment).Include(x => x.IdUsedCurrencyNavigation).Where(x => (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
                 && x.IdTiers == idClient
                 && (x.DocumentTypeCode == DocumentEnumerator.SalesInvoice || x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)
                 && x.DocumentRemainingAmountWithCurrency > 0).OrderByDescending(x => x.DocumentDate).AsQueryable();

            res = res.Where(predicateFilterRelationModel.PredicateWhere);
            if (startdate != null)
            {
                res = res.Where(x => DateTime.Compare(x.DocumentDate.Date, startdate.Value.Date) >= NumberConstant.Zero);
            }
            if (enddate != null)
            {
                res = res.Where(x => DateTime.Compare(x.DocumentDate, enddate.Value) <= NumberConstant.Zero);
            }
            int total = res.Count();
            IList<Document> documents = res.Skip(gridstate.Skip).Take(gridstate.Take).ToList();
            List<DocumentViewModel> documentList = documents.Select(_builder.BuildEntity).ToList();
            foreach (DocumentViewModel item in documentList)
            {
                if (item.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)
                {
                    item.DocumentRemainingAmount = item.DocumentRemainingAmount == null ? 0 : -(item.DocumentRemainingAmount);
                    item.DocumentRemainingAmountWithCurrency = -(item.DocumentRemainingAmountWithCurrency);
                }
                item.FormatOption = new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = item.IdUsedCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = item.IdUsedCurrencyNavigation.Precision
                };
            };
            DataSourceResult<DocumentViewModel> listModel = new DataSourceResult<DocumentViewModel>
            {
                data = documentList,
                total = total
            };
            return listModel;
        }

        public List<ManagementBaseObject> GetListOfActivePrinters()
        {

            List<ManagementBaseObject> printersActive = new List<ManagementBaseObject>();
            var printerQuery = new ManagementObjectSearcher("SELECT * from Win32_Printer");
            foreach (var printer in printerQuery.Get())
            {
                if (IsOnline(printer) && !IsPrinterError(printer))
                {
                    printersActive.Add(printer);
                }

            }

            return printersActive;
        }

        //check printer is online**
        private static bool IsOnline(ManagementBaseObject printer)
        {
            bool isOnlineprinter = true;
            var ResultPrinter01 = printer.Properties["ExtendedPrinterStatus"].Value.ToString();
            var ResultPrinter02 = printer.Properties["PrinterState"].Value.ToString();

            //(no internet connection or printer switched off):PrinterState
            if (ResultPrinter02 == "128" || ResultPrinter02 == "4096")
            {
                isOnlineprinter = false;
            }
            var network = printer.Properties["WorkOffline"].Value.ToString();
            if (network == "True")
            {
                isOnlineprinter = false;
            }

            ////printer is initializing....
            //if (ResultPrinter02 == "16")
            //{
            //    isOnlineprinter = false;
            //}

            //(no internet connection or printer switched off):ExtendedPrinterStatus
            if (ResultPrinter01 == "7")
            {
                isOnlineprinter = false;
            }

            return isOnlineprinter;
        }

        //check for out of paper**
        private static bool IspaperOK(ManagementBaseObject printer)
        {
            bool PaperOK = true;

            var PaperStatus = printer.Properties["PrinterState"].Value.ToString();

            //(PrinterState)16 = Out of Paper
            //(PrinterState)5 = Out of paper
            //(PrinterState)4 = paperjam
            //(PrinterState)144 = Out of paper
            if ((PaperStatus == "5") || (PaperStatus == "16") || (PaperStatus == "144"))
            {
                PaperOK = false;
            }
            return PaperOK;
        }

        //Verify still printing state or not**
        private static bool Isprinting(ManagementBaseObject printer)
        {
            bool Isprintingnow = false;
            var PrinterNameProperty = printer.Properties["DeviceId"].Value.ToString();
            var printing01 = printer.Properties["PrinterState"].Value.ToString();
            var printing02 = printer.Properties["PrinterStatus"].Value.ToString();
            //(PrinterState)11 = Printing
            //(PrinterState)1024 = printing
            //(PrinterStatus)4 = printing
            if (printing01 == "11" || printing01 == "1024" || printing02 == "4")
            {
                Isprintingnow = true;
            }

            return Isprintingnow;
        }

        //check for error (Printer)
        private static bool IsPrinterError(ManagementBaseObject printer)
        {
            bool PrinterOK = true;

            var PrinterSpecificError = printer.Properties["PrinterState"].Value.ToString();
            var otherError = printer.Properties["ExtendedPrinterStatus"].Value.ToString();
            //(PrinterState)2 - error of printer
            //(PrinterState)131072 - Toner Low
            //(PrinterState)18 - Toner Low
            //(PrinterState)19 - No Toner

            if ((PrinterSpecificError == "131072") || (PrinterSpecificError == "18") || (PrinterSpecificError == "19") || (PrinterSpecificError == "2") || (PrinterSpecificError == "7"))
            {
                PrinterOK = false;
            }

            //(ExtendedPrinterStatus) 2 - no error
            if (otherError == "2")
            {
                PrinterOK = true;
            }
            else
            {
                PrinterOK = false;
            }

            return PrinterOK;
        }

        //check Network or USB**
        private static bool IsNetworkPrinter(ManagementBaseObject printer)
        {
            bool IsNetwork = true;

            var network = printer.Properties["Network"].Value.ToString();

            var local = printer.Properties["Local"].Value.ToString();

            if (network == "True")
            {
                IsNetwork = true;
            }

            if (network == "True" && local == "True")
            {
                IsNetwork = true;
            }

            if (local == "True" && network == "False")
            {
                IsNetwork = false;
            }
            return IsNetwork;
        }

        public void OfConfirmation(int id)
        {
            try
            {
                BeginTransaction();
                Document document = _entityRepo.GetAllAsNoTracking().Include(x => x.DocumentLine).FirstOrDefault(x => x.Id == id);

                var documentLines = document.DocumentLine.ToList();
                if (document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                var dls = documentLines.Select(x => x.Id).ToList();
                var offConfirm = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking().Where(x => dls.Contains(x.IdDocumentLineAssociated ?? 0) &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset).Any();
                if (offConfirm)
                {
                    throw new CustomException(CustomStatusCode.DOCUMENT_IS_IMPORTED);
                }
                if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    document.IdDocumentStatus = (int)DocumentStatusEnumerator.Draft;

                    if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
                    {
                        foreach (var docline in documentLines)
                        {
                            docline.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Draft;
                        }
                    }
                    else
                    {
                        // delete document lines 
                        foreach (var item in documentLines)
                        {
                            item.IsDeleted = true;
                            item.DeletedToken = Guid.NewGuid().ToString();
                        }
                    }

                    _ticketRepo.GetAllWithConditions(x => x.IdInvoice == id).UpdateFromQuery(p => new Ticket
                    {
                        IdInvoice = null
                    });
                    _unitOfWork.Commit();

                    if (documentLines.Count > 0)
                    {
                        _serviceDocumentLine.BulkUpdateWithoutTransaction(documentLines);
                        setBlAsProvisional(documentLines.ToList());
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.INVALID_SATATUS_DOCUMENT);
                }

                UpdateDocAmountsWithoutTransaction(document, null);
                // delete documentTaxeResume
                _entityDocumentTaxsResume.GetAllAsNoTracking().Where(x => x.IdDocument == document.Id).UpdateFromQuery(
                    x => new DocumentTaxsResume { IsDeleted = true });
                // delete financial Commitments
                _entityFinancialCommitmentRepo.GetAllAsNoTracking().Where(x => x.IdDocument == document.Id).UpdateFromQuery(
                    x => new FinancialCommitment { IsDeleted = true });
                // delete DocumentWitholdingTax
                _entityDocumentWithholdingTaxRepo.GetAllAsNoTracking().Where(x => x.IdDocument == document.Id).UpdateFromQuery(
                   x => new DocumentWithholdingTax { IsDeleted = true });
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception ex)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(ex);
                throw;
            }

        }
        private void setBlAsProvisional(List<DocumentLine> documentLines)
        {
            var idDLAssociated = documentLines.Select(x => x.IdDocumentLineAssociated);
            var documentLinesToUpdate = _entityDocumentLineRepo.QuerableGetAll().Where(x => idDLAssociated.Contains(x.Id));

            _entityRepo.QuerableGetAll().Where(x => documentLinesToUpdate.Select(y => y.IdDocument).Contains(x.Id))
                .UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Valid });

            _entityDocumentLineRepo.QuerableGetAll().Where(p => documentLinesToUpdate.Select(y => y.Id).Contains(p.Id))
                        .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid });
        }

        public void ReValidate(int id)
        {
            BeginTransaction();
            try
            {
                var dlLines = _serviceDocumentLine.FindModelsByNoTracked(x => x.IdDocument == id);
                if (!dlLines.Any())
                {
                    throw new CustomException(CustomStatusCode.NoLinesAreAdded);
                }
                SetDocumentStaus(id);
                SoldeDocumentAssociated(id, null);
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == id,
                    doc => doc.IdTiersNavigation, expesne => expesne.DocumentExpenseLine);
                DocumentType documentType = _entityDocumentTypeRepo
                      .GetSingleWithRelationsNotTracked(c => c.CodeType == document.DocumentTypeCode, p => p.DefaultCodeDocumentTypeAssociatedNavigation);
                SetDocumentFinancialCommitment(document, documentType);
                UpdateItemTiersForDocumentPurchaseDelivery(document, dlLines.ToList());
                _unitOfWork.Commit();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception ex)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(ex);
                throw;
            }
            EndTransaction();
        }
        private void SetDocumentStaus(int id)
        {

            var document = GetModelAsNoTracked(x => x.Id == id);
            document.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
            _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == id)
               .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid });
            UpdateModelWithoutTransaction(document, null, null);
        }

        public DataSourceResult<DocumentViewModel> GetProvisionalBl(ProvisionalSDFilterViewModel provisionalSDFilter)
        {
            var StockMovementDocument = _serviceStockMovement.GetModelsWithConditionsRelations(c =>
            c.Operation == OperationEnumerator.Output && c.Status == DocumentEnumerator.Reservation &&
            c.IdDocumentLineNavigation.IdDocument != provisionalSDFilter.IdDocument,
            x => x.IdDocumentLineNavigation).Select(x => x.IdDocumentLineNavigation.IdDocument).ToList();

            IQueryable<Document> queryableListOfDocument = _entityRepo.QuerableGetAll().Where(x => x.IdTiers == provisionalSDFilter.IdSupplier &&
                x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional &&
                x.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.Id != provisionalSDFilter.IdDocument && !StockMovementDocument.Contains(x.Id))
                .Include(x => x.IdUsedCurrencyNavigation);

            if (provisionalSDFilter.Code != null)
            {
                queryableListOfDocument = queryableListOfDocument.Where(x => x.Code.Contains(provisionalSDFilter.Code));
            }
            if (provisionalSDFilter.StartDate != null && provisionalSDFilter.EndDate != null)
            {
                queryableListOfDocument = queryableListOfDocument.Where(x =>
                x.DocumentDate.Date >= ((DateTime)provisionalSDFilter.StartDate).Date &&
                x.DocumentDate.Date <= ((DateTime)provisionalSDFilter.EndDate).Date);
            }
            else if (provisionalSDFilter.StartDate != null)
            {
                queryableListOfDocument = queryableListOfDocument.Where(x =>
                x.DocumentDate.Date >= ((DateTime)provisionalSDFilter.StartDate).Date);
            }
            else if (provisionalSDFilter.EndDate != null)
            {
                queryableListOfDocument = queryableListOfDocument.Where(x =>
                x.DocumentDate.Date <= ((DateTime)provisionalSDFilter.EndDate).Date);
            }

            var documents = queryableListOfDocument.Select(_builder.BuildEntity).ToList();
            DataSourceResult<DocumentViewModel> listModel = new DataSourceResult<DocumentViewModel>
            {
                data = documents,
                total = documents.Count
            };
            return listModel;
        }





        public DocumentViewModel DeleteAllLinesFromId(List<int> idList)
        {
            try
            {
                if (idList.Count > 0)
                {

                    var ItemPrices = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking()
                        .Include(x => x.IdDocumentNavigation).Include(x => x.IdItemNavigation)
                        .Include(x => x.InverseIdDocumentLineAssociatedNavigation)
                        .Include(x => x.StockMovement)
                        .Where(x => idList.Contains(x.Id))
                        .Select(x => new ItemPriceViewModel
                        {
                            DocumentDate = x.IdDocumentNavigation.DocumentDate,
                            DocumentLineViewModel = _documentLineBuilder.BuildEntity(x),
                            DocumentType = x.IdDocumentNavigation.DocumentTypeCode,
                            IdCurrency = x.IdDocumentNavigation.IdUsedCurrency ?? 0,
                            IdTiers = x.IdDocumentNavigation.IdTiers ?? 0
                        }).ToList();

                    if (ItemPrices.Count > 0)
                    {
                        BeginTransaction();
                        var documentType = ItemPrices[0].DocumentType;
                        var documentStatus = ItemPrices[0].DocumentLineViewModel.IdDocumentLineStatus;
                        List<int> idsItems = ItemPrices.Where(x => x.DocumentLineViewModel.IdItemNavigation.ProvInventory).Select(p => p.DocumentLineViewModel.IdItem).Distinct().ToList();


                        if (documentType == DocumentEnumerator.BE && idsItems.Any())
                        {
                            IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                              x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                              && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                              && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSourceNavigation.IsCentral));
                            if (inventaireList.Any())
                            {
                                throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                            }
                        }
                        if ((documentType == DocumentEnumerator.BS || documentType == DocumentEnumerator.SalesDelivery ||
                            (documentType == DocumentEnumerator.SalesAsset && documentStatus == (int)DocumentStatusEnumerator.Valid)) && idsItems.Any())
                        {
                            List<int?> idsWarehouses = ItemPrices.Where(x => x.DocumentLineViewModel.IdItemNavigation.ProvInventory).Select(p => p.DocumentLineViewModel.IdWarehouse).Distinct().ToList();
                            IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                             x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                             && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                             && (x.IdStockDocumentNavigation.IdTiers != null || idsWarehouses.Contains(x.IdStockDocumentNavigation.IdWarehouseSource)));
                            if (inventaireList.Any())
                            {
                                throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                            }
                        }

                        foreach (var item in ItemPrices)
                        {
                            CheckRolesBeforeDeleting(item, item.DocumentType);
                            item.DocumentLineViewModel.IdDocumentNavigation = null;
                            if (item.DocumentType == DocumentEnumerator.BS)
                            {
                                if (item.DocumentLineViewModel.InverseIdDocumentLineAssociatedNavigation != null
                                    && item.DocumentLineViewModel.InverseIdDocumentLineAssociatedNavigation.Count > 0)
                                {
                                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                                        {
                                            { Constants.ITEM_DESCRIPTION_UPPER_CASE, item.DocumentLineViewModel.IdItemNavigation.Description }
                                        };
                                    throw new CustomException(CustomStatusCode.BSDeleteOrEditLineViolation, paramtrs);
                                }
                                InsertUpdateBSDocumentLineWithoutTransaction(item);
                            }
                            else
                            {
                                InsertUpdateDocumentLineWithoutTransaction(item, null);
                            }

                        }
                        var doc = UpdateDocumentAmountsWithoutTransaction(ItemPrices[0].DocumentLineViewModel.IdDocument, null);
                        EndTransaction();
                        return doc;
                    }
                    else
                    {
                        throw new CustomException(CustomStatusCode.LINE_ALREAD_DELETED);
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.EMPTY_LIST);
                }
            }
            catch (CustomException ex)
            {
                RollBackTransaction();
                throw;
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        public void CheckRolesBeforeDeleting(ItemPriceViewModel item, string documentTypeCode)
        {
            //documentLineViewModel.IsValidReservationFromProvisionalStock = entity.IsActive;
            item.DocumentLineViewModel.IsDeleted = true;
            var isSalesDocument = documentTypeCode == DocumentEnumerator.SalesInvoice || documentTypeCode == DocumentEnumerator.SalesQuotation
                || documentTypeCode == DocumentEnumerator.SalesDelivery || documentTypeCode == DocumentEnumerator.SalesAsset
                || documentTypeCode == DocumentEnumerator.SalesOrder || documentTypeCode == DocumentEnumerator.SalesInvoiceAsset;
            if (item.DocumentLineViewModel.IsValidReservationFromProvisionalStock && !RoleHelper.HasPermission(RoleHelper.Delete_DocLine))
            {
                item.DocumentLineViewModel.IsDeleted = false;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "Document", DocumentsLongName.GetValueOrDefault(item.DocumentType)},
                                { "DocumentLine", DocumentsLongName.GetValueOrDefault(item.DocumentLineViewModel.CodeDocumentLine)}
                            };
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_RESERVED_LINE, paramtrs);
                //throw new CustomException(CustomStatusCode.Unauthorized);
            }

            if (isSalesDocument && !RoleHelper.HasPermission(RoleHelper.Delete_DocLine) && !RoleHelper.HasPermission("COUNTER_SALES"))
            {
                item.DocumentLineViewModel.IsDeleted = false;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "Document", DocumentsLongName.GetValueOrDefault(item.DocumentType)},
                                { "DocumentLine", DocumentsLongName.GetValueOrDefault(item.DocumentLineViewModel.CodeDocumentLine)}
                            };
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE, paramtrs);
            }
            if (!isSalesDocument && (documentTypeCode == DocumentEnumerator.BS || documentTypeCode == DocumentEnumerator.BE) && !RoleHelper.HasPermission(RoleHelper.Delete_Multiple_DocLine_Stock_Correction))
            {
                item.DocumentLineViewModel.IsDeleted = false;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "Document", DocumentsLongName.GetValueOrDefault(item.DocumentType)},
                                { "DocumentLine", DocumentsLongName.GetValueOrDefault(item.DocumentLineViewModel.CodeDocumentLine)}
                            };
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE, paramtrs);
            }
            if (!isSalesDocument && documentTypeCode != DocumentEnumerator.BS && documentTypeCode != DocumentEnumerator.BE && !RoleHelper.HasPermission(RoleHelper.Delete_Multiple_DocLine_PU))
            {
                item.DocumentLineViewModel.IsDeleted = false;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "Document", DocumentsLongName.GetValueOrDefault(item.DocumentType)},
                                { "DocumentLine", DocumentsLongName.GetValueOrDefault(item.DocumentLineViewModel.CodeDocumentLine)}
                            };
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE, paramtrs);
            }


            if (documentTypeCode == DocumentEnumerator.SalesDelivery && item.DocumentLineViewModel.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Provisional && !RoleHelper.HasPermission(RoleHelper.Update_Valid_Delivery_SA))
            {
                item.DocumentLineViewModel.IsDeleted = false;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "Document", DocumentsLongName.GetValueOrDefault(item.DocumentType)},
                                { "DocumentLine", DocumentsLongName.GetValueOrDefault(item.DocumentLineViewModel.CodeDocumentLine)}
                            };
                throw new CustomException(CustomStatusCode.AlreadyValidatedDocument, paramtrs);
            }
        }

        public ItemHistoryViewModel GetMovementHistoryRelatedToItemB2B(ItemHistoryViewModel itemHistoryViewModel)
        {

            itemHistoryViewModel.Document = new List<DocumentMovementDetail>();

            // get sales delivery
            List<DocumentMovementDetail> linesDelivery = _entityDocumentLineRepo.QuerableGetAll().Include(x => x.IdDocumentNavigation)
                .ThenInclude(x => x.IdTiersNavigation).Where(x => x.IdItem == itemHistoryViewModel.IdItem
                && x.IdDocumentNavigation.IdTiers == itemHistoryViewModel.IdTiers
                && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                && !x.StockMovement.Select(z => z.Status).Contains(DocumentEnumerator.Reservation)
                && DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, itemHistoryViewModel.StartDate.Date) >= 0
                && DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, itemHistoryViewModel.EndDate.Date) <= 0)
                .Select(x => new DocumentMovementDetail
                {
                    Code = x.IdDocumentNavigation.Code,
                    Reference = x.IdDocumentNavigation.Reference,
                    IdDocument = x.IdDocument,
                    DocumentDate = x.IdDocumentNavigation.DocumentDate,
                    IdTiers = x.IdDocumentNavigation.IdTiers,
                    TiersCode = x.IdDocumentNavigation.IdTiersNavigation != null ? x.IdDocumentNavigation.IdTiersNavigation.CodeTiers : "",
                    TiersName = x.IdDocumentNavigation.IdTiersNavigation != null ? x.IdDocumentNavigation.IdTiersNavigation.Name : "",
                    DocumentTypeCode = x.IdDocumentNavigation.DocumentTypeCode,
                    Quantity = x.MovementQty,
                    Status = x.IdDocumentNavigation.IdDocumentStatus,
                    SalesAmount = (double)x.HtTotalLine
                }).ToList();

            itemHistoryViewModel.Document.AddRange(linesDelivery);
            itemHistoryViewModel.Document = itemHistoryViewModel.Document.OrderBy(x => x.DocumentDate).ToList();


            itemHistoryViewModel.EndSaleAmount = itemHistoryViewModel.Document.Sum(p => p.SalesAmount);
            return itemHistoryViewModel;
        }

        public DocumentViewModel SetDocumentDelivered(int idDoc, bool isDelivered, string userMail)
        {
            DocumentViewModel documentToUpdate = GetModelAsNoTracked(x => x.Id == idDoc);
            documentToUpdate.IsDeliverySuccess = isDelivered;
            UpdateModel(documentToUpdate, null, userMail);
            return documentToUpdate;
        }



        public List<BalanceDocumentLine> CancelBalancedDocLine(int idDocLine,
            string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false)
        {
            try
            {
                BeginTransaction();
                List<BalanceDocumentLine> listBalance = new List<BalanceDocumentLine>();
                DocumentLineViewModel docLine = _serviceDocumentLine.GetModelAsNoTracked(x => x.Id == idDocLine, x => x.IdDocumentNavigation);
                docLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Refused;
                _serviceDocumentLine.UpdateModelWithoutTransaction(docLine, null, null);
                listBalance = _serviceItem.GetBalancedList((int)docLine.IdDocumentNavigation.IdTiers, null,
                    importerDocumentType, importedDocumentType, isFromB2B);
                EndTransaction();
                return listBalance;
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        private void SetDocumentStatusWhenAllLinesAreBalanced(int idDoc)
        {
            var docLineNumber = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == idDoc && x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Refused).Count();
            if (docLineNumber == 0)
            {
                _entityRepo.QuerableGetAll().Where(x => x.Id == idDoc).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
                _unitOfWork.Commit();
            }
        }
        public List<BalanceDocumentLine> SaveBalancedDocLine(BalanceDocumentLine line)
        {
            List<BalanceDocumentLine> listBalance = new List<BalanceDocumentLine>();
            DocumentLineViewModel docLine = _serviceDocumentLine.GetModelAsNoTracked(x => x.Id == line.IdLine, x => x.IdDocumentNavigation);
            docLine.DateAvailability = line.DateDispo;
            _serviceDocumentLine.UpdateModel(docLine, null, null);
            listBalance = _serviceItem.GetBalancedList((int)docLine.IdDocumentNavigation.IdTiers);
            return listBalance;
        }

        public List<CostPriceViewModel> GeneratePriceCostLinesFromDocumentLine(IList<DocumentLine> DocumentLineList)
        {
            List<CostPriceViewModel> cotPriceList = new List<CostPriceViewModel>();
            _serviceItemWarehouse.GetAllAvailbleQuantityFolAllItem(DocumentLineList.Select(f => f.IdItemNavigation).ToList());
            List<int> idDocLines = DocumentLineList.Select(x => x.Id).ToList();
            List<DocumentLineTaxeViewModel> docLineTaxes = _serviceDocumentLineTaxe.GetModelsWithConditionsRelations(z => idDocLines.Contains(z.IdDocumentLine), z => z.IdTaxeNavigation).ToList();
            foreach (var item in DocumentLineList)
            {
                var costPriceLine = PrepareCostpriceObject(item);
                costPriceLine.DocumentLineTaxe = docLineTaxes.Where(r => r.IdDocumentLine == item.Id).ToList();
                costPriceLine.StockQty = item.IdItemNavigation.AllAvailableQuantity;
                cotPriceList.Add(costPriceLine);
            }

            return cotPriceList;
        }

        public bool IsDocumentLineNegotiatedFromDocumentId(int id)
        {
            return _entityRepoDocumentLineNegotiationOptions.GetAllAsNoTracking().
                    Any(x => x.IdDocumentLineNavigation.IdDocument == id);
        }

        public List<BalanceDocumentLine> GetBalancedList(int idTiers, string importerDocumentType = null,
            string importedDocumentType = null, bool isFromB2B = false)
        {
            return _serviceDocumentLine.GetBalancedList(idTiers, null, importerDocumentType,
                importedDocumentType, isFromB2B);
        }
        public List<BalanceDocumentLine> GetBalancedListWithPredicate(int idTiers, PredicateFormatViewModel predicate, string importerDocumentType = null,
            string importedDocumentType = null, bool isFromB2B = false)
        {
            return _serviceDocumentLine.GetBalancedListWithPredicate(idTiers, predicate, null, importerDocumentType,
                importedDocumentType, isFromB2B);
        }
        public bool IsAnyLineWithoutPrice(int idDoc)
        {
            List<DocumentLineViewModel> docLines = _serviceDocumentLine.GetAllModelsQueryableWithRelation(x => x.IdDocument == idDoc && x.TtcTotalLineWithCurrency == 0 && x.HtTotalLineWithCurrency == 0, y => y.StockMovement).ToList();
            if (docLines.Any(x => x.IsValidReservationFromProvisionalStock == false))
            {
                return true;
            }
            else
            {
                return false;
            }

        }


        public bool IsDocumentContainsLines(int idDoc)
        {
            return _entityDocumentLineRepo.QuerableGetAll().Any(x => x.IdDocument == idDoc);
        }
        public DataSourceResult<ReducedDocumentList> GetListDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Document> entities = null;
            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "NameTiers")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "IdTiersNavigation.Name";
                }
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "CreatorName")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "IdCreatorNavigation.FullName";
                }
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "DocumentStatus")
                {
                    predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop = "IdDocumentStatus";
                }
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
                entities = GetEntitiesDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
                var total = entities.Count();
                if (predicateModelWithSpecificFilters.page > 0 && predicateModelWithSpecificFilters.pageSize > 0)
                {
                    entities = entities.Skip((predicateModelWithSpecificFilters.page - 1) * predicateModelWithSpecificFilters.pageSize).Take(predicateModelWithSpecificFilters.pageSize);
                }
                List<int> idsDoc = entities.Select(x => x.Id).ToList();
                List<StockMovement> listStockMovement = _entityStockMovementRepo.GetAllWithConditionsRelations(
                    c => c.Operation == OperationEnumerator.Output && c.Status == DocumentEnumerator.Reservation
                     && idsDoc.Contains(c.IdDocumentLineNavigation.IdDocument), x => x.IdDocumentLineNavigation).ToList();
                List<MasterUserViewModel> users = new List<MasterUserViewModel>();
                if (entities != null && entities.Any(x => x.IdCreatorNavigation != null) && entities.FirstOrDefault().DocumentTypeCode == DocumentEnumerator.PurchaseRequest)
                {
                    List<string> emails = entities.Select(x => x.IdCreatorNavigation.Email).ToList();
                    users = _serviceMasterUser.GetAllModelsWithRelations().Where(x => emails.Contains(x.Email)).ToList();
                }
                List<UsersBtob> usersBtob = new List<UsersBtob>();
                if (entities != null && entities.Any(x => x.IdCreatorBtob != null))
                {
                    List<int> idCreatorsBtob = entities.Where(y => y.IdCreatorBtob != null).Select(x => x.IdCreatorBtob.Value).ToList();
                    usersBtob = _repoUsersBtob.GetAllAsNoTracking().Where(x => idCreatorsBtob.Contains(x.Id)).ToList();
                }
                List<ReducedDocumentList> model = entities.ToList().Select(x => _builderdocument.BuildEntityToReducedList(x, listStockMovement, users, usersBtob)).ToList();
                return new DataSourceResult<ReducedDocumentList> { data = model, total = total };
            }
            return null;
        }
        public DataSourceResult<DocumentViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            DataSourceResult<DocumentViewModel> resultTiers = base.GetDataWithSpecificFilter(predicateModel);
            if (resultTiers.data != null && resultTiers.data.Any() && resultTiers.data[0].DocumentTypeCode != DocumentEnumerator.PurchaseRequest)
            {
                foreach (var document in resultTiers.data)
                {
                    if (document.IdTiersNavigation.UrlPicture != null)
                    {
                        document.IdTiersNavigation.PictureFileInfo = GetFiles(document.IdTiersNavigation.UrlPicture).FirstOrDefault();
                    }
                }
            }
            return resultTiers;
        }

        public dynamic GetDocumentsAssociatedForPriceRequest(int documentId)
        {
            var list = GetModelsWithConditionsRelations(x => x.IdPriceRequest == documentId && x.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder, r => r.IdTiersNavigation, r => r.IdUsedCurrencyNavigation);
            return list;
        }

        public CreatedDataViewModel GeneratePosInvoiceFromBl(int idDocument, Document invoice, int idTicket, bool isFromTickets, List<int> idsDelivery, List<int> idsTickets, string userMail)
        {
            try
            {
                VerifExistingInvoiceProvisional(DateTime.Now, null, true);
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);
                CurrencyViewModel companyCurrency = company.IdCurrencyNavigation;
                SettlementMode settlementMode = _entitySettlementModeRepo.GetSingle(p => p.Code == "Comptant");
                if (settlementMode == null)
                {
                    settlementMode = _entitySettlementModeRepo.GetFirst();
                }
                invoice.IdSettlementMode = settlementMode.Id;
                invoice.DocumentOtherTaxesWithCurrency = company.FiscalStamp;
                invoice.IdValidator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
                invoice.IdCreator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
                List<int> documentLinesId = new List<int>();
                if (isFromTickets)
                {
                    List<Document> salesDeliveryList = _entityRepo.GetAllWithConditionsQueryable(x => idsDelivery.Contains(x.Id))
                        .Include(x => x.DocumentLine)
                        .ThenInclude(x => x.DocumentLineTaxe).ThenInclude(x => x.IdDocumentLineNavigation).ToList();
                    List<DocumentLine> documentLines = new List<DocumentLine>();
                    salesDeliveryList.ForEach(sd =>
                    {
                        documentLines.AddRange(sd.DocumentLine);
                        invoice.Reference = sd.Reference;
                        invoice.Name = sd.Name;
                        invoice.MatriculeFiscale = sd.MatriculeFiscale;
                        invoice.Tel1 = sd.Tel1;
                    });
                    documentLinesId = documentLines.Select(x => x.Id).ToList();
                    invoice.DocumentLine = documentLines;
                }
                else
                {
                    var posbl = _entityRepo.GetAllAsNoTracking().First(x => x.Id == idDocument);
                    invoice.Reference = posbl.Reference;
                    invoice.Name = posbl.Name;
                    invoice.MatriculeFiscale = posbl.MatriculeFiscale;
                    invoice.Tel1 = posbl.Tel1;
                    // set document Lines to invoice
                    List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllWithConditionsQueryable(x => x.IdDocument == idDocument)
                                .Include(x => x.DocumentLineTaxe).ThenInclude(x => x.IdDocumentLineNavigation).ToList();
                    documentLinesId = documentLines.Select(x => x.Id).ToList();
                    invoice.DocumentLine = documentLines;
                }

                List<DocumentTaxsResume> updatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
                DocumentViewModel documentViewModel = _builder.BuildEntity(invoice);
                CalculDocument(documentViewModel, updatedDocumentTaxsResumes, documentLinesId, invoice);
                SetDocumentValueCurrency(documentViewModel, companyCurrency.Precision);
                SetRemainingAmount(documentViewModel);
                this.ConvertAmountToLetter(documentViewModel);
                documentViewModel.DocumentLine.ToList().ForEach(p =>
                    {
                        p.IdDocumentLineAssociated = p.Id;
                        p.Id = 0;
                        p.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid;
                        p.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                    });
                documentViewModel.DocumentTaxsResume = updatedDocumentTaxsResumes.Select(x => _documentTaxsResumeBuilder.BuildEntity(x)).ToList();
                dynamic createdInvoice = (CreatedDataViewModel)AddModelWithoutTransaction(documentViewModel, null, userMail, "DocumentTypeCode");
                // generate and validate financial commitment
                DocumentType documentType = _entityDocumentTypeRepo
                        .GetSingleWithRelationsNotTracked(c => c.CodeType == documentViewModel.DocumentTypeCode, p => p.DefaultCodeDocumentTypeAssociatedNavigation);
                documentViewModel.Id = createdInvoice.Id;
                SetDocumentFinancialCommitment(documentViewModel, documentType);


                if (isFromTickets)
                {
                    //set BL and BL lines  Status to balanced 
                    _entityRepo.FindByAsNoTracking(p => idsDelivery.Contains(p.Id)).AsQueryable().UpdateFromQuery(p => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
                    _entityDocumentLineRepo.FindByAsNoTracking(p => idsDelivery.Contains(p.Id)).AsQueryable().UpdateFromQuery(p => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced });
                    var tickets = _ticketRepo.FindByAsNoTracking(x => idsTickets.Contains(x.Id)).ToList();
                    tickets.ForEach(x => x.IdInvoice = createdInvoice.Id);
                    _ticketRepo.BulkUpdate(tickets);
                }
                else
                {
                    //set BL and BL lines  Status to balanced 
                    _entityRepo.FindByAsNoTracking(p => p.Id == idDocument).AsQueryable().UpdateFromQuery(p => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
                    _entityDocumentLineRepo.FindByAsNoTracking(p => p.Id == idDocument).AsQueryable().UpdateFromQuery(p => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced });
                    var ticket = _ticketRepo.FindByAsNoTracking(x => x.Id == idTicket).FirstOrDefault();
                    ticket.IdInvoice = createdInvoice.Id;
                    _ticketRepo.Update(ticket);
                }
                _unitOfWork.Commit();

                return createdInvoice;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }


        }

        public object DeleteDocuments(List<int> ids, string userMail)
        {
            object data = null;
            ids.ForEach(id =>
            {
                data = DeleteModel(id, "Document", userMail);
            });
            return data;
        }
        public bool IsAnyRelationSupplierWithItem(int idTier, int idItem)
        {
            return _itemEntityRepo.QuerableGetAll().Any(x => x.Id == idItem && x.ItemTiers.Select(x => x.IdTiers).Contains(idTier));
        }
        public DateTime? GenerateDate(string date)
        {
            return (!date.Equals("-1")) ? new DateTime(int.Parse(date.Split(",")[0]), int.Parse(date.Split(",")[1]), int.Parse(date.Split(",")[2])) : (DateTime?)null;
        }
        /// <summary>
        /// get note on turnover list
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        public NoteOnTurnoverTotalLinesReportViewModel GetNoteOnTurnoverList(string StartDate, string EndDate, int idItem, bool isFromReport = false)
        {
            NoteOnTurnoverTotalLinesReportViewModel noteOnTurnoverTotalLinesReport = new NoteOnTurnoverTotalLinesReportViewModel();
            noteOnTurnoverTotalLinesReport.NoteOnTurnoverLines = new List<NoteOnTurnoverLineReportViewModel>();
            noteOnTurnoverTotalLinesReport.totalAmountHT = 0;
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            DateTime? sdate = GenerateDate(StartDate);
            DateTime? edate = GenerateDate(EndDate);

            var documentLines = _entityDocumentLineRepo.QuerableGetAll()
                             .Include(x => x.IdItemNavigation)
                             .Where(x => DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero &&
                         DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero &&
                         x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                         x.IdDocumentNavigation.IsRestaurn == false && x.IdDocumentNavigation.InoicingType != (int)InvoicingTypeEnumerator.advancePayment &&
                         x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional &&
                         x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft).Include(x => x.IdDocumentNavigation).AsQueryable();
            if (idItem != 0)
            {
                documentLines = documentLines.Where(x => x.IdItem == idItem);
            }
            List<NoteOnTurnoverLineReportViewModel> models = new List<NoteOnTurnoverLineReportViewModel>();
            models = documentLines.ToList().Select(doc =>
               new NoteOnTurnoverLineReportViewModel
               {
                   Cost = doc.CostPrice != null ? CurrencyUtility.GenerateCurrencyByCulture(doc.CostPrice.Value, company.IdCurrencyNavigation.Precision, "", company.Culture) : "0",
                   CodeItem = doc.IdItemNavigation != null ? doc.IdItemNavigation.Code : string.Empty,
                   Quantity = doc != null ? doc.MovementQty.ToString() : string.Empty,
                   SalePriceAfterDelivery = doc.HtAmount != 0 ? CurrencyUtility.GenerateCurrencyByCulture(doc.HtAmount, company.IdCurrencyNavigation.Precision, "", company.Culture) : string.Empty,
                   Margin = (doc.CostPrice != null && doc.CostPrice.Value != 0) ? Math.Round((double)(((doc.HtAmount - doc.CostPrice.Value) / doc.CostPrice.Value) * 100), 3) + GenericConstants.Pers : "0%",
                   Designation = doc != null ? doc.Designation : string.Empty,
                   CurrencyCode = company.IdCurrencyNavigation.Symbole,
                   CodeInvoiceSales = doc.IdDocumentNavigation != null ? doc.IdDocumentNavigation.Code : string.Empty,
                   GainInAmountHT = doc != null ? Math.Round(doc.MovementQty * (doc.HtAmount - (doc.CostPrice != null ? doc.CostPrice.Value : 0)), company.IdCurrencyNavigation.Precision) : 0,
                   TotalPurchase = (doc != null && doc.MovementQty != null ? doc.MovementQty : 0) * (doc.CostPrice != null ? Math.Round(doc.CostPrice.Value, company.IdCurrencyNavigation.Precision) : 0),
                   TotalSales = (doc.HtAmount != 0 ? Math.Round(doc.HtAmount, company.IdCurrencyNavigation.Precision) : 0)
               }).ToList();
            noteOnTurnoverTotalLinesReport.NoteOnTurnoverLines.AddRange(models);
            noteOnTurnoverTotalLinesReport.NoteOnTurnoverLines.ForEach(noteOnTurnoverLine =>
            {
                noteOnTurnoverTotalLinesReport.totalAmountHT = noteOnTurnoverTotalLinesReport.totalAmountHT + noteOnTurnoverLine.GainInAmountHT;
            });
            if (isFromReport == true)
            {
                NoteOnTurnoverLineReportViewModel total = new NoteOnTurnoverLineReportViewModel()
                {
                    SalePriceAfterDelivery = Math.Round((double)models.Sum(x => x.TotalSales), company.IdCurrencyNavigation.Precision).ToString(),
                    GainInAmountHT = Math.Round((double)models.Sum(x => x.GainInAmountHT != null ? x.GainInAmountHT : 0), company.IdCurrencyNavigation.Precision),
                    Cost = Math.Round((double)models.Sum(x => x.Cost != null ? Convert.ToDouble(x.Cost) : 0), company.IdCurrencyNavigation.Precision).ToString(),
                    CodeItem = "Total",
                    Quantity = string.Empty,
                    Designation = string.Empty,
                    Margin = string.Empty
                };
                noteOnTurnoverTotalLinesReport.NoteOnTurnoverLines.Add(total);
            }
            return noteOnTurnoverTotalLinesReport;
        }
        /// <summary>
        /// get note on turnover data source
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        public NoteOnTurnoverTotalLinesReportViewModel GetNoteOnTurnoverDataSource(string StartDate, string EndDate, int idItem)
        {
            return GetNoteOnTurnoverList(StartDate, EndDate, idItem);
        }

        public DocumentViewModel GetNewDocumentForBillingSession(DocumentViewModel document, string userMail)
        {
            CreatedDataViewModel createdDataViewModel = (CreatedDataViewModel)AddDocument(null, document, userMail, null);
            return GetModelAsNoTracked(x => x.Id == createdDataViewModel.Id, x => x.IdTiersNavigation);
        }

        public List<DocumentViewModel> GetDocumentsByBillingEmployees(List<BillingEmployeeViewModel> billingEmployeeViewModels)
        {
            List<int> projectsIds = billingEmployeeViewModels.Select(x => x.IdProject).ToList();
            List<int> timesheetsIds = billingEmployeeViewModels.Select(x => x.IdTimeSheet).ToList();
            return FindModelsByNoTracked(x => x.IdProject.HasValue && x.IdTimeSheet.HasValue && x.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoice)
                && projectsIds.Contains(x.IdProject.Value) && timesheetsIds.Contains(x.IdTimeSheet.Value), x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation).ToList();
        }

        public DataSourceResult<string> GenerateDeliveryForms(ListOrdersViewModel listOrdersViewModel)
        {
            DataSourceResult<string> dataSourceResult = new DataSourceResult<string>();
            dataSourceResult.data = new List<string>();
            foreach (OrderMagentoViewModel orderViewModel in listOrdersViewModel.items)
            {
                int IdInvoiceEcommerce = orderViewModel.entity_id > 0 ? orderViewModel.entity_id : 1;
                try
                {
                    DocumentViewModel document = new DocumentViewModel();
                    //List<DocumentViewModel> documents = GetModelsWithConditionsRelations(x => x.IdInvoiceEcommerce == IdInvoiceEcommerce).ToList();


                    //if (documents.Count == 0)
                    //{
                    BeginTransaction();
                    int idClient = InsertOrUpdateAndGetCustomerOfDelivery(orderViewModel);
                    document = CreateNewDocumentFromEcommerce(orderViewModel.items, IdInvoiceEcommerce, idClient);
                    DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == DocumentEnumerator.SalesDelivery);
                    CreatedDataViewModel result = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, document, documentType, null, null);
                    EndTransaction();

                    BeginTransaction();
                    DocumentViewModel validatedDocument = ValidateDocumentWithoutTransaction(result.Id, null, (int)DocumentStatusEnumerator.Valid, false);
                    EndTransaction();

                    dataSourceResult.data.Add(validatedDocument != null ? validatedDocument.Code : string.Empty);

                    //}


                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }

            dataSourceResult.total = dataSourceResult.data.Count;
            return dataSourceResult;



























            //BeginTransaction();
            //List<ProductMagentoViewModel> Products = new List<ProductMagentoViewModel>();
            //ProductMagentoViewModel p = new ProductMagentoViewModel()
            //{
            //    sku="test",
            //    qty_ordered=10,
            //    price=100
            //};
            //Products.Add(p);
            //var document1 = CreateNewDocumentFromEcommerce(Products, 1, 1555);
            //DocumentType documentType1 = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == DocumentEnumerator.SalesDelivery);
            //CreatedDataViewModel result = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, document1, documentType1, null, null);
            //EndTransaction();

            //BeginTransaction();
            //DocumentViewModel validatedDocument = ValidateDocumentWithoutTransaction(result.Id, null, (int)DocumentStatusEnumerator.Valid, false);
            //EndTransaction();

        }




        private int InsertOrUpdateAndGetCustomerOfDelivery(OrderMagentoViewModel orderViewModel)
        {
            int idClient = 0;
            CreatedDataViewModel obj = null;
            TiersViewModel instanceType = new TiersViewModel()
            {
                Name = orderViewModel.customer_firstname + " " + orderViewModel.customer_lastname,
                IdCurrency = 2,
                IdTaxeGroupTiers = 2,
                IdTypeTiers = 1,
                IdEcommerceCustomer = orderViewModel.customer_id,
                Email = orderViewModel.billing_address.email,
                Contact = new List<ContactViewModel>(),
                AuthorizedAmountInvoice = 1000000
            };

            ContactViewModel contact = new ContactViewModel()
            {
                FirstName = orderViewModel.customer_firstname,
                LastName = orderViewModel.customer_lastname,
                Tel1 = "216" + orderViewModel.billing_address.telephone,
                Email = orderViewModel.billing_address.email,
                Adress = orderViewModel.billing_address.address_type,
                IsDeleted = false
            };
            instanceType.Contact.Add(contact);

            var idAutoshop = instanceType.IdEcommerceCustomer;
            TiersViewModel tiersViewModel = _serviceTiers.GetModelWithRelationsAsNoTracked(x => x.IdEcommerceCustomer == idAutoshop);

            if (tiersViewModel == null)
            {
                obj = (CreatedDataViewModel)_serviceTiers.AddModelWithoutTransaction(instanceType, null, null, null);
                idClient = obj.Id;
            }
            else
            {
                idClient = tiersViewModel.Id;

            }
            return idClient;
        }



        private DocumentViewModel CreateNewDocumentFromEcommerce(List<ProductMagentoViewModel> Products, int IdInvoiceAutoshop, int idClient)
        {
            DocumentViewModel document = new DocumentViewModel()
            {
                IdDocumentStatus = 1,
                DocumentTypeCode = DocumentEnumerator.SalesDelivery,
                IdTiers = idClient,
                IdUsedCurrency = 2,
                IdInvoiceEcommerce = IdInvoiceAutoshop > 0 ? IdInvoiceAutoshop : null,
                IsTermBilling = true,
                DocumentDate = DateTime.UtcNow,
                DocumentLine = new List<DocumentLineViewModel>()
            };

            DocumentLineViewModel documentLineViewModel;
            WarehouseViewModel warehouseViewModel = _serviceWarehouse.GetModelWithRelationsAsNoTracked(x => x.IsCentral == true);

            foreach (ProductMagentoViewModel productViewModel in Products)
            {
                ItemViewModel itemViewModel = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == productViewModel.item_id, x => x.IdUnitSalesNavigation);
                if (itemViewModel != null)
                {
                    documentLineViewModel = new DocumentLineViewModel()
                    {
                        IdItem = itemViewModel.Id,
                        Designation = itemViewModel.Description.Replace("'", "\'"),
                        MovementQty = productViewModel.qty_ordered,
                        IsChecked = false,
                        IdMeasureUnit = itemViewModel.IdUnitSales,
                        MesureUnitLabel = itemViewModel.IdUnitSalesNavigation.Label,
                        IdWarehouse = warehouseViewModel.Id,
                        HtUnitAmount = productViewModel.price,
                        HtAmount = productViewModel.price,
                        HtUnitAmountWithCurrency = productViewModel.price,
                        HtAmountWithCurrency = productViewModel.price,
                        IsActive = false,
                        DiscountPercentage = 0
                    };

                    document.DocumentLine.Add(documentLineViewModel);
                }
            }

            return document;

        }



        public DataSourceResult<string> CreateDeliveryForms(ListOrdersViewModel listOrdersViewModel)
        {
            DataSourceResult<string> dataSourceResult = new DataSourceResult<string>();
            dataSourceResult.data = new List<string>();
            foreach (OrderMagentoViewModel orderViewModel in listOrdersViewModel.items)
            {
                try
                {
                    DocumentViewModel document = new DocumentViewModel();
                    BeginTransaction();
                    TiersViewModel tiersViewModel = _serviceTiers.GetModelWithRelationsAsNoTracked(x => x.Id == orderViewModel.customer_id);
                    if (tiersViewModel != null)
                    {
                        document = CreateNewDocumentFromEcommerce(orderViewModel.items, 0, orderViewModel.customer_id);
                        DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == DocumentEnumerator.SalesDelivery);
                        CreatedDataViewModel result = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, document, documentType, null, null);
                        EndTransaction();

                        BeginTransaction();
                        DocumentViewModel validatedDocument = ValidateDocumentWithoutTransaction(result.Id, null, (int)DocumentStatusEnumerator.Valid, false);
                        EndTransaction();

                        dataSourceResult.data.Add(validatedDocument != null ? validatedDocument.Code : string.Empty);

                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }

            dataSourceResult.total = dataSourceResult.data.Count;
            return dataSourceResult;


        }

        public DocumentViewModel GenerateDepositSalesInvoice(int idDoc, double amount, int idItem, string userMail)
        {
            try
            {
                DataSourceResult<string> dataSourceResult = new DataSourceResult<string>();
                dataSourceResult.data = new List<string>();
                DocumentViewModel orderDoc = GetModelWithRelationsAsNoTracked(x => x.Id == idDoc);
                IQueryable<int> idsLignesDoc = _entityDocumentLineRepo.GetAllWithConditionsQueryable(x => x.IdDocument == orderDoc.Id).Select(y => y.Id);
                int generatedDocuments = _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdDocumentLineAssociated != null && idsLignesDoc.Contains(x.IdDocumentLineAssociated.Value)).Count();
                if (generatedDocuments != null && generatedDocuments > 0)
                {
                    throw new CustomException(CustomStatusCode.OrderContainsSalesDelivery);
                }
                SettlementMode settlementMode = _entitySettlementModeRepo.FindSingleBy(x => x.Code == "Paiement_Avance");

                DocumentViewModel newDocument = new DocumentViewModel()
                {
                    IdDocumentStatus = 1,
                    DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                    InoicingType = (int)InvoicingTypeEnumerator.advancePayment,
                    IdTiers = orderDoc.IdTiers,
                    IdUsedCurrency = orderDoc.IdUsedCurrency,
                    DocumentDate = DateTime.UtcNow,
                    Code = "",
                    IdSettlementMode = settlementMode != null ? settlementMode.Id : 1,
                    Id = 0,
                    IdSalesOrder = orderDoc.Id,
                    DocumentLine = new List<DocumentLineViewModel>()
                };
                SetDocumentDate(newDocument);
                newDocument.IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == userMail).Id;
                CreatedDataViewModel addDocuemnt;
                string property = "DocumentTypeCode";
                var isValid = newDocument?.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid;
                if (isValid)
                {
                    GenerateValidationCodification(newDocument, true);
                }
                Document entity = _builder.BuildModel(newDocument);
                GenerateCodification(entity, property, false, false, true);
                entity.ProvisionalCode = entity.Code;
                if (isValid)
                {
                    entity.Code = newDocument.Code;
                }
                _entityRepo.Add(entity);
                _unitOfWork.Commit();
                if (GetPropertyName(entity) != null)
                {
                    addDocuemnt = new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), DocumentTtcpriceWithCurrency = entity.DocumentTtcpriceWithCurrency, Reference = entity.Reference, EntityName = entity.GetType().Name.ToUpper() };
                }
                else
                {
                    addDocuemnt = new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
                }
                ItemViewModel advanceItem = _serviceItem.GetModelAsNoTracked(x => x.Id == idItem);
                DocumentLineViewModel docLine = new DocumentLineViewModel()
                {
                    IdItem = advanceItem.Id,
                    CodeDocumentLine = "",
                    CostPrice = 0,
                    DiscountPercentage = 0,
                    HtAmountWithCurrency = amount,
                    HtUnitAmount = amount,
                    HtUnitAmountWithCurrency = amount,
                    Id = 0,
                    IdDocument = addDocuemnt.Id,
                    IdDocumentLineStatus = 1,
                    Designation = "Avance_" + orderDoc.Code,
                    MovementQty = 1,
                };
                ItemPriceViewModel itemPrice = new ItemPriceViewModel()
                {
                    DocumentDate = DateTime.UtcNow,
                    DocumentType = DocumentEnumerator.SalesInvoice,
                    IdCurrency = (int)orderDoc.IdUsedCurrency,
                    IdTiers = (int)orderDoc.IdTiers,
                    RecalculateDiscount = false,
                    DocumentLineViewModel = docLine
                };
                DocumentViewModel generatedDoc = InsertUpdateDocumentLine(itemPrice, userMail);
                orderDoc.IdSalesDepositInvoice = generatedDoc.Id;
                var ctx = _unitOfWork.GetContext();
                var attachedDL = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == orderDoc.Id);
                if (attachedDL != null)
                {
                    ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                }
                orderDoc.IdCreatorNavigation = null;
                orderDoc.IdValidatorNavigation = null;
                UpdateModelWithoutTransaction(orderDoc);
                return generatedDoc;
            }
            catch (CustomException)
            {
                RollBackTransaction();
                throw;
            }
        }

        public bool IsValidDepositInvoiceStatus(int idDepositInvoice, int idOrder)
        {
            bool haveInvoiceGenerated = GetModelsWithConditionsRelations(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.IdSalesOrder == idOrder && x.InoicingType == (int)InvoicingTypeEnumerator.Cash).Count() == 0;
            bool isValidDepositInvoice = GetModelAsNoTracked(x => x.Id == idDepositInvoice).IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied;
            return (haveInvoiceGenerated && isValidDepositInvoice);
        }

        public DocumentViewModel GenerateInvoiceFromOrder(int idDoc, string userMail)
        {
            try
            {
                Document order = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idDoc).Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLineTaxe).FirstOrDefault();
                double advancedAmount = (double)_entityRepo.FindByAsNoTracking(x => x.Id == order.IdSalesDepositInvoice).FirstOrDefault().DocumentTtcpriceWithCurrency;
                if (order.DocumentTtcpriceWithCurrency < advancedAmount)
                {
                    throw new CustomException(CustomStatusCode.OrderAmountLessThanAdvance);
                }
                var idsItems = order.DocumentLine.Select(x => x.IdItem).ToList();
                List<ItemWarehouseViewModel> itemWarehouse = _serviceItemWarehouse.GetAllModelsQueryableWithRelation(x => idsItems.Contains(x.IdItem) && x.IdWarehouse == order.DocumentLine.First().IdWarehouse).ToList();
                if (itemWarehouse != null && itemWarehouse.Any())
                {
                    order.DocumentLine.ToList().ForEach(line =>
                    {
                        ItemWarehouseViewModel itemW = itemWarehouse.Where(x => x.IdItem == line.IdItem).FirstOrDefault();
                        if (itemW != null && line.MovementQty > (itemW.AvailableQuantity - itemW.ReservedQuantity))
                        {
                            throw new CustomException(CustomStatusCode.InsufficientQuantity);
                        }
                    });
                }
                List<Document> invoiceToAdd = new List<Document>();
                CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
                DocumentType documentType = _entityDocumentTypeRepo.GetSingle(p => p.Code == DocumentEnumerator.SalesInvoice);
                User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);

                Document generatedInvoice = new Document
                {
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                    IdTiers = order.IdTiers,
                    DocumentDate = DateTime.UtcNow,
                    IdUsedCurrency = order.IdUsedCurrency,
                    DocumentLine = new List<DocumentLine>(),
                    DocumentOtherTaxesWithCurrency = documentType.Code == DocumentEnumerator.SalesInvoice ? _serviceCompany.GetCurrentCompany().SaleSettings.SaleOtherTaxes : 0,
                    IdCreator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId,
                    IdSettlementMode = 1,
                    InoicingType = (int)InvoicingTypeEnumerator.Cash,
                    IdSalesOrder = order.Id,
                    IdSalesDepositInvoice = order.IdSalesDepositInvoice,
                };


                List<DocumentLine> lines = new List<DocumentLine>();
                lines.AddRange(order.DocumentLine);
                List<int> documentLinesId = lines.Select(x => x.Id).ToList();

                lines.ForEach(p =>
                {
                    p.IdDocumentAssociated = null;
                    p.IdDocumentLineAssociated = null;
                    p.InverseIdDocumentLineAssociatedNavigation = null;
                    p.Id = 0;
                    p.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                    p.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                });
                generatedInvoice.DocumentLine = lines;

                DocumentViewModel documentViewModel = _builder.BuildEntity(generatedInvoice);
                List<DocumentTaxsResume> UpdatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
                CalculDocument(documentViewModel, UpdatedDocumentTaxsResumes, documentLinesId, generatedInvoice);
                SetDocumentValueCurrency(documentViewModel, companyCurrency.Precision);
                SetRemainingAmount(documentViewModel);
                ConvertAmountToLetter(documentViewModel);
                Document document = _builder.BuildModel(documentViewModel);
                document.IdCreator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
                document.DocumentTaxsResume = UpdatedDocumentTaxsResumes;

                if (document != null)
                {
                    var codificationCounter = GetCodificationCounter(document, nameof(document.DocumentTypeCode), document.DocumentTypeCode, false);
                    invoiceToAdd.Add(document);
                    SetCodification(invoiceToAdd, codificationCounter);
                }

                _entityRepo.BulkAdd(invoiceToAdd);
                _unitOfWork.Commit();
                return GetModelAsNoTracked(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment
                && x.IdSalesOrder == order.Id);
            }
            catch (CustomException)
            {
                RollBackTransaction();
                throw;
            }
        }
        public CancelOrderViewModel CheckOrderToCancel(int idDocument, string userMail)
        {
            CancelOrderViewModel result = new CancelOrderViewModel();
            Document order = (Document)_entityRepo.GetSingleNotTracked(x => x.Id == idDocument);
            if (order != null && order.IdSalesDepositInvoice != null)
            {
                List<Document> docs = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == order.IdSalesDepositInvoice || (x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment &&
                x.IdSalesDepositInvoice == order.IdSalesDepositInvoice)).ToList();
                if (docs.Count() == 1)
                {
                    result.CodeDepositInvoice = docs.First().Code;
                    result.IdDepositInvoiceStatus = docs.First().IdDocumentStatus;
                }
                else
                {
                    Document invoice = docs.Where(x => x.Id != order.IdSalesDepositInvoice).First();
                    Document depositInvoice = docs.Where(x => x.Id == order.IdSalesDepositInvoice).First();
                    result.CodeDepositInvoice = depositInvoice.Code;
                    result.IdDepositInvoiceStatus = depositInvoice.IdDocumentStatus;
                    result.CodeInvoice = invoice.Code;
                    result.IdInvoiceStatus = invoice.IdDocumentStatus;
                }
            }
            return result;
        }
        public override Document VerifIfEntityAlreadyExist(Document entity, string propertyName, List<object> codification)
        {
            return _entityRepo.GetAllWithConditions(x => x.Code == codification[2].ToString()).FirstOrDefault();
        }
        /// <summary>
        /// Get BR document for bar code
        /// </summary>
        /// <param name="BarCode"></param>
        /// <returns></returns>
        public DocumentViewModel SearchPurchaseDeliveryByBarCode(Image BarCode)
        {
            BarcodeReader barCodeReader = new BarcodeReader();
            var result = barCodeReader.Decode((Bitmap)BarCode);
            DocumentViewModel document = new DocumentViewModel();
            if (result != null)
            {
                document = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(r => r.Code.Equals(result))
                 .Include(r => r.IdTiersNavigation)
                 .ThenInclude(r => r.IdCurrencyNavigation)
                 .Include(r => r.IdUsedCurrencyNavigation)
                 .Include(r => r.DocumentLine).ThenInclude(r => r.IdMeasureUnitNavigation)
                 .Include(r => r.DocumentWithholdingTax)
                 .ThenInclude(r => r.IdWithholdingTaxNavigation)
                 .Include(r => r.DocumentTaxsResume)
                 .ThenInclude(r => r.IdTaxNavigation)
                 .Include(r => r.FinancialCommitment)
                 .ThenInclude(r => r.SettlementCommitment)
                 .ThenInclude(r => r.Settlement)
                 .Select(_builderdocument.BuildDocumentEntity)
                 .ToList()
                 .FirstOrDefault();
            }
            return document;

        }

        /// <summary>
        /// method to check if there are reserved lines and return delivery forms codes
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public string CheckReservedLines(int idDocument)
        {
            List<DocumentLineViewModel> documentLineViewModels = new List<DocumentLineViewModel>();
            StringBuilder codes = new StringBuilder();
            DocumentViewModel documentViewModel = GetModelWithRelationsAsNoTracked(x => x.Id == idDocument, x => x.DocumentLine);
            if (documentViewModel != null)
            {
                List<int> idsItem = documentViewModel.DocumentLine.Select(doc => doc.IdItem).ToList();
                // get documentlines in provisional sales delivery
                List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllWithConditionsRelationsAsNoTracking(x =>
                idsItem.Contains(x.IdItem) && x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
                && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery, doc => doc.StockMovement, documentLines => documentLines.IdDocumentNavigation).ToList();
                // build documentLines to get reserved lines
                documentLineViewModels = documentLines.Select(x => _documentLineBuilder.BuildEntity(x)).ToList();
                List<DocumentLineViewModel> reservedLines = documentLineViewModels.Where(x => x.IsValidReservationFromProvisionalStock == true).ToList();
                reservedLines.ForEach(line =>
                {
                    codes.Append(line.IdDocumentNavigation.Code);
                    codes.Append(", ");
                });
            }
            return codes.ToString();
        }

        /// <summary>
        /// method to generate invoice from delivery
        /// </summary>
        /// <param name="idsDocument"></param>
        /// <returns></returns>
        public DocumentViewModel GenerateInvoice(int[] idsDocument, string userMail)
        {
            DocumentViewModel resultEntity = new DocumentViewModel();
            //get checked documents which are valid and partially satisfied
            List<Document> documents = _entityRepo.QuerableGetAll().Where(x => idsDocument.Contains(x.Id)
            && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid || x.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied))
                .Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLineTaxe).Include(x => x.IdTiersNavigation).ToList();
            if(documents.Any())
            {
                Tiers tier = documents.FirstOrDefault().IdTiersNavigation;
                List<DocumentLine> documentLinesModels = new List<DocumentLine>();
                documents.ForEach(x => documentLinesModels.AddRange(x.DocumentLine));
                List<DocumentLineViewModel> documentLines = documentLinesModels.Select(x => _documentLineBuilder.BuildEntity(x)).ToList();
                // get all document lines with document line associated
                List<DocumentLine> documentLineAssociated = _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocumentLineAssociated != null 
                && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.IdDocumentNavigation.IdTiers == tier.Id).ToList();
                List<int> idsDocumentLineAssociated = documentLineAssociated.Select(x => x.IdDocumentLineAssociated.Value).ToList();
                // get only document lines without documentLineAssociated or with documentLineAssociated and MovementQty < AssociatedDocuments MovementQty
                documentLines = documentLines.Where(x => !idsDocumentLineAssociated.Contains(x.Id) ||
                (idsDocumentLineAssociated.Contains(x.Id) && x.MovementQty > documentLineAssociated.Where(d => d.IdDocumentLineAssociated == x.Id).Select(l => l.MovementQty).Sum())).ToList();
                List<int> idsDocumentOfDocumentLinesToAdd = documentLines.Select(x => x.IdDocument).Distinct().ToList();
                documents = documents.Where(x => idsDocumentOfDocumentLinesToAdd.Contains(x.Id)).ToList();
                List<int> idItems = documentLines.Select(y => y.IdItem).Distinct().ToList();
                List<Item> itemList = _itemEntityRepo.GetAllAsNoTracking().Include(r => r.IdNatureNavigation).Include(r => r.TaxeItem).Where(p => idItems.Distinct().Contains(p.Id)).ToList();
                List<ItemWarehouse> itemWarehouseList = _entityItemWarehouseRepo.GetAllAsNoTracking().Where(p => idItems.Distinct().Contains(p.IdItem)).ToList();
                int companyPrecision = GetCompanyCurrencyPrecision();
                DocumentViewModel invoiceToAdd = new DocumentViewModel
                {
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                    DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                    DocumentDate = DateTime.Now,
                    DocumentLine = new List<DocumentLineViewModel>(),
                    IdTiers = tier.Id,
                    IdUsedCurrency = tier.IdCurrency,
                    IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == userMail).Id
                };
                CreatedDataViewModel createdDataViewModel = new CreatedDataViewModel();
                if (documentLines.Any())
                {
                    createdDataViewModel = (CreatedDataViewModel)AddModelWithoutTransaction(invoiceToAdd, null, null, "DocumentTypeCode");
                }
                else
                {
                    return resultEntity;
                }
                Document currentDocument = _entityRepo.FindSingleBy(x => x.Id == createdDataViewModel.Id);
                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == currentDocument.DocumentTypeCode);
                int idCurrency = _entityRepoTiers.GetAllAsNoTracking().FirstOrDefault(x => x.Id == currentDocument.IdTiers).IdCurrency.Value;
                double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(idCurrency, currentDocument.DocumentDate, currentDocument.ExchangeRate);
                int tiersPrecision = GetPrecissionValue(idCurrency, currentDocument.DocumentTypeCode);
                List<int> documentLineIds = documentLines.Select(d => d.Id).ToList();
                //get document lines associated to document lines to add 
                documentLineAssociated = documentLineAssociated.Where(x => documentLineIds.Contains(x.IdDocumentLineAssociated.Value)).ToList();
                foreach (var documentLine in documentLines)
                {
                    Item item = itemList.FirstOrDefault(p => p.Id == documentLine.IdItem);
                    DocumentLine docLineAssociated = documentLineAssociated.Where(x => x.IdDocumentLineAssociated == documentLine.Id).FirstOrDefault();
                    if(docLineAssociated != null)
                    {
                        documentLine.MovementQty = documentLine.MovementQty - docLineAssociated.MovementQty;
                    }
                    ItemWarehouse itemWarehouse = itemWarehouseList.FirstOrDefault(p => p.IdItem == documentLine.IdItem && p.IdWarehouse == documentLine.IdWarehouse);
                    documentLine.HtUnitAmountWithCurrency = documentLine.UnitPriceFromQuotation > 0 ?
                                documentLine.UnitPriceFromQuotation : documentLine.HtUnitAmountWithCurrency;


                    if (documentLine.MovementQty == 0)
                    {
                        continue;
                    }
                    documentLine.IdDocumentLineAssociated = documentLine.Id;
                    documentLine.Id = 0;
                    documentLine.IdDocumentNavigation = null;
                    documentLine.Designation = string.IsNullOrEmpty(documentLine.Designation) ? itemList.First(x => x.Id == documentLine.IdItem).Description : documentLine.Designation;
                    documentLine.UnitPriceFromQuotation = 0;
                    documentLine.IdDocument = createdDataViewModel.Id;
                    documentLine.IdDocumentLineStatus = currentDocument.IdDocumentStatus;
                    if (documentLine.DocumentLineTaxe != null && documentLine.DocumentLineTaxe.Any())
                    {
                        documentLine.DocumentLineTaxe.Clear();

                    }
                    ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel
                    {
                        IsToImport = true,
                        DocumentDate = currentDocument.DocumentDate,
                        DocumentType = currentDocument.DocumentTypeCode,
                        IdCurrency = currentDocument.IdUsedCurrency ?? 0,
                        IdTiers = currentDocument.IdTiers ?? 0,
                        DocumentLineViewModel = documentLine,
                        Tiers = tier,
                        exchangeRate = exchangeRate,
                        Document = currentDocument,
                        Item = item,
                        DocumentTypeObject = documentType,
                        CompanyPrecison = companyPrecision,
                        TiersPrecison = tiersPrecision
                    };
                    GetDocumentLinePrice(itemPricesViewModel);
                    CalculateDocumentLine(itemPricesViewModel);
                }
                _entityDocumentLineRepo.BulkAdd(documentLines.Select(x => _documentLineBuilder.BuildModel(x)).ToList());
                _unitOfWork.Commit();
                resultEntity = UpdateDocumentAmountsWithoutTransaction(createdDataViewModel.Id, null);
                // build BL codes
                StringBuilder BLCodes = new StringBuilder();
                int counter = 0;
                documents.ForEach(doc =>
                {
                    counter++;
                    BLCodes.Append(doc.Code);
                    if(counter < documents.Count)
                    {
                        BLCodes.Append(", ");
                    }
                    else
                    {
                        BLCodes.Append(".");
                    }
                    
                });
                resultEntity.AssociatedDocumentsCode = BLCodes.ToString();
            }
            
            return resultEntity;
        }


        public void UpdateItemTiersForDocumentPurchaseDelivery(DocumentViewModel document, List<DocumentLineViewModel> documentLines)
        {
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery)
            {
                int precision = GetCompanyCurrencyPrecision();
                List<int> idItems = documentLines.Select(p => p.IdItem).Distinct().ToList();
                List<Item> itemsList = _itemEntityRepo.GetAllWithConditionsRelationsAsNoTracking(item => idItems.Contains(item.Id)).ToList();
                List<ItemTiers> itemsTiers = _itemTiersEntityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdTiers == document.IdTiers && idItems.Contains(x.IdItem)).ToList();
                documentLines.ToList().ForEach(dl =>
                {
                    var item = itemsList.First(y => y.Id == dl.IdItem);
                    item.UnitHtsalePrice = AmountMethods.FormatValue(dl.ConclusiveSellingPrice, precision);
                    item.UnitHtpurchasePrice = AmountMethods.FormatValue(dl.HtUnitAmountWithCurrency, precision);
                    item.CostPrice = AmountMethods.FormatValue(dl.CostPrice, precision);
                    if (itemsTiers.Where(x => x.IdItem == dl.IdItem).Any())
                    {
                        var itemTier = itemsTiers.Where(x => x.IdItem == dl.IdItem).FirstOrDefault();
                        itemTier.PurchasePrice = item.UnitHtpurchasePrice;
                        itemTier.ExchangeRate = document.ExchangeRate;
                        itemTier.Margin = dl.PercentageMargin;
                        itemTier.Cost = dl.CostPrice;
                    }
                });
                _itemEntityRepo.BulkUpdate(itemsList);
                _itemTiersEntityRepo.BulkUpdate(itemsTiers);
            }

        }

        public DeleteInvoiceFromPosViewModel CheckInvoiceLinesToDelete(int idInvoice, List<int> Lines, string userMail)
        {
            try
            {
                DeleteInvoiceFromPosViewModel result = new DeleteInvoiceFromPosViewModel();
                if (idInvoice != null && Lines != null && Lines.Any())
                {
                    DocumentViewModel invoice = GetModelWithRelationsAsNoTracked(x => x.Id == idInvoice, y => y.DocumentLine);

                    List<DocumentLine> allInvoiceLine = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking().Include(x => x.IdDocumentNavigation).Include(x => x.IdItemNavigation)
                            .Include(x => x.InverseIdDocumentLineAssociatedNavigation).Include(x => x.StockMovement).Where(x => x.IdDocument == idInvoice).ToList();

                    List<int> allAssociatedLines = allInvoiceLine.Where(x => x.IdDocumentLineAssociated != null).Select(x => (int)x.IdDocumentLineAssociated).ToList();
                    List<DocumentLine> linesToDelete = allInvoiceLine.Where(x => Lines.Contains(x.Id)).ToList();
                    List<DocumentLine> delete = allInvoiceLine.Where(x => Lines.Contains(x.Id) && x.IdDocumentLineAssociated == null).ToList();
                    List<DocumentLine> Associated = allInvoiceLine.Where(x => Lines.Contains(x.Id) && x.IdDocumentLineAssociated != null).ToList();
                    List<string> AskToDelete = new List<string>();
                    List<int> lineToAsk = new List<int>();
                    if (Associated != null && Associated.Any())
                    {
                        List<int> idsLineAssociated = Associated.Select(x => (int)x.IdDocumentLineAssociated).ToList();
                        var idsDocAssociated = _serviceDocumentLine.GetAllModelsQueryableWithRelation(x => idsLineAssociated.Contains(x.Id), x => x.IdDocumentNavigation).Select(x => x.IdDocument).Distinct().ToList();
                        List<Document> fromPosDocument = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => idsDocAssociated.Contains(x.Id)).Include(y => y.DocumentLine).ToList();
                        fromPosDocument.ForEach(doc =>
                        {
                            if (doc.IsForPos == true)
                            {
                                List<int> documentIds = doc.DocumentLine.Select(x => x.Id).ToList();
                                List<int> ImportedLines = documentIds.Intersect(allAssociatedLines).ToList();
                                List<int> importedLineToDelete = documentIds.Intersect(idsLineAssociated).ToList();
                                if (importedLineToDelete.Any() && ImportedLines.Count() > importedLineToDelete.Count())
                                {
                                    AskToDelete.Add(doc.Code);
                                    lineToAsk.AddRange(allInvoiceLine.Where(x => x.IdDocumentLineAssociated != null && documentIds.Contains((int)x.IdDocumentLineAssociated)).Select(y => y.Id).ToList());
                                }
                                else if (ImportedLines.Count() == importedLineToDelete.Count())
                                {
                                    delete.AddRange(allInvoiceLine.Where(x => x.IdDocumentLineAssociated != null && importedLineToDelete.Contains((int)x.IdDocumentLineAssociated)));
                                }
                            }
                            else
                            {
                                List<int> documentIds = doc.DocumentLine.Select(x => x.Id).ToList();
                                List<int> importedLineToDelete = documentIds.Intersect(idsLineAssociated).ToList();
                                if (importedLineToDelete != null && importedLineToDelete.Any())
                                {
                                    delete.AddRange(allInvoiceLine.Where(x => x.IdDocumentLineAssociated != null && importedLineToDelete.Contains((int)x.IdDocumentLineAssociated)));
                                }
                            }
                        });
                    }
                    List<int> idsLineToDelete = delete.Select(x => x.Id).ToList();
                    if (idsLineToDelete.Count > 0)
                    {

                        var ItemPrices = delete.Select(x => new ItemPriceViewModel
                        {
                            DocumentDate = x.IdDocumentNavigation.DocumentDate,
                            DocumentLineViewModel = _documentLineBuilder.BuildEntity(x),
                            DocumentType = x.IdDocumentNavigation.DocumentTypeCode,
                            IdCurrency = x.IdDocumentNavigation.IdUsedCurrency ?? 0,
                            IdTiers = x.IdDocumentNavigation.IdTiers ?? 0
                        }).ToList();

                        if (ItemPrices.Count > 0)
                        {
                            BeginTransaction();
                            var documentType = ItemPrices[0].DocumentType;
                            var documentStatus = ItemPrices[0].DocumentLineViewModel.IdDocumentLineStatus;
                            List<int> idsItems = ItemPrices.Where(x => x.DocumentLineViewModel.IdItemNavigation.ProvInventory).Select(p => p.DocumentLineViewModel.IdItem).Distinct().ToList();



                            foreach (var item in ItemPrices)
                            {
                                CheckRolesBeforeDeleting(item, item.DocumentType);
                                item.DocumentLineViewModel.IdDocumentNavigation = null;
                                InsertUpdateDocumentLineWithoutTransaction(item, null);

                            }
                            var doc = UpdateDocumentAmountsWithoutTransaction(ItemPrices[0].DocumentLineViewModel.IdDocument, null);
                            EndTransaction();
                            result.Document = doc;
                            result.DeletedLines = idsLineToDelete;
                            result.DocToAsk = AskToDelete;
                            result.LinesToAsk = lineToAsk;
                            return result;
                        }
                        else
                        {
                            throw new CustomException(CustomStatusCode.LINE_ALREAD_DELETED);
                        }
                    }
                    else if (AskToDelete != null && AskToDelete.Any() && linesToDelete != null && linesToDelete.Any())
                    {
                        result.Document = invoice;
                        result.DeletedLines = null;
                        result.DocToAsk = AskToDelete;
                        result.LinesToAsk = lineToAsk;
                        return result;
                    }
                    else
                    {
                        throw new CustomException(CustomStatusCode.EMPTY_LIST);
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.EMPTY_LIST);
                }

            }
            catch (CustomException ex)
            {
                RollBackTransaction();
                throw;
            }
        }
    }

}
