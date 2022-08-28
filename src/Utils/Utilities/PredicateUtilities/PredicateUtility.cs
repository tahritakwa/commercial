using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;

namespace Utils.Utilities.PredicateUtilities
{
    public static class PredicateUtility<TEntity> where TEntity : class
    {
        public static bool IsDefaultOrderBy(ICollection<OrderByViewModel> orderBy)
        {
            return orderBy.Count == 1 && orderBy.First().Prop == "Id";
        }
        private static Dictionary<Operation, Func<Expression, Expression, Expression>> GetExpressions()
        {
            return new Dictionary<Operation, Func<Expression, Expression, Expression>>
            {
                {Operation.Equals, Expression.Equal},
                {Operation.NotEquals, Expression.NotEqual},
                {Operation.GreaterThan, Expression.GreaterThan},
                {Operation.GreaterThanOrEquals, Expression.GreaterThanOrEqual},
                {Operation.LessThan, Expression.LessThan},
                {Operation.LessThanOrEquals, Expression.LessThanOrEqual},
                {Operation.Contains, Contains},
                {Operation.IsEmpty, EmptyString},
                {Operation.IsNotEmpty, NotEmptyString},
                {Operation.IsNotNull, IsNotNullMethod},
                {Operation.IsNull, IsNullMethod},
                {Operation.DoesNotContain, DoesNotContain},
                {Operation.StartsWith, (member, constant) => Expression.Call(member, TypeProcessor.GetStartsWithMethod(), constant)},
                {Operation.EndsWith, (member, constant) => Expression.Call(member, TypeProcessor.GetEndsWithMethod(), constant)}
            };
        }


        /// <summary>
        /// built the expression of the "GetWithRelation" predicate.
        /// </summary>
        /// <param name="predicateRelation">parameters of the expression.</param>
        /// <returns>"GetWithRelation" Expression.</returns>
        public static Expression<Func<TEntity, object>>[] PredicateRelation(ICollection<RelationViewModel> predicateRelation)
        {
            StringBuilder currentObject = new StringBuilder("x");
            PropertyInfo prop = null;
            var parameter = Expression.Parameter(typeof(TEntity), currentObject.ToString());
            Expression<Func<TEntity, object>>[] finalExpression;
            if (predicateRelation != null)
            {
                finalExpression = new Expression<Func<TEntity, object>>[predicateRelation.Count];
                int i = 0;
                dynamic member = null;

                //1ere niveau des predicates
                var firstLevel = predicateRelation.Where(x => x.Prop.IndexOf(".") == -1).ToList();
                foreach (var predicate in firstLevel)
                {
                    prop = parameter.Type.GetProperty(predicate.Prop);
                    if (prop != null)
                    {
                        member = Expression.Property(parameter, predicate.Prop);
                        finalExpression[i] = Expression.Lambda<Func<TEntity, object>>(member, parameter);
                        i++;
                        if (predicateRelation.Count != firstLevel.Count)
                        {
                            i = SearchForNavigation(predicate.Prop, finalExpression, prop, predicateRelation, member, i, parameter);
                        }
                    }

                }
            }
            else
            {
                finalExpression = new Expression<Func<TEntity, object>>[0];
            }
            return finalExpression;

        }

        private static int SearchForNavigation(string currentObject, Expression<Func<TEntity, object>>[] finalExpression, PropertyInfo prop,
            ICollection<RelationViewModel> predicateRelation, dynamic member, int i, ParameterExpression parameter)
        {
            //recuperate list of predicate in yhis level 
            var niemeLevel = predicateRelation.Where(x => x.Prop.Contains(currentObject + ".")).OrderBy(x => x.Prop.Split('.').Count()).ToList();
            // save proretiy info 
            PropertyInfo propinfo;
            //save menber
            dynamic usingMember;

            foreach (var predicate in niemeLevel)
            {
                //recuperate navigation 
                var predicateExpr = predicate.Prop.Substring(currentObject.Length + 1);
                // recuperate current object 
                var current = "x." + currentObject;

                ParameterExpression stream = Expression.Parameter(prop.PropertyType, current.ToString());

                //get Property for the predicate Expression
                propinfo = stream.Type.GetProperty(predicateExpr);

                if (propinfo != null)
                {

                    usingMember = Expression.Property(member, predicateExpr);
                    finalExpression[i] = Expression.Lambda<Func<TEntity, object>>(usingMember, parameter);
                    i++;

                    SearchForNavigation(predicate.Prop, finalExpression, propinfo, predicateRelation, usingMember, i, parameter);
                }

            }
            return i;

        }
        /// <summary>
        /// built the expression of the "Where" predicate.
        /// </summary>
        /// <param name="predicateFiltersCollection">parameters of the "Where" expression.</param>
        /// <param name="operatorPredicate">The operator of the predicate.</param>
        /// <returns>"Where" Expression.</returns>
        public static Expression<Func<TEntity, bool>> PredicateFilter(PredicateFormatViewModel predicateCollection, Operator operatorPredicate = Operator.And)
        {
            ICollection<FilterViewModel> predicateFiltersCollection = predicateCollection.Filter;
            Expression globalBody = Expression.Constant(true);
            Expression link = null;
            bool isSearch = false;
            var parameter = Expression.Parameter(typeof(TEntity), "x");
            if (predicateFiltersCollection != null)
            {
                foreach (var predicate in predicateFiltersCollection.OrderBy(x => x.IsSearchPredicate))
                {
                    Expression body = GetExpression(parameter, predicate);
                    if (body != null)
                    {
                        if (predicate.IsSearchPredicate)
                        {
                            link = CreatSearchePredicatExpression(ref isSearch, link, body);
                        }
                        else
                        {
                            globalBody = operatorPredicate == Operator.And ? Expression.AndAlso(globalBody, body) : Expression.OrElse(globalBody, body);
                        }
                    }
                }
                if (link != null)
                    globalBody = Expression.AndAlso(globalBody, link);
            }

            return Expression.Lambda<Func<TEntity, bool>>(globalBody, parameter);

        }

        private static Expression CreatSearchePredicatExpression(ref bool isSearch, Expression link, Expression body)
        {
            Expression linkSearchPrediacte;
            if (isSearch)
            {
                linkSearchPrediacte = Expression.OrElse(link, body);
            }
            else
            {
                linkSearchPrediacte = body;
                isSearch = true;
            }
            return linkSearchPrediacte;
        }

        /// <summary>
        /// Built a single expression/condition for the "Where" expression.
        /// format: parameter(x).Property(Id) Function(Equal) value(3)
        /// formar: x.Id == 3
        /// </summary>
        /// <param name="param">The parameter  of the expression.</param>
        /// <param name="filter">Condition.</param>
        /// <returns>Expression as x.Id == 3 .</returns>
        public static Expression GetExpression(ParameterExpression param, FilterViewModel filter)
        {
            try
            {
                Expression member = GetMemberExpression(param, filter.Prop);
                Expression constant = Expression.Constant(filter.Value);
                var entity = Activator.CreateInstance<TEntity>();
                Type type = GetPropertyType(entity, filter.Prop);
                if (TypeProcessor.TypesOperations.ContainsKey(Type.GetTypeCode(type)))
                    TypeProcessor.TypesOperations[Type.GetTypeCode(type)].Invoke(ref member, ref constant, ref type, filter);
                else
                    TypeProcessor.TypesOperations[TypeCode.Empty].Invoke(ref member, ref constant, ref type, filter);
                member = Expression.Convert(member, type);
                Operation key = filter.Operation == 0 ? Operation.Equals : filter.Operation;
                return GetExpressions()[key].Invoke(member, constant);
            }
            catch (Exception)
            {
                return null;
            }


        }



        static Type GetPropertyType(object entity, string propertyName)
        {
            PropertyInfo propInfo;
            if (propertyName.Contains("."))
            {
                int index = propertyName.IndexOf(".", StringComparison.Ordinal);
                string subString = propertyName.Substring(0, index);
                propInfo = entity.GetType().GetProperty(subString, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                object newEntity = Activator.CreateInstance(propInfo.PropertyType);
                return GetPropertyType(newEntity, propertyName.Substring(index + 1));
            }
            propInfo = entity.GetType().GetProperty(propertyName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
            return propInfo.PropertyType.GetTypeInfo().IsGenericType ? propInfo.PropertyType.GenericTypeArguments[0] : propInfo.PropertyType;
        }
        /// <summary>
        /// Gets the member expression: parameter(x).Property(Id).
        /// </summary>
        /// <param name="param">The parameter.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <returns>MemberExpression.</returns>
        public static MemberExpression GetMemberExpression(Expression param, string propertyName)
        {
            if (propertyName.Contains("."))
            {
                int index = propertyName.IndexOf(".", StringComparison.Ordinal);
                var subParam = Expression.Property(param, propertyName.Substring(0, index));
                return GetMemberExpression(subParam, propertyName.Substring(index + 1));
            }
            return Expression.Property(param, propertyName);
        }
        /// <summary>
        /// Treat the specific behaviour of the [contains] function 
        /// for the string property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression Contains(Expression member, Expression expression)
        {
            ConstantExpression constantExpression = expression as ConstantExpression;
            var constant = constantExpression;
            if (constant?.Value is IList && constant.Value.GetType().GetTypeInfo().IsGenericType)
            {
                var type = constant.Value.GetType();
                var containsInfo = type.GetMethod("Contains", new[] { type.GetGenericArguments()[0] });
                var contains = Expression.Call(constant, containsInfo, member);
                return contains;
            }
            return Expression.Call(member, TypeProcessor.GetContainsMethod(), expression);
        }

        /// <summary>
        /// Treat the specific behaviour of the [ not contains] function 
        /// for the string property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression DoesNotContain(Expression member, Expression expression)
        {
            return Expression.Not(Contains(member, expression));
        }

        /// <summary>
        /// Treat the specific behaviour of the [ Empty String] function 
        /// for the string property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression EmptyString(Expression member, Expression expression)
        {
            Expression constant = Expression.Constant("");
            return Expression.Equal(member, constant);
        }

        /// <summary>
        /// Treat the specific behaviour of the [ Not Empty String] function 
        /// for the string property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression NotEmptyString(Expression member, Expression expression)
        {
            return Expression.Not(EmptyString(member, expression));
        }

        /// <summary>
        /// Treat the specific behaviour of the [ Is Not null Method ] function 
        /// for All property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression IsNotNullMethod(Expression member, Expression expression)
        {
            return Expression.Not(IsNullMethod(member, expression));
        }

        /// <summary>
        /// Treat the specific behaviour of the [ Is null Method ] function 
        /// for All property.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="expression">The expression.</param>
        /// <returns>Expression.</returns>
        static Expression IsNullMethod(Expression member, Expression expression)
        {
            Expression constant = Expression.Constant(null);
            return Expression.Equal(member, constant);
        }
    }
    /// <summary>    
    /// Enables the efficient, dynamic composition of query predicates.    
    /// </summary>    
    public static class PredicateBuilder
    {
        /// <summary>    
        /// Creates a predicate that evaluates to true.    
        /// </summary>    
        public static Expression<Func<T, bool>> True<T>() { return param => true; }

        /// <summary>    
        /// Creates a predicate that evaluates to false.    
        /// </summary>    
        public static Expression<Func<T, bool>> False<T>() { return param => false; }

        /// <summary>    
        /// Creates a predicate expression from the specified lambda expression.    
        /// </summary>    
        public static Expression<Func<T, bool>> Create<T>(Expression<Func<T, bool>> predicate) { return predicate; }

        /// <summary>    
        /// Combines the first predicate with the second using the logical "and".    
        /// </summary>    
        public static Expression<Func<T, bool>> And<T>(this Expression<Func<T, bool>> first, Expression<Func<T, bool>> second)
        {
            return first.Compose(second, Expression.AndAlso);
        }

        /// <summary>    
        /// Combines the first predicate with the second using the logical "or".    
        /// </summary>    
        public static Expression<Func<T, bool>> Or<T>(this Expression<Func<T, bool>> first, Expression<Func<T, bool>> second)
        {
            return first.Compose(second, Expression.OrElse);
        }

        /// <summary>    
        /// Negates the predicate.    
        /// </summary>    
        public static Expression<Func<T, bool>> Not<T>(this Expression<Func<T, bool>> expression)
        {
            var negated = Expression.Not(expression.Body);
            return Expression.Lambda<Func<T, bool>>(negated, expression.Parameters);
        }

        /// <summary>    
        /// Combines the first expression with the second using the specified merge function.    
        /// </summary>    
        static Expression<T> Compose<T>(this Expression<T> first, Expression<T> second, Func<Expression, Expression, Expression> merge)
        {
            // zip parameters (map from parameters of second to parameters of first)    
            var map = first.Parameters
                .Select((f, i) => new { f, s = second.Parameters[i] })
                .ToDictionary(p => p.s, p => p.f);

            // replace parameters in the second lambda expression with the parameters in the first    
            var secondBody = ParameterRebinder.ReplaceParameters(map, second.Body);

            // create a merged lambda expression with parameters from the first expression    
            return Expression.Lambda<T>(merge(first.Body, secondBody), first.Parameters);
        }

        class ParameterRebinder : ExpressionVisitor
        {
            readonly Dictionary<ParameterExpression, ParameterExpression> map;

            ParameterRebinder(Dictionary<ParameterExpression, ParameterExpression> map)
            {
                this.map = map ?? new Dictionary<ParameterExpression, ParameterExpression>();
            }

            public static Expression ReplaceParameters(Dictionary<ParameterExpression, ParameterExpression> map, Expression exp)
            {
                return new ParameterRebinder(map).Visit(exp);
            }

            protected override Expression VisitParameter(ParameterExpression p)
            {
                ParameterExpression replacement;

                if (map.TryGetValue(p, out replacement))
                {
                    p = replacement;
                }

                return base.VisitParameter(p);
            }
        }
    }
}
