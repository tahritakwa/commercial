using log4net;
using log4net.Config;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using Serilog;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.DBConfig;

namespace Web
{
    public class Program
    {
        private static AppSettings _appSettings;
        public static void Main(string[] args)
        { 

            CreateWebHostBuilder(args).Build().Run();
        }

        /* public static IHostBuilder CreateHostBuilder(string[] args) =>
             Host.CreateDefaultBuilder(args)
                 .ConfigureWebHostDefaults(webBuilder =>
                 {
                     webBuilder.UseStartup<Startup>();
                 });*/

        public static IWebHostBuilder CreateWebHostBuilder(string[] args)
        {

            MigrateDatabase();
            return WebHost.CreateDefaultBuilder(args)
                         .UseContentRoot(Directory.GetCurrentDirectory())
                         .UseIISIntegration()
                         .UseStartup<Startup>();
        }

        private static void MigrateDatabase()
        {
            try
            {
                string envName = ReadDataFileEnv();
                string location = "";
                if (envName == "Local" || envName == "Integration" || envName == "IntegrationJenkins")
                {
                    location = Path.Combine("..", "..", "08-DataBase", "1-Initialization", "3-ERP");
                }
                else
                {
                    location = Path.Combine("DataBase", "Evolve_DB") ;

                }
                ExecuteScripts(location, envName);
            }
            catch (Exception ex)
            {
                Log.Error("Database migration failed.", ex);
            }

        }

        private static void ExecuteScripts(string location, string envName)
        {

            if (Directory.Exists(location))
            {
                using (StreamReader r = new StreamReader(Path.Combine("Env", "env." + envName + ".json")))
                {
                    string jsonEnv = r.ReadToEnd();
                    dynamic dynamicJsonEnv = JsonConvert.DeserializeObject(jsonEnv);
                    Newtonsoft.Json.Linq.JObject appSettingsString = dynamicJsonEnv["AppSettings"];
                    AppSettings appSettings = JsonConvert.DeserializeObject<AppSettings>(appSettingsString.ToString());
                    _appSettings = appSettings;
                }
                if (_appSettings.CreateDateBase)
                {
                    string cnxString = string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                                      _appSettings.MasterDbSettings.Server, _appSettings.MasterDbSettings.DataBaseName, _appSettings.MasterDbSettings.UserId, _appSettings.MasterDbSettings.UserPassword);

                    List<string> listOfCompanyNames = GetCompanyNameList(cnxString);
                    listOfCompanyNames.ForEach(x =>
                    {
                        string cnxStringOfListCompany = string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                               _appSettings.MasterDbSettings.Server, x, _appSettings.MasterDbSettings.UserId, _appSettings.MasterDbSettings.UserPassword);
                        SqlConnection cnx = new SqlConnection(cnxStringOfListCompany);
                        var evolve = new Evolve.Evolve(cnx, msg => Log.Information(msg))
                        {
                            Locations = new[] { location }
                        };
                        evolve.Migrate();
                    });
                }
            }

        }

        private static string ReadDataFileEnv()
        {
            using (StreamReader r = new StreamReader($"./Env/env.json"))
            {
                string json = r.ReadToEnd();
                dynamic dataEnv = JsonConvert.DeserializeObject<dynamic>(json);
                return dataEnv.EnviromentName.Value;
            }
        }

        private static List<string> GetCompanyNameList(string connectionString)
        {
            List<string> listOfCompanyNames = new List<string>();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select DataBaseName from Master.MasterCompany where IsDeleted=0", conn)))
                {
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        listOfCompanyNames.Add(rdr.GetString(0));
                    }

                    conn.Close();
                }

            }

            return listOfCompanyNames;

        }
        private static bool DeleteChangeLogEvolve(string connectionString)
        {
            try
            {

                List<string> listOfCompanyNames = new List<string>();
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(string.Format("if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'changelog' AND TABLE_SCHEMA = 'dbo') drop table dbo.changelog", conn)))
                    {
                        cmd.Connection = conn;
                        SqlDataReader rdr = cmd.ExecuteReader();
                        conn.Close();
                        return true;
                    }

                }
            }
            catch (Exception ex)
            {
                Log.Error("Database migration failed.", ex);
                return false;
            }

        }
    }
}
