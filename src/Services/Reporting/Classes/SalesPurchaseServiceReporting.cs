using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Shared;

namespace Services.Reporting.Classes
{
    /// <summary>
    /// This service provide informations for Telerik report
    /// </summary>
    public class SalesPurchaseServiceReporting : ISalesPurchaseServiceReporting
    {
        #region Fields
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceTiers _serviceTiers;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceCountry _serviceCountry;
        private readonly IServiceCity _serviceCity;
        private readonly IServiceDocumentType _serviceDocumentType;
        private readonly IServiceCurrency _serviceCurrency;
        private readonly IServiceBankAccount _serviceBankAccount;
        private readonly IDocumentReportingBuilder _documentReportingBuilder;
        private readonly ICompanyReportingBuilder _companyReportingBuilder;
        private readonly IDocumentLineReportingBuilder _documentLineReportingBuilder;
        private readonly IRepository<Document> _entityRepoDocument;
        private readonly IRepository<Company> _entityRepoCompany;
        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IDocumentLineCostReportingBuilder _documentLineCostReportingBuilder;
        IRepository<DocumentExpenseLine> _entityRepoDocumentLineExpense;
        private readonly IDocumentLineExpenseReportingBuilder _documentLineExpenseReportingBuilder;
        private readonly AppSettings _appSettings;
        private readonly IRepository<BankAccount> _repoBankAccount;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IDocumentLineBuilder _documentLineBuilder;
        private readonly IRepository<DocumentType> _entityDocumentTypeRepo;
        private readonly IDocumentBuilder _documentBuilder;
        private readonly IDocumentTaxsResumeBuilder _documentTaxeResumeBuilder;
        private readonly IDocumentLineTaxeBuilder _documentLineTaxeBuilder;
        private readonly IRepository<Taxe> _entityTaxeRepo;

        #endregion
        #region Constructor
        public SalesPurchaseServiceReporting(IServiceDocumentLine serviceDocumentLine, IServiceDocument serviceDocument,
            IServiceTiers serviceTiers, IServiceCompany serviceCompany, IServiceCountry serviceCountry,
            IServiceCity serviceCity, IServiceDocumentType serviceDocumentType, IDocumentLineCostReportingBuilder documentLineCostReportingBuilder,
            IServiceCurrency serviceCurrency, IDocumentReportingBuilder documentReportingBuilder,
            ICompanyReportingBuilder companyReportingBuilder, IDocumentLineReportingBuilder documentLineReportingBuilder,
            IRepository<Document> entityRepoDocument, IRepository<Company> entityRepoCompany, IDocumentLineExpenseReportingBuilder documentLineExpenseReportingBuilder,
            IRepository<DocumentLine> entityRepoDocumentLine, IRepository<DocumentExpenseLine> entityRepoDocumentLineExpense,
            IServiceBankAccount serviceBankAccount, IOptions<AppSettings> appSettings, IServiceCurrencyRate serviceCurrencyRate, IDocumentLineBuilder documentLineBuilder, IDocumentBuilder documentBuilder,
            IDocumentTaxsResumeBuilder documentTaxeResumeBuilder, IRepository<DocumentType> entityDocumentTypeRepo, IDocumentLineTaxeBuilder documentLineTaxeBuilder, IRepository<Taxe> entityTaxeRepo, IRepository<BankAccount> repoBankAccount)
        {
            _serviceDocumentLine = serviceDocumentLine;
            _serviceDocument = serviceDocument;
            _serviceTiers = serviceTiers;
            _serviceCompany = serviceCompany;
            _serviceCountry = serviceCountry;
            _serviceCity = serviceCity;
            _serviceDocumentType = serviceDocumentType;
            _serviceCurrency = serviceCurrency;
            _serviceBankAccount = serviceBankAccount;
            _documentReportingBuilder = documentReportingBuilder;
            _companyReportingBuilder = companyReportingBuilder;
            _documentLineReportingBuilder = documentLineReportingBuilder;
            _entityRepoDocument = entityRepoDocument;
            _serviceCurrencyRate = serviceCurrencyRate;
            _repoBankAccount = repoBankAccount;

            _entityRepoCompany = entityRepoCompany;
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _documentLineCostReportingBuilder = documentLineCostReportingBuilder;
            _entityRepoDocumentLineExpense = entityRepoDocumentLineExpense;
            _documentLineExpenseReportingBuilder = documentLineExpenseReportingBuilder;
            _documentLineBuilder = documentLineBuilder;
            _documentBuilder = documentBuilder;
            _documentTaxeResumeBuilder = documentTaxeResumeBuilder;
            _entityDocumentTypeRepo = entityDocumentTypeRepo;
            _documentLineTaxeBuilder = documentLineTaxeBuilder;
            _entityTaxeRepo = entityTaxeRepo;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
        }
        #endregion
        #region Methodes

        /// <summary>
        /// Get document report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="printType"></param>
        /// <param name="isBtoB"></param>
        /// <returns></returns>
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocument(int idDocument, int printType, bool isBtoB)
        {
            // Recalcul document
            // _serviceDocument.RecalculateDocument(idDocument);

            // Recuperate document
            Document document = _entityRepoDocument.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLinePrices).ThenInclude(x => x.IdPricesNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdTypeTiersNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.Address)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdPhoneNavigation)
                .Include(x => x.IdVehicleNavigation)
                .Include(x => x.IdContactNavigation).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdBankAccountNavigation).ThenInclude(x => x.IdBankNavigation).Include(x => x.IdSettlementModeNavigation)
                .Include(x => x.IdCreatorNavigation)
                .Include(x => x.DocumentTaxsResume).ThenInclude(x => x.IdTaxNavigation)
                .Where(x => x.Id == idDocument).FirstOrDefault();
            // Build document to DocumentReportingViewModel
            DocumentReportingViewModel documentReportingViewModel = _documentReportingBuilder.BuildEntity(document);
            


            // Set type tiers
            documentReportingViewModel.LabelTypeTiers = document.IdTiersNavigation.IdTypeTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiersNavigation.Label : "";
            documentReportingViewModel.DocumentSymboleCurrency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty;
            //documentReportingViewModel.DocumentCurrencyPresicion = (document.IdUsedCurrencyNavigation != null && document.DocumentTypeCode.Contains("SA")) ?
            //    document.IdUsedCurrencyNavigation.SalePrecision : document.IdUsedCurrencyNavigation.PurchasePrecision;
            documentReportingViewModel.DocumentCurrencyPresicion = (documentReportingViewModel.IdUsedCurrencyNavigation != null && documentReportingViewModel.DocumentTypeCode.Contains("SA")) ?
                documentReportingViewModel.IdUsedCurrencyNavigation.Precision : documentReportingViewModel.IdUsedCurrencyNavigation.Precision;

            // Get document type
            DocumentTypeViewModel documentTypeViewModel = _serviceDocumentType.GetModel(x => x.Code == documentReportingViewModel.DocumentTypeCode);
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            // Build company to CompanyReportingViewModel
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            if (isBtoB)
            {
                companyReportingViewModel.CompanyLogo = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "assets", "images", "logos", "logocompany.png");
            }


            double? vatRate = 0;
            string ContractCode = string.Empty;
            // Get vat rate and contract code
            if (document.DocumentLine != null && document.DocumentLine.Any())
            {
                vatRate = document.DocumentLine.ToList()[0].VatTaxRate * 100;
                if (document.DocumentLine.ToList()[0].DocumentLinePrices != null && document.DocumentLine.ToList()[0].DocumentLinePrices.Any())
                {
                    Prices price = document.DocumentLine.ToList()[0].DocumentLinePrices.ToList()[0].IdPricesNavigation;
                    if (price != null)
                    {
                        ContractCode = price.ContractCode;
                    }
                }
            }
            documentReportingViewModel.DocumentTotalBrut = documentReportingViewModel.DocumentTotalDiscountWithCurrency + documentReportingViewModel.DocumentHtpriceWithCurrency;
            var GroupedDocumentLine = GroupedTaxLine(document.DocumentTaxsResume.ToList(), document.IdUsedCurrencyNavigation.Precision, company.Culture);
            var GroupedDocumentLineCount = GroupedDocumentLine.Count;
            string AdressTiers = string.Empty;
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            ReportInformationsForDocumentViewModel reportInformationsForDocumentViewModel = new ReportInformationsForDocumentViewModel
            {
                AdressTiers = document.Adress != null ? document.Adress : string.Empty,
                IdCreator = document.IdCreatorNavigation?.FullName,
                Document = documentReportingViewModel,
                DateOfDoc = document.DocumentDate != null ? document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                DateTimeOfdoc = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) ? String.Format(GenericConstants.EN_FORMAT_DATE, document.DocumentDate) : String.Format(GenericConstants.FR_FORMAT_DATE, document.DocumentDate),
                InvoicingDate = document.DocumentInvoicingDate != null ? document.DocumentInvoicingDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                PrintType = PrintTypeTitle(printType),
                IsAsset = DocumentTypeTitle(document.DocumentTypeCode),
                IsNotValid = document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional,
                GroupedDocumentLine = GroupedDocumentLine,
                GroupedDocumentLine1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0] : new GroupedTaxLineViewModel(),
                GroupedDocumentLine2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1] : new GroupedTaxLineViewModel(),
                GroupedDocumentLineCount = GroupedDocumentLineCount,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) && documentTypeViewModel != null ? documentTypeViewModel.Label 
                : ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) && documentTypeViewModel != null ? documentTypeViewModel.LabelEn : string.Empty,
                Company = companyReportingViewModel,
                ContractCode = ContractCode,
                VatRate = vatRate != null ? CurrencyUtility.GenerateCurrencyByCulture(vatRate.Value, document.IdUsedCurrencyNavigation.Precision, "", company.Culture) : string.Empty,
                DocumentTotalBrut = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalBrut, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalDiscountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalDiscountWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentHtpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentHtpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalVatTaxesWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalVatTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentOtherTaxesWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentOtherTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTtcpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTtcpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentPriceIncludeVatWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentPriceIncludeVatWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalExcVatTaxesWithCurrency = documentReportingViewModel.DocumentTotalExcVatTaxesWithCurrency != 0 ?
                CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalExcVatTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture) : string.Empty,
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                Reference = document.Reference != null ? document.Reference : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty,
                CompanyTel = companyReportingViewModel.CompanyTel,
                BankName = bankAccount != null && bankAccount.IdBankNavigation != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                AmountInLetter = document.AmountInLetter,
                BaseVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].BaseTVA : string.Empty,
                BaseVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].BaseTVA : string.Empty,
                BaseVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].BaseTVA : string.Empty,
                AmountVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].MontantTVA : string.Empty,
                AmountVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].MontantTVA : string.Empty,
                AmountVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].MontantTVA : string.Empty,
                TauxVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].TauxTVA : string.Empty,
                TauxVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].TauxTVA : string.Empty,
                TauxVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].TauxTVA : string.Empty,
                CurrencyLabel = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                TelTiers = document.Tel1 != null ? document.Tel1 : string.Empty,
            };
            if (document != null && document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.IdSalesDepositInvoice != null)
            {
                DocumentViewModel depositInvoice = _serviceDocument.GetModelAsNoTracked(x => x.Id == document.IdSalesDepositInvoice);
                reportInformationsForDocumentViewModel.DepositAmount = CurrencyUtility.GenerateCurrencyByCulture((double)depositInvoice.DocumentTtcpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture) ;
                reportInformationsForDocumentViewModel.IsDepositInvoice = true;
                if(document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    reportInformationsForDocumentViewModel.IsProvisonalDepositInvoice = true;
                    reportInformationsForDocumentViewModel.RemainingAmount = CurrencyUtility.GenerateCurrencyByCulture((double)(document.DocumentTtcpriceWithCurrency - depositInvoice.DocumentTtcpriceWithCurrency), document.IdUsedCurrencyNavigation.Precision, "", company.Culture);
                }
                else
                {
                    reportInformationsForDocumentViewModel.DepositInvoiceNumber = depositInvoice.Code;
                    reportInformationsForDocumentViewModel.IsProvisonalDepositInvoice = false;
                }
            }
            else
            {
                reportInformationsForDocumentViewModel.IsDepositInvoice = false;
                reportInformationsForDocumentViewModel.IsProvisonalDepositInvoice = false;
            }
            return reportInformationsForDocumentViewModel;
        }


        private List<GroupedTaxLineViewModel> GroupedTaxLine(IList<DocumentTaxsResume> data, int precision, string culture)
        {
            List<GroupedTaxLineViewModel> listOfData = new List<GroupedTaxLineViewModel>();
            data.ToList().ForEach(y =>
            {

                listOfData.Add(new GroupedTaxLineViewModel()
                {

                    MontantHT = y.HtAmountWithCurrency.Value > 0 ? CurrencyUtility.GenerateCurrencyByCulture((y.HtAmountWithCurrency.Value - (y.ExcVatTaxAmountWithCurrency ?? 0)), precision, "", culture) : "",
                    BaseTVA = y.HtAmountWithCurrency.Value > 0 ? CurrencyUtility.GenerateCurrencyByCulture(y.HtAmountWithCurrency.Value, precision, "", culture) : "",
                    MontantTVA = CurrencyUtility.GenerateCurrencyByCulture(y.TaxAmountWithCurrency.Value, precision, "", culture),
                    TauxTVA = y.IdTaxNavigation.TaxeValue != null ? CurrencyUtility.GenerateCurrencyByCulture(y.IdTaxNavigation.TaxeValue.Value, 1, "", culture) : "-",
                    TotalRemise = CurrencyUtility.GenerateCurrencyByCulture(y.DiscountAmountWithCurrency.Value, precision, "", culture)
                });
            });

            return listOfData;
        }

        private string PrintTypeTitle(int printType)
        {
            string PrintTypeTitle = string.Empty;
            if (printType == 0)
            {
                PrintTypeTitle = "ORIGINALE";
            }
            else if (printType == 1)
            {
                PrintTypeTitle = "COPIE";
            }
            else if (printType == 2)
            {
                PrintTypeTitle = "DUPLICATA";
            }
            else if (printType == 3)
            {
                PrintTypeTitle = "DETAILED";
            }

            return PrintTypeTitle;
        }

        private string DocumentTypeTitle(string docType)
        {
            string PrintTypeTitle = string.Empty;
            if (docType == DocumentEnumerator.SalesInvoiceAsset)
            {
                PrintTypeTitle = "AVOIR";
            }

            return PrintTypeTitle;
        }


        private string PrepareCompanyImage(Company company)
        {

            FileInfoViewModel fileInfoViewModel = null;
            // Test if company logo exist
            if (company.AttachmentUrl != null)
            {
                // Prepare file info
                fileInfoViewModel = _serviceCompany.GetFilesContent(company.AttachmentUrl).FirstOrDefault();
                if (fileInfoViewModel == null)
                {
                    return "";
                }
                // Get path
                string path = Path.Combine(_appSettings.UploadFilePath, company.AttachmentUrl);
                if (!Directory.Exists(path))
                {
                    // Create directory
                    Directory.CreateDirectory(path);
                }
                fileInfoViewModel.FulPath = path;
                fileInfoViewModel.FulPathReportingImage = Path.Combine(path, fileInfoViewModel.Name);
                _serviceCompany.CreatFile(fileInfoViewModel, path);
            }
            return (fileInfoViewModel != null && fileInfoViewModel.FulPathReportingImage != null) ? fileInfoViewModel.FulPathReportingImage : string.Empty;
        }
        /// <summary>
        /// Get DocumentLine report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLine(int idDocument)
        {
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            var documentLinesReportingViewModel = _entityRepoDocumentLine.QuerableGetAll().Where(x => x.IdDocument == idDocument).
                Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdUsedCurrencyNavigation).Include(x => x.IdMeasureUnitNavigation).
                Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemVehicleBrandModelSubModel).ThenInclude(x => x.IdVehicleBrandNavigation).
                Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).
                Include(x => x.IdItemNavigation).ThenInclude(x => x.IdProductItemNavigation).
                Include(x => x.IdItemNavigation).Include(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).ToList();
            int currency = 0;
            IList<DocumentLineReportingViewModel> listDocLineReport = new List<DocumentLineReportingViewModel>();
            foreach (var documenLineViewModel in documentLinesReportingViewModel)
            {
                if (currency == 0)
                {
                    currency = (documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation != null && documenLineViewModel.IdDocumentNavigation.DocumentTypeCode.Contains("SA")) ?
               documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision : documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision;

                }
                if (documenLineViewModel.UnitPriceFromQuotation != null && !documenLineViewModel.UnitPriceFromQuotation.Value.Equals(0))
                {
                    documenLineViewModel.HtUnitAmountWithCurrency = documenLineViewModel.UnitPriceFromQuotation;
                }
                documenLineViewModel.VatTaxRate *= 100;
            }
            listDocLineReport = documentLinesReportingViewModel.Select(x => _documentLineReportingBuilder.BuildEntity(x,null,null))
                .OrderBy(p => p.ShelfAndStorage).ThenBy(p => p.CodeArticle).ToList();
            if (currency != 0)
            {
                listDocLineReport.ToList().ForEach(x => x.CurrencyPrecision = currency);
            }
            foreach (DocumentLineReportingViewModel docLineReport in listDocLineReport)
            {
                docLineReport.HtUnitAmountWithCurrencyString = docLineReport.HtUnitAmountWithCurrency !=null ? CurrencyUtility.GenerateCurrencyByCulture(docLineReport.HtUnitAmountWithCurrency.Value, docLineReport.CurrencyPrecision.Value, "", company.Culture) : "0";
                docLineReport.HtTotalLineWithCurrencyString = docLineReport.HtTotalLineWithCurrency !=null ? CurrencyUtility.GenerateCurrencyByCulture(docLineReport.HtTotalLineWithCurrency.Value, docLineReport.CurrencyPrecision.Value, "", company.Culture) :"0";
                docLineReport.TTcTotalLineWithCurrencyString = docLineReport.TTcTotalLineWithCurrency != null ? CurrencyUtility.GenerateCurrencyByCulture(docLineReport.TTcTotalLineWithCurrency.Value, docLineReport.CurrencyPrecision.Value, "", company.Culture) : "0";
                if (docLineReport.DocumentLineTaxe != null)
                {
                    List<DocumentLineTaxeViewModel> listDocLineWithCalculableTaxe = docLineReport.DocumentLineTaxe.Where(y => y.IdTaxeNavigation.IsCalculable && y.IdTaxeNavigation.TaxeValue != null).ToList();
                    List<DocumentLineTaxeViewModel> listDocLineWithoutCalculableTaxe = docLineReport.DocumentLineTaxe.Where(y => !y.IdTaxeNavigation.IsCalculable).ToList();
                    docLineReport.AllVatTaxRate = "-";
                    if (listDocLineWithCalculableTaxe != null && listDocLineWithCalculableTaxe.Any())
                    {
                        docLineReport.AllVatTaxRate = string.Join(GenericConstants.Comma, listDocLineWithCalculableTaxe.Select(x => x.IdTaxeNavigation.Label.ToString())) ?? "-";
                       
                    } else if (listDocLineWithoutCalculableTaxe != null && listDocLineWithoutCalculableTaxe.Any())
                    {
                        docLineReport.AllVatTaxRate = docLineReport.VatTaxAmountWithCurrency != null ?
                            docLineReport.HtUnitAmountWithCurrencyString = CurrencyUtility.GenerateCurrencyByCulture
                            (docLineReport.VatTaxAmountWithCurrency.Value, docLineReport.CurrencyPrecision.Value,
                            docLineReport.Symbole, company.Culture) : "-";
                    }
                }
            }
            return listDocLineReport;
        }


        public IEnumerable<DocumentLineViewModel> ListReportDocumentLines(int idDocument)
        {
            var documentLine = _serviceDocumentLine.GetDocumentLines(idDocument);

            foreach (var documenLineViewModel in documentLine)
            {
                if (documenLineViewModel.UnitPriceFromQuotation != null && !documenLineViewModel.UnitPriceFromQuotation.Equals(0))
                {
                    documenLineViewModel.HtUnitAmountWithCurrency = documenLineViewModel.UnitPriceFromQuotation;
                }
            }
            return documentLine;
        }


        /// <summary>
        /// Get document report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public DocumentReportInformationsViewModel GetDocumentReportInformations(int idDocument)
        {
            var document = _serviceDocument.GetModel(x => x.Id == idDocument);
            var tiers = _serviceTiers.GetModelWithRelations(x => x.Id == document.IdTiers, x => x.Contact);
            var contact = tiers.Contact.FirstOrDefault(x => x.Id == document.IdContact);
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var addressTiers = tiers.Address != null ? tiers.Address.FirstOrDefault() : null;
            var city = _serviceCity.GetModel(x => x.Id == address.IdCity);
            var country = _serviceCountry.GetModel(x => x.Id == address.IdCountry);
            var currency = _serviceCurrency.GetModel(x => x.Id == document.IdUsedCurrency);
            BankAccountViewModel bankAccount = document.IdBankAccount != null ? _serviceBankAccount.GetAllModelsWithRelations(x => x.Id == document.IdBankAccount).FirstOrDefault() : null;
            DocumentReportInformationsViewModel result = new DocumentReportInformationsViewModel
            {
                //company
                AdressCompany = address != null ? address.PrincipalAddress : string.Empty,
                ZipCodeCompany = (address != null && address.IdZipCodeNavigation != null) ? address.IdZipCodeNavigation.Code : string.Empty,
                TelCompany = company != null ? company.Tel1 : string.Empty,
                CityCompany = city != null ? city.Label : string.Empty,
                NameCompany = company != null ? company.Name : string.Empty,
                WebSiteCompany = company != null ? company.WebSite : string.Empty,
                PaysCompany = country != null ? country.NameFr : string.Empty,
                SIRETCompany = (company != null && company.Siret != null) ? company.Siret : string.Empty,
                CommercialRegisterCompany = company != null ? company.CommercialRegister : string.Empty,
                EmailCompany = company != null ? company.Email : string.Empty,
                CompanyLogo = (company != null && company.PictureFileInfo != null && company.PictureFileInfo.FulPathReportingImage!=null) ? company.PictureFileInfo.FulPathReportingImage : string.Empty,
                //TVA = company.TVA
                VATNumberCompany = company != null ? company.VatNumber : string.Empty,
                //document
                DocumentDate = document != null ? document.CreationDate : default,
                DocumentCode = document != null ? document.Code : default,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? _serviceDocumentType.GetModel(x => x.Code == document.DocumentTypeCode).Label
                : _serviceDocumentType.GetModel(x => x.Code == document.DocumentTypeCode).LabelEn,
                DocumentTotalDiscountWithCurrency = document.DocumentTotalDiscountWithCurrency,
                DocumentHtpriceWithCurrency = document.DocumentHtpriceWithCurrency,
                DocumentTotalExcVatTaxesWithCurrency = document.DocumentTotalExcVatTaxesWithCurrency,
                DocumentTotalVatTaxesWithCurrency = document.DocumentTotalVatTaxesWithCurrency,
                DocumentOtherTaxesWithCurrency = document.DocumentOtherTaxesWithCurrency,
                DocumentTtcpriceWithCurrency = document.DocumentTtcpriceWithCurrency,
                DocumentSymboleCurrency = currency != null ? currency.Symbole : string.Empty,
                DocumentCurrencyPresicion = (currency != null && document.DocumentTypeCode.Contains("SA")) ? currency.Precision : currency.Precision,
                //tiers
                CodeTiers = tiers != null ? tiers.CodeTiers : default,
                NameTiers = tiers != null ? tiers.Name : default,
                AdressTiers = addressTiers != null ? addressTiers.PrincipalAddress : string.Empty,

                MatriculeFiscalTiers = tiers != null ? tiers.MatriculeFiscale : default,
                RegionTiers = tiers != null ? tiers.Region : default,
                //contact
                FirstNameContact = contact != null ? contact.FirstName : string.Empty,
                LastNameContact = contact != null ? contact.LastName : string.Empty,
                TelContact = contact != null ? contact.Tel1 : string.Empty,
                FunctionContact = contact != null ? contact.Fonction : string.Empty,
                EmailContact = contact != null ? contact.Email : string.Empty,
                //bank account
                IbanBankAccount = bankAccount != null ? bankAccount.Iban : string.Empty,
                BicBankAccount = bankAccount != null ? bankAccount.Bic : string.Empty,
            };
            return result;
        }


        /// <summary>
        /// Get DocumentLine report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="isfrombl"></param>
        /// <returns></returns>
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineInvoice(int idDocument, int isfrombl)
        {
            // Get Company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            // Get document Lines
            var documentLinesReportingViewModel = _entityRepoDocumentLine.GetAllWithConditionsRelations(x => x.IdDocument == idDocument,
                x => x.IdDocumentNavigation, x => x.IdDocumentNavigation.IdUsedCurrencyNavigation, x => x.IdMeasureUnitNavigation,
                x => x.IdItemNavigation, x => x.IdItemNavigation.ItemWarehouse, x => x.IdItemNavigation.IdProductItemNavigation,
                x => x.IdDocumentLineAssociatedNavigation,
                x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation).ToList();
            int currency = 0;
            foreach (var documenLineViewModel in documentLinesReportingViewModel)
            {
                if (currency == 0)
                {
                    currency = documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation != null ? documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision : 3;

                }
                if (documenLineViewModel.UnitPriceFromQuotation != null && !documenLineViewModel.UnitPriceFromQuotation.Value.Equals(0))
                {
                    documenLineViewModel.HtUnitAmountWithCurrency = documenLineViewModel.UnitPriceFromQuotation;
                }

            }

            var documentLineResult = documentLinesReportingViewModel.Select(x => _documentLineReportingBuilder.BuildEntity(x, null, null)).ToList().OrderBy(f => f.IdDocumentAssociatedNavigationCode).ToList();

            documentLineResult.GroupBy(x => x.IdDocumentAssociatedNavigationCode).ToList().ForEach(v =>
            {
                v.ToList().ForEach(n =>
                {
                    n.VatTaxRate = Math.Round((n.VatTaxRate ?? NumberConstant.Zero) * NumberConstant.Hundred, NumberConstant.One);
                    n.DocumentHtpriceWithCurrency = v.Sum(f => f.HtTotalLineWithCurrency + f.VatTaxAmountWithCurrency + f.ExcVatTaxAmountWithCurrency);
                    var ttc = CurrencyUtility.GenerateCurrencyByCulture(n.DocumentHtpriceWithCurrency.Value, currency, "", company.Culture);
                    var mht = CurrencyUtility.GenerateCurrencyByCulture(v.Sum(f => f.HtTotalLineWithCurrency).Value, currency, "", company.Culture);
                    var codeLength = 0;
                    if (n.IdDocumentAssociatedNavigation != null)
                    {

                        if (isfrombl == 1)
                        {
                            codeLength = (n.IdDocumentAssociatedNavigationCode.Length - NumberConstant.Six > NumberConstant.Six ? NumberConstant.Six : (n.IdDocumentAssociatedNavigationCode.Length - NumberConstant.Six));
                            n.DocumentTypeString = GenericConstants.BL_NUMBER + n.IdDocumentAssociatedNavigationCode.Substring(NumberConstant.Six, NumberConstant.Six);
                        }
                        else
                        {
                            codeLength = (n.IdDocumentAssociatedNavigationCode.Length - NumberConstant.Eight > NumberConstant.Six ? NumberConstant.Six : (n.IdDocumentAssociatedNavigationCode.Length - NumberConstant.Eight));
                            n.DocumentTypeString = GenericConstants.HV_NUMBER + n.IdDocumentAssociatedNavigationCode.Substring(NumberConstant.Eight, codeLength);
                        }
                        n.DocumentDateString = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) 
                        ? GenericConstants.FROM + String.Format(GenericConstants.EN_FORMAT_DATE, n.IdDocumentAssociatedNavigation.DocumentDate)
                       : GenericConstants.FROM + String.Format(GenericConstants.FR_FORMAT_DATE, n.IdDocumentAssociatedNavigation.DocumentDate);
                        n.DocumentMHTString = GenericConstants.HT_AMOUNT + mht.Replace(GenericConstants.Point, GenericConstants.Comma);
                        n.DocumentMTTCString = GenericConstants.TTC_AMOUNT + ttc.Replace(GenericConstants.Point, GenericConstants.Comma);
                        n.DocumentLineHeader = n.DocumentTypeString + n.DocumentDateString + n.DocumentMHTString + n.DocumentMTTCString;
                        n.HtUnitAmountWithCurrencyString = n.HtUnitAmountWithCurrency != null ? CurrencyUtility.GenerateCurrencyByCulture(n.HtUnitAmountWithCurrency.Value, currency, "", company.Culture) : string.Empty;
                        n.HtTotalLineWithCurrencyString = n.HtTotalLineWithCurrency != null ? CurrencyUtility.GenerateCurrencyByCulture(n.HtTotalLineWithCurrency.Value, currency, "", company.Culture) : string.Empty;
                        n.TTcTotalLineWithCurrencyString = n.TTcTotalLineWithCurrency != null ? CurrencyUtility.GenerateCurrencyByCulture(n.HtTotalLineWithCurrency.Value, currency, "", company.Culture) : string.Empty;

                        if (n.IdDocumentAssociatedNavigation.DocumentTypeCode == DocumentEnumerator.BS || (n.IdDocumentAssociatedNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice && n.IdDocumentAssociatedNavigation.InoicingType != null && n.IdDocumentAssociatedNavigation.InoicingType == 3))
                        {
                            n.DocumentTypeString = "";
                            n.DocumentDateString = "";
                            n.DocumentMHTString = "";
                            n.DocumentMTTCString = "";
                            n.DocumentLineHeader = "";
                        }
                        n.IdDocumentAssociatedNavigation.IdTiersNavigation = null;
                    }
                });
            });
            return documentLineResult.OrderBy(f => f.IdDocumentAssociatedNavigationCode).ToList();
        }

        /// <summary>
        /// Get DocumentLine report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="printType"></param>
        /// <param name="isfrombl"></param>
        /// <returns></returns>
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentCost(int idDocument, int printType, bool isBtoB)
        {
            // Recuperate document
            Document document = _entityRepoDocument.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLinePrices).ThenInclude(x => x.IdPricesNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdTypeTiersNavigation).Include(x => x.IdContactNavigation).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdBankAccountNavigation).Include(x => x.IdSettlementModeNavigation)
                .Include(x => x.IdCreatorNavigation)
                .Include(x => x.DocumentExpenseLine)
                .Include(x => x.DocumentLine).ThenInclude(x => x.IdItemNavigation)
                .Include(x => x.DocumentTaxsResume).ThenInclude(x => x.IdTaxNavigation)
                .Where(x => x.Id == idDocument).FirstOrDefault();
            // Build document to DocumentReportingViewModel
            DocumentReportingViewModel documentReportingViewModel = _documentReportingBuilder.BuildEntity(document);
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            var documentLinesReportingViewModel = _serviceDocument.GeneratePriceCostLinesFromDocumentLine(document.DocumentLine.ToList());
            var mntdevise = document.DocumentTtcpriceWithCurrency;
            var coursdevise = document.ExchangeRate;
            var mntdt = document.DocumentTtcprice;
            var mntcharge = document.DocumentExpenseLine.Sum(d => d.TtcAmountLineWithCurrency);
            var totalHT = documentLinesReportingViewModel.Sum(x => x.LineHtAmount);
            var totalTTC = documentLinesReportingViewModel.Sum(x => x.ConclusiveSellingPrice);
            var coefAchat = (mntdt + mntcharge) / mntdevise;
            var coefVente = documentLinesReportingViewModel.Sum(x => x.ConclusiveSellingPrice * x.Quantity) / mntdevise;

            // Set type tiers
            documentReportingViewModel.LabelTypeTiers = document.IdTiersNavigation.IdTypeTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiersNavigation.Label : "";
            documentReportingViewModel.DocumentSymboleCurrency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty;

            documentReportingViewModel.DocumentCurrencyPresicion = (documentReportingViewModel.IdUsedCurrencyNavigation != null && documentReportingViewModel.DocumentTypeCode.Contains("SA")) ?
                documentReportingViewModel.IdUsedCurrencyNavigation.Precision : documentReportingViewModel.IdUsedCurrencyNavigation.Precision;

            // Get document type
            DocumentTypeViewModel documentTypeViewModel = _serviceDocumentType.GetModel(x => x.Code == documentReportingViewModel.DocumentTypeCode);
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true, x => x.IdCurrencyNavigation);
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            
            if (isBtoB)
            {
                companyReportingViewModel.CompanyLogo = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "assets", "images", "logos", "logocompany.png");
            }

            double? vatRate = 0;
            string ContractCode = string.Empty;
            // Get vat rate and contract code
            if (document.DocumentLine != null && document.DocumentLine.Any())
            {
                vatRate = document.DocumentLine.ToList()[0].VatTaxRate * 100;
                if (document.DocumentLine.ToList()[0].DocumentLinePrices != null && document.DocumentLine.ToList()[0].DocumentLinePrices.Any())
                {
                    Prices price = document.DocumentLine.ToList()[0].DocumentLinePrices.ToList()[0].IdPricesNavigation;
                    if (price != null)
                    {
                        ContractCode = price.ContractCode;
                    }
                }
            }
            documentReportingViewModel.DocumentTotalBrut = documentReportingViewModel.DocumentTotalDiscountWithCurrency + documentReportingViewModel.DocumentHtpriceWithCurrency;
            var GroupedDocumentLine = GroupedTaxLine(document.DocumentTaxsResume.ToList(), document.IdUsedCurrencyNavigation.Precision, company.Culture);
            var GroupedDocumentLineCount = GroupedDocumentLine.Count;
            // Prepare data to use in report
            ReportInformationsForDocumentViewModel reportInformationsForDocumentViewModel = new ReportInformationsForDocumentViewModel
            {
                CurrencyLabel = document.IdUsedCurrencyNavigation.CurrencyInLetter,
                MontantDevise = CurrencyUtility.GenerateCurrencyByCulture(mntdevise.Value, document.IdUsedCurrencyNavigation.Precision, document.IdUsedCurrencyNavigation.Symbole, company.Culture),
                MontantDinars = CurrencyUtility.GenerateCurrencyByCulture(mntdt.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                MontantCharge = CurrencyUtility.GenerateCurrencyByCulture(mntcharge, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                CoursDeChange = coursdevise,
                MargeDepense = 0,
                TotalHT = totalHT,
                TotalTTC = totalTTC,
                CoefAchat = AmountMethods.FormatValue(coefAchat, company.IdCurrencyNavigation.Precision),
                CoefVente = AmountMethods.FormatValue(coefVente, company.IdCurrencyNavigation.Precision),
                NoteFacture = document.Reference,
                NumeroFacture = document.DocumentInvoicingNumber,
                IdCreator = document.IdCreatorNavigation?.FullName,
                Document = documentReportingViewModel,
                InvoicingDate = document.DocumentInvoicingDate != null ? document.DocumentInvoicingDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                DateOfDoc = document.DocumentDate != null ? document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                DateTimeOfdoc = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) ? String.Format(GenericConstants.EN_FORMAT_DATE, document.DocumentDate) : String.Format(GenericConstants.FR_FORMAT_DATE, document.DocumentDate),
                PrintType = PrintTypeTitle(printType),
                IsAsset = DocumentTypeTitle(document.DocumentTypeCode),
                IsNotValid = document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional,
                GroupedDocumentLine = GroupedDocumentLine,
                GroupedDocumentLine1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0] : new GroupedTaxLineViewModel(),
                GroupedDocumentLine2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1] : new GroupedTaxLineViewModel(),
                GroupedDocumentLineCount = GroupedDocumentLineCount,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) && documentTypeViewModel != null ? documentTypeViewModel.Label 
                : ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) && documentTypeViewModel != null ? documentTypeViewModel.LabelEn : string.Empty,
                Company = companyReportingViewModel,
                ContractCode = ContractCode,
                VatRate = CurrencyUtility.GenerateCurrencyByCulture(vatRate.Value, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
            return reportInformationsForDocumentViewModel;
        }


        /// <summary>
        /// Get document report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="printType"></param>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentExpense(int idDocument, int printType, bool isBtoB)
        {
            // Recuperate document
            Document document = _entityRepoDocument.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLinePrices).ThenInclude(x => x.IdPricesNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdTypeTiersNavigation).Include(x => x.IdContactNavigation).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdBankAccountNavigation).Include(x => x.IdSettlementModeNavigation)
                .Include(x => x.IdCreatorNavigation)
                .Include(x => x.DocumentExpenseLine)
                .Include(x => x.DocumentTaxsResume).ThenInclude(x => x.IdTaxNavigation)
                .Where(x => x.Id == idDocument).FirstOrDefault();
            // Build document to DocumentReportingViewModel
            DocumentReportingViewModel documentReportingViewModel = _documentReportingBuilder.BuildEntity(document);

            //var documentLinesReportingViewModel = _entityRepoDocumentLineExpense.GetAllWithConditionsRelations(x => x.IdDocument == idDocument).ToList();
            var documentLinesReportingViewModel = document.DocumentExpenseLine.ToList();

            var mntdevise = document.DocumentTtcpriceWithCurrency;
            var coursdevise = document.ExchangeRate;
            var mntdt = document.DocumentTtcprice;

            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            // Set type tiers
            documentReportingViewModel.LabelTypeTiers = document.IdTiersNavigation.IdTypeTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiersNavigation.Label : "";
            documentReportingViewModel.DocumentSymboleCurrency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty;

            documentReportingViewModel.DocumentCurrencyPresicion = (documentReportingViewModel.IdUsedCurrencyNavigation != null && documentReportingViewModel.DocumentTypeCode.Contains("SA")) ?
                documentReportingViewModel.IdUsedCurrencyNavigation.Precision : documentReportingViewModel.IdUsedCurrencyNavigation.Precision;

            // Get document type
            DocumentTypeViewModel documentTypeViewModel = _serviceDocumentType.GetModel(x => x.Code == documentReportingViewModel.DocumentTypeCode);
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true, x => x.IdCurrencyNavigation);
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
           
            if (isBtoB)
            {
                companyReportingViewModel.CompanyLogo = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "assets", "images", "logos", "logocompany.png");
            }
            double? vatRate = 0;
            string ContractCode = string.Empty;
            // Get vat rate and contract code
            if (document.DocumentLine != null && document.DocumentLine.Any())
            {
                vatRate = document.DocumentLine.ToList()[0].VatTaxRate * 100;
                if (document.DocumentLine.ToList()[0].DocumentLinePrices != null && document.DocumentLine.ToList()[0].DocumentLinePrices.Any())
                {
                    Prices price = document.DocumentLine.ToList()[0].DocumentLinePrices.ToList()[0].IdPricesNavigation;
                    if (price != null)
                    {
                        ContractCode = price.ContractCode;
                    }
                }
            }
            documentReportingViewModel.DocumentTotalBrut = documentReportingViewModel.DocumentTotalDiscountWithCurrency + documentReportingViewModel.DocumentHtpriceWithCurrency;
            var GroupedDocumentLine = GroupedTaxLine(document.DocumentTaxsResume.ToList(), document.IdUsedCurrencyNavigation.Precision, company.Culture);
            var GroupedDocumentLineCount = GroupedDocumentLine.Count;
            // Prepare data to use in report
            ReportInformationsForDocumentViewModel reportInformationsForDocumentViewModel = new ReportInformationsForDocumentViewModel
            {
                CurrencyLabel = document.IdUsedCurrencyNavigation.CurrencyInLetter,
                MontantDevise = CurrencyUtility.GenerateCurrencyByCulture(mntdevise.Value, document.IdUsedCurrencyNavigation.Precision, document.IdUsedCurrencyNavigation.Symbole, company.Culture),
                MontantDinars = CurrencyUtility.GenerateCurrencyByCulture(mntdt.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                CoursDeChange = coursdevise,
                MargeDepense = 0,
                NoteFacture = document.Reference,
                NumeroFacture = document.DocumentInvoicingNumber,
                IdCreator = document.IdCreatorNavigation?.FullName,
                Document = documentReportingViewModel,
                InvoicingDate = document.DocumentInvoicingDate != null ? document.DocumentInvoicingDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                DateOfDoc = document.DocumentDate != null ? document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                PrintType = PrintTypeTitle(printType),
                IsAsset = DocumentTypeTitle(document.DocumentTypeCode),
                IsNotValid = document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional,
                GroupedDocumentLine = GroupedDocumentLine,
                GroupedDocumentLine1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0] : new GroupedTaxLineViewModel(),
                GroupedDocumentLine2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1] : new GroupedTaxLineViewModel(),
                GroupedDocumentLineCount = GroupedDocumentLineCount,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) && documentTypeViewModel != null ? documentTypeViewModel.Label
                : ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) && documentTypeViewModel != null ? documentTypeViewModel.LabelEn : string.Empty,
                Company = companyReportingViewModel,
                ContractCode = ContractCode,
                VatRate = CurrencyUtility.GenerateCurrencyByCulture(vatRate.Value, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
            return reportInformationsForDocumentViewModel;
        }


        /// <summary>
        /// Get DocumentLine report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="isfrombl"></param>
        /// <returns></returns>
        public IList<DocumentLineCostReportingViewModel> GetReportInformationOfDocumentLineCost(int idDocument, int isfrombl)
        {
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true, x => x.IdCurrencyNavigation);
            // Get document Lines
            var documentLines = _entityRepoDocumentLine.GetAllWithConditionsRelations(x => x.IdDocument == idDocument,
                x => x.IdDocumentNavigation, x => x.IdDocumentNavigation.IdUsedCurrencyNavigation, x => x.IdMeasureUnitNavigation,
                x => x.IdItemNavigation, x => x.IdItemNavigation.ItemWarehouse,
                x => x.IdDocumentLineAssociatedNavigation,
                x => x.IdDocumentLineAssociatedNavigation.IdDocumentNavigation).ToList();
            
            foreach (var item in documentLines)
            {
                if (item.UnitPriceFromQuotation != null && !item.UnitPriceFromQuotation.Value.Equals(0))
                {
                    item.HtUnitAmountWithCurrency = item.UnitPriceFromQuotation;
                }
                item.VatTaxRate *= 100;
            }
            var costPriceLines = _serviceDocument.GeneratePriceCostLinesFromDocumentLine(documentLines);
            var documentLineResult = costPriceLines.Select(_documentLineCostReportingBuilder.BuildEntity).ToList().OrderBy(f => f.CodeItem).ToList();
            documentLineResult.ForEach(item =>
            {
                item.PUDEVString = CurrencyUtility.GenerateCurrencyByCulture(item.PUDEV.Value, documentLines.FirstOrDefault().IdDocumentNavigation.IdUsedCurrencyNavigation.Precision, documentLines.FirstOrDefault().IdDocumentNavigation.IdUsedCurrencyNavigation.Symbole, company.Culture);
                item.PREVString = CurrencyUtility.GenerateCurrencyByCulture(item.PREV.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture);
                item.PVHTString = CurrencyUtility.GenerateCurrencyByCulture(item.PVHT.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture);
            });
            double sumPudevQty = documentLineResult.Sum(x => x.PudevQty.Value);
            double sumPrevQTY = documentLineResult.Sum(x => x.PrevQty.Value);
            double sumPvhtQty = documentLineResult.Sum(x => x.PvhtQty.Value);
            if (documentLineResult != null && documentLineResult.Any())
            {
                documentLineResult.Add(new DocumentLineCostReportingViewModel()
                {
                    Reference = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    PUDEVString = CurrencyUtility.GenerateCurrencyByCulture(sumPudevQty, documentLines.FirstOrDefault().IdDocumentNavigation.IdUsedCurrencyNavigation.Precision, documentLines.FirstOrDefault().IdDocumentNavigation.IdUsedCurrencyNavigation.Symbole, company.Culture),
                    PREVString = CurrencyUtility.GenerateCurrencyByCulture(sumPrevQTY, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                    PVHTString = CurrencyUtility.GenerateCurrencyByCulture(sumPvhtQty, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture)
                });
            }
            return documentLineResult;
        }
        /// <summary>
        /// Get DocumentLine report information
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public IList<DocumentLineExpenseReportingViewModel> GetReportInformationOfDocumentLineExpense(int idDocument, int isfrombl)
        {
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true, x => x.IdCurrencyNavigation);
            // Get document Expense Lines
            var documentExpenseLines = _entityRepoDocumentLineExpense.GetAllWithConditionsRelations(x => x.IdDocument == idDocument,
                x => x.IdDocumentNavigation, x => x.IdDocumentNavigation.IdUsedCurrencyNavigation,
                x => x.IdCurrencyNavigation, x => x.IdExpenseNavigation, x => x.IdTiersNavigation,
                x => x.IdTaxeNavigation).ToList();

            var documentLineResult = documentExpenseLines.Select(_documentLineExpenseReportingBuilder.BuildEntity).ToList().OrderBy(f => f.Code).ToList();
            documentLineResult.ForEach(item =>
            {
                item.MNTHTString = CurrencyUtility.GenerateCurrencyByCulture(item.MNTHT.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture);
                item.MNTTVAString = CurrencyUtility.GenerateCurrencyByCulture(item.MNTTVA.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture);
                item.MNTTTCString = CurrencyUtility.GenerateCurrencyByCulture(item.MNTTTC.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture);
            });
            double sumMNTHT = documentLineResult.Sum(x => x.MNTHT.Value);
            double sumMNTTVA = documentLineResult.Sum(x => x.MNTTVA.Value);
            double sumMNTTTC = documentLineResult.Sum(x => x.MNTTTC.Value);
            if (documentLineResult != null && documentLineResult.Any())
            {
                documentLineResult.Add(new DocumentLineExpenseReportingViewModel()
                {
                    Designation = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    MNTHTString = CurrencyUtility.GenerateCurrencyByCulture(sumMNTHT, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                    MNTTVAString = CurrencyUtility.GenerateCurrencyByCulture(sumMNTTVA, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                    MNTTTCString = CurrencyUtility.GenerateCurrencyByCulture(sumMNTTTC, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                });
            }
            return documentLineResult;
        }



        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentWithoutDiscount(int idDocument, int printType, bool isBtoB)
        {
            Document document1 = _entityRepoDocument.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLinePrices).ThenInclude(x => x.IdPricesNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdTypeTiersNavigation)
                 .Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdPhoneNavigation)
                .Include(x => x.IdTiersNavigation).ThenInclude(x => x.Address)
                .Include(x => x.IdContactNavigation).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdBankAccountNavigation).ThenInclude(x => x.IdBankNavigation).Include(x => x.IdSettlementModeNavigation)
                .Include(x => x.IdCreatorNavigation)
                .Include(x => x.DocumentTaxsResume).ThenInclude(x => x.IdTaxNavigation)
                .Include(x => x.IdVehicleNavigation)
                .Where(x => x.Id == idDocument).FirstOrDefault();
            var document = SetDocumentWithoutDiscount(document1);
            DocumentReportingViewModel documentReportingViewModel = _documentReportingBuilder.BuildEntity(document);
            // Set type tiers
            documentReportingViewModel.LabelTypeTiers = document.IdTiersNavigation.IdTypeTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiersNavigation.Label : "";
            documentReportingViewModel.DocumentSymboleCurrency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty;
            documentReportingViewModel.DocumentCurrencyPresicion = (documentReportingViewModel.IdUsedCurrencyNavigation != null && documentReportingViewModel.DocumentTypeCode.Contains("SA")) ?
                documentReportingViewModel.IdUsedCurrencyNavigation.Precision : documentReportingViewModel.IdUsedCurrencyNavigation.Precision;

            // Get document type
            DocumentTypeViewModel documentTypeViewModel = _serviceDocumentType.GetModel(x => x.Code == documentReportingViewModel.DocumentTypeCode);
            // Get company
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            // Build company to CompanyReportingViewModel
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            if (isBtoB)
            {
                companyReportingViewModel.CompanyLogo = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "assets", "images", "logos", "logocompany.png");
            }


            double? vatRate = 0;
            string ContractCode = string.Empty;
            // Get vat rate and contract code
            if (document.DocumentLine != null && document.DocumentLine.Any())
            {
                vatRate = document.DocumentLine.ToList()[0].VatTaxRate * 100;
                if (document.DocumentLine.ToList()[0].DocumentLinePrices != null && document.DocumentLine.ToList()[0].DocumentLinePrices.Any())
                {
                    Prices price = document.DocumentLine.ToList()[0].DocumentLinePrices.ToList()[0].IdPricesNavigation;
                    if (price != null)
                    {
                        ContractCode = price.ContractCode;
                    }
                }
            }
            documentReportingViewModel.DocumentTotalBrut = documentReportingViewModel.DocumentTotalDiscountWithCurrency + documentReportingViewModel.DocumentHtpriceWithCurrency;
            var GroupedDocumentLine = GroupedTaxLine(document.DocumentTaxsResume.ToList(), document.IdUsedCurrencyNavigation.Precision, company.Culture);
            var GroupedDocumentLineCount = GroupedDocumentLine.Count;
            string AdressTiers = string.Empty;
            if (document.IdTiersNavigation != null && document.IdTiersNavigation.Address != null && document.IdTiersNavigation.Address.Any())
            {
                AdressTiers = document.IdTiersNavigation.Address.First().PrincipalAddress;
            }
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            ReportInformationsForDocumentViewModel reportInformationsForDocumentViewModel = new ReportInformationsForDocumentViewModel
            {
                AdressTiers = document.Adress != null ? document.Adress : string.Empty,
                IdCreator = document.IdCreatorNavigation?.FullName,
                Document = documentReportingViewModel,
                DateOfDoc = document.DocumentDate != null ? document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                DateTimeOfdoc = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) ? String.Format(GenericConstants.EN_FORMAT_DATE, document.DocumentDate) : String.Format(GenericConstants.FR_FORMAT_DATE, document.DocumentDate),
                InvoicingDate = document.DocumentInvoicingDate != null ? document.DocumentInvoicingDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                PrintType = PrintTypeTitle(printType),
                IsAsset = DocumentTypeTitle(document.DocumentTypeCode),
                IsNotValid = document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional,
                GroupedDocumentLine = GroupedDocumentLine,
                GroupedDocumentLine1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0] : new GroupedTaxLineViewModel(),
                GroupedDocumentLine2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1] : new GroupedTaxLineViewModel(),
                GroupedDocumentLineCount = GroupedDocumentLineCount,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) && documentTypeViewModel != null ? documentTypeViewModel.Label 
                : ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.English) && documentTypeViewModel != null ? documentTypeViewModel.LabelEn : string.Empty,
                Company = companyReportingViewModel,
                ContractCode = ContractCode,
                VatRate = vatRate != null ? CurrencyUtility.GenerateCurrencyByCulture(vatRate.Value, document.IdUsedCurrencyNavigation.Precision, "", company.Culture) : string.Empty,
                DocumentTotalBrut = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalBrut, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalDiscountWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalDiscountWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentHtpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentHtpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalVatTaxesWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalVatTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentOtherTaxesWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentOtherTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTtcpriceWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTtcpriceWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentPriceIncludeVatWithCurrency = CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentPriceIncludeVatWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture),
                DocumentTotalExcVatTaxesWithCurrency = documentReportingViewModel.DocumentTotalExcVatTaxesWithCurrency != 0 ?
                CurrencyUtility.GenerateCurrencyByCulture(documentReportingViewModel.DocumentTotalExcVatTaxesWithCurrency, document.IdUsedCurrencyNavigation.Precision, "", company.Culture) : string.Empty,
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                Reference = document.Reference != null ? document.Reference : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty,
                CompanyTel = companyReportingViewModel.CompanyTel,
                BankName = bankAccount != null && bankAccount.IdBankNavigation != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                AmountInLetter = document.AmountInLetter,
                BaseVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].BaseTVA : string.Empty,
                BaseVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].BaseTVA : string.Empty,
                BaseVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].BaseTVA : string.Empty,
                AmountVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].MontantTVA : string.Empty,
                AmountVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].MontantTVA : string.Empty,
                AmountVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].MontantTVA : string.Empty,
                TauxVat1 = GroupedDocumentLineCount > 0 ? GroupedDocumentLine[0].TauxTVA : string.Empty,
                TauxVat2 = GroupedDocumentLineCount > 1 ? GroupedDocumentLine[1].TauxTVA : string.Empty,
                TauxVat3 = GroupedDocumentLineCount > 2 ? GroupedDocumentLine[2].TauxTVA : string.Empty,
                CurrencyLabel = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                TelTiers = document.Tel1 != null ? document.Tel1 : string.Empty
            };
            return reportInformationsForDocumentViewModel;
        }




        public Document SetDocumentWithoutDiscount(Document document)
        {
            int discountValue = 0;
            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
            int companyPrecision = _serviceDocument.GetCompanyCurrencyPrecision();
            int tiersPrecision = _serviceDocument.GetPrecissionValue(document.IdUsedCurrency ?? 0, document.DocumentTypeCode);
            var documentTypeObject = _entityDocumentTypeRepo.GetSingle(x => x.Code == document.DocumentTypeCode);
            var ItemPrices = document.DocumentLine.Select(x => new ItemPriceViewModel
            {
                DocumentDate = x.IdDocumentNavigation.DocumentDate,
                DocumentLineViewModel = _documentLineBuilder.BuildEntity(x),
                DocumentType = x.IdDocumentNavigation.DocumentTypeCode,
                IdCurrency = x.IdDocumentNavigation.IdUsedCurrency ?? 0,
                IdTiers = x.IdDocumentNavigation.IdTiers ?? 0,
                Document = document,
                Tiers = document.IdTiersNavigation,
                CompanyPrecison = companyPrecision,
                TiersPrecison = tiersPrecision,
                exchangeRate = exchangeRate,
                DocumentTypeObject = documentTypeObject,
            }).ToList();

            List<DocumentLine> docLines = new List<DocumentLine>();
            List<DocumentLineViewModel> allDocLines = new List<DocumentLineViewModel>();
            List<DocumentLineTaxeViewModel> allDocLineTaxe = new List<DocumentLineTaxeViewModel>();
            List<DocumentLineTaxe> docTaxes = new List<DocumentLineTaxe>();
            foreach (var item in ItemPrices)
            {
                item.DocumentLineViewModel.DiscountPercentage = discountValue;
                _serviceDocument.GetDocumentLinePrice(item);
                _serviceDocument.CalculateDocumentLine(item,true);
                allDocLines.Add(item.DocumentLineViewModel);
            }
            allDocLineTaxe = allDocLines.SelectMany(x => x.DocumentLineTaxe).ToList();
            docTaxes= allDocLineTaxe.Select(x => _documentLineTaxeBuilder.BuildModel(x)).ToList();
            //allDocLines.Select(y=> y.DocumentLineTaxe).ToList().ForEach(x =>
            //{
            //    x. IdDocumentLineNavigation = null;
            //});
            docLines = allDocLines.Select(x=>  _documentLineBuilder.BuildModel(x)).ToList();
            document.DocumentLine = docLines;
            document.DocumentLine.ToList().ForEach(y =>
            {
                y.DocumentLineTaxe = docTaxes.Where(x => x.IdDocumentLine == y.Id).ToList();
            });
            DocumentViewModel documentViewModel = _documentBuilder.BuildEntity(document);
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
            List<DocumentTaxsResume> updatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
            _serviceDocument.CalculDocument(documentViewModel, updatedDocumentTaxsResumes, null, document, false) ;
            document =_documentBuilder.BuildModel(documentViewModel);
            List<int> idsTax = updatedDocumentTaxsResumes.Select(x => (int)x.IdTax).Distinct().ToList();
            List<Taxe> listTaxes = _entityTaxeRepo.GetAllWithConditionsRelationsAsNoTracking(x => idsTax.Contains(x.Id)).ToList();
            updatedDocumentTaxsResumes.ToList().ForEach(y =>
            {
                y.IdTaxNavigation = listTaxes.Where(x => x.Id == y.IdTax).FirstOrDefault();
            });
            document.DocumentTaxsResume = updatedDocumentTaxsResumes;
            return document;
        }


        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineWithoutDiscount(int idDocument)
        {
            Company company = _entityRepoCompany.GetSingleWithRelations(x => true);
            List<DocumentLine> documentLines = _entityRepoDocumentLine.QuerableGetAll().Where(x => x.IdDocument == idDocument).
                Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdUsedCurrencyNavigation).Include(x => x.IdMeasureUnitNavigation).
                Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemWarehouse).ThenInclude(x => x.IdWarehouseNavigation).
                Include(x => x.IdItemNavigation).ThenInclude(x=>x.IdProductItemNavigation).
                Include(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).ToList();
            int currency = 0;
            List<DocumentLine> documentLinesReportingViewModel =  setDocumentLineWithoutDiscount(documentLines);
            IList<DocumentLineReportingViewModel> listDocLineReport = new List<DocumentLineReportingViewModel>();
            Document doc = documentLines.First().IdDocumentNavigation;
            foreach (var documenLineViewModel in documentLinesReportingViewModel)
            {
                documenLineViewModel.IdDocumentNavigation = doc;
                documenLineViewModel.IdItemNavigation = documentLines.Where(z => z.Id == documenLineViewModel.Id).FirstOrDefault().IdItemNavigation;

                if (currency == 0)
                {
                    currency = documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation != null? documenLineViewModel.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision : 3 ;

                }
                if (documenLineViewModel.UnitPriceFromQuotation != null && !documenLineViewModel.UnitPriceFromQuotation.Value.Equals(0))
                {
                    documenLineViewModel.HtUnitAmountWithCurrency = documenLineViewModel.UnitPriceFromQuotation;
                }
                documenLineViewModel.VatTaxRate *= 100;
            }
            List<int> idTaxes = new List<int>();
            idTaxes = documentLinesReportingViewModel.SelectMany(y => y.DocumentLineTaxe).Select(y => y.IdTaxe).Distinct().ToList();
            List<Taxe> listTaxes = _entityTaxeRepo.FindByAsNoTracking(z => idTaxes.Contains(z.Id)).ToList();
            listDocLineReport = documentLinesReportingViewModel.Select(x => _documentLineReportingBuilder.BuildEntity(x, listTaxes, company))
                .OrderBy(p => p.ShelfAndStorage).ThenBy(p => p.CodeArticle).ToList();
            return listDocLineReport;
        }

        public List<DocumentLine> setDocumentLineWithoutDiscount(List<DocumentLine> doclines)
        {
            int discountValue = 0;
            Document doc = doclines.First().IdDocumentNavigation;
            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(doc.IdUsedCurrency ?? 0, doc.DocumentDate, doc.ExchangeRate);
            int companyPrecision = _serviceDocument.GetCompanyCurrencyPrecision();
            int tiersPrecision = _serviceDocument.GetPrecissionValue(doc.IdUsedCurrency ?? 0, doc.DocumentTypeCode);
            DocumentType documentTypeObject = _entityDocumentTypeRepo.GetSingle(x => x.Code == doc.DocumentTypeCode);
            List<ItemPriceViewModel> ItemPrices = doclines.Select(x => new ItemPriceViewModel
            {
                DocumentDate = doc.DocumentDate,
                DocumentLineViewModel = _documentLineBuilder.BuildEntity(x),
                DocumentType = doc.DocumentTypeCode,
                IdCurrency = doc.IdUsedCurrency ?? 0,
                IdTiers = doc.IdTiers ?? 0,
                Document = doc,
                Tiers = doc.IdTiersNavigation?? null,
                CompanyPrecison = companyPrecision,
                TiersPrecison = tiersPrecision,
                exchangeRate = exchangeRate,
                DocumentTypeObject = documentTypeObject,
            }).ToList();

            List<DocumentLine> docLinesEntity = new List<DocumentLine>();
            List<DocumentLineViewModel> allDocLines = new List<DocumentLineViewModel>();
            foreach (var item in ItemPrices)
            {
                item.DocumentLineViewModel.DiscountPercentage = discountValue;
                _serviceDocument.GetDocumentLinePrice(item);
                _serviceDocument.CalculateDocumentLine(item,true);
                allDocLines.Add(item.DocumentLineViewModel);
            }
            docLinesEntity = allDocLines.Select(x => _documentLineBuilder.BuildModel(x)).ToList();
            return docLinesEntity;
        }

        public IList<PurchaseDeliveryTagViewModel> GetTagListOfPurchaseDelivery(string DataToPrint)
        {
            List<PurchaseDeliveryTagViewModel> result = new List<PurchaseDeliveryTagViewModel>();
            //List<string> lineQty = DataToPrint.Split(',').ToList();
            List<dynamic> listOfLines = new List<dynamic>();
            // lineQty.ForEach(line =>
            //{
            //    dynamic MyDynamic = new ExpandoObject();
            //    var qtyAndIdLine = line.Split('-');
            //    MyDynamic.IdLine = qtyAndIdLine[0];
            //    MyDynamic.Qty = qtyAndIdLine[1];
            //    listOfLines.Add(MyDynamic);
            //});

            string lineQty = DataToPrint.Split(',').First();
            dynamic MyDynamic = new ExpandoObject();
            var qtyAndIdLine = lineQty.Split('-');
            MyDynamic.IdLine = qtyAndIdLine[0];
            MyDynamic.Qty = qtyAndIdLine[1];
            listOfLines.Add(MyDynamic);
            List<int> allLinesIds = listOfLines.Select(x => (int)int.Parse(x.IdLine)).ToList();
            List<DocumentLine> Lines = _entityRepoDocumentLine.GetAllWithConditionsRelationsQueryable(x => allLinesIds.Contains(x.Id))
               .Include(y => y.IdItemNavigation).ThenInclude(y => y.IdProductItemNavigation)
               .Include(y => y.IdItemNavigation).ThenInclude(y => y.OemItem)
               .Include(y => y.IdItemNavigation).ThenInclude(y => y.ItemWarehouse).ThenInclude(y=> y.IdWarehouseNavigation)
               .Include(y => y.IdItemNavigation).ThenInclude(y => y.ItemWarehouse).ThenInclude(y => y.IdStorageNavigation).ThenInclude(y=> y.IdShelfNavigation).
               Include(y => y.IdDocumentNavigation).ThenInclude(y => y.IdTiersNavigation).ToList();
            Lines.ForEach(line =>
            {
                PurchaseDeliveryTagViewModel tag = new PurchaseDeliveryTagViewModel()
                {
                    Date = line.IdDocumentNavigation.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language), 
                    ItemCode = line.IdItemNavigation.Code,
                    ItemLabel = line.IdItemNavigation.Description,
                    ProductName = line.IdItemNavigation.IdProductItemNavigation != null ? line.IdItemNavigation.IdProductItemNavigation.CodeProduct : null,
                    PurchaseDeliveryCode = line.IdDocumentNavigation.Code,
                    SupplierCode = line.IdDocumentNavigation.IdTiersNavigation.CodeTiers,
                    BarCode = line.IdItemNavigation.BarCode1D != null  ? line.IdItemNavigation.BarCode1D : null ,
                    OemCode = line.IdItemNavigation.OemItem != null && line.IdItemNavigation.OemItem.Any() ? line.IdItemNavigation.OemItem.Last().OemNumber : null,
                    Warehouse = line .IdWarehouse != null ?line.IdItemNavigation.ItemWarehouse.Where(x=> x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdWarehouseNavigation.WarehouseName : null,
                    Shelf = line.IdWarehouse != null  && line.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdStorageNavigation != null &&
                    line.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdStorageNavigation.IdShelfNavigation != null  ?
                            line.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdStorageNavigation.IdShelfNavigation.Label : null,
                    Storage = line.IdWarehouse != null && line.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdStorageNavigation != null ?
                            line.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == line.IdWarehouse).FirstOrDefault().IdStorageNavigation.Label : null,

                };
                result.Add(tag);
            });
            return result;
        }

        #endregion
    }
}
