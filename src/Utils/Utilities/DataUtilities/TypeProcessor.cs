using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;

namespace Utils.Utilities.DataUtilities
{

    public static class TypeProcessor
    {
        #region OperationPerTypeDictionary
        internal delegate void PredicateTypeAction(ref Expression member, ref Expression expr, ref Type type, FilterViewModel filter);
        internal static readonly IDictionary<TypeCode, PredicateTypeAction> TypesOperations = new Dictionary<TypeCode, PredicateTypeAction>
            {
            {TypeCode.Int32, ProcessInt32},
            { TypeCode.Int64,ProcessInt64},
            {TypeCode.String,ProcessString},
            {TypeCode.DateTime,ProcessDateTime},
            {TypeCode.Double,ProcessDouble},
            {TypeCode.Boolean,ProcessBoolean},
            {TypeCode.Object,ProcessObject},
            {TypeCode.Empty,ProcessOtherObject}
            };


        #endregion

        #region methodUsed
        public static MethodInfo GetContainsMethod()
        {
            return typeof(string).GetMethod("Contains", new[] { typeof(string) });
        }

        public static MethodInfo GetTrimMethod()
        {
            return typeof(string).GetMethod("Trim", new Type[0]);
        }

        public static MethodInfo GetToLowerMethod()
        {
            return typeof(string).GetMethod("ToLower", new Type[0]);
        }

        public static MethodInfo GetStartsWithMethod()
        {
            return typeof(string).GetMethod("StartsWith", new[] { typeof(string) });
        }

        public static MethodInfo GetEndsWithMethod()
        {
            return typeof(string).GetMethod("EndsWith", new[] { typeof(string) });
        }
        #endregion

        public static void ProcessInt32(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            if (filter != null)
            {
                if (CheckOperation(filter.Operation))
                {
                    member = Expression.Call(member, GeToStringMethod());
                    type = typeof(String);
                    return;
                }

                if (filter.Value != null)
                {
                    constant = Expression.Constant(Convert.ToInt32(filter.Value));
                }

                if (filter.Operation == Operation.IsNull || filter.Operation == Operation.IsNotNull)
                {
                    type = typeof(Int32?);
                }
            }
        }
        public static void ProcessInt64(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            if (filter != null)
            {
                if (CheckOperation(filter.Operation))
                {
                    member = Expression.Call(member, GeToStringMethod());
                    type = typeof(String);
                    return;
                }
                if (filter.Value != null)
                {
                    constant = Expression.Constant(Convert.ToInt64(filter.Value));
                }
                if (filter.Operation == Operation.IsNull || filter.Operation == Operation.IsNotNull)
                {
                    type = typeof(Int64?);
                }

            }

        }
        public static void ProcessString(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            var trimMemberCall = Expression.Call(member, GetTrimMethod());
            member = Expression.Call(trimMemberCall, GetToLowerMethod());
            if (constant.ToString() != "null")
            {
                var trimConstantCall = Expression.Call(constant, GetTrimMethod());
                constant = Expression.Call(trimConstantCall, GetToLowerMethod());
            }
        }
        public static void ProcessDateTime(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            constant = Expression.Constant(Convert.ToDateTime(filter.Value));
        }
        public static void ProcessDouble(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            if (filter != null)
            {
                if (CheckOperation(filter.Operation))
                {
                    member = Expression.Call(member, GeToStringMethod());
                    type = typeof(String);
                    return;
                }

                if (filter.Value != null)
                {
                    constant = Expression.Constant(Convert.ToDouble(filter.Value));
                }
                if (filter.Operation == Operation.IsNull || filter.Operation == Operation.IsNotNull)
                {
                    type = typeof(double?);
                }

            }
        }
        private static MethodInfo GeToStringMethod()
        {
            return typeof(Object).GetMethod("ToString", System.Type.EmptyTypes);
        }

        public static void ProcessBoolean(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            constant = Expression.Constant(Convert.ToBoolean(filter.Value));
        }
        public static void ProcessObject(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            constant = Expression.Constant(filter.Value);
        }
        public static void ProcessOtherObject(ref Expression member, ref Expression constant, ref Type type, FilterViewModel filter)
        {
            Convert.ChangeType(filter.Value, type);
            constant = Expression.Constant(filter.Value);
        }

        private static bool CheckOperation(Operation operation)
        {
            if (operation == Operation.Contains || operation == Operation.DoesNotContain || operation == Operation.StartsWith || operation == Operation.EndsWith)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

    }
}
