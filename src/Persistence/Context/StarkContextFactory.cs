using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Persistence.Audit;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Linq.Expressions;
using System.Net.Http;
using System.Text;

namespace Persistence.Context
{
    public partial class StarkContextFactory : GUIDContext
    {
        private readonly bool _isIocCall;
        private readonly IHttpContextAccessor _contextAccessor;
        private readonly AppSettings _appSettings;
        private readonly IMemoryCache _memoryCache;
        private readonly IRepository<MasterUser> _entityRepoMasterUser;
        public StarkContextFactory(DbContextOptions<StarkContextFactory> options,
            IHttpContextAccessor contextAccessor,
            IMemoryCache memoryCache,
            IOptions<AppSettings> appSettings, IRepository<MasterUser> entityRepoMasterUser = null, bool isIocCall = true)
            : base(options)
        {
            _appSettings = appSettings.Value;
            _contextAccessor = contextAccessor;
            _isIocCall = isIocCall;
            _memoryCache = memoryCache;
            _entityRepoMasterUser = entityRepoMasterUser;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            try
            {

                if (_isIocCall)
                {
                    CredentialsModel user = JsonConvert.DeserializeObject<CredentialsModel>(DecryptToken()["user"].ToString());
                    var companyCode = _memoryCache.Get(user.Email);
                    if (_entityRepoMasterUser!=null && companyCode == null)
                    {
                        string LastConnectedCompany;
                        LastConnectedCompany = _entityRepoMasterUser.FindSingleBy(x => x.Email == user.Email).LastConnectedCompany;
                        _memoryCache.Set(user.Email, LastConnectedCompany);
                        companyCode = LastConnectedCompany;

                    }
                    if (companyCode != null)
                    {
                        DbSettings dbSettings = _memoryCache.Get(companyCode.ToString()) as DbSettings;
                        if (dbSettings != null)
                        {
                            GeneratedConnectionString = string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                            dbSettings.Server, dbSettings.DataBaseName, dbSettings.UserId, dbSettings.UserPassword);
                            optionsBuilder.UseSqlServer(GeneratedConnectionString);
                            optionsBuilder.EnableSensitiveDataLogging();
                        }
                    }
                }
                else
                {
                    base.OnConfiguring(optionsBuilder);
                }
            }
            catch (Exception)
            {
                return;
            }
        }

        public dynamic DecryptToken()
        {
            if (AppHttpContext.Current != null)
            {
                AppHttpContext.Current.Request.Headers.TryGetValue("Authorization", out StringValues userToken);
                if (userToken != "")
                {
                    var jwt = userToken.ToString().Replace("Bearer ", string.Empty);
                    if (userToken != "")
                    {
                        JwtSecurityToken token = new JwtSecurityToken(jwt);
                        return token.Payload;
                    }
                    return null;
                }
            }
            return null;
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                if (entityType.FindProperty("IsDeleted") != null)
                {
                    Type type = Type.GetType(entityType.Name);
                    var parameter = Expression.Parameter(type);
                    var constant = Expression.Constant(false);
                    var member = Expression.Property(parameter, "IsDeleted");
                    var body = Expression.Equal(member, constant);
                    var delegateType = typeof(Func<,>).MakeGenericType(type, typeof(bool));
                    dynamic lambda = Expression.Lambda(delegateType, body, parameter);
                    modelBuilder.Entity(type).HasQueryFilter(lambda);
                }
            }
        }

        /// <summary>
        /// Detect changes between current transaction model value and the database old values
        /// </summary>
        /// <returns></returns>
        private AuditEntry DetectChanges()
        {
            IList<Type> entityOutOfTraceability = new List<Type> {typeof(Message), typeof(MsgNotification), typeof(Codification),
               typeof(StockDocumentLine)};
            ChangeTracker.DetectChanges();
            IList<EntityEntry> entitiesList = ChangeTracker.Entries().ToList();
            entitiesList = entitiesList.Where(en => !en.Entity.GetType().IsAssignableToAnyOf(entityOutOfTraceability)
                                                && en.State != EntityState.Detached && en.State != EntityState.Unchanged).ToList();
            var token = DecryptToken();
            string userName = "System";
            string codeCompany = "";
            IList<AuditValues> auditEntries = TracabilityUtility.OnBeforeSaveChanges(entitiesList);
            if (token != null)
            {
                CredentialsModel user = JsonConvert.DeserializeObject<CredentialsModel>(token["user"].ToString());
                userName = user.Email;
                codeCompany = _memoryCache.Get(user.Email).ToString();
            }
            return new AuditEntry
            {
                UserName = userName,
                CodeCompany = codeCompany,
                AuditValues = auditEntries
            };
        }

        /// <summary>
        /// Send AuditEntry object to tracability service for tracing
        /// Use message broker with FIFO principle can be more efficient
        /// </summary>
        /// <param name="auditEntry"></param>
        private async void SendTracabilityService(AuditEntry auditEntry)
        {
            if (auditEntry.AuditValues.Any())
            {
                using HttpClient httpClient = new HttpClient();
                try
                {
                    httpClient.BaseAddress = _appSettings.TracabilityServiceUrl;
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri("Tracability/trace", UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(auditEntry), Encoding.UTF8, _appSettings.MasterMediaType)
                    };
                    await httpClient.SendAsync(httpRequestMessage).ConfigureAwait(continueOnCapturedContext: false);
                }
                catch (Exception)
                {
                }
            }
        }

        public override int SaveChanges()
        {
            AuditEntry auditEntry = DetectChanges();
            ChangeTracker.AutoDetectChangesEnabled = false;
            var result = base.SaveChanges();
            ChangeTracker.AutoDetectChangesEnabled = true;
            TracabilityUtility.SetTemporaryProperties(auditEntry);
            SendTracabilityService(auditEntry);
            return result;
        }
    }
}
