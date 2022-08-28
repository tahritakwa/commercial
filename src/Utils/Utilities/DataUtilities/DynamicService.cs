using Microsoft.Extensions.DependencyInjection;
using System;
using System.Reflection;

namespace Utils.Utilities.DataUtilities
{
    public class DynamicService
    {
        public readonly IServiceProvider _serviceProvider;
        public DynamicService(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }
        /// <summary>
        /// Create a dynamic service with entity and module name
        /// </summary>
        /// <param name="moduleName"></param>
        /// <param name="entityName"></param>
        /// <returns></returns>
        public dynamic CreateDynamicService(string moduleName, string entityName)
        {
            try
            {
                var interfaceName = "Application.Services." + moduleName + ".Interfaces.IService" + entityName;
                var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                Type type = Type.GetType(assemblyInterface);
                if (type == null)
                {
                    interfaceName = "Application.Services.Administration.Interfaces.IService" + entityName;
                    assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                    type = Type.GetType(assemblyInterface);                   
                }
                dynamic service = _serviceProvider.GetRequiredService(type);
                return service;
            }
            catch (Exception e)
            {
                throw ;
            }
        }
    }
}

