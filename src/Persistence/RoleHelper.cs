using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Settings.Config;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Utils.Enumerators.CommercialEnumerators;

namespace Persistence
{
    public class RoleHelper
    {
        public static string DASHBOARD_ROLE = "DASHBOARD";
        public static string MODULES_ROLE = "MODULES";
        public static string STOCK_ROLE = "STOCK";
        public static string SALES_ROLE = "VENTES";
        public static string RH_ROLE = "RH";
        public static string HR_ROLE = "RH";
        public static string PURCHASE_ROLE = "ACHATS";
        public static string SETTINGS_ROLE = "REGLAGES";
        public static string PAY_ROLE = "PAIE";
        public static string IMMOB_ROLE = "IMMOB";
        public static string HELPDESK_ROLE = "ASSISTANCE";
        public static string REPORTING_ROLE = "REPORTING";
        public static string ACCOUNTING_ROLE = "ACCOUNTING";
        public static string CRM_ROLE = "CRM";
        public static string MANUFACTURING_ROLE = "MANUFACTURING";
        public static string ADMIN_ROLE = "ADMIN";
        public static string CONSULTANT_ROLE = "CONSULTANT";
        public static string MANAGER_ROLE = "MANAGER";
        public static string RESP_RH_ROLE = "Responsable RH";
        public static string RESP_PAY_ROLE = "Responsable Pay";
        public static string NOTCONTROLLED_ROLE = "NOTCONTROLLED";
        public static string ALLOWANONYMOUS_ROLE = "ALLOWANONYMOUS";
        public static string ITEM_LIST_ROLE = "LISTE ARTICLE";
        public static string PURCHASE_PRICE_HISTORY_ROLE = "PURCHASEPRICEHISTORY";
        public static string Ecommerce_Config = "Gestion E-commerce";


        public static string SalesAsset_SaUpdate_Config = "SalesAsset_SaUpdate_Config";
        public static string SalesInvoice_SaUpdate_Config = "SalesInvoice_SaUpdate_Config";
        public static string SalesOrder_SaUpdate_Config = "SalesOrder_SaUpdate_Config";
        public static string SalesQuotation_SaUpdate_Config = "SalesQuotation_SaUpdate_Config";
        public static string BS_SaUpdate_Config = "BS_SaUpdate_Config";
        public static string BE_SaUpdate_Config = "BE_SaUpdate_Config";
        public static string PurchaseDelivery_SaUpdate_Config = "PurchaseDelivery_SaUpdate_Config";
        public static string PurchaseAsset_SaUpdate_Config = "PurchaseAsset_SaUpdate_Config";
        public static string PurchaseInvoice_SaUpdate_Config = "PurchaseInvoice_SaUpdate_Config";
        public static string PurchaseOrder_SaUpdate_Config = "PurchaseOrder_SaUpdate_Config";
        public static string PurchaseFinalOrder_SaUpdate_Config = "PurchaseFinalOrder_SaUpdate_Config";
        public static string PurchaseQuotation_SaUpdate_Config = "PurchaseQuotation_SaUpdate_Config";
        public static string PurchaseBudget_SaUpdate_Config = "PurchaseBudget_SaUpdate_Config";
        public static string ItemPrice_SaUpdate_Config = "ItemPrice_SaUpdate_Config";
        public static string SalesDelivery_SaUpdate_Config = "SalesDelivery_SaUpdate_Config";


        public static string Update_Valid_Order_SA = "UPDATE_VALID_ORDER_SALES";
        public static string Update_Valid_Delivery_SA = "UPDATE_VALID_DELIVERY_SALES";
        public static string Update_Valid_Asset_SA = "UPDATE_VALID_ASSET_SALES";
        public static string Update_Valid_BS = "UPDATE_VALID_EXIT_VOUCHERS";
        public static string Update_Valid_BE = "UPDATE_VALID_ADMISSION_VOUCHERS";
        public static string PurchaseDelivery_SaUpdate_Role = "Modification Bon de reception Validé";
        public static string PurchaseAsset_SaUpdate_Role = "Modification Avoir Achat Validé";
        public static string PurchaseInvoice_SaUpdate_Role = "Modification Facture Achat Validé";
        public static string PurchaseOrder_SaUpdate_Role = "Modification Commande Achat Validé";
        public static string PurchaseFinalOrder_SaUpdatRole = "Modification Commande Final Achat Validé";
        public static string PurchaseQuotation_SaUpdate_Role = "Modification Devis Achat Validé";
        public static string PurchaseBudget_SaUpdate_Role = "Modification Demande Achat Validé";
        public static string ItemPrice_SaUpdate_Role = "Modification Prix Article - SA";

        public static string Delete_ReservedDocLine = "DELETE_RESERVED_LINE";
        public static string Delete_DocLine = "DELETE_LINE_SALES";
        public static string Delete_Multiple_DocLine_SA = "DELETE_MULTIPLE_LINES_SALES";
        public static string Delete_Multiple_DocLine_PU = "DELETE_MULTIPLE_LINES_PURCHASE";
        public static string Delete_DocLine_PU = "DELETE_LINE_PURCHASE";
        public static string Delete_Multiple_DocLine_Stock_Correction = "DELETE_MULTIPLE_LINES_STOCK_CORRECTION";
        public static string Delete_DocLine_Stock_Correction = "DELETE_LINE_STOCK_CORRECTION";
        public static string DELIVER_SALES_DELIVERY = "DELIVER-BE";
        public static string Delete_Document_Sales = "Delete-Document_Sales";
        public static string Delete_Document_Purchase = "Delete-Document_Purchase";
        public static string Delete_Document_Stock = "Delete-Document_Stock";

        public static string Cancel_Order_Sales = "CANCEL_ORDER_SALES";

        public static string LIST_CONTRACT = "LIST_CONTRACT";
        public static string ADD_CONTRACT = "ADD_CONTRACT";
        public static string UPDATE_CONTRACT = "UPDATE_CONTRACT";

        protected static AppSettings _appSettings;
        public RoleHelper(IOptions<AppSettings> appSettings)
        {
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
        }
        public static bool HasPermission(string permissionName)
        {
            IList<string> permissionNames = new List<string>();
            permissionNames.Add(permissionName);
            return CheckIfUserHasPermission(permissionNames).Result;             
        }

        public static bool HasPermissions(IList<string> permissionNames)
        {
            return CheckIfUserHasPermission(permissionNames).Result;
        }
        public static async Task<bool> CheckIfUserHasPermission(IList<string> permissionNames)
        {
            AppHttpContext.Current.Request.Headers.TryGetValue("Authorization", out StringValues authorizationValue);
            string authorization = authorizationValue.First();
            AppHttpContext.Current.Request.Headers.TryGetValue("envUrl", out StringValues envurl);
            EnvUrl envUrl = JsonConvert.DeserializeObject<EnvUrl>(envurl.First());
            using (HttpClient httpClient = new HttpClient())
            {
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                httpClient.DefaultRequestHeaders.Add("Origin", envUrl.BaseUrl.ToString());
                httpClient.DefaultRequestHeaders.Add("Authorization", authorization);
                HttpResponseMessage response = await httpClient.PostAsync(envUrl.checkPermissionJavaApi, new StringContent(JsonConvert.SerializeObject(permissionNames), Encoding.UTF8, "application/json"))
                    .ConfigureAwait(continueOnCapturedContext: false);
                object responseData = JsonConvert.DeserializeObject(response.Content.ReadAsStringAsync().Result);
                bool result;
                if(bool.TryParse(responseData.ToString(),out result))
                {
                    
                    return result;
                }
                return false;
            }
        }
        public static bool hasDocumentPermission(List<string> actions, string documentType ,bool isResturn = false)
        {
            string typeDocumentName = "";
            if(documentType == DocumentEnumerator.PurchaseOrder || documentType == DocumentEnumerator.PurchaseBudget )
            {
                typeDocumentName = "ORDER_QUOTATION_PURCHASE";
            }
            else if (isResturn)
            {
                typeDocumentName = "FINANCIAL_ASSET_SALES";
            }
            else
            {
                var permissionEnum = typeof(DocumentPermissionsEnumerator).GetProperties(BindingFlags.Public | BindingFlags.Static);
                typeDocumentName = permissionEnum.FirstOrDefault(prop => (string)prop.GetValue(null) == documentType).Name;
            }
            
            string role = "";
            IList<string> permissionNames = new List<string>();
            if (actions.Count == 1)
            {
                role = actions[0] + "_" + typeDocumentName;
                permissionNames.Add(role);
            }
            else
            {
                foreach(var action in actions)
                {
                    role = action + "_" + typeDocumentName;
                    permissionNames.Add(role);
                }
            }  
            return CheckIfUserHasPermission(permissionNames).Result;
        }
    }
}