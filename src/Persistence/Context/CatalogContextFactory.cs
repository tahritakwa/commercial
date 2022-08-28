using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.CatalogEntities;
using Settings.Config;
using System;
using System.Linq.Expressions;

namespace Persistence.Context
{
    public partial class CatalogContextFactory: CatalogContext
    {
        private readonly bool _isIocCall;
        private readonly AppSettings _appSettings;

        public CatalogContextFactory(DbContextOptions<CatalogContextFactory> options, IOptions<AppSettings> appSettings,
            bool isIocCall = true) : base(options)
        {
            _isIocCall = isIocCall;
            _appSettings = appSettings.Value;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (_isIocCall)
            {
                var connexionString = string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                   _appSettings.MasterDbSettings.Server, _appSettings.MasterDbSettings.DataBaseName, _appSettings.MasterDbSettings.UserId, _appSettings.MasterDbSettings.UserPassword);
                optionsBuilder.UseSqlServer(connexionString);
            }
            else
            {
                base.OnConfiguring(optionsBuilder);
            }
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


    }
}
