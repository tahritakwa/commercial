using Microsoft.AspNetCore.SignalR;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Classes.ServiceLeave
{
    public class ServiceLeaveBalanceRemaining : Service<LeaveBalanceRemainingViewModel, LeaveBalanceRemaining>, IServiceLeaveBalanceRemaining
    {
        private readonly IServiceLeave _serviceLeave;
        private readonly IServicePeriod _servicePeriod;
        internal readonly IRepository<Employee> _entityEmployee;
        internal readonly IRepository<LeaveType> _entityLeaveType;
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IHubContext<LeaveBalanceRemainingProgressHub> _progressHubContext;

        public ServiceLeaveBalanceRemaining(IRepository<LeaveBalanceRemaining> entityRepo,
            IUnitOfWork unitOfWork,
          ILeaveBalanceRemainingBuilder leaveBalanceRemainingBuilder,
           IRepository<Employee> entityEmployee,
           IRepository<LeaveType> entityLeaveType,
          IEmployeeBuilder employeeBuilder,
          IServiceLeave serviceLeave,
          IServicePeriod servicePeriod,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IHubContext<LeaveBalanceRemainingProgressHub> progressHubContext)
           : base(entityRepo, unitOfWork, leaveBalanceRemainingBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _employeeBuilder = employeeBuilder;
            _entityEmployee = entityEmployee;
            _entityLeaveType = entityLeaveType;
            _serviceLeave = serviceLeave;
            _servicePeriod = servicePeriod;
            _progressHubContext = progressHubContext;
        }
        /// <summary>
        /// Save annual type leave balance remaining each employee 
        /// </summary>
        /// <param name="connectionString"></param>
        public void CalculateAllLeaveBalance(string connectionString = null, LeaveBalanceRemainingFilter leaveBalanceRemainingFilter = null, int leavePeriod = 0)
        {
            try
            {
                if (!string.IsNullOrEmpty(connectionString))
                {
                    BeginTransaction(connectionString);
                }
                DateTime today = DateTime.Today;
                Expression<Func<LeaveBalanceRemaining, bool>> getCondition = x => true;
                Expression<Func<LeaveType, bool>> conditions = x => true;
                if (leaveBalanceRemainingFilter.EmployeesId.Any())
                {
                    getCondition = getCondition.And(x => leaveBalanceRemainingFilter.EmployeesId.Contains(x.IdEmployee));
                }
                if (leaveBalanceRemainingFilter.LeaveTypeId != default)
                {
                    conditions = conditions.And(x => leaveBalanceRemainingFilter.LeaveTypeId == x.Id);
                    getCondition = getCondition.And(x => leaveBalanceRemainingFilter.LeaveTypeId == x.IdLeaveType);
                }
                if (leavePeriod != default)
                {
                    conditions = conditions.And(x => x.Period == leavePeriod);
                }
                IList<LeaveBalanceRemainingViewModel> leaveBalanceRemainingViewModels = FindModelsByNoTracked(getCondition);
                // Get employeListAccording to filter or all if no specified employee
                List<Employee> employeesList = _entityEmployee.GetAllWithConditionsQueryable(x =>
                    !leaveBalanceRemainingFilter.EmployeesId.Any() || leaveBalanceRemainingFilter.EmployeesId.Contains(x.Id)).ToList();
                // Get leaveTypeListAccording to filter or all if no specified leave type
                List<LeaveType> leaveTypeList = _entityLeaveType.GetAllWithConditionsQueryable(conditions).ToList();
                // Retrieve the period of the day for the subtraction operations
                PeriodViewModel periodViewModel = _servicePeriod.GetPeriodOfDate(today);
                double dayHourInDecimal = _servicePeriod.CalculateHourNumber(periodViewModel.Hours);
                foreach (var leaveBalance in GetAllLeaveBalances(employeesList, leaveTypeList, leaveBalanceRemainingViewModels, dayHourInDecimal, today))
                {
                    if(leaveBalance.Result.Id != NumberConstant.Zero)
                    {
                        
                        UpdateModelWithoutTransaction(leaveBalance.Result, null, null);
                    }
                    else
                    {
                        AddModelWithoutTransaction(leaveBalance.Result, null, null);
                    }
                    
                    LeaveBalanceRemainingProgressHub.SendProgress(employeesList.Count, _progressHubContext);
                }
                LeaveBalanceRemainingProgressHub.ClearProgress(_progressHubContext);;
                if (!string.IsNullOrEmpty(connectionString))
                {
                    EndTransaction();
                }
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }
        }
        /// <summary>
        /// get leave balance
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="leaveTypeList"></param>
        /// <param name="leaveBalanceRemainingViewModels"></param>
        /// <param name="dayHourInDecimal"></param>
        /// <param name="today"></param>
        /// <returns></returns>
        public LeaveBalanceRemainingViewModel GetLeaveBalance(Employee employee, List<LeaveType> leaveTypeList, IList<LeaveBalanceRemainingViewModel> leaveBalanceRemainingViewModels, double dayHourInDecimal, DateTime today)
        {
            DayHour cumulativeHoursTaken = new DayHour();
            DayHour remainingBalanceDay = new DayHour();
            DayHour cumulativeAcquired = new DayHour();
            LeaveBalanceRemainingViewModel leaveBalanceRemainingViewModel = new LeaveBalanceRemainingViewModel(); ;
            // Simulate a validated leave in order to call the balance calculation methods
            // Validated leave because this status does not take into account the current leave.
            LeaveViewModel leaveViewModel = new LeaveViewModel
            {
                IdEmployee = employee.Id,
                StartDate = today,
                StartTime = new TimeSpan(),
                EndDate = today,
                EndTime = new TimeSpan(),
                Status = (int)AdministrativeDocumentStatusEnumerator.Accepted
            };
            leaveTypeList.ForEach(leaveTypeViewModel =>
            {
                leaveBalanceRemainingViewModel = new LeaveBalanceRemainingViewModel();
                leaveViewModel.IdLeaveType = leaveTypeViewModel.Id;
                _serviceLeave.CalculateNumberOfDaysAndHourOfLeaveBalance(leaveViewModel);
                LeaveBalanceRemainingViewModel model = leaveBalanceRemainingViewModels.FirstOrDefault(x => x.IdEmployee == employee.Id && x.IdLeaveType == leaveTypeViewModel.Id);
                // The total balance taken is equal to the total balance acquired minus the total remaining balance
                DayHour cumulativeTaken = new DayHour(leaveViewModel.TotalLeaveBalanceAcquired);
                cumulativeTaken.Substract(leaveViewModel.CurrentBalance, dayHourInDecimal);
                if (model != null)
                {
                    model.CumulativeAcquired = leaveViewModel.TotalLeaveBalanceAcquired;
                    model.RemainingBalance = leaveViewModel.CurrentBalance;
                    model.CumulativeTaken = cumulativeTaken;
                    leaveBalanceRemainingViewModel = model;
                }
                else
                {
                    leaveBalanceRemainingViewModel.RemainingBalance = leaveViewModel.CurrentBalance;
                    leaveBalanceRemainingViewModel.CumulativeAcquired = leaveViewModel.TotalLeaveBalanceAcquired;
                    leaveBalanceRemainingViewModel.CumulativeTaken = cumulativeTaken;
                    leaveBalanceRemainingViewModel.IdLeaveType = leaveTypeViewModel.Id;
                    leaveBalanceRemainingViewModel.IdEmployee = employee.Id;
                }
            });
            return leaveBalanceRemainingViewModel;
        }

        /// <summary>
        /// get all leave balances
        /// </summary>
        /// <param name="employeesList"></param>
        /// <param name="leaveTypeList"></param>
        /// <param name="leaveBalanceRemainingViewModels"></param>
        /// <param name="dayHourInDecimal"></param>
        /// <param name="today"></param>
        /// <returns></returns>
        public IEnumerable<Task<LeaveBalanceRemainingViewModel>> GetAllLeaveBalances(List<Employee> employeesList, List<LeaveType> leaveTypeList, IList<LeaveBalanceRemainingViewModel> leaveBalanceRemainingViewModels, double dayHourInDecimal, DateTime today)
        {
            foreach (Employee employee in employeesList)
            {
                Task<LeaveBalanceRemainingViewModel> returnedTaskTResult = Task.Run(() => GetLeaveBalance(employee, leaveTypeList, leaveBalanceRemainingViewModels, dayHourInDecimal, today));
                returnedTaskTResult.Wait();
                yield return returnedTaskTResult;
            }
        }
        /// <summary>
        /// Get the negatif leave balance remaining list
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public DataSourceResult<LeaveBalanceRemainingViewModel> GetLeaveBalanceRemainingList(PredicateFormatViewModel predicateModel, string userMail)
        {
            PredicateFilterRelationViewModel<LeaveBalanceRemaining> predicateFilterRelationModel = PreparePredicate(predicateModel);
            if (!predicateModel.Filter.Any())
            {
                predicateModel.Filter = new List<FilterViewModel>();
            }
            Expression<Func<LeaveBalanceRemaining, bool>> expression = x => x.RemainingBalanceDay < NumberConstant.Zero;
            // Combining two expressions
            ParameterExpression param = Expression.Parameter(typeof(LeaveBalanceRemaining), "x");
            BinaryExpression body = Expression.AndAlso(Expression.Invoke(predicateFilterRelationModel.PredicateWhere, param),
                Expression.Invoke(expression, param));
            predicateFilterRelationModel.PredicateWhere = Expression.Lambda<Func<LeaveBalanceRemaining, bool>>(body, param);
            return GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }

        public IList<LeaveBalanceRemainingViewModel> GetDataLeaveBalanceRemainingByIdEmployee(int idEmployee)
        {
            List<LeaveBalanceRemainingViewModel> leaveBalanceRemainingsListByIdEmpoyee = FindModelBy(x => x.IdEmployee == idEmployee).ToList();
            return leaveBalanceRemainingsListByIdEmpoyee;
        }

        public DataSourceResult<LeaveBalanceRemainingLine> GetLeaveBalanceRemaining(LeaveBalanceRemainingFilter leaveBalanceRemainingFilter)
        {
            List<LeaveBalanceRemainingLine> leaveBalanceRemaining = new List<LeaveBalanceRemainingLine>();
            // Total of returned list
            var total = 0;
            IList<Employee> EmployeeQueryable = _entityEmployee.QuerableGetAll()
                .Where(x =>
             (!leaveBalanceRemainingFilter.EmployeesId.Any())
             || (leaveBalanceRemainingFilter.EmployeesId.Contains(x.Id))).ToList();
            total = EmployeeQueryable.Count;
            var listEmployee = EmployeeQueryable.Skip((leaveBalanceRemainingFilter.Page - 1) * leaveBalanceRemainingFilter.PageSize)
                                   .Take(leaveBalanceRemainingFilter.PageSize)
                                   .Select(x => _employeeBuilder.BuildEntity(x))
                                   .ToList();
            Expression<Func<LeaveBalanceRemaining, bool>> conditions = x => listEmployee.Select(e=>e.Id).Contains(x.IdEmployee);
            conditions = leaveBalanceRemainingFilter.LeaveTypeId != default ?
                conditions.And(x => leaveBalanceRemainingFilter.LeaveTypeId == x.IdLeaveType) :
                conditions.And(x => x.IdLeaveType != default);
            IList <LeaveBalanceRemainingViewModel> leaveBalanceRemainingViewModels = GetAllModelsQueryable(conditions).ToList();
            List<LeaveType> leaveTypeList = new List<LeaveType>();
            if (leaveBalanceRemainingFilter.LeaveTypeId == default)
            {
                leaveTypeList = _entityLeaveType.GetAllAsNoTracking().ToList();
            }
            foreach (EmployeeViewModel employee in listEmployee)
            {
                List<LeaveBalanceRemainingViewModel> employeeLeaveBalances = leaveBalanceRemainingViewModels.Where(x => x.IdEmployee == employee.Id).OrderBy(x => x.IdLeaveType).ToList();
                if (!employeeLeaveBalances.Any())
                {
                    leaveTypeList.ForEach(leaveType =>
                    {
                        employeeLeaveBalances.Add(new LeaveBalanceRemainingViewModel
                        {
                            IdEmployee = employee.Id,
                            IdLeaveType = leaveType.Id,
                            CumulativeTaken = new DayHour(),
                            RemainingBalance = new DayHour(),
                            CumulativeAcquired = new DayHour()
                        });
                    });
                }
                leaveBalanceRemaining.Add(new LeaveBalanceRemainingLine
                {
                    Employee = employee,
                    leaveBalanceRemainingList = employeeLeaveBalances
                });
            }
            return new DataSourceResult<LeaveBalanceRemainingLine> { data = leaveBalanceRemaining, total = total };

        }
    }
}
