using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using Settings.Exceptions.ExceptionsPayroll;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    /// <summary>
    /// Service payslip
    /// </summary>
    public class ServicePayslip : Service<PayslipViewModel, Payslip>, IServicePayslip
    {
        #region constants
        public const string SESSION_TITLE = "{SESSION_TITLE}";
        #endregion
        #region Fields

        private readonly ISalaryRuleBuilder _salaryRuleBuilder;
        private readonly ISessionBonusBuilder _sessionBonusBuilder;
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IServiceContract _serviceContract;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceBaseSalary _serviceBaseSalary;
        private readonly IServiceCnss _serviceCnss;
        private readonly IServiceSalaryStructure _serviceSalaryStructure;
        private readonly IServiceSalaryRule _serviceSalaryRule;
        private readonly IServiceBonus _serviceBonus;
        private readonly IServiceContractBonus _serviceContractBonus;
        private readonly IServiceBenefitInKind _serviceBenefitInKind;
        private readonly IServiceContractBenefitInKind _serviceContractBenefitInKind;
        private readonly IServicePayslipDetails _servicePayslipDetails;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly ILexicalAnalyzer _lexicalAnalyzer;
        private readonly ISyntacticAnalyzer _syntacticAnalyzer;
        private readonly ISemanticAnalyzer _semanticAnalyzer;
        internal readonly IServiceSessionBonus _serviceSessionBonus;
        internal readonly IRepository<Session> _repoSession;
        internal readonly IServiceInformation _serviceInformation;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceSharedDocument _serviceSharedDocument;
        private readonly IServiceGrade _serviceGrade;
        private readonly IHubContext<PayslipSessionProgressHub> _progressHubContext;
        private readonly IServiceSalaryStructureValidityPeriodSalaryRule _serviceSalaryStructureValidityPeriodSalaryRule;
        private readonly IServiceTimeSheet _servicetimeSheet;
        private readonly IServicePeriod _servicePeriod;
        private static readonly CultureInfo frCulture = new CultureInfo("fr-FR", false);
        private readonly IRepository<LoanInstallment> _loanInstallmentRepository;
        private readonly IServiceCurrency _serviceCurrency;
        private readonly SmtpSettings _smtpSettings;
        private readonly IRepository<Attendance> _repoAttendance;
        private readonly IRepository<SessionLoanInstallment> _repoSessionLoanInstallment;
        private readonly IRepository<Address> _repoEntityAddress;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceJobEmployee _serviceJobEmployee;
        private readonly IRepository<SourceDeduction> _sourceDeductionRepo;
        private readonly IRepository<AdditionalHour> _repoAdditionalHour;
        private readonly IRepository<SourceDeductionSession> _sourceDeductionSessionRepo;
        private readonly IRepository<SourceDeductionSessionEmployee> _sourceDeductionSessionEmployeeRepo;
        #endregion
        #region Constructors
        public ServicePayslip(IServiceContractBonus serviceContractBonus,
             IServiceCompany serviceCompany,
            IServiceSalaryStructure serviceSalaryStructure,
            IServiceSalaryRule serviceSalaryRule,
            IServiceBonus servicePremium,
            IServiceBenefitInKind serviceBenefitInKind,
            IServiceContractBenefitInKind serviceContractBenefitInKind,
            IServicePayslipDetails servicePayslipDetails,
            ILexicalAnalyzer lexicalAnalyzer,
            ISyntacticAnalyzer syntacticAnalyzer,
            IServiceTimeSheet servicetimeSheet,
            IServicePeriod servicePeriod,
            IServiceSalaryStructureValidityPeriodSalaryRule serviceSalaryStructureValidityPeriodSalaryRule,
            IServiceSessionBonus servicePaySlipPremium,
            IServiceBaseSalary serviceBaseSalary,
            IServiceCnss serviceCnss,
            IServiceGrade serviceGrade,
             IServiceJobEmployee serviceJobEmployee,
            IHubContext<PayslipSessionProgressHub> progressHubContext,
            ISemanticAnalyzer semanticAnalyzer,
            IRepository<Payslip> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            IPayslipBuilder builder, ISalaryRuleBuilder salaryRuleBuilder,
            ISessionBonusBuilder sessionBonusBuilder,
            IRepository<Entity> entityRepoEntity,
            IRepository<User> entityRepoUser,
            IRepository<AdditionalHour> repoAdditionalHour,
            IServiceContract serviceContract,
            IServiceEmployee serviceEmployee,
            IServiceRuleUniqueReference serviceRuleUniqueReference,
            IRepository<Session> repoSession,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<LoanInstallment> loanInstallmentRepository,
            IServiceSharedDocument serviceSharedDocument,
            IServiceMsgNotification serviceMessageNotification,
            IServiceInformation serviceInformation,
            IServiceEmail serviceEmail, IOptions<SmtpSettings> smtpSettings,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
             IRepository<Address> repoEntityAddress,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache, IServiceCurrency serviceCurrency, IRepository<Attendance> repoAttendance, IRepository<SessionLoanInstallment> repoSessionLoanInstallment,
            IRepository<SourceDeduction> sourceDeductionRepo, IRepository<SourceDeductionSession> sourceDeductionSessionRepo, IRepository<SourceDeductionSessionEmployee> sourceDeductionSessionEmployeeRepo)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity,
                  entityRepoEntityCodification, entityRepoCodification, companyBuilder, memoryCache)
        {
            _serviceContract = serviceContract;
            _serviceEmployee = serviceEmployee;
            _serviceSalaryStructure = serviceSalaryStructure;
            _serviceSalaryRule = serviceSalaryRule;
            _serviceBonus = servicePremium;
            _servicetimeSheet = servicetimeSheet;
            _servicePeriod = servicePeriod;
            _serviceContractBonus = serviceContractBonus;
            _serviceBaseSalary = serviceBaseSalary;
            _serviceCnss = serviceCnss;
            _serviceBenefitInKind = serviceBenefitInKind;
            _serviceContractBenefitInKind = serviceContractBenefitInKind;
            _servicePayslipDetails = servicePayslipDetails;
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _serviceSharedDocument = serviceSharedDocument;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceInformation = serviceInformation;
            _serviceEmail = serviceEmail;
            _lexicalAnalyzer = lexicalAnalyzer;
            _syntacticAnalyzer = syntacticAnalyzer;
            _semanticAnalyzer = semanticAnalyzer;
            _salaryRuleBuilder = salaryRuleBuilder;
            _sessionBonusBuilder = sessionBonusBuilder;
            _entityRepoUser = entityRepoUser;
            _serviceSessionBonus = servicePaySlipPremium;
            _repoSession = repoSession;
            _serviceGrade = serviceGrade;
            _progressHubContext = progressHubContext;
            _serviceSalaryStructureValidityPeriodSalaryRule = serviceSalaryStructureValidityPeriodSalaryRule;
            _loanInstallmentRepository = loanInstallmentRepository;
            _serviceCurrency = serviceCurrency;
            _smtpSettings = smtpSettings.Value;
            _repoAttendance = repoAttendance;
            _repoSessionLoanInstallment = repoSessionLoanInstallment;
            _repoEntityAddress = repoEntityAddress;
            _serviceCompany = serviceCompany;
            _serviceJobEmployee = serviceJobEmployee;
            _sourceDeductionRepo = sourceDeductionRepo;
            _sourceDeductionSessionRepo = sourceDeductionSessionRepo;
            _sourceDeductionSessionEmployeeRepo = sourceDeductionSessionEmployeeRepo;
            _repoAdditionalHour = repoAdditionalHour;
        }


        #endregion
        #region Methodes
        /// <summary>
        /// Add new Payslip
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <returns></returns>
        public PayslipViewModel AddModelPayslip(PayslipViewModel model, double daysOfWork, bool dependOnTimeSheet)
        {
            if (model == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            try
            {
                BeginTransaction();
                ICollection<SalaryRuleViewModel> result = GetEmployeeContractRules(model, daysOfWork, dependOnTimeSheet);
                CalculateDetails(model, result);
                Payslip entity = _builder.BuildModel(model);
                // add entity
                _entityRepo.Add(entity);
                _unitOfWork.Commit();
                EndTransaction();
                CreatedDataViewModel createdData = new CreatedDataViewModel { Id = entity.Id };
                model.Id = createdData.Id;
                return model;
            }
            catch (CustomException customException)
            {
                model.ErrorMessage = customException.Paramtrs.ContainsKey(PayRollConstant.PayslipErrorMessage)
                    ? customException.Paramtrs[PayRollConstant.PayslipErrorMessage]
                    : PayRollConstant.GENERATED_PAYSLIP_ERROR;
                model.Status = (int)PayslipStatus.Wrong;
                Payslip entity = _builder.BuildModel(model);
                _entityRepo.Add(entity);
                _unitOfWork.Commit();
                EndTransaction();
                return model;
            }
            catch (Exception e)
            {
                model.ErrorMessage = PayRollConstant.GENERATED_PAYSLIP_ERROR;
                model.Status = (int)PayslipStatus.Wrong;
                Payslip entity = _builder.BuildModel(model);
                _entityRepo.Add(entity);
                _unitOfWork.Commit();
                EndTransaction();
                return model;
            }
        }

        /// <summary>
        /// Update model
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        public override object UpdateModel(PayslipViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            var UpdateResult = new Object();
            if (model == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            try
            {
                BeginTransaction();
                if (model.Status != (int)PayslipStatus.Correct)
                {
                    UpdateSourceDeductions(new List<PayslipViewModel> { model }, model.Month.Year);
                }
                _servicePayslipDetails.BulkDeleteModelsPhysicallyWhithoutTransaction(_servicePayslipDetails.FindModelBy(detail => detail.IdPayslip.Equals(model.Id)), userMail);
                Session session = _repoSession.GetSingleNotTracked(p => p.Id == model.IdSession);
                // Get the employee contract attendance
                Attendance attendance = _repoAttendance.GetSingleNotTracked(m => m.IdSession == model.IdSession && m.IdContract == model.IdContract);
                model.NumberDaysWorked = attendance.NumberDaysWorked;
                model.NumberDaysPaidLeave = attendance.NumberDaysPaidLeave;
                model.AdditionalHourOne = attendance.AdditionalHourOne;
                model.AdditionalHourTwo = attendance.AdditionalHourTwo;
                model.AdditionalHourThree = attendance.AdditionalHourThree;
                model.AdditionalHourFour = attendance.AdditionalHourFour;
                // Get employee salary structure rules
                ICollection<SalaryRuleViewModel> result = GetEmployeeContractRules(model, session.DaysOfWork, session.DependOnTimesheet);
                // Calculate details of payslip
                CalculateDetails(model, result);
                model.Status = (int)PayslipStatus.Correct;
                model.ErrorMessage = null;
            }
            catch (CustomException customException)
            {
                model.Status = (int)PayslipStatus.Wrong;
                model.ErrorMessage = customException.Paramtrs.ContainsKey(PayRollConstant.PayslipErrorMessage)
                    ? customException.Paramtrs[PayRollConstant.PayslipErrorMessage]
                    : PayRollConstant.GENERATED_PAYSLIP_ERROR;
            }
            catch (Exception)
            {
                model.Status = (int)PayslipStatus.Wrong;
                model.ErrorMessage = PayRollConstant.GENERATED_PAYSLIP_ERROR;
            }
            finally
            {
                UpdateResult = UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                EndTransaction();

            }
            return UpdateResult;
        }


        /// <summary>
        /// Takes into parameter the contract of the employee, the date of beginning and end of the bulletin, 
        /// recovers the identifier of the associated salary structure and calls the method GetRulesAndValues
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="BulletinStartDate"></param>
        /// <param name="BulletinEndDate"></param>
        /// <returns></returns>
        public ICollection<SalaryRuleViewModel> GetEmployeeContractRules(PayslipViewModel model, double? daysOfWork, bool? dependOnTimeSheet)
        {
            if (model != null)
            {
                model.Month = model.Month.FirstDateOfMonth();
                SalaryStructureViewModel salaryStructureViewModel = _serviceSalaryStructure.GetStructureSalaryByIdContract(model.IdContract);
                return GetRulesAndValues(model, salaryStructureViewModel, daysOfWork, dependOnTimeSheet);
            }
            else
            {
                return new List<SalaryRuleViewModel>();
            }
        }

        /// <summary>
        /// Return the rebuild rules after replace the variables and constants by their values
        /// </summary>
        /// <param name="salaryStructure"></param>
        /// <returns></returns>
        public ICollection<SalaryRuleViewModel> GetRulesAndValues(PayslipViewModel model, SalaryStructureViewModel salaryStructureViewModel, double? daysOfWork, bool? dependOnTimeSheet)
        {
            if (!daysOfWork.HasValue)
            {
                daysOfWork = _servicePeriod.NumberOfDaysWorkedByCompanyInMonth(model.Month);
            }
            if (!dependOnTimeSheet.HasValue)
            {
                dependOnTimeSheet = GetCurrentCompany().PayDependOnTimesheet;
            }
            if (model != null)
            {
                SalaryStructureViewModel salaryStructure = salaryStructureViewModel.DeepCopyByExpressionTree();
                salaryStructure.SalaryRules = _serviceSalaryStructureValidityPeriodSalaryRule.GetSalaryStructureHierarchyRules(salaryStructureViewModel, model.Month);
                // Determine the effective number of days of the month
                double monthNumberOfDays = _servicePeriod.NumberOfDaysInIntervalDates(model.Month, model.Month.LastDateOfMonth(), dependOnTimeSheet.Value);
                // initializes the buffer that will contain the already calculated expression values
                _semanticAnalyzer.InitializeBuffer();
                BonusValue bonusValue = new BonusValue();
                // Calculate fixed bonus
                IList<SalaryRuleViewModel> salaryRulesbonus = CalculateBonus(model, bonusValue, daysOfWork.Value, dependOnTimeSheet.Value, monthNumberOfDays);
                foreach (SalaryRuleViewModel salaryRuleViewModel in salaryRulesbonus)
                {
                    salaryStructure.SalaryRules.Add(salaryRuleViewModel);
                }
                // Calculate benefit in kind
                IList<SalaryRuleViewModel> salaryRulesBenefitInKind = CalculateBenefitInKind(model, bonusValue, daysOfWork.Value, dependOnTimeSheet.Value, monthNumberOfDays);
                foreach (SalaryRuleViewModel salaryRuleViewModel in salaryRulesBenefitInKind)
                {
                    salaryStructure.SalaryRules.Add(salaryRuleViewModel);
                }
                // Calculate ovvertime
                IList<SalaryRuleViewModel> salaryRulesOverTime = CalculateOverTime(model, bonusValue, daysOfWork.Value, dependOnTimeSheet.Value, monthNumberOfDays);
                foreach (SalaryRuleViewModel salaryRuleViewModel in salaryRulesOverTime)
                {
                    salaryStructure.SalaryRules.Add(salaryRuleViewModel);
                }
                _semanticAnalyzer.SetValueInBuffer(PayRollConstant.ContributoryBonus, bonusValue.ContributoryPortion);
                _semanticAnalyzer.SetValueInBuffer(PayRollConstant.TaxableBonus, bonusValue.Taxable);
                _semanticAnalyzer.SetValueInBuffer(PayRollConstant.TotalBonus, bonusValue.Total);
                // calculate loan 
                IList<SalaryRuleViewModel> salaryRuleLoanInstallments = CalculateLoan(model);
                foreach (SalaryRuleViewModel salaryRuleViewModel in salaryRuleLoanInstallments)
                {
                    salaryStructure.SalaryRules.Add(salaryRuleViewModel);
                }
                salaryStructure.SalaryRules = salaryStructure.SalaryRules.OrderBy(c => c.Applicability).ThenBy(c => c.Order).ToList();
                salaryStructure.SalaryRules = CalculateSalary(salaryStructure, model, daysOfWork.Value, dependOnTimeSheet.Value, monthNumberOfDays);
                // Clear the buffer which contain the already calculated expression values
                _semanticAnalyzer.ClearBuffer();
                return salaryStructure.SalaryRules;
            }
            else
            {
                return new List<SalaryRuleViewModel>();
            }
        }

        /// <summary>
        /// Calculate payslip details
        /// </summary>
        /// <param name="payslipViewModel"></param>
        /// <param name="result"></param>
        /// <param name="idPayslip"></param>
        private void CalculateDetails(PayslipViewModel payslipViewModel, ICollection<SalaryRuleViewModel> result)
        {
            if (payslipViewModel == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            int order = NumberConstant.One;
            payslipViewModel.PayslipDetails = new List<PayslipDetailsViewModel>();
            int lastOrderApplicability = NumberConstant.Zero;
            foreach (SalaryRuleViewModel rule in result)
            {
                PayslipDetailsViewModel detail = new PayslipDetailsViewModel
                {
                    Rule = rule.Name,
                    Order = order,
                    AppearsOnPaySlip = rule.AppearsOnPaySlip,
                    IdPayslip = payslipViewModel.Id,
                    NumberOfDays = rule.DependNumberDaysWorked ? rule.NumberDaysWorked : NumberConstant.Zero
                };
                if (rule.RuleType == (int)RuleTypeEnumerator.Gain)
                {
                    detail.Gain = rule.Rules.ContainsKey(PayRollConstant.Salary) ? rule.Rules[PayRollConstant.Salary] : NumberConstant.Zero;
                    if (detail.Gain < NumberConstant.Zero)
                    {
                        payslipViewModel.ErrorMessage = PayRollConstant.NEGATIVE_SALARY;
                        payslipViewModel.Status = (int)PayslipStatus.Wrong;
                    }
                    detail.Deduction = NumberConstant.Zero;

                }
                else
                {
                    detail.Deduction = rule.Rules.ContainsKey(PayRollConstant.Salary) ? rule.Rules[PayRollConstant.Salary] : NumberConstant.Zero;
                    if (detail.Deduction < NumberConstant.Zero)
                    {
                        payslipViewModel.ErrorMessage = PayRollConstant.NEGATIVE_SALARY;
                        payslipViewModel.Status = (int)PayslipStatus.Wrong;
                    }
                    detail.Gain = NumberConstant.Zero;
                }
                if (rule.IsBonus)
                {
                    detail.IdBonus = rule.Id;
                }
                else if (rule.IsBenefitInKind)
                {
                    detail.IdBenefitInKind = rule.Id;
                }
                else if (rule.IsLoan)
                {
                    detail.IdLoanInstallment = rule.Id;
                }
                else if (rule.IsAdditionalHour)
                {
                    detail.IdAdditionalHour = rule.Id;
                }
                else
                {
                    detail.IdSalaryRule = rule.Id;
                    detail.IdSalaryRuleNavigation = rule;
                }
                PayslipDetailsArround(detail, rule, result, ref lastOrderApplicability);
                payslipViewModel.PayslipDetails.Add(detail);
                order++;
            }
        }

        /// <summary>
        /// After the salary calculation, the rounding method is called for visual appearance matching
        /// </summary>
        /// <param name="detail"></param>
        /// <param name="rule"></param>
        /// <param name="result"></param>
        /// <param name="lastOrderApplicability"></param>
        private void PayslipDetailsArround(PayslipDetailsViewModel detail, SalaryRuleViewModel rule, ICollection<SalaryRuleViewModel> result, ref int lastOrderApplicability)
        {
            detail.Gain = PayrollRound(detail.Gain);
            detail.Deduction = PayrollRound(detail.Deduction);
            if (rule.Order == NumberConstant.Zero && rule.Applicability > NumberConstant.Zero)
            {
                int value = lastOrderApplicability;
                double rest = result.Where(x => x.Applicability == value && x.RuleType == (int)RuleTypeEnumerator.Gain).Sum(y => PayrollRound((double)y.Rules[PayRollConstant.Salary])) -
                result.Where(x => x.Applicability == value && x.RuleType == (int)RuleTypeEnumerator.Retenue).Sum(y => PayrollRound((double)y.Rules[PayRollConstant.Salary]));
                detail.Gain = rule.RuleType == (int)RuleTypeEnumerator.Gain ? PayrollRound(rest) : NumberConstant.Zero;
                detail.Deduction = rule.RuleType == (int)RuleTypeEnumerator.Retenue ? PayrollRound(rest) : NumberConstant.Zero;
                lastOrderApplicability = rule.Applicability;
            }
        }


        /// <summary>
        /// Calculate fixed bonus
        /// </summary>
        /// <param name="premiumViewModels"></param>
        /// <param name="payslipViewModel"></param>
        /// <returns></returns>
        public IList<SalaryRuleViewModel> CalculateBonus(PayslipViewModel payslipViewModel, BonusValue bonusValue, double daysOfWork, bool dependOnTimeSheet, double monthNumberOfDays)
        {
            if (payslipViewModel == null)
            {
                throw new ArgumentException("");
            }
            List<SalaryRuleViewModel> salaryRuleViewModels = new List<SalaryRuleViewModel>();
            double numberDaysWorked = payslipViewModel.NumberDaysWorked + payslipViewModel.NumberDaysPaidLeave;
            // Get list of premium associate with the employee contract
            IEnumerable<BonusViewModel> bonusViewModels = _serviceBonus.GetAvailableBonusOfContract(payslipViewModel.IdContract, payslipViewModel.Month).ToList();
            // Get list of session bonus associate with the employee contract and the current session
            IEnumerable<SessionBonusViewModel> sessionBonus = _serviceSessionBonus.FindModelsByNoTracked(sb => sb.IdContract == payslipViewModel.IdContract && sb.IdSession == payslipViewModel.IdSession,
                x => x.IdBonusNavigation, x => x.IdBonusNavigation.IdCnssNavigation);
            // Calculate fixed bonus
            if (bonusViewModels.Any())
            {
                foreach (BonusViewModel bonusViewModel in bonusViewModels)
                {
                    // Build salaryrule from the bonus
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByBonus(bonusViewModel);
                    // Initialize the value of the bonus
                    double contractBonusValue = _serviceContractBonus.GetBonusValue(payslipViewModel, bonusViewModel, dependOnTimeSheet, daysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked);
                    salaryRuleViewModel.NumberDaysWorked = numberDaysWorked < dayOfWorkReallyWorked ? numberDaysWorked : dayOfWorkReallyWorked;
                    contractBonusValue = bonusViewModel.DependNumberDaysWorked ? salaryRuleViewModel.NumberDaysWorked * contractBonusValue / dayOfWorkReallyWorked : contractBonusValue;
                    contractBonusValue = double.IsNaN(contractBonusValue) ? NumberConstant.Zero : contractBonusValue;
                    salaryRuleViewModel.Rule = contractBonusValue.ToString(frCulture);
                    CalculateBonusValue(payslipViewModel, salaryRuleViewModel, bonusViewModel, bonusValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
            }
            // Calculate variable bonus named sessionBonus
            if (sessionBonus.Any())
            {
                foreach (SessionBonusViewModel sessionBonusViewModel in sessionBonus)
                {
                    //BonusViewModel bonusViewModel = _serviceBonus.GetModel(bonus => bonus.Id == sessionBonusViewModel.IdBonus);
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByBonus(sessionBonusViewModel.IdBonusNavigation);
                    salaryRuleViewModel.NumberDaysWorked = numberDaysWorked < daysOfWork ? numberDaysWorked : daysOfWork;
                    // Initialize the value of the bonus
                    double sessionBonusValue = sessionBonusViewModel.IdBonusNavigation.DependNumberDaysWorked ? salaryRuleViewModel.NumberDaysWorked * sessionBonusViewModel.Value / daysOfWork : sessionBonusViewModel.Value;
                    salaryRuleViewModel.Rule = sessionBonusValue.ToString(frCulture);
                    salaryRuleViewModel.Name = sessionBonusViewModel.IdBonusNavigation.Name;
                    salaryRuleViewModel.Reference = sessionBonusViewModel.IdBonusNavigation.Code;
                    CalculateBonusValue(payslipViewModel, salaryRuleViewModel, sessionBonusViewModel.IdBonusNavigation, bonusValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
            }
            return salaryRuleViewModels ?? new List<SalaryRuleViewModel>();
        }

        /// <summary>
        /// Calculate the correct value by number of days of each bonus
        /// </summary>
        /// <param name="model"></param>
        /// <param name="salaryRuleViewModel"></param>
        /// <param name="bonusViewModel"></param>
        /// <param name="bonusValue"></param>
        /// <param name="CompanyNumberDaysWorked"></param>
        private void CalculateBonusValue(PayslipViewModel model, SalaryRuleViewModel salaryRuleViewModel, BonusViewModel bonusViewModel, BonusValue bonusValue)
        {
            // Tokenize the rule (Construct a queue)
            Queue<TokenViewModel> rule = _lexicalAnalyzer.LexerForExcecution(salaryRuleViewModel.Rule);
            // Parser the queue in AST, Abstract Syntactic Tree            
            SubTreeViewModel ast = _syntacticAnalyzer.Parse(rule);
            double NumberDaysWorked = model.NumberDaysWorked + model.NumberDaysPaidLeave;
            // Excecute the ast
            Dictionary<string, double> result = _semanticAnalyzer.Execute(ast, model.IdEmployee, model.IdContract, model.Month, salaryRuleViewModel, NumberDaysWorked);
            salaryRuleViewModel.Rules = new Dictionary<string, dynamic>
            {
                [PayRollConstant.Salary] = result[PayRollConstant.Salary]
            };
            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
            // Calculate the cnss value of the bonus
            bonusValue.ContributoryPortion += result[PayRollConstant.Salary] * bonusViewModel.IdCnssNavigation.SalaryRate / NumberConstant.Hundred;
            if (bonusViewModel.IsTaxable)
            {
                bonusValue.Taxable += result[PayRollConstant.Salary];
            }
            bonusValue.Total += result[PayRollConstant.Salary];
        }


        /// <summary>
        /// Calculate benefit in kind value
        /// </summary>
        /// <param name="model"></param>
        /// <param name="bonusValue"></param>
        /// <param name="daysOfWork"></param>
        /// <param name="dependOnTimeSheet"></param>
        /// <param name="monthNumberOfDays"></param>
        /// <returns></returns>
        public IList<SalaryRuleViewModel> CalculateBenefitInKind(PayslipViewModel model, BonusValue bonusValue, double daysOfWork, bool dependOnTimeSheet, double monthNumberOfDays)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            List<SalaryRuleViewModel> salaryRuleViewModels = new List<SalaryRuleViewModel>();
            // Get list of benefitInKind associate with the employee contract
            IList<BenefitInKindViewModel> benefitInKindViewModels = _serviceBenefitInKind.GetAvailableBenefitInKindOfContract(model.IdContract, model.Month).ToList();
            // Calculate benefit in kind
            if (benefitInKindViewModels.Any())
            {
                foreach (BenefitInKindViewModel benefitInKindViewModel in benefitInKindViewModels)
                {
                    // Build salaryrule from the benefitInKind
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByBenefitInKind(benefitInKindViewModel);
                    // Initialize the value of the benefitInKind
                    double contractBenefitInKindValue = _serviceContractBenefitInKind.GetBenefitInKindValue(model, benefitInKindViewModel, dependOnTimeSheet, daysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked);
                    double numberDaysWorked = model.NumberDaysWorked + model.NumberDaysPaidLeave;
                    salaryRuleViewModel.NumberDaysWorked = numberDaysWorked < dayOfWorkReallyWorked ? numberDaysWorked : dayOfWorkReallyWorked;
                    contractBenefitInKindValue = benefitInKindViewModel.DependNumberDaysWorked ? salaryRuleViewModel.NumberDaysWorked * contractBenefitInKindValue / dayOfWorkReallyWorked : contractBenefitInKindValue;
                    contractBenefitInKindValue = double.IsNaN(contractBenefitInKindValue) ? NumberConstant.Zero : contractBenefitInKindValue;
                    salaryRuleViewModel.Rule = contractBenefitInKindValue.ToString(frCulture);
                    CalculateBenefitInKindValue(model, salaryRuleViewModel, benefitInKindViewModel, bonusValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
            }
            return salaryRuleViewModels ?? new List<SalaryRuleViewModel>();
        }

        private void CalculateBenefitInKindValue(PayslipViewModel model, SalaryRuleViewModel salaryRuleViewModel, BenefitInKindViewModel benefitInKindViewModel, BonusValue bonusValue)
        {
            // Tokenize the rule (Construct a queue)
            Queue<TokenViewModel> rule = _lexicalAnalyzer.LexerForExcecution(salaryRuleViewModel.Rule);
            // Parser the queue in AST, Abstract Syntactic Tree            
            SubTreeViewModel ast = _syntacticAnalyzer.Parse(rule);
            double NumberDaysWorked = model.NumberDaysWorked + model.NumberDaysPaidLeave;
            // Excecute the ast
            Dictionary<string, double> result = _semanticAnalyzer.Execute(ast, model.IdEmployee, model.IdContract, model.Month, salaryRuleViewModel, NumberDaysWorked);
            salaryRuleViewModel.Rules = new Dictionary<string, dynamic>
            {
                [PayRollConstant.Salary] = result[PayRollConstant.Salary]
            };
            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
            // Calculate the cnss value of the bonus
            bonusValue.ContributoryPortion += result[PayRollConstant.Salary] * benefitInKindViewModel.IdCnssNavigation.SalaryRate / NumberConstant.Hundred;
            if (benefitInKindViewModel.IsTaxable)
            {
                bonusValue.Taxable += result[PayRollConstant.Salary];
            }
            bonusValue.Total += result[PayRollConstant.Salary];
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="payslipViewModel"></param>
        /// <param name="bonusValue"></param>
        /// <param name="daysOfWork"></param>
        /// <param name="dependOnTimeSheet"></param>
        /// <param name="monthNumberOfDays"></param>
        /// <returns></returns>
        public IList<SalaryRuleViewModel> CalculateOverTime(PayslipViewModel payslipViewModel, BonusValue bonusValue, double daysOfWork, bool dependOnTimeSheet, double monthNumberOfDays)
        {
            if (payslipViewModel == null)
            {
                throw new ArgumentException("");
            }
            List<SalaryRuleViewModel> salaryRuleViewModels = new List<SalaryRuleViewModel>();
            if (payslipViewModel.AdditionalHourOne != default || payslipViewModel.AdditionalHourTwo != default
                || payslipViewModel.AdditionalHourThree != default || payslipViewModel.AdditionalHourFour != default)
            {
                double baseSalary = _serviceBaseSalary.GetBaseSalary(payslipViewModel, dependOnTimeSheet, daysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked, true);
                IList<AdditionalHour> additionalHours = _repoAdditionalHour.GetAll().OrderBy(x => x.Code).ToList();
                if (payslipViewModel.AdditionalHourOne != default)
                {
                    AdditionalHour additionalHour = additionalHours.FirstOrDefault(x => x.Code.Equals(PayRollConstant.FirstAdditionalHourCode));
                    // Build salaryrule from the additionalHour
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByAdditionalHour(additionalHour);
                    // Initialize the value of the additionalHour
                    double additionalHourValue = payslipViewModel.AdditionalHourOne * baseSalary / daysOfWork * (additionalHour.IncreasePercentage / NumberConstant.Hundred + NumberConstant.One);
                    CalculateOverTimeValue(payslipViewModel, salaryRuleViewModel, bonusValue, additionalHourValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
                if (payslipViewModel.AdditionalHourTwo != default)
                {
                    AdditionalHour additionalHour = additionalHours.FirstOrDefault(x => x.Code.Equals(PayRollConstant.SecondAdditionalHourCode));
                    // Build salaryrule from the additionalHour
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByAdditionalHour(additionalHour);
                    // Initialize the value of the additionalHour
                    double additionalHourValue = payslipViewModel.AdditionalHourTwo * baseSalary / daysOfWork * (additionalHour.IncreasePercentage / NumberConstant.Hundred + NumberConstant.One);
                    CalculateOverTimeValue(payslipViewModel, salaryRuleViewModel, bonusValue, additionalHourValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
                if (payslipViewModel.AdditionalHourThree != default)
                {
                    AdditionalHour additionalHour = additionalHours.FirstOrDefault(x => x.Code.Equals(PayRollConstant.ThirdAdditionalHourCode));
                    // Build salaryrule from the additionalHour
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByAdditionalHour(additionalHour);
                    // Initialize the value of the additionalHour
                    double additionalHourValue = payslipViewModel.AdditionalHourThree * baseSalary / daysOfWork * (additionalHour.IncreasePercentage / NumberConstant.Hundred + NumberConstant.One);
                    CalculateOverTimeValue(payslipViewModel, salaryRuleViewModel, bonusValue, additionalHourValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
                if (payslipViewModel.AdditionalHourFour != default)
                {
                    AdditionalHour additionalHour = additionalHours.FirstOrDefault(x => x.Code.Equals(PayRollConstant.FourthAdditionalHourCode));
                    // Build salaryrule from the additionalHour
                    SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleByAdditionalHour(additionalHour);
                    // Initialize the value of the additionalHour
                    double additionalHourValue = payslipViewModel.AdditionalHourFour * baseSalary / daysOfWork * (additionalHour.IncreasePercentage / NumberConstant.Hundred + NumberConstant.One);
                    CalculateOverTimeValue(payslipViewModel, salaryRuleViewModel, bonusValue, additionalHourValue);
                    salaryRuleViewModels.Add(salaryRuleViewModel);
                }
            }
            return salaryRuleViewModels ?? new List<SalaryRuleViewModel>();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="salaryRuleViewModel"></param>
        /// <param name="bonusValue"></param>
        /// <param name="additionalHourValue"></param>
        private void CalculateOverTimeValue(PayslipViewModel model, SalaryRuleViewModel salaryRuleViewModel, BonusValue bonusValue, double additionalHourValue)
        {
            salaryRuleViewModel.Rule = double.IsNaN(additionalHourValue) ? NumberConstant.Zero.ToString(frCulture) : additionalHourValue.ToString(frCulture);
            // Tokenize the rule (Construct a queue)
            Queue<TokenViewModel> rule = _lexicalAnalyzer.LexerForExcecution(salaryRuleViewModel.Rule);
            // Parser the queue in AST, Abstract Syntactic Tree            
            SubTreeViewModel ast = _syntacticAnalyzer.Parse(rule);
            double NumberDaysWorked = model.NumberDaysWorked + model.NumberDaysPaidLeave;
            // Excecute the ast
            Dictionary<string, double> result = _semanticAnalyzer.Execute(ast, model.IdEmployee, model.IdContract, model.Month, salaryRuleViewModel, NumberDaysWorked);
            salaryRuleViewModel.Rules = new Dictionary<string, dynamic>
            {
                [PayRollConstant.Salary] = result[PayRollConstant.Salary]
            };
            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
            // Calculate the cnss value of the bonus
            CnssViewModel cnssViewModel = _serviceCnss.GetModel(cnss => cnss.Id == model.IdContractNavigation.IdCnss);
            bonusValue.ContributoryPortion += result[PayRollConstant.Salary] * cnssViewModel.SalaryRate / NumberConstant.Hundred;
            bonusValue.Taxable += result[PayRollConstant.Salary];
            bonusValue.Total += result[PayRollConstant.Salary];
        }

        /// <summary>
        /// Calculate the salary of employee using the list of salaryrules of his salarystructure
        /// </summary>
        /// <param name="salaryRules"></param>
        /// <param name="payslipViewModel"></param>
        /// <returns></returns>
        public ICollection<SalaryRuleViewModel> CalculateSalary(SalaryStructureViewModel salaryStructureViewModel, PayslipViewModel payslipViewModel, double daysOfWork, bool dependOnTimeSheet, double monthNumberOfDays)
        {
            if (salaryStructureViewModel.SalaryRules == null || payslipViewModel == null)
            {
                throw new NonExistentRulesException();
            }
            double salaryCurrentValue = default;
            double lastPrimaryRuleValue;
            double numberDaysWorked = payslipViewModel.NumberDaysWorked + payslipViewModel.NumberDaysPaidLeave;
            foreach (SalaryRuleViewModel salaryRuleViewModel in salaryStructureViewModel.SalaryRules)
            {
                if (salaryRuleViewModel.IsBonus || salaryRuleViewModel.IsBenefitInKind || salaryRuleViewModel.IsAdditionalHour)
                {
                    salaryCurrentValue += salaryRuleViewModel.Rules[PayRollConstant.Salary];
                }
                else
                {
                    if (salaryRuleViewModel.Order.Equals(NumberConstant.Zero) || salaryRuleViewModel.Rule == null)
                    {
                        // This suppose the basesalary is calculate
                        if (!salaryCurrentValue.Equals(NumberConstant.Zero))
                        {
                            if (salaryCurrentValue < NumberConstant.Zero)
                            {
                                throw new CustomException(CustomStatusCode.NegativeSalary);
                            }
                            lastPrimaryRuleValue = salaryCurrentValue;
                            salaryRuleViewModel.Rules[PayRollConstant.Salary] = lastPrimaryRuleValue;
                            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
                        }
                        // This suppose the basesalary is not calculate yet
                        else
                        {
                            // Get the value of basesalary
                            salaryCurrentValue = _serviceBaseSalary.GetBaseSalary(payslipViewModel, dependOnTimeSheet, daysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked);
                            salaryRuleViewModel.NumberDaysWorked = numberDaysWorked < dayOfWorkReallyWorked ? numberDaysWorked : dayOfWorkReallyWorked;
                            salaryCurrentValue = salaryRuleViewModel.NumberDaysWorked * salaryCurrentValue / dayOfWorkReallyWorked;
                            salaryCurrentValue = double.IsNaN(salaryCurrentValue) ? NumberConstant.Zero : salaryCurrentValue;
                            salaryRuleViewModel.Rules[PayRollConstant.Salary] = salaryCurrentValue;
                            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
                        }
                    }
                    else
                    {
                        salaryCurrentValue = GetSalaryCurrentValue(salaryRuleViewModel, payslipViewModel, numberDaysWorked, salaryCurrentValue);
                    }
                }
            }
            return salaryStructureViewModel.SalaryRules;
        }

        /// <summary>
        /// Get the salary current value
        /// </summary>
        /// <param name="salaryRuleViewModel"></param>
        /// <param name="payslipViewModel"></param>
        /// <param name="numberDaysWorked"></param>
        /// <param name="salaryCurrentValue"></param>
        /// <returns></returns>
        private double GetSalaryCurrentValue(SalaryRuleViewModel salaryRuleViewModel, PayslipViewModel payslipViewModel, double numberDaysWorked, double salaryCurrentValue)
        {
            Dictionary<string, double> result;
            result = _semanticAnalyzer.Execute(salaryRuleViewModel.ParsedSalaryRule, payslipViewModel.IdEmployee, payslipViewModel.IdContract, payslipViewModel.Month, salaryRuleViewModel, numberDaysWorked);
            if (!result.ContainsKey(PayRollConstant.Salary))
            {
                salaryRuleViewModel.Rules[PayRollConstant.Employer] = result[PayRollConstant.Employer];
            }
            else
            {
                salaryRuleViewModel.Rules[PayRollConstant.Salary] = result[PayRollConstant.Salary];
                if (result.ContainsKey(PayRollConstant.Employer))
                {
                    salaryRuleViewModel.Rules[PayRollConstant.Employer] = result[PayRollConstant.Employer];
                }
                if (salaryRuleViewModel.RuleType == (int)RuleTypeEnumerator.Gain)
                {
                    return salaryCurrentValue + result[PayRollConstant.Salary];
                }
                else
                {
                    return salaryCurrentValue - result[PayRollConstant.Salary];
                }
            }
            return salaryCurrentValue;
        }

        /// <summary>
        /// Prepare session's payslip for massive download
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public DownloadReportDataViewModel GetAllPayslipReportSettings(int idSession, string userMail, out IList<Payslip> payslips)
        {
            Session session = _repoSession.GetSingleNotTracked(p => p.Id == idSession);
            payslips = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(m => m.IdSession == idSession,
               m => m.IdContractNavigation,
               m => m.IdContractNavigation.IdEmployeeNavigation,
               m => m.IdContractNavigation.IdContractTypeNavigation,
               m => m.IdEmployeeNavigation,
               m => m.IdSessionNavigation).ToList();
            string zipFolderName = string.Concat(nameof(Session), GenericConstants.Underscore, session.Code, GenericConstants.Underscore,
                    session.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            return BuildReportsName(payslips, zipFolderName);
        }
        public DownloadReportDataViewModel GetPayslipReportSettings(Payslip payslip)
        {
            Session session = _repoSession.GetSingleNotTracked(p => p.Id == payslip.IdSession);
            payslip.IdSessionNavigation = session;
            string zipFolderName = string.Concat(nameof(Session), GenericConstants.Underscore, session.Code, GenericConstants.Underscore,
                    session.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            return BuildOneReportsName(payslip, zipFolderName);
        }
        /// <summary>
        /// Prepare employee's payslip for massive download
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public DownloadReportDataViewModel GetAllPayslipOfSelectedEmployeeReportSettings(PredicateFormatViewModel predicate, DateTime startDate, DateTime endDate)
        {
            IList<ReportSettings> reportSettings = new List<ReportSettings>();
            List<Payslip> payslips = GetPayslipsOfSelectedEmployee(predicate, startDate, endDate).ToList();
            if (payslips.Count > NumberConstant.Zero)
            {
                string zipFolderName = string.Concat(nameof(Payslip), GenericConstants.Underscore, payslips.First().IdEmployeeNavigation.LastName,
                    GenericConstants.Underscore, payslips.First().IdEmployeeNavigation.FirstName, GenericConstants.Underscore,
                    startDate.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language), GenericConstants.Underscore,
                    endDate.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
                return BuildReportsName(payslips, zipFolderName);
            }
            else
            {
                // Throw exception when selected employee has zero payslips
                throw new CustomException(CustomStatusCode.EmployeeWithNoPayslipException);
            }
        }

        /// <summary>
        /// Buil reports name and zip folder name
        /// </summary>
        /// <param name="payslips"></param>
        /// <param name="zipFolderName"></param>
        /// <param name="documentSuffix"></param>
        /// <returns></returns>
        private DownloadReportDataViewModel BuildReportsName(IList<Payslip> payslips, string zipFolderName)
        {
            dynamic[] dynamicListIds = new dynamic[payslips.Count];
            int counter = NumberConstant.Zero;
            payslips.ToList().ForEach(payslip =>
            {
                dynamic report = new JObject();
                report.idPayslip = payslip.Id;
                report.idEmployee = payslip.IdEmployee;
                report.idSession = payslip.IdSession;
                StringBuilder reportName = new StringBuilder()
                                                .Append(nameof(Payslip)).Append(GenericConstants.Underscore)
                                                .Append(payslip.IdEmployeeNavigation.LastName).Append(GenericConstants.Underscore)
                                                .Append(payslip.IdEmployeeNavigation.FirstName).Append(GenericConstants.Underscore)
                                                .Append(payslip.IdContractNavigation.IdContractTypeNavigation.Code).Append(GenericConstants.Underscore)
                                                .Append(payslip.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language)).Append(GenericConstants.Underscore)
                                                .Append(nameof(Session)).Append(GenericConstants.Underscore)
                                                .Append(payslip.IdSessionNavigation.Code);
                if (payslips.Count(x => x.IdEmployee == payslip.IdEmployee && x.IdSession == payslip.IdSession) > NumberConstant.One)
                {
                    reportName.Append(GenericConstants.OpeningParenthesis)
                        .Append(dynamicListIds.Count(x => x != null && x.idEmployee == payslip.IdEmployee && x.idSession == payslip.IdSession) + NumberConstant.One)
                        .Append(GenericConstants.ClosingParenthesis);
                }
                report.documentName = reportName.ToString();
                dynamicListIds[counter] = report;
                counter++;
            });
            DownloadReportDataViewModel downloadReportDataViewModel = new DownloadReportDataViewModel
            {
                ReportName = nameof(Payslip),
                ReportFormatName = "pdf",
                ZipFolderName = zipFolderName,
                DynamicListIds = dynamicListIds
            };
            UpdateReportSettings(downloadReportDataViewModel);
            return downloadReportDataViewModel;
        }
        private DownloadReportDataViewModel BuildOneReportsName(Payslip payslip, string zipFolderName)
        {
            dynamic[] dynamicListIds = new dynamic[NumberConstant.One];
            dynamic report = new JObject();
            report.idPayslip = payslip.Id;
            StringBuilder reportName = new StringBuilder();
            report.documentName = reportName.Append(nameof(Payslip)).Append(GenericConstants.Underscore)
                                            .Append(payslip.IdEmployeeNavigation.LastName).Append(GenericConstants.Underscore)
                                            .Append(payslip.IdEmployeeNavigation.FirstName).Append(GenericConstants.Underscore)
                                            .Append(payslip.IdContractNavigation.IdContractTypeNavigation.Code).Append(GenericConstants.Underscore)
                                            .Append(payslip.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language)).Append(GenericConstants.Underscore)
                                            .Append(nameof(Session)).Append(GenericConstants.Underscore)
                                            .Append(payslip.IdSessionNavigation.Code).ToString();
            dynamicListIds[NumberConstant.Zero] = report;
            DownloadReportDataViewModel downloadReportDataViewModel = new DownloadReportDataViewModel
            {
                ReportName = nameof(Payslip),
                ReportFormatName = "pdf",
                ZipFolderName = zipFolderName,
                DynamicListIds = dynamicListIds
            };
            UpdateReportSettings(downloadReportDataViewModel);
            return downloadReportDataViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="payslipViewModel"></param>
        /// <returns></returns>
        private PayslipReportInformationsViewModel GetPayslipHeaderInformation(PayslipViewModel payslipViewModel)
        {
            // Get Employee contract information with few navigations
            ContractViewModel contractViewModel;
            if (payslipViewModel.IdContract > NumberConstant.Zero)
            {
                contractViewModel = _serviceContract.GetModelWithRelations(model => model.Id == payslipViewModel.IdContract,
                model => model.IdEmployeeNavigation,
                model => model.IdContractTypeNavigation);
            }
            else
            {
                contractViewModel = _serviceContract.FindModelsByNoTracked(model => model.IdEmployee == payslipViewModel.IdEmployee,
                    model => model.IdEmployeeNavigation,
                    model => model.IdContractTypeNavigation).OrderByDescending(x => x.StartDate).FirstOrDefault();
                payslipViewModel.IdContract = contractViewModel.Id;
                DateTime currentMonth = DateTime.Today.FirstDateOfMonth();
                payslipViewModel.Month = (contractViewModel.EndDate.HasValue && currentMonth.BetweenDateLimitIncluded(contractViewModel.StartDate.FirstDateOfMonth(), contractViewModel.EndDate.Value) ||
                !contractViewModel.EndDate.HasValue && currentMonth.BeforeDateLimitIncluded(payslipViewModel.Month.FirstDateOfMonth())) ? currentMonth : contractViewModel.StartDate.FirstDateOfMonth();
            };

            // Set company informations
            CompanyViewModel companyViewModel = GetCurrentCompany();

            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();
            PayslipReportInformationsViewModel report = new PayslipReportInformationsViewModel(reportCompanyInformationViewModel)
            {
                // Set report view model with employee informations
                EmployeeFullName = contractViewModel.IdEmployeeNavigation.FullName,
                EmployeeRegistrationNumber = contractViewModel.IdEmployeeNavigation.Matricule,
                EmployeeCnss = contractViewModel.IdEmployeeNavigation.SocialSecurityNumber ?? string.Empty,
                EmployeeAdress = contractViewModel.IdEmployeeNavigation.AddressLine1 + PayRollConstant.BlankSpace +
                contractViewModel.IdEmployeeNavigation.AddressLine2 + PayRollConstant.BlankSpace +
                contractViewModel.IdEmployeeNavigation.AddressLine3 + PayRollConstant.BlankSpace +
                contractViewModel.IdEmployeeNavigation.AddressLine4 + PayRollConstant.BlankSpace +
                contractViewModel.IdEmployeeNavigation.AddressLine5,
                EmployeeIsForeign = contractViewModel.IdEmployeeNavigation.IsForeign,
                EmployeeJob = _serviceJobEmployee.GetEmployeeJobAsString(contractViewModel.IdEmployee),
                EmployeeContractType = contractViewModel.IdContractTypeNavigation.Code ?? string.Empty,
                EmployeeHiringDate = contractViewModel.IdEmployeeNavigation.HiringDate.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                EmployeeIdentityPiece = !string.IsNullOrEmpty(contractViewModel.IdEmployeeNavigation.Cin) ? contractViewModel.IdEmployeeNavigation.Cin : string.Empty,
                EmployeeFamilyLeader = (contractViewModel.IdEmployeeNavigation.FamilyLeader != null) && (bool)contractViewModel.IdEmployeeNavigation.FamilyLeader,
                EmployeeEchellon = contractViewModel.IdEmployeeNavigation.Echelon.HasValue ? contractViewModel.IdEmployeeNavigation.Echelon.ToString() : string.Empty,
                EmployeeChildreenNumber = contractViewModel.IdEmployeeNavigation.ChildrenNumber.HasValue ? (int)contractViewModel.IdEmployeeNavigation.ChildrenNumber : default,
                EmployeeCategory = contractViewModel.IdEmployeeNavigation.Category ?? string.Empty,
                Month = payslipViewModel.Month,
                IdContract = contractViewModel.Id,
                SalaryOfMonth = payslipViewModel.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                Rib = string.Empty,
                BankName = string.Empty
            };

            // Get employee grade
            GradeViewModel gradeViewModel = _serviceGrade.GetModel(model => model.Id == contractViewModel.IdEmployeeNavigation.IdGrade);
            report.EmployeeGrade = gradeViewModel != null ? gradeViewModel.Designation : string.Empty;
            if (payslipViewModel.IdSessionNavigation is null)
            {
                double daysOfWork = _servicePeriod.NumberOfDaysWorkedByCompanyInMonth(payslipViewModel.Month);
                // Determine the effective number of days of the month
                double monthNumberOfDays = _servicePeriod.NumberOfDaysInIntervalDates(payslipViewModel.Month.FirstDateOfMonth(), payslipViewModel.Month.LastDateOfMonth(), companyViewModel.PayDependOnTimesheet);
                report.EmployeeBaseSalary = PayrollRound(_serviceBaseSalary.GetBaseSalary(payslipViewModel, companyViewModel.PayDependOnTimesheet, daysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked, true)).ToString();
                AttendanceViewModel attendanceViewModel = companyViewModel.PayDependOnTimesheet ?
                    _servicetimeSheet.NumberOfDaysWorkedByContractDependOnTimeSheet(contractViewModel, payslipViewModel.Month, _servicePeriod.NumberOfDaysWorkedByCompanyInMonth(payslipViewModel.Month), isForPreview: true)
                    : _serviceContract.NumberOfDaysWorkedByContractNotDependOnTimeSheet(contractViewModel, payslipViewModel.Month, daysOfWork, companyViewModel.DaysOfWeekWorked);
                if (payslipViewModel.NumberDaysWorked != NumberConstant.Zero)
                {
                    attendanceViewModel.NumberDaysWorked = payslipViewModel.NumberDaysWorked;
                }
                report.NumberOfDaysWorked = attendanceViewModel.NumberDaysWorked.ToString();
                report.EmployeePaidLeave = attendanceViewModel.NumberDaysPaidLeave.ToString();
                report.EmployeeUnPaidLeave = attendanceViewModel.NumberDaysNonPaidLeave.ToString();
                report.NumberOfDaysWorkedByCompanyInMonth = attendanceViewModel.MaxNumberOfDaysAllowed;
            }
            else
            {
                Attendance attendance = _repoAttendance.GetAllWithConditions(x => x.IdContract == payslipViewModel.IdContract && x.IdSession == payslipViewModel.IdSession).FirstOrDefault();
                // Get contract attendance
                report.NumberOfDaysWorked = attendance.NumberDaysWorked.ToString();
                report.EmployeePaidLeave = attendance.NumberDaysPaidLeave.ToString();
                report.EmployeeUnPaidLeave = attendance.NumberDaysNonPaidLeave.ToString();
                // Determine the effective number of days of the month
                double monthNumberOfDays = _servicePeriod.NumberOfDaysInIntervalDates(payslipViewModel.Month.FirstDateOfMonth(), payslipViewModel.Month.LastDateOfMonth(), payslipViewModel.IdSessionNavigation.DependOnTimesheet);
                // Get employee base salary for the current period
                report.EmployeeBaseSalary = PayrollRound(_serviceBaseSalary.GetBaseSalary(payslipViewModel, payslipViewModel.IdSessionNavigation.DependOnTimesheet,
                    payslipViewModel.IdSessionNavigation.DaysOfWork, monthNumberOfDays, out double dayOfWorkReallyWorked, true)).ToString();
            }
            return report;
        }

        /// <summary>
        /// Calculate payslip for all contract
        /// And regerate the payslips
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        private IEnumerable<Task<PayslipViewModel>> GenerateSessionPayslips(int idSession, string userMail)
        {
            Session session = _repoSession.GetSingleWithRelations(model => model.Id == idSession, model => model.Attendance);
            // Get already generated payslips
            IList<PayslipViewModel> payslipViewModels = FindModelBy(payslip => payslip.IdSession == idSession).ToList();
            // Delete physically these payslips
            if (payslipViewModels.Any())
            {
                List<PayslipViewModel> wrongPayslips = payslipViewModels.Where(x => x.Status != (int)PayslipStatus.Correct).ToList();
                if (wrongPayslips != null && wrongPayslips.Count > NumberConstant.Zero)
                {
                    UpdateSourceDeductions(wrongPayslips, session.Month.Year);
                }
                BulkDeleteModelsPhysicallyWhithoutTransaction(payslipViewModels.ToList(), userMail);
            }
            foreach (Attendance attendance in session.Attendance)
            {
                // Get employee contract from attendance id contract
                ContractViewModel contractViewModel = _serviceContract.GetModelAsNoTracked(contract => contract.Id == attendance.IdContract);
                // Check if employee contract is not null
                if (contractViewModel != null)
                {
                    // Create new payslip
                    PayslipViewModel payslipViewModel = new PayslipViewModel
                    {
                        IdSession = session.Id,
                        Month = session.Month,
                        IdContract = contractViewModel.Id,
                        IdEmployee = contractViewModel.IdEmployee,
                        Status = (int)PayslipStatus.Correct,
                        NumberDaysWorked = attendance.NumberDaysWorked,
                        NumberDaysPaidLeave = attendance.NumberDaysPaidLeave,
                        AdditionalHourOne = attendance.AdditionalHourOne,
                        AdditionalHourTwo = attendance.AdditionalHourTwo,
                        AdditionalHourThree = attendance.AdditionalHourThree,
                        AdditionalHourFour = attendance.AdditionalHourFour,
                        IdContractNavigation = contractViewModel
                    };
                    Task<PayslipViewModel> returnedTaskTResult = Task.Run(() => AddModelPayslip(payslipViewModel, session.DaysOfWork, session.DependOnTimesheet));
                    returnedTaskTResult.Wait();
                    yield return returnedTaskTResult;
                }
            }
        }

        /// <summary>
        /// Set source deductions status if they exist to wrong, delete source deductions and session in case of one existing payslip
        /// </summary>
        /// <param name="payslips"></param>
        /// <param name="year"></param>
        public void UpdateSourceDeductions(List<PayslipViewModel> payslips, int year, bool sessionToDelete = false)
        {
            List<int> employeesIds = payslips.Select(x => x.IdEmployee).Distinct().ToList();
            List<SourceDeduction> sourceDeductions = _sourceDeductionRepo.FindByAsNoTracking(x => x.Year == year && employeesIds.Contains(x.IdEmployee)).ToList();
            sourceDeductions.Select(x => { x.Status = (int)PayslipStatus.Wrong; return x; }).ToList();
            if (sessionToDelete)
            {
                List<SourceDeduction> sourceDeductionsToDelete = new List<SourceDeduction>();
                List<SourceDeductionSession> sourceDeductionsSessionsToDelete = new List<SourceDeductionSession>();
                List<SourceDeductionSessionEmployee> sessionEmployeesToDelete = new List<SourceDeductionSessionEmployee>();
                List<int> sourceDeductionSessionIds = sourceDeductions.Select(x => x.IdSourceDeductionSession).ToList();
                List<SourceDeductionSession> sourceDeductionSessions = _sourceDeductionSessionRepo.GetAllWithConditionsRelationsAsNoTracking(x => sourceDeductionSessionIds.Contains(x.Id),
                    x => x.SourceDeduction, x => x.SourceDeductionSessionEmployee).ToList();
                employeesIds.ForEach(id =>
                {
                    int existingPayslips = _entityRepo.FindByAsNoTracking(x => x.Month.Year == year && x.IdEmployee == id).Count();
                    // If employee has one payslip, all associated source deductions will be deleted
                    if (existingPayslips == NumberConstant.One)
                    {
                        List<SourceDeduction> sourceDeductionToDelete = sourceDeductions.Where(x => x.IdEmployee == id).ToList();
                        if (sourceDeductionToDelete != null)
                        {
                            sourceDeductionsToDelete.AddRange(sourceDeductionToDelete);
                            sourceDeductions.RemoveAll(x => x.IdEmployee == id);
                            sessionEmployeesToDelete.AddRange(sourceDeductionSessions.SelectMany(x => x.SourceDeductionSessionEmployee.Where(y => y.IdEmployee == id)));
                            sessionEmployeesToDelete = sessionEmployeesToDelete.Select(x => { x.IdSourceDeductionSessionNavigation = null; return x; }).ToList();
                        }
                    }
                });
                sourceDeductionSessionIds.ForEach(id =>
                {
                    SourceDeductionSession session = sourceDeductionSessions.FirstOrDefault(x => x.Id == id);
                    // If source deductions to delete of a particular session has the session length, the session will be deleted
                    if (session != null && sourceDeductionsToDelete.Where(x => x.IdSourceDeductionSession == id).Count() == session.SourceDeduction.Count)
                    {
                        sourceDeductionsSessionsToDelete.Add(session);
                        sourceDeductionsToDelete.RemoveAll(x => x.IdSourceDeductionSession == id);
                        sessionEmployeesToDelete.RemoveAll(x => x.IdSourceDeductionSession == id);
                    }
                });
                _sourceDeductionSessionRepo.RemoveRange(sourceDeductionsSessionsToDelete.ToArray());
                _sourceDeductionRepo.RemoveRange(sourceDeductionsToDelete.ToArray());
                _sourceDeductionSessionEmployeeRepo.RemoveRange(sessionEmployeesToDelete.ToArray());
            }
            _sourceDeductionRepo.BulkUpdate(sourceDeductions);
            _unitOfWork.Commit();
        }
        /// <summary>
        /// Generate session payslip
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public ICollection<PayslipViewModel> GeneratePayslip(int id, int max, string userMail)
        {
            ICollection<PayslipViewModel> resultObjectData = new List<PayslipViewModel>();
            foreach (var payslip in GenerateSessionPayslips(id, userMail))
            {
                PayslipSessionProgressHub.SendProgress(id, max, _progressHubContext);
                resultObjectData.Add(payslip.Result);
            }
            PayslipSessionProgressHub.ClearProgress(id, _progressHubContext);
            return resultObjectData;
        }

        /// <summary>
        /// Get file folder path and file name for download it
        /// </summary>
        /// <param name="path"></param>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public new FileInfoViewModel GetFileInfoForDownload(FileInfoViewModel fileInfoViewModel)
        {
            if (fileInfoViewModel == null)
            {
                throw new ArgumentException("");
            }
            // Build complete path of file
            string completePath = string.Concat(fileInfoViewModel.FulPath, fileInfoViewModel.Name);
            try
            {
                if (File.Exists(completePath))
                {
                    // Convert file data to bytes
                    fileInfoViewModel.Data = File.ReadAllBytes(completePath);
                    // Delete the payslip on the server temp folder
                    File.Delete(completePath);
                    return fileInfoViewModel;
                }
                else
                {
                    throw new ArgumentException("");
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idPaylsip"></param>
        /// <returns></returns>
        public PayslipReportInformationsViewModel GetPayslipReportInformation(int idPaylsip)
        {
            PayslipViewModel payslipViewModel = GetModelAsNoTracked(m => m.Id == idPaylsip, m => m.IdSessionNavigation);
            PayslipReportInformationsViewModel report = GetPayslipHeaderInformation(payslipViewModel);
            IList<PayslipDetailsViewModel> payslipDetails = _servicePayslipDetails.FindModelsByNoTracked(model => model.IdPayslipNavigation.Id == idPaylsip);
            report.NetToPay = payslipDetails.Any() ? PayrollRound(payslipDetails.OrderByDescending(m => m.Order).First().Gain) : NumberConstant.Zero;
            return report;
        }

        /// <summary>
        /// Get payslip report lines
        /// </summary>
        /// <param name="idPaylsip"></param>
        /// <returns></returns>
        public IList<PayslipReportLinesViewModel> GetPayslipReportInformationLines(int idPaylsip)
        {
            IList<PayslipDetailsViewModel> payslipDetailsViewModels = _servicePayslipDetails.FindModelsByNoTracked(
                model => model.IdPayslipNavigation.Id == idPaylsip,
                model => model.IdSalaryRuleNavigation).ToList();
            return BuildPayslipReport(payslipDetailsViewModels);
        }

        /// <summary>
        /// Calculate payslip report informations for preview
        /// </summary>
        /// <param name="idContract"></param>
        /// <returns></returns>
        public PayslipReportInformationsViewModel GetPayslipPreviewInformation(PayslipViewModel payslipViewModel)
        {
            try
            {
                // Instanciate report information view model
                PayslipReportInformationsViewModel report = GetPayslipHeaderInformation(payslipViewModel);
                CompanyViewModel companyViewModel = GetCurrentCompany();
                payslipViewModel.NumberDaysWorked = double.Parse(report.NumberOfDaysWorked);
                // Get employee contracts and rules
                ICollection<SalaryRuleViewModel> result = GetEmployeeContractRules(payslipViewModel, companyViewModel.DaysOfWork, companyViewModel.PayDependOnTimesheet);
                CalculateDetails(payslipViewModel, result);
                report.PayslipReportLinesViewModels = BuildPayslipReport(payslipViewModel.PayslipDetails.ToList());
                report.NetToPay = report.PayslipReportLinesViewModels.Any() ? Convert.ToDouble(report.PayslipReportLinesViewModels.Last().Gain) : 0.0;
                return report;
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception)
            {
                throw new CustomException(CustomStatusCode.PAYSLIP_PREVIEW);
            }
        }

        /// <summary>
        /// Build a list of PayslipReportLine from a list of payslipDetails
        /// </summary>
        /// <param name="payslipDetailsViewModels"></param>
        /// <returns></returns>
        private IList<PayslipReportLinesViewModel> BuildPayslipReport(IList<PayslipDetailsViewModel> payslipDetailsViewModels)
        {
            IList<PayslipReportLinesViewModel> payslipReportLinesViewModels = new List<PayslipReportLinesViewModel>();
            foreach (PayslipDetailsViewModel payslipDetails in payslipDetailsViewModels)
            {
                payslipReportLinesViewModels.Add(new PayslipReportLinesViewModel
                {
                    Label = payslipDetails.Rule,
                    NumberOfDays = payslipDetails.NumberOfDays.IsApproximately() ? string.Empty : payslipDetails.NumberOfDays.ToString(),
                    Gain = (payslipDetails.IdBenefitInKind != null || payslipDetails.IdBonus != null || payslipDetails.IdAdditionalHour != null) ? PayrollRound(payslipDetails.Gain).ToString()
                        : payslipDetails.IdSalaryRuleNavigation != null && payslipDetails.IdSalaryRuleNavigation.RuleType == (int)RuleTypeEnumerator.Gain ? PayrollRound(payslipDetails.Gain).ToString() : string.Empty,
                    Deduction = payslipDetails.IdLoanInstallment != null ? PayrollRound(payslipDetails.Deduction).ToString()
                        : payslipDetails.IdSalaryRuleNavigation != null && payslipDetails.IdSalaryRuleNavigation.RuleType == (int)RuleTypeEnumerator.Retenue ? PayrollRound(payslipDetails.Deduction).ToString() : string.Empty,
                    Order = payslipDetails.Order
                });
            }
            return payslipReportLinesViewModels.OrderBy(m => m.Order).ToList();
        }

        /// <summary>
        /// Distribution of payslips from the pay session to consecrated employees space and saving payslip encrypted in the associted employee folder on the disk
        /// </summary>
        /// <param name="idsession"> id session </param>
        /// <param name="filesInfos"> filesInfos List associated to every pdf generated to each payslip in the session </param>
        public void BrodcastPayslip(string userMail, int idsession, string link, IDictionary<Contract, FileInfoViewModel> dictionary, SmtpSettings smtpSettings)
        {
            User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
            Session session = _repoSession.FindSingleBy(x => x.Id == idsession);

            // prepare the notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters[Constants.SESSION_TITLE] = "\"" + session.Title + "\"";
            InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_PAYSLIP)
                      .FirstOrDefault();

            IList<Contract> contracts = dictionary.Keys.ToList();
            // Get employees from contracts
            IList<int> employeesIds = contracts.Select(x => x.IdEmployee).Distinct().ToList();

            // Get all Users from employees
            IList<User> users = _entityRepoUser.FindByAsNoTracking(x => x.IdEmployee.HasValue && employeesIds.Contains(x.IdEmployee.Value)).ToList();

            IList<EmployeeViewModel> employees = _serviceEmployee.FindByAsNoTracking(x => employeesIds.Contains(x.Id)).ToList();

            // save all payslips in disk and send mails
            foreach (var contract in contracts)
            {
                // Save the file in the disk && Save sharedDocument Line
                int generatedId = SaveSharedDocument(connectedUser, contract.IdEmployeeNavigation, dictionary[contract], userMail);

                // send mail 
                User user = users.Where(x => x.IdEmployee == contract.IdEmployee).FirstOrDefault();
                if (user != null)
                {
                    // send mail 
                    SendEmail(information, user, session, userMail, link, parameters, smtpSettings);
                }
            }
            // send notif
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SHARING_PAYSLIP,
            idsession, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertSharingDocument,
            userMail, parameters, users.ToList(), GetCurrentCompany().Code);
        }
        public void BrodcastOnePayslip(string userMail, string link, IDictionary<Contract, FileInfoViewModel> dictionary, Payslip payslip, SmtpSettings smtpSettings)
        {
            if (payslip.Status != (int)PayslipStatus.Correct)
            {
                throw new CustomException(CustomStatusCode.CannotBroadcastPayslip);
            }
            User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
            Session session = _repoSession.FindSingleBy(x => x.Id == payslip.IdSession);
            // prepare the notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters[Constants.SESSION_TITLE] = "\"" + session.Title + "\"";
            InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_PAYSLIP)
                      .FirstOrDefault();
            // Get User from employee
            User user = _entityRepoUser.GetSingleNotTracked(x => x.IdEmployee.HasValue && x.IdEmployee.Value == payslip.IdContractNavigation.IdEmployee);
            // Save the file in the disk && Save sharedDocument Line
            int generatedId = SaveSharedDocument(connectedUser, payslip.IdEmployeeNavigation, dictionary[payslip.IdContractNavigation], userMail);
            // send mail 
            if (user != null)
            {
                // send mail 
                SendEmail(information, user, session, userMail, link, parameters, smtpSettings);
            }
            // send notif
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SHARING_PAYSLIP,
            payslip.IdSession, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertSharingDocument,
            userMail, parameters, null, GetCurrentCompany().Code);
        }

        int SaveSharedDocument(User connectedUser, Employee employee, FileInfoViewModel fileInfo, string userMail)
        {
            // connctedUser is the person who has the action to distribute payslips
            // while Id employee is the person concerned by the payslip
            if (connectedUser == null)
            {
                throw new CustomException(CustomStatusCode.NotFound);
            }

            SharedDocumentViewModel sharedDocument = new SharedDocumentViewModel
            {
                Id = 0,
                IdEmployee = employee.Id,
                SubmissionDate = DateTime.Now,
                IdType = (int)DocumentRequestTypeEnumerator.Payslip,
                FilesInfos = new List<FileInfoViewModel> { fileInfo },
                TransactionUserId = connectedUser.Id,
                EncryptFile = true
            };
            return ((CreatedDataViewModel)_serviceSharedDocument.AddModel(sharedDocument, null, connectedUser.Email, null)).Id;

        }
        public void SendEmail(InformationViewModel information, User user, Session session, string userMail, string link, IDictionary<string, dynamic> parameters, SmtpSettings smtpSettings)
        {

            EmailConstant emailConstant = new EmailConstant(user.Lang);
            string subject = PrepareMailSubject(emailConstant, session.Title);
            string message = PrepareMessage(user, information, parameters);
            StringBuilder path = new StringBuilder();
            path.Append(link); path.Append(information.Url);
            string mailUrl = PrepareUrl(emailConstant, path.ToString());
            string body = PrepareMailBody(emailConstant, message, mailUrl);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = user.Email
            };
            // add the email in the db
            _serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail);
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
        }
        public string PrepareMessage(User user, InformationViewModel information, IDictionary<string, dynamic> parameters)
        {
            StringBuilder msgBuilder = new StringBuilder();
            switch (user.Lang)
            {
                case "fr":
                    msgBuilder.Append(information.Fr);
                    break;
                case "en":
                    msgBuilder.Append(information.En);
                    break;
            }
            string msg = msgBuilder.ToString();

            if (msg.IndexOf(SESSION_TITLE) > -1)
            {
                msg = msg.Replace(SESSION_TITLE, parameters[Constants.SESSION_TITLE].ToString(), StringComparison.OrdinalIgnoreCase);
            }
            return msg;
        }

        string PrepareUrl(EmailConstant emailConstant, string url)
        {
            StringBuilder Url = new StringBuilder();
            Url.Append("<a href='");
            Url.Append(@url);
            Url.Append("'>");
            Url.Append(emailConstant.AccessToYourSpace);
            Url.Append("</a>");
            return Url.ToString();
        }

        string PrepareMailSubject(EmailConstant emailConstant, string sessionTitle)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.PayslipEmailSubject);
            subject.Append("\"");
            subject.Append(sessionTitle);
            subject.Append("\"");
            return subject.ToString();
        }

        string PrepareMailBody(EmailConstant emailConstant, string msg, string link)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.SharingDocumentEmailTemplate);
            body = body.Replace("{MESSAGE}", msg, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LINK}", link, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        public DataSourceResult<PayslipViewModel> GetPayslipHistory(PredicateFormatViewModel predicate, DateTime startDate, DateTime endDate)
        {
            DataSourceResult<PayslipViewModel> dataSourceResult = new DataSourceResult<PayslipViewModel>();
            IList<Payslip> entities = GetPayslipsOfSelectedEmployee(predicate, startDate, endDate);
            dataSourceResult.data = entities.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).
                    Take(predicate.pageSize).Select(_builder.BuildEntity).ToList();
            dataSourceResult.total = entities.Count;
            return dataSourceResult;
        }

        private IList<Payslip> GetPayslipsOfSelectedEmployee(PredicateFormatViewModel predicate, DateTime startDate, DateTime endDate)
        {
            startDate = startDate.FirstDateOfMonth();
            endDate = endDate.LastDateOfMonth();
            // Prepare the predicate
            PredicateFilterRelationViewModel<Payslip> predicateFilterRelationModel = PreparePredicate(predicate);
            // Prepare expression
            Expression<Func<Payslip, bool>> expression = x => x.Month.Date.BetweenDateLimitIncluded(startDate, endDate);
            // Combine expression and predicate condition
            ParameterExpression param = Expression.Parameter(typeof(Payslip), "x");
            BinaryExpression body = Expression.AndAlso(Expression.Invoke(predicateFilterRelationModel.PredicateWhere, param),
                Expression.Invoke(expression, param));
            predicateFilterRelationModel.PredicateWhere = Expression.Lambda<Func<Payslip, bool>>(body, param);

            IList<Payslip> payslips = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicate.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            return payslips;
        }

        /// <summary>
        /// Calculate loan 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public List<SalaryRuleViewModel> CalculateLoan(PayslipViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            List<SalaryRuleViewModel> salaryRuleViewModels = new List<SalaryRuleViewModel>();
            //Get loan assciated to employee
            List<LoanInstallment> loanInstallments = _loanInstallmentRepository.QuerableGetAll().Include(n => n.IdLoanNavigation).Where(x => x.IdLoanNavigation.IdEmployee == model.IdEmployee
               && x.Month.FirstDateOfMonth().EqualsDate(model.Month)).ToList();
            if (loanInstallments != null && loanInstallments.Count > NumberConstant.Zero)
            {
                loanInstallments.ForEach(loanInstallment =>
                {
                    // 
                    // Get session loan installment associated to loan installment
                    List<SessionLoanInstallment> sessionLoanInstallment = _repoSessionLoanInstallment.FindByAsNoTracking(x => x.IdSession == model.IdSession && x.IdLoanInstallment == loanInstallment.Id
                       && x.IdContract == model.IdContract).ToList();
                    if (sessionLoanInstallment != null && sessionLoanInstallment.Count > NumberConstant.Zero)
                    {
                        double sum = _repoSessionLoanInstallment.FindByAsNoTracking(x => x.IdLoanInstallment == loanInstallment.Id).Sum(x => x.Value);
                        SalaryRuleViewModel salaryRuleViewModel = _salaryRuleBuilder.BuildSalaryRuleLoan(loanInstallment);
                        salaryRuleViewModel.Rule = Convert.ToString(sessionLoanInstallment.FirstOrDefault(x => x.IdContract == model.IdContract).Value, frCulture);
                        CalculateLoanValue(model, salaryRuleViewModel);
                        salaryRuleViewModels.Add(salaryRuleViewModel);
                        loanInstallment.State = sum.IsApproximately(loanInstallment.Amount) ? (int)LoanInstallmentEnumerator.Paid : (int)LoanInstallmentEnumerator.PartiallyPaid;
                    }
                });
                loanInstallments.Select(x => { x.PayslipDetails = null; x.SessionLoanInstallment = null; return x; }).ToList();
                _loanInstallmentRepository.BulkUpdate(loanInstallments);
                _unitOfWork.Commit();
            }
            return salaryRuleViewModels;
        }

        /// <summary>
        /// Calculate value of the installment of the loan 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="salaryRuleViewModel"></param>
        /// <returns></returns>
        public void CalculateLoanValue(PayslipViewModel model, SalaryRuleViewModel salaryRuleViewModel)
        {
            // Tokenize the rule (Construct a queue)
            Queue<TokenViewModel> rule = _lexicalAnalyzer.LexerForExcecution(salaryRuleViewModel.Rule);
            // Parser the queue in AST, Abstract Syntactic Tree     
            SubTreeViewModel ast = _syntacticAnalyzer.Parse(rule);
            salaryRuleViewModel.ParsedSalaryRule = ast.DeepCopyByExpressionTree();
            double NumberDaysWorked = model.NumberDaysWorked + model.NumberDaysPaidLeave;
            // Execute the ast 
            Dictionary<string, double> result = _semanticAnalyzer.Execute(ast, model.IdEmployee, model.IdContract, model.Month, salaryRuleViewModel, NumberDaysWorked);
            salaryRuleViewModel.Rules = new Dictionary<string, dynamic>
            {
                [PayRollConstant.Salary] = result["Salary"]
            };
            _semanticAnalyzer.SetValueInBuffer(salaryRuleViewModel);
        }


        /// <summary>
        /// calculate the round of the value with currency precision
        /// </summary>
        /// <param name="valueToRound"></param>
        /// <returns></returns>
        public double PayrollRound(double valueToRound)
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            CurrencyViewModel currencyViewModel = _serviceCurrency.GetModel(x => x.Id == companyViewModel.IdCurrency);
            return Math.Round(valueToRound, currencyViewModel.Precision);
        }

        /// <summary>
        /// Check if there are source deductions to delete
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public bool CheckIfThereAreSourceDeductionsToDelete(int idSession)
        {
            List<Payslip> payslips = _entityRepo.FindByAsNoTracking(x => x.IdSession == idSession).ToList();
            List<int> employeesIds = payslips.Select(x => x.IdEmployee).Distinct().ToList();
            return payslips.Any() && _sourceDeductionSessionRepo.FindByAsNoTracking(x => x.Year == payslips.FirstOrDefault().Month.Year
                && x.SourceDeductionSessionEmployee.Any(y => employeesIds.Contains(y.IdEmployee))).Any();
        } 
        #endregion
    }
}
