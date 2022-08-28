using MySql.Data.MySqlClient;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceTecDoc
    {
        MySqlConnection Connect();
        List<TecDocManufacturersViewModel> GetManufacturers(string mail);
        List<TecDocModelSeriesViewModel> GetModelSeriesByMFA(int idMFA, string userMail);
        List<TecDocPassengerCar> GetPassengerCars(int idMFA,int idModellSerie, string userMail);
        void Disconnect(MySqlConnection connection);
        bool Check_connection();
        List<TecDocProductTreeViewModel> GetProductTree(int idPassengerCar, string userMail);
        List<TecDocProduct> GetProduct(int idPC, int idNode, string userMail);
        List<TecDocArticleViewModel> GetArticles(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert);
        List<TecDocArticleViewModel> GetEquivalentTecDoc(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert);
        List<TecDocArticleViewModel> GetArticlesByRef(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        List<TecDocArticleViewModel> GetArticlesById(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        List<TecDocArticleViewModel> GetTecDocByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter, bool isForEquivalence = false);
        string GetTecDocDiscriptionByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        TecDocDetailsViewModel GetTecdocDetails(ItemViewModel tecdoc);
        List<TecDocPassengerCar> GetpassengerCarForDetails(ItemViewModel tecdoc);
        List<TecDocPassengerCar> GetTopPassengerCarForDetails(ItemViewModel tecdoc);
        List<string> GetEnginesForDetails(ItemViewModel itemtecdoc);
        List<TecDocMedia> GetMediaForDetails(ItemViewModel itemtecdoc);
        List<TecDocBrandViewModel> GetTecDocBrands();
        TecDocRowArticleDetails GetTecdocDetailsApi(ItemViewModel tecdoc);
        List<TecDocArticleViewModel> GetTecDocItemsByBrand(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        SupplierAddressViewModel GetTopBrandInfo(int supId, string userMail);
        List<SupplierAddressViewModel> GetBrandInfo(int supId, string userMail);
        TecDocRowArticleDetails GetDocumentsForDetails(ItemViewModel itemtecdoc);
        List<TecDocVehicleRawDetails> GetTopPassengerCarApiForDetails(ItemViewModel itemtecdoc);
        List<TecDocArticleViewModel> GetTecDocByExactOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        List<TecDocArticleViewModel> GetArticlesByGlobalSearch(TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
    }
}
