using Newtonsoft.Json.Linq;
using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocRequest
    {
        public JObject GetManufacturerRequest(string mail)
        {
            var res = new JObject(
                new JProperty("getManufacturers",
                new JObject(
                    new JProperty("country", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("linkingTargetType", "p"),
                    new JProperty("mail", mail)
                )));
            return res;
        }

        public JObject GetModelSeriesByMFARequest(int ManufacturerId, string mail)
        {
            var res = new JObject(
                new JProperty("getModelSeries",
                new JObject(
                    new JProperty("country", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("linkingTargetType", "p"),
                    new JProperty("manuId", ManufacturerId),
                    new JProperty("mail", mail)
                )));
            return res;
        }
        public JObject GetPassengerCarsRequest(int ManufacturerId, int ModelId, string mail)
        {
            var res = new JObject(
                new JProperty("getVehicleIdsByCriteria",
                new JObject(
                    new JProperty("countriesCarSelection", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("carType", "P"),
                    new JProperty("manuId", ManufacturerId),
                    new JProperty("modId", ModelId),
                    new JProperty("mail", mail)
                )));
            return res;
        }
        public JObject GetChildNodesPatternRequest(int idPassengerCar, string mail)
        {
            var res = new JObject(
                new JProperty("getChildNodesPattern",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("linkingTargetType", "P"),
                    new JProperty("linkingTargetId", idPassengerCar),
                    new JProperty("mail", mail)
                )));
            return res;
        }
        public JObject GetProductRequest(int idPassengerCar, string mail)
        {
            var res = new JObject(
                new JProperty("getGenericArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchTreeNodes", true),
                    new JProperty("linked", true),
                    new JProperty("linkingTargetType", "P"),
                    new JProperty("linkingTargetId", idPassengerCar),
                    new JProperty("mail", mail)
                )));
            return res;
        }
        public JObject GetArticlesRequest(string mail, int IdSupplier = 0, string TecdocRef = "")
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchTreeNodes", true),
                    new JProperty("searchQuery", TecdocRef),
                    new JProperty("searchMatchType", "exact"),
                    new JProperty("dataSupplierIds", new JArray(IdSupplier)),
                    new JProperty("includeGTINs", true),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("includeArticleCriteria", true),
                    new JProperty("includeArticleText", true),
                    new JProperty("includeMisc", true),
                    new JProperty("perPage", 1000),
                    new JProperty("includeOEMNumbers", true),
                    new JProperty("mail", mail)
                )));
            return res;
        }

        public JObject GetArticlesRequestDetail(string mail, int IdSupplier = 0, string TecdocRef = "")
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchTreeNodes", true),
                    new JProperty("searchQuery", TecdocRef),
                    new JProperty("searchMatchType", "exact"),
                    new JProperty("dataSupplierIds", new JArray(IdSupplier)),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("perPage", 1000),
                    new JProperty("mail", mail)
                )));
            return res;
        }


        public JObject GetEquivalanceRequest(string mail, int genericArticleIds = 0, string TecdocRef = "")
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchType", 3),
                    new JProperty("genericArticleIds", genericArticleIds),
                    new JProperty("searchTreeNodes", true),
                    new JProperty("searchQuery", TecdocRef),
                    new JProperty("searchMatchType", "exact"),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("includeGTINs", true),
                    new JProperty("includeImages", true),
                    new JProperty("perPage", 1000),
                    new JProperty("mail", mail)
                )));
            return res;
        }


        public JObject GetArticlesMediaRequest(int IdSupplier, string TecdocRef, string mail)
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchTreeNodes", true),
                    new JProperty("searchQuery", TecdocRef),
                    new JProperty("searchMatchType", "exact"),
                    new JProperty("dataSupplierIds", new JArray(IdSupplier)),
                    new JProperty("includePDFs", true),
                    new JProperty("includeImages", true),
                    new JProperty("perPage", 1),
                    new JProperty("includeLinks", true),
                    new JProperty("mail", mail)
                )));
            return res;
        }

        public JObject GetArticlesWithStateRequest(int IdPassengerCar, int IdProduct, string mail)
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("genericArticleIds", IdProduct),
                    new JProperty("linkageTargetType", "P"),
                    new JProperty("linkageTargetId", IdPassengerCar),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("perPage", 1000),
                    new JProperty("includeGTINs", true),
                    new JProperty("includeImages", true),
                    new JProperty("mail", mail),
                    new JProperty("includeOEMNumbers", true)
                )));
            return res;
        }


        public JObject GetArticleDirectSearchAllNumbersWithStateRequest(string TecDocNumber, int NumberType, string mail, bool isExact)
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchQuery", TecDocNumber),
                    new JProperty("searchType", NumberType),
                    new JProperty("searchMatchType", isExact ? "exact" : "prefix_or_suffix"),
                    new JProperty("includeGTINs", true),
                    new JProperty("perPage", 1000),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("includeImages", true),
                    new JProperty("mail", mail),
                    new JProperty("includeOEMNumbers", true)
                )));
            return res;
        }


        public JObject GetItemByExactVAlue(string TecDocNumber, int NumberType, string mail)
        {
            var res = new JObject(
                new JProperty("getArticles",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("searchQuery", TecDocNumber),
                    new JProperty("searchType", NumberType),
                    new JProperty("includeGTINs", true),
                    new JProperty("perPage", 1000),
                    new JProperty("includeGenericArticles", true),
                    new JProperty("mail", mail)
                )));
            return res;
        }


        public JObject GetAmBrandAddressRequest(int IdBrand, string mail)
        {
            var res = new JObject(
                new JProperty("getAmBrandAddress",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("brandNo", IdBrand),
                    new JProperty("mail", mail)
                )));
            return res;
        }

        public JObject GetArticleLinkedAllLinkingTarget3(int IdArticle, string mail)
        {
            var res = new JObject(
                new JProperty("getArticleLinkedAllLinkingTarget3",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("articleId", IdArticle),
                    new JProperty("linkingTargetType", "P"),
                    new JProperty("mail", mail)
                )));
            return res;
        }

        public JObject getVehicleByIds3(List<int> CarIds, string mail)
        {
            var res = new JObject(
                new JProperty("getVehicleByIds3",
                new JObject(
                    new JProperty("articleCountry", "TN"),
                    new JProperty("countriesCarSelection", "TN"),
                    new JProperty("country", "TN"),
                    new JProperty("lang", "FR"),
                    new JProperty("carIds",
                        new JObject(
                    new JProperty("array", CarIds))),
                    new JProperty("linkingTargetType", "P"),
                    new JProperty("motorCodes", true),
                    new JProperty("mail", mail)
                )));
            return res;
        }
    }
}
