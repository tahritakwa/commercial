using Microsoft.EntityFrameworkCore;
using Persistence.Context;
using Persistence.UnitOfWork.Interfaces;
using System;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
namespace Persistence.UnitOfWork.Classes
{
    public class GenericUnitOfWork : IGenericUnitOfWork
    {
        private BaseContext _context;

        public GenericUnitOfWork(BaseContext context)
        {
            _context = context;
        }

        public BaseContext GetContext()
        {
            return _context;
        }

        public void BeginTransaction()
        {
            _context.Database.BeginTransaction();
        }
        public void BeginTransactionunReadUncommitted()
        {
            _context.Database.BeginTransaction(System.Data.IsolationLevel.ReadUncommitted);
        }
        public void BeginTransactionunReadUncommitted(string connectionString)
        {
            _context.GeneratedConnectionString = connectionString;
            _context.Database.BeginTransaction(System.Data.IsolationLevel.ReadUncommitted);
        }
        public void BeginTransaction(string connectionString)
        {
            _context.GeneratedConnectionString = connectionString;
            _context.Database.BeginTransaction();
        }

        public void SetConnectionString(string connectionString)
        {
            _context.GeneratedConnectionString = connectionString;
        }
        public void CommitTransaction()
        {
            _context.Database.CommitTransaction();
        }

        public void RollbackTransaction()
        {
            if (_context.Database.CurrentTransaction != null)
            {
                _context.Database.RollbackTransaction();
            }
        }

        public DbSet<T> Set<T>() where T : class
        {
            return _context.Set<T>();
        }
        public IQueryable<T> SetAsNoTracking<T>() where T : class
        {
            return _context.Set<T>().AsNoTracking().AsQueryable();
        }
        public IQueryable<T> SetWithRelations<T>(Expression<Func<T, object>>[] includeExpressions) where T : class
        {
            IQueryable<T> set = _context.Set<T>();
            foreach (var includeExpression in includeExpressions)
            {
                if (includeExpression != null)
                {
                    set = set.Include(includeExpression);
                }
            }
            return set;
        }
        public IQueryable<T> SetWithRelationsAsNoTracking<T>(Expression<Func<T, object>>[] includeExpressions) where T : class
        {
            IQueryable<T> set = _context.Set<T>().AsNoTracking().AsQueryable();
            foreach (var includeExpression in includeExpressions)
            {
                set = set.Include(includeExpression);
            }
            return set;
        }
        public void Commit()
        {
            //_context.ChangeTracker.AutoDetectChangesEnabled = false;

            _context.SaveChanges();
        }
        public int CommitWithoutTraceability()
        {
            return _context.SaveChangesWithoutTraceability();
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);  // Violates rule
        }
        protected virtual void Dispose(bool isdisposing)
        {
            if (isdisposing)
            {
                _context.Dispose();
            }
        }
        public int CreateCommand(String Command)
        {
            var cmd = _context.Database.GetDbConnection().CreateCommand();
            cmd.CommandText = Command;
            if (cmd.Connection.State != ConnectionState.Open) cmd.Connection.Open();
            return cmd.ExecuteNonQuery();
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }

        public void SetContext(BaseContext context)
        {
            var starktype = context.GetType();
            _context = BaseContext.DynamicCastTo(context, starktype, true);
        }
    }
}
