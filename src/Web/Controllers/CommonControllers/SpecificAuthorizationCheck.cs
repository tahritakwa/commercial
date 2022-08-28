using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Persistence;
using System;
using System.Collections.Generic;
using System.Text;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;

namespace Web.Controllers.CommonControllers
{
    public static class SpecificAuthorizationCheck
    {
        const string permission = "permissions";
        static  Dictionary<string, string> DocumentPermissions = new Dictionary<string, string>()
        {
            
            {"O-PU","ORDER_QUOTATION_PURCHASE"},
            {"D-PU","RECEIPT_PURCHASE"},
            {"FO-PU","FINAL_ORDER_PURCHASE"},
            {"I-PU","INVOICE_PURCHASE"},
            {"A-PU","ASSET_PURCHASE"},
            {"O-SA","ORDER_SALES"},
            {"D-SA","DELIVERY_SALES"},
            {"Q-SA","QUOTATION_SALES"},
            {"I-SA","INVOICE_SALES"},
            {"A-SA","ASSET_SALES"},
            {"IA-SA","INVOICE_ASSET_SALES"},
            {"TM","TRANSFER_MOVEMENT"},
            {"INV","INVENTORY_MOVEMENT"},
            {"BS-SA","EXIT_VOUCHERS"},
            {"BE-PU","ADMISSION_VOUCHERS"},
            {"B-PU", "ORDER_QUOTATION_PURCHASE" }
        };

        /// <summary>
        /// verify if user has authorization
        /// </summary>
        /// <param name="documentType">current document type</param>
        /// <param name="authorizationAction">current action (expl ADD, UPDATE ..)</param>
        /// <returns>bolean hasRole or Not</returns>
        public static bool DocumentAuthorization(string documentType, string authorizationAction, bool? isRestaurn = false)
        {
           
            StringBuilder role;

            if (authorizationAction == AutorizationActionConstants.AuthorizationDelete)
            {
                var isSalesDocument = documentType == DocumentEnumerator.SalesInvoice || documentType == DocumentEnumerator.SalesQuotation
             || documentType == DocumentEnumerator.SalesDelivery || documentType == DocumentEnumerator.SalesAsset
             || documentType == DocumentEnumerator.SalesOrder || documentType == DocumentEnumerator.SalesInvoiceAsset;
                if (isSalesDocument)
                {
                    role = new StringBuilder(authorizationAction).Append("_").Append("MULTIPLEDOCUMENTLINES_SA");
                }
                else
                {
                    role = new StringBuilder(authorizationAction).Append("_").Append("MULTIPLEDOCUMENTLINES_PU");
                }
            }
            else if (isRestaurn == true)
            {
                role = new StringBuilder(authorizationAction).Append("_").Append("FINANCIAL_ASSET_SALES");
            }
            else
            {
                role = new StringBuilder(authorizationAction).Append("_").Append(DocumentPermissions[documentType]);
            }
            return RoleHelper.HasPermission(role.ToString()); 
        }
        public static bool SettlementAuthorization(int idDirection, string authorizationAction, HttpContext httpContext)
        {
            // user permissions
            IList<string> permissions = JsonConvert.DeserializeObject<List<string>>(httpContext.Session.GetString(permission));
            var settlementDirection = Enum.GetName(typeof(PaymentDirectionEnumerator), idDirection);
            StringBuilder role = new StringBuilder(authorizationAction).Append("-").Append(settlementDirection);
            return permissions.Contains(role.ToString());
        }
        public static bool CheckAuthorizationByName(string authorizationName, HttpContext httpContext)
        {
            // user permissions
            IList<string> permissionNames = new List<string>();
            permissionNames.Add(authorizationName);
            return RoleHelper.CheckIfUserHasPermission(permissionNames).Result;
        }
    }
}
