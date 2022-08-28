using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Persistence.Repository.Classes
{

    public class GenericRepository<TEntity> : IGenericRepository<TEntity>
        where TEntity : class
    {
        private readonly IGenericUnitOfWork _unitOfWork;

        public GenericRepository(IGenericUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public IQueryable<TEntity> GetAll()
        {
            return _unitOfWork.Set<TEntity>();
        }

        public IQueryable<TEntity> GetAllAsNoTracking()
        {
            return _unitOfWork.SetAsNoTracking<TEntity>();
        }

        public IGenericUnitOfWork GetUnitOfWork()
        {
            return _unitOfWork;
        }

        public IQueryable<TEntity> QuerableGetAll(params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            if (relationPredicate != null)
            {
                return _unitOfWork.SetWithRelations(relationPredicate);
            }
            return _unitOfWork.Set<TEntity>();

        }
        public IQueryable<TEntity> GetAllWithRelations(Expression<Func<TEntity, object>>[] predicate)
        {
            return _unitOfWork.SetWithRelations(predicate);
        }
        public IQueryable<TEntity> GetAllWithConditionsRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return GetAllWithConditionsRelationsQueryable(conditionPredicate, relationPredicate);
        }
        public IQueryable<TEntity> GetAllWithConditions(Expression<Func<TEntity, bool>> conditionPredicate)
        {
            return GetAllWithConditionsQueryable(conditionPredicate);
        }

        public IQueryable<TEntity> GetAllWithConditionsRelationsQueryable(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            IQueryable<TEntity> query = _unitOfWork.SetWithRelations(relationPredicate);
            query = query.Where(conditionPredicate);
            return query;
        }
        public IQueryable<TEntity> GetAllWithConditionsQueryable(Expression<Func<TEntity, bool>> conditionPredicate)
        {
            IQueryable<TEntity> query = _unitOfWork.Set<TEntity>();
            query = query.Where(conditionPredicate);
            return query;
        }

        public IQueryable<TEntity> GetAllWithConditionsRelationsAsNoTracking(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return GetAllWithConditionsRelationsQueryableAsNoTracking(conditionPredicate, relationPredicate);
        }
        public IQueryable<TEntity> GetAllWithConditionsRelationsQueryableAsNoTracking(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            IQueryable<TEntity> query = _unitOfWork.SetWithRelationsAsNoTracking(relationPredicate);
            query = query.Where(conditionPredicate);
            return query;
        }
        public TEntity GetSingle(Expression<Func<TEntity, bool>> predicate)
        {
            return _unitOfWork.Set<TEntity>().SingleOrDefault(predicate);
        }
        public TEntity GetSingleWithRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return _unitOfWork.SetWithRelations(relationPredicate).SingleOrDefault(conditionPredicate);
        }
        public TEntity GetLast()
        {
            return _unitOfWork.Set<TEntity>().LastOrDefault();
        }
        public TEntity GetFirst()
        {
            return _unitOfWork.Set<TEntity>().FirstOrDefault();
        }

        public IQueryable<TEntity> FindBy(Expression<Func<TEntity, bool>> predicate)
        {
            return _unitOfWork.Set<TEntity>().Where(predicate);
        }
        public TEntity FindSingleBy(Expression<Func<TEntity, bool>> predicate)
        {
            return _unitOfWork.Set<TEntity>().Where(predicate).FirstOrDefault();
        }

        public IQueryable<TEntity> FindByAsNoTracking(Expression<Func<TEntity, bool>> predicate)
        {
            return _unitOfWork.Set<TEntity>().AsNoTracking().Where(predicate);
        }
        public int GetCount()
        {
            return _unitOfWork.Set<TEntity>().Count();
        }
        public int GetCountWithPredicate(Expression<Func<TEntity, bool>> predicate)
        {
            if (predicate != null)
                return _unitOfWork.Set<TEntity>().Where(predicate).Count();
            else
                return GetCount();
        }

        public int GetCountWithPredicate(Expression<Func<TEntity, bool>> predicate, Expression<Func<TEntity, bool>> predicateWhere)
        {
            if (predicate != null && predicateWhere != null)
                return _unitOfWork.Set<TEntity>()
                    .Where(predicate).Where(predicateWhere).Count();
            else
                return GetCount();
        }

        public void Add(TEntity entity)
        {

            if (entity == null)
            {
                throw new ArgumentNullException(nameof(entity));
            }
            _unitOfWork.Set<TEntity>().Add(entity);

        }

        public void AttachAsModified(TEntity entity)
        {
            _unitOfWork.GetContext().Attach(entity);
            _unitOfWork.GetContext().Entry(entity).State = EntityState.Modified;
            var context = _unitOfWork.GetContext();
            var entityByContext = context.Model.GetEntityTypes().FirstOrDefault(elt => elt.Name.Contains(entity.GetType().Name));
            foreach (var navigation in entityByContext.GetNavigations())
            {
                _unitOfWork.GetContext().Entry(entityByContext.GetType().GetProperty(navigation.Name)).State = EntityState.Modified;
            }
            _unitOfWork.GetContext().SaveChanges();

        }

        public void Remove(TEntity entity)
        {
            if (entity == null)
            {
                throw new ArgumentNullException(nameof(entity));
            }
            var data = _unitOfWork.Set<TEntity>().Remove(entity);
            data.State = EntityState.Deleted;
        }

        public void RemoveRange(TEntity[] entity)
        {

            if (entity == null)
            {
                throw new ArgumentNullException(nameof(entity));
            }
            _unitOfWork.Set<TEntity>().RemoveRange(entity);

        }

        public void Update(TEntity entity)
        {
            if (entity == null)
            {
                throw new ArgumentNullException(nameof(entity));
            }
            var data = _unitOfWork.Set<TEntity>().Attach(entity);
            data.State = EntityState.Modified;
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
                _unitOfWork.Dispose();
            }
        }

        public List<string> GetPropertiesByConstraint(string constraint)
        {
            List<string> result = new List<string>();
            // PARAMETERIZED QUERIES!
            using (SqlConnection connection = new SqlConnection(_unitOfWork.GetContext().Database.GetDbConnection().ConnectionString))
            {
                SqlCommand command = new SqlCommand();
                command.Parameters.Add("@ConstraintCode", SqlDbType.NVarChar);
                command.Parameters["@ConstraintCode"].Value = constraint;
                command.Connection = connection;
                command.CommandText = "select TC.Constraint_Name, CC.Column_Name from information_schema.table_constraints TC inner join " +
                    "information_schema.constraint_column_usage CC on TC.Constraint_Name = CC.Constraint_Name " +
                    "where TC.constraint_type = 'Unique' and TC.Constraint_Name = @ConstraintCode and CC.Column_Name != 'Deleted_Token' ";
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        result.Add((string)reader["Column_Name"]);
                    }
                }

            }

            return result;
        }

        public int GetCountWithPredicates(Expression<Func<TEntity, object>>[] predicateRelations, Expression<Func<TEntity, bool>> predicateWhere, Expression<Func<TEntity, bool>> conditionPredicate)
        {
            return _unitOfWork.SetWithRelations(predicateRelations).Where(predicateWhere).Where(conditionPredicate).Count();
        }

        public TEntity GetSingleWithRelationsNotTracked(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return _unitOfWork.SetWithRelations(relationPredicate).AsNoTracking().SingleOrDefault(conditionPredicate);
        }
        public TEntity GetSingleWithRelations(params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return _unitOfWork.SetWithRelations(relationPredicate).SingleOrDefault();
        }

        public TEntity GetSingleNotTracked(Expression<Func<TEntity, bool>> conditionPredicate)
        {
            return _unitOfWork.Set<TEntity>().AsNoTracking().SingleOrDefault(conditionPredicate);
        }

        public async Task<TEntity> AddAsync(TEntity entity)
        {
            _unitOfWork.Set<TEntity>().Add(entity);
            await _unitOfWork.SaveChangesAsync();
            return entity;
        }
        public TEntity GetLastWithRelations(Expression<Func<TEntity, bool>> conditionPredicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return _unitOfWork.SetWithRelations(relationPredicate).LastOrDefault(conditionPredicate);
        }

        /// <summary>
        /// Make bulk insert
        /// </summary>
        /// <param name="entities"></param>
        /// <returns></returns>
        public void BulkAdd(IList<TEntity> entities)
        {
            if (entities == null)
            {
                throw new ArgumentNullException(nameof(entities));
            }
            _unitOfWork.GetContext().AddRange(entities);
        }

        /// <summary>
        /// Make bulk update
        /// </summary>
        /// <param name="entities"></param>
        public void BulkUpdate(IList<TEntity> entities)
        {
            if (entities == null)
            {
                throw new ArgumentNullException(nameof(entities));
            }
            _unitOfWork.GetContext().UpdateRange(entities);
            _unitOfWork.GetContext().BulkUpdateAsync(entities);
        }

        /// <summary>
        /// Bulk Delete physically an array of entities 
        /// </summary>
        /// <param name="entities"></param>
        public void BulkDeletePhysically(IEnumerable<TEntity> entities)
        {
            if (entities == null)
            {
                throw new ArgumentNullException(nameof(entities));
            }
            entities.ToList().ForEach(entity =>
            {
                var data = _unitOfWork.Set<TEntity>().Remove(entity);
                data.State = EntityState.Deleted;
            });
            _unitOfWork.GetContext().RemoveRange(entities);
            _unitOfWork.GetContext().BulkDeleteAsync(entities);
        }
    }
}
