using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace Services.Reporting.Classes
{
    /// <summary>
    /// This service provide informations for Telerik report
    /// </summary>
    public class ServiceReporting : IServiceReporting
    {
        #region Fields
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<ItemWarehouse> _entityRepoItemWareHouse;
        private readonly IRepository<Warehouse> _entityRepoWareHouse;
        private readonly IRepository<Document> _entityRepoDocument;
        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IRepository<DocumentLineTaxe> _entityRepoDocumentLineTaxe;
        private readonly IRepository<Address> _repoEntityAddress;
        private readonly IRepository<Settlement> _repoEntitySettlement;
        private readonly IRepository<Currency> _repoEntityCurrency;
        private readonly IRepository<DocumentType> _repoEntityDocumentType;
        private readonly IRepository<Tiers> _repoEntityTiers;
        private readonly IRepository<DocumentLine> _repoEntityDocLine;
        private readonly IRepository<StockDocument> _repoEntityStockDocument;
        private readonly IDocumentLineBuilder _builderDocLine;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IRepository<CurrencyRate> _entityRepoCurrencyRate;
        private readonly IServiceStockDocument _serviceStockDocument;
        private readonly IRepository<Taxe> _repoEntityTaxe;
        private readonly AppSettings _appSettings;
        private readonly IServiceDocument _serviceDocument;
        private readonly IRepository<BankAccount> _repoBankAccount;


        #endregion
        #region Constructor

        public ServiceReporting(IUnitOfWork unitOfWork, IRepository<StockDocument> repoEntityStockDocument, IDocumentLineBuilder builderDocLine, IServiceCompany serviceCompany,
            IRepository<DocumentLine> repoEntityDocLine,
            IRepository<Tiers> repoEntityTiers, IRepository<DocumentType> repoEntityDocumentType,
            IRepository<Currency> repoEntityCurrency, IRepository<Settlement> repoEntitySettlement,
            IRepository<Document> entityRepoDocument, IRepository<Address> repoEntityAddress,
            IRepository<DocumentLine> entityRepoDocumentLine,
            IRepository<DocumentLineTaxe> entityRepoDocumentLineTaxe,
            IRepository<ItemWarehouse> entityRepoItemWareHouse, IRepository<Warehouse> entityRepoWareHouse, IRepository<CurrencyRate> entityRepoCurrencyRate,
            IServiceStockDocument serviceStockDocument, IRepository<Taxe> repoEntityTaxe, IServiceDocument serviceDocument, IRepository<BankAccount> repoBankAccount)
        {
            _repoEntityDocLine = repoEntityDocLine;
            _serviceCompany = serviceCompany;
            _repoEntityTiers = repoEntityTiers;
            _repoEntityDocumentType = repoEntityDocumentType;
            _repoEntityCurrency = repoEntityCurrency;
            _entityRepoItemWareHouse = entityRepoItemWareHouse;
            _entityRepoWareHouse = entityRepoWareHouse;
            _repoEntitySettlement = repoEntitySettlement;
            _entityRepoDocument = entityRepoDocument;
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _entityRepoDocumentLineTaxe = entityRepoDocumentLineTaxe;
            _repoEntityAddress = repoEntityAddress;
            _builderDocLine = builderDocLine;
            _repoEntityStockDocument = repoEntityStockDocument;
            _unitOfWork = unitOfWork;
            _entityRepoCurrencyRate = entityRepoCurrencyRate;
            _serviceStockDocument = serviceStockDocument;
            _repoEntityTaxe = repoEntityTaxe;
            _serviceDocument = serviceDocument;
            _repoBankAccount = repoBankAccount;
        }
        #endregion
        #region Methodes
        public IEnumerable<DocumentLineViewModel> ListReportDocumentLines(int idDocument)
        {
            var documentLine = _repoEntityDocLine.FindBy(x => x.IdDocument == idDocument).Select(y => _builderDocLine.BuildEntity(y));

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
            Document document = _entityRepoDocument.GetSingle(x => x.Id == idDocument);
            var tiers = _repoEntityTiers.GetSingleWithRelations(x => x.Id == document.IdTiers, x => x.Contact);
            var contact = tiers.Contact.FirstOrDefault(x => x.Id == document.IdContact);
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var addressTiers = tiers.Address != null ? tiers.Address.FirstOrDefault() : null;
            var city = address.IdCityNavigation;
            var country = address.IdCountryNavigation;
            var currency = _repoEntityCurrency.GetSingle(x => x.Id == document.IdUsedCurrency);
            //BankAccountViewModel bankAccount = document.IdBankAccount != null ? company.BankAccount.FirstOrDefault(x => x.Id == document.IdBankAccount) : null;
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
                CompanyLogo = company != null ? company.PictureFileInfo.FulPathReportingImage : string.Empty,
                //TVA = company.TVA
                VATNumberCompany = company != null ? company.VatNumber : string.Empty,
                //document
                DocumentDate = document != null ? document.DocumentDate : default,
                DocumentCode = document != null ? document.Code : default,
                DocumentTypeLabel = ActiveAccountHelper.GetConnectedUserCredential().Language == "fr" ? _repoEntityDocumentType.GetSingle(x => x.Code == document.DocumentTypeCode).Label
                :  _repoEntityDocumentType.GetSingle(x => x.Code == document.DocumentTypeCode).LabelEn,
                DocumentTypeCode = document.DocumentTypeCode,
                DocumentTotalDiscountWithCurrency = document.DocumentTotalDiscountWithCurrency,
                DocumentHtpriceWithCurrency = document.DocumentHtpriceWithCurrency,
                DocumentPriceIncludeVatWithCurrency = document.DocumentPriceIncludeVatwithCurrency,
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
                //IbanBankAccount = bankAccount != null ? bankAccount.Iban : string.Empty,
                //BicBankAccount = bankAccount != null ? bankAccount.Bic : string.Empty,
            };
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentInformationLines(int idStockDocument)
        { 
            return GetStockDocumentLines(idStockDocument,false).ToList();
        }



        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentLines(int idInventoryDocument, bool condition)
         {
            try
            {
                var doc = _repoEntityStockDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idInventoryDocument).ToList();
                if (doc == null)
                {
                    throw new CustomException(CustomStatusCode.CantUpdateDeletedInventory);
                }
                var relationpredicate = new Expression<Func<StockDocumentLine, object>>[] {
                x => x.IdWarehouseNavigation,
                x => x.IdItemNavigation.IdNatureNavigation,
                x=> x.IdItemNavigation.ItemWarehouse,
                x => x.IdStockDocumentNavigation,
                x => x.IdStockDocumentNavigation.IdWarehouseSourceNavigation,
                x => x.IdStockDocumentNavigation.IdWarehouseDestinationNavigation
            };

                var query = _unitOfWork.SetWithRelationsAsNoTracking(relationpredicate);
                query = query.Where(x => x.IdStockDocument == idInventoryDocument);
                if (condition)
                {
                    query = query.Where((c) => c.ForecastQuantity.HasValue && c.ActualQuantity.HasValue && Convert.ToInt32(c.ForecastQuantity.Value - c.ActualQuantity.Value) != 0);
                }
                List<StockDocumentLine> alldata = query.ToList();
                int idFiltredWarehouse = 0;
                if (alldata != null && alldata.Any())
                {

                    if (alldata[0].IdStockDocumentNavigation != null && alldata[0].IdStockDocumentNavigation.IdWarehouseSource != null)
                    {
                        idFiltredWarehouse = (int)alldata[0].IdStockDocumentNavigation.IdWarehouseSource;
                    }

                }

                IList<StockDocumentLineInventoryReportViewModel> listOfStockDocLine = alldata.Select(a =>
                {
                    string ShelfAndStorage = "";
                    ItemWarehouse itemWarehouse = idFiltredWarehouse != 0 ? a.IdItemNavigation.ItemWarehouse.Where(y => y.IdWarehouse == idFiltredWarehouse).FirstOrDefault() :
                    a.IdItemNavigation.ItemWarehouse.Where(y => y.IdWarehouse == a.IdWarehouse).FirstOrDefault();
                    if (itemWarehouse != null)
                    {
                        ShelfAndStorage = itemWarehouse.Shelf != null || itemWarehouse.Storage != null ? string.Concat(itemWarehouse.Shelf, itemWarehouse.Storage) : " ";
                    }
                    return new StockDocumentLineInventoryReportViewModel
                    {
                        Reference = a.IdItemNavigation.Code,
                        Designation = a.IdItemNavigation.Description,
                        DocumentDate = a.IdStockDocumentNavigation.DocumentDate.Value.ToUniversalTime(),
                        DocumentDateString = a.IdStockDocumentNavigation.DocumentDate.Value.ToUniversalTime().Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                        ArticleName = new StringBuilder(a.IdItemNavigation.Code).Append(" ").Append(a.IdItemNavigation.Description).ToString(),
                        IdStockDocument = a.IdStockDocument,
                        ActualQuantity = a.ActualQuantity,
                        ForecastQuantity = a.ForecastQuantity,
                        IdItem = a.IdItem,
                        WarehouseCode = idFiltredWarehouse != 0 && a.IdStockDocumentNavigation.IdWarehouseSourceNavigation != null ? a.IdStockDocumentNavigation.IdWarehouseSourceNavigation.WarehouseCode : a.IdWarehouseNavigation != null ?a.IdWarehouseNavigation.WarehouseCode : string.Empty,
                        WarehouseName = idFiltredWarehouse != 0 && a.IdStockDocumentNavigation.IdWarehouseSourceNavigation != null ? a.IdStockDocumentNavigation.IdWarehouseSourceNavigation.WarehouseName : a.IdWarehouseNavigation != null ? a.IdWarehouseNavigation.WarehouseName: string.Empty,
                        ShelfName = ShelfAndStorage,
                        Ecart = (a.ForecastQuantity.HasValue && a.ActualQuantity.HasValue) ? ((a.ForecastQuantity.Value - a.ActualQuantity.Value) > 0 ? string.Concat("+", (a.ForecastQuantity.Value - a.ActualQuantity.Value).ToString()) : (a.ForecastQuantity.Value - a.ActualQuantity.Value).ToString()) : string.Empty,
                        Ecart2 = (a.ForecastQuantity2.HasValue && a.ActualQuantity.HasValue) ? ((a.ForecastQuantity2.Value - a.ActualQuantity.Value) > 0 ? string.Concat("+", (a.ForecastQuantity2.Value - a.ActualQuantity.Value).ToString()) : (a.ForecastQuantity2.Value - a.ActualQuantity.Value).ToString()) : string.Empty
                    };

                }).OrderBy(y => y.WarehouseName).ThenBy(z => z.ShelfName).ToList();
                return listOfStockDocLine;
            }
            catch (Exception e)
            {
                // thorw the original exception
                throw e;
            }
        }

        /// <summary>
        /// Get inventory information
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public StockDocumentInventoryReportViewModel GetStockDocumentInformation(int idStockDocument)
        {
            return GetStockDocument(idStockDocument);
        }


        /// <summary>
        /// return inventory information by id
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public StockDocumentInventoryReportViewModel GetStockDocument(int idInventoryDocument)
        {
            try
            {
                var company = _serviceCompany.GetCurrentCompany();
                var address = company.Address != null ? company.Address.FirstOrDefault() : null;
                var relationpredicate = new Expression<Func<StockDocument, object>>[] { x => x.IdWarehouseSourceNavigation, y => y.IdTiersNavigation, z => z.StockDocumentLine };
                var alldata = _repoEntityStockDocument.GetAllWithConditionsRelationsQueryable(x => x.Id == idInventoryDocument, relationpredicate).FirstOrDefault();
                ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
                BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
                if (alldata != null)
                {
                    /*int ecartList = alldata.StockDocumentLine.Where(x => x.ActualQuantity - x.ForecastQuantity != 0).Count();
                    if (ecartList == 0)
                    {
                        throw new CustomException(CustomStatusCode.AddExistingInventory);
                    }*/
                    var StockDoc = new StockDocumentInventoryReportViewModel()
                    {
                        DocumentCode = alldata != null ?alldata.Code : string.Empty,
                        DocumentDate = alldata != null ?alldata.DocumentDate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                        DocumentDateString = alldata.DocumentDate.Value.ToUniversalTime().Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                        PrintedDate = DateTime.Now.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                        WarehouseCode = alldata.Code,
                        WarehouseName = alldata.IdWarehouseSourceNavigation != null ? alldata.IdWarehouseSourceNavigation.WarehouseName : string.Empty,
                        SupplierName = alldata.IdTiersNavigation != null ? alldata.IdTiersNavigation.Name : string.Empty,
                        InventoryType = alldata.IdWarehouseSourceNavigation != null ? "PerWareHouse" : "PerSupplier",
                        Company = companyReportingViewModel,
                        WebSite = company.WebSite ?? string.Empty,
                        StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                        StarkLogo = _serviceCompany.GetStarkLogo(),
                        BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                        Rib = bankAccount != null ? bankAccount.Rib : string.Empty
                    };
                    return StockDoc;
                }
                else
                {
                    return new StockDocumentInventoryReportViewModel();
                }
            }
            catch (CustomException e)
            {
                throw e;
            }
        }

        /// <summary>
        /// Get inventory gain lines
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentLinesEcart(int idStockDocument)
        {
            return GetStockDocumentLines(idStockDocument,true).ToList();
        }

        /// <summary>
        /// Get multi inventories informations
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public StockDocumentInventoryReportViewModel GetMultiStockDocumentsInformations(string idStockDocument)
        {
            return GetMultiStockDocuments(idStockDocument);
        }


        /// <summary>
        /// return multi inventories informations by ids
        /// </summary>
        /// <param name="idInventoriesDocument"></param>
        /// <returns></returns>
        public StockDocumentInventoryReportViewModel GetMultiStockDocuments(string idInventoriesDocument)
        {
            List<int> selectedInventoriesIds = idInventoriesDocument.Split(GenericConstants.Semicolon).ToList().ConvertAll(int.Parse);
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var relationpredicate = new Expression<Func<StockDocument, object>>[] { x => x.IdWarehouseSourceNavigation };
            var alldata = _repoEntityStockDocument.GetAllWithConditionsRelationsQueryable(x => selectedInventoriesIds.Contains(x.Id), relationpredicate);
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            if (alldata != null)
            {
                var StockDoc = new StockDocumentInventoryReportViewModel()
                {
                    PrintedDate = DateTime.Now.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                    Company = companyReportingViewModel,
                    StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                    StarkLogo = _serviceCompany.GetStarkLogo(),
                    BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                    Rib = bankAccount != null ? bankAccount.Rib : string.Empty
                };
                return StockDoc;
            }
            else
            {
                return new StockDocumentInventoryReportViewModel();
            }
        }

        /// <summary>
        /// Get multi inventories gain lines
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesGain(string idStockDocument)
        {
            Func<StockDocumentLine, bool> ecartGainCondition = (c) => (c.ForecastQuantity.HasValue && c.ActualQuantity.HasValue) ? Convert.ToInt32(c.ForecastQuantity.Value - c.ActualQuantity.Value) > 0 : false;
            return GetMultiStockDocumentLines(idStockDocument, ecartGainCondition).ToList();
        }

        /// <summary>
        /// Get multi inventories loss lines
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesLoss(string idStockDocument)
        {
            Func<StockDocumentLine, bool> ecartLossCondition = (c) => (c.ForecastQuantity.HasValue && c.ActualQuantity.HasValue) ? Convert.ToInt32(c.ForecastQuantity.Value - c.ActualQuantity.Value) < 0 : false;
            return GetMultiStockDocumentLines(idStockDocument, ecartLossCondition).ToList();
        }

        /// <summary>
        /// return list of stock document where condition
        /// </summary>
        /// <param name="idInventoriesDocument"></param>
        /// <param name="condition"></param>
        /// <returns></returns>
        public IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLines(string idInventoriesDocument, Func<StockDocumentLine, bool> ecartCondition)
        {
            List<int> selectedInventoriesIds = idInventoriesDocument.Split(GenericConstants.Semicolon).ToList().ConvertAll(int.Parse);
            var relationpredicate = new Expression<Func<StockDocumentLine, object>>[] {
                x => x.IdWarehouseNavigation,
                x => x.IdItemNavigation.IdNatureNavigation,
                x=> x.IdItemNavigation.ItemWarehouse,
                x => x.IdStockDocumentNavigation,
                x => x.IdStockDocumentNavigation.IdWarehouseSourceNavigation,
                x => x.IdStockDocumentNavigation.IdWarehouseDestinationNavigation
            };
            var query = _unitOfWork.SetWithRelationsAsNoTracking(relationpredicate);
            //List<StockDocumentLine> alldata = query.Where(x => x.IdStockDocument == idInventoryDocument).ToList();

            List<StockDocumentLine> alldata = null;
            if (ecartCondition!=null)
            {
                alldata = query.Where(x => selectedInventoriesIds.Contains(x.IdStockDocument)).Where(ecartCondition).ToList();

                //alldata = query.Where(x => selectedInventoriesIds.Contains(x.IdStockDocument))
                //    .Where((c) => c.ForecastQuantity.HasValue && c.ActualQuantity.HasValue && Convert.ToInt32(c.ForecastQuantity.Value - c.ActualQuantity.Value) != 0).ToList();
            }
            else
            {
                alldata = query.ToList();
            }

           // List<StockDocumentLine> alldata = query.Where(x => selectedInventoriesIds.Contains(x.IdStockDocument) && ecartCondition(x)).ToList();
           int idFiltredWarehouse = 0;
            if (alldata != null && alldata.Any())
            {
                if (alldata[0].IdStockDocumentNavigation != null && alldata[0].IdStockDocumentNavigation.IdWarehouseSource != null)
                {
                    idFiltredWarehouse = (int)alldata[0].IdStockDocumentNavigation.IdWarehouseSource;
                }
            }
            IList<StockDocumentLineInventoryReportViewModel> listOfStockDocLine = alldata.Select(a =>
            {
                string ShelfAndStorage = "";
                ItemWarehouse itemWarehouse = idFiltredWarehouse != 0 ? a.IdItemNavigation.ItemWarehouse.Where(y => y.IdWarehouse == idFiltredWarehouse).FirstOrDefault() :
                a.IdItemNavigation.ItemWarehouse.Where(y => y.IdWarehouse == a.IdWarehouse).FirstOrDefault();
                if (itemWarehouse != null)
                {
                    ShelfAndStorage = itemWarehouse.Shelf != null || itemWarehouse.Storage != null ? string.Concat(itemWarehouse.Shelf, itemWarehouse.Storage) : " ";
                }
                return new StockDocumentLineInventoryReportViewModel
                {
                    Reference = a.IdItemNavigation.Code ,
                    Designation = a.IdItemNavigation.Description,
                    DocumentDate =  a.IdStockDocumentNavigation.DocumentDate.Value.ToUniversalTime(),
                    DocumentDateString = a.IdStockDocumentNavigation.DocumentDate!= null ? a.IdStockDocumentNavigation.DocumentDate.Value.ToUniversalTime().ToString("dd/MM/yyyy") : string.Empty,
                    ArticleName = new StringBuilder(a.IdItemNavigation.Code).Append(" ").Append(a.IdItemNavigation.Description).ToString(),
                    IdStockDocument =  a.IdStockDocument ,
                    ActualQuantity = a.ActualQuantity ,
                    ForecastQuantity =   a.ForecastQuantity ,
                    IdItem = a.IdItem,
                    WarehouseCode = idFiltredWarehouse != 0 && a.IdStockDocumentNavigation.IdWarehouseSourceNavigation != null? a.IdStockDocumentNavigation.IdWarehouseSourceNavigation.WarehouseCode : a.IdWarehouseNavigation != null ? a.IdWarehouseNavigation.WarehouseCode : string.Empty ,
                    WarehouseName = idFiltredWarehouse != 0 && a.IdStockDocumentNavigation.IdWarehouseSourceNavigation != null ? a.IdStockDocumentNavigation.IdWarehouseSourceNavigation.WarehouseName : a.IdWarehouseNavigation != null ? a.IdWarehouseNavigation.WarehouseName : string.Empty,
                    ShelfName = ShelfAndStorage,
                    Ecart = (a.ForecastQuantity.HasValue && a.ActualQuantity.HasValue) ? (a.ForecastQuantity.Value - a.ActualQuantity.Value).ToString() : string.Empty,
                    UnitHtpurchasePrice = a.IdItemNavigation != null && a.IdItemNavigation.UnitHtpurchasePrice.HasValue ? a.IdItemNavigation.UnitHtpurchasePrice.Value.ToString() : string.Empty,
                    UnitHtsalePrice = a.IdItemNavigation != null && a.IdItemNavigation.UnitHtsalePrice.HasValue ? a.IdItemNavigation.UnitHtsalePrice.Value.ToString() : string.Empty
                };
            }).OrderBy(y => y.WarehouseName).ThenBy(z => z.ShelfName).ToList();
            return listOfStockDocLine;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idwarehouse"></param>
        /// <param name="startdate"></param>
        /// <param name="endate"></param>
        /// <returns></returns>
        public DailySalesReportViewModel GetDailySalesInformation(int idwarehouse, DateTime? startdate, DateTime? endate)
        {
            return GetDailySales(idwarehouse, startdate, endate);
        }
        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public DailySalesReportViewModel GetDailySales(int idwarehouse, DateTime? startdate, DateTime? endate)
        {
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var relationpredicate = new Expression<Func<StockDocument, object>>[] { x => x.IdWarehouseSourceNavigation };
            var warehousedata = idwarehouse == -1 ? null : _entityRepoWareHouse.GetSingleNotTracked(x => x.Id == idwarehouse);
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            return new DailySalesReportViewModel
            {
                DateDuAu = "Du " + (startdate != null ? new DateTime(startdate.Value.Year, startdate.Value.Month, startdate.Value.Day).Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language)
                : "-") + " au " + (endate != null ? new DateTime(endate.Value.Year, endate.Value.Month, endate.Value.Day).Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language)
                : "-"),
                DocumentDate = startdate,
                PrintedDate = startdate,
                WarehouseCode = warehousedata != null ? warehousedata.WarehouseCode : "Tous les dépôts",
                WarehouseName = warehousedata != null ? warehousedata.WarehouseName : "Tous les dépôts",
                Company = companyReportingViewModel,
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public IList<DailySalesDeliveryLineReportViewModel> GetDailySalesDeliveryLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listresult = GetSalesDeliveryDailyDocumentLineList(DailySalesQuery);
            return listresult == null ? new List<DailySalesDeliveryLineReportViewModel>() : listresult.ToList();
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<DailySalesDeliveryLineReportViewModel> GetSalesDeliveryDailyDocumentLineList(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            var queryrequest = _entityRepoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x =>
                   (x.DocumentTypeCode == DocumentEnumerator.SalesDelivery || x.DocumentTypeCode == DocumentEnumerator.SalesAsset)
                  && (DailySalesQuery.IdTiers != -1 ? x.IdTiers == DailySalesQuery.IdTiers : true)
                   && (DailySalesQuery.IdStatus != -1 ? x.IdDocumentStatus == DailySalesQuery.IdStatus : true)
                   , x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation);
            if (DailySalesQuery.StartDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.StartDate.Value) >= 0);
            }
            if (DailySalesQuery.EndDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.EndDate.Value) <= 0);
            }
            queryrequest = queryrequest.Include(x => x.DocumentLine).ThenInclude(x => x.IdItemNavigation);
            var allSaleDocument = queryrequest?.ToList();
            if (allSaleDocument != null && allSaleDocument.Any())
            {
                allSaleDocument.ForEach(x =>
                {
                    x.DocumentLine.ToList().ForEach(y =>
                    {
                        listModel.Add(new DailySalesDeliveryLineReportViewModel
                        {
                            IdTiers = x.IdTiers,
                            DocumentType = x.DocumentTypeCode,
                            CodeDocument = x.Code,
                            ClientCode = x.IdTiersNavigation.CodeTiers,
                            ClientName = x.IdTiersNavigation.Name,
                            DocumentDate = x.DocumentDate,
                            Reference = y.IdItemNavigation != null ? y.IdItemNavigation.Code : string.Empty,
                            ArticleName = y.IdItemNavigation != null ? y.IdItemNavigation.Description : string.Empty,
                            SoldQuantity = y.MovementQty,
                            HtAmount = CurrencyUtility.GenerateCurrencyByCulture(y.HtAmountWithCurrency.GetValueOrDefault(), x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture),
                            TtcAmount = CurrencyUtility.GenerateCurrencyByCulture(y.TtcTotalLineWithCurrency.GetValueOrDefault(), x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture),
                            BLDate = x.DocumentDate,
                            BLDateString = x.DocumentDate != null ? x.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                            BLHtAmount = x.DocumentHtpriceWithCurrency,
                            BLTtcAmount = x.DocumentTypeCode == DocumentEnumerator.SalesDelivery ? x.DocumentTtcpriceWithCurrency : 0,
                            AssetTtcAmount = x.DocumentTypeCode == DocumentEnumerator.SalesAsset ? x.DocumentTtcpriceWithCurrency : 0,
                        });

                    });

                });
            }
            else
            {
                listModel = null;
            }

            return listModel?.OrderBy(x => x.DocumentType).ThenBy(x => x.CodeDocument).ToList();
        }
        public static List<Document> FilterDocByType(DailySalesDeliveryReportQueryViewModel DailySalesQuery, List<Document> queryrequest)
        {
            var slength = DailySalesQuery.IdType.Length - 2 <= 0 ? 1 : DailySalesQuery.IdType.Length - 2;
            var stringType = slength > 2 && DailySalesQuery.IdType.Contains('[') && DailySalesQuery.IdType.Contains(']') ?
                DailySalesQuery.IdType.Substring(1, slength).Trim().Split(',') : DailySalesQuery.IdType.Trim().Split(',');
            int[] dataType = stringType.Length <= 1 && string.IsNullOrWhiteSpace(stringType[0]) ? null : Array.ConvertAll(stringType, (f => int.Parse(f)));

            List<Document> queryResult = new List<Document>();
            if (dataType != null && dataType.Length > 0 && !dataType.Contains(-1))
            {
                foreach (var item in dataType)
                {
                    switch (item)
                    {
                        case (int)DocumentTypesEnumerator.SUPPLIER_ASSET:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset));
                            queryrequest = queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset).ToList();
                            break;
                        case (int)DocumentTypesEnumerator.CUSTOMER_ASSET:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset));
                            break;
                        case (int)DocumentTypesEnumerator.BE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.BE));
                            break;
                        case (int)DocumentTypesEnumerator.BS:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.BS));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_QUOTATION:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseBudget));
                            break;
                        case (int)DocumentTypesEnumerator.RECEIPT:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery));
                            break;
                        case (int)DocumentTypesEnumerator.DELIVERY_FORM:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_FINAL_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseOrder));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesOrder));
                            break;
                        case (int)DocumentTypesEnumerator.PRICE_REQUEST:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseQuotation));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_QUOTATION:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesQuotation));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_REQUEST:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseRequest));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_TERMBILLING_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 2));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_TERMBILLING_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 2));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ASSET_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 3));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ASSET_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 3));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_CASH_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 1));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_CASH_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 1));
                            break;
                        default:
                            queryResult.AddRange(queryrequest);
                            break;
                    }
                }
            }
            else
            {
                queryResult.AddRange(queryrequest);
            }

            return queryResult;
        }


        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<DocumentControlStatusLineReportViewModel> GetDocumentControlStatusLineList(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listModel = new List<DocumentControlStatusLineReportViewModel>();
            var queryrequest = _entityRepoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x =>
                   (DailySalesQuery.IdTiers != -1 ? x.IdTiers == DailySalesQuery.IdTiers : true) && x.DocumentTypeCode != DocumentEnumerator.PurchaseRequest
                   && (DailySalesQuery.IdStatus != -1 ? x.IdDocumentStatus == DailySalesQuery.IdStatus : true)
                   , x => x.IdTiersNavigation, x => x.IdDocumentStatusNavigation);



            if (DailySalesQuery.StartDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.StartDate.Value) >= 0);
            }
            if (DailySalesQuery.EndDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.EndDate.Value) <= 0);
            }



            var allSaleDocument = FilterDocByType(DailySalesQuery, queryrequest.ToList());
            if (allSaleDocument != null && allSaleDocument.Any())
            {
                List<int> lisIdsCurrency = allSaleDocument.Select(x => (int)x.IdTiersNavigation.IdCurrency).ToList();
                List<Currency> listOfCurrency = _repoEntityCurrency.GetAllWithConditions(x => lisIdsCurrency.Contains(x.Id)).ToList();

                allSaleDocument.ForEach(x =>
                {
                    Currency currentCurrency = listOfCurrency.Where(y => y.Id == (int)x.IdTiersNavigation.IdCurrency).First();
                    listModel.Add(new DocumentControlStatusLineReportViewModel
                    {
                        IdTiers = x.IdTiers,
                        DocumentType = x.DocumentTypeCode,
                        DocumentStatus = x.IdDocumentStatusNavigation?.Label,
                        DocumentCode = x.Code,
                        ClientCode = x.IdTiersNavigation?.CodeTiers,
                        ClientName = x.IdTiersNavigation?.Name,
                        DocumentDate = x.DocumentDate,
                        DocumentDateString = x.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                        BLDate = x.DocumentDate,
                        BLTtcAmount = AmountMethods.FormatValue(x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero, currentCurrency != null ? currentCurrency.Precision : 3),
                        BLTtcAmountString = AmountMethods.FormatValueString(x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero, currentCurrency != null ? currentCurrency.Precision : 3),
                        BLNetHTAmount = AmountMethods.FormatValue(x.DocumentHtpriceWithCurrency ?? NumberConstant.Zero, currentCurrency != null ? currentCurrency.Precision : 3),
                        BLNetHTAmountString = AmountMethods.FormatValueString(x.DocumentHtpriceWithCurrency ?? NumberConstant.Zero, currentCurrency != null ? currentCurrency.Precision : 3),
                        Symbole = currentCurrency != null ? currentCurrency.Symbole : String.Empty,
                        IdCurrency = x.IdTiersNavigation != null ? x.IdTiersNavigation.IdCurrency.ToString() : string.Empty
                    });
                });
            }


            if (listModel != null && listModel.Count > 0)
            {
                return DailySalesQuery.GroupByTiers == -1 || DailySalesQuery.GroupByTiers == 0 ? listModel.OrderBy(x => x.DocumentType).ToList() : listModel.OrderBy(x => x.IdTiersNavigation).OrderBy(x => x.DocumentType).ToList();
            }
            else
            {
                return listModel;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public IList<DocumentControlStatusLineReportViewModel> GetDocumentControlStatusLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listresult = GetDocumentControlStatusLineList(DailySalesQuery);
            return listresult == null ? new List<DocumentControlStatusLineReportViewModel>() : listresult.ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public IList<DocumentControlStatusLineReportViewModel> GetInvoiceDocumentControlStatusLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listresult = GetDocumentControlStatusLineList(DailySalesQuery);
            if (listresult == null)
            {
                return new List<DocumentControlStatusLineReportViewModel>();
            }

            var groupedResult = listresult.GroupBy(x => x.IdTiers);


            return groupedResult.Select(x =>
            new DocumentControlStatusLineReportViewModel
            {
                IdTiers = x.FirstOrDefault().IdTiers,
                DocumentStatus = x.FirstOrDefault().DocumentStatus,
                DocumentCode = x.FirstOrDefault().DocumentCode,
                ClientCode = x.FirstOrDefault().ClientCode,
                ClientName = x.FirstOrDefault().ClientName,
                BLTtcAmount = x.Sum(f => f.BLTtcAmount),
                BLNetHTAmount = x.Sum(f => f.BLNetHTAmount),
            }).ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public DailySalesDeliveryReportViewModel GetDailySalesDeliveryInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            return GetDailySalesDelivery(DailySalesQuery);
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public DailySalesDeliveryReportViewModel GetDailySalesDelivery(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();

            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            var queryrequest = _entityRepoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x =>
                  (x.DocumentTypeCode == DocumentEnumerator.SalesDelivery || x.DocumentTypeCode == DocumentEnumerator.SalesAsset), x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation);
            if (DailySalesQuery.StartDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.StartDate.Value) >= 0);
            }
            if (DailySalesQuery.EndDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.EndDate.Value) <= 0);
            }

            if (DailySalesQuery.IdTiers != -1)
            {
                queryrequest = queryrequest.Where(x => x.IdTiers == DailySalesQuery.IdTiers);
            }
            if (DailySalesQuery.IdStatus != -1)
            {
                queryrequest = queryrequest.Where(x => x.IdDocumentStatus == DailySalesQuery.IdStatus);
            }

            var allSaleDocument = queryrequest?.ToList();
            double? blcount = 0;
            double? assetcount = 0;
            double? salesassetcount = 0;
            double? alltotalttc = 0;
            double? alltotalht = 0;
            string clientName = string.Empty;
            if (allSaleDocument != null && allSaleDocument.Any())
            {
                blcount = allSaleDocument.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery);
                assetcount = allSaleDocument.Count(x => x.DocumentTypeCode != DocumentEnumerator.SalesDelivery);
                salesassetcount = allSaleDocument.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset);
                alltotalttc = allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery).Select(x => x.DocumentTtcpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum();
                alltotalht = allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery).Select(x => x.DocumentHtpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum();
                clientName = DailySalesQuery.IdTiers != -1 ? allSaleDocument.First().IdTiersNavigation.Name :
                                                            (ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? "Tous les clients" : "All clients");
            }
            else
            {
                clientName = DailySalesQuery.IdTiers != -1 ? _repoEntityTiers.GetSingle(x => x.Id == DailySalesQuery.IdTiers).Name : (ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? "Tous les clients" : "All clients");
            }


            return new DailySalesDeliveryReportViewModel
            {
                ClientName = clientName,
                DocumentDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                PrintedDate = DateTime.Now,
                PrintedDateString = DateTime.Now.ToString("dd/MM/yyyy"),
                WarehouseCode = default,
                WarehouseName = default,
                Company = companyReportingViewModel,
                Adress = address != null ? address.PrincipalAddress : string.Empty,
                City = address != null && address.IdCityNavigation != null && !string.IsNullOrEmpty(address.IdCityNavigation.Label) ? address.IdCityNavigation.Label : string.Empty,
                Pays = address != null && address.IdCountryNavigation != null && !string.IsNullOrEmpty(address.IdCountryNavigation.NameFr) ? address.IdCountryNavigation.NameFr : string.Empty,
                ZipCode = address != null && address.IdZipCodeNavigation != null && !string.IsNullOrEmpty(address.IdZipCodeNavigation.Code) ? address.IdZipCodeNavigation.Code : string.Empty,
                ClientInfoName = clientName,
                BLCount = blcount,
                AssetCount = assetcount,
                SalesAssetCount = salesassetcount,
                AllTotalHT = DailySalesQuery.IdTiers != -1 && allSaleDocument != null && allSaleDocument.Any() ?
                         CurrencyUtility.GenerateCurrencyByCulture(alltotalht.Value, allSaleDocument.FirstOrDefault().IdUsedCurrencyNavigation.Precision, allSaleDocument.FirstOrDefault().IdUsedCurrencyNavigation.Symbole, company.Culture)
                       : CurrencyUtility.GenerateCurrencyByCulture(alltotalht.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                AllTotalTTC = DailySalesQuery.IdTiers != -1 && allSaleDocument != null && allSaleDocument.Any() ?
                         CurrencyUtility.GenerateCurrencyByCulture(alltotalttc.Value, allSaleDocument.FirstOrDefault().IdUsedCurrencyNavigation.Precision, allSaleDocument.FirstOrDefault().IdUsedCurrencyNavigation.Symbole, company.Culture)
                       : CurrencyUtility.GenerateCurrencyByCulture(alltotalttc.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                VatNumber = company.VatNumber != null ? company.VatNumber : string.Empty,
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public DocumentControlStatusReportViewModel GetDocumentControlStatusInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            return GetDocumentControlStatus(DailySalesQuery);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public DocumentControlStatusReportViewModel GetInvoiceDocumentControlStatusInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            return GetDocumentControlStatus(DailySalesQuery);
        }





        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public DocumentControlStatusReportViewModel GetDocumentControlStatus(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var company = _serviceCompany.GetCurrentCompany();
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var city = address != null ? address.IdCityNavigation : null ;
            var country = address != null ? address.IdCountryNavigation : null;
            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            var queryrequest = _entityRepoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => true, x => x.IdTiersNavigation);
            if (DailySalesQuery.StartDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.StartDate.Value) >= 0);
            }
            if (DailySalesQuery.EndDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.EndDate.Value) <= 0);
            }

            if (DailySalesQuery.IdTiers != -1)
            {
                queryrequest = queryrequest.Where(x => x.IdTiers == DailySalesQuery.IdTiers);
            }
            if (DailySalesQuery.IdStatus != -1)
            {
                queryrequest = queryrequest.Where(x => x.IdDocumentStatus == DailySalesQuery.IdStatus);
            }
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            var allSaleDocument = FilterDocByType(DailySalesQuery, queryrequest)?.ToList();
            var allDocTypeTitle = GetDocByTypeTitle(DailySalesQuery)?.ToList();
            double? blcount = 0;
            double? alltotalttc = 0;
            double? alltotalht = 0;
            string clientName = string.Empty;
            //string typeDpcs = string.Empty;
            string typeDpcsTitle = string.Empty;
            if (allSaleDocument != null && allSaleDocument.Any())
            {
                //blcount = allSaleDocument.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery);
                blcount = allSaleDocument.Count();
                alltotalttc = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum();
                alltotalht = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum();
            }
            Tiers tiers = DailySalesQuery.IdTiers != -1 ? _repoEntityTiers.GetSingle(x => x.Id == DailySalesQuery.IdTiers) : null;
            clientName = tiers == null ? "Tous les clients" : tiers.Name;
            //typeDpcs = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "[-1]" ? allSaleDocument.Select(f => f.DocumentTypeCode.ToString()).Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            typeDpcsTitle = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "-1" ? allDocTypeTitle.Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            DocumentControlStatusReportViewModel model = new DocumentControlStatusReportViewModel
            {
                ClientName = clientName,
                DocumentDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                PrintedDateString = DateTime.Now.Day + "/" + DateTime.Now.Month + "/" + DateTime.Now.Year,
                PrintedTime = DateTime.Now.Hour + ":" + DateTime.Now.Minute + ":" + DateTime.Now.Second,
                FromDateString = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Day + "/" + DailySalesQuery.StartDate.Value.Month + "/" + DailySalesQuery.StartDate.Value.Year : string.Empty,
                ToDateString = DailySalesQuery.EndDate != null ? DailySalesQuery.EndDate.Value.Day + "/" + DailySalesQuery.EndDate.Value.Month + "/" + DailySalesQuery.EndDate.Value.Year : string.Empty,
                FromDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                ToDate = DailySalesQuery.EndDate != null ? DailySalesQuery.EndDate.Value.Date : (DateTime?)null,
                WarehouseCode = default,
                WarehouseName = default,
                Adress = address != null ? address.PrincipalAddress : string.Empty,
                City = address != null && address.IdCityNavigation != null && !string.IsNullOrEmpty(address.IdCityNavigation.Label) ? address.IdCityNavigation.Label : string.Empty,
                Pays = address != null && address.IdCountryNavigation != null && !string.IsNullOrEmpty(address.IdCountryNavigation.NameFr) ? address.IdCountryNavigation.NameFr : string.Empty,
                ZipCode = address != null && address.IdZipCodeNavigation != null && !string.IsNullOrEmpty(address.IdZipCodeNavigation.Code) ? address.IdZipCodeNavigation.Code : string.Empty,
                ClientInfoName = clientName,
                TypeDocs = typeDpcsTitle,
                TypeDocsTitle = typeDpcsTitle,
                DocumentCount = blcount,
                AllTotalHT = alltotalht,
                AllTotalTTC = alltotalttc,
                StarkLogo = _serviceCompany.GetStarkLogo(),
                Company = companyReportingViewModel,
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
            IList<DocumentControlStatusLineReportViewModel> lines = GetDocumentControlStatusLines(DailySalesQuery);
            var list = lines.GroupBy(x => x.Symbole).ToList();
            foreach (var x in list)
            {
                Currency currency = _repoEntityCurrency.FindSingleBy(y => y.Id == int.Parse(x.FirstOrDefault().IdCurrency));
                if (model.CurrencyOne == null)
                {
                    model.CurrencyOne = x.Key;
                    model.CurrencyTwo = string.Empty;
                    model.CurrencyThree = string.Empty;
                    model.TotalNetHTOne = AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision).ToString() : string.Empty;
                    model.TotalTTCOne = AmountMethods.FormatValueString(x.Sum(y => y.BLTtcAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLTtcAmount.Value), currency.Precision).ToString() : string.Empty;
                    model.TotalTTCTwo = string.Empty;
                    model.TotalTTCThree = string.Empty;
                    model.TotalNetHTTwo = string.Empty;
                    model.TotalNetHTThree = string.Empty;
                    continue;
                }
                if (model.CurrencyOne != null)
                {
                    model.CurrencyTwo = x.Key;
                    model.CurrencyThree = string.Empty;
                    model.TotalNetHTTwo = AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision).ToString() : string.Empty;
                    model.TotalTTCTwo = AmountMethods.FormatValueString(x.ToList().Sum(y => y.BLTtcAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLTtcAmount.Value), currency.Precision).ToString() : string.Empty;
                    model.TotalTTCThree = string.Empty;
                    model.TotalNetHTThree = string.Empty;
                    continue;
                }
                if (model.CurrencyTwo != null)
                {
                    model.CurrencyThree = x.Key;
                    model.TotalNetHTThree = AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLNetHTAmount.Value), currency.Precision).ToString() : string.Empty;
                    model.TotalTTCThree = AmountMethods.FormatValueString(x.Sum(y => y.BLTtcAmount.Value), currency.Precision) != AmountMethods.FormatValue(NumberConstant.Zero, currency.Precision).ToString() ?
                    AmountMethods.FormatValueString(x.Sum(y => y.BLTtcAmount.Value), currency.Precision).ToString() : string.Empty;
                    continue;
                }

            }
            return model;
        }

        public List<string> GetDocByTypeTitle(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var slength = DailySalesQuery.IdType.Length - 2 <= 0 ? 1 : DailySalesQuery.IdType.Length - 2;
            var stringType = DailySalesQuery.IdType.Contains('[') && DailySalesQuery.IdType.Contains(']') ?
                DailySalesQuery.IdType.Substring(1, slength).Trim().Split(',') : DailySalesQuery.IdType.Trim().Split(',');
            int[] dataType = stringType.Length <= 1 && string.IsNullOrWhiteSpace(stringType[0]) ? null : Array.ConvertAll(stringType, (f => int.Parse(f)));


            List<string> typeTitleResult = new List<string>();
            if (dataType != null && dataType.Length > 0 && !dataType.Contains(-1))
            {

                foreach (var item in dataType)
                {
                    switch (item)
                    {
                        case (int)DocumentTypesEnumerator.SUPPLIER_ASSET:
                            typeTitleResult.Add("Avoir Fournisseur");
                            break;
                        case (int)DocumentTypesEnumerator.CUSTOMER_ASSET:
                            typeTitleResult.Add("Avoir Client");
                            break;
                        case (int)DocumentTypesEnumerator.BE:
                            typeTitleResult.Add("Bon d'entrée");
                            break;
                        case (int)DocumentTypesEnumerator.BS:
                            typeTitleResult.Add("Bon de Sortie");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_QUOTATION:
                            typeTitleResult.Add("Devis Fournisseur");
                            break;
                        case (int)DocumentTypesEnumerator.RECEIPT:
                            typeTitleResult.Add("Bon Récéption");
                            break;
                        case (int)DocumentTypesEnumerator.DELIVERY_FORM:
                            typeTitleResult.Add("Bon de Livraison");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_FINAL_ORDER:
                            typeTitleResult.Add("Commande Finale");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_INVOICE:
                            typeTitleResult.Add("Facture d'achat");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_INVOICE:
                            typeTitleResult.Add("Facture de vente");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ORDER:
                            typeTitleResult.Add("Commande Achat");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ORDER:
                            typeTitleResult.Add("Commande Vente");
                            break;
                        case (int)DocumentTypesEnumerator.PRICE_REQUEST:
                            typeTitleResult.Add("Demande de prix");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_QUOTATION:
                            typeTitleResult.Add("Devis Client");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_REQUEST:
                            typeTitleResult.Add("Demande d'achat");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_TERMBILLING_INVOICE:
                            typeTitleResult.Add("Facture à terme achat");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_TERMBILLING_INVOICE:
                            typeTitleResult.Add("Facture à terme vente");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ASSET_INVOICE:
                            typeTitleResult.Add("Facture Avoir Achat");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ASSET_INVOICE:
                            typeTitleResult.Add("Facture Avoir Vente");
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_CASH_INVOICE:
                            typeTitleResult.Add("Facture Comptant Achat");
                            break;
                        case (int)DocumentTypesEnumerator.SALES_CASH_INVOICE:
                            typeTitleResult.Add("Facture Comptant Vente");
                            break;
                        default:
                            break;
                    }
                }
            }

            return typeTitleResult;
        }


        public List<Document> FilterDocByType(DailySalesDeliveryReportQueryViewModel DailySalesQuery, IQueryable<Document> queryrequest)
        {
            var slength = DailySalesQuery.IdType.Length - 2 <= 0 ? 1 : DailySalesQuery.IdType.Length - 2;
            var stringType = slength > 2 && DailySalesQuery.IdType.Contains('[') && DailySalesQuery.IdType.Contains(']') ?
                DailySalesQuery.IdType.Substring(1, slength).Trim().Split(',') : DailySalesQuery.IdType.Trim().Split(',');
            int[] dataType = stringType.Length <= 1 && string.IsNullOrWhiteSpace(stringType[0]) ? null : Array.ConvertAll(stringType, (f => int.Parse(f)));


            List<Document> queryResult = new List<Document>();
            if (dataType != null && dataType.Length > 0 && !dataType.Contains(-1))
            {
                foreach (var item in dataType)
                {
                    switch (item)
                    {
                        case (int)DocumentTypesEnumerator.SUPPLIER_ASSET:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset));
                            break;
                        case (int)DocumentTypesEnumerator.CUSTOMER_ASSET:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset));
                            break;
                        case (int)DocumentTypesEnumerator.BE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.BE));
                            break;
                        case (int)DocumentTypesEnumerator.BS:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.BS));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_QUOTATION:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseBudget));
                            break;
                        case (int)DocumentTypesEnumerator.RECEIPT:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery));
                            break;
                        case (int)DocumentTypesEnumerator.DELIVERY_FORM:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_FINAL_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseOrder));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ORDER:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesOrder));
                            break;
                        case (int)DocumentTypesEnumerator.PRICE_REQUEST:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseQuotation));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_QUOTATION:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesQuotation));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_REQUEST:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseRequest));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_TERMBILLING_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 2));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_TERMBILLING_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 2));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_ASSET_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 3));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_ASSET_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 3));
                            break;
                        case (int)DocumentTypesEnumerator.PURCHASE_CASH_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && x.InoicingType == 1));
                            break;
                        case (int)DocumentTypesEnumerator.SALES_CASH_INVOICE:
                            queryResult.AddRange(queryrequest.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && x.InoicingType == 1));
                            break;
                        default:
                            break;
                    }
                }
            }

            return queryResult;
        }



        public DailySalesDeliveryReportQueryViewModel GenerateQueryViewModel(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype)
        {
            var sdate = GenerateDate(startdate);
            var edate = GenerateDate(enddate);
            var queryViewModel = new DailySalesDeliveryReportQueryViewModel() { IdType = idtype, IdStatus = idstatus, IdTiers = idtiers, StartDate = sdate, EndDate = edate, GroupByTiers = groupbytiers };

            return queryViewModel;
        }

        public InventoryDocumentReportQueryViewModel GetInventoryDocumentInformationsQueryVM(int idinventory, int idwarehouse, string startdate, string enddate)
        {
            var sdate = GenerateDate(startdate);
            var edate = GenerateDate(enddate);
            var queryViewModel = new InventoryDocumentReportQueryViewModel() { IdWarehouse = idwarehouse, IdInventory = idinventory, StartDate = sdate, EndDate = edate };

            return queryViewModel;
        }


        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="idInventoryDocument"></param>
        /// <returns></returns>
        public InventoryDocumentReportViewModel GetInventoryDocumentInformations(InventoryDocumentReportQueryViewModel DailySalesQuery)
        {
            var company = _serviceCompany.GetCurrentCompany();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var city = address.IdCityNavigation;
            var country = address.IdCountryNavigation;
            var clientname = _repoEntityTiers.FindSingleBy(x => x.Id == DailySalesQuery.IdTiers);

            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            var queryrequest = _repoEntityStockDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == DailySalesQuery.IdInventory, x => x.IdTiersNavigation);
            if (DailySalesQuery.DocumentDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Value.Date, DailySalesQuery.DocumentDate.Value) >= 0);
            }


            //var allSaleDocument = FilterDocByType(DailySalesQuery, queryrequest)?.ToList();
            //var allDocTypeTitle = GetDocByTypeTitle(DailySalesQuery)?.ToList();
            double? blcount = 0;
            double? alltotalttc = 0;
            double? alltotalht = 0;
            string clientName = string.Empty;
            //string typeDpcs = string.Empty;
            string typeDpcsTitle = string.Empty;
            //if (allSaleDocument != null && allSaleDocument.Any())
            //{
            //    //blcount = allSaleDocument.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery);
            //    blcount = allSaleDocument.Count();
            //    alltotalttc = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentTtcpriceWithCurrency).Sum();
            //    alltotalht = allSaleDocument.Where(x => x.DocumentTypeCode != DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum() - allSaleDocument.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset).Select(x => x.DocumentHtpriceWithCurrency).Sum();
            //    clientName = DailySalesQuery.IdTiers != -1 ? allSaleDocument.First().IdTiersNavigation.Name : "Tous les clients";
            //    //typeDpcs = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "[-1]" ? allSaleDocument.Select(f => f.DocumentTypeCode.ToString()).Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            //    typeDpcsTitle = DailySalesQuery.IdType != "[]" && DailySalesQuery.IdType != "[-1]" ? allDocTypeTitle.Distinct().Aggregate((i, j) => i + ", " + j) : "Tous les documents";
            //}

            return new InventoryDocumentReportViewModel
            {
                ClientName = DailySalesQuery.IdTiers < 0 ? "" : clientname.Name,
                DocumentDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                PrintedDate = DateTime.Now,
                FromDate = DailySalesQuery.StartDate != null ? DailySalesQuery.StartDate.Value.Date : (DateTime?)null,
                ToDate = DailySalesQuery.EndDate != null ? DailySalesQuery.EndDate.Value.Date : (DateTime?)null,
                WarehouseCode = default,
                WarehouseName = default,
                Name = company.Name,
                Email = company.Email,
                Adress = address != null ? address.PrincipalAddress : string.Empty,
                City = city == null ? string.Empty : city.Label,
                CommercialRegister = company.CommercialRegister,
                MatriculeFisc = company.MatriculeFisc,
                Pays = country == null ? string.Empty : country.Label,
                ZipCode = address != null ? address.IdZipCodeNavigation.Code : string.Empty,
                Tel1 = company.Tel1,
                ClientInfoName = clientName,
                TypeDocs = typeDpcsTitle,
                TypeDocsTitle = typeDpcsTitle,
                DocumentCount = blcount,
                AllTotalHT = alltotalht,
                AllTotalTTC = alltotalttc
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public IList<InventoryDocumentLineReportViewModel> GetInventoryDocumentLines(InventoryDocumentReportQueryViewModel DailySalesQuery)
        {
            var listModel = new List<InventoryDocumentLineReportViewModel>();



            var listresult = listModel.OrderBy(x => x.DocumentType).ToList();
            if (listresult == null)
            {
                return new List<InventoryDocumentLineReportViewModel>();
            }

            return listresult;
        }


        /// <summary>
        /// Get Daily Sales delivery Information line with few informations
        /// </summary>
        /// <param name="DailySalesQuery"></param>
        /// <returns></returns>
        public IList<DailySalesDeliveryListReportViewModel> GetDailySalesDeliveryList(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listresult = GetSalesDeliveryDailyDocumentList(DailySalesQuery);
            return listresult == null ? new List<DailySalesDeliveryListReportViewModel>() : listresult.ToList();
        }


        /// <summary>
        /// return list of document with few informations where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<DailySalesDeliveryListReportViewModel> GetSalesDeliveryDailyDocumentList(DailySalesDeliveryReportQueryViewModel DailySalesQuery)
        {
            var listModel = new List<DailySalesDeliveryLineReportViewModel>();
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            var queryrequest = _entityRepoDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x =>
                   (x.DocumentTypeCode == DocumentEnumerator.SalesDelivery || x.DocumentTypeCode == DocumentEnumerator.SalesAsset)
                  && (DailySalesQuery.IdTiers != -1 ? x.IdTiers == DailySalesQuery.IdTiers : true)
                   && (DailySalesQuery.IdStatus != -1 ? x.IdDocumentStatus == DailySalesQuery.IdStatus : true)
                   , x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation);
            if (DailySalesQuery.StartDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.StartDate.Value) >= 0);
            }
            if (DailySalesQuery.EndDate != null)
            {
                queryrequest = queryrequest.Where(x => DateTime.Compare(x.DocumentDate.Date, DailySalesQuery.EndDate.Value) <= 0);
            }
            var allSaleDocument = queryrequest?.ToList().OrderBy(x => x.DocumentTypeCode).ThenBy(x => x.Code);
            var result = new List<DailySalesDeliveryListReportViewModel>();
            double? allTotalsDebit;
            double? allTotalsCredit;
            if (allSaleDocument != null && allSaleDocument.Any())
            {
                result = allSaleDocument.Select(x => new DailySalesDeliveryListReportViewModel()
                {
                    CustomerCode = x.IdTiersNavigation != null && !string.IsNullOrEmpty(x.IdTiersNavigation.CodeTiers) ? x.IdTiersNavigation.CodeTiers : string.Empty,
                    CustomerName = x.IdTiersNavigation != null && !string.IsNullOrEmpty(x.IdTiersNavigation.Name) ? x.IdTiersNavigation.Name : string.Empty,
                    BLCode = x.Code ?? string.Empty,
                    BLDate = x.DocumentDate,
                    BLDateString = x.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                    TotalDebit = !string.IsNullOrEmpty(x.DocumentTypeCode) && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery ? x.DocumentTtcpriceWithCurrency : 0,
                    TotalCredit = !string.IsNullOrEmpty(x.DocumentTypeCode) && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery ? 0 : x.DocumentTtcpriceWithCurrency,
                    TotalDebitString = !string.IsNullOrEmpty(x.DocumentTypeCode) && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery ?
                                            (DailySalesQuery.IdTiers != -1 ?
                                                CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcpriceWithCurrency.Value, x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture)
                                               : CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcprice.GetValueOrDefault(), company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture))
                                          : (DailySalesQuery.IdTiers != -1 ? CurrencyUtility.GenerateCurrencyByCulture(0, x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture) :
                                           CurrencyUtility.GenerateCurrencyByCulture(0, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture)),
                    TotalCreditString = !string.IsNullOrEmpty(x.DocumentTypeCode) && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery ?
                                            (DailySalesQuery.IdTiers != -1 ?
                                                CurrencyUtility.GenerateCurrencyByCulture(0, x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture)
                                               : CurrencyUtility.GenerateCurrencyByCulture(0, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture))
                                          : (DailySalesQuery.IdTiers != -1 ? CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcpriceWithCurrency.Value, x.IdUsedCurrencyNavigation.Precision, x.IdUsedCurrencyNavigation.Symbole, company.Culture) :
                                            CurrencyUtility.GenerateCurrencyByCulture(x.DocumentTtcprice.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture))
                }).ToList();
                allTotalsDebit = result.Sum(x => x.TotalDebit);
                allTotalsCredit = result.Sum(x => x.TotalCredit);
                result.Add(new DailySalesDeliveryListReportViewModel()
                {
                    CustomerCode = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    CustomerName = string.Empty,
                    BLCode = string.Empty,
                    BLDate = null,
                    BLDateString = string.Empty,
                    TotalDebit = allTotalsDebit,
                    TotalCredit = allTotalsCredit,
                    TotalDebitString = DailySalesQuery.IdTiers != -1 ? CurrencyUtility.GenerateCurrencyByCulture(allTotalsDebit.Value, queryrequest.FirstOrDefault().IdUsedCurrencyNavigation.Precision, queryrequest.FirstOrDefault().IdUsedCurrencyNavigation.Symbole, company.Culture)
                                                                     : CurrencyUtility.GenerateCurrencyByCulture(allTotalsDebit.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture),
                    TotalCreditString = DailySalesQuery.IdTiers != -1 ? CurrencyUtility.GenerateCurrencyByCulture(allTotalsCredit.Value, queryrequest.FirstOrDefault().IdUsedCurrencyNavigation.Precision, queryrequest.FirstOrDefault().IdUsedCurrencyNavigation.Symbole, company.Culture)
                                                                      : CurrencyUtility.GenerateCurrencyByCulture(allTotalsCredit.Value, company.IdCurrencyNavigation.Precision, company.IdCurrencyNavigation.Symbole, company.Culture)
                });
            }
            return result;
        }



        /// <summary>
        /// Get Stock Valuation Informations
        /// </summary>
        /// <param name="idwarehouse"></param>
        /// <returns></returns>
        public StockValuationReportInformationsViewModel GetStockValuationInformations(int idwarehouse)
        {
            Warehouse warehouse = _entityRepoWareHouse.FindSingleBy(x => x.Id == idwarehouse);
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            if (warehouse == null || company == null)
            {
                throw new ArgumentException("");
            }
            return new StockValuationReportInformationsViewModel()
            {
                WarehouseName = warehouse.WarehouseName ?? string.Empty,
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                CompanyLogo = _serviceCompany.GetReportCompanyInformation().CompanyLogo,
                Company = companyReportingViewModel,
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
        }

        /// <summary>
        /// Get Stock Valuation Lines
        /// </summary>
        /// <param name="idwarehouse"></param>
        /// <returns></returns>
        public IList<StockValuationReportLinesViewModel> GetStockValuationLines(int idwarehouse)
        {
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            IList<StockValuationReportLinesViewModel> stockValuationLines = new List<StockValuationReportLinesViewModel>();
            List<ItemWarehouse> itemWarehouseList = _entityRepoItemWareHouse.GetAllWithConditionsRelations(x => x.IdWarehouse == idwarehouse && x.AvailableQuantity > NumberConstant.Zero, x => x.IdItemNavigation, x => x.IdItemNavigation.ItemTiers, y => y.IdStorageNavigation,
                         y => y.IdStorageNavigation.IdShelfNavigation).ToList();
            List<int> idsTiers = itemWarehouseList.Where(z => z.IdItemNavigation.ItemTiers != null && z.IdItemNavigation.ItemTiers.Any()).Select(y => y.IdItemNavigation.ItemTiers.First().IdTiers).ToList();
            List<Tiers> tiers = _repoEntityTiers.GetAllWithConditionsRelations(y => idsTiers.Contains(y.Id), y => y.IdCurrencyNavigation).ToList();

            List<int> idCurrency = tiers.Select(x => (int)x.IdCurrency).Distinct().ToList();
            List<CurrencyRate> currencyRates = _entityRepoCurrencyRate
                    .GetAllWithConditionsRelations(c => idCurrency.Contains(c.IdCurrency)
                   && DateTime.Now >= c.StartDate && DateTime.Now <= c.EndDate).ToList();

            if (itemWarehouseList != null && itemWarehouseList.Any())
            {
                List<int> idsItem = itemWarehouseList.Select(x => x.IdItem).Distinct().ToList();
                List<DocumentLine> docLine = _repoEntityDocLine.GetAllWithConditionsRelations(x => idsItem.Contains(x.IdItem) && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery
                && x.CostPrice != null && x.CostPrice > 0, x => x.IdDocumentNavigation).ToList();
                itemWarehouseList.ForEach(itemWarehouse =>
                {
                    Tiers currenctTiers = (itemWarehouse.IdItemNavigation.ItemTiers != null && itemWarehouse.IdItemNavigation.ItemTiers.Any() &&
                    itemWarehouse.IdItemNavigation.ItemTiers.First().IdTiers > 0) ? tiers.First(z => z.Id == itemWarehouse.IdItemNavigation.ItemTiers.First().IdTiers) : null;
                    var precision = currenctTiers != null ? currenctTiers.IdCurrencyNavigation.Precision : 0;
                    List<DocumentLine> docLines = docLine.Where(x => x.IdItem == itemWarehouse.IdItem).ToList();
                    DocumentLine documLine = null;
                    if (docLines != null && docLines.Any())
                    {
                        documLine = docLines.OrderByDescending(x => x.IdDocumentNavigation.DocumentDate).GroupBy(z => z.IdDocument).First().OrderByDescending(y => y.CostPrice).First();
                    }

                    var stockValuation = new StockValuationReportLinesViewModel
                    {
                        Shelf = itemWarehouse.IdStorageNavigation != null && itemWarehouse.IdStorageNavigation.IdShelfNavigation != null ? itemWarehouse.IdStorageNavigation.IdShelfNavigation.Label : string.Empty,
                        Storage = itemWarehouse.IdStorageNavigation != null ? itemWarehouse.IdStorageNavigation.Label : string.Empty,
                        CodeArticle = itemWarehouse.IdItemNavigation != null && !string.IsNullOrEmpty(itemWarehouse.IdItemNavigation.Code) ? itemWarehouse.IdItemNavigation.Code : string.Empty,
                        Article = itemWarehouse.IdItemNavigation != null && !string.IsNullOrEmpty(itemWarehouse.IdItemNavigation.Description) ? itemWarehouse.IdItemNavigation.Description : string.Empty,
                        TotalQuantity = itemWarehouse.AvailableQuantity.ToString(),
                        UnitPurchasePriceWithCurrency = (documLine != null && documLine.CostPrice != null) ? (double)documLine.CostPrice : NumberConstant.Zero,
                        UnitPurchasePriceStringWithCurrency = (documLine != null && documLine.CostPrice != null) ? AmountMethods.FormatValueString((double)documLine.CostPrice, company.IdCurrencyNavigation.Precision) : AmountMethods.FormatValueString(0, company.IdCurrencyNavigation.Precision),
                        Currency = company.IdCurrencyNavigation.Symbole,
                        Precision = company.IdCurrencyNavigation.Precision

                    };
                    stockValuation.TotalWithCurrency = stockValuation.UnitPurchasePriceWithCurrency * itemWarehouse.AvailableQuantity;
                    stockValuation.TotalStringWithCurrency = AmountMethods.FormatValueString(stockValuation.UnitPurchasePriceWithCurrency * itemWarehouse.AvailableQuantity, precision);

                    stockValuation.UnitPurchasePrice = stockValuation.UnitPurchasePriceWithCurrency;
                    stockValuation.Total = stockValuation.TotalWithCurrency;

                    stockValuationLines.Add(stockValuation);
                });
            }
            if (stockValuationLines != null && stockValuationLines.Any())
            {
                var UnitPurchasePrice = stockValuationLines.Sum(x => x.UnitPurchasePrice ?? NumberConstant.Zero);
                var total = stockValuationLines.Sum(x => x.Total ?? NumberConstant.Zero);
                stockValuationLines.Add(new StockValuationReportLinesViewModel()
                {
                    Shelf = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    Storage = string.Empty,
                    CodeArticle = string.Empty,
                    Article = string.Empty,
                    TotalQuantity = string.Empty,
                    UnitPurchasePrice = UnitPurchasePrice,
                    UnitPurchasePriceStringWithCurrency = string.Empty,
                    Total = total,
                    TotalStringWithCurrency = AmountMethods.FormatValueString(total, company.IdCurrencyNavigation.Precision),
                    Currency = company.IdCurrencyNavigation.Symbole
                });
            }
            return stockValuationLines;
        }

        /// <summary>
        /// Get Tiers Extract Informations
        /// </summary>
        /// <param name="idtiers"></param>        
        /// <param name="startdate"></param>
        /// <returns></returns>
        public TiersExtractReportInformationsViewModel GetTiersExtractInformations(int idtiers, string startdate)
        {
            DateTime? sdate = GenerateDate(startdate);
            // invoices
            IList<Document> invoicesList = _entityRepoDocument.GetAllWithConditionsQueryable(x => x.IdTiers == idtiers
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && ((x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice) ||
            (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier && x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice)))
                .Include(x => x.IdUsedCurrencyNavigation).ToList();
            // assets
            IList<Document> assetsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => x.IdTiers == idtiers
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && ((x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer && x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset) ||
            (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier && x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset))).ToList();
            //Settlement
            IList<Settlement> settlementListViewModels = _repoEntitySettlement.GetAllWithConditionsRelations(x => x.IdTiers == idtiers,
                x => x.IdUsedCurrencyNavigation, x => x.IdTiersNavigation).ToList();

            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            // tiers
            Tiers tiers = _repoEntityTiers.GetSingle(x => x.Id == idtiers);
            // company
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            if (tiers == null || company == null)
            {
                throw new ArgumentException("");
            }
            else
            {
                var address = company.Address != null ? company.Address.FirstOrDefault() : null;
                double? balanceAtStartDate = (tiers.IdTypeTiers == (int)TiersType.Supplier) ?
                   (invoicesList.Where(x => x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))
                                           - assetsList.Where(x => x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero)))
                                           - (settlementListViewModels.Where(x => x.SettlementDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.AmountWithCurrency))
                                           + settlementListViewModels.Where(x => x.SettlementDate.Date.BeforeDate(sdate.Value.Date) && x.WithholdingTax.HasValue && x.WithholdingTax.Value != NumberConstant.Zero).Sum(x => (x.WithholdingTax))) :

                                           ((settlementListViewModels.Where(x => x.SettlementDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.AmountWithCurrency))
                                           + settlementListViewModels.Where(x => x.SettlementDate.Date.BeforeDate(sdate.Value.Date) && x.WithholdingTax.HasValue && x.WithholdingTax.Value != NumberConstant.Zero).Sum(x => (x.WithholdingTax)))
                                           - (invoicesList.Where(x => x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))
                                           - assetsList.Where(x => x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))))
                                           ;
                double? balanceAtDateNow = (tiers.IdTypeTiers == (int)TiersType.Supplier) ?
                   (invoicesList.Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))
                                           - assetsList.Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero)))
                                           - (settlementListViewModels.Sum(x => (x.AmountWithCurrency))
                                           + settlementListViewModels.Where(x => x.WithholdingTax.HasValue && x.WithholdingTax.Value != NumberConstant.Zero).Sum(x => (x.WithholdingTax))) :

                                           ((settlementListViewModels.Sum(x => (x.AmountWithCurrency))
                                           + settlementListViewModels.Where(x => x.WithholdingTax.HasValue && x.WithholdingTax.Value != NumberConstant.Zero).Sum(x => (x.WithholdingTax)))
                                           - (invoicesList.Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))
                                           - assetsList.Sum(x => (x.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero))));

                string symbole = invoicesList.Count != NumberConstant.Zero && invoicesList.FirstOrDefault().IdUsedCurrencyNavigation != null ? invoicesList.FirstOrDefault().IdUsedCurrencyNavigation.Symbole : String.Empty;
                int precision = invoicesList.Count != NumberConstant.Zero && invoicesList.FirstOrDefault().IdUsedCurrencyNavigation != null ? invoicesList.FirstOrDefault().IdUsedCurrencyNavigation.Precision : NumberConstant.Zero;
                return new TiersExtractReportInformationsViewModel()
                {
                    ReportTitle = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? "Extrait " + (tiers.IdTypeTiers == NumberConstant.One ? "Client" : "Fournisseur") : (tiers.IdTypeTiers == NumberConstant.One ? "Client" : "Supplier") + " Extract",
                    TiersName = tiers.Name ?? string.Empty,
                    TiersType = tiers.IdTypeTiers,
                    StartDate = GenerateDate(startdate).Value.PreviousDate().Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                    DateNow = DateTime.Now.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                    BalanceAtStartDate = AmountMethods.FormatValueString(balanceAtStartDate, precision),
                    BalanceAtDateNow = AmountMethods.FormatValueString(balanceAtDateNow, precision),
                    SymboleCurrency = symbole,
                    StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                    StarkLogo = _serviceCompany.GetStarkLogo(),
                    Company = companyReportingViewModel,
                    BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                    Rib = bankAccount != null ? bankAccount.Rib : string.Empty
                };
            }
        }

        /// <summary>
        /// Get Tiers Extract Lines
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="startdate"></param>
        /// <returns></returns>
        public IList<TiersExtractReportLinesViewModel> GetTiersExtractLines(int idtiers, string startdate)
        {
            DateTime? sdate = GenerateDate(startdate);
            var company = _serviceCompany.GetCurrentCompany();
            int companyPrecision = company.IdCurrencyNavigation.Precision;
            Tiers tiers = _repoEntityTiers.GetSingleWithRelations(x => x.Id == idtiers, x => x.IdCurrencyNavigation);
            int tiersPrecision = tiers.IdCurrencyNavigation.Precision;
            IList<TiersExtractReportLinesViewModel> extractTiersLines = new List<TiersExtractReportLinesViewModel>();
            // All Documents Query
            IList<Document> documentsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => x.IdTiers == idtiers
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && ((x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer &&
            (x.DocumentTypeCode == DocumentEnumerator.SalesInvoice || x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)) ||
            (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier &&
            (x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice || x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset))))
                .Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdTiersNavigation).ToList();
            // Invoices
            IList<Document> invoicesList = documentsList.Where(x => (x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                 || x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) && DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero).ToList();
            if (invoicesList != null && invoicesList.Any())
            {
                var invoicesTierType = invoicesList.FirstOrDefault().IdTiersNavigation != null ? invoicesList.FirstOrDefault().IdTiersNavigation.IdTypeTiers : NumberConstant.Zero;
                invoicesList.ToList().ForEach(document =>
                {
                    extractTiersLines.Add(new TiersExtractReportLinesViewModel()
                    {
                        DocumentCode = document.Code,
                        DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,

                        TotalCreditWithCurrency = AmountMethods.FormatValue(invoicesTierType == (int)TiersType.Customer ? (document.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero) : NumberConstant.Zero, document.IdUsedCurrencyNavigation.Precision),
                        TotalCredit = AmountMethods.FormatValue(invoicesTierType == (int)TiersType.Customer ? (document.DocumentTtcprice ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),

                        TotalDebitWithCurrency = AmountMethods.FormatValue(invoicesTierType == (int)TiersType.Supplier ? (document.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero) : NumberConstant.Zero, document.IdUsedCurrencyNavigation.Precision),
                        TotalDebit = AmountMethods.FormatValue(invoicesTierType == (int)TiersType.Supplier ? (document.DocumentTtcprice ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),

                        TotalCreditStringWithCurrency = AmountMethods.FormatValueString(invoicesTierType == (int)TiersType.Customer ? (document.DocumentTtcpriceWithCurrency ?? null) : null, document.IdUsedCurrencyNavigation.Precision),
                        TotalCreditString = AmountMethods.FormatValueString(invoicesTierType == (int)TiersType.Customer ? (document.DocumentTtcprice ?? null) : null, companyPrecision),

                        TotalDebitStringWithCurrency = AmountMethods.FormatValueString(invoicesTierType == (int)TiersType.Supplier ? (document.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero) : NumberConstant.Zero, document.IdUsedCurrencyNavigation.Precision),
                        TotalDebitString = AmountMethods.FormatValueString(invoicesTierType == (int)TiersType.Supplier ? (document.DocumentTtcprice ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),

                        TiersType = document.IdTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiers : NumberConstant.Zero,
                        Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                        Precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0

                    });
                });
            }
            // Assets
            IList<Document> assetsList = documentsList.Where(x => (x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset
              || x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset) && DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero).ToList();
            if (assetsList != null && assetsList.Any())
            {
                var assetTierType = assetsList.FirstOrDefault().IdTiersNavigation != null ? assetsList.FirstOrDefault().IdTiersNavigation.IdTypeTiers : NumberConstant.Zero;
                assetsList.ToList().ForEach(document =>
                {
                    extractTiersLines.Add(new TiersExtractReportLinesViewModel()
                    {
                        DocumentCode = document.Code,
                        DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,

                        TotalCreditWithCurrency = AmountMethods.FormatValue(assetTierType == (int)TiersType.Customer ? (-document.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero) : NumberConstant.Zero, document.IdUsedCurrencyNavigation.Precision),
                        TotalCredit = AmountMethods.FormatValue(assetTierType == (int)TiersType.Customer ? (-document.DocumentTtcprice ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),

                        TotalDebitWithCurrency = AmountMethods.FormatValue(assetTierType == (int)TiersType.Supplier ? (-document.DocumentTtcpriceWithCurrency ?? NumberConstant.Zero) : NumberConstant.Zero, document.IdUsedCurrencyNavigation.Precision),
                        TotalDebit = AmountMethods.FormatValue(assetTierType == (int)TiersType.Supplier ? (-document.DocumentTtcprice ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),

                        TotalCreditStringWithCurrency = AmountMethods.FormatValueString(assetTierType == (int)TiersType.Customer ? (-document.DocumentTtcpriceWithCurrency ?? null) : null, document.IdUsedCurrencyNavigation.Precision),
                        TotalCreditString = AmountMethods.FormatValueString(assetTierType == (int)TiersType.Customer ? (-document.DocumentTtcprice ?? null) : null, companyPrecision),

                        TotalDebitStringWithCurrency = AmountMethods.FormatValueString(assetTierType == (int)TiersType.Supplier ? (-document.DocumentTtcpriceWithCurrency ?? null) : null, document.IdUsedCurrencyNavigation.Precision),
                        TotalDebitString = AmountMethods.FormatValueString(assetTierType == (int)TiersType.Supplier ? (-document.DocumentTtcprice ?? null) : null, companyPrecision),

                        TiersType = document.IdTiersNavigation != null ? document.IdTiersNavigation.IdTypeTiers : NumberConstant.Zero,
                        Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                        Precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0


                    });
                });
            }
            // settlements 
            IList<Settlement> settlementListViewModels = _repoEntitySettlement.GetAllWithConditionsRelations(x => x.IdTiers == idtiers && DateTime.Compare(x.SettlementDate.Date, sdate.Value.Date) >= NumberConstant.Zero,
                x => x.IdUsedCurrencyNavigation, x => x.IdTiersNavigation).ToList();
            if (settlementListViewModels != null && settlementListViewModels.Any())
            {
                var settlementTierType = settlementListViewModels.FirstOrDefault().IdTiersNavigation != null ? settlementListViewModels.FirstOrDefault().IdTiersNavigation.IdTypeTiers : NumberConstant.Zero;
                settlementListViewModels.ToList().ForEach(settlement =>
                {
                    extractTiersLines.Add(new TiersExtractReportLinesViewModel()
                    {
                        DocumentCode = settlement.Code,
                        DocumentDate = settlement.SettlementDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,

                        TotalCreditWithCurrency = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Supplier ? settlement.AmountWithCurrency : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),
                        TotalCredit = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Supplier ? settlement.Amount : NumberConstant.Zero, companyPrecision),

                        TotalDebitWithCurrency = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Customer ? settlement.AmountWithCurrency : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),
                        TotalDebit = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Customer ? settlement.Amount : NumberConstant.Zero, companyPrecision),

                        TotalCreditStringWithCurrency = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Supplier ? settlement.AmountWithCurrency : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),
                        TotalCreditString = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Supplier ? settlement.Amount : NumberConstant.Zero, companyPrecision),

                        TotalDebitStringWithCurrency = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Customer ? settlement.AmountWithCurrency : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),
                        TotalDebitString = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Customer ? settlement.Amount : NumberConstant.Zero, companyPrecision),

                        TiersType = settlement.IdTiersNavigation != null ? settlement.IdTiersNavigation.IdTypeTiers : NumberConstant.Zero,
                        Currency = settlement.IdUsedCurrencyNavigation != null ? settlement.IdUsedCurrencyNavigation.Symbole : string.Empty,
                        Precision = settlement.IdUsedCurrencyNavigation != null ? settlement.IdUsedCurrencyNavigation.Precision : 0

                    });
                    if (settlement.WithholdingTax.HasValue && settlement.WithholdingTax.Value != NumberConstant.Zero)
                    {
                        extractTiersLines.Add(new TiersExtractReportLinesViewModel()
                        {
                            DocumentCode = String.Concat("RT-", settlement.Code),
                            DocumentDate = settlement.SettlementDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,

                            TotalCredit = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Supplier ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),
                            TotalCreditWithCurrency = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Supplier ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),

                            TotalDebit = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Customer ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),
                            TotalDebitWithCurrency = AmountMethods.FormatValue(settlementTierType == (int)TiersType.Customer ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),

                            TotalCreditString = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Supplier ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),
                            TotalCreditStringWithCurrency = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Supplier ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),

                            TotalDebitString = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Customer ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, companyPrecision),
                            TotalDebitStringWithCurrency = AmountMethods.FormatValueString(settlementTierType == (int)TiersType.Customer ? (settlement.WithholdingTax ?? NumberConstant.Zero) : NumberConstant.Zero, settlement.IdUsedCurrencyNavigation.Precision),

                            TiersType = settlement.IdTiersNavigation != null ? settlement.IdTiersNavigation.IdTypeTiers : NumberConstant.Zero,
                            Currency = settlement.IdUsedCurrencyNavigation != null ? settlement.IdUsedCurrencyNavigation.Symbole : string.Empty,
                            Precision = settlement.IdUsedCurrencyNavigation != null ? settlement.IdUsedCurrencyNavigation.Precision : 0
                        });
                    }
                });
            }
            extractTiersLines = extractTiersLines.OrderBy(x => x.DocumentDate).ToList();
            double? allTotalsDebit;
            double? allTotalsCredit;
            int tierType;
            double? balanceAtStartDate;
            double? balance;
            if (extractTiersLines != null && extractTiersLines.Any())
            {
                allTotalsDebit = extractTiersLines.Sum(x => x.TotalDebitWithCurrency);
                allTotalsCredit = extractTiersLines.Sum(x => x.TotalCreditWithCurrency);
                tierType = documentsList.Count != NumberConstant.Zero && documentsList.FirstOrDefault().IdTiersNavigation != null ? documentsList.FirstOrDefault().IdTiersNavigation.IdTypeTiers : NumberConstant.Zero;
                balanceAtStartDate = documentsList.Where(x => (x.DocumentTypeCode == DocumentEnumerator.SalesInvoice || x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice)
                                                   && x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentRemainingAmountWithCurrency ?? NumberConstant.Zero))
                                    - documentsList.Where(x => (x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset || x.DocumentTypeCode == DocumentEnumerator.PurchaseAsset)
                                                   && x.DocumentDate.Date.BeforeDate(sdate.Value.Date)).Sum(x => (x.DocumentRemainingAmountWithCurrency ?? NumberConstant.Zero));
                balance = allTotalsDebit - allTotalsCredit;
                extractTiersLines.Add(new TiersExtractReportLinesViewModel()
                {
                    DocumentCode = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    DocumentDate = string.Empty,
                    TotalCredit = AmountMethods.FormatValue(allTotalsCredit, tiersPrecision),
                    TotalDebit = AmountMethods.FormatValue(allTotalsDebit, tiersPrecision),
                    TotalDebitString = AmountMethods.FormatValueString(allTotalsDebit, companyPrecision),
                    TotalDebitStringWithCurrency = AmountMethods.FormatValueString(allTotalsDebit, tiersPrecision),
                    TotalCreditStringWithCurrency = AmountMethods.FormatValueString(allTotalsCredit, tiersPrecision),
                    TotalCreditString = AmountMethods.FormatValueString(allTotalsCredit, companyPrecision),
                    TiersType = tierType,
                    Balance = AmountMethods.FormatValueString(balance.Value, tiersPrecision),
                    Precision = tiersPrecision,
                    Currency = tiers.IdCurrencyNavigation != null ? tiers.IdCurrencyNavigation.Symbole : string.Empty,

                });
            }
            return extractTiersLines;
        }

        /// <summary>
        /// Get VAT Declaration Informations
        /// </summary>
        /// <param name="startdate"></param>      
        /// <param name="enddate"></param>
        /// <returns></returns>
        public VatDeclarationInformationsViewModel GetVatDeclarationInformations(string startdate, string enddate, int idCurrency)
        {
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            ReportCompanyInformationViewModel companyReportingViewModel = _serviceCompany.GetReportCompanyInformation();
            if (company == null)
            {
                throw new ArgumentException("");
            }
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;
            var currencySymbol = _repoEntityCurrency.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == idCurrency).FirstOrDefault().Symbole;
            return new VatDeclarationInformationsViewModel()
            {

                StartDate = GenerateDate(startdate).Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                EndDate = GenerateDate(enddate).Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                Company = companyReportingViewModel,
                StarkWebSiteUrl = _serviceCompany.GetStarkWebSiteUrl(),
                StarkLogo = _serviceCompany.GetStarkLogo(),
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty,
                Currency = currencySymbol
            };
        }

        /// <summary>
        /// Get Tiers Extract Lines
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        public IList<VatDeclarationReportViewModel> GetVatDeclarationReport(string startdate, string enddate, bool isPurchaseType, int idTier, int idCurrency)
        {
            // get vat Declaration info
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            if (company == null)
            {
                throw new ArgumentException("");
            }
            var address = company.Address != null ? company.Address.FirstOrDefault() : null;

            // get vat Declaration Data
            DateTime? sdate = GenerateDate(startdate);
            DateTime? edate = GenerateDate(enddate);
            List<VatDeclarationReportViewModel> vatDeclarationLines = new List<VatDeclarationReportViewModel>();

            // invoices
            List<Document> documentsList = new List<Document>();
            if (isPurchaseType)
            {
                documentsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero &&
                DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier && x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) && x.IdUsedCurrency == idCurrency &&
            (idTier > 0 ? x.IdTiers == idTier : true)).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdTiersNavigation).ToList();
            }
            else
            {
                documentsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero &&
                DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice) && x.IdUsedCurrency == idCurrency &&
            (idTier > 0 ? x.IdTiers == idTier : true)).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdTiersNavigation).ToList();
            }
            if (documentsList != null && documentsList.Any())
            {
                IList<int> AllDocumentsListIds = documentsList.Select(x => x.Id).ToList();
                var AllDocumentLinesListIds = _entityRepoDocumentLine.FindBy(x => AllDocumentsListIds.Contains(x.IdDocument)).Select(x => new { IdDocLine = x.Id, IdDocument = x.IdDocument }).ToList();
                IList<DocumentLineTaxe> AllDocumentsLinesTaxess = _entityRepoDocumentLineTaxe.GetAllWithConditionsQueryable(x => AllDocumentLinesListIds.Select(y => y.IdDocLine).Contains(x.IdDocumentLine))
                                                                    .Include(x => x.IdTaxeNavigation).OrderBy(x => x.IdTaxeNavigation.TaxeValue.Value).ToList();
                int[] usedTaxesType1 = AllDocumentsLinesTaxess.Where(x => x.IdTaxe != null && x.IdTaxeNavigation != null && x.IdTaxeNavigation.TaxeType == 1 && x.IdTaxeNavigation.IsCalculable == true &&
                x.IdTaxeNavigation.TaxeValue != 0).Select(x => x.IdTaxe).Distinct().ToArray();
                int[] usedTaxesType2 = AllDocumentsLinesTaxess.Where(x => x.IdTaxe != null && x.IdTaxeNavigation != null && x.IdTaxeNavigation.TaxeType == 2 && x.IdTaxeNavigation.IsCalculable == true &&
                x.IdTaxeNavigation.TaxeValue != 0).Select(x => x.IdTaxe).Distinct().ToArray();
                List<Taxe> usedTaxes = _repoEntityTaxe.GetAllWithConditionsRelationsAsNoTracking(x => (usedTaxesType1.Length > 0 && usedTaxesType1.Contains(x.Id)) ||
                                       (usedTaxesType2.Length > 0 && usedTaxesType2.Contains(x.Id))).ToList();
                bool hasVatAmount = AllDocumentsLinesTaxess.Any(x => x.IdTaxeNavigation != null && x.IdTaxeNavigation.IsCalculable == false);
                bool hasBase0 = AllDocumentsLinesTaxess.Any(y => y.IdTaxeNavigation.TaxeValue != null && y.IdTaxeNavigation.TaxeValue.Value == 0);

                documentsList.ToList().ForEach(document =>
                {
                    IList<int> documentLinesListIds = AllDocumentLinesListIds.Where(x => x.IdDocument == document.Id).Select(x => x.IdDocLine).ToList();
                    IList<DocumentLineTaxe> documentLinesTaxes = AllDocumentsLinesTaxess.Where(x => documentLinesListIds.Contains(x.IdDocumentLine)).ToList();
                    var precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0;
                    if (documentLinesTaxes != null && documentLinesTaxes.Any())
                    {

                        vatDeclarationLines.Add(documentLinesTaxes
                                                .Select(x =>
                                                    new VatDeclarationReportViewModel()
                                                    {
                                                        DocumentCode = document.Code,
                                                        DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                                                        TiersName = document.IdTiersNavigation.Name,
                                                        //Fodec
                                                        VatAmount0 = usedTaxesType2.Length > 0 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType2[0]).Sum(y => y.TaxeValue) ?? 0, precision) :
                                                                (usedTaxesType1.Length > 4 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[4]).Sum(y => y.TaxeValue) ?? 0, precision) : 0),
                                                        BaseVatAmount0 = usedTaxesType2.Length > 0 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType2[0]).Sum(y => y.TaxeBase) ?? 0, precision) :
                                                                (usedTaxesType1.Length > 4 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[4]).Sum(y => y.TaxeBase) ?? 0, precision) : 0),
                                                        // Base 0%
                                                        Base0 = documentLinesTaxes.Any(y => y.IdTaxeNavigation.TaxeValue != null && y.IdTaxeNavigation.TaxeValue.Value == 0) ?
                                                            Math.Round(documentLinesTaxes.Where(y => y.IdTaxeNavigation.TaxeValue != null && y.IdTaxeNavigation.TaxeValue.Value == 0).Sum(y => y.TaxeBase) ?? 0, precision)
                                                            : 0,
                                                        // Vat 1
                                                        VatAmount1 = usedTaxesType1.Length > 0 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[0]).Sum(y => y.TaxeValue) ?? 0, precision) : 0,
                                                        BaseVatAmount1 = usedTaxesType1.Length > 0 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[0]).Sum(y => y.TaxeBase) ?? 0, precision) : 0,
                                                        // Vat 2
                                                        VatAmount2 = usedTaxesType1.Length > 1 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[1]).Sum(y => y.TaxeValue) ?? 0, precision) : 0,
                                                        BaseVatAmount2 = usedTaxesType1.Length > 1 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[1]).Sum(y => y.TaxeBase) ?? 0, precision) : 0,
                                                        // Vat 3
                                                        VatAmount3 = usedTaxesType1.Length > 2 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[2]).Sum(y => y.TaxeValue) ?? 0, precision) : 0,
                                                        BaseVatAmount3 = usedTaxesType1.Length > 2 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[2]).Sum(y => y.TaxeBase) ?? 0, precision) : 0,
                                                        // vat 4
                                                        VatAmount4 = usedTaxesType1.Length > 3 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[3]).Sum(y => y.TaxeValue) ?? 0, precision) : 0,
                                                        BaseVatAmount4 = usedTaxesType1.Length > 3 ? Math.Round(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[3]).Sum(y => y.TaxeBase) ?? 0, precision) : 0,
                                                        // Vat Amount 
                                                        VatAmountdouble = Math.Round(documentLinesTaxes.Where(z => z.IdTaxeNavigation.IsCalculable == false).Sum(e => e.TaxeValue) ?? 0, precision),

                                                        // Total
                                                        TotalHT = Math.Round(document.DocumentHtprice ?? 0, precision),
                                                        TotalVat = Math.Round(document.DocumentTotalVatTaxes ?? 0, precision),
                                                        FiscalStamp = Math.Round(document.DocumentOtherTaxes ?? 0, precision),
                                                        TotalTTC = Math.Round(document.DocumentTtcprice ?? 0, precision),

                                                        //Fodec
                                                        VatAmountString0 = usedTaxesType2.Length > 0 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType2[0]).Sum(y => y.TaxeValue), precision) :
                                                                (usedTaxesType1.Length > 4 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[4]).Sum(y => y.TaxeValue), precision) : null),
                                                        BaseVatAmountString0 = usedTaxesType2.Length > 0 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType2[0]).Sum(y => y.TaxeBase), precision) :
                                                                (usedTaxesType1.Length > 4 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[4]).Sum(y => y.TaxeBase), precision) : null),
                                                        // Base 0%
                                                        BaseString0 = documentLinesTaxes.Any(y => y.IdTaxeNavigation.TaxeValue != null && y.IdTaxeNavigation.TaxeValue.Value == 0) ?
                                                            AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxeNavigation.TaxeValue != null && y.IdTaxeNavigation.TaxeValue.Value == 0).Sum(y => y.TaxeBase), precision)
                                                            : null,
                                                        // Vat 1
                                                        VatAmountString1 = usedTaxesType1.Length > 0 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[0]).Sum(y => y.TaxeValue), precision) : null,
                                                        BaseVatAmountString1 = usedTaxesType1.Length > 0 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[0]).Sum(y => y.TaxeBase), precision) : null,
                                                        // Vat 2
                                                        VatAmountString2 = usedTaxesType1.Length > 1 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[1]).Sum(y => y.TaxeValue), precision) : null,
                                                        BaseVatAmountString2 = usedTaxesType1.Length > 1 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[1]).Sum(y => y.TaxeBase), precision) : null,
                                                        // Vat 3
                                                        VatAmountString3 = usedTaxesType1.Length > 2 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[2]).Sum(y => y.TaxeValue), precision) : null,
                                                        BaseVatAmountString3 = usedTaxesType1.Length > 2 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[2]).Sum(y => y.TaxeBase), precision) : null,
                                                        // vat 4
                                                        VatAmountString4 = usedTaxesType1.Length > 3 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[3]).Sum(y => y.TaxeValue), precision) : null,
                                                        BaseVatAmountString4 = usedTaxesType1.Length > 3 ? AmountMethods.FormatValueString(documentLinesTaxes.Where(y => y.IdTaxe == usedTaxesType1[3]).Sum(y => y.TaxeBase), precision) : null,
                                                        // Vat Amount 
                                                        VatAmount = AmountMethods.FormatValueString(documentLinesTaxes.Where(z => z.IdTaxeNavigation.IsCalculable == false).Sum(e => e.TaxeValue), precision),

                                                        // Total
                                                        TotalHTString = AmountMethods.FormatValueString(document.DocumentHtprice, precision),
                                                        TotalVatString = AmountMethods.FormatValueString(document.DocumentTotalVatTaxes, precision),
                                                        FiscalStampString = AmountMethods.FormatValueString(document.DocumentOtherTaxes, precision),
                                                        TotalTTCString = AmountMethods.FormatValueString(document.DocumentTtcprice, precision),



                                                        Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                                                        Precision = precision,
                                                        IdCurrency = document.IdUsedCurrency != null ? (int)document.IdUsedCurrency : 0,
                                                        NameVat0 = usedTaxesType2.Length > 0 ? usedTaxes.Where(z => z.Id == usedTaxesType2[0]).FirstOrDefault().Label :
                                                                   (usedTaxesType1.Length > 4 ?
                                                         ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? "TVA " : "VAT " + usedTaxes.Where(z => z.Id == usedTaxesType1[4]).FirstOrDefault().TaxeValue.ToString() + "%" : null),
                                                        NameVat1 = usedTaxesType1.Length > 0 ? usedTaxes.Where(z => z.Id == usedTaxesType1[0]).FirstOrDefault().TaxeValue.ToString() : null,
                                                        NameVat2 = usedTaxesType1.Length > 1 ? usedTaxes.Where(z => z.Id == usedTaxesType1[1]).FirstOrDefault().TaxeValue.ToString() : null,
                                                        NameVat3 = usedTaxesType1.Length > 2 ? usedTaxes.Where(z => z.Id == usedTaxesType1[2]).FirstOrDefault().TaxeValue.ToString() : null,
                                                        NameVat4 = usedTaxesType1.Length > 3 ? usedTaxes.Where(z => z.Id == usedTaxesType1[3]).FirstOrDefault().TaxeValue.ToString() : null,
                                                        HasVatAmount = hasVatAmount,
                                                        HasBase0 = hasBase0
                                                    }).FirstOrDefault());
                    }
                    else
                    {
                        vatDeclarationLines.Add(new VatDeclarationReportViewModel()
                        {
                            DocumentCode = document.Code,
                            DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                            TiersName = document.IdTiersNavigation.Name,
                            TotalHT = Math.Round(document.DocumentHtprice ?? 0, precision),
                            TotalVat = Math.Round(document.DocumentTotalVatTaxes ?? 0, precision),
                            TotalHTString = AmountMethods.FormatValueString(document.DocumentHtprice, precision),
                            TotalVatString = AmountMethods.FormatValueString(document.DocumentTotalVatTaxes, precision),
                            FiscalStampString = AmountMethods.FormatValueString(document.DocumentOtherTaxes, precision),
                            TotalTTCString = AmountMethods.FormatValueString(document.DocumentTtcprice, precision),
                            FiscalStamp = Math.Round(document.DocumentOtherTaxes ?? 0, precision),
                            TotalTTC = Math.Round(document.DocumentTtcprice ?? 0, precision),
                            Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                            Precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0,
                            IdCurrency = document.IdUsedCurrency != null ? (int)document.IdUsedCurrency : 0,
                            NameVat0 = null,
                            NameVat1 = null,
                            NameVat2 = null,
                            NameVat3 = null,
                            NameVat4 = null,
                            HasVatAmount = false,
                            HasBase0 = false
                        });
                    }
                });
            }
            if (vatDeclarationLines != null && vatDeclarationLines.Any())
            {
                Currency currency = _repoEntityCurrency.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == idCurrency).FirstOrDefault();
                var precision = currency.Precision;
                vatDeclarationLines.Add(new VatDeclarationReportViewModel()
                {
                    DocumentCode = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    DocumentDate = string.Empty,
                    TiersName = string.Empty,
                    VatAmountString0 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmount0), precision),
                    BaseVatAmountString0 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.BaseVatAmount0), precision),
                    BaseString0 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.Base0), precision),
                    VatAmountString1 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmount1), precision),
                    BaseVatAmountString1 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.BaseVatAmount1), precision),
                    VatAmountString2 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmount2), precision),
                    BaseVatAmountString2 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.BaseVatAmount2), precision),
                    VatAmountString3 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmount3), precision),
                    BaseVatAmountString3 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.BaseVatAmount3), precision),
                    TotalHTString = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.TotalHT), precision),
                    TotalVatString = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.TotalVat), precision),
                    FiscalStampString = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.FiscalStamp), precision),
                    TotalTTCString = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.TotalTTC), precision),
                    Precision = precision,
                    Currency = currency.Symbole,
                    VatAmount = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmountdouble), precision),
                    BaseVatAmountString4 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.BaseVatAmount4), precision),
                    VatAmountString4 = AmountMethods.FormatValueString(vatDeclarationLines.Sum(x => x.VatAmount4), precision),
                    NameVat0 = vatDeclarationLines.Any(x => !String.IsNullOrEmpty(x.NameVat0)) ? vatDeclarationLines.Where(x => !String.IsNullOrEmpty(x.NameVat0)).FirstOrDefault().NameVat0 : null,
                    NameVat1 = vatDeclarationLines.Any(x => !String.IsNullOrEmpty(x.NameVat1)) ? vatDeclarationLines.Where(x => !String.IsNullOrEmpty(x.NameVat1)).FirstOrDefault().NameVat1 : null,
                    NameVat2 = vatDeclarationLines.Any(x => !String.IsNullOrEmpty(x.NameVat2)) ? vatDeclarationLines.Where(x => !String.IsNullOrEmpty(x.NameVat2)).FirstOrDefault().NameVat2 : null,
                    NameVat3 = vatDeclarationLines.Any(x => !String.IsNullOrEmpty(x.NameVat3)) ? vatDeclarationLines.Where(x => !String.IsNullOrEmpty(x.NameVat3)).FirstOrDefault().NameVat3 : null,
                    NameVat4 = vatDeclarationLines.Any(x => !String.IsNullOrEmpty(x.NameVat4)) ? vatDeclarationLines.Where(x => !String.IsNullOrEmpty(x.NameVat4)).FirstOrDefault().NameVat4 : null,
                    HasVatAmount = vatDeclarationLines.Any(x => x.HasVatAmount == true) ? true : false,
                    HasBase0 = vatDeclarationLines.Any(x => x.HasBase0 == true) ? true : false
                });

            }
            return vatDeclarationLines;
        }

        public DateTime? GenerateDate(string date)
        {
            return (!date.Equals("-1")) ? new DateTime(int.Parse(date.Split(",")[0]), int.Parse(date.Split(",")[1]), int.Parse(date.Split(",")[2])) : (DateTime?)null;
        }

        /// <summary>
        /// get stock movement information for reporting
        /// </summary>
        /// <param name="idIStockMovemment"></param>
        /// <returns></returns>
        public StockMovementInformationViewModel GetStockMovementInformation(int idIStockMovemment)
        {
            StockDocument stockMovement = _repoEntityStockDocument.GetAllAsNoTracking().Where(d => d.Id == idIStockMovemment).Include(x => x.IdDocumentStatusNavigation)
                .Include(y => y.IdWarehouseDestinationNavigation)
                .Include(z => z.IdWarehouseSourceNavigation).FirstOrDefault();
            ReportCompanyInformationViewModel company = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            StockMovementInformationViewModel model = new StockMovementInformationViewModel
            {
                DocumentDate = stockMovement != null ? stockMovement.DocumentDate.Value.ToUniversalTime().Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                WarehouseSource = stockMovement.IdWarehouseSourceNavigation != null ? stockMovement.IdWarehouseSourceNavigation.WarehouseName : string.Empty,
                WarehouseDestination = stockMovement.IdWarehouseDestinationNavigation != null ? stockMovement.IdWarehouseDestinationNavigation.WarehouseName : string.Empty,
                Code = stockMovement != null ? stockMovement.Code : string.Empty,
                Company = company,
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
            switch (stockMovement.IdDocumentStatus)
            {
                case 2:
                    model.Status = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? DocumentConstant.ValidFr : DocumentConstant.ValidEn;
                    break;
                case 9:
                    model.Status = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? DocumentConstant.TransferredFr : DocumentConstant.TransferredEn;
                    break;
                case 10:
                    model.Status = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? DocumentConstant.ReceivedFr : DocumentConstant.ReceivedEn;
                    break;
                default:
                    model.Status = string.Empty;
                    break;
            }
            return model;
        }

        /// <summary>
        /// get stock movement lines for reporting
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        public IList<ReportStockMovementViewModel> GetStockMovementLines(int idStockDocument)
        {
            DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel = new DocumentLinesWithPagingViewModel
            {
                IdDocument = idStockDocument,
                isSalesDocument = false
            };
            List<StockDocumentLineViewModel> models = _serviceStockDocument.GetStockDocumentWithStockDocumentLine(documentLinesWithPagingViewModel, out int total);
            IList<ReportStockMovementViewModel> reportStockMovementViewModels = new List<ReportStockMovementViewModel>();
            foreach (var model in models)
            {
                reportStockMovementViewModels.Add(new ReportStockMovementViewModel
                {
                    Item = model.IdItemNavigation != null ? model.IdItemNavigation.Code: string.Empty,
                    Quantity = model != null ? model.ActualQuantity.ToString() : string.Empty,
                });
            }
            return reportStockMovementViewModels;
        }

        /// <summary>
        /// Get Tiers Extract Lines
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        public IList<VatDeclarationLinesViewModel> GetVatDeclarationLines(string startdate, string enddate, bool isPurchaseType, int idTier)
        {
            DateTime? sdate = GenerateDate(startdate);
            DateTime? edate = GenerateDate(enddate);
            List<VatDeclarationLinesViewModel> vatDeclarationLines = new List<VatDeclarationLinesViewModel>();
            // invoices
            IList<Document> documentsList = new List<Document>();
            if (isPurchaseType)
            {
                documentsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero
                && DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier && x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) &&
            (idTier > 0 ? x.IdTiers == idTier : true)).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdTiersNavigation).ToList();
            }
            else
            {
                documentsList = _entityRepoDocument.GetAllWithConditionsQueryable(x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero
                && DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero
            && (x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)
            && (x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice) &&
            (idTier > 0 ? x.IdTiers == idTier : true)).Include(x => x.IdUsedCurrencyNavigation).Include(x => x.IdTiersNavigation).ToList();
            }
            if (documentsList != null && documentsList.Any())
            {
                IList<int> AllDocumentsListIds = documentsList.Select(x => x.Id).ToList();
                var AllDocumentLinesListIds = _entityRepoDocumentLine.FindBy(x => AllDocumentsListIds.Contains(x.IdDocument)).Select(x => new { IdDocLine = x.Id, IdDocument = x.IdDocument }).ToList();
                IList<DocumentLineTaxe> AllDocumentsLinesTaxess = _entityRepoDocumentLineTaxe.GetAllWithConditionsQueryable(x => AllDocumentLinesListIds.Select(y => y.IdDocLine).Contains(x.IdDocumentLine))
                                                                    .Include(x => x.IdTaxeNavigation).OrderBy(x => x.IdTaxeNavigation.TaxeValue.Value).ToList();
                documentsList.ToList().ForEach(document =>
                {
                    IList<int> documentLinesListIds = AllDocumentLinesListIds.Where(x => x.IdDocument == document.Id).Select(x => x.IdDocLine).ToList();
                    IList<DocumentLineTaxe> documentLinesTaxes = AllDocumentsLinesTaxess.Where(x => documentLinesListIds.Contains(x.IdDocumentLine)).ToList();
                    var precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0;
                    if (documentLinesTaxes != null && documentLinesTaxes.Any())
                    {

                        vatDeclarationLines.Add(documentLinesTaxes
                                                .Select(x =>
                                                    new VatDeclarationLinesViewModel()
                                                    {
                                                        DocumentCode = document.Code,
                                                        DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                                                        TiersName = document.IdTiersNavigation.Name,
                                                        TotalHT = AmountMethods.FormatValue(document.DocumentHtprice, precision),
                                                        TotalHTWithCurrency = document.DocumentHtpriceWithCurrency,
                                                        TotalVat = AmountMethods.FormatValue(document.DocumentTotalVatTaxes, precision),
                                                        TotalVatWithCurrency = document.DocumentTotalVatTaxesWithCurrency,
                                                        FiscalStamp = AmountMethods.FormatValue(document.DocumentOtherTaxes, precision),
                                                        TotalTTC = AmountMethods.FormatValue(document.DocumentTtcprice, precision),
                                                        TotalTTCString = AmountMethods.FormatValue(document.DocumentTtcprice, precision).ToString(),
                                                        TotalTTCWithCurrency = document.DocumentTtcpriceWithCurrency,
                                                        Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                                                        Precision = precision

                                                    }).FirstOrDefault());
                    }
                    else
                    {
                        vatDeclarationLines.Add(new VatDeclarationLinesViewModel()
                        {
                            DocumentCode = document.Code,
                            DocumentDate = document.DocumentDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                            TiersName = document.IdTiersNavigation.Name,
                            TotalHT = AmountMethods.FormatValue(document.DocumentHtprice, precision),
                            TotalHTWithCurrency = document.DocumentHtpriceWithCurrency,
                            TotalVat = AmountMethods.FormatValue(document.DocumentTotalVatTaxes, precision),
                            TotalVatWithCurrency = document.DocumentTotalVatTaxesWithCurrency,
                            FiscalStamp = AmountMethods.FormatValue(document.DocumentOtherTaxes, precision),
                            TotalTTC = AmountMethods.FormatValue(document.DocumentTtcprice, precision),
                            TotalTTCWithCurrency = document.DocumentTtcpriceWithCurrency,
                            Currency = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Symbole : string.Empty,
                            Precision = document.IdUsedCurrencyNavigation != null ? document.IdUsedCurrencyNavigation.Precision : 0

                        });
                    }
                });
            }
            if (vatDeclarationLines != null && vatDeclarationLines.Any())
            {
                var company = _serviceCompany.GetCurrentCompany();
                var Precision = company.IdCurrencyNavigation.Precision;
                vatDeclarationLines.Add(new VatDeclarationLinesViewModel()
                {
                    DocumentCode = ActiveAccountHelper.GetConnectedUserCredential().Language.Equals(GenericConstants.French) ? GenericConstants.Totaux : GenericConstants.Totals,
                    DocumentDate = string.Empty,
                    TiersName = string.Empty,
                    TotalHT = AmountMethods.FormatValue(vatDeclarationLines.Sum(x => x.TotalHT), Precision),
                    TotalHTWithCurrency = vatDeclarationLines.Sum(x => x.TotalHTWithCurrency),
                    TotalVat = AmountMethods.FormatValue(vatDeclarationLines.Sum(x => x.TotalVat), Precision),
                    TotalVatWithCurrency = vatDeclarationLines.Sum(x => x.TotalVatWithCurrency),
                    FiscalStamp = AmountMethods.FormatValue(vatDeclarationLines.Sum(x => x.FiscalStamp), Precision),
                    TotalTTC = AmountMethods.FormatValue(vatDeclarationLines.Sum(x => x.TotalTTC), Precision),
                    TotalTTCWithCurrency = vatDeclarationLines.Sum(x => x.TotalTTCWithCurrency),
                    Precision = Precision,
                    Currency = company.IdCurrencyNavigation.Symbole
                });
            }
            return vatDeclarationLines;
        }

        
        /// <summary>
        /// method to get note on turnover report informations
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        public NoteOnTurnoverReportViewModel GetNoteOnTurnoverInformations(string StartDate, string EndDate)
        {
            ReportCompanyInformationViewModel company = _serviceCompany.GetReportCompanyInformation();
            BankAccount bankAccount = _repoBankAccount.GetAllWithConditionsRelations(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation).FirstOrDefault();
            DateTime? sdate = GenerateDate(StartDate);
            DateTime? edate = GenerateDate(EndDate);
            NoteOnTurnoverReportViewModel model = new NoteOnTurnoverReportViewModel
            {
                Company = company,
                StartDate = sdate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                EndDate = edate.Value.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) ?? string.Empty,
                BankName = bankAccount != null ? bankAccount.IdBankNavigation.Name : string.Empty,
                Rib = bankAccount != null ? bankAccount.Rib : string.Empty
            };
            return model;
        }
        /// <summary>
        /// method to get note on turnover lines 
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        public List<NoteOnTurnoverLineReportViewModel> GetNoteOnTurnoverLines(string StartDate, string EndDate, int IdItem)
        {
            return _serviceDocument.GetNoteOnTurnoverList(StartDate, EndDate, IdItem, true).NoteOnTurnoverLines;
        }
        #endregion
    }
}