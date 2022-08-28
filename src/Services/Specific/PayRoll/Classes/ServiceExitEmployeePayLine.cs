using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExitEmployeePayLine : Service<ExitEmployeePayLineViewModel, ExitEmployeePayLine>, IServiceExitEmployeePayLine
    {
        private readonly IServiceExitEmployeePayLineSalaryRule _serviceLinesSalaryRule;
        private readonly IServiceExitEmployee _serviceEmployeeExit;
        private readonly IServiceSalaryRule _serviceSalaryRule;
        private readonly IRepository<Employee> _entityEmployee;
        private readonly IRepository<Payslip> _entityPayslip;

        public ServiceExitEmployeePayLine(IRepository<ExitEmployeePayLine> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IServiceExitEmployeePayLineSalaryRule serviceLinesSalaryRule,
           IServiceExitEmployee serviceEmployeeExit,
           IServiceSalaryRule serviceSalaryRule,
           IRepository<Employee> entityEmployee,
           IRepository<Payslip> entityPayslip,
           IUnitOfWork unitOfWork, IExitEmployeePayLineBuilder builder,
           IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceLinesSalaryRule = serviceLinesSalaryRule;
            _serviceEmployeeExit = serviceEmployeeExit;
            _serviceSalaryRule = serviceSalaryRule;
            _entityEmployee = entityEmployee;
            _entityPayslip = entityPayslip;
        }


        /// <summary>
        /// create lines pay for exit employee during the whole period of his work
        /// </summary>
        /// <param name="employeeExit"></param>
        public void GeneratePayBalanceForExitEmployee(int idEmployeeExit)
        {
            ExitEmployeeViewModel employeeExit = _serviceEmployeeExit.GetModelAsNoTracked(x => x.Id == idEmployeeExit);
            if (!employeeExit.ExitPhysicalDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.EmployeeExithasNoExitPhysicalDate);
            }
            Employee employee = _entityEmployee.GetSingleWithRelationsNotTracked(x => x.Id == employeeExit.IdEmployee, x => x.Contract);
            if (employee is null || !employee.Contract.Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyContract);
            }
            if (!_entityPayslip.FindByAsNoTracking(x => x.Month.BetweenDateLimitIncluded(employee.HiringDate.FirstDateOfMonth(), employeeExit.ExitPhysicalDate.Value)).Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyPayslip);
            }
            // Remove existing paylines fo this employeeExit
            var exitEmployeePayLinesToRemove = _entityRepo.FindByAsNoTracking(x => x.IdExitEmployee == idEmployeeExit);
            if (exitEmployeePayLinesToRemove.Any())
            {
                _entityRepo.RemoveRange(exitEmployeePayLinesToRemove.ToArray());
                // commit
                _unitOfWork.Commit();
            }
            DateTime startDate = employee.HiringDate;
            IList<ExitEmployeePayLineViewModel> exitEmployeePayLines = new List<ExitEmployeePayLineViewModel>();
            while (startDate.BeforeDateLimitIncluded(employeeExit.ExitPhysicalDate.Value))
            {
                Contract currentContract = employee.Contract.FirstOrDefault(x => x.EndDate.HasValue && startDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value) ||
                                     !x.EndDate.HasValue && x.StartDate.BeforeDateLimitIncluded(startDate));
                if (currentContract != null)
                {
                    ExitEmployeePayLineViewModel exitEmployeePayLineViewModel = new ExitEmployeePayLineViewModel
                    {
                        IdExitEmployee = employeeExit.Id,
                        Month = startDate,
                        State = (int)PayLineStateEnumerator.NotValidated,
                        ExitEmployeePayLineSalaryRule = new List<ExitEmployeePayLineSalaryRuleViewModel>()
                    };
                    _serviceLinesSalaryRule.GetResumeForExitEmployee(exitEmployeePayLineViewModel, currentContract, startDate);
                    exitEmployeePayLines.Add(exitEmployeePayLineViewModel);
                }
                startDate = startDate.AddMonths(NumberConstant.One);
            }
            BulkAddWithoutTransaction(exitEmployeePayLines);
            employeeExit.StatePay = (int)ExitEmployeeStatePayEnumerator.Calculate;
            _serviceEmployeeExit.UpdateModelWithoutTransaction(employeeExit, null, null);
        }

        /// <summary>
        /// Get List of pay for exit employee
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public DataSourceResult<ExitEmployeePayLineViewModel> GetListOfPayForExitEmployee(PredicateFormatViewModel predicate, int idEmployeeExit)
        {
            List<ExitEmployeePayLineViewModel> listOfLinesSalaryRules = new List<ExitEmployeePayLineViewModel>();
            List<ExitEmployeePayLineViewModel> listOfValidLinesSalaryRules = new List<ExitEmployeePayLineViewModel>();
            PredicateFilterRelationViewModel<ExitEmployeePayLine> predicateFilterRelationModel = PreparePredicate(predicate);
            IList<ExitEmployeePayLineViewModel> listOfExitEmployeePay = _entityRepo.GetAllAsNoTracking()
                                              .Include(x => x.IdExitEmployeeNavigation)
                                              .OrderByRelation(predicate.OrderBy)
                                              .Where(predicateFilterRelationModel.PredicateWhere)
                                              .ToList().Select(x => _builder.BuildEntity(x)).ToList();
            if (listOfExitEmployeePay.Any())
            {
                foreach (var exitEmployeePayLine in listOfExitEmployeePay)
                {
                    ExitEmployeePayLineViewModel linesSalaryRules = PrepareLineSalaryRlueViewModel(exitEmployeePayLine);
                    listOfLinesSalaryRules.Add(linesSalaryRules);
                    if (exitEmployeePayLine.State == (int)PayLineStateEnumerator.Valid)
                    {
                        listOfValidLinesSalaryRules.Add(exitEmployeePayLine);
                    }
                }
                UpdateStatePayOfEmployeeExit(listOfValidLinesSalaryRules, listOfLinesSalaryRules, idEmployeeExit);
            }
            var total = listOfLinesSalaryRules.Count;
            var data = listOfLinesSalaryRules.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize).ToList();
            return new DataSourceResult<ExitEmployeePayLineViewModel> { data = data, total = total };
        }


        /// <summary>
        /// prepare LineSalaryRlueViewModel for every month to display it
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ExitEmployeePayLineViewModel PrepareLineSalaryRlueViewModel(ExitEmployeePayLineViewModel model)
        {
            ExitEmployeePayLineViewModel lineExitEmployeePayLine = new ExitEmployeePayLineViewModel
            {
                Id = model.Id,
                IdExitEmployee = model.IdExitEmployee,
                Month = model.Month,
                Details = model.Details,
                State = model.State,
                RuleListAndValues = new Dictionary<string, double>()
            };
            IList<ExitEmployeePayLineSalaryRuleViewModel> listOfLineSalaryRules = _serviceLinesSalaryRule.GetModelsWithConditionsRelations(x => x.IdExitEmployeePayLine == model.Id, x => x.IdExitEmployeePayLineNavigation).ToList();
            List<SalaryRuleViewModel> salaryRules = _serviceSalaryRule.FindModelsByNoTracked(x => listOfLineSalaryRules.Any(y => y.IdSalaryRule == x.Id), x => x.IdRuleUniqueReferenceNavigation)
                .OrderBy(x => x.Applicability).ThenBy(x => x.Order).ToList();
            salaryRules.ForEach(salaryRule =>
            {
                lineExitEmployeePayLine.RuleListAndValues[salaryRule.IdRuleUniqueReferenceNavigation.Reference] = listOfLineSalaryRules.FirstOrDefault(x => x.IdSalaryRule == salaryRule.Id).Value;
            });
            return lineExitEmployeePayLine;
        }

        /// <summary>
        /// update statePay of employee exit (valid or PartiallyValidated)
        /// </summary>
        /// <param name="listOfValidLinesSalaryRules"></param>
        /// <param name="totalList"></param>
        /// <param name="idEmployeeExit"></param>
        public void UpdateStatePayOfEmployeeExit(List<ExitEmployeePayLineViewModel> listOfValidLinesSalaryRules, List<ExitEmployeePayLineViewModel> totalList, int idEmployeeExit)
        {
            ExitEmployeeViewModel employeeExit = _serviceEmployeeExit.GetModelAsNoTracked(x => x.Id == idEmployeeExit);
            if (listOfValidLinesSalaryRules.Count == totalList.Count)
            {
                employeeExit.StatePay = (int)ExitEmployeeStatePayEnumerator.Valid;
                _serviceEmployeeExit.UpdateModelWithoutTransaction(employeeExit, null, null);
            }
            else if (listOfValidLinesSalaryRules.Count == NumberConstant.Zero)
            {
                employeeExit.StatePay = (int)ExitEmployeeStatePayEnumerator.Calculate;
                _serviceEmployeeExit.UpdateModelWithoutTransaction(employeeExit, null, null);
            }
            else
            {
                employeeExit.StatePay = (int)ExitEmployeeStatePayEnumerator.PartiallyValidated;
                _serviceEmployeeExit.UpdateModelWithoutTransaction(employeeExit, null, null);
            }
        }
    }
}
