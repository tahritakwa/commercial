using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;

namespace Services.Reporting.Classes
{
    /// <summary>
    /// This service provide informations for Telerik report
    /// </summary>
    public class DailySalesServiceReporting : IDailySalesServiceReporting
    {
        #region Fields

        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IRepository<Storage> _entityStorageRepo;
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceStockDocumentLine _serviceStockDocumentLine;


        #endregion
        #region Constructor
        public DailySalesServiceReporting(IRepository<DocumentLine> entityRepoDocumentLine, IServiceItemWarehouse serviceItemWarehouse,
            IServiceWarehouse serviceWarehouse, IServiceStockDocumentLine serviceStockDocumentLine,
             IRepository<Storage> entityStorageRepo)
        {
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _serviceItemWarehouse = serviceItemWarehouse;
            _serviceWarehouse = serviceWarehouse;
            _serviceStockDocumentLine = serviceStockDocumentLine;
            _entityStorageRepo = entityStorageRepo;
        }
        //public DailySalesServiceReporting(IServiceDocumentLine serviceDocumentLine, IServiceDocument serviceDocument,
        //    IServiceTiers serviceTiers, IServiceCompany serviceCompany, IServiceCountry serviceCountry,
        //    IServiceCity serviceCity, IServiceDocumentType serviceDocumentType,
        //    IServiceCurrency serviceCurrency, IDocumentReportingBuilder documentReportingBuilder,
        //    ICompanyReportingBuilder companyReportingBuilder, IDocumentLineReportingBuilder documentLineReportingBuilder,
        //    IRepository<Document> entityRepoDocument, IRepository<Company> entityRepoCompany,
        //    IRepository<DocumentLine> entityRepoDocumentLine, IOptions<ReportingSettings> reportingSettings)
        //{
        //_serviceDocumentLine = serviceDocumentLine;
        //_serviceDocument = serviceDocument;
        //_serviceTiers = serviceTiers;
        //_serviceCompany = serviceCompany;
        //_serviceCountry = serviceCountry;
        //_serviceCity = serviceCity;
        //_serviceDocumentType = serviceDocumentType;
        //_serviceCurrency = serviceCurrency;
        //_documentReportingBuilder = documentReportingBuilder;
        //_companyReportingBuilder = companyReportingBuilder;
        //_documentLineReportingBuilder = documentLineReportingBuilder;
        //_entityRepoDocument = entityRepoDocument;
        //_entityRepoCompany = entityRepoCompany;
        //_entityRepoDocumentLine = entityRepoDocumentLine;
        //_reportingSettings = reportingSettings.Value;
        //}
        #endregion
        #region Methodes


        /// <summary>
        /// 
        /// </summary>
        /// <param name="idPaylsip"></param>
        /// <returns></returns>
        public IList<DailySalesLineViewModel> GetDailySalesLines(int idWarehouse, DateTime? startDate, DateTime? endDate)
        {
            var allstockDocumenLine = new List<DailySalesLineViewModel>();
            IList<DailySalesLineViewModel> dailySalesLines = new List<DailySalesLineViewModel>();

            IQueryable<DocumentLine> queryItemSalesDelivery = _entityRepoDocumentLine.QuerableGetAll(r => r.IdItemNavigation,
                 r => r.IdItemNavigation.ItemWarehouse, r => r.IdDocumentNavigation, r => r.IdDocumentNavigation.IdTiersNavigation, r => r.IdWarehouseNavigation)
                    .Where(x => (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS)
                    && x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional
                    && (idWarehouse > 0 ? x.IdWarehouse == idWarehouse : true));


            if (startDate.HasValue)
            {
                queryItemSalesDelivery = queryItemSalesDelivery.Where(x => DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, startDate.Value.Date) >= 0);
            }
            if (endDate.HasValue)
            {
                queryItemSalesDelivery = queryItemSalesDelivery.Where(x => DateTime.Compare(x.IdDocumentNavigation.DocumentDate.Date, endDate.Value.Date) <= 0);
            }
            List<DocumentLine> linesBL = queryItemSalesDelivery.ToList();
            List<DocumentLine> linesSales = linesBL.Where(p => p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery ||
            p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS).ToList();
            List<DocumentLine> linesAsset = linesBL.Where(p => p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset).ToList();
            var allSaleDocumenLine = linesSales?.GroupBy(x => (x.IdItem, x.IdWarehouse)).ToList();
            var allAssetDocumenLine = linesAsset?.GroupBy(x => (x.IdItem, x.IdWarehouse)).ToList();
            if (allSaleDocumenLine != null && allSaleDocumenLine.Any())
            {
                var listOfItem = new List<Item>();

                allSaleDocumenLine.ForEach(y =>
                {
                    listOfItem.Add(y.FirstOrDefault().IdItemNavigation);
                });
                //_serviceItemWarehouse.GetAllRealQuantityFolAllItem(listOfItem, y.);

                DailySalesLineViewModel dailySalesLineViewModel;
                IQueryable<Storage> storages = _entityStorageRepo.QuerableGetAll(x => x.IdShelfNavigation);

                allSaleDocumenLine.ForEach(a =>
                {

                    var documentLine = a.FirstOrDefault();
                    double assetQty = 0;
                    if (linesAsset != null && linesAsset.Any())
                    {
                        assetQty = linesAsset.Where(d => d.IdItem == documentLine.IdItem).Select(v => v.MovementQty).Sum();
                    }
                    var linesDeliverValidQty = a.Select(y => y.MovementQty).Sum();
                    ItemWarehouse itemWarehouseSelected = null;
                    if (documentLine.IdItemNavigation.ItemWarehouse != null && documentLine.IdItemNavigation.ItemWarehouse.Any())
                    {
                        itemWarehouseSelected = documentLine.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouse == a.Key.IdWarehouse).FirstOrDefault();
                    }

                    dailySalesLineViewModel = new DailySalesLineViewModel
                    {
                        Supplier = (documentLine.IdDocumentNavigation != null && documentLine.IdDocumentNavigation.IdTiersNavigation != null) ? documentLine.IdDocumentNavigation.IdTiersNavigation.Name : string.Empty,
                        CodeItem = documentLine.IdItemNavigation.Code,
                        Designation = documentLine.IdItemNavigation.Description,
                        WarehouseCode = documentLine.IdWarehouseNavigation != null ? documentLine.IdWarehouseNavigation.WarehouseCode : "",
                        WarehouseName = documentLine.IdWarehouseNavigation != null ? documentLine.IdWarehouseNavigation.WarehouseName : "",
                        Shelf = itemWarehouseSelected != null && itemWarehouseSelected.Shelf != null && itemWarehouseSelected.Shelf.Length > 0 ? itemWarehouseSelected.Shelf : (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ?
                       storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.IdShelfNavigation.Label).FirstOrDefault() : ""),

                        Storage = itemWarehouseSelected != null && itemWarehouseSelected.Storage != null && itemWarehouseSelected.Storage.Length > 0 ? itemWarehouseSelected.Storage :
                        (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ? storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.Label).FirstOrDefault() : ""),

                        ShelfStorage = itemWarehouseSelected != null ?
                       (itemWarehouseSelected.Shelf != null && itemWarehouseSelected.Shelf.Length > 0 ? itemWarehouseSelected.Shelf : (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ?
                       storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.IdShelfNavigation.Label).FirstOrDefault() : string.Empty)) +

                        (itemWarehouseSelected.Storage != null && itemWarehouseSelected.Storage.Length > 0 ? itemWarehouseSelected.Storage :
                        (itemWarehouseSelected != null && itemWarehouseSelected.IdStorage != null ? storages.Where(x => x.Id == itemWarehouseSelected.IdStorage).Select(y => y.Label).FirstOrDefault() : string.Empty))

                        : string.Empty,
                        SoldQty = 0,
                        ValidBLQty = linesDeliverValidQty - assetQty,
                        AvailableQty = itemWarehouseSelected != null ? itemWarehouseSelected.AvailableQuantity : 0
                    };
                    dailySalesLineViewModel.SoldQty = dailySalesLineViewModel.AvailableQty + dailySalesLineViewModel.ValidBLQty;
                    dailySalesLines.Add(dailySalesLineViewModel);

                });
            }

            return dailySalesLines.OrderBy(x => x.ShelfStorage).ToList();
        }

        #endregion
    }
}
