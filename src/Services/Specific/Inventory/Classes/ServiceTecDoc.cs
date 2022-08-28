using Microsoft.Extensions.Options;
using MySql.Data.MySqlClient;
using Services.Specific.Inventory.Classes.TecDocFactory;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Specific.Inventory.Classes.TecDoc;
using ViewModels.Comparers;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceTecDoc : IServiceTecDoc
    {
        TecDocTreeListBuilder TecDocTreeListBuilder;
        private readonly IServiceItem _serviceItem;
        readonly int COUNTTRYCODE = 50; //TN = 197  GER = 50  FR = 75 GBR = 77
        readonly int LANGUAGE = 6; //FR = 6 EN = 4
        readonly TecDoc2019q1SQLQueries TecDoc;
        readonly string TecDocMediaRoot;

        public ServiceTecDoc(IServiceItem serviceItem, IOptions<OtherDataBaseSettings> appSettings)
        {
            _serviceItem = serviceItem;
            var connexion = ManageDBConnections.BuildConnectionStringMySql(appSettings.Value);
            TecDoc = new TecDoc2019q1SQLQueries(connexion);
            TecDocMediaRoot = appSettings.Value.MediaRoot;
        }


        public bool Check_connection()
        {
            bool result = false;
            MySqlConnection connection = new MySqlConnection(TecDoc.ConnectionString);
            try
            {
                connection.Open();
                result = true;
                connection.Close();
            }
            catch
            {
                result = false;
            }
            return result;
        }

        public MySqlConnection Connect()
        {
            MySqlConnection connection = new MySqlConnection(TecDoc.ConnectionString);
            try
            {
                connection.Open();
            }
#pragma warning disable CS0168 // The variable 'exc' is declared but never used
            catch (Exception exc)
#pragma warning restore CS0168 // The variable 'exc' is declared but never used
            {
                return connection;
            }
            return connection;
        }

        public void Disconnect(MySqlConnection connection)
        {
            connection.Close();
        }
        // Selecting list of manufacturers for the passenger cars
        public List<TecDocManufacturersViewModel> GetManufacturers(string mail)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetManufacturersQuery(COUNTTRYCODE);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocManufacturersViewModel> MFAList = new List<TecDocManufacturersViewModel>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                MFAList.Add(new TecDocManufacturersViewModel
                {
                    ManuId = rdr.GetInt32("MFA_ID"),
                    ManuName = rdr.GetString("MFA_BRAND")
                });
            }
            Disconnect(cnx);
            return MFAList;
        }


        // Selecting list of model series for the manufacturer of passenger
        public List<TecDocModelSeriesViewModel> GetModelSeriesByMFA(int idMFA,string UserMail)
        {

            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetModelSeriesQuery(LANGUAGE, COUNTTRYCODE, idMFA);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocModelSeriesViewModel> ModellSeriesList = new List<TecDocModelSeriesViewModel>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                ModellSeriesList.Add(new TecDocModelSeriesViewModel
                {
                    ModelId = rdr.GetInt32("MS_ID"),
                    ModelName = rdr.GetString("MS_NAME")
                });
            }
            Disconnect(cnx);
            return ModellSeriesList;
        }


        // Selecting list of passenger car models for the model series
        public List<TecDocPassengerCar> GetPassengerCars(int idMFA, int idModellSerie, string userMail)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetPassengerCarQuery(LANGUAGE, COUNTTRYCODE, idModellSerie);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocPassengerCar> TecDocPassengerCarList = new List<TecDocPassengerCar>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                TecDocPassengerCarList.Add(new TecDocPassengerCar
                {
                    CarId = rdr.GetInt32("PC_ID"),
                    CarName = rdr.GetString("TYPEL"),
                    ConstructionStartInterval = SafeGetDate(rdr, 2),
                    ConstructionEndInterval = SafeGetDate(rdr, 3),
                    PowerKW = SafeGetDecimal(rdr, 4),
                    PowerPS = SafeGetDecimal(rdr, 5),
                    CapacityTech = SafeGetDecimal(rdr, 6),
                    BodyType = rdr.GetString("BODYTYPE")
                });
            }
            Disconnect(cnx);
            return TecDocPassengerCarList;
        }

        public List<TecDocProductTreeViewModel> GetProductTree(int idPassengerCar, string userMail)
        {
            MySqlConnection cnx = Connect();
            TecDocTreeListBuilder = new TecDocTreeListBuilder();
            string sql = TecDoc.GetProductTreeQuery(LANGUAGE, idPassengerCar);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocProductListModelView> tecDocProductList = new List<TecDocProductListModelView>();
            List<TecDocProductTreeViewModel> TecDocProductTreeList = new List<TecDocProductTreeViewModel>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            tecDocProductList = TecDocTreeListBuilder.BuildList(rdr);
            TecDocProductTreeList = TecDocTreeListBuilder.BuildTree(tecDocProductList);
            Disconnect(cnx);
            return TecDocProductTreeList;
        }

        public List<TecDocProduct> GetProduct(int idPC, int idNode, string userMail)
        {
            List<TecDocProduct> Products = new List<TecDocProduct>();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetProductQuery(LANGUAGE, COUNTTRYCODE, idPC, idNode);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Products.Add(new TecDocProduct
                {
                    Designation = rdr.GetString(0),
                    GenericArticleId = rdr.GetInt32(1)
                });
            }
            Disconnect(cnx);
            return Products;
        }

        public List<TecDocArticleViewModel> GetArticles(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetArticlesQuery(LANGUAGE, COUNTTRYCODE, teckDockWithFiltert.idPC ?? 0, teckDockWithFiltert.idProduct ?? 0);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticles.Add(new TecDocArticleViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    Description = SafeGetString(rdr, 2),
                    Supplier = SafeGetString(rdr, 3),
                    IdSupplier = rdr.GetInt32(4),
                    BarCode = SafeGetString(rdr, 5)
                });

            }
            if (teckDockWithFiltert.idForB2b == true)
            {
                tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFiltert);
            }
            else
            {
                tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFiltert);
            }
            Disconnect(cnx);
            return tecDocArticles;
        }

        public List<TecDocArticleViewModel> GetEquivalentTecDoc(TeckDockWithWarehouseFilterViewModel teckDockWithFiltert)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetEquivalentTecDocQuery(LANGUAGE, COUNTTRYCODE, teckDockWithFiltert.TecDocReferance, teckDockWithFiltert.idSupplier ?? 0);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticles.Add(new TecDocArticleViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    Description = SafeGetString(rdr, 2),
                    Supplier = SafeGetString(rdr, 3),
                    IdSupplier = rdr.GetInt32(4),
                    BarCode = SafeGetString(rdr, 5)
                });

            }
            tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFiltert);
            Disconnect(cnx);
            return tecDocArticles;
        }

        public List<TecDocArticleViewModel> GetArticlesById(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            if (teckDockWithFilter == null)
            {
                return tecDocArticles;
            }
            string sql = TecDoc.GetArticlesByIdQuery(LANGUAGE, COUNTTRYCODE, teckDockWithFilter.idPC);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticles.Add(new TecDocArticleViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    Description = SafeGetString(rdr, 2),
                    Supplier = SafeGetString(rdr, 3),
                    IdSupplier = rdr.GetInt32(4),
                    BarCode = SafeGetString(rdr, 5)
                });
            }
            tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
            Disconnect(cnx);
            return tecDocArticles;
        }

        public List<TecDocArticleViewModel> GetArticlesByRef(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetArticlesByRefQuery(LANGUAGE, COUNTTRYCODE, teckDockWithFilter.TecDocReferance, teckDockWithFilter.idSupplier);
            if (!string.IsNullOrEmpty(sql))
            {
                MySqlCommand cmd = new MySqlCommand(sql, cnx);
                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    tecDocArticles.Add(new TecDocArticleViewModel
                    {
                        Id = rdr.GetInt32(0),
                        Reference = SafeGetString(rdr, 1),
                        Description = SafeGetString(rdr, 2),
                        Supplier = SafeGetString(rdr, 3),
                        IdSupplier = rdr.GetInt32(4),
                        BarCode = SafeGetString(rdr, 5)
                    });
                }
                if (teckDockWithFilter.idForB2b == true)
                {
                    tecDocArticles = _serviceItem.ExistsInDataBaseForB2B(tecDocArticles, teckDockWithFilter);
                }
                else
                {
                    tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
                }
                Disconnect(cnx);
            }
            return tecDocArticles;
        }

        public string GetTecDocDiscriptionByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            string description = "";
            MySqlConnection cnx = Connect();

            string sql = TecDoc.GetFirstTecDocByOemQuery(teckDockWithFilter.oem, COUNTTRYCODE, LANGUAGE);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                description = SafeGetString(rdr, 0);
            }
            Disconnect(cnx);
            return (description);
        }
        public List<TecDocArticleViewModel> GetTecDocByOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter, bool isForEquivalence = false)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            string description = GetTecDocDiscriptionByOem(teckDockWithFilter);
            string sql = TecDoc.GetTecDocByOemQuery(teckDockWithFilter.oem, teckDockWithFilter.idSupplier, COUNTTRYCODE, LANGUAGE);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticles.Add(new TecDocArticleViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    Description = description,
                    IdSupplier = rdr.GetInt32(2),
                    Supplier = SafeGetString(rdr, 3),
                });
            }
            tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
            Disconnect(cnx);
            return tecDocArticles;
        }
        public DateTime? SafeGetDate(MySqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader.GetDateTime(colIndex);
            return null;
        }
        public string SafeGetString(MySqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader.GetString(colIndex);
            return null;
        }
        public decimal SafeGetDecimal(MySqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader.GetDecimal(colIndex);
            return 0;
        }

        public TecDocDetailsViewModel GetTecdocDetails(ItemViewModel tecdoc)
        {
            TecDocDetailsViewModel tecDocArticle = new TecDocDetailsViewModel();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetTecdocDetailsQuery(LANGUAGE, COUNTTRYCODE, tecdoc.TecDocId.Value);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticle = new TecDocDetailsViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    PackUnit = rdr.GetInt32(2),
                    QtyPerUnit = SafeGetDecimal(rdr, 3),
                    SupplierBrand = SafeGetString(rdr, 4),
                    SupplierId = rdr.GetInt32(5),
                    SupplierLogo = SafeGetString(rdr, 6),
                    ProductName = SafeGetString(rdr, 7),
                    Information = SafeGetString(rdr, 8),
                    Criteria = SafeGetString(rdr, 9),
                    OemNumbers = SafeGetString(rdr, 10),
                    EanNumbers = SafeGetString(rdr, 11)
                };
            }
            Disconnect(cnx);
            return (tecDocArticle);
        }

        public List<TecDocPassengerCar> GetpassengerCarForDetails(ItemViewModel tecdoc)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetpassengerCarForDetailsQuery(LANGUAGE, COUNTTRYCODE, tecdoc.TecDocId.Value);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocPassengerCar> TecDocPassengerCarList = new List<TecDocPassengerCar>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                TecDocPassengerCarList.Add(new TecDocPassengerCar
                {
                    TermsOfUse = SafeGetString(rdr, 0) != null ? SafeGetString(rdr, 0).Split(';') : null,
                    CarId = rdr.GetInt32(1),
                    CarName = SafeGetString(rdr, 2),
                    ConstructionStartInterval = SafeGetDate(rdr, 3),
                    ConstructionEndInterval = SafeGetDate(rdr, 4),
                    PowerKW = SafeGetDecimal(rdr, 5),
                    PowerPS = SafeGetDecimal(rdr, 6),
                    CapacityTech = SafeGetDecimal(rdr, 7),
                    BodyType = SafeGetString(rdr, 8),
                    EngineCodeList = SafeGetString(rdr, 9) != null ? SafeGetString(rdr, 9).Split(',') : null
                });
            }
            Disconnect(cnx);
            return TecDocPassengerCarList;
        }

        public List<TecDocPassengerCar> GetTopPassengerCarForDetails(ItemViewModel tecdoc)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetTopPassengerCarForDetailsQuery(LANGUAGE, COUNTTRYCODE, tecdoc.TecDocId.Value);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocPassengerCar> TecDocPassengerCarList = new List<TecDocPassengerCar>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                TecDocPassengerCarList.Add(new TecDocPassengerCar
                {
                    TermsOfUse = SafeGetString(rdr, 0) != null ? SafeGetString(rdr, 0).Split(';') : null,
                    CarId = rdr.GetInt32(1),
                    CarName = SafeGetString(rdr, 2),
                    ConstructionStartInterval = SafeGetDate(rdr, 3),
                    ConstructionEndInterval = SafeGetDate(rdr, 4),
                    PowerKW = SafeGetDecimal(rdr, 5),
                    PowerPS = SafeGetDecimal(rdr, 6),
                    CapacityTech = SafeGetDecimal(rdr, 7),
                    BodyType = SafeGetString(rdr, 8),
                    EngineCodeList = SafeGetString(rdr, 9) != null ? SafeGetString(rdr, 9).Split(',') : null
                });
            }
            Disconnect(cnx);
            return TecDocPassengerCarList;
        }

        public List<string> GetEnginesForDetails(ItemViewModel tecdoc)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetEnginesForDetailsQuery(LANGUAGE, COUNTTRYCODE, tecdoc.TecDocId.Value);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<string> TecDocEngineList = new List<string>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            string[] noelement = null;
            while (rdr.Read())
            {
                if (SafeGetString(rdr, 0) != null)
                {
                    TecDocEngineList.AddRange(SafeGetString(rdr, 0) != null ? SafeGetString(rdr, 0).Split(';', ',') : noelement);
                }
            }
            TecDocEngineList = TecDocEngineList.Distinct().ToList();
            Disconnect(cnx);
            return TecDocEngineList;
        }

        public List<TecDocMedia> GetMediaForDetails(ItemViewModel tecdoc)
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetMediaQuery(LANGUAGE, COUNTTRYCODE, tecdoc.TecDocId.Value);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocMedia> TecDocMediaList = new List<TecDocMedia>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                TecDocMediaList.Add(new TecDocMedia
                {
                    mediaType = rdr.GetInt32(0),
                    Source = rdr.GetInt32(0) == 1 ? TecDocMediaRoot + SafeGetString(rdr, 1).ToUpper() : SafeGetString(rdr, 1).ToUpper(),
                    Info = SafeGetString(rdr, 3),
                });
            }
            Disconnect(cnx);
            return TecDocMediaList;
        }
        public List<TecDocBrandViewModel> GetTecDocBrands()
        {
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetBrandsQuery();
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            List<TecDocBrandViewModel> TecDocMediaList = new List<TecDocBrandViewModel>();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                TecDocMediaList.Add(new TecDocBrandViewModel
                {
                    Id = rdr.GetInt32(0),
                    Name = SafeGetString(rdr, 1),
                    Code = SafeGetString(rdr, 2)
                });
            }
            Disconnect(cnx);
            return TecDocMediaList;
        }
        public List<TecDocArticleViewModel> GetTecDocItemsByBrand(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            List<TecDocArticleViewModel> tecDocArticles = new List<TecDocArticleViewModel>();
            MySqlConnection cnx = Connect();
            if (teckDockWithFilter == null)
            {
                return tecDocArticles;
            }
            string sql = TecDoc.GetTecDocItemsByBrand(LANGUAGE, COUNTTRYCODE, teckDockWithFilter.idSupplier);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tecDocArticles.Add(new TecDocArticleViewModel
                {
                    Id = rdr.GetInt32(0),
                    Reference = SafeGetString(rdr, 1),
                    Description = SafeGetString(rdr, 2),
                    Supplier = SafeGetString(rdr, 3),
                    IdSupplier = rdr.GetInt32(4),
                    BarCode = SafeGetString(rdr, 5)
                });
            }
            tecDocArticles = _serviceItem.ExistsInDataBase(tecDocArticles, teckDockWithFilter);
            Disconnect(cnx);
            return tecDocArticles;
        }

        public SupplierAddressViewModel GetTopBrandInfo(int supId, string userMail)
        {
            SupplierAddressViewModel supplierAdress = new SupplierAddressViewModel();
            MySqlConnection cnx = Connect();
            string sql = TecDoc.GetTopAddress(supId);
            MySqlCommand cmd = new MySqlCommand(sql, cnx);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                supplierAdress = new SupplierAddressViewModel
                {
                    SupId = rdr.GetInt32(0),
                    AddressType = rdr.GetInt32(1),
                    City = SafeGetString(rdr, 2),
                    City2 = SafeGetString(rdr, 3),
                    Street = SafeGetString(rdr, 4),
                    Street2 = SafeGetString(rdr, 5),
                    Email = SafeGetString(rdr, 6),
                    wwwURL = SafeGetString(rdr, 7),
                    Name = SafeGetString(rdr, 8),
                    Name2 = SafeGetString(rdr, 9),
                    Mailbox = SafeGetString(rdr, 10),
                    Zip = SafeGetString(rdr, 11),
                    ZipMailbox = SafeGetString(rdr, 12),
                    ZipSpecial = SafeGetString(rdr, 13),
                    ZipCountryCode = SafeGetString(rdr, 14),
                    Fax = SafeGetString(rdr, 15),
                    Phone = SafeGetString(rdr, 16)
                };
            }
            Disconnect(cnx);
            return supplierAdress;

        }

        public TecDocRowArticleDetails GetTecdocDetailsApi(ItemViewModel tecdoc)
        {
            throw new NotImplementedException();
        }

        public List<TecDocVehicleRawDetails> GetTopPassengerCarApiForDetails(ItemViewModel itemtecdoc)
        {
            throw new NotImplementedException();
        }

        public List<SupplierAddressViewModel> GetBrandInfo(int supId,string mail)
        {
            throw new NotImplementedException();
        }

        public TecDocRowArticleDetails GetDocumentsForDetails(ItemViewModel itemtecdoc)
        {
            throw new NotImplementedException();
        }

        public List<TecDocArticleViewModel> GetTecDocByExactOem(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            throw new NotImplementedException();
        }
        public List<TecDocArticleViewModel> GetArticlesByGlobalSearch(TeckDockWithWarehouseFilterViewModel teckDockWithFilter)
        {
            throw new NotImplementedException();
        }

    }

}
