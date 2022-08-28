using System;
using System.Linq.Expressions;

namespace Utils.Utilities.PredicateUtilities
{
    public class PredicateFilterRelationViewModel<TEntity> where TEntity : class
    {
        public Expression<Func<TEntity, bool>> PredicateWhere { get; set; }
        public Expression<Func<TEntity, object>>[] PredicateRelations { get; set; }

        public PredicateFilterRelationViewModel(Expression<Func<TEntity, bool>> predicateWhere, Expression<Func<TEntity, object>>[] predicateRelations)
        {
            PredicateWhere = predicateWhere;
            PredicateRelations = predicateRelations;
        }
    }
}
