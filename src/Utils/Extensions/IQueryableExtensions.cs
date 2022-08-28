using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using Remotion.Linq.Parsing.Structure;
using System.Linq;
using System.Reflection;

namespace Utils.Extensions
{
    public static class IQueryableExtensions
    {
       /* private static readonly TypeInfo QueryCompilerTypeInfo =
            typeof(QueryCompiler).GetTypeInfo();
        private static readonly TypeInfo QueryModelGeneratorTypeInfo =
            typeof(QueryModelGenerator).GetTypeInfo();
        private static readonly FieldInfo QueryCompilerField =
            typeof(EntityQueryProvider).GetTypeInfo().DeclaredFields
                .First(x => x.Name == "_queryCompiler");
        private static readonly FieldInfo QueryModelGeneratorField =
            QueryCompilerTypeInfo.GetTypeInfo().DeclaredFields
                .First(x => x.Name == "_queryModelGenerator");
        private static readonly FieldInfo NodeTypeProviderField =
            QueryModelGeneratorTypeInfo.DeclaredFields
                .Single(x => x.Name == "_nodeTypeProvider");
        private static readonly MethodInfo CreateQueryParserMethod =
            QueryModelGeneratorTypeInfo.DeclaredMethods
                .First(x => x.Name == "CreateQueryParser");
        private static readonly FieldInfo DataBaseField =
            QueryCompilerTypeInfo.DeclaredFields.Single(x => x.Name == "_database");
        private static readonly PropertyInfo DatabaseDependenciesField =
            typeof(Database).GetTypeInfo().DeclaredProperties
                .Single(x => x.Name == "Dependencies");

        public static string ToSqlQuery<TEntity>(this IQueryable<TEntity> query) where TEntity
            : class
        {
            if (!(query is EntityQueryable<TEntity>) && !(query is Microsoft.EntityFrameworkCore.Internal.InternalDbSet<TEntity>))
            {
                throw new System.ArgumentException("Invalid query");
            }
            var queryCompiler = (IQueryCompiler)QueryCompilerField.GetValue(query.Provider);
            var queryModelGenerator =
                (IQueryModelGenerator)QueryModelGeneratorField.GetValue(queryCompiler);
            var nodeTypeProvider =
                (INodeTypeProvider)NodeTypeProviderField.GetValue(queryModelGenerator);
            var parser = (IQueryParser)CreateQueryParserMethod.Invoke(
                queryModelGenerator, new object[] { nodeTypeProvider });
            var queryModel = parser.GetParsedQuery(query.Expression);
            var database = DataBaseField.GetValue(queryCompiler);
            var queryCompilationContextFactory =
                ((DatabaseDependencies)DatabaseDependenciesField
                    .GetValue(database)).QueryCompilationContextFactory;
            var queryCompilationContext = queryCompilationContextFactory.Create(false);
            var modelVisitor =
                (RelationalQueryModelVisitor)queryCompilationContext.CreateQueryModelVisitor();
            modelVisitor.CreateQueryExecutor<TEntity>(queryModel);
            return modelVisitor.Queries.First().ToString();
        }*/
    }
}
