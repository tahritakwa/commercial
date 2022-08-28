using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;
using ViewModels.DTO.Dashboard;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;

namespace Services.Specific.Dashboard.Interfaces
{
    public interface IServiceDashboard : IService<DocumentViewModel, Document>
    {
        bool CheckHasRole(dynamic datarole);
        bool CheckHasPermission(dynamic datarole);
        bool CheckHasRoleOrPermission(dynamic datarole);
        Task<IList<ChartDataElement>> GetKPIFromStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<SalesPurchasesStateDataElement>> GetKPIFromSalePurchaseStateStoredProcedure(ObjectToSaveViewModel objectToSave);   
        Task<IList<TopTiersChartElement>> GetKPIFromTopCustomerStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<TopTiersChartElement>> GetKPIFromTopSupplierStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<SalesPerItemDataElement>> GetKPIFromItemSaleStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<SalesPerItemDataElement>> GetKPIFromItemPurchaseStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<CardChartDataElement>> GetKPISalesTurnover();
        Task<IList<CardChartDataElement>> GetKPIPurchaseTurnover();
        Task<IList<CardChartDataElement>> GetKPITotalCustomers();
        Task<IList<SalesPurchasesStateDataElement>> GetKPICummulativeTurnover(ObjectToSaveViewModel objectToSave);
        Task<IList<TopTiersChartElement>> GetTierRank(int idTier);
        Task<IList<ChartDataElement>> GetKPIFromTotalWorkDaysStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<ChartDataElement>> GetKPIFromOrderStateStoredProcedure(ObjectToSaveViewModel objectToSave);
        Task<IList<ChartDataElement>> GetKPIFromDeliveryRateStoredProcedure(ObjectToSaveViewModel objectToSave);
        object GetKPITotalOrderB2B();



    }
}
