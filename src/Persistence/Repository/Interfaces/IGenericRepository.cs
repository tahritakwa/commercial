using Persistence.UnitOfWork.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Persistence.Repository.Interfaces
{
    public interface IGenericRepository<TEntity> : IDisposable where TEntity : class
    {
        IQueryable<TEntity> GetAll();
        IQueryable<TEntity> GetAllAsNoTracking();
        IQueryable<TEntity> QuerableGetAll(params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TEntity> GetAllWithRelations(params Expression<Func<TEntity, object>>[] predicate);
        TEntity GetSingle(Expression<Func<TEntity, bool>> predicate);
        IQueryable<TEntity> GetAllWithConditionsRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TEntity> GetAllWithConditions(Expression<Func<TEntity, bool>> conditionPredicate);
        IQueryable<TEntity> GetAllWithConditionsRelationsAsNoTracking(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        TEntity GetLast();
        TEntity GetFirst();
        IQueryable<TEntity> FindBy(Expression<Func<TEntity, bool>> predicate);
        IQueryable<TEntity> FindByAsNoTracking(Expression<Func<TEntity, bool>> predicate);
        void Add(TEntity entity);
        void Remove(TEntity entity);
        void RemoveRange(TEntity[] entity);
        void Update(TEntity entity);
        int GetCount();
        int GetCountWithPredicate(Expression<Func<TEntity, bool>> predicate);
        int GetCountWithPredicate(Expression<Func<TEntity, bool>> predicate, Expression<Func<TEntity, bool>> predicateWhere);
        List<string> GetPropertiesByConstraint(string constraint);
        IGenericUnitOfWork GetUnitOfWork();
        TEntity FindSingleBy(Expression<Func<TEntity, bool>> predicate);
        int GetCountWithPredicates(Expression<Func<TEntity, object>>[] predicateRelations, Expression<Func<TEntity, bool>> predicateWhere, Expression<Func<TEntity, bool>> conditionPredicate);
        TEntity GetLastWithRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        TEntity GetSingleWithRelationsNotTracked(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        TEntity GetSingleNotTracked(Expression<Func<TEntity, bool>> conditionPredicate);
        Task<TEntity> AddAsync(TEntity entity);
        TEntity GetSingleWithRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        void BulkAdd(IList<TEntity> entities);
        void BulkUpdate(IList<TEntity> entities);
        void BulkDeletePhysically(IEnumerable<TEntity> entities);
        TEntity GetSingleWithRelations(params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TEntity> GetAllWithConditionsRelationsQueryable(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TEntity> GetAllWithConditionsRelationsQueryableAsNoTracking(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TEntity> GetAllWithConditionsQueryable(Expression<Func<TEntity, bool>> conditionPredicate);
    }
}
