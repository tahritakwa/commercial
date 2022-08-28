using Microsoft.Extensions.DependencyInjection;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Reflection;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class RecuperateValueFromReference : IRecuperateValueFromReference
    {
        public readonly IServiceProvider _serviceProvider;
        public RecuperateValueFromReference(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        /// <summary>
        /// Create service dynamically
        /// </summary>
        /// <param name="TEntity"></param>
        /// <param name="model"></param>
        /// <param name="ViewModel"></param>
        /// <returns></returns>
        private dynamic CreateDynamicService(string TEntity, out Type model, out Type ViewModel)
        {
            try
            {
                var interfaceName = "Application.Services.PayRoll.Interfaces.IService" + TEntity;
                var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                //Service interface
                Type type = Type.GetType(assemblyInterface);
                Type[] implementedInterfaces = type.GetInterfaces();
                //The model obtained
                model = implementedInterfaces[0].GenericTypeArguments[1];
                //The ViewModel obtained
                ViewModel = implementedInterfaces[0].GenericTypeArguments[0];
                //The Service obtained
                dynamic service = _serviceProvider.GetRequiredService(type);
                return service;
            }
            catch (Exception e)
            {
                throw new InvalidDynamicServiceException(e.ToString());
            }
        }

        /// <summary>
        /// Get the value of the expression in relation to the employee who has passed in parameter. It is the sum of each element between payslip start date and end date
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="referenceChaine"></param>
        /// <param name="month"></param>
        /// <param name="BulletinEndDate"></param>
        /// <returns></returns>
        public dynamic GetSumFormalismValue(int idEmployee, string referenceChaine, DateTime month)
        {
            string[] element = referenceChaine.Split(".");
            dynamic entityService = CreateDynamicService(element[0], out Type Model, out Type ViewModel);
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            predicate.Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "IdEmployee", Value = idEmployee, Operation = Operation.Equals } };
            var predicateType = typeof(PredicateUtility<>).MakeGenericType(Model);
            MethodInfo info = predicateType.GetMethod("PredicateFilter");
            object[] myStaticMethodArguments = { predicate, Operator.And };
            info.Invoke(null, myStaticMethodArguments);
            var vm = entityService.FindModelBy(predicate);
            if (element.Length == 2)
            {
                Double Result = 0;
                foreach (var item in vm)
                {
                    var Value = ViewModel.GetProperty(element[element.Length - 1], BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(item);
                    if (Value.GetType() == typeof(System.Double) || Value.GetType() == typeof(System.Int32))
                    {
                        Result += Value;
                    }
                    else
                    {
                        return Value;
                    }
                }
                return Result;
            }
            else
            {
                predicate.Filter.Add(new FilterViewModel { Prop = "Id" + element[0] + "TypeNavigation.Code", Value = element[1], Operation = Operation.Equals });
                double Result = 0;
                if (element[2].ToLower() == "days")
                {
                    foreach (var item in vm)
                    {
                        var StartDate = ViewModel.GetProperty("StartDate", BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(item);
                        var EndDate = ViewModel.GetProperty("EndDate", BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(item);
                        Result += DaysBetween(month, StartDate, EndDate);
                    }
                }
                return Result;
            }
        }

        /// <summary>
        /// Get the value of the expression in relation to the employee who has passed in parameter
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="ReferenceChaine"></param>
        /// <param name="month"></param>
        /// <param name="BulletinEndDate"></param>
        /// <returns></returns>
        public dynamic GetSingleFormalismValue(int idEmployee, int idContract, string ReferenceChaine)
        {
            FormalismReference formalismReference;
            string[] element = ReferenceChaine.Split(".");
            switch (element[0])
            {
                case nameof(Cnss):
                    formalismReference = new FormalismReference
                    {
                        AssociatedTable = nameof(Contract),
                        TableReference = nameof(Cnss),
                        AttributeReference = element[NumberConstant.One],
                        Value = idContract
                    };
                    return GetSingleValueAccordingToForeignEntity(formalismReference);
                case nameof(Employee):
                    formalismReference = new FormalismReference
                    {
                        TableReference = nameof(Employee),
                        AttributeReference = element[NumberConstant.One],
                        Value = idEmployee
                    };
                    return GetSingleValueToEntity(formalismReference);
                default:
                    throw new Exception();
            }
        }

        /// <summary>
        /// Get the value of entity associate with another foreign entity
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="tableReference"></param>
        /// <param name="attributeReference"></param>
        /// <returns></returns>
        private dynamic GetSingleValueAccordingToForeignEntity(FormalismReference formalismReference)
        {
            // Create contract service dynamically
            dynamic entityService = CreateDynamicService(formalismReference.AssociatedTable, out Type Model, out Type ViewModel);
            // Create predicate to filter on contract recording for filter on IdEmployee
            PredicateFormatViewModel predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = "Id", Value = formalismReference.Value, Operation = Operation.Equals }
                }
            };
            var predicateType = typeof(PredicateUtility<>).MakeGenericType(Model);
            MethodInfo info = predicateType.GetMethod("PredicateFilter");
            object[] myStaticMethodArguments = { predicate, Operator.And };
            info.Invoke(null, myStaticMethodArguments);
            // Get the contract of the employee in parameter
            var vm = entityService.FindSingleModelBy(predicate);
            // Get the foreign key IdCnns value
            double Id = ViewModel.GetProperty(nameof(Contract.IdCnss), BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(vm);
            // Reset predicate to add new Filter on reference table for get the Cnss with Id equal IdCnss
            predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = Id, Operation = Operation.Equals } }
            };
            // Cretae reference entity service dynamicaly
            entityService = CreateDynamicService(formalismReference.TableReference, out Type referenceModel, out Type referenceViewModel);
            predicateType = typeof(PredicateUtility<>).MakeGenericType(referenceModel);
            info = predicateType.GetMethod("PredicateFilter");
            object[] cnssStaticMethodArguments = { predicate, Operator.And };
            info.Invoke(null, cnssStaticMethodArguments);
            // Get the cnss with id equal to IdCnss
            vm = entityService.FindSingleModelBy(predicate);
            // Get the resut of salaryrate
            var result = referenceViewModel.GetProperty(formalismReference.AttributeReference, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(vm);
            return result;
        }

        /// <summary>
        /// Get the value of entity attribute
        /// </summary>
        /// <param name="formalismReference"></param>
        /// <returns></returns>
        private dynamic GetSingleValueToEntity(FormalismReference formalismReference)
        {
            dynamic entityService = CreateDynamicService(formalismReference.TableReference, out Type Model, out Type ViewModel);
            PredicateFormatViewModel predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = formalismReference.Value, Operation = Operation.Equals } }
            };
            var predicateType = typeof(PredicateUtility<>).MakeGenericType(Model);
            MethodInfo info = predicateType.GetMethod("PredicateFilter");
            object[] myStaticMethodArguments = { predicate, Operator.And };
            info.Invoke(null, myStaticMethodArguments);
            var vm = entityService.FindSingleModelBy(predicate);
            var result = ViewModel.GetProperty(formalismReference.AttributeReference, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).GetValue(vm);
            return result;
        }

        /// <summary>
        /// Return number of days between payslip start date and end date
        /// </summary>
        /// <param name="BulletinStartDate"></param>
        /// <param name="BulletinEndDate"></param>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        private static double DaysBetween(DateTime month, DateTime StartDate, DateTime EndDate)
        {
            DateTime BulletinStartDate = month;
            DateTime BulletinEndDate = month.LastDateOfMonth();
            if (StartDate <= BulletinStartDate && EndDate >= BulletinStartDate && EndDate <= BulletinEndDate) { return (EndDate - BulletinStartDate).TotalDays; }
            else if (StartDate <= BulletinStartDate && EndDate >= BulletinEndDate) { return (BulletinEndDate - BulletinStartDate).TotalDays; }
            else if (StartDate >= BulletinStartDate && StartDate <= BulletinEndDate && EndDate >= BulletinEndDate) { return (BulletinEndDate - StartDate).TotalDays; }
            else if (StartDate >= BulletinStartDate && EndDate <= BulletinEndDate) { return (EndDate - StartDate).TotalDays; }
            return 0.0;
        }
    }
}
