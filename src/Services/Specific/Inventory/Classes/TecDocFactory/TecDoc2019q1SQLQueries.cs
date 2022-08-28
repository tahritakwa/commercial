using System;
using System.Text.RegularExpressions;

namespace Services.Specific.Inventory.Classes.TecDocFactory
{
    public class TecDoc2019q1SQLQueries
    {
        public string ConnectionString { get; private set; }

        public TecDoc2019q1SQLQueries(string connectionString)
        {
            ConnectionString = connectionString;
        }

        /// <summary>
        /// Query To Get list of manufacturers for the passenger cars
        /// </summary>
        /// <param name="COUNTTRYCODE">the country constraints</param>
        /// <returns></returns>
        public string GetManufacturersQuery(int COUNTTRYCODE)
        {
            return "SELECT MFA_ID,MFA_BRAND FROM MANUFACTURERS INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = MANUFACTURERS.MFA_PC_CTM AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + " WHERE MANUFACTURERS.MFA_PC = 1 ORDER BY MFA_BRAND; ";

        }
        /// <summary>
        /// Query To Get list of model series for the manufacturer of passenger
        /// </summary>
        /// <param name="LANGUAGE">the display language</param>
        /// <param name="COUNTTRYCODE">the country constraints</param>
        /// <param name="idMFA">the Id of Manufacturer</param>
        /// <returns></returns>
        public string GetModelSeriesQuery(int LANGUAGE, int COUNTTRYCODE, int idMFA)
        {

            return "SELECT DISTINCT "
                + "MS_ID, get_text(MS_COUNTRY_SPECIFICS.MSCS_NAME_DES," + LANGUAGE + ") AS MS_NAME " + "FROM MODELS_SERIES "
                + "INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = MODELS_SERIES.MS_PC_CTM "
                + "AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + " "
                + "INNER JOIN MS_COUNTRY_SPECIFICS ON MS_COUNTRY_SPECIFICS.MSCS_ID = MODELS_SERIES.MS_ID "
                + "AND(MS_COUNTRY_SPECIFICS.MSCS_COU_ID = " + COUNTTRYCODE + " OR MS_COUNTRY_SPECIFICS.MSCS_COU_ID = 255) "
                + "AND MS_COUNTRY_SPECIFICS.MSCS_AXL = 0 "
                + "WHERE MODELS_SERIES.MS_MFA_ID = " + idMFA + " AND MODELS_SERIES.MS_PC = 1;";
        }

        /// <summary>
        /// Query to Get list of manufacturers for the passenger cars
        /// </summary>
        /// <param name="LANGUAGE">the display language</param>
        /// <param name="COUNTTRYCODE">the country constraints</param>
        /// <param name="idModellSerie">the Id of Model Serie</param>
        /// <returns></returns>
        public string GetPassengerCarQuery(int LANGUAGE, int COUNTTRYCODE, int idModelSerie)
        {
            return "SELECT"
            + " PC_ID,"
            + " get_text(PASSENGER_CARS.PC_MODEL_DES, " + LANGUAGE + ") AS TYPEL,"
            + " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_START,"
            + " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_END,"
            + " PC_COUNTRY_SPECIFICS.PCS_POWER_KW,"
            + " PC_COUNTRY_SPECIFICS.PCS_POWER_PS,"
            + " PC_COUNTRY_SPECIFICS.PCS_CAPACITY_TAX,"
            + " get_text(PC_COUNTRY_SPECIFICS.PCS_BODY_TYPE, " + LANGUAGE + ") AS BODYTYPE"
            + " FROM"
            + " PASSENGER_CARS"
            + " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = PASSENGER_CARS.PC_CTM"
            + " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""

            + " INNER JOIN PC_COUNTRY_SPECIFICS ON PC_COUNTRY_SPECIFICS.PCS_PC_ID = PASSENGER_CARS.PC_ID"
            + " AND(PC_COUNTRY_SPECIFICS.PCS_COU_ID = " + COUNTTRYCODE + " OR PC_COUNTRY_SPECIFICS.PCS_COU_ID = 255)"

            + " INNER JOIN MODELS_SERIES ON MODELS_SERIES.MS_ID = " + idModelSerie + ""

            + " INNER JOIN MANUFACTURERS ON MANUFACTURERS.MFA_ID = PASSENGER_CARS.PC_MFA_ID"

            + " INNER JOIN MS_COUNTRY_SPECIFICS ON MS_COUNTRY_SPECIFICS.MSCS_ID = MODELS_SERIES.MS_ID"
            + " AND(MS_COUNTRY_SPECIFICS.MSCS_COU_ID = " + COUNTTRYCODE + " OR MS_COUNTRY_SPECIFICS.MSCS_COU_ID = 255)"
            + " AND MS_COUNTRY_SPECIFICS.MSCS_AXL = 0"

            + " WHERE"
            + " PASSENGER_CARS.PC_MS_ID = " + idModelSerie + ""
            + " AND MODELS_SERIES.MS_PC = 1";
        }
        /// <summary>
        /// Query to Build tree of the products groups for a passenger car
        /// </summary>
        /// <param name="LANGUAGE">the display language</param>
        /// <param name="idPC">Passanger Car ID</param>
        /// <returns></returns>

        public string GetProductTreeQuery(int LANGUAGE, int idPC)
        {
            return
    "SELECT DISTINCT         SEARCH_TREE.STR_LEVEL,     " +
"ELT(SEARCH_TREE.STR_LEVEL," +
 "get_text(SEARCH_TREE.STR_DES_ID, " + LANGUAGE + ")," +
  "get_text(PARENT_NODE1.STR_DES_ID, " + LANGUAGE + ")," +
   "get_text(PARENT_NODE2.STR_DES_ID, " + LANGUAGE + ")," +
    "get_text(PARENT_NODE3.STR_DES_ID, " + LANGUAGE + ")) AS ROOT_NODE_TEXT," +
     "ELT(SEARCH_TREE.STR_LEVEL," +
      "SEARCH_TREE.STR_ID," +
       "PARENT_NODE1.STR_ID," +
"PARENT_NODE2.STR_ID," +
 "PARENT_NODE3.STR_ID) AS ROOT_NODE_STR_ID," +
  "ELT(SEARCH_TREE.STR_LEVEL - 1," +
   "get_text(SEARCH_TREE.STR_DES_ID, " + LANGUAGE + ")," +
    "get_text(PARENT_NODE1.STR_DES_ID, " + LANGUAGE + ")," +
     "get_text(PARENT_NODE2.STR_DES_ID, " + LANGUAGE + ")," +
      "get_text(PARENT_NODE3.STR_DES_ID, " + LANGUAGE + ") ) AS NODE_1_TEXT," +
"ELT(SEARCH_TREE.STR_LEVEL - 1," +
 "SEARCH_TREE.STR_ID," +
  "PARENT_NODE1.STR_ID," +
   "PARENT_NODE2.STR_ID," +
    "PARENT_NODE3.STR_ID) AS NODE_1_STR_ID," +
     "ELT(SEARCH_TREE.STR_LEVEL - 2," +
      "get_text(SEARCH_TREE.STR_DES_ID, " + LANGUAGE + ")," +
       "get_text(PARENT_NODE1.STR_DES_ID, " + LANGUAGE + ")," +
"get_text(PARENT_NODE2.STR_DES_ID, " + LANGUAGE + ")," +
 "get_text(PARENT_NODE3.STR_DES_ID, " + LANGUAGE + ")) AS NODE_2_TEXT," +
  "ELT(SEARCH_TREE.STR_LEVEL - 2," +
   "SEARCH_TREE.STR_ID," +
    "PARENT_NODE1.STR_ID," +
     "PARENT_NODE2.STR_ID," +
      "PARENT_NODE3.STR_ID) AS NODE_2_STR_ID," +
"ELT(SEARCH_TREE.STR_LEVEL - 3," +
 "get_text(SEARCH_TREE.STR_DES_ID, " + LANGUAGE + ")," +
  "get_text(PARENT_NODE1.STR_DES_ID, " + LANGUAGE + ")," +
   "get_text(PARENT_NODE2.STR_DES_ID, " + LANGUAGE + ")," +
    "get_text(PARENT_NODE3.STR_DES_ID, " + LANGUAGE + ") ) AS NODE_3_TEXT, " +
     "ELT(SEARCH_TREE.STR_LEVEL - 3," +
"SEARCH_TREE.STR_ID, " +
 "PARENT_NODE1.STR_ID, " +
  "PARENT_NODE2.STR_ID, " +
   "PARENT_NODE3.STR_ID) AS NODE_3_STR_ID " +
    "FROM " +
     "LINK_LA_TYP " +
      "INNER JOIN LINK_PT_STR ON LINK_PT_STR.STR_TYPE = 1 AND LINK_PT_STR.PT_ID = LINK_LA_TYP.LAT_PT_ID " +
       "INNER JOIN SEARCH_TREE ON SEARCH_TREE.STR_ID = LINK_PT_STR.STR_ID AND SEARCH_TREE.STR_TYPE = 1 " +
        "LEFT JOIN SEARCH_TREE AS PARENT_NODE1 ON PARENT_NODE1.STR_ID = SEARCH_TREE.STR_ID_PARENT AND PARENT_NODE1.STR_TYPE = 1 " +
         "LEFT JOIN SEARCH_TREE AS PARENT_NODE2 ON PARENT_NODE2.STR_ID = PARENT_NODE1.STR_ID_PARENT AND PARENT_NODE2.STR_TYPE = 1 " +
          "LEFT JOIN SEARCH_TREE AS PARENT_NODE3 ON PARENT_NODE3.STR_ID = PARENT_NODE2.STR_ID_PARENT AND PARENT_NODE3.STR_TYPE = 1 " +
"WHERE " +
 "LINK_LA_TYP.LAT_TYP_ID = " + idPC + " AND LINK_LA_TYP.LAT_TYPE = 2 " +
  "ORDER BY " +
   "ROOT_NODE_TEXT, " +
    "NODE_1_TEXT,     " +
"NODE_2_TEXT,  " +
 "NODE_3_TEXT";
        }
        public string GetProductQuery(int LANGUAGE, int COUNTTRYCODE, int idPC, int idNode)
        {
            return
                "SELECT DISTINCT"
 + " get_text(PRODUCTS.PT_DES_ID, " + LANGUAGE + ") AS \"PRODUCT GROUP\","
 + " PRODUCTS.PT_ID"
 + " FROM"
 + " SEARCH_TREE"
 + " INNER JOIN LINK_PT_STR ON LINK_PT_STR.STR_ID = " + idNode
 + " AND LINK_PT_STR.STR_TYPE = 1"
+ " INNER JOIN LINK_LA_TYP ON LINK_LA_TYP.LAT_TYP_ID = " + idPC + ""
+ " AND LINK_LA_TYP.LAT_TYPE = 2"
+ " AND LINK_LA_TYP.LAT_PT_ID = LINK_PT_STR.PT_ID"
+ " INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"



+ " INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
+ " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM"
+ " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE



+ " INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
+ " INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_LA_TYP.LAT_PT_ID"
+ " WHERE"
+ " SEARCH_TREE.STR_ID = " + idNode
+ " AND SEARCH_TREE.STR_TYPE = 1"
+ " ORDER BY \"PRODUCT GROUP\"";
        }

        public string GetArticlesQuery(int LANGUAGE, int COUNTTRYCODE, int idPC, int idProduct)
        {
            return " SELECT DISTINCT"
 + " ARTICLES.ART_ID,"
 + " ARTICLES.ART_ARTICLE_NR,"
  + " CONCAT_WS(\" - \",get_text(ARTICLES.ART_COMPLETE_DES_ID, " + LANGUAGE + "),get_text(ARTICLES.ART_DES_ID, " + LANGUAGE + ")) AS DESCRIPTIONS,"
 + " ARTICLES.ART_SUP_BRAND,"
 + " ARTICLES.ART_SUP_ID,"
    + " ART_EAN_NUMBERS.EAN_NUM"
 + " FROM"
 + " LINK_LA_TYP"
 + " INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"
 + " INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
 + " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM"
 + " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
 + " INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID"
 + " AND(ART_COUNTRY_SPECIFICS.ACS_COU_ID =  " + COUNTTRYCODE + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
 + " INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
 + " INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_LA_TYP.LAT_PT_ID"
+ " INNER JOIN ART_EAN_NUMBERS ON ART_EAN_NUMBERS.ART_ID= ARTICLES.ART_ID "
 + " WHERE"
 + " LINK_LA_TYP.LAT_TYP_ID = " + idPC + ""
 + " AND LINK_LA_TYP.LAT_TYPE = 2"
 + " AND LINK_LA_TYP.LAT_PT_ID = " + idProduct + "";
        }

        public string GetArticlesByRefQuery(int LANGUAGE, int COUNTTRYCODE, string RefTecDoc, int? IdSupplier)
        {
            if (!string.IsNullOrEmpty(RefTecDoc))
            {
                var refTecDoc_normalize = RefTecDoc.Normalize(System.Text.NormalizationForm.FormD);
                var refTeckdo = Regex.Replace(refTecDoc_normalize, @"[\u0300-\u036f]", "");
                var refTecDocNorm = Regex.Replace(refTeckdo, @"[^a-zA-Z0-9]", "");

                string res = "SELECT DISTINCT"
              + " ARTICLES.ART_ID,"
              + " ARTICLES.ART_ARTICLE_NR,"
              + " CONCAT_WS(' ',"
              + " (SELECT"
              + " GROUP_CONCAT(get_text(PRODUCTS.PT_DES_ID, " + LANGUAGE + ") SEPARATOR ',')"
              + " FROM"
              + " LINK_ART_PT"
              + " INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_ART_PT.LAP_PT_ID"
              + " WHERE"
              + " LINK_ART_PT.LAP_ART_ID = ARTICLES.ART_ID),"
              + " get_text(ARTICLES.ART_DES_ID, " + LANGUAGE + ") ) AS DESCRIPTIONS,"
              + " SUPPLIERS.SUP_BRAND,"
              + " SUPPLIERS.SUP_ID,"
              + " (SELECT"
              + " GROUP_CONCAT(ART_EAN_NUMBERS.EAN_NUM SEPARATOR 0x0a)"
              + " FROM"
              + " ART_EAN_NUMBERS"
              + " WHERE"
              + " ART_EAN_NUMBERS.ART_ID = ARTICLES.ART_ID) AS EAN_NUMBERS"
              + " FROM"
              + " ARTICLES  partition(ART_NR_" + refTecDocNorm.Substring(0, 1) + ")"
              + " INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID"
              + " INNER JOIN SUPPLIERS ON ARTICLES.ART_SUP_ID = SUP_ID"
              + " "
              + " WHERE"
              + " ARTICLES.ART_ARTICLE_NR_TRIM = '" + refTecDocNorm + "'";
                if (IdSupplier != 0)
                {
                    res = res + " AND SUPPLIERS.SUP_ID = " + IdSupplier;
                }
                return res;
            }
            else
            {
                return "";
            }

        }
        public string GetArticlesByIdQuery(int LANGUAGE, int COUNTTRYCODE, int? TecDocId)
        {
            return ("SELECT DISTINCT"
                  + " ARTICLES.ART_ID,"
                  + " ARTICLES.ART_ARTICLE_NR,"
                  + " CONCAT_WS(' - ', get_text(ARTICLES.ART_COMPLETE_DES_ID, " + LANGUAGE + "), get_text(ARTICLES.ART_DES_ID, " + LANGUAGE + ")) AS DESCRIPTIONS,"
                  + " SUPPLIERS.SUP_BRAND,"
                  + " SUPPLIERS.SUP_ID,"
                  + " ART_EAN_NUMBERS.EAN_NUM"
                  + " FROM"
                  + " LINK_LA_TYP"
                  + " INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"
                  + " INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
                  + " INNER JOIN COUNTRY_RESTRICTIONS"
                  + " ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM"
                  + " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
                  + " INNER JOIN ART_COUNTRY_SPECIFICS"
                  + " ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID"
                  + " AND(ART_COUNTRY_SPECIFICS.ACS_COU_ID = " + COUNTTRYCODE + ""
                  + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
                  + " INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
                  + " INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_LA_TYP.LAT_PT_ID"
                  + " INNER JOIN ART_EAN_NUMBERS ON ART_EAN_NUMBERS.ART_ID= ARTICLES.ART_ID "
                  + " WHERE"
                  + " LINK_ART.LA_ART_ID = " + TecDocId + "  ORDER BY SUP_BRAND, ART_ID");
        }

        public string GetTecDocByOemQuery(string OEM, int? IdSupplier, int COUNTTRYCODE, int LANGUAGE)
        {
            var OemTecDoc_normalize = OEM.Normalize(System.Text.NormalizationForm.FormD);
            var OemTeckdo = Regex.Replace(OemTecDoc_normalize, @"[\u0300-\u036f]", "");
            var OemTecDocNorm = Regex.Replace(OemTeckdo, @"[^a-zA-Z0-9]", "");
            string OemTecDocUpper = OemTecDocNorm.ToUpper();
            string partitionindex;
            if (OemTecDocUpper.Length > 1)
            {
                partitionindex = OemTecDocUpper.Substring(0, 2);
                bool isNumeric = int.TryParse(partitionindex, out int n);

                if (!isNumeric)
                {
                    partitionindex = partitionindex.Substring(0, 1);
                }
            }
            else
            {
                partitionindex = OemTecDocUpper.Substring(0, 1);
            }


            string res = "SELECT DISTINCT"
                  + "  ARTICLES.ART_ID,"
                  + "  ARTICLES.ART_ARTICLE_NR, "
                  + "  SUPPLIERS.SUP_ID,       "
                  + "  SUPPLIERS.SUP_BRAND"
                  + "  FROM"
                  + "  LINK_LA_TYP"
                  + "  INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"
                  + "  INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
                  + "  INNER JOIN ART_OEM_NUMBERS PARTITION(OEM_" + partitionindex + ") ON ART_OEM_NUMBERS.ART_ID = ARTICLES.ART_ID"
                  + "  INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM   AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
                  + "  INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID AND(ART_COUNTRY_SPECIFICS.ACS_COU_ID = " + COUNTTRYCODE + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
                  + "  INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
                  + "  WHERE"
                  + "  LINK_LA_TYP.LAT_TYPE = 2"
                  + "  AND ART_OEM_NUMBERS.OEM_NUM_TRIM = '" + OemTecDocUpper + "'";

            if (IdSupplier != 0)
            {
                res = res + " AND SUPPLIERS.SUP_ID = " + IdSupplier;
            }
            return res;
        }

        public string GetFirstTecDocByOemQuery(string OEM, int COUNTTRYCODE, int LANGUAGE)
        {
            var OemTecDoc_normalize = OEM.Normalize(System.Text.NormalizationForm.FormD);
            var OemTeckdo = Regex.Replace(OemTecDoc_normalize, @"[\u0300-\u036f]", "");
            var OemTecDocNorm = Regex.Replace(OemTeckdo, @"[^a-zA-Z0-9]", "");
            string OemTecDocUpper = OemTecDocNorm.ToUpper();
            string partitionindex;
            if (OemTecDocUpper.Length > 1)
            {
                partitionindex = OemTecDocUpper.Substring(0, 2);
                bool isNumeric = int.TryParse(partitionindex, out int n);

                if (!isNumeric)
                {
                    partitionindex = partitionindex.Substring(0, 1);
                }
            }
            else
            {
                partitionindex = OemTecDocUpper.Substring(0, 1);
            }


            return ("SELECT DISTINCT"
                  + "  get_text(ARTICLES.ART_COMPLETE_DES_ID, " + LANGUAGE + ")"
                  + "  FROM"
                  + "  LINK_LA_TYP"
                  + "  INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"
                  + "  INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
                  + "  Inner JOIN ART_OEM_NUMBERS PARTITION(OEM_" + partitionindex + ") ON ART_OEM_NUMBERS.ART_ID = ARTICLES.ART_ID"
                  + "  INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM   AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
                  + "  INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID AND(ART_COUNTRY_SPECIFICS.ACS_COU_ID = " + COUNTTRYCODE + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
                  + "  INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
                  + "  WHERE"
                  + "  LINK_LA_TYP.LAT_TYPE = 2"
                  + "  AND ART_OEM_NUMBERS.OEM_NUM_TRIM = '" + OemTecDocUpper + "' LIMIT 1"
                  );
        }




        public string GetEquivalentTecDocQuery(int LANGUAGE, int COUNTTRYCODE, string RefTecDoc, int IdSupplier)
        {
            return "SELECT DISTINCT"
                + " ARTICLES_CROSSES.ART_ID,"
                + " ARTICLES_CROSSES.ART_ARTICLE_NR,"
                + " CONCAT_WS(' - ', get_text(ARTICLES_CROSSES.ART_COMPLETE_DES_ID, " + LANGUAGE + "), get_text(ARTICLES_CROSSES.ART_DES_ID, " + LANGUAGE + ")) AS DESCRIPTIONS,"
                + " SUPPLIERS_CROSSES.SUP_BRAND,"
                + " ARTICLES_CROSSES.ART_SUP_ID,"
                    + " ART_EAN_NUMBERS.EAN_NUM"
                + " FROM"
                + " ARTICLES"
                + " INNER JOIN LINK_ART_PT ON LINK_ART_PT.LAP_ART_ID = ARTICLES.ART_ID"
                + " INNER JOIN ART_OEM_NUMBERS ON ART_OEM_NUMBERS.ART_ID = ARTICLES.ART_ID"
                + " INNER JOIN ART_OEM_NUMBERS AS ART_OEM_NUMBERS_CROSS"
                + " ON ART_OEM_NUMBERS_CROSS.OEM_NUM = ART_OEM_NUMBERS.OEM_NUM"
                + " AND ART_OEM_NUMBERS_CROSS.MFA_ID = ART_OEM_NUMBERS.MFA_ID"
                + " AND ART_OEM_NUMBERS_CROSS.ART_ID != ARTICLES.ART_ID"
                + " INNER JOIN ARTICLES AS ARTICLES_CROSSES"
                + " ON ARTICLES_CROSSES.ART_ID = ART_OEM_NUMBERS_CROSS.ART_ID"
                + " INNER JOIN LINK_ART_PT AS CROSS_LINK_ART_PT"
                + " ON CROSS_LINK_ART_PT.LAP_ART_ID = ARTICLES_CROSSES.ART_ID"
                + " AND CROSS_LINK_ART_PT.LAP_PT_ID = LINK_ART_PT.LAP_PT_ID"
                + " INNER JOIN COUNTRY_RESTRICTIONS AS COUNTRY_RESTRICTIONS_CROSSES"
                + " ON COUNTRY_RESTRICTIONS_CROSSES.CNTR_ID = ARTICLES_CROSSES.ART_CTM"
                + " AND COUNTRY_RESTRICTIONS_CROSSES.CNTR_COU_ID = " + COUNTTRYCODE
                + " INNER JOIN SUPPLIERS AS SUPPLIERS_CROSSES"
                + " ON SUPPLIERS_CROSSES.SUP_ID = ARTICLES_CROSSES.ART_SUP_ID"
                + " INNER JOIN ART_EAN_NUMBERS ON ART_EAN_NUMBERS.ART_ID= ARTICLES.ART_ID "

                + " WHERE"
                + " ARTICLES.ART_ARTICLE_NR = '" + RefTecDoc + "'"
                + " AND ARTICLES.ART_SUP_ID = " + IdSupplier;
        }

        public string GetTecdocDetailsQuery(int LANGUAGE, int COUNTTRYCODE, int IdTecDoc)
        {
            return
"SELECT"
+ " ARTICLES.ART_ID,"
+ "  ARTICLES.ART_ARTICLE_NR,"
+ "  ART_COUNTRY_SPECIFICS.ACS_PACK_UNIT,"
+ "  ART_COUNTRY_SPECIFICS.ACS_QUANTITY_PER_UNIT,"
+ "  SUPPLIERS.SUP_BRAND,"
+ " SUPPLIERS.SUP_ID,"
+ "  SUPPLIERS.SUP_LOGO_NAME,"
+ "  CONCAT_WS(' ',"
+ "  (SELECT"
+ "  GROUP_CONCAT(DISTINCT get_text(PRODUCTS.PT_DES_ID, " + LANGUAGE + ") SEPARATOR ',' )"
+ "  FROM"
+ "  LINK_ART_PT"
+ "  INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_ART_PT.LAP_PT_ID"
+ "  WHERE"
+ "  LINK_ART_PT.LAP_ART_ID = ARTICLES.ART_ID),"
+ "  get_text(ARTICLES.ART_DES_ID, " + LANGUAGE + ") ) AS ART_PRODUCT_NAME,"
+ "  (SELECT"
+ "  CONCAT('[{\"infotype\":\"',"
+ "  CONCAT_WS('\",\"value\": \"', get_text_kt(72, ARTICLE_INFO.AIN_KV_TYPE, " + LANGUAGE + "),"
+ "  GROUP_CONCAT( IFNULL( TEXT_MODULE_TEXTS.TMT_TEXT, TEXT_MODULE_TEXTS_UNI"
+ " .TMT_TEXT ) SEPARATOR '-' ) )"
+ "  ,'\"}]')"
+ " FROM"
+ "  ARTICLE_INFO"
+ "  LEFT OUTER JOIN TEXT_MODULE_TEXTS ON TEXT_MODULE_TEXTS.TMT_ID = ARTICLE_INFO.AIN_TMT_ID"
+ "  AND TEXT_MODULE_TEXTS.TMT_LNG_ID = " + LANGUAGE + ""
+ "  LEFT OUTER JOIN TEXT_MODULE_TEXTS AS TEXT_MODULE_TEXTS_UNI ON TEXT_MODULE_TEXTS_UNI.TMT_ID"
+ " = ARTICLE_INFO.AIN_TMT_ID"
+ "  AND TEXT_MODULE_TEXTS_UNI.TMT_LNG_ID = 255"
+ "  WHERE"
+ "  ARTICLE_INFO.AIN_ART_ID = ARTICLES.ART_ID) AS ART_INFO,"
+ "  (SELECT"
+ " CONCAT('[{\"criteria\":\"',"
+ "  GROUP_CONCAT("
+ "  CONCAT_WS('\",\"value\": \"', get_text(CRITERIA.CRI_DES_ID, " + LANGUAGE + "),"
+ "  (CASE"
+ "  WHEN CRITERIA.CRI_TYPE = 3"
+ "  THEN"
+ "  get_text_kt(ARTICLE_CRITERIA.ACR_KV_KT_ID, ARTICLE_CRITERIA.ACR_KV_KV, " + LANGUAGE + ")"
+ "  ELSE"
+ "  ARTICLE_CRITERIA.ACR_VALUE"
+ "  END) )"
+ "  SEPARATOR '\"}, {\"criteria\":\"')"
+ " ,'\"}]') "
+ " FROM"
+ "  ARTICLE_CRITERIA"
+ "  INNER JOIN CRITERIA ON ARTICLE_CRITERIA.ACR_CRI_ID = CRITERIA.CRI_ID"
+ "  INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLE_CRITERIA.ACR_CTM"
+ "  AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ "  WHERE"
+ "  ARTICLE_CRITERIA.ACR_ART_ID = ARTICLES.ART_ID LIMIT 4 ) AS ARTICLE_CRITERIA,"
+ "  (SELECT"
+ " CONCAT('[{\"m\":\"',"
+ "  GROUP_CONCAT( CONCAT_WS( '\",\"v\": \"', MANUFACTURERS.MFA_BRAND,ART_OEM_NUMBERS.OEM_NUM) SEPARATOR '\"}, {\"m\":\"' )"
+ " ,'\"}]') "
+ "  FROM"
+ "  ART_OEM_NUMBERS"
+ "  INNER JOIN MANUFACTURERS ON MANUFACTURERS.MFA_ID = ART_OEM_NUMBERS.MFA_ID"
+ "  INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ART_OEM_NUMBERS.OEM_CTM"
+ "  AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ "  WHERE"
+ "  ART_OEM_NUMBERS.ART_ID = ARTICLES.ART_ID ) AS OEM_NUMBERS,"
+ "  (SELECT"
+ "  GROUP_CONCAT( ART_EAN_NUMBERS.EAN_NUM SEPARATOR ',' )"
+ "  FROM"
+ "  ART_EAN_NUMBERS"
+ "  WHERE"
+ "  ART_EAN_NUMBERS.ART_ID = ARTICLES.ART_ID) AS EAN_NUMBERS"
+ "  FROM"
+ "  ARTICLES"
+ "  INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID"
+ "  AND (ART_COUNTRY_SPECIFICS.ACS_COU_ID = " + COUNTTRYCODE + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
+ "  LEFT OUTER JOIN KEY_VALUES ON KEY_VALUES.KV_KT_ID = 73"
+ "  AND KEY_VALUES.KV_KV = ART_COUNTRY_SPECIFICS.ACS_STATUS_KV_KV"
+ " "
+ "  INNER JOIN SUPPLIERS ON ARTICLES.ART_SUP_ID = SUP_ID"
+ "  WHERE"
+ " ARTICLES.ART_ID = " + IdTecDoc;
        }

        public string GetBrandsQuery()
        {
            return "SELECT * FROM SUPPLIERS";
        }

        public string GetTopAddress(int IdSupplier)
        {
            return "SELECT" +
                " * FROM SUPPLIER_ADDRESSES" +
                " WHERE SUP_ID = " + IdSupplier + 
                " AND TYPE_OF_ADDRESS = 1" +
                " LIMIT 1";
        }


        public string GetTecDocItemsByBrand(int LANGUAGE, int COUNTTRYCODE, int? IdSupplier)
        {
            return " SELECT DISTINCT"
            + " ARTICLES.ART_ID,"
            + " ARTICLES.ART_ARTICLE_NR,"
            + " CONCAT_WS(\" - \",get_text(ARTICLES.ART_COMPLETE_DES_ID, " + LANGUAGE + "),get_text(ARTICLES.ART_DES_ID, " + LANGUAGE + ")) AS DESCRIPTIONS,"
            + " ARTICLES.ART_SUP_BRAND,"
            + " ARTICLES.ART_SUP_ID,"
            + " ART_EAN_NUMBERS.EAN_NUM"
            + " FROM"
            + " LINK_LA_TYP"
            + " INNER JOIN LINK_ART ON LINK_ART.LA_ID = LINK_LA_TYP.LAT_LA_ID"
            + " INNER JOIN ARTICLES ON ARTICLES.ART_ID = LINK_ART.LA_ART_ID"
            + " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ARTICLES.ART_CTM"
            + " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
            + " INNER JOIN ART_COUNTRY_SPECIFICS ON ART_COUNTRY_SPECIFICS.ACS_ART_ID = ARTICLES.ART_ID"
            + " AND(ART_COUNTRY_SPECIFICS.ACS_COU_ID =  " + COUNTTRYCODE + " OR ART_COUNTRY_SPECIFICS.ACS_COU_ID = 255)"
            + " INNER JOIN SUPPLIERS ON SUPPLIERS.SUP_ID = LINK_LA_TYP.LAT_SUP_ID"
            + " INNER JOIN PRODUCTS ON PRODUCTS.PT_ID = LINK_LA_TYP.LAT_PT_ID"
            + " INNER JOIN ART_EAN_NUMBERS ON ART_EAN_NUMBERS.ART_ID= ARTICLES.ART_ID "
            + " WHERE"
            + " ARTICLES.ART_SUP_ID = " + IdSupplier + " LIMIT 50";
        }


        public string GetpassengerCarForDetailsQuery(int LANGUAGE, int COUNTTRYCODE, int IdTecDoc)
        {
            return
                "SELECT DISTINCT"
+ " (SELECT"
+ " GROUP_CONCAT("
+ " CONCAT_WS(': ', get_text(CRITERIA.CRI_DES_ID, " + LANGUAGE + "),"
+ " (CASE"
+ " WHEN CRITERIA.CRI_TYPE = 3"
+ " THEN"
+ " get_text_kt(LA_CRITERIA.LAC_KV_KT_ID, LA_CRITERIA.LAC_KV_KV, " + LANGUAGE + ")"
+ " ELSE"
+ " LA_CRITERIA.LAC_VALUE"
+ " END))"
+ " SEPARATOR '; ')"
+ " FROM"
+ " LA_CRITERIA"
+ " INNER JOIN CRITERIA ON LA_CRITERIA.LAC_CRI_ID = CRITERIA.CRI_ID"
+ " WHERE"
+ " LA_CRITERIA.LAC_LA_ID = LINK_LA_TYP.LAT_LA_ID AND LA_CRITERIA.LAC_DISPLAY = 1) AS 'TERM_OF_USE',"
+ " PASSENGER_CARS.PC_ID,"
+ " CONCAT(MFA_BRAND, ' ',"
+ " get_text(MS_COUNTRY_SPECIFICS.MSCS_NAME_DES, " + LANGUAGE + "), ' ',"
+ " get_text(PASSENGER_CARS.PC_MODEL_DES, " + LANGUAGE + ")) AS TYPEL,"
+ " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_START,"
+ " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_END,"
+ " PC_COUNTRY_SPECIFICS.PCS_POWER_KW,"
+ " PC_COUNTRY_SPECIFICS.PCS_POWER_PS,"
+ " PC_COUNTRY_SPECIFICS.PCS_CAPACITY_TECH,"
+ " get_text(PC_COUNTRY_SPECIFICS.PCS_BODY_TYPE, " + LANGUAGE + ") AS PC_BODY_TYPE,"
+ " (SELECT"
+ " GROUP_CONCAT(ENGINES.ENG_CODE)"
+ " FROM"
+ " ENGINES"
+ " JOIN ENG_DESIGNATIONS ON(ENGINES.ENG_ID = ENG_DESIGNATIONS.ENG_ID)"
+ " WHERE"
+ " ENG_DESIGNATIONS.PC_ID = PASSENGER_CARS.PC_ID) AS PC_ENG_CODES"
+ " FROM"
+ " LINK_ART"
+ " INNER JOIN LINK_LA_TYP ON LINK_LA_TYP.LAT_LA_ID = LINK_ART.LA_ID"
+ " AND LINK_LA_TYP.LAT_TYPE = 2"
+ " INNER JOIN PASSENGER_CARS ON PASSENGER_CARS.PC_ID = LINK_LA_TYP.LAT_TYP_ID"
+ " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = PASSENGER_CARS.PC_CTM"
+ " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ " INNER JOIN PC_COUNTRY_SPECIFICS ON PC_COUNTRY_SPECIFICS.PCS_PC_ID = PASSENGER_CARS.PC_ID"
+ " AND(PC_COUNTRY_SPECIFICS.PCS_COU_ID = " + COUNTTRYCODE + " OR PC_COUNTRY_SPECIFICS.PCS_COU_ID = 255)"
+ " INNER JOIN MODELS_SERIES ON MODELS_SERIES.MS_ID = PASSENGER_CARS.PC_MS_ID"
+ " INNER JOIN MANUFACTURERS ON MANUFACTURERS.MFA_ID = PASSENGER_CARS.PC_MFA_ID"
+ " INNER JOIN MS_COUNTRY_SPECIFICS ON MS_COUNTRY_SPECIFICS.MSCS_ID = MODELS_SERIES.MS_ID"
+ " AND(MS_COUNTRY_SPECIFICS.MSCS_COU_ID = " + COUNTTRYCODE + " OR MS_COUNTRY_SPECIFICS.MSCS_COU_ID = 255)"
+ " AND MS_COUNTRY_SPECIFICS.MSCS_AXL = 0"
+ " WHERE"
+ " LINK_ART.LA_ART_ID = " + IdTecDoc + "";
        }

        public string GetTopPassengerCarForDetailsQuery(int LANGUAGE, int COUNTTRYCODE, int IdTecDoc)
        {
            return
                "SELECT DISTINCT"
+ " (SELECT"
+ " GROUP_CONCAT("
+ " CONCAT_WS(': ', get_text(CRITERIA.CRI_DES_ID, " + LANGUAGE + "),"
+ " (CASE"
+ " WHEN CRITERIA.CRI_TYPE = 3"
+ " THEN"
+ " get_text_kt(LA_CRITERIA.LAC_KV_KT_ID, LA_CRITERIA.LAC_KV_KV, " + LANGUAGE + ")"
+ " ELSE"
+ " LA_CRITERIA.LAC_VALUE"
+ " END))"
+ " SEPARATOR '; ')"
+ " FROM"
+ " LA_CRITERIA"
+ " INNER JOIN CRITERIA ON LA_CRITERIA.LAC_CRI_ID = CRITERIA.CRI_ID"
+ " WHERE"
+ " LA_CRITERIA.LAC_LA_ID = LINK_LA_TYP.LAT_LA_ID AND LA_CRITERIA.LAC_DISPLAY = 1) AS 'TERM_OF_USE',"
+ " PASSENGER_CARS.PC_ID,"
+ " CONCAT(MFA_BRAND, ' ',"
+ " get_text(MS_COUNTRY_SPECIFICS.MSCS_NAME_DES, " + LANGUAGE + "), ' ',"
+ " get_text(PASSENGER_CARS.PC_MODEL_DES, " + LANGUAGE + ")) AS TYPEL,"
+ " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_START,"
+ " PC_COUNTRY_SPECIFICS.PCS_CONSTRUCTION_INTERVAL_END,"
+ " PC_COUNTRY_SPECIFICS.PCS_POWER_KW,"
+ " PC_COUNTRY_SPECIFICS.PCS_POWER_PS,"
+ " PC_COUNTRY_SPECIFICS.PCS_CAPACITY_TECH,"
+ " get_text(PC_COUNTRY_SPECIFICS.PCS_BODY_TYPE, " + LANGUAGE + ") AS PC_BODY_TYPE,"
+ " (SELECT"
+ " GROUP_CONCAT(ENGINES.ENG_CODE)"
+ " FROM"
+ " ENGINES"
+ " JOIN ENG_DESIGNATIONS ON(ENGINES.ENG_ID = ENG_DESIGNATIONS.ENG_ID)"
+ " WHERE"
+ " ENG_DESIGNATIONS.PC_ID = PASSENGER_CARS.PC_ID) AS PC_ENG_CODES"
+ " FROM"
+ " LINK_ART"
+ " INNER JOIN LINK_LA_TYP ON LINK_LA_TYP.LAT_LA_ID = LINK_ART.LA_ID"
+ " AND LINK_LA_TYP.LAT_TYPE = 2"
+ " INNER JOIN PASSENGER_CARS ON PASSENGER_CARS.PC_ID = LINK_LA_TYP.LAT_TYP_ID"
+ " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = PASSENGER_CARS.PC_CTM"
+ " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ " INNER JOIN PC_COUNTRY_SPECIFICS ON PC_COUNTRY_SPECIFICS.PCS_PC_ID = PASSENGER_CARS.PC_ID"
+ " AND(PC_COUNTRY_SPECIFICS.PCS_COU_ID = " + COUNTTRYCODE + " OR PC_COUNTRY_SPECIFICS.PCS_COU_ID = 255)"
+ " INNER JOIN MODELS_SERIES ON MODELS_SERIES.MS_ID = PASSENGER_CARS.PC_MS_ID"
+ " INNER JOIN MANUFACTURERS ON MANUFACTURERS.MFA_ID = PASSENGER_CARS.PC_MFA_ID"
+ " INNER JOIN MS_COUNTRY_SPECIFICS ON MS_COUNTRY_SPECIFICS.MSCS_ID = MODELS_SERIES.MS_ID"
+ " AND(MS_COUNTRY_SPECIFICS.MSCS_COU_ID = " + COUNTTRYCODE + " OR MS_COUNTRY_SPECIFICS.MSCS_COU_ID = 255)"
+ " AND MS_COUNTRY_SPECIFICS.MSCS_AXL = 0"
+ " WHERE"
+ " LINK_ART.LA_ART_ID = " + IdTecDoc + " LIMIT 100";
        }


        public string GetEnginesForDetailsQuery(int LANGUAGE, int COUNTTRYCODE, int IdTecDoc)
        {
            return
                "SELECT DISTINCT"
+ " (SELECT"
+ " GROUP_CONCAT(ENGINES.ENG_CODE)"
+ " FROM"
+ " ENGINES"
+ " JOIN ENG_DESIGNATIONS ON(ENGINES.ENG_ID = ENG_DESIGNATIONS.ENG_ID)"
+ " WHERE"
+ " ENG_DESIGNATIONS.PC_ID = PASSENGER_CARS.PC_ID) AS PC_ENG_CODES"
+ " FROM"
+ " LINK_ART"
+ " INNER JOIN LINK_LA_TYP ON LINK_LA_TYP.LAT_LA_ID = LINK_ART.LA_ID"
+ " AND LINK_LA_TYP.LAT_TYPE = 2"
+ " INNER JOIN PASSENGER_CARS ON PASSENGER_CARS.PC_ID = LINK_LA_TYP.LAT_TYP_ID"
+ " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = PASSENGER_CARS.PC_CTM"
+ " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ " INNER JOIN PC_COUNTRY_SPECIFICS ON PC_COUNTRY_SPECIFICS.PCS_PC_ID = PASSENGER_CARS.PC_ID"
+ " AND(PC_COUNTRY_SPECIFICS.PCS_COU_ID = " + COUNTTRYCODE + " OR PC_COUNTRY_SPECIFICS.PCS_COU_ID = 255)"
+ " INNER JOIN MODELS_SERIES ON MODELS_SERIES.MS_ID = PASSENGER_CARS.PC_MS_ID"
+ " INNER JOIN MANUFACTURERS ON MANUFACTURERS.MFA_ID = PASSENGER_CARS.PC_MFA_ID"
+ " INNER JOIN MS_COUNTRY_SPECIFICS ON MS_COUNTRY_SPECIFICS.MSCS_ID = MODELS_SERIES.MS_ID"
+ " AND(MS_COUNTRY_SPECIFICS.MSCS_COU_ID = " + COUNTTRYCODE + " OR MS_COUNTRY_SPECIFICS.MSCS_COU_ID = 255)"
+ " AND MS_COUNTRY_SPECIFICS.MSCS_AXL = 0"
+ " WHERE"
+ " LINK_ART.LA_ART_ID = " + IdTecDoc + "";
        }

        public string GetMediaQuery(int LANGUAGE, int COUNTTRYCODE, int IdTecDoc)
        {
            return
                 "SELECT"
+ " ART_MEDIA_INFO.ART_MEDIA_TYPE,"
+ " (CASE"
+ " WHEN ART_MEDIA_INFO.ART_MEDIA_TYPE = 1"
+ " THEN CONCAT_WS('/', ART_MEDIA_INFO.ART_MEDIA_SUP_ID, ART_MEDIA_INFO.ART_MEDIA_FILE_NAME)".ToUpper()
+ " WHEN ART_MEDIA_INFO.ART_MEDIA_TYPE = 2"
+ " THEN CONCAT_WS('/', 'http://dvsegmbh.info/pdf/einbau', '12018',"
+ " ART_MEDIA_INFO.ART_MEDIA_SUP_ID, ART_MEDIA_INFO.ART_MEDIA_FILE_NAME)".ToUpper()
+ " WHEN ART_MEDIA_INFO.ART_MEDIA_TYPE = 3"
+ " THEN ART_MEDIA_INFO.ART_MEDIA_HIPPERLINK"
+ " END) AS ART_MEDIA_SOURCE,"
+ " ART_MEDIA_INFO.ART_MEDIA_SUP_ID,"
+ " get_text_kt(141, ART_MEDIA_INFO.ART_MEDIA_NORM, " + LANGUAGE + ")AS ALT"
+ " FROM"
+ " ART_MEDIA_INFO"
+ " INNER JOIN COUNTRY_RESTRICTIONS ON COUNTRY_RESTRICTIONS.CNTR_ID = ART_MEDIA_INFO.ART_MEDIA_CTM"
+ " AND COUNTRY_RESTRICTIONS.CNTR_COU_ID = " + COUNTTRYCODE + ""
+ " WHERE"
+ " ART_MEDIA_INFO.ART_ID = " + IdTecDoc + "";
        }

    }
}
