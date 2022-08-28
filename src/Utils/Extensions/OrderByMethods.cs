using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Reflection;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;

namespace Utils.Extensions
{
    /// <exclude />
    public static class OrderByMethods
    {
        /// <summary>
        /// The order by asc method
        /// </summary>
        private static MethodInfo OrderByMethod => MethodOf(() => Queryable.OrderBy(default(IQueryable<object>), default(Expression<Func<object, object>>)))
            .GetGenericMethodDefinition();


        /// <summary>
        /// The order by descending method
        /// </summary>
        private static MethodInfo OrderByDescendingMethod => MethodOf(() => Queryable.OrderByDescending(default(IQueryable<object>), default(Expression<Func<object, object>>)))
            .GetGenericMethodDefinition();

        /// <summary>
        /// The then by method
        /// </summary>
        private static MethodInfo ThenByMethod => MethodOf(() => Queryable.ThenBy(default(IOrderedQueryable<object>), default(Expression<Func<object, object>>)))
            .GetGenericMethodDefinition();
        /// <summary>
        /// The then by descending method
        /// </summary>
        private static MethodInfo ThenByDescendingMethod => MethodOf(() => Queryable.ThenByDescending(default(IOrderedQueryable<object>), default(Expression<Func<object, object>>)))
            .GetGenericMethodDefinition();
        /// <summary>
        /// Methods the of.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="method">The method.</param>
        /// <returns>MethodInfo.</returns>
        public static MethodInfo MethodOf<T>(Expression<Func<T>> method)
        {
            MethodCallExpression mce = (MethodCallExpression)method.Body;
            MethodInfo mi = mce.Method;
            return mi;
        }


        public static IQueryable<TEntity> BuildOrderBysQue<TEntity>(this IQueryable<TEntity> source, ICollection<OrderByViewModel> predicateOrderBy)
        {
            try
            {
                if (predicateOrderBy == null || !predicateOrderBy.Any()) return source;

                var typeOfT = typeof(TEntity);

                Type t = typeOfT;


                //for the order by then
                IOrderedQueryable<TEntity> result = null;
                //initialize by false for the first propertie
                var thenBy = false;

                foreach (var item in predicateOrderBy
                    .Select(prop => new { PropertyInfo = t.GetProperty(prop.Prop), prop.Direction }))
                {
                    if (item.PropertyInfo != null)
                    {
                        var oExpr = Expression.Parameter(typeOfT, "o");
                        var propertyInfo = item.PropertyInfo;
                        var propertyType = propertyInfo.PropertyType;
                        var isAscending = item.Direction == OrderByDirection.ASC;

                        if (thenBy) // Then by; others iterations
                        {
                            var parameter = Expression.Parameter(typeof(IOrderedQueryable<TEntity>), "x");
                            var expr1 = Expression.Lambda<Func<IOrderedQueryable<TEntity>, IOrderedQueryable<TEntity>>>(
                                Expression.Call(
                                    (isAscending ? ThenByMethod : ThenByDescendingMethod).MakeGenericMethod(typeOfT, propertyType),
                                    parameter,
                                    Expression.Lambda(
                                        typeof(Func<,>).MakeGenericType(typeOfT, propertyType),
                                        Expression.MakeMemberAccess(oExpr, propertyInfo),
                                        oExpr)
                                    ),
                                parameter)
                                .Compile();

                            result = expr1(result);
                        }
                        else // Order by; first iteration
                        {
                            var parameter = Expression.Parameter(typeof(IQueryable<TEntity>), "x");
                            var expr1 = Expression.Lambda<Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>>>(
                                Expression.Call(
                                    (isAscending ? OrderByMethod : OrderByDescendingMethod).MakeGenericMethod(typeOfT, propertyType),
                                    parameter,
                                    Expression.Lambda(
                                        typeof(Func<,>).MakeGenericType(typeOfT, propertyType),
                                        Expression.MakeMemberAccess(oExpr, propertyInfo),
                                        oExpr)
                                    ),
                                parameter)
                                .Compile();

                            result = expr1(source);
                            thenBy = true;
                        }
                    }
                    else
                    {
                        return source;
                    }
                }
                return result;
            }
            catch (Exception)
            {
                return source;
            }

        }
        public static IQueryable<TEntity> OrderByRelation<TEntity>(this IQueryable<TEntity> source, ICollection<OrderByViewModel> predicateOrderBy)
        {
            try
            {
                var thenBy = false;
                if (predicateOrderBy == null)
                {
                    return source;
                }

                IQueryable<TEntity> sourceAfterOrderBy = source;
                if (predicateOrderBy == null)
                {
                    return source;
                }
                string order=""; 

                foreach (var item in predicateOrderBy)
                {
                    if (thenBy)
                    {
                        order = order+", " +item.Prop + " " + item.Direction;

                    }else
                    {
                        order = item.Prop + " " + item.Direction;
                        thenBy = true;
                    }
                }

                return sourceAfterOrderBy.OrderBy(order);
            }
            catch (Exception e)
            {
                return source;
            }
        }
    }
}
