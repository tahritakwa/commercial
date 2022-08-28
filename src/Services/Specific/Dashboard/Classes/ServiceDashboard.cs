using Infrastruture.Utility;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Dashboard.Interfaces;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Dashboard;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;

namespace Services.Specific.Dashboard.Classes
{
    public class ServiceDashboard : Service<DocumentViewModel, Document>, IServiceDashboard
    {
        readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly IRepository<DocumentLine> _entityRepoDocumentLine;
        private readonly IRepository<Item> _entityRepoItem;
        private readonly IDocumentLineBuilder _documentLineBuilder;
        IRepository<Document> _entityRepoDocument;


        public ServiceDashboard(IRepository<Document> entityRepo,
            IUnitOfWork unitOfWork,
            IDocumentBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IServiceDocumentLine serviceDocumentLine,
            IRepository<DocumentLine> entityRepoDocumentLine,
             IRepository<Item> entityRepoItem,
            IDocumentLineBuilder documentLineBuilder,
             IRepository<Document> entityRepoDocument
            )
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceDocumentLine = serviceDocumentLine;
            _entityRepoDocumentLine = entityRepoDocumentLine;
            _documentLineBuilder = documentLineBuilder;
            _entityRepoItem = entityRepoItem;
            _entityRepoDocument = entityRepoDocument;

        }
       

        public bool CheckHasRole(dynamic datarole)
        {
            var roles = JsonConvert.DeserializeObject<List<string>>(datarole.ToString());
            return (RoleHelper.HasPermissions(roles));
        }

        public bool CheckHasPermission(dynamic datarole)
        {
            var roles = JsonConvert.DeserializeObject<List<string>>(datarole.ToString());
            return (RoleHelper.HasPermissions(roles));
        }

        public bool CheckHasRoleOrPermission(dynamic datarole)
        {
            return this.CheckHasPermission(datarole) || this.CheckHasRole(datarole);
        }

        private List<SqlParameter> GetParameterFromStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            string storedProcedureName = objectToSave.model.storedProcedureName;
            int numberOfRows;
            string tierType;
            string rankCriteria;
            int periodEnum;
            int month;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            switch (storedProcedureName)
            {
                case "[Reporting].[GetKPISalesPurchaseState]":
                    tierType = objectToSave.model.tierType;
                    periodEnum = objectToSave.model.periodEnum;
                    month = objectToSave.model.month;
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_BY_MONTH, month));
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
                    break;
                default:
                    numberOfRows = objectToSave.model.numberOfRows;
                    tierType = objectToSave.model.tierType;
                    rankCriteria = ((bool)objectToSave.model.rankCriteria) ? Constants.RANK_CRITERIA_AMOUNT : Constants.RANK_CRITERIA_QUANTITY;
                    periodEnum = objectToSave.model.periodEnum;
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_RANK_CRITERIA, rankCriteria));
                    parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
                    break;
            }
            return parametersOfSP;
        }

        private async Task<dynamic> GetDataFromStoredProdure(string nameOfStoredProcedure, List<SqlParameter> parametersOfSP, dynamic obj, dynamic returnObject)
        {
            try
            {
                Type type = obj.GetType();
                var _context = _unitOfWork.GetContext();
                var cmd = _context.Database.GetDbConnection().CreateCommand();
                //Name of stored procedure
                cmd.CommandText = nameOfStoredProcedure;
                cmd.CommandType = CommandType.StoredProcedure;
                // set the parameters of the stored procedure
                cmd.Parameters.Clear();
                foreach (var item in parametersOfSP)
                {
                    var parameter = new SqlParameter();
                    parameter.ParameterName = item.ParameterName;
                    parameter.Value = item.Value;
                    cmd.Parameters.Add(parameter);
                }

                if (cmd.Connection.State != ConnectionState.Open)
                {
                    cmd.Connection.Open();
                }
                var dataReader = await cmd.ExecuteReaderAsync();
                while (await dataReader.ReadAsync())
                {
                    dynamic dataRow = Activator.CreateInstance(type);
                    for (var iFiled = NumberConstant.Zero; iFiled < dataReader.FieldCount; iFiled++)
                    {
                        if (!dataReader.IsDBNull(iFiled))
                        {
                            var a = dataReader.GetName(iFiled);
                            dataRow.GetType().GetProperty(dataReader.GetName(iFiled)).SetValue(dataRow, dataReader[iFiled]);
                        }
                    }
                    returnObject.Add(dataRow);
                }
                return returnObject;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        public async Task<IList<ChartDataElement>> GetKPIFromStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            string storedProcedureName = objectToSave.model.storedProcedureName;
            return (IList<ChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, GetParameterFromStoredProcedure(objectToSave), new ChartDataElement(), new List<ChartDataElement>());

        }

        public async Task<IList<TopTiersChartElement>> GetTierRank(int idTier)
        {
            string storedProcedureName = "[Reporting].[GetKPIRankTiers]";
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_ID_TIER, idTier));
            return (IList<TopTiersChartElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP, new TopTiersChartElement(), new List<TopTiersChartElement>());
        }

        public async Task<IList<ChartDataElement>> GetKPIFromOrderStateStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            string storedProcedureName = objectToSave.model.storedProcedureName;
            int numberOfRows = objectToSave.model.numberOfRows;
            string tierType = objectToSave.model.tierType;
            int periodEnum = objectToSave.model.periodEnum;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
            return (IList<ChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP, new ChartDataElement(), new List<ChartDataElement>());

        }

        public async Task<IList<ChartDataElement>> GetKPIFromTotalWorkDaysStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            string storedProcedureName = objectToSave.model.storedProcedureName;
            string teamName = objectToSave.model.teamName;
            int month = objectToSave.model.month;
            int year = objectToSave.model.year;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_MONTH, month));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_YEAR, year));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_TEAM_NAME, teamName));
            return (IList<ChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP, new ChartDataElement(), new List<ChartDataElement>());

        }


        public object GetKPITotalOrderB2B()
        {
            dynamic returnObject = new ExpandoObject();
            IList<Document> allB2BDocument = _entityRepoDocument.GetAllWithConditions(x => x.IsBtoB == false && x.DocumentTypeCode == DocumentEnumerator.SalesOrder
            && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional).ToList();
            int currentMonth = DateTime.Now.Month;
            int lastMonth = DateTime.Now.AddMonths(-1).Month;
            returnObject.allCurrentMonth = allB2BDocument.Where(x => x.DocumentDate.Month == currentMonth).Count();
            returnObject.allLastMonth = allB2BDocument.Where(x => x.DocumentDate.Month == lastMonth).Count();
            returnObject.deliveredCurrentMonth = allB2BDocument.Where(x => x.DocumentDate.Month == currentMonth && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Valid).Count();
            returnObject.deliverLastMonth = allB2BDocument.Where(x => x.DocumentDate.Month == lastMonth && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Valid).Count();
            return returnObject;
        }

        public async Task<IList<ChartDataElement>> GetKPIFromDeliveryRateStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            string storedProcedureName = objectToSave.model.storedProcedureName;
            int byMonth = objectToSave.model.byMonth;
            int periodEnum = objectToSave.model.periodEnum;
            string type = objectToSave.model.type;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_BY_MONTH, byMonth));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, type));
            return (IList<ChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP, new ChartDataElement(), new List<ChartDataElement>());
        }

        public async Task<IList<TopTiersChartElement>> GetKPIFromTopCustomerStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            int numberOfRows;
            string rankCriteria;
            int periodEnum;

            string storedProcedureName = Constants.TOP_TIERS_KPI;
            string tierType = "SA";
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            numberOfRows = objectToSave.model.numberOfRows;
            rankCriteria = ((bool)objectToSave.model.rankCriteria) ? Constants.RANK_CRITERIA_AMOUNT : Constants.RANK_CRITERIA_QUANTITY;
            periodEnum = objectToSave.model.periodEnum;
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_RANK_CRITERIA, rankCriteria));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
            return (IList<TopTiersChartElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new TopTiersChartElement(), new List<TopTiersChartElement>());

        }
        public async Task<IList<TopTiersChartElement>> GetKPIFromTopSupplierStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            int numberOfRows;
            string rankCriteria;
            int periodEnum;
            string storedProcedureName = Constants.TOP_TIERS_KPI;
            string tierType = "PU";
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            numberOfRows = objectToSave.model.numberOfRows;
            rankCriteria = ((bool)objectToSave.model.rankCriteria) ? Constants.RANK_CRITERIA_AMOUNT : Constants.RANK_CRITERIA_QUANTITY;
            periodEnum = objectToSave.model.periodEnum;
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_RANK_CRITERIA, rankCriteria));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
            return (IList<TopTiersChartElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new TopTiersChartElement(), new List<TopTiersChartElement>());

        }

        public async Task<IList<SalesPerItemDataElement>> GetKPIFromItemPurchaseStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            int numberOfRows;
            string rankCriteria;
            int periodEnum;
            string storedProcedureName = Constants.SALES_PER_ITEM_KPI;
            string tierType = Constants.PURCHASE_OPERATION_TYPE;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            numberOfRows = objectToSave.model.numberOfRows;
            rankCriteria = ((bool)objectToSave.model.rankCriteria) ? Constants.RANK_CRITERIA_AMOUNT : Constants.RANK_CRITERIA_QUANTITY;
            periodEnum = objectToSave.model.periodEnum;
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_RANK_CRITERIA, rankCriteria));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
            return (IList<SalesPerItemDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new SalesPerItemDataElement(), new List<SalesPerItemDataElement>());

        }


        public async Task<IList<SalesPerItemDataElement>> GetKPIFromItemSaleStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
            int numberOfRows;
            string rankCriteria;
            int periodEnum;
            string storedProcedureName = Constants.SALES_PER_ITEM_KPI;
            string tierType = Constants.SALE_OPERATION_TYPE;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            numberOfRows = objectToSave.model.numberOfRows;
            rankCriteria = ((bool)objectToSave.model.rankCriteria) ? Constants.RANK_CRITERIA_AMOUNT : Constants.RANK_CRITERIA_QUANTITY;
            periodEnum = objectToSave.model.periodEnum;
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, tierType));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_RANK_CRITERIA, rankCriteria));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_NUMBER_OF_ROWS, numberOfRows));
            return (IList<SalesPerItemDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new SalesPerItemDataElement(), new List<SalesPerItemDataElement>());


        }
        public async Task<IList<SalesPurchasesStateDataElement>> GetKPIFromSalePurchaseStateStoredProcedure(ObjectToSaveViewModel objectToSave)
        {
         
            string storedProcedureName = Constants.SALES_PURCHASE_STATE_KPI;
            string operationType = objectToSave.model.operationType;
            int month = objectToSave.model.month;
            int periodEnum = objectToSave.model.periodEnum;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_BY_MONTH, month));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, operationType));
            return (IList<SalesPurchasesStateDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new SalesPurchasesStateDataElement(), new List<SalesPurchasesStateDataElement>());

        }
        public async Task<IList<CardChartDataElement>> GetKPISalesTurnover()
        {
            string storedProcedureName = Constants.CARTES_KPI;
            string label = Constants.SALES_TURNOVER_MONTH_LABEL;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_LABEL, label));
            return (IList<CardChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                   new CardChartDataElement(), new List<CardChartDataElement>());

        }

        public async Task<IList<CardChartDataElement>> GetKPIPurchaseTurnover()
        {
            string storedProcedureName = Constants.CARTES_KPI;
            string label = Constants.PURCHASE_TURNOVER_MONTH_LABEL;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_LABEL, label));
            return (IList<CardChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                   new CardChartDataElement(), new List<CardChartDataElement>());

        }

        public async Task<IList<CardChartDataElement>> GetKPITotalCustomers()
        {
            string storedProcedureName = Constants.CARTES_KPI;
            string label = Constants.CUSTOMER_LABEL;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_LABEL, label));
            return (IList<CardChartDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                   new CardChartDataElement(), new List<CardChartDataElement>());

        }

        public async Task<IList<SalesPurchasesStateDataElement>> GetKPICummulativeTurnover(ObjectToSaveViewModel objectToSave)
        {
            int periodEnum = objectToSave.model.periodEnum;
            int month = objectToSave.model.month;
            string storedProcedureName = Constants.SALES_PURCHASE_STATE_KPI;
            string operationType = objectToSave.model.operationType;
            List<SqlParameter> parametersOfSP = new List<SqlParameter>();
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_PERIOD, periodEnum));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_BY_MONTH, month));
            parametersOfSP.Add(new SqlParameter(Constants.PARAMETER_OPERATION_TYPE, operationType));
            return (IList<SalesPurchasesStateDataElement>)await GetDataFromStoredProdure(storedProcedureName, parametersOfSP,
                new SalesPurchasesStateDataElement(), new List<SalesPurchasesStateDataElement>());

        }


    }
}
