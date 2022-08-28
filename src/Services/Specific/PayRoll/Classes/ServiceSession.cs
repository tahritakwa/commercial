using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSession : Service<SessionViewModel, Session>, IServiceSession
    {
        private readonly IRepository<PayslipDetails> _entityRepoPayslipDetails;
        private readonly IServiceAttendance _serviceAttendance;
        private readonly IServiceSessionContract _serviceSessionContract;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceContract _serviceContract;
        private readonly IServiceSessionBonus _serviceSessionBonus;
        private readonly IServicePayslip _servicePayslip;
        private readonly IServiceSalaryRule _serviceSalaryRule;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly IServicePeriod _servicePeriod;
        private readonly ISessionBonusBuilder _sessionBonusBuilder;
        private readonly IServiceTimeSheet _serviceTimesheet;
        private readonly IServiceSessionLoanInstallment _serviceSessionLoanInstallment;
        private readonly IRepository<LoanInstallment> _entityRepoLoanInstallment;
        private readonly ISessionLoanInstallmentBuilder _sessionLoanInstallmentBuilder;
        private readonly IRepository<Bonus> _repoBonus;
        private readonly IRepository<SessionContract> _entityRepoSessionContract;
        private readonly IRepository<TimeSheet> _entityRepoTimeSheet;
        private readonly IRepository<SessionBonus> _entityRepoSessionBonus;
        private readonly IRepository<SessionLoanInstallment> _entityRepoSessionLoanInstallment;
        private readonly IRepository<Payslip> _entityRepoPayslip;
        private readonly IRepository<Contract> _entityRepoContract;
        private readonly IRepository<Attendance> _entityRepoAttendance;
        private readonly IServiceLoanInstallment _serviceLoanInstallment;

        public ServiceSession(IRepository<Session> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            ISessionBuilder builder, IServiceTimeSheet serviceTimesheet,
            IServicePeriod servicePeriod, IServiceContract serviceContract, IServicePayslip servicePayslip,
            IServiceSalaryRule serviceSalaryRule, IServiceRuleUniqueReference serviceRuleUniqueReference,
            IServiceSessionBonus serviceSessionBonus, IServiceAttendance serviceAttendance, IServiceEmployee serviceEmployee,
            IRepository<PayslipDetails> entityRepoPayslipDetails,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            ISessionBonusBuilder sessionBonusBuilder,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache, IServiceSessionContract serviceSessionContract,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification, IServiceSessionLoanInstallment serviceSessionLoanInstallment, IRepository<LoanInstallment> entityRepoLoanInstallment,
            ISessionLoanInstallmentBuilder sessionLoanInstallmentBuilder, IRepository<Bonus> repoBonus, IRepository<SessionContract> entityRepoSessionContract, IRepository<TimeSheet> entityRepoTimeSheet,
            IRepository<SessionBonus> entityRepoSessionBonus, IRepository<SessionLoanInstallment> entityRepoSessionLoanInstallment, IRepository<Payslip> entityRepoPayslip, IRepository<Contract> entityRepoContract,
             IRepository<Attendance> entityRepoAttendance, IServiceLoanInstallment serviceLoanInstallment)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                   entityRepoEntity, entityRepoEntityCodification, entityRepoCodification, companyBuilder, memoryCache
                    )
        {
            _entityRepoPayslipDetails = entityRepoPayslipDetails;
            _serviceContract = serviceContract;
            _servicePayslip = servicePayslip;
            _serviceAttendance = serviceAttendance;
            _serviceSessionBonus = serviceSessionBonus;
            _servicePeriod = servicePeriod;
            _serviceEmployee = serviceEmployee;
            _serviceSalaryRule = serviceSalaryRule;
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _sessionBonusBuilder = sessionBonusBuilder;
            _serviceTimesheet = serviceTimesheet;
            _serviceSessionContract = serviceSessionContract;
            _serviceSessionLoanInstallment = serviceSessionLoanInstallment;
            _entityRepoLoanInstallment = entityRepoLoanInstallment;
            _sessionLoanInstallmentBuilder = sessionLoanInstallmentBuilder;
            _entityRepoSessionContract = entityRepoSessionContract;
            _repoBonus = repoBonus;
            _entityRepoTimeSheet = entityRepoTimeSheet;
            _entityRepoSessionBonus = entityRepoSessionBonus;
            _entityRepoSessionLoanInstallment = entityRepoSessionLoanInstallment;
            _entityRepoPayslip = entityRepoPayslip;
            _entityRepoContract = entityRepoContract;
            _entityRepoAttendance = entityRepoAttendance;
            _serviceLoanInstallment = serviceLoanInstallment;

        }

        public override object AddModelWithoutTransaction(SessionViewModel sessionViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (sessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            if (CheckUnicityPerMonth(sessionViewModel))
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SESSION_NUMBER_NOT_UNIQUE);
            }
            // Initiate the creation date of the session to the current date
            sessionViewModel.CreationDate = DateTime.Now;
            // Force the day of the month of the session to first day of month. Actually we only need the month and the year
            sessionViewModel.Month = sessionViewModel.Month.FirstDateOfMonth();
            // Make the state of session to Attendance
            sessionViewModel.State = (int)SessionStateViewModel.New;
            CompanyViewModel companyViewModel = GetCurrentCompany();
            // Mark if the session depends on the CRA or not when generating the Payroll session
            sessionViewModel.DependOnTimesheet = companyViewModel.PayDependOnTimesheet;
            // Set the days of week worked for the session
            sessionViewModel.DaysOfWeekWorked = companyViewModel.DaysOfWeekWorked;
            // Mark the number of working days configured when generating the Payroll session
            sessionViewModel.DaysOfWork = _servicePeriod.NumberOfDaysWorkedByCompanyInMonth(sessionViewModel.Month);
            // Save the session credentials data in database
            object Result = base.AddModelWithoutTransaction(sessionViewModel, null, userMail, property);
            return Result;
        }

        /// <summary>
        /// Avoid delete of session closed
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            SessionViewModel sessionViewModel = GetModelWithRelationsAsNoTracked(m => m.Id == id, m => m.SessionLoanInstallment, m => m.Payslip);
            if(sessionViewModel == null)
            {
                throw new CustomException(CustomStatusCode.AlreadyDeletedEntity);
            }
            if (sessionViewModel.State == (int)SessionStateViewModel.Closed)
                throw new CustomException(CustomStatusCode.CANNOT_DELETE_CLOSED_SESSION);
            if (sessionViewModel.Payslip != null && sessionViewModel.Payslip.Count > NumberConstant.Zero)
            {
                _servicePayslip.UpdateSourceDeductions(sessionViewModel.Payslip.ToList(), sessionViewModel.Month.Year, true);
            }
            if (sessionViewModel.SessionLoanInstallment != null && sessionViewModel.SessionLoanInstallment.Count > NumberConstant.Zero)
            {
                List<int> loanInstallmentsToUpdateIds = sessionViewModel.SessionLoanInstallment.Select(x => x.IdLoanInstallment).ToList();
                List<LoanInstallment> loanInstallmentsToUpdate = _entityRepoLoanInstallment.FindByAsNoTracking(x => loanInstallmentsToUpdateIds.Contains(x.Id)).ToList();
                List<SessionLoanInstallmentViewModel> sessionLoanInstallments = _serviceSessionLoanInstallment.FindModelsByNoTracked(x => loanInstallmentsToUpdateIds.Contains(x.IdLoanInstallment)
                   && !sessionViewModel.SessionLoanInstallment.Select(y => y.Id).Contains(x.Id)).ToList();
                loanInstallmentsToUpdate.ForEach(loanInstallment =>
                {
                    double sum = sessionViewModel.SessionLoanInstallment.Where(x => x.IdLoanInstallment == loanInstallment.Id).Sum(x => x.Value);
                    //
                    if (sum.IsApproximately(loanInstallment.Amount) || sessionLoanInstallments.Count == NumberConstant.Zero)
                    {
                        loanInstallment.State = (int)LoanInstallmentEnumerator.Unpaid;
                    }
                    else
                    {
                        loanInstallment.State = (int)LoanInstallmentEnumerator.PartiallyPaid;
                    }
                });
                _entityRepoLoanInstallment.BulkUpdate(loanInstallmentsToUpdate);
            }
            return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        /// <summary>
        /// Closes the payroll session
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void CloseSession(SessionViewModel model)
        {
            Session session = _entityRepo.GetSingleNotTracked(x => x.Id == model.Id);
            if(session == null)
            {
                throw new CustomException(CustomStatusCode.CanNotCLoseDeletedSession);
            }
            model.State = (int)SessionStateViewModel.Closed;
            model.Attendance.Clear();
            model.SessionBonus.Clear();
            model.SessionContract.Clear();
            model.Payslip.Clear();
            // Can't close session in the future
            if (model.Month.FirstDateOfMonth().AfterDate(DateTime.Today.FirstDateOfMonth()))
            {
                throw new CustomException(CustomStatusCode.CanNotCLoseSessionInFuture);
            }
            IList<PayslipViewModel> payslips = _servicePayslip.FindModelsByNoTracked(x => x.IdSession == model.Id);
            if (!payslips.Any())
            {
                throw new CustomException(CustomStatusCode.CanNotCloseSessionWithoutPayslip);
            }
            if (payslips.Any(x => x.Status != (int)PayslipStatus.Correct))
            {
                throw new CustomException(CustomStatusCode.CanNotCloseSessionWithWrongOrNotCalculatedPayslip);
            }
            UpdateModelWithoutTransaction(model, null, null);
        }

        /// <summary>
        /// Get session details
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns>SessionViewModel</returns>
        public SessionViewModel GetSessionDetails(int IdSession)
        {
            SessionViewModel sessionViewModel = GetModelAsNoTracked(x => x.Id == IdSession);
            if (sessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            // Get sessionEmployee 
            sessionViewModel.SessionContract = _serviceSessionContract.GetModelsWithConditionsRelations(x => x.IdSession == IdSession, x => x.IdContractNavigation).ToList();
            // Get Attendance
            sessionViewModel.Attendance = _serviceAttendance.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                 x => x.IdContractNavigation.IdEmployeeNavigation, x => x.IdContractNavigation.IdSalaryStructureNavigation,
                 x => x.IdContractNavigation.IdContractTypeNavigation).ToList();
            // Get sessionBonus
            sessionViewModel.SessionBonus = _serviceSessionBonus.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                x => x.IdBonusNavigation).ToList();

            // Get sessionLoanInstallment
            sessionViewModel.SessionLoanInstallment = _serviceSessionLoanInstallment.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                x => x.IdContractNavigation).ToList();
            // Get payslip
            sessionViewModel.Payslip = _servicePayslip.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                x => x.IdContractNavigation.IdSalaryStructureNavigation).ToList();
            return sessionViewModel;
        }


        /// <summary>
        /// Return session bonus data grouped by IdBonus
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public dynamic GetSessionBonusByIdBonus(int IdSession)
        {
            IDictionary<int, List<SessionBonusViewModel>> bonusByIdSession = new Dictionary<int, List<SessionBonusViewModel>>();
            IList<SessionBonusViewModel> sessionBonusViewModels = _serviceSessionBonus.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                x => x.IdContractNavigation,
                x => x.IdContractNavigation.IdContractTypeNavigation,
                x => x.IdBonusNavigation,
                x => x.IdContractNavigation.IdSalaryStructureNavigation).ToList();
            foreach (SessionBonusViewModel sessionBonus in sessionBonusViewModels)
            {
                PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel
                {
                    Filter = new List<FilterViewModel>
                    {
                        new FilterViewModel
                        {
                            Prop = "Id",
                            Value = sessionBonus.IdContractNavigation.IdEmployee,
                            Operation = Operation.Equals
                        }
                    }
                };
                sessionBonus.IdContractNavigation.IdEmployeeNavigation = _serviceEmployee.FindSingleModelBy(predicateFormatViewModel);
                if (!bonusByIdSession.ContainsKey(sessionBonus.IdBonus))
                {
                    bonusByIdSession[sessionBonus.IdBonus] = new List<SessionBonusViewModel>();
                }
                bonusByIdSession[sessionBonus.IdBonus].Add(sessionBonus);
            }
            return bonusByIdSession;
        }

        /// <summary>
        /// Check if for any employee, number of days worked by month is lower or equal than company number of days worked for this month
        /// </summary>
        /// <param name="sessionViewModel"></param>
        private void CheckAttendanceValueNotExceed(SessionViewModel sessionViewModel)
        {
            sessionViewModel.SessionContract.ToList().ForEach(sessionContractViewModel =>
            {
                double nb = NumberConstant.Zero;
                nb = sessionViewModel.Attendance.Where(model => model.IdContractNavigation.IdEmployee == sessionContractViewModel.IdContractNavigation.IdEmployee)
                    .Sum(x => x.NumberDaysWorked + x.NumberDaysPaidLeave);
                if (nb > sessionViewModel.DaysOfWork)
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), sessionViewModel.Attendance.Where(x => x.IdContractNavigation.IdEmployee == sessionContractViewModel.IdContractNavigation.IdEmployee)
                            .FirstOrDefault().IdContractNavigation.IdEmployeeNavigation.FullName }
                    };
                    throw new CustomException(CustomStatusCode.ATTENDANCE_VALUE_EXCEED, errorParams);
                }
            });
        }



        /// <summary>
        /// Get sessions of select trimester
        /// </summary>
        /// <param name="trimester"></param>
        /// <returns></returns>
        public IList<SessionViewModel> SessionOfTrimester(PredicateFormatViewModel predicate, DateTime dateTime)
        {
            PredicateFilterRelationViewModel<Session> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<Session> sessions = GetAllQueryableWithRelation(x => ((x.Month.Year.Equals(dateTime.Year) && x.Month.Month.Equals(dateTime.Month)) ||
               (x.Month.Year.Equals(dateTime.Year) && x.Month.Month.Equals(dateTime.Month + NumberConstant.One)) ||
               (x.Month.Year.Equals(dateTime.Year) && x.Month.Month.Equals(dateTime.Month + NumberConstant.Two)))
               && x.SessionContract.Any(sessionContract => !sessionContract.IdContractNavigation.IdSalaryStructureNavigation.SalaryStructureReference.Equals(PayRollConstant.Sivp))).
               Where(predicateFilterRelationModel.PredicateWhere);
            List<SessionViewModel> sessionViewModels = new List<SessionViewModel>();
            sessions.ToList().ForEach(session => sessionViewModels.Add(_builder.BuildEntity(session)));
            return sessionViewModels;
         }

        /// <summary>
        /// Return the list of salary rules applied for the pay calculation of the session concerned
        /// Are concerned the ValidityPeriod valid for the month of the session
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public IList<SalaryRuleViewModel> GetAvailableSalaryRulesForResume(int idSession)
        {
            return _serviceSalaryRule.FindModelsByNoTracked(m =>
                m.UsedinNewsPaper == true &&
                m.PayslipDetails.Any(p => p.IdPayslipNavigation.IdSession == idSession),
                m => m.IdRuleUniqueReferenceNavigation).OrderBy(x => x.Applicability).ThenBy(x => x.Order).ToList();
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionResumeFilter"></param>
        /// <returns></returns>
        public DataSourceResult<EmployeeResumeLine> GetSessionResume(SessionResumeFilter sessionResumeFilter)
        {
            List<EmployeeResumeLine> resumeLines = new List<EmployeeResumeLine>();
            // Total of returned list
            long total = default;
            // Rules to dispaly in the grid
            List<int> salaryRules = GetAvailableSalaryRulesForResume(sessionResumeFilter.IdSession).Select(x => x.Id).ToList();

            Expression<Func<Contract, bool>> filter = m => m.Payslip.Any(x => x.IdSession == sessionResumeFilter.IdSession);
            Expression<Func<Contract, bool>> containExpression = x => true;
            if (sessionResumeFilter.EmployeesId.Any())
            {
                containExpression = x => sessionResumeFilter.EmployeesId.Contains(x.IdEmployee);
            }
            // Combining two expressions
            ParameterExpression param = Expression.Parameter(typeof(Contract), "x");
            BinaryExpression body = Expression.AndAlso(Expression.Invoke(filter, param),
                Expression.Invoke(containExpression, param));
            IQueryable<ContractViewModel> contractsQuery = _serviceContract.GetAllModelsQueryable(Expression.Lambda<Func<Contract, bool>>(body, param),
                 m => m.IdEmployeeNavigation,
                    m => m.IdContractTypeNavigation);
            total = contractsQuery.Count();
            IList<ContractViewModel> contractViewModels = contractsQuery.Skip((sessionResumeFilter.Page - NumberConstant.One) * sessionResumeFilter.PageSize).Take(sessionResumeFilter.PageSize).ToList();
            // Get all payslips details of corresponding employee payslips
            IQueryable<PayslipDetails> payslipDetailsQuery = _entityRepoPayslipDetails.GetAllAsNoTracking()
                .Include(m => m.IdPayslipNavigation)
                .Where(m => m.IdSalaryRule.HasValue && salaryRules.Any(x => x == m.IdSalaryRule.Value) &&
                m.IdPayslipNavigation.IdSession == sessionResumeFilter.IdSession);
            // Récupérer tous les pointages mensuels des employés concernés
            IList<AttendanceViewModel> attendanceViewModels = _serviceAttendance.FindByAsNoTracking(attendance => contractViewModels.Any(contract =>
                contract.Id == attendance.IdContract && attendance.IdSession == sessionResumeFilter.IdSession)).ToList();
            // For resume total line
            EmployeeResumeLine totalLine = new EmployeeResumeLine
            {
                IdContractNavigation = null,
                IdAttendanceNavigation = null,
                RuleListAndValues = new Dictionary<int, string>()
            };
            // 
            List<PayslipDetails> payslipDetails = payslipDetailsQuery.Where(x => contractViewModels.Any(m => m.Id == x.IdPayslipNavigation.IdContract)).ToList();
            foreach (int idSalaryRule in salaryRules)
            {
                var res = payslipDetailsQuery.Where(x => x.IdSalaryRule.HasValue && x.IdSalaryRule.Value == idSalaryRule);
                double gain = res.Select(x => x.Gain).Sum();
                double deduction = res.Select(x => x.Deduction).Sum();
                double value = gain > NumberConstant.Zero ? _servicePayslip.PayrollRound(gain) : _servicePayslip.PayrollRound(deduction);
                totalLine.RuleListAndValues[idSalaryRule] = value.ToString(PayRollConstant.NumberFormat);
            }
            foreach (ContractViewModel contractViewModel in contractViewModels)
            {
                EmployeeResumeLine employeeResumeLine = new EmployeeResumeLine
                {
                    IdContractNavigation = contractViewModel,
                    IdAttendanceNavigation = attendanceViewModels.FirstOrDefault(a => a.IdContract == contractViewModel.Id)
                };
                employeeResumeLine.RuleListAndValues = new Dictionary<int, string>();
                foreach (int idSalaryRule in salaryRules)
                {
                    PayslipDetails payslipDetail = payslipDetails.FirstOrDefault(m => m.IdSalaryRule == idSalaryRule
                    && m.IdPayslipNavigation.IdContract == contractViewModel.Id);
                    double amount = payslipDetail is null ? NumberConstant.Zero :
                        payslipDetail.Gain > NumberConstant.Zero
                            ? _servicePayslip.PayrollRound(payslipDetail.Gain)
                            : _servicePayslip.PayrollRound(payslipDetail.Deduction);
                    employeeResumeLine.RuleListAndValues[idSalaryRule] = amount.ToString(PayRollConstant.NumberFormat);
                }
                resumeLines.Add(employeeResumeLine);

            }
            resumeLines.Add(totalLine);
            return new DataSourceResult<EmployeeResumeLine> { data = resumeLines, total = total };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="IdSession"></param>
        /// <returns></returns>
        public IEnumerable<SessionResumeLineViewModel> GetSessionResumeReportLines(int IdSession)
        {
            if (IdSession == NumberConstant.Zero)
            {
                throw new ArgumentException("");
            }
            IList<PayslipViewModel> payslipViewModels = _servicePayslip.GetModelsWithConditionsRelations(x => x.IdSession == IdSession,
                x => x.IdContractNavigation,
                x => x.IdContractNavigation.IdContractTypeNavigation,
                x => x.IdEmployeeNavigation,
                x => x.PayslipDetails).ToList();
            // For number format, separate per three digits
            var cultureInfo = (NumberFormatInfo)CultureInfo.InvariantCulture.NumberFormat.Clone();
            cultureInfo.NumberGroupSeparator = " ";
            // Calculate resume lines
            double baseSalarySum = default;
            double grossSalarySum = default;
            double taxableWagesSum = default;
            double netSalarySum = default;
            double cssSum = default;
            double irppSum = default;
            double socialContributionSum = default;
            // Instantiate new collection for contain resume table lines in the report
            IList<SessionResumeLineViewModel> resume = new List<SessionResumeLineViewModel>();
            IList<EmployeeViewModel> employeeViewModels = _serviceEmployee.FindByAsNoTracking(employee =>
                payslipViewModels.Any(payslip => payslip.IdEmployee.Equals(employee.Id)))
                .OrderBy(m => m.LastName).ThenBy(m => m.FirstName).ToList();

            IList<AttendanceViewModel> attendanceViewModels = _serviceAttendance.FindByAsNoTracking(attendance => payslipViewModels.Any(payslip =>
                payslip.IdContract == attendance.IdContract && payslip.IdSession == attendance.IdSession)).ToList();

            employeeViewModels.ToList().ForEach(employee =>
            {
                foreach (PayslipViewModel payslipViewModel in payslipViewModels.Where(m => m.IdEmployee.Equals(employee.Id)))
                {
                    AttendanceViewModel attendanceViewModel = attendanceViewModels.FirstOrDefault(m => m.IdContract == payslipViewModel.IdContract);
                    double baseSalary = default;
                    double grossSalary = default;
                    double taxableWages = default;
                    double netSalary = default;
                    double css = default;
                    double socialContribution = default;
                    double irpp = default;
                    SessionResumeLineViewModel sessionResumeLineViewModel = new SessionResumeLineViewModel
                    {
                        ContractType = payslipViewModel.IdContractNavigation.IdContractTypeNavigation.Code,
                        Matricule = employee.Matricule,
                        FirstName = employee.FirstName,
                        LastName = employee.LastName,
                        NumberDaysWorked = attendanceViewModel.NumberDaysWorked.ToString(),
                        NumberDaysPaidLeave = attendanceViewModel.NumberDaysPaidLeave.ToString()
                    };
                    payslipViewModel.PayslipDetails.Where(m => m.IdSalaryRule.HasValue).ToList().ForEach(payslipDetailsViewModel =>
                    {
                        string reference = _serviceRuleUniqueReference.GetReferenceByIdReference(_serviceSalaryRule.GetModelById(payslipDetailsViewModel.IdSalaryRule.Value).IdRuleUniqueReference);
                        double gain = _servicePayslip.PayrollRound(payslipDetailsViewModel.Gain);
                        double deduction = _servicePayslip.PayrollRound(payslipDetailsViewModel.Deduction);
                        if (reference.Equals(PayRollConstant.Base))
                        {
                            baseSalary = gain;
                            baseSalarySum += payslipDetailsViewModel.Gain;
                        }
                        else if (reference.Equals(PayRollConstant.Brut))
                        {
                            grossSalary = gain;
                            grossSalarySum += payslipDetailsViewModel.Gain;
                        }
                        else if (reference.Equals(PayRollConstant.Net))
                        {
                            taxableWages = gain;
                            taxableWagesSum += payslipDetailsViewModel.Gain;
                        }
                        else if (reference.Equals(PayRollConstant.Netapayer))
                        {
                            netSalary = gain;
                            netSalarySum += payslipDetailsViewModel.Gain;
                        }
                        else if (reference.Equals(PayRollConstant.Css))
                        {
                            css = deduction;
                            cssSum += payslipDetailsViewModel.Deduction;
                        }
                        else if (reference.Equals(PayRollConstant.Irpp))
                        {
                            irpp = deduction;
                            irppSum += payslipDetailsViewModel.Deduction;
                        }
                        else if (reference.Equals(PayRollConstant.Cnss))
                        {
                            socialContribution = deduction;
                            socialContributionSum += payslipDetailsViewModel.Deduction;
                        }
                    });
                    sessionResumeLineViewModel.BaseSalary = baseSalary.ToString(PayRollConstant.NumberFormat, cultureInfo);
                    sessionResumeLineViewModel.GrossSalary = grossSalary.ToString(PayRollConstant.NumberFormat, cultureInfo);
                    sessionResumeLineViewModel.NetSalary = netSalary.ToString(PayRollConstant.NumberFormat, cultureInfo);
                    sessionResumeLineViewModel.TaxableWages = taxableWages > NumberConstant.Zero ? taxableWages.ToString(PayRollConstant.NumberFormat, cultureInfo) : string.Empty;
                    sessionResumeLineViewModel.Css = css > NumberConstant.Zero ?
                        css.ToString(PayRollConstant.NumberFormat, cultureInfo) : string.Empty;
                    sessionResumeLineViewModel.Irpp = irpp > NumberConstant.Zero ?
                        irpp.ToString(PayRollConstant.NumberFormat, cultureInfo) : string.Empty;
                    sessionResumeLineViewModel.SocialContribution = socialContribution > NumberConstant.Zero ?
                        socialContribution.ToString(PayRollConstant.NumberFormat, cultureInfo) : string.Empty;
                    resume.Add(sessionResumeLineViewModel);
                }
            });
            resume.Add(new SessionResumeLineViewModel
            {
                Matricule = PayRollConstant.Totals,
                FirstName = string.Empty,
                LastName = string.Empty,
                ContractType = string.Empty,
                NumberDaysWorked = string.Empty,
                NumberDaysPaidLeave = string.Empty,
                BaseSalary = _servicePayslip.PayrollRound(baseSalarySum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                GrossSalary = _servicePayslip.PayrollRound(grossSalarySum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                SocialContribution = _servicePayslip.PayrollRound(socialContributionSum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                NetSalary = _servicePayslip.PayrollRound(netSalarySum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                Irpp = _servicePayslip.PayrollRound(irppSum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                Css = _servicePayslip.PayrollRound(cssSum).ToString(PayRollConstant.NumberFormat, cultureInfo),
                TaxableWages = _servicePayslip.PayrollRound(taxableWagesSum).ToString(PayRollConstant.NumberFormat, cultureInfo)
            });
            return resume;
        }

        public List<SessionViewModel> SessionsWithEmployeesWithTransferPaymentType(DateTime month)
        {
            List<SessionViewModel> sessions = FindByAsNoTracking(x => x.Month.EqualsDate(month.FirstDateOfMonth()) &&
                x.Payslip.Any(y => y.IdEmployeeNavigation.IdPaymentTypeNavigation.Code.Equals(PayRollConstant.Transfer, StringComparison.OrdinalIgnoreCase))).ToList();

            return sessions;
        }

        /// <summary>
        /// Update session state in every step
        /// </summary>
        /// <param name="model"></param>
        public void UpdateSessionStates(SessionViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            SessionViewModel sessionViewModel = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, m => m.SessionContract, s => s.Attendance);
            int oldState = sessionViewModel.State;
            switch (model.State)
            {
                case (int)SessionStateViewModel.New:
                    sessionViewModel = AddAttendanceBySessionContract(sessionViewModel);
                    sessionViewModel.State = oldState == (int)SessionStateViewModel.New ? (int)SessionStateViewModel.Attendance : oldState;
                    break;
                case (int)SessionStateViewModel.Attendance:
                    sessionViewModel.Title = model.Title;
                    sessionViewModel.State = oldState == (int)SessionStateViewModel.Attendance ? (int)SessionStateViewModel.Bonus : oldState;
                    break;
                case (int)SessionStateViewModel.Bonus:
                    sessionViewModel.State = oldState == (int)SessionStateViewModel.Bonus ? (int)SessionStateViewModel.Loan : oldState;
                    break;
                case (int)SessionStateViewModel.Loan:
                    sessionViewModel.State = oldState == (int)SessionStateViewModel.Loan ? (int)SessionStateViewModel.Payslip : oldState;
                    break;
                default:
                    throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            UpdateWithoutCollectionsWithoutTransaction(sessionViewModel);
        }

        /// <summary>
        /// Returns available emplyees contracts for session 
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public ReturnedDataSessionViewModel GetListOfAvailableEmployeesByContracts(PredicateFormatViewModel predicate, int idSession)
        {
            PredicateFilterRelationViewModel<Contract> predicateFilterRelationModel = _serviceContract.PreparePredicate(predicate);
            Session session = _entityRepo.GetSingleNotTracked(x => x.Id == idSession);
            IQueryable<Contract> employeeContracts = _serviceContract.GetAllQueryableWithRelation(contract =>
            DateTime.Compare(contract.StartDate, session.Month.LastDateOfMonth()) <= NumberConstant.Zero &&
                (!contract.EndDate.HasValue || (contract.EndDate.HasValue && contract.EndDate.Value >= session.Month.FirstDateOfMonth())),
                contract => contract.IdEmployeeNavigation, contract => contract.IdContractTypeNavigation, Contract => Contract.SessionContract)
                .Where(predicateFilterRelationModel.PredicateWhere)
                .OrderByDescending(x => x.IdEmployeeNavigation.Matricule);
            int total = employeeContracts.Count();
            ReturnedDataSessionViewModel returnedDataSessionViewModel = new ReturnedDataSessionViewModel
            {
                Total = total,
                PayDependOnTimesheet = session.Id != NumberConstant.Zero ? session.DependOnTimesheet : GetCurrentCompany().PayDependOnTimesheet
            };
            IList<Contract> employeeContractsModel = employeeContracts.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).
                Take(predicate.pageSize).ToList();
            var idEmoployees = employeeContractsModel.Select(x => x.IdEmployee);
            List<SessionContract> employeesSessionContracts = _entityRepoSessionContract.FindByAsNoTracking(x => x.IdSession == idSession && employeeContractsModel.Select(contract => contract.Id).Contains(x.IdContract)).ToList();
            IList<TimeSheetViewModel> timesheets = new List<TimeSheetViewModel>();
            if (returnedDataSessionViewModel.PayDependOnTimesheet)
            {
                timesheets = _serviceTimesheet.FindModelsByNoTracked(x => x.Month.EqualsDate(session.Month.FirstDateOfMonth()) &&
                idEmoployees.Contains(x.IdEmployee)).ToList();
            }
            IList<ReducedDataSessionViewModel> reducedData = employeeContractsModel.
                Select(elt => new ReducedDataSessionViewModel
                {
                    IdContract = elt.Id,
                    IdEmployee = elt.IdEmployeeNavigation.Id,
                    IdTimeSheet = timesheets.FirstOrDefault(t => t.IdEmployee == elt.IdEmployee) != null ? timesheets.FirstOrDefault(t => t.IdEmployee == elt.IdEmployee).Id : NumberConstant.Zero,
                    Code = elt.IdContractTypeNavigation.Code,
                    Matricule = elt.IdEmployeeNavigation.Matricule,
                    FullName = elt.IdEmployeeNavigation.FullName,
                    TimesheetStatus = timesheets.FirstOrDefault(t => t.IdEmployee == elt.IdEmployee) != null ? timesheets.FirstOrDefault(t => t.IdEmployee == elt.IdEmployee).Status : (int)TimeSheetStatusEnumerator.ToDo,
                    IdSelected = employeesSessionContracts.Any(x => x.IdContract == elt.Id) ? employeesSessionContracts.First(x => x.IdContract == elt.Id).Id : NumberConstant.Zero
                }).ToList();
            returnedDataSessionViewModel.SessionContracts = reducedData;
            return returnedDataSessionViewModel;
        }

        /// <summary>
        /// Add contract to session 
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="idSession"></param>
        /// <param name="idSelected"></param>
        /// <param name="idTimeSheet"></param>
        /// <returns></returns>
        public ObjectToSaveViewModel AddContractToSession(int idContract, int idSession, int idSelected, int idTimeSheet)
        {
            int timeSheetStatus = (int)TimeSheetStatusEnumerator.Validated;
            if (idSelected == NumberConstant.Zero)
            {
                Session session = _entityRepo.FindByAsNoTracking(s => s.Id == idSession).FirstOrDefault();
                if (session.DependOnTimesheet)
                {
                    TimeSheet timeSheet = _entityRepoTimeSheet.FindByAsNoTracking(t => t.Id == idTimeSheet).FirstOrDefault();
                    if (timeSheet != null)
                    {
                        timeSheetStatus = timeSheet.Status;
                    }
                    else
                    {
                        timeSheetStatus = (int)TimeSheetStatusEnumerator.ToDo;
                    }
                }
                if (timeSheetStatus == (int)TimeSheetStatusEnumerator.Validated)
                {
                    _entityRepoSessionContract.Add(new SessionContract
                    {
                        IdContract = idContract,
                        IdSession = idSession
                    });
                    _unitOfWork.Commit();
                }
            }
            else
            {
                _serviceSessionContract.DeleteModelPhysicallyWhithoutTransaction(idSelected, null);
            }
            ObjectToSaveViewModel objectToSaveViewModel = new ObjectToSaveViewModel
            {
                model = new ExpandoObject()
            };
            objectToSaveViewModel.model.Status = timeSheetStatus;
            return objectToSaveViewModel;
        }

        /// <summary>
        /// Add all contracts to session
        /// </summary>
        /// <param name="allSelected"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public IList<int> AddAllContractsToSession(PredicateFormatViewModel predicate, bool allSelected, int idSession)
        {
            PredicateFilterRelationViewModel<Contract> predicateFilterRelationModel = _serviceContract.PreparePredicate(predicate);
            Session session = _entityRepo.GetSingleWithRelations(x => x.Id == idSession, m => m.SessionContract);
            List<int> contractIdsToSave = new List<int>();
            if (allSelected)
            {
                List<int> savedContractIds = new List<int>();
                if (session.SessionContract != null && session.SessionContract.Count != NumberConstant.Zero )
                {
                    //get already saved contract ids
                    savedContractIds = session.SessionContract.Select(x => x.IdContract).ToList();
                }
                IQueryable<Contract> employeeContractsQueryable = _serviceContract.GetAllQueryableWithRelation(contract => contract.StartDate.BeforeDateLimitIncluded(session.Month.LastDateOfMonth()) &&
                    (!contract.EndDate.HasValue || (contract.EndDate.HasValue && contract.EndDate.Value >= session.Month.FirstDateOfMonth()))).Where(predicateFilterRelationModel.PredicateWhere)
                    .Where(x => !savedContractIds.Contains(x.Id));
                List<Contract> employeeContracts = employeeContractsQueryable.ToList();
                if (session.DependOnTimesheet)
                {
                    // Get all employees ids for timesheets
                    IList<int> employessIds = _serviceTimesheet.FindModelsByNoTracked(x => x.Month.EqualsDate(session.Month.FirstDateOfMonth()) &&
                         employeeContracts.Any(e => e.IdEmployee == x.IdEmployee)).Select(x => x.IdEmployee).ToList();
                    contractIdsToSave = employeeContracts.Where(x => employessIds.Contains(x.IdEmployee)).Select(m => m.Id).ToList();
                }
                else
                {
                    contractIdsToSave = employeeContracts.Select(x => x.Id).ToList();
                }
                List<SessionContract> sessionContracts = new List<SessionContract>();
                foreach (int id in contractIdsToSave)
                {
                    sessionContracts.Add(new SessionContract
                    {
                        IdSession = idSession,
                        IdContract = id
                    });
                }
                _entityRepoSessionContract.BulkAdd(sessionContracts);
                contractIdsToSave.AddRange(savedContractIds);
            }
            else
            {
                _entityRepoSessionContract.BulkDeletePhysically(session.SessionContract.ToList());
            }
            _unitOfWork.Commit();
            return contractIdsToSave;
        }

        /// <summary>
        /// Get lit of attendances for session
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public ReturnedDataAttendanceViewModel GetListOfAttendances(PredicateFormatViewModel predicate, int idSession)
        {
            PredicateFilterRelationViewModel<Attendance> predicateFilterRelationModel = _serviceAttendance.PreparePredicate(predicate);
            IQueryable<Attendance> attendances = _serviceAttendance.GetAllQueryableWithRelation(x => x.IdSession == idSession, a => a.IdContractNavigation, a => a.IdContractNavigation.IdContractTypeNavigation,
                a => a.IdContractNavigation.IdEmployeeNavigation)
                .Where(predicateFilterRelationModel.PredicateWhere)
                .OrderByDescending(x => x.IdContractNavigation.IdEmployeeNavigation.Matricule);
            int total = attendances.Count();
            IList<Attendance> attendancesModels = attendances.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).
                Take(predicate.pageSize).ToList();
            List<ReducedDataAttendanceViewModel> reducedData = attendancesModels.
                Select(elt => new ReducedDataAttendanceViewModel
                {
                    IdContract = elt.IdContract,
                    ContractState = elt.IdContractNavigation.State,
                    IdSession = idSession,
                    IdAttendance = elt.Id,
                    AttendanceStartDate = elt.StartDate,
                    AttendanceEndDate = elt.EndDate,
                    IdEmployee = elt.IdContractNavigation.IdEmployee,
                    Code = elt.IdContractNavigation.IdContractTypeNavigation.Code,
                    Matricule = elt.IdContractNavigation.IdEmployeeNavigation.Matricule,
                    FullName = elt.IdContractNavigation.IdEmployeeNavigation.FullName,
                    NumberDaysWorked = elt.NumberDaysWorked,
                    NumberDaysPaidLeave = elt.NumberDaysPaidLeave,
                    NumberDaysNonPaidLeave = elt.NumberDaysNonPaidLeave,
                    MaxNumberOfDaysAllowed = elt.MaxNumberOfDaysAllowed,
                    AdditionalHourOne = elt.AdditionalHourOne,
                    AdditionalHourTwo = elt.AdditionalHourTwo,
                    AdditionalHourThree = elt.AdditionalHourThree,
                    AdditionalHourFour = elt.AdditionalHourFour

                }).ToList();
            Session session = _entityRepo.GetSingleNotTracked(x => x.Id == idSession);
            ReturnedDataAttendanceViewModel returnedDataAttendanceViewModel = new ReturnedDataAttendanceViewModel
            {
                Total = total,
                Attendances = reducedData,
                SessionState = session.State,
                SessionMonth = session.Month,
                SessionTitle = session.Title,
                SessionCode = session.Code
            };
            return returnedDataAttendanceViewModel;
        }

        /// <summary>
        /// Get list of bonus session 
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public ReturnedDataBonusViewModel GetListOfBonusesForSession(PredicateFormatViewModel predicate, int idSession)
        {
            PredicateFilterRelationViewModel<Attendance> predicateFilterRelationModel = _serviceAttendance.PreparePredicate(predicate);
            Expression<Func<Attendance, bool>> expression = x => x.IdSession == idSession;
            double value = NumberConstant.Zero;
            if (predicate.Filter.Any(filter => filter.Prop == PayRollConstant.Value))
            {
                value = Convert.ToDouble(predicate.Filter.Where(filter => filter.Prop == PayRollConstant.Value).FirstOrDefault().Value);
                
                if (value != NumberConstant.Zero)
                {
                    Expression<Func<Attendance, bool>> valueExpression = x => x.IdSessionNavigation.SessionBonus.Any(y => y.Value >= value && y.IdContract == x.IdContract);
                    expression = expression.And(valueExpression);
                }
                predicate.Filter = predicate.Filter.Where(filter => filter.Prop != PayRollConstant.Value).ToList();
            }
            IQueryable<Attendance> attendances = _serviceAttendance.GetAllQueryableWithRelation(expression , a => a.IdContractNavigation, a => a.IdContractNavigation.IdContractTypeNavigation,
                a => a.IdContractNavigation.IdEmployeeNavigation, a => a.IdSessionNavigation.SessionBonus)
                .Where(predicateFilterRelationModel.PredicateWhere)
                .OrderByDescending(x => x.IdContractNavigation.IdEmployeeNavigation.Matricule);
            int total = attendances.Count();
            IList<Attendance> attendanceModels = attendances.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).
                Take(predicate.pageSize).ToList();
            int idBonus = predicate.values[NumberConstant.Zero];
            Expression<Func<SessionBonus, bool>> sessionBonusExpression = x => x.IdSession == idSession && x.IdBonus == idBonus;
            sessionBonusExpression = sessionBonusExpression.And(x => x.Value >= value);
            IList<SessionBonus> sessionBonus = _entityRepoSessionBonus.FindByAsNoTracking(sessionBonusExpression).ToList();
            IList<ReducedDataBonusViewModel> reducedData = attendanceModels.Select(elt => new ReducedDataBonusViewModel
            {
                IdSession = elt.IdSession,
                IdContract = elt.IdContract,
                IdEmployee = elt.IdContractNavigation.IdEmployeeNavigation.Id,
                ContractCode = elt.IdContractNavigation.IdContractTypeNavigation.Code,
                Matricule = elt.IdContractNavigation.IdEmployeeNavigation.Matricule,
                FullName = elt.IdContractNavigation.IdEmployeeNavigation.FullName,
                Value = sessionBonus.Any(s => s.IdContract == elt.IdContract) ? sessionBonus.FirstOrDefault(s => s.IdContract == elt.IdContract).Value : NumberConstant.Zero,
                IdSelected = sessionBonus.Any(s => s.IdContract == elt.IdContract) ? sessionBonus.FirstOrDefault(s => s.IdContract == elt.IdContract).Id : NumberConstant.Zero
            }).ToList();
            ReturnedDataBonusViewModel returnedDataBonusViewModel = new ReturnedDataBonusViewModel
            {
                Total = total,
                SessionBonus = reducedData
            };
            return returnedDataBonusViewModel;
        }

        /// <summary>
        /// Add bonus to all contracts in session
        /// </summary>
        /// <param name="allSelected"></param>
        /// <param name="idSession"></param>
        /// <param name="idBonus"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public IList<int> AddBonusToAllContracts(PredicateFormatViewModel predicate, bool allSelected, int idSession, int idBonus, double value)
        {
            PredicateFilterRelationViewModel<Attendance> predicateFilterRelationModel = _serviceAttendance.PreparePredicate(predicate);
            Session session = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == idSession, m => m.SessionBonus);
            List<int> contractIdsToSave = new List<int>();
            if (allSelected)
            {
                List<int> savedContractIds = new List<int>();
                if (session.SessionBonus != null && session.SessionBonus.Count != NumberConstant.Zero && session.SessionBonus.Any(b => b.IdBonus == idBonus))
                {
                    //get already saved session bonuses ids
                    savedContractIds = session.SessionBonus.Where(x => x.IdBonus == idBonus).Select(x => x.IdContract).ToList();
                }
                List<SessionBonus> sessionBonus = new List<SessionBonus>();
                IQueryable<Attendance> attendances = _serviceAttendance.GetAllQueryableWithRelation(x => x.IdSession == idSession).Where(predicateFilterRelationModel.PredicateWhere)
                    .Where(x => !savedContractIds.Contains(x.IdContract));
                contractIdsToSave = attendances.Select(a => a.IdContract).ToList();
                foreach (int id in contractIdsToSave)
                {
                    sessionBonus.Add(new SessionBonus
                    {
                        IdSession = idSession,
                        IdContract = id,
                        IdBonus = idBonus,
                        Value = value
                    });
                }
                // add session bonuses
                _entityRepoSessionBonus.BulkAdd(sessionBonus);
                // update payslips related to session
                BonusUpdatePayslipsTreatement(idSession, sessionBonus);
                contractIdsToSave.AddRange(savedContractIds);
            }
            else
            {
                List<SessionBonus> sessionBonus = session.SessionBonus.Where(x => x.IdBonus == idBonus).ToList();
                BonusUpdatePayslipsTreatement(idSession, sessionBonus);
                //delete session bonuses related to idBonus
                _entityRepoSessionBonus.BulkDeletePhysically(sessionBonus);
            }
            _unitOfWork.Commit();
            return contractIdsToSave;
        }

        /// <summary>
        /// Sets payslip models states to wrong when updating bonus type
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="sessionBonus"></param>
        public void BonusUpdatePayslipsTreatement(int idSession, IList<SessionBonus> sessionBonus)
        {
            //get contract ids related to bonus concerned
            List<int> contractIds = sessionBonus.Select(x => x.IdContract).ToList();
            List<Payslip> payslips = _entityRepoPayslip.FindByAsNoTracking(x => x.IdSession.Equals(idSession) && contractIds.Contains(x.IdContract)).ToList();
            if (payslips != null && payslips.Count != NumberConstant.Zero)
            {
                payslips.ForEach(elt => elt.Status = (int)PayslipStatus.Wrong);
                _entityRepoPayslip.BulkUpdate(payslips);
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// Add bonus to contract
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="idSession"></param>
        /// <param name="idSelected"></param>
        /// <param name="idBonus"></param>
        /// <param name="value"></param>
        public void AddBonusToContract(int idContract, int idSession, int idSelected, int idBonus, double value)
        {
            if (idSelected == NumberConstant.Zero)
            {   if(value == NumberConstant.Zero)
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.BonusValueEqualToZero);
                }
                _entityRepoSessionBonus.Add(new SessionBonus
                {
                    IdContract = idContract,
                    IdSession = idSession,
                    IdBonus = idBonus,
                    Value = value
                });
                _unitOfWork.Commit();
            }
            else
            {
                _serviceSessionBonus.DeleteModelPhysicallyWhithoutTransaction(idSelected, null);
            }
            UpdatePayslipTreatement(idSession, idContract);
        }
        /// <summary>
        /// Sets a payslip state to wrong when updating bonus 
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="idContract"></param>
        public void UpdatePayslipTreatement(int idSession, int idContract)
        {
            Payslip payslip = _entityRepoPayslip.FindSingleBy(x => x.IdSession.Equals(idSession) && x.IdContract == idContract);
            if (payslip != null && payslip.Status != (int)PayslipStatus.NotCalculated)
            {
                payslip.Status = (int)PayslipStatus.Wrong;
                _entityRepoPayslip.Update(payslip);
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// Check if bonus type chosen already exists in session
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="idBonus"></param>
        /// <returns></returns>
        public ObjectToSaveViewModel CheckBonusExistanceInSession(int idSession, int idBonus)
        {
            IQueryable<SessionBonus> sessionBonus = _entityRepoSessionBonus.GetAllWithConditionsQueryable(x => x.IdSession == idSession && x.IdBonus == idBonus);
            if (sessionBonus.Count() == NumberConstant.Zero)
            {
                ObjectToSaveViewModel objectToSaveViewModel = new ObjectToSaveViewModel
                {
                    model = new ExpandoObject()
                };
                objectToSaveViewModel.model.exist = false;
                return objectToSaveViewModel;
            }
            else
            {
                throw new CustomException(customStatusCode: CustomStatusCode.BonusExistanceInSession);
            }
        }

        /// <summary>
        /// Delete bonus from session
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="idBonus"></param>
        public void DeleteBonusFromSession(int idSession, int idBonus)
        {
            IList<SessionBonus> sessionBonus = _entityRepoSessionBonus.FindByAsNoTracking(s => s.IdSession == idSession && s.IdBonus == idBonus).ToList();
            BonusUpdatePayslipsTreatement(idSession, sessionBonus);
            _entityRepoSessionBonus.BulkDeletePhysically(sessionBonus);
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Update bonus type in session
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="idBonus"></param>
        /// <param name="idOldBonus"></param>
        public void UpdateBonusType(int idSession, int idBonus, int idOldBonus)
        {
            //check if the selected bonus type n update mode exists already in the session
            IQueryable<SessionBonus> sessionBonus = _entityRepoSessionBonus.GetAllWithConditionsQueryable(x => x.IdSession == idSession && x.IdBonus == idBonus);
            if (sessionBonus.Count() != NumberConstant.Zero && idBonus != idOldBonus)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.BonusExistanceInSession);
            }
            else
            {
                List<SessionBonus> sessionBonuses = _entityRepoSessionBonus.FindByAsNoTracking(s => s.IdSession == idSession && s.IdBonus == idOldBonus).ToList();
                sessionBonuses.ForEach(elt => elt.IdBonus = idBonus);
                _entityRepoSessionBonus.BulkUpdate(sessionBonuses);
                BonusUpdatePayslipsTreatement(idSession, sessionBonuses);
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// Add attendance to session 
        /// </summary>
        /// <param name="sessionViewModel"></param>
        /// <param name="oldState"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public SessionViewModel AddAttendanceBySessionContract(SessionViewModel sessionViewModel)
        {
            if (sessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            if (sessionViewModel.Attendance != null && sessionViewModel.Attendance.Count != NumberConstant.Zero)
            {
                List<int> attendanceContractIds = sessionViewModel.Attendance.Select(a => a.IdContract).ToList();
                List<int> sessionContractIds = sessionViewModel.SessionContract.Select(s => s.IdContract).ToList();
                //get session contracts that do not have an attendance
                List<SessionContractViewModel> sessionContractViewModels = sessionViewModel.SessionContract.Where(s => !attendanceContractIds.Contains(s.IdContract)).ToList();
                //get attendances that do not have a session contract ( deleted ones)
                List<AttendanceViewModel> attendanceViewModels = sessionViewModel.Attendance.Where(s => !sessionContractIds.Contains(s.IdContract)).ToList();
                //case when we added session contracts
                if (sessionContractViewModels != null && sessionContractViewModels.Count != NumberConstant.Zero)
                {
                    // leave only session contracts that do not have attendance 
                    sessionViewModel.SessionContract = sessionViewModel.SessionContract.Where(s => sessionContractViewModels.Contains(s)).ToList();
                    //get session contracts with navigation 
                    List<SessionContract> sessionContracts = _entityRepoSessionContract.GetAllWithConditionsRelationsAsNoTracking(s => sessionViewModel.SessionContract.Select(x => x.IdContract).Contains(s.IdContract)
                    && s.IdSession == sessionViewModel.Id, x => x.IdContractNavigation).ToList();
                    if (_servicePayslip.GetAllModelsQueryable(m => m.IdSession.Equals(sessionViewModel.Id)).Count() > NumberConstant.Zero)
                    {
                        IList<Payslip> newPayslips = new List<Payslip>();
                        sessionContracts.ToList().ForEach(elt => newPayslips.Add(new Payslip
                        {
                            // create new payslip
                            IdSession = elt.IdSession,
                            Month = sessionViewModel.Month.FirstDateOfMonth(),
                            IdContract = elt.IdContract,
                            IdEmployee = elt.IdContractNavigation.IdEmployee,
                            Status = (int)PayslipStatus.NotCalculated
                        }));
                        _entityRepoPayslip.BulkAdd(newPayslips);
                        _unitOfWork.Commit();
                    }
                }
                //case when we deleted session contracts
                if (attendanceViewModels != null && attendanceViewModels.Count != NumberConstant.Zero)
                {
                    // delete attendances
                    _serviceAttendance.BulkDeleteModelsPhysicallyWhithoutTransaction(attendanceViewModels, null);
                    // delete related payslips
                    List<Payslip> payslips = _entityRepoPayslip.FindByAsNoTracking(x => x.IdSession == sessionViewModel.Id
                              && attendanceViewModels.Select(m => m.IdContract).Contains(x.IdContract)).ToList();
                    _entityRepoPayslip.BulkDeletePhysically(payslips);
                    //delete related session loan installments
                    List<SessionLoanInstallment> sessionLoanInstallments = _entityRepoSessionLoanInstallment.FindByAsNoTracking(x => x.IdSession == sessionViewModel.Id
                              && attendanceViewModels.Select(m => m.IdContract).Contains(x.IdContract)).ToList();
                    _entityRepoSessionLoanInstallment.BulkDeletePhysically(sessionLoanInstallments);
                    //delete related session bonus 
                    List<SessionBonus> sessionBonus = _entityRepoSessionBonus.FindByAsNoTracking(x => x.IdSession == sessionViewModel.Id
                              && attendanceViewModels.Select(m => m.IdContract).Contains(x.IdContract)).ToList();
                    _entityRepoSessionBonus.BulkDeletePhysically(sessionBonus);
                    _unitOfWork.Commit();
                }
                // the case that we don't have any changes
                if (sessionContractViewModels.Count == NumberConstant.Zero && attendanceViewModels.Count == NumberConstant.Zero ||
                    sessionContractViewModels.Count == NumberConstant.Zero && attendanceViewModels.Count != NumberConstant.Zero)
                {
                    return sessionViewModel;
                }
            }
            sessionViewModel.Attendance = new List<AttendanceViewModel>();
            // For each employee selected in the first interface, create the monthly scores at the base of the company working days number.
            foreach (SessionContractViewModel sessionContractViewModel in sessionViewModel.SessionContract)
            {
                ContractViewModel contractViewModel = _serviceContract.GetModelById(sessionContractViewModel.IdContract);
                AttendanceViewModel attendanceViewModel = sessionViewModel.DependOnTimesheet ?
                _serviceTimesheet.NumberOfDaysWorkedByContractDependOnTimeSheet(contractViewModel,
                     sessionViewModel.Month, sessionViewModel.DaysOfWork) :
                 _serviceContract.NumberOfDaysWorkedByContractNotDependOnTimeSheet(contractViewModel,
                        sessionViewModel.Month, sessionViewModel.DaysOfWork, sessionViewModel.DaysOfWeekWorked);
                attendanceViewModel.IdSession = sessionViewModel.Id;
                sessionViewModel.Attendance.Add(attendanceViewModel);
            }
            // Save attendance in database
            _serviceAttendance.BulkAddWithoutTransaction(sessionViewModel.Attendance.ToList(), null, null);
            return sessionViewModel;
        }

        /// <summary>
        /// Get session data of available loan installments for session
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public ReturnedDataLoanViewModel GetListOfLoanInstallmentForSession(PredicateFormatViewModel predicate, int idSession)
        {
            PredicateFilterRelationViewModel<LoanInstallment> predicateFilterRelationModel = _serviceLoanInstallment.PreparePredicate(predicate);
            Session session = _entityRepo.GetAllAsNoTracking().Where(x => x.Id == idSession).Include(x => x.Attendance).ThenInclude(a => a.IdContractNavigation).ThenInclude(c => c.IdContractTypeNavigation).FirstOrDefault();
            List<int> employeesIds = session.Attendance.Select(s => s.IdContractNavigation.IdEmployee).Distinct().ToList();
            if (predicate.Filter.Any(filter => filter.Prop == PayRollConstant.Code))
            {
                int value = Convert.ToInt32(predicate.Filter.Where(filter => filter.Prop == PayRollConstant.Code).FirstOrDefault().Value);
                Expression<Func<LoanInstallment, bool>> expression = x => true;
                if(value != NumberConstant.Zero)
                {
                    expression = x => x.IdLoanNavigation.IdEmployeeNavigation.Contract.Any(c => c.IdContractType == value);
                }
                predicate.Filter = predicate.Filter.Where(filter => filter.Prop != PayRollConstant.Code).ToList();
                predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(expression);
            }

            // Get loan installment corresponding to session month
            IQueryable<LoanInstallment> loanInstallments = _serviceLoanInstallment.GetAllQueryableWithRelation(p => p.Month == session.Month && employeesIds.Contains(p.IdLoanNavigation.IdEmployee),
                x => x.IdLoanNavigation, x => x.IdLoanNavigation.IdEmployeeNavigation, x => x.IdLoanNavigation.IdEmployeeNavigation.Contract)
                .Where(predicateFilterRelationModel.PredicateWhere)
                .OrderByDescending(x => x.IdLoanNavigation.IdEmployeeNavigation.Matricule);
            List<LoanInstallment> payments = loanInstallments.ToList();
            IList<ReducedDataLoanInstallmentViewModel> reducedData = PrepareLoanInstallmentsReducedData(payments, session);
            ReturnedDataLoanViewModel returnedDataLoanViewModel = new ReturnedDataLoanViewModel();
            returnedDataLoanViewModel.Total = reducedData.Count;
            returnedDataLoanViewModel.SessionLoanInstallment = reducedData.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).
                Take(predicate.pageSize).ToList();
            returnedDataLoanViewModel.SessionLoanInstallment = returnedDataLoanViewModel.SessionLoanInstallment.OrderByDescending(x => x.Matricule).ThenByDescending(x => x.Value).ToList();
            return returnedDataLoanViewModel;
        }

        /// <summary>
        /// Get data of available loan installments for session
        /// </summary>
        /// <param name="payments"></param>
        /// <param name="session"></param>
        /// <returns></returns>
        public IList<ReducedDataLoanInstallmentViewModel> PrepareLoanInstallmentsReducedData(List<LoanInstallment> payments, Session session)
        {
            // Get registered sessionLoanInstallment
            List<SessionLoanInstallment> oldLoans = _entityRepoSessionLoanInstallment.GetAllWithConditionsRelationsAsNoTracking(x => payments.Select(y => y.Id).Contains(x.IdLoanInstallment),
            x => x.IdContractNavigation, x => x.IdContractNavigation.IdEmployeeNavigation, x => x.IdContractNavigation.IdContractTypeNavigation, x => x.IdLoanInstallmentNavigation.IdLoanNavigation).ToList();
            List<SessionLoanInstallment> sessionLoanInstallments = _entityRepoSessionLoanInstallment.FindByAsNoTracking(x => x.IdSession == session.Id).ToList();
            List<ReducedDataLoanInstallmentViewModel> reducedData = new List<ReducedDataLoanInstallmentViewModel>();
            if (oldLoans != null && oldLoans.Count > NumberConstant.Zero)
            {
                reducedData = oldLoans.Where(x => x.IdSession == session.Id).Select(elt => new ReducedDataLoanInstallmentViewModel
                {
                    IdContract = elt.IdContract,
                    IdLoanInstallment = elt.IdLoanInstallment,
                    Code = elt.IdContractNavigation.IdContractTypeNavigation.Code,
                    FullName = elt.IdContractNavigation.IdEmployeeNavigation.FullName,
                    Matricule = elt.IdContractNavigation.IdEmployeeNavigation.Matricule,
                    Value = _servicePayslip.PayrollRound(elt.Value),
                    CreditType = elt.IdLoanInstallmentNavigation.IdLoanNavigation.CreditType,
                    IdSelected = sessionLoanInstallments.Any(x => x.IdContract == elt.IdContract && x.IdLoanInstallment == elt.IdLoanInstallment) ? sessionLoanInstallments.First(x => x.IdContract == elt.IdContract && x.IdLoanInstallment == elt.IdLoanInstallment).Id : NumberConstant.Zero
                }).ToList();
            }
            List<int> oldLoansIds = oldLoans.Select(x => x.IdLoanInstallment).Distinct().ToList();
            // Get not paid loan installments
            List<LoanInstallment> notPaid = payments.Where(x => x.State != (int)LoanInstallmentEnumerator.Paid &&
                (!oldLoansIds.Contains(x.Id) || (oldLoansIds.Contains(x.Id) && oldLoans.FirstOrDefault(y => y.IdLoanInstallment == x.Id).Value != x.Amount))).ToList();
            List<int> employeeWithLoansIds = payments.Select(x => x.IdLoanNavigation.IdEmployee).ToList();
            // Get attendances with navigations
            IQueryable<Attendance> attendances = _serviceAttendance.GetAllQueryableWithRelation(a => a.IdSession == session.Id, a => a.IdContractNavigation.IdContractTypeNavigation,
                a => a.IdContractNavigation.IdEmployeeNavigation);
            // Get attendances of contracts which has loan installments to be paid
            var concernedAttendances = attendances.ToList().Where(x => employeeWithLoansIds.Contains(x.IdContractNavigation.IdEmployee)).GroupBy(x => x.IdContractNavigation.IdEmployee).ToList();
            concernedAttendances.ForEach(x =>
            {
                x.ToList().ForEach(y =>
                {
                    notPaid.Where(z => z.IdLoanNavigation.IdEmployee == y.IdContractNavigation.IdEmployee && !oldLoans.Any(w => w.IdContract == y.IdContract && w.IdLoanInstallment == z.Id)).ToList().ForEach(loanToPay =>
                    {
                        ReducedDataLoanInstallmentViewModel reducedDataLoanInstallmentViewModel = new ReducedDataLoanInstallmentViewModel
                        {
                            IdContract = y.IdContract,
                            IdLoanInstallment = loanToPay.Id,
                            Code = y.IdContractNavigation.IdContractTypeNavigation.Code,
                            FullName = loanToPay.IdLoanNavigation.IdEmployeeNavigation.FullName,
                            Matricule = loanToPay.IdLoanNavigation.IdEmployeeNavigation.Matricule,
                            CreditType = loanToPay.IdLoanNavigation.CreditType,
                            IdSelected = sessionLoanInstallments.Any(s => s.IdContract == y.IdContract && s.IdLoanInstallment == loanToPay.Id) ? sessionLoanInstallments.First(s => s.IdContract == y.IdContract && s.IdLoanInstallment == loanToPay.Id).Id : NumberConstant.Zero
                        };
                        if (x.Count() == NumberConstant.One && (loanToPay.State == (int)LoanInstallmentEnumerator.Unpaid ||
                            oldLoansIds.Count == NumberConstant.Zero || (oldLoansIds.Count > NumberConstant.Zero && oldLoansIds.Contains(loanToPay.Id))))
                        {
                            reducedDataLoanInstallmentViewModel.Value = _servicePayslip.PayrollRound(oldLoansIds.Contains(loanToPay.Id) ? loanToPay.Amount - oldLoans.Where(s => s.IdLoanInstallment == loanToPay.Id).Sum(s => s.Value) :
                                 loanToPay.Amount);
                        }
                        else
                        {
                            reducedDataLoanInstallmentViewModel.Value = _servicePayslip.PayrollRound(loanToPay.Amount * y.NumberDaysWorked / session.DaysOfWork);
                        }
                        reducedData.Add(reducedDataLoanInstallmentViewModel);
                    });
                });
            });
            return reducedData;
        }

        /// <summary>
        /// Add loan installment to session
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="idSession"></param>
        /// <param name="idSelected"></param>
        /// <param name="idLoanInstallment"></param>
        /// <param name="value"></param>
        public void AddLoanInstallmentToSession(int idContract, int idSession, int idSelected, int idLoanInstallment, double value)
        {
            if (idSelected == NumberConstant.Zero)
            {
                _entityRepoSessionLoanInstallment.Add(new SessionLoanInstallment
                {
                    IdContract = idContract,
                    IdSession = idSession,
                    IdLoanInstallment = idLoanInstallment,
                    Value = value
                });
                _unitOfWork.Commit();
            }
            else
            {
                LoanInstallment loanInstallmentToUpdate = _entityRepoLoanInstallment.GetSingleWithRelationsNotTracked(x => x.Id == idLoanInstallment, m => m.SessionLoanInstallment);
                double sum = loanInstallmentToUpdate.SessionLoanInstallment.Sum(x => x.Value);
                if (value.IsApproximately(sum))
                {
                    loanInstallmentToUpdate.State = (int)LoanInstallmentEnumerator.Unpaid;
                }
                else
                {
                    loanInstallmentToUpdate.State = (int)LoanInstallmentEnumerator.PartiallyPaid;
                }
                _entityRepoLoanInstallment.Update(loanInstallmentToUpdate);
                _serviceSessionLoanInstallment.DeleteModelPhysicallyWhithoutTransaction(idSelected, null);
            }
            UpdatePayslipTreatement(idSession, idContract);
        }

        /// <summary>
        /// Sets payslip models states to wrong when updating loan in session
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="sessionLoanInstallments"></param>
        public void LoanUpdatePayslipsTreatement(int idSession, IList<SessionLoanInstallment> sessionLoanInstallments)
        {
            //get contract ids related to loan installment concerned
            List<int> contractIds = sessionLoanInstallments.Select(x => x.IdContract).ToList();
            List<Payslip> payslips = _entityRepoPayslip.FindByAsNoTracking(x => x.IdSession.Equals(idSession) && contractIds.Contains(x.IdContract)).ToList();
            if (payslips != null && payslips.Count != NumberConstant.Zero)
            {
                payslips.ForEach(elt => elt.Status = (int)PayslipStatus.Wrong);
                _entityRepoPayslip.BulkUpdate(payslips);
            }
        }
        /// <summary>
        /// Add all loan installment in session
        /// </summary>
        /// <param name="allSelected"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public void AddAllLoanInstallmentToSession(PredicateFormatViewModel predicate, bool allSelected, int idSession)
        {
            Session session = _entityRepo.GetSingleWithRelations(x => x.Id == idSession, m => m.SessionLoanInstallment);
            ReturnedDataLoanViewModel returnedDataLoanViewModel = GetListOfLoanInstallmentForSession(predicate, idSession);
            if (allSelected)
            {
                if (session.SessionLoanInstallment != null && session.SessionLoanInstallment.Count != NumberConstant.Zero)
                {
                    //get saved SessionLoanInstallment ids 
                    List<int> savedSessionLoanInstallmentIds = session.SessionLoanInstallment.Select(x => x.Id).ToList();
                    returnedDataLoanViewModel.SessionLoanInstallment = returnedDataLoanViewModel.SessionLoanInstallment.Where(x => !savedSessionLoanInstallmentIds.Contains(x.IdSelected)).ToList();
                }
                IList<SessionLoanInstallment> sessionLoanInstallments = new List<SessionLoanInstallment>();
                foreach (ReducedDataLoanInstallmentViewModel loanInstallment in returnedDataLoanViewModel.SessionLoanInstallment)
                {
                    sessionLoanInstallments.Add(new SessionLoanInstallment
                    {
                        IdSession = idSession,
                        IdContract = loanInstallment.IdContract,
                        IdLoanInstallment = loanInstallment.IdLoanInstallment,
                        Value = loanInstallment.Value
                    });
                }
                _entityRepoSessionLoanInstallment.BulkAdd(sessionLoanInstallments);
                LoanUpdatePayslipsTreatement(idSession, sessionLoanInstallments);
            }
            else
            {
                List<LoanInstallment> loanInstallmentsToUpdate = new List<LoanInstallment>();
                var currentSessionLoanInstallments = session.SessionLoanInstallment.GroupBy(x => x.IdLoanInstallment).ToList();
                currentSessionLoanInstallments.ForEach(x =>
                {
                    LoanInstallment loanInstallmentToUpdate = _entityRepoLoanInstallment.FindSingleBy(y => y.Id == x.Key);
                    double currentSessionValuesSum = x.Sum(s => s.Value);
                    double allSessionValuesSum = _entityRepoSessionLoanInstallment.FindByAsNoTracking(a => a.IdLoanInstallment == loanInstallmentToUpdate.Id).Sum(b => b.Value);
                    if (currentSessionValuesSum.IsApproximately(allSessionValuesSum))
                    {
                        loanInstallmentToUpdate.State = (int)LoanInstallmentEnumerator.Unpaid;
                    }
                    else
                    {
                        loanInstallmentToUpdate.State = (int)LoanInstallmentEnumerator.PartiallyPaid;
                    }
                    loanInstallmentsToUpdate.Add(loanInstallmentToUpdate);
                });
                _entityRepoLoanInstallment.BulkUpdate(loanInstallmentsToUpdate);
                LoanUpdatePayslipsTreatement(idSession, session.SessionLoanInstallment.ToList());
                _entityRepoSessionLoanInstallment.BulkDeletePhysically(session.SessionLoanInstallment.ToList());
            }
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Update all bonus values
        /// </summary>
        /// <param name="idSession"></param>
        /// <param name="idBonus"></param>
        /// <param name="value"></param>
        public void UpdateAllBonusValues(int idSession, int idBonus, double value)
        {
            List<SessionBonus> sessionBonuses = _entityRepoSessionBonus.FindByAsNoTracking(x => x.IdSession == idSession && x.IdBonus == idBonus).ToList();
            if (sessionBonuses.Count != NumberConstant.Zero)
            {
                sessionBonuses.ForEach(elt => elt.Value = value);
                _entityRepoSessionBonus.BulkUpdate(sessionBonuses);
                _unitOfWork.Commit();
            }
        }

    }
}
