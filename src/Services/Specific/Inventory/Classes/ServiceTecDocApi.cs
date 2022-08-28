using Microsoft.Extensions.Options;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using ViewModels.Builders.Specific.Inventory.Classes.TecDoc;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Classes
{
    class ServiceTecDocApi : IServiceTecDoc
    {

        static HttpClient client;
        private readonly IServiceItem _serviceItem;
        private readonly TecDocRequest _TecDoc;


        public ServiceTecDocApi(IServiceItem serviceItem, IOptions<OtherDataBaseSettings> appSettings)
        {
            _TecDoc = new TecDocRequest();
            client = new HttpClient();
            _serviceItem = serviceItem;
            client.BaseAddress = new Uri(appSettings.Value.GetewayAddress);
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));

        }
        public bool Check_connection()
        {
            throw new NotImplementedException();
        }

        public MySqlConnection Connect()
        {
            throw new NotImplementedException();
        }

        public void Disconnect(MySqlConnection connection)
        {
            throw new NotImplementedException();
        }

        public List<TecDocArticleViewModel> GetArticles(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var tecDocArticles = new List<TecDocArticleViewModel>();
            var JsonRequest = _TecDoc.GetArticlesWithStateRequest(teckDockWithFiltert.idPC.GetValueOrDefault(0), teckDockWithFiltert.idProduct.GetValueOrDefault(0), teckDockWithFiltert.UserMail);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            if (res != null)
            {
                var l = res.ToObject<List<TecDocRowArticleDetails>>();
                l.ForEach(article =>
                {
                    tecDocArticles.Add(TecDocArticleBuilder.buildArticleForGrid(article));
                });
                if (teckDockWithFiltert.idForB2b == true)
                {
                    tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFiltert);
                }
                else
                {
                    tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFiltert);
                }
            }
            return tecDocArticles;

        }

        public List<TecDocArticleViewModel> GetArticlesById(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            throw new NotImplementedException();
        }

        public List<TecDocArticleViewModel> GetArticlesByRef(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var tecDocArticles = new List<TecDocArticleViewModel>();
            var JsonRequest = _TecDoc.GetArticleDirectSearchAllNumbersWithStateRequest(teckDockWithFilter.TecDocReferance, 0, teckDockWithFilter.UserMail, false);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            if (res != null)
            {
                var l = res.ToObject<List<TecDocRowArticleDetails>>();
                l.ForEach(article =>
                {
                    tecDocArticles.Add(TecDocArticleBuilder.buildArticleForGrid(article));
                });
                if (teckDockWithFilter.idForB2b == true)
                {
                    tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFilter);
                }
                else
                {
                    tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
                }
            }
            return tecDocArticles;
        }

        public List<string> GetEnginesForDetails(ItemViewModel itemtecdoc)
        {
            List<TecDocVehicleRawDetails> Cars = GetTopPassengerCarApiForDetails(itemtecdoc);
            List<string> engines = Cars.Where(m => m.MotorCodes != null).Select(x => x.MotorCodes.Array).SelectMany(y => y.Select(r => r.MotorCode).ToList()).Distinct().ToList();
            return engines;
            throw new NotImplementedException();
        }

        public List<TecDocArticleViewModel> GetEquivalentTecDoc(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert)
        {
            List<TecDocArticleViewModel> resultList = new List<TecDocArticleViewModel>();
            var item = new ItemViewModel
            {
                TecDocRef = teckDockWithFiltert.TecDocReferance,
                TecDocIdSupplier = teckDockWithFiltert.idSupplier,
                userMail = teckDockWithFiltert.UserMail
            };
            var tecDocArticleBuilder = new TecDocArticleBuilder();
            var ItemTecdoc = GetTecdocDetailsApiForEquivalance(item);
            if (ItemTecdoc.ArticleNumber != null && ItemTecdoc.GenericArticles.Any())
            {
                var result = new List<TecDocArticleViewModel>();
                foreach (var itemGeneric in ItemTecdoc.GenericArticles)
                {
                    var equivalnceItem = GetTecdocEquivalance(teckDockWithFiltert.UserMail, ItemTecdoc.ArticleNumber, itemGeneric.genericArticleId)
                  .Select(x => tecDocArticleBuilder.buildArticleForGrid(x)).ToList();
                    result.AddRange(equivalnceItem);
                }

                resultList = _serviceItem.ExistsInDataBase(result, teckDockWithFiltert);

            }
            return resultList;
        }

        public List<TecDocManufacturersViewModel> GetManufacturers(string mail)
        {
            var JsonRequest = _TecDoc.GetManufacturerRequest(mail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ManufacturerList = res.ToObject<List<TecDocManufacturersViewModel>>();
            return ManufacturerList;
        }

        public List<TecDocMedia> GetMediaForDetails(ItemViewModel itemtecdoc)
        {

            List<TecDocMedia> medias = new List<TecDocMedia>();
            var JsonRequest = _TecDoc.GetArticlesMediaRequest(itemtecdoc.TecDocIdSupplier.Value, itemtecdoc.TecDocRef, itemtecdoc.userMail);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ManufacturerList = res.ToObject<List<TecDocRowArticleDetails>>()[0];
            ManufacturerList.Images.ForEach(x =>
            {
                medias.Add(new TecDocMedia
                {
                    Source = x.imageURL800,
                    Info = x.typeDescription,
                    mediaType = 1
                });
            });
            return medias;
        }

        public TecDocRowArticleDetails GetDocumentsForDetails(ItemViewModel itemtecdoc)
        {

            List<TecDocMedia> medias = new List<TecDocMedia>();
            var JsonRequest = _TecDoc.GetArticlesMediaRequest(itemtecdoc.TecDocIdSupplier.Value, itemtecdoc.TecDocRef, itemtecdoc.userMail);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ManufacturerList = res.ToObject<List<TecDocRowArticleDetails>>()[0];
            return ManufacturerList;
        }

        public List<TecDocModelSeriesViewModel> GetModelSeriesByMFA(int idMFA, string userMail)
        {
            var JsonRequest = _TecDoc.GetModelSeriesByMFARequest(idMFA, userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ModelSeriesList = res.ToObject<List<TecDocModelSeriesViewModel>>();
            return ModelSeriesList;
        }

        public List<TecDocPassengerCar> GetpassengerCarForDetails(ItemViewModel tecdoc)
        {
            throw new NotImplementedException();
        }

        public List<TecDocPassengerCar> GetPassengerCars(int idMFA, int idModellSerie, string userMail)
        {
            var JsonRequest = _TecDoc.GetPassengerCarsRequest(idMFA, idModellSerie, userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ModelSeriesList = res.ToObject<List<TecDocPassengerCar>>();
            return ModelSeriesList;
        }

        public List<TecDocProduct> GetProduct(int idPC, int idNode, string userMail)
        {
            var JsonRequest = _TecDoc.GetProductRequest(idPC, userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var ModelSeriesList = res.ToObject<List<TecDocProduct>>();
            ModelSeriesList = ModelSeriesList.FindAll(x => x.SearchTreeNodeId == idNode);
            return ModelSeriesList;
        }

        public List<TecDocProductTreeViewModel> GetProductTree(int idPassengerCar, string userMail)
        {
            var TecDocTreeListBuilder = new TecDocTreeListBuilder();
            var JsonRequest = _TecDoc.GetChildNodesPatternRequest(idPassengerCar, userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var FlatList = res.ToObject<List<TecDocApiTree>>();
            List<TecDocProductTreeViewModel> ProductTree = TecDocTreeListBuilder.BuildTree(FlatList);
            return ProductTree;
        }

        public List<TecDocBrandViewModel> GetTecDocBrands()
        {
            List<TecDocBrandViewModel> result = new List<TecDocBrandViewModel>();
            return result;
        }

        public List<TecDocArticleViewModel> GetTecDocByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter, bool isForEquivalence = false)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var tecDocArticles = new List<TecDocArticleViewModel>();
            var JsonRequest = _TecDoc.GetArticleDirectSearchAllNumbersWithStateRequest(teckDockWithFilter.oem, 10, teckDockWithFilter.UserMail, false);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            {
                var l = res.ToObject<List<TecDocRowArticleDetails>>();
                l.ForEach(article =>
                {
                    tecDocArticles.Add(TecDocArticleBuilder.buildArticleForGrid(article));
                });
                if (!isForEquivalence)
                {
                    if (teckDockWithFilter.idForB2b == true)
                    {
                        tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFilter);
                    }
                    else
                    {
                        tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
                    }
                }
            }
            return tecDocArticles;

        }

        public List<TecDocArticleViewModel> GetTecDocByExactOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var tecDocArticles = new List<TecDocArticleViewModel>();
            var JsonRequest = _TecDoc.GetItemByExactVAlue(teckDockWithFilter.oem, 10, teckDockWithFilter.UserMail);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            {
                var l = res.ToObject<List<TecDocRowArticleDetails>>();
                l.ForEach(article =>
                {
                    tecDocArticles.Add(TecDocArticleBuilder.buildArticleForGrid(article));
                });
                if (teckDockWithFilter.idForB2b == true)
                {
                    tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFilter);
                }
                else
                {
                    tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
                }
            }
            return tecDocArticles;

        }

        public TecDocRowArticleDetails GetTecdocDetailsApi(ItemViewModel tecdoc)
        {
            TecDocRowArticleDetails TecDoc = new TecDocRowArticleDetails();
            if (tecdoc.TecDocRef != null)
            {
                var JsonRequest = _TecDoc.GetArticlesRequest(tecdoc.userMail, tecdoc.TecDocIdSupplier.Value, tecdoc.TecDocRef);

                Task<JToken> task = SendToGetewayForArticles(JsonRequest);
                task.Wait();
                var res = task.Result;
                if (res.Count() > 0)
                {
                    TecDoc = res.ToObject<List<TecDocRowArticleDetails>>()[0];
                }
            }
            return TecDoc;
        }


        public TecDocRowArticleDetails GetTecdocDetailsApiForEquivalance(ItemViewModel tecdoc)
        {
            TecDocRowArticleDetails TecDoc = new TecDocRowArticleDetails();
            if (tecdoc.TecDocRef != null)
            {
                var JsonRequest = _TecDoc.GetArticlesRequestDetail(tecdoc.userMail, tecdoc.TecDocIdSupplier.Value, tecdoc.TecDocRef);

                Task<JToken> task = SendToGetewayForArticles(JsonRequest);
                task.Wait();
                var res = task.Result;
                if (res.Count() > 0)
                {
                    TecDoc = res.ToObject<List<TecDocRowArticleDetails>>()[0];
                }
            }
            return TecDoc;
        }

        public IList<TecDocRowArticleDetails> GetTecdocEquivalance(string useremail, string code, int genericArticle)
        {
            IList<TecDocRowArticleDetails> TecDoc = new List<TecDocRowArticleDetails>();
            if (code != null)
            {
                var JsonRequest = _TecDoc.GetEquivalanceRequest(useremail, genericArticle, code);

                Task<JToken> task = SendToGetewayForArticles(JsonRequest);
                task.Wait();
                var res = task.Result;
                if (res.Any())
                {
                    TecDoc = res.ToObject<List<TecDocRowArticleDetails>>();
                }
            }
            return TecDoc;
        }

        public TecDocDetailsViewModel GetTecdocDetails(ItemViewModel tecdoc)
        {
            throw new NotImplementedException();
        }

        public string GetTecDocDiscriptionByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            throw new NotImplementedException();
        }

        public List<TecDocArticleViewModel> GetTecDocItemsByBrand(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            throw new NotImplementedException();
        }

        public SupplierAddressViewModel GetTopBrandInfo(int supId, string userMail)
        {
            var JsonRequest = _TecDoc.GetAmBrandAddressRequest(supId, userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var Brand = res.ToObject<List<SupplierAddressViewModel>>()[0];
            return Brand;
        }

        public List<TecDocPassengerCar> GetTopPassengerCarForDetails(ItemViewModel tecdoc)
        {
            throw new NotImplementedException();
        }

        public List<TecDocVehicleRawDetails> GetTopPassengerCarApiForDetails(ItemViewModel tecdoc)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var res = new List<ArticleLinkage>();
            List<TecDocVehicleRawDetails> Cars = new List<TecDocVehicleRawDetails>();
            var JsonRequest = _TecDoc.GetArticleLinkedAllLinkingTarget3(tecdoc.TecDocId.Value, tecdoc.userMail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            try
            {
                res = task.Result[0]["articleLinkages"]["array"].ToObject<List<ArticleLinkage>>();
            }
            catch
            {
                res = new List<ArticleLinkage>();
            }
            var list = TecDocArticleBuilder.BuildCarIdArray(res);
            list.ForEach(vehicleIdList =>
            {
                var JsonRequest1 = _TecDoc.getVehicleByIds3(vehicleIdList, tecdoc.userMail);
                Task<JToken> task1 = SendToGeteway(JsonRequest1);
                task1.Wait();
                var res1 = task1.Result;
                Cars.AddRange(res1.ToObject<List<TecDocVehicleRawDetails>>());
            });
            return Cars;
        }



        static async Task<JToken> SendToGeteway(object obj)
        {
            HttpResponseMessage response = await client.PostAsJsonAsync(
                "tecdoc", obj);
            response.EnsureSuccessStatusCode();
            var Resp = response.Content.ReadAsAsync<JObject>();
            JObject list = Resp.Result;
            try
            {
                JToken listobj = list["data"]["array"];
                return listobj;
            }
            catch
            {
                return null;
            }

        }

        static async Task<JToken> SendToGetewayForArticles(object obj)
        {
            String objstr = obj.ToString();
            HttpResponseMessage response = await client.PostAsJsonAsync(
                "tecdoc", obj);
            response.EnsureSuccessStatusCode();
            var Resp = response.Content.ReadAsAsync<JObject>();
            JObject list = Resp.Result;
            JToken listobj = list["articles"];
            return listobj;
        }

        public List<SupplierAddressViewModel> GetBrandInfo(int supId, string mail)
        {
            var JsonRequest = _TecDoc.GetAmBrandAddressRequest(supId, mail);
            Task<JToken> task = SendToGeteway(JsonRequest);
            task.Wait();
            var res = task.Result;
            var Brands = res.ToObject<List<SupplierAddressViewModel>>();
            return Brands;
        }
        public List<TecDocArticleViewModel> GetArticlesByGlobalSearch(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            var TecDocArticleBuilder = new TecDocArticleBuilder();
            var tecDocArticles = new List<TecDocArticleViewModel>();
            var JsonRequest = _TecDoc.GetArticleDirectSearchAllNumbersWithStateRequest(teckDockWithFilter.GlobalSearch, 10, teckDockWithFilter.UserMail, teckDockWithFilter.isExactSearch.Value);
            Task<JToken> task = SendToGetewayForArticles(JsonRequest);
            task.Wait();
            var res = task.Result;
            if (res != null)
            {
                var l = res.ToObject<List<TecDocRowArticleDetails>>();
                l.ForEach(article =>
                {
                    tecDocArticles.Add(TecDocArticleBuilder.buildArticleForGrid(article));
                });
                tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
            }
            return tecDocArticles;
        }
    }
}
