using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Dashboard.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Dashboard;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.DashboardController
{
    [Route("api/dashboard")]
    public class DashboardController : BaseController
    {
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceDashboard _serviceDashboard;
        private readonly IServiceUser _serviceUser;

        public DashboardController(IServiceProvider serviceProvider, ILogger<BaseController> logger,
            IOptions<AppSettings> appSettings, IServiceDocument serviceDocument,
            IServiceUser serviceUser, IServiceDashboard serviceDashboard) : base(serviceProvider, logger)
        {
            _serviceDashboard = serviceDashboard;
            _serviceDocument = serviceDocument;
            _serviceUser = serviceUser;
        }



        #region V2
        [HttpPost("GetRRCsMFSS")]
        public ResponseData GetReducedRoleConfigsModulesFuncsServerSession()
        {
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.GetSuccessfull,
                // objectData = RoleHelper.GetAllPermissions(), // ToDo: call the java api to get all permissions
                flag = 1
            };
        }


        [HttpPost("CheckHasOnlyRoles")]
        public ResponseData CheckHasOnlyRoles([FromBody] dynamic data)
        {
            GetUserMail();
            int iduser = _serviceUser.FindModelBy(x => x.Email == userMail).FirstOrDefault().Id;
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.GetSuccessfull,
                objectData = _serviceDashboard.CheckHasRole(data),
                flag = 1
            };
        }

        [HttpPost("CheckHasOnlyPermissions")]
        public ResponseData CheckHasOnlyPermissions([FromBody] dynamic data)
        {
            GetUserMail();
            int iduser = _serviceUser.FindModelBy(x => x.Email == userMail).FirstOrDefault().Id;
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.GetSuccessfull,
                objectData = _serviceDashboard.CheckHasPermission(data),
                flag = 1
            };
        }

        [HttpPost("CheckHasOnlyRolesPermissions")]
        public ResponseData CheckHasOnlyRolesPermissions([FromBody] dynamic data)
        {
            GetUserMail();
            int iduser = _serviceUser.FindModelBy(x => x.Email == userMail).FirstOrDefault().Id;

            return new ResponseData
            {
                customStatusCode = CustomStatusCode.GetSuccessfull,
                objectData = _serviceDashboard.CheckHasRoleOrPermission(data),
                flag = 1
            };
        }

        #endregion

        #region V1
        [HttpGet("supplierChart")]
        public IEnumerable<DocumentDashboard> AmountPerSupplier()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.PurchaseInvoiceAmountPerSupplier();
            return result;
        }
        [HttpGet("supplierDeliveryChart")]
        public IEnumerable<DocumentDashboard> DeliveryAmountPerSupplier()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.PurchaseDeliveryAmountPerSupplier();
            return result;
        }
        [HttpGet("supplierInvoiceChart")]
        public IEnumerable<DocumentDashboard> SupplierInvoiceAmountPerMonth()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.PurchaseInvoiceAmountPerMonth();
            return result;
        }
        [HttpGet("customerInvoiceChart")]
        public IEnumerable<DocumentDashboard> CustomerInvoiceAmountPerMonth()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.SaleInvoiceAmountPerMonth();
            return result;
        }
        [HttpGet("supplierDeliveryPerMonth")]
        public IEnumerable<DocumentDashboard> PurchaseDeliveryAmountPerMonth()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.PurchaseDeliveryAmountPerMonth();
            return result;
        }
        [HttpGet("techChartForSale")]
        public IEnumerable<DocumentDashboard> AmountPerCategoryInSalesInvoice()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.AmountPerCategoryInSalesInvoice();
            return result;
        }
        [HttpGet("techPerMonthChartForSale")]
        public IEnumerable<DocumentDashboard> AmountPerCategoryPerMonthInSalesInvoice()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.AmountPerCategoryPerMonthInSalesInvoice();
            return result;
        }
        [HttpGet("itemChartForPurchase")]
        public IEnumerable<DocumentDashboard> ItemPerCategoryInPurchaseOrder()
        {
            IEnumerable<DocumentDashboard> result;
            result = _serviceDocument.AmountItemPerCategoryInPurchaseOrder();
            return result;
        }

        [HttpGet("numberSalesInvoices")]
        public DocumentDashboard NumberSalesInvoices()
        {
            DocumentDashboard result;
            result = _serviceDocument.NumberSalesInvoices();
            return result;
        }

        [HttpGet("workforce")]
        public DocumentDashboard WorkforceNumber()
        {
            DocumentDashboard result;
            result = _serviceDocument.WorkforceNumber();
            return result;
        }

        [HttpGet("staffingTurnover")]
        public DocumentDashboard StaffingTurnover()
        {
            DocumentDashboard result;
            result = _serviceDocument.StaffingTurnover();
            return result;
        }
        [HttpGet("indirectStaffingTurnover")]
        public DocumentDashboard IndirectStaffingTurnover()
        {
            DocumentDashboard result;
            result = _serviceDocument.IndirectStaffingTurnover();
            return result;
        }
        #endregion

        #region Stored Procedure
        /// <summary>
        /// get TopCustomers
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromTopCustomerStoredProcedure"), Authorize("SALES_DASHBOARD")]
        public IList<TopTiersChartElement> GetKPIFromTopCustomerStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<TopTiersChartElement>> result = _serviceDashboard.GetKPIFromTopCustomerStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get tier rank
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("getTierRank/{id}"), Authorize("LIST_SUPPLIER,SHOW_SUPPLIER,UPDATE_SUPPLIER,SHOW_CUSTOMER,UPDATE_CUSTOMER")]
        public IList<TopTiersChartElement> GetTierRank(int id)
        {
            Task<IList<TopTiersChartElement>> result = _serviceDashboard.GetTierRank(id);
            return result.Result;
        }

        /// <summary>
        /// get TopSuppliers
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>

        [HttpPost("getKPIFromTopSupplierStoredProcedure"), Authorize("PURCHASE_DASHBOARD")]
        public IList<TopTiersChartElement> GetKPIFromTopSupplierStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<TopTiersChartElement>> result = _serviceDashboard.GetKPIFromTopSupplierStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get Purchases Sales
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>

        [HttpPost("getKPIFromPurchasesSalesStoredProcedure"), Authorize("PURCHASE_DASHBOARD,SALES_DASHBOARD")]
        public IList<SalesPurchasesStateDataElement> GetKPIFromPurchasesSalesStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<SalesPurchasesStateDataElement>> result = _serviceDashboard.GetKPIFromSalePurchaseStateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get Sales State
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>

        [HttpPost("getKPIFromSalePurchaseStateStoredProcedure"), Authorize("SALES_DASHBOARD,PURCHASE_DASHBOARD")]
        public IList<SalesPurchasesStateDataElement> GetKPIFromSaleStateStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<SalesPurchasesStateDataElement>> result = _serviceDashboard.GetKPIFromSalePurchaseStateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get Item Sales
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromItemSaleStoredProcedure"), Authorize("SALES_DASHBOARD")]
        public IList<SalesPerItemDataElement> GetKPIFromItemSaleStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<SalesPerItemDataElement>> result = _serviceDashboard.GetKPIFromItemSaleStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get Item Purchases
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromItemPurchaseStoredProcedure"), Authorize("PURCHASE_DASHBOARD")]
        public IList<SalesPerItemDataElement> getKPIFromItemPurchaseStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<SalesPerItemDataElement>> result = _serviceDashboard.GetKPIFromItemPurchaseStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// Get Order state
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromOrderStateStoredProcedure")]
        public IList<ChartDataElement> GetKPIFromOrderStateStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {

            Task<IList<ChartDataElement>> result = _serviceDashboard.GetKPIFromOrderStateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get Total work days by employee
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromTotalWorkDaysStoredProcedure")]
        public IList<ChartDataElement> GetKPIFromTotalWorkDaysStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<ChartDataElement>> result = _serviceDashboard.GetKPIFromTotalWorkDaysStoredProcedure(objectToSave);
            return result.Result;
        }



        /// <summary>
        /// get purshaces or sales delivery rate
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPIFromDeliveryRateStoredProcedure")]
        public IList<ChartDataElement> GetKPIFromDeliveryRateStoredProcedure([FromBody] ObjectToSaveViewModel objectToSave)
        {

            Task<IList<ChartDataElement>> result = _serviceDashboard.GetKPIFromDeliveryRateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get total orders b2b
        /// </summary>
        /// <returns></returns>

        [HttpGet("getTotalOrderB2B"), Authorize("SALES_DASHBOARD")]
        public object GetKPITotalOrderB2B()
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDashboard.GetKPITotalOrderB2B(),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// get customer Outstanding from stored procedure from SalePurchaseState Stored Procedure
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>

        [HttpPost("getKPICustomerOutstanding"), Authorize("TREASURY_SALES_DASHBOARD")]
        public IList<SalesPurchasesStateDataElement> GetKPICustomerOutstanding([FromBody] ObjectToSaveViewModel objectToSave)
        {

            Task<IList<SalesPurchasesStateDataElement>> result = _serviceDashboard.GetKPIFromSalePurchaseStateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get supplier outstanding from SalePurchaseState Stored Procedure
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPISupplierOutstanding"), Authorize("TREASURY_PURCHASE_DASHBOARD")]
        public IList<SalesPurchasesStateDataElement> GetKPISupplierOutstanding([FromBody] ObjectToSaveViewModel objectToSave)
        {

            Task<IList<SalesPurchasesStateDataElement>> result = _serviceDashboard.GetKPIFromSalePurchaseStateStoredProcedure(objectToSave);
            return result.Result;
        }

        /// <summary>
        /// get cummulative turnover sales from  SalePurchaseState stored procedure
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getKPICummulativeTurnover"), Authorize("SALES_DASHBOARD")]
        public IList<SalesPurchasesStateDataElement> GetKPICummulativeTurnover([FromBody] ObjectToSaveViewModel objectToSave)
        {
            Task<IList<SalesPurchasesStateDataElement>> result = _serviceDashboard.GetKPICummulativeTurnover(objectToSave);
            return result.Result;
        }


        /// <summary>
        /// get total turnover sales from cartes stored procedure
        /// </summary>
        /// <returns></returns>

        [HttpGet("getKPISalesTurnover"), Authorize("SALES_DASHBOARD")]
        public IList<CardChartDataElement> GetKPISalesTurnover()
        {
            Task<IList<CardChartDataElement>> result = _serviceDashboard.GetKPISalesTurnover();
            return result.Result;
        }

        /// <summary>
        /// get total turnover purchases from cartes stored procedure
        /// </summary>
        /// <returns></returns>
        /// 
        [HttpGet("getKPIPurchaseTurnover"), Authorize("PURCHASE_DASHBOARD")]
        public IList<CardChartDataElement> GetKPIPurchaseTurnover()
        {
            Task<IList<CardChartDataElement>> result = _serviceDashboard.GetKPIPurchaseTurnover();
            return result.Result;
        }

        /// <summary>
        /// Get total customers from cartes stored procedure
        /// </summary>
        /// <returns></returns>
        [HttpGet("getKPITotalCustomers"), Authorize("SALES_DASHBOARD")]
        public IList<CardChartDataElement> GetKPITotalCustomers()
        {
            Task<IList<CardChartDataElement>> result = _serviceDashboard.GetKPITotalCustomers();
            return result.Result;
        }


        #endregion
    }

}
