using CacheManager.Core;
using EFSecondLevelCache.Core;
using Elastic.Apm.AspNetCore;
using Elastic.Apm.DiagnosticSource;
using Elastic.Apm.EntityFrameworkCore;
using Hangfire;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Logging;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using Persistence;
using Persistence.Context;
using Serilog;
using Serilog.Debugging;
using Serilog.Events;
using Serilog.Sinks.Elasticsearch;
using Services.Specific.Hubs;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using Utils.Utilities.ConverterUtilities;
using ViewModels.DTO.Shared;
using Web.App_Start;
using Web.Authorization;
using Web.HangFire;
using Web.Interceptors.Proxy;
using Web.Interceptors.RequestInterceptor;
using Web.Quartz;
using Web.TokenProvider;

namespace Web
{
    public class Startup
    {
        public static IConfigurationRoot Configuration { get; set; }
        public static AppSettings _appSettings { get; set; }
        public static string envName { get; set; }
        private IConfigurationRoot EnviromentConfiguration { get; set; }
        public Startup(IWebHostEnvironment env)
        {
            // Enviroment Config
            EnviromentConfiguration = new Microsoft.Extensions.Configuration.ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile($"./Env/env.json", optional: true, reloadOnChange: true)
                .Build();
            string environmentName = EnviromentConfiguration["EnviromentName"];
            // Set up configuration sources
            envName = environmentName;
            var builder = new Microsoft.Extensions.Configuration.ConfigurationBuilder()
            .SetBasePath(env.ContentRootPath)
            .AddJsonFile($"./Env/env.{environmentName}.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables()
            .AddInMemoryCollection(new[]
            {
                new KeyValuePair<string,string>("UseInMemoryDatabase", "true"),
            });
            Configuration = builder.Build();

            var elasticUri = Configuration["ElasticConfiguration:Uri"];
            StreamWriter writer = File.CreateText("serilog.log");
            SelfLog.Enable(writer);
            if (environmentName == "QA")
            {
                Log.Logger = new LoggerConfiguration().Enrich.FromLogContext()
                .MinimumLevel
                .Information()
                .WriteTo.RollingFile("Logs/log-{Date}.log", LogEventLevel.Warning)
                .WriteTo.Elasticsearch(new ElasticsearchSinkOptions(new Uri(elasticUri))
                {
                    IndexFormat = Configuration["ElasticConfiguration:Index"],
                    AutoRegisterTemplate = true,
                    ModifyConnectionSettings = Configuration => Configuration.ServerCertificateValidationCallback(
                            (o, certificate, arg3, arg4) => { return true; }),

                })
                .CreateLogger();
            }
            else
            {
                Log.Logger = new LoggerConfiguration().Enrich.FromLogContext()
                .MinimumLevel
                .Information()
                .WriteTo.RollingFile("Logs/log-{Date}.log", LogEventLevel.Warning)
                .CreateLogger();
            }

            using (StreamReader r = new StreamReader($"./Env/env.{environmentName}.json"))
            {
                string jsonEnv = r.ReadToEnd();
                dynamic dynamicJsonEnv = JsonConvert.DeserializeObject(jsonEnv);
                Newtonsoft.Json.Linq.JObject appSettingsString = dynamicJsonEnv["AppSettings"];
                AppSettings appSettings = JsonConvert.DeserializeObject<AppSettings>(appSettingsString.ToString());
                _appSettings = appSettings;
            }

        }
        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            
            IdentityModelEventSource.ShowPII = true;
            ConfigureJWT(services);
            ConfigureLogging(services);
            //Add service for accessing current HttpContext
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

            services.RegisterDbContext();
            services.RegisterRepositories();
            services.RegisterBuilders();
            services.RegisterServices();

            if (_appSettings.ExecuteJobs)
            {
                services.InjectJobs();
                services.AddQuartz(services.BuildServiceProvider(), _appSettings);
            }

            // Response caching service
            services.AddResponseCaching();
            // Response caching policy
            AddResponseCompressionPolicy(services);
            // Inmemory cache 
            services.AddMemoryCache();
            services.AddSingleton<MemoryCache>();
            // /!\ Cors 
            services.AddCors(options =>
            {
                options.AddPolicy("CorsPolicy",
                    builder => builder.AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader());
                    //.AllowCredentials());
            });

            // SIgnalR service
            services.AddSignalR();
          
            // swagger service
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "Stark-API", Version = "v1.0.x" });
                c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
            });
            // settings config
            services.Configure<SmtpSettings>(Configuration.GetSection("SmtpSettings"));
            services.Configure<List<CompanyViewModel>>(Configuration.GetSection("Companies"));
            services.Configure<Oauth2>(Configuration.GetSection("TokenConfig"));

            //B2B settings 
            services.Configure<B2BSettings>(Configuration.GetSection("B2BSettings"));
            //OtherDataBase
            services.Configure<OtherDataBaseSettings>(Configuration.GetSection("OtherDataBaseSettings"));
            // Hangfire settings
            services.Configure<HangfireSettings>(Configuration.GetSection("HangfireSettings"));
            // Automatic Print Configuration
            services.Configure<PrinterSettings>(Configuration.GetSection("PrinterSettings"));
            // Add Second Level Caching.
            services.AddEFSecondLevelCache();
            // proxy service
            services.AddScoped<ProxyService>();
            // Add In Memory DataBase 
            services.AddEntityFrameworkInMemoryDatabase().AddDbContext<StarkContextFactory>(optionsBuilder =>
            {
                optionsBuilder.UseInMemoryDatabase("StarkDbCache");
            });
            // /!\
            // Authorization service
            services.AddSingleton<IAuthorizationPolicyProvider, PermissionPolicyProvider>();
            services.AddScoped<IAuthorizationHandler, PermissionAuthorizationHandler>();
            // /!\

            services.AddControllersWithViews().AddJsonOptions(options =>
            {
                options.JsonSerializerOptions.PropertyNamingPolicy = null;
                options.JsonSerializerOptions.PropertyNameCaseInsensitive = true;
                options.JsonSerializerOptions.AllowTrailingCommas = true;
                options.JsonSerializerOptions.IncludeFields = true;
                options.JsonSerializerOptions.NumberHandling = System.Text.Json.Serialization.JsonNumberHandling.AllowReadingFromString;
                options.JsonSerializerOptions.Converters.Add(new DynamicTextJsonConverter());
                options.JsonSerializerOptions.Converters.Add(new JsonTimeSpanConverter());

        });


            // Add an in-memory cache service provider
            AddInMemoryCacheServiceProvider(services);

            if (_appSettings.ExecuteJobs)
            {
                // Add Hangfire configuration
                IConfigurationSection _hangfireSettings = Configuration.GetSection("HangfireSettings");
                string hangfireServer = _hangfireSettings.GetChildren().First(p => p.Key == "Server").Value;
                string hangfireDataBaseName = _hangfireSettings.GetChildren().First(p => p.Key == "DataBaseName").Value;
                string hangfireUserId = _hangfireSettings.GetChildren().First(p => p.Key == "UserId").Value;
                string hangfireUserPassword = _hangfireSettings.GetChildren().First(p => p.Key == "UserPassword").Value;
                //_hangfireSettings
                string hangfireConnectionString = ("Data Source=" + hangfireServer + ";Initial Catalog=" + hangfireDataBaseName
                    + ";Persist Security Info=True;User ID=" + hangfireUserId + ";Password=" + hangfireUserPassword);
                services.AddHangfire(x => x.UseSqlServerStorage(hangfireConnectionString));
                services.AddHangfireServer();
            }

        }
        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILoggerFactory loggerFactory)
        {
            //Register Log4Net middleware
            loggerFactory.AddLog4Net();
            //Registers the agent with an IConfiguration instance:
            app.UseElasticApm(Configuration,
            new HttpDiagnosticsSubscriber(),  //* Enable tracing of outgoing HTTP requests *//
            new EfCoreDiagnosticsSubscriber());

            app.UseCors("CorsPolicy");
            if (_appSettings.ExecuteJobs)
            {
                // use quartz
                app.UseQuartz();
            }

            AppHttpContext.Services = app.ApplicationServices;


            // Logger configuration
            //loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            //loggerFactory.AddDebug();
            //loggerFactory.AddSerilog();
            //loggerFactory.AddConsole(Configuration.GetSection("Logging"));


            // Response caching policy
            AddResponseCachingPolicy(app);

            // Response Compression 
            app.UseResponseCompression();
            //app.UseSession();
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseRouting();
            app.UseAuthentication();
            
            app.UseForwardedHeaders(new ForwardedHeadersOptions
            {
                ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto

            });
            app.UseStaticFiles();
            //use exception middleware
            app.ConfigureCustomExceptionMiddleware();
            app.UseAuthorization();
            // /!\ Cors
            app.UseCors("CorsPolicy");
            // /!\
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            //use Mvc
            //app.UseMvc();
            app.UseFileServer();
            // Swagger
            app.UseSwagger();
            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint($"/swagger/v1/swagger.json", "Stark-Swaagger");
            });
            // Secon level Cache 
            //app.UseEFSecondLevelCache();

            if (_appSettings.ExecuteJobs)
            {
                // Hangfire Dashboard configuration
                var hangFireAuth = new DashboardOptions
                {
                    Authorization = new[]
                {
                    new HangfireDashboardAuthorizationFilter(app.ApplicationServices.GetService<IAuthorizationService>(),
                    app.ApplicationServices.GetService<IHttpContextAccessor>())
                }
                };

                app.UseHangfireDashboard("/hangfire", hangFireAuth);
                // Hangfire Server configuration
                app.UseHangfireServer(new BackgroundJobServerOptions
                {
                    WorkerCount = 1
                });
                GlobalJobFilters.Filters.Add(new AutomaticRetryAttribute { Attempts = 0 });
                HangFireJobScheduler.ScheduleRecurringJobs();

            }

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapHub<NotificationHub>("/api/notificationHub");
                endpoints.MapHub<PayslipSessionProgressHub>("/api/payslipSessionProgressHub");
                endpoints.MapHub<BillingSessionProgessHub>("/api/billingSessionProgressHub");
                endpoints.MapHub<SourceDeductionSessionProgressHub>("/api/sourceDeductionSessionProgressHub");
                endpoints.MapHub<LeaveBalanceRemainingProgressHub>("/api/leaveBalanceRemainingProgressHub");
                endpoints.MapHub<CommentHub>("/api/commentHub");
                endpoints.MapHub<ChatHub>("/api/chatHub");
                endpoints.MapDefaultControllerRoute();

            });
        }
        private void AddResponseCachingPolicy(IApplicationBuilder app)
        {
            app.UseResponseCaching();
        }
        private void AddInMemoryCacheServiceProvider(IServiceCollection services)
        {
            services.AddSingleton(typeof(ICacheManagerConfiguration),
                new CacheManager.Core.ConfigurationBuilder()
                    .WithMicrosoftLogging(f =>
                    {
                       /* f.AddConsole(Configuration.GetSection("Logging"));
                        f.AddDebug();*/
                        f.AddSerilog();
                    })
                    .WithJsonSerializer()
                    .WithMicrosoftMemoryCacheHandle()
                    .WithExpiration(ExpirationMode.Sliding, TimeSpan.FromDays(7))
                    .DisablePerformanceCounters()
                    .DisableStatistics()
                    .Build());
            services.AddSingleton(typeof(ICacheManager<>), typeof(BaseCacheManager<>));
        }

        /// <summary>
        /// Configuration for enable JWT
        /// </summary>
        /// <param name="services"></param>
        private void ConfigureJWT(IServiceCollection services)
        {
            var appSettingsSection = Configuration.GetSection("AppSettings");
            services.Configure<AppSettings>(appSettingsSection);
            var appSettings = appSettingsSection.Get<AppSettings>();

            services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            });
        }


        private void AddResponseCompressionPolicy(IServiceCollection services)
        {
            // compression service 
            services.AddResponseCompression(options =>
            {
                options.Providers.Add<GzipCompressionProvider>();
                // Default Mime types text/plain, text / css,  application / javascript, text / html, application / xml, text / xml, application / json, text / json
                options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(new[] { "image/svg+xml" });
            });
            services.Configure<GzipCompressionProviderOptions>(options =>
            {
                options.Level = CompressionLevel.Fastest;
            });
        }
        /// <summary>
        ///  Logger configuration
        /// </summary>
        /// <param name="factory"></param>
        /// <returns></returns>
        private IServiceCollection ConfigureLogging(IServiceCollection factory)
        {
            factory.AddLogging(opt =>
            {
                opt.AddConsole();
                opt.AddSerilog();
            });
            return factory;
        }
    }
}

