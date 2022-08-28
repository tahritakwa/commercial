using Settings.Config;

namespace ViewModels.Comparers
{
    public static class ManageDBConnections
    {
        /// <summary>
        /// BuildConnectionString
        /// </summary>
        /// <param name="dbSettings"></param>
        /// <returns></returns>
        public static string BuildConnectionString(DbSettings dbSettings, DbSettings defaultDbSettings = null)
        {
            if (dbSettings == null)
            {
                return null;
            }
            if (string.IsNullOrEmpty(dbSettings.Server) && defaultDbSettings != null)
            {
                dbSettings.Server = defaultDbSettings.Server;
            }
            if (string.IsNullOrEmpty(dbSettings.UserId) && defaultDbSettings != null)
            {
                dbSettings.UserId = defaultDbSettings.UserId;
            }
            if (string.IsNullOrEmpty(dbSettings.UserPassword) && defaultDbSettings != null)
            {
                dbSettings.UserPassword = defaultDbSettings.UserPassword;
            }
            return string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                dbSettings.Server, dbSettings.DataBaseName, dbSettings.UserId, dbSettings.UserPassword);
        }


        /// <summary>
        /// BuildConnectionString
        /// </summary>
        /// <param name="dbSettings"></param>
        /// <returns></returns>
        public static string BuildConnectionStringMySql(OtherDataBaseSettings dbSettings)
        {
            if (dbSettings == null)
            {
                return null;
            }
            return string.Format("Server={0}; Port={1}; Database={2}; Uid={3}; Pwd={4};",
                dbSettings.Server, dbSettings.Port, dbSettings.DataBaseName, dbSettings.Uid, dbSettings.UserPassword);
        }
    }
}
