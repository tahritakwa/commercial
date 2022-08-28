using Microsoft.EntityFrameworkCore;
using Persistence.Context;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Persistence.UnitOfWork.Interfaces
{
    public interface IGenericUnitOfWork : IDisposable
    {
        DbSet<T> Set<T>() where T : class;
        IQueryable<T> SetAsNoTracking<T>() where T : class;
        IQueryable<T> SetWithRelations<T>(Expression<Func<T, object>>[] includeExpressions) where T : class;
        IQueryable<T> SetWithRelationsAsNoTracking<T>(Expression<Func<T, object>>[] includeExpressions) where T : class;
        void Commit();
        void BeginTransaction();
        void BeginTransaction(string connectionString);
        void CommitTransaction();
        void RollbackTransaction();
        BaseContext GetContext();
        void SetContext(BaseContext context);
        Task SaveChangesAsync();
        void SetConnectionString(string connectionString);
        void BeginTransactionunReadUncommitted();
        void BeginTransactionunReadUncommitted(string connectionString);
        int CommitWithoutTraceability();
    }
}
