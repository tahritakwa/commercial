using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes.ServiceContract
{
    public partial class ServiceContract : Service<ContractViewModel, Contract>, IServiceContract
    {
        internal readonly IServiceContractBonus _serviceContractBonus;
        internal readonly IServiceInformation _serviceInformation;
        internal readonly IServiceMessage _serviceMessage;
        internal readonly IServiceMsgNotification _serviceMessageNotification;
        internal readonly IRepository<Employee> _employeeRepo;
        internal readonly IServiceContractBenefitInKind _serviceContractBenefitInKind;
        internal readonly IServiceBaseSalary _serviceBaseSalary;
        internal readonly IBaseSalaryBuilder _baseSalaryBuilder;
        private readonly IRepository<TimeSheet> _repoTimeSheet;
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IServiceUserPrivilege _serviceUserPrivilege;
        private readonly IRepository<Payslip> _repoPayslip;
        private readonly IServiceUserReduce _serviceUserReduce;
        private readonly IServicePeriod _servicePeriod;
        private readonly IRepository<Session> _repoSession;
        private readonly IRepository<ContractType> _entityRepoContractType;
        public ServiceContract(IRepository<Contract> entityRepo,
            IRepository<Payslip> repoPayslip,
            IServiceUserReduce serviceUser,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            IContractBuilder builder, IRepository<Entity> entityRepoEntity,
            IServiceContractBonus serviceContractPremium,
            IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
            IRepository<EntityCodification> entityRepoEntityCodification, IServiceMsgNotification serviceMessageNotification,
            IRepository<Codification> entityRepoCodification, IServiceInformation serviceInformation, IServiceMessage serviceMessage, IRepository<Employee> employeeRepo
            , IServiceContractBenefitInKind serviceContractBenefitInKind, IServiceBaseSalary serviceBaseSalary, IBaseSalaryBuilder baseSalaryBuilder, IEmployeeBuilder employeeBuilder,
            IRepository<TimeSheet> repoTimeSheet, IServiceUserPrivilege serviceUserPrivilege, IServicePeriod servicePeriod, IRepository<Session> repoSession, IRepository<ContractType> entityRepoContractType)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceContractBonus = serviceContractPremium;
            _serviceInformation = serviceInformation;
            _serviceMessage = serviceMessage;
            _serviceMessageNotification = serviceMessageNotification;
            _employeeRepo = employeeRepo;
            _serviceContractBenefitInKind = serviceContractBenefitInKind;
            _serviceBaseSalary = serviceBaseSalary;
            _baseSalaryBuilder = baseSalaryBuilder;
            _repoTimeSheet = repoTimeSheet;
            _repoPayslip = repoPayslip;
            _employeeBuilder = employeeBuilder;
            _serviceUserReduce = serviceUser;
            _serviceUserPrivilege = serviceUserPrivilege;
            _servicePeriod = servicePeriod;
            _repoSession = repoSession;
            _entityRepoContractType = entityRepoContractType;
        }

        public override object AddModelWithoutTransaction(ContractViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                Employee employee = _employeeRepo.GetAllAsNoTracking()
                    .Include(x => x.Contract).ThenInclude(e => e.BaseSalary)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBenefitInKind)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBonus)
                    .Where(x => x.Id == model.IdEmployee).FirstOrDefault();
                EmployeeViewModel employeeView = _employeeBuilder.BuildEntity(employee);
                ManageFileContract(model, employee.FullName);
                DateTime hiringDate = SetHiringDate(employee, model);
                ContractViewModel contractViewModel = ContractValidation(employeeView.Contract, model);
                SetBonusAndBeneFitInKindEndDates(contractViewModel);
                contractViewModel.State = (int)ContractStateEnumerator.New;
                Contract entity = _builder.BuildModel(contractViewModel);
                entity.ContractReference = UpdateCodification(entity, null);
                // Update payslips and timeSheets if requested
                if (contractViewModel.UpdatePayslipAndTimeSheets)
                {
                    UpdateContractAssociateWithPayslipOrTimesheet(new List<Contract> { entity }, hiringDate);
                }
                // add entity
                _entityRepo.Add(entity);
                _unitOfWork.Commit();
                // add entityAxesValues
                AddEntityAxesValues(entityAxisValuesModelList, entity.Id, userMail);
                _unitOfWork.Commit();
                if (GetPropertyName(entity) != null)
                {
                    return new CreatedDataViewModel { Id = entity.Id, Code = getModelCode(entity, GetPropertyName(entity)) };
                }
                return new CreatedDataViewModel { Id = entity.Id };
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        public override object UpdateModelWithoutTransaction(ContractViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                Employee employee = _employeeRepo.GetAllAsNoTracking()
                    .Include(x => x.Contract).ThenInclude(e => e.BaseSalary)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBenefitInKind)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBonus)
                    .Where(x => x.Id == model.IdEmployee).FirstOrDefault();
                EmployeeViewModel employeeView = _employeeBuilder.BuildEntity(employee);
                ManageFileContract(model, employee.FullName);
                DateTime hiringDate = SetHiringDate(employee, model);
                // Assign existing values for items that the user does not have access to
                SetContractRemunerationsOldValues(model, employeeView.Contract.FirstOrDefault(x => x.Id == model.Id));
                ContractViewModel contractViewModel = ContractValidation(employeeView.Contract, model);
                SetBonusAndBeneFitInKindEndDates(contractViewModel);
                Contract entity = _builder.BuildModel(contractViewModel);
                if (model.State == (int)ContractStateEnumerator.Expired && !new ContractComparer().Equals(entity, employee.Contract.FirstOrDefault(x => x.Id == model.Id)))
                {
                    throw new CustomException(CustomStatusCode.ContractUpdateCheck);
                }
                // Generate Contracts Codification for new contracts
                if (string.IsNullOrEmpty(entity.ContractReference))
                {
                    entity.ContractReference = UpdateCodification(entity, null);
                }
                // Update payslips and timeSheets if requested
                if (contractViewModel.UpdatePayslipAndTimeSheets)
                {
                    UpdateContractAssociateWithPayslipOrTimesheet(new List<Contract> { entity }, hiringDate);
                }
                UpdateCollections(entity, userMail);
                // update entity
                _entityRepo.Update(entity);
                // commit 
                _unitOfWork.Commit();
                return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }

        /// <summary>
        /// Set bonus end date with contract end date
        /// </summary>
        /// <param name="contract"></param>
        public void SetBonusAndBeneFitInKindEndDates(ContractViewModel contract)
        {
            if (contract.EndDate.HasValue)
            {
                if (contract.ContractBonus != null)
                {
                    contract.ContractBonus.Where(x => !x.ValidityEndDate.HasValue).Select(x => { x.ValidityEndDate = contract.EndDate; return x; }).ToList();
                }
                if (contract.ContractBenefitInKind != null)
                {
                    contract.ContractBenefitInKind.Where(x => !x.ValidityEndDate.HasValue).Select(x => { x.ValidityEndDate = contract.EndDate; return x; }).ToList();
                }
            }
        }



        /// <summary>
        /// Update timesheets or payslips
        /// </summary>
        /// <param name="listContracts"></param>
        /// <param name="hiringDate"></param>
        public void UpdateContractAssociateWithPayslipOrTimesheet(IList<Contract> listContracts, DateTime hiringDate)
        {
            ObjectToSaveViewModel objectToSaveViewModel = CheckIfContractsHasAnyPayslipOrTimesheet(listContracts, hiringDate);
            IList<Payslip> payslips = objectToSaveViewModel.model.Payslip;
            IList<TimeSheet> timesheets = objectToSaveViewModel.model.TimeSheet;
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Contract)}
                    };
                    throw new CustomException(CustomStatusCode.CantUpdateEntityBecauseAnyPayslipIsUsedInClosedSesion, errorParams);
                }
                DateTime minStartDate = listContracts.Min(x => x.StartDate);
                payslips = payslips.Select(x => { x.Status = (int)PayslipStatus.Wrong; return x; }).ToList();
                UpdateSessionsIfThereArePayslipsToDelete(payslips, minStartDate, listContracts.Where(x => x.Id != NumberConstant.Zero).ToList());
                _unitOfWork.Commit();
            }
            if (timesheets.Any())
            {
                //if (timesheets.Any(x => x.Document.Any()))
                //{
                //    throw new CustomException(CustomStatusCode.CANNOT_UPDATE_BECAUSE_INVOICED_TIMEHSEET_EXIST);
                //}
                timesheets.Select(x => { x.Status = (int)TimeSheetStatusEnumerator.ToReWork; return x; }).ToList();
                _repoTimeSheet.BulkUpdate(timesheets);
                _unitOfWork.Commit();
            }
        }

        private void UpdateSessionsIfThereArePayslipsToDelete(IList<Payslip> payslips, DateTime minStartDate, List<Contract> listContracts)
        {
            // Get sessions to update
            List<Session> sessions = _repoSession.GetAllWithConditionsRelationsQueryableAsNoTracking(x => payslips.Any(y => y.IdSession == x.Id),
                x => x.SessionContract,
                x => x.SessionBonus,
                x => x.Attendance,
                x => x.SessionLoanInstallment)
                .Include(x => x.Payslip)
                .ThenInclude(x => x.PayslipDetails).ToList();
            DateTime? maxEndDate = listContracts.Any(x => x.EndDate.HasValue) ? listContracts.Max(x => x.EndDate.Value) : (DateTime?)null;
            // Get payslips to delete
            List<Payslip> payslipsToDelete = payslips.Where(x => x.Month.BeforeDate(minStartDate.FirstDateOfMonth())
                || (maxEndDate.HasValue && x.Month.AfterDate(maxEndDate.Value.FirstDateOfMonth()))).ToList();
            List<int> sessionsToUpdate = payslipsToDelete.Select(x => x.IdSession).ToList();
            List<Session> sessionsToDeleteOrUpdate = sessions.Where(x => sessionsToUpdate.Contains(x.Id)).ToList();
            List<Session> sessionsOfAttendancesToUpdate = sessions.Where(x => !sessionsToUpdate.Contains(x.Id)).ToList();
            // If there are attendances to update, we update the MaxNumberOfDaysAllowed
            if (sessionsOfAttendancesToUpdate.Any())
            {
                sessionsOfAttendancesToUpdate.ForEach(session =>
                {
                    session.Attendance.Where(x => listContracts.Any(y => y.Id == x.IdContract)).ToList().ForEach(attendance =>
                    {
                        Contract currentContract = listContracts.FirstOrDefault(x => x.Id == attendance.IdContract);
                        if (session.DependOnTimesheet)
                        {
                            DateTime startDate = currentContract.StartDate.BeforeDateLimitIncluded(session.Month.FirstDateOfMonth())
                                ? session.Month.FirstDateOfMonth() : currentContract.StartDate;
                            DateTime endDate = currentContract.EndDate.HasValue && currentContract.EndDate.Value.BeforeDateLimitIncluded(session.Month.LastDateOfMonth())
                                ? currentContract.EndDate.Value : session.Month.LastDateOfMonth();
                            bool workedEntireMonth = startDate.EqualsDate(session.Month.FirstDateOfMonth()) && endDate.EqualsDate(session.Month.LastDateOfMonth());
                            attendance.MaxNumberOfDaysAllowed = workedEntireMonth ? session.DaysOfWork : _servicePeriod.NumberOfDaysWorkedCompanyBetweenDates(startDate, endDate);
                        }
                        else
                        {
                            int numberOfDaysFromStartDate = currentContract.StartDate.Month == attendance.StartDate.Value.Month && attendance.StartDate.Value.Year == currentContract.StartDate.Year
                                ? attendance.StartDate.Value.Day - currentContract.StartDate.Day : attendance.StartDate.Value.Day - NumberConstant.One;
                            int numberOfDaysFromEndDate = currentContract.EndDate.HasValue && currentContract.EndDate.Value.Month == attendance.EndDate.Value.Month
                                && attendance.EndDate.Value.Year == currentContract.EndDate.Value.Year ? currentContract.EndDate.Value.Day - attendance.EndDate.Value.Day :
                                attendance.EndDate.Value.LastDateOfMonth().Day - attendance.EndDate.Value.Day;
                            attendance.MaxNumberOfDaysAllowed += numberOfDaysFromStartDate + numberOfDaysFromEndDate;
                            attendance.MaxNumberOfDaysAllowed = attendance.MaxNumberOfDaysAllowed > session.DaysOfWork ? session.DaysOfWork : attendance.MaxNumberOfDaysAllowed;
                        }
                        attendance.StartDate = attendance.StartDate.Value.Month == currentContract.StartDate.Month && attendance.StartDate.Value.Year == currentContract.StartDate.Year ?
                            currentContract.StartDate : attendance.StartDate.Value.FirstDateOfMonth();
                        attendance.EndDate = currentContract.EndDate.HasValue && attendance.EndDate.Value.Month == currentContract.EndDate.Value.Month
                            && attendance.EndDate.Value.Year == currentContract.EndDate.Value.Year ? currentContract.EndDate : attendance.EndDate.Value.LastDateOfMonth();
                    });
                });
            }
            sessionsOfAttendancesToUpdate.Select(x => { x.Payslip = null; x.SessionBonus = null; x.SessionContract = null; x.SessionLoanInstallment = null; return x; }).ToList();
            // If there are any sessions to delete or sessions entities to delete
            if (sessionsToDeleteOrUpdate.Any())
            {
                // Check if sessions contains only one payslip
                if (sessionsToDeleteOrUpdate.Any(y => y.Payslip.Count == NumberConstant.One))
                {
                    sessionsToDeleteOrUpdate.Where(y => y.Payslip.Count == NumberConstant.One).Select(x => { x.IsDeleted = true; return x; }).ToList();
                }
                List<int> contractsToDelete = payslipsToDelete.Select(x => x.IdContract).ToList();
                sessionsToDeleteOrUpdate.ForEach(session =>
                {
                    session.SessionContract.Where(x => contractsToDelete.Contains(x.IdContract)).Select(x => { x.IsDeleted = true; return x; }).ToList();
                    session.Attendance.Where(x => contractsToDelete.Contains(x.IdContract)).Select(x => { x.IsDeleted = true; return x; }).ToList();

                    session.Payslip.Where(x => contractsToDelete.Contains(x.IdContract)).Select(x =>
                    {
                        x.IsDeleted = true;
                        x.PayslipDetails.Select(y => { y.IsDeleted = true; return y; }).ToList(); return x;
                    }).ToList();
                    if (session.SessionBonus.Any(x => contractsToDelete.Contains(x.IdContract)))
                    {
                        session.SessionBonus.Where(x => contractsToDelete.Contains(x.IdContract)).Select(x => { x.IsDeleted = true; return x; }).ToList();
                    }
                    if (session.SessionLoanInstallment.Any(x => contractsToDelete.Contains(x.IdContract)))
                    {
                        session.SessionLoanInstallment.Where(x => contractsToDelete.Contains(x.IdContract)).Select(x => { x.IsDeleted = true; return x; }).ToList();
                    }
                });
            }
            sessionsToDeleteOrUpdate.AddRange(sessionsOfAttendancesToUpdate);
            _repoSession.BulkUpdate(sessionsToDeleteOrUpdate);
            List<Payslip> payslipsWithNoSessionsToUpdate = payslips.Where(x => x.Month.AfterDateLimitIncluded(minStartDate.FirstDateOfMonth())
                && (!maxEndDate.HasValue || (maxEndDate.HasValue && x.Month.BeforeDateLimitIncluded(maxEndDate.Value.FirstDateOfMonth())))).ToList();
            if (payslipsWithNoSessionsToUpdate.Any())
            {
                _repoPayslip.BulkUpdate(payslipsWithNoSessionsToUpdate);
            }
        }


        public IList<ContractViewModel> GenerateContractListFromExcel(Stream excelDataStream)
        {
            return GenerateListFromExcel(excelDataStream, "MatriculeEmployee", null, NumberConstant.One);
        }

        /// <summary>
        /// Update hiring date to check if there is any changes before uodate and notify user
        /// </summary>
        /// <param name="listContracts"></param>
        /// <param name="isFromContract"></param>
        public ObjectToSaveViewModel CheckBeforeUpdateIfContractsHaveAnyPayslipOrTimesheet(IList<Contract> listContracts, bool isFromContract)
        {
            DateTime hiringDate = default;
            if (listContracts.Count > NumberConstant.Zero)
            {
                if (isFromContract)
                {
                    Contract contract = listContracts.FirstOrDefault();
                    List<Contract> employeeContracts = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdEmployee == contract.IdEmployee && x.Id != contract.Id).ToList();
                    hiringDate = employeeContracts.Count > NumberConstant.Zero ? new DateTime(Math.Min(employeeContracts.Min(x => x.StartDate).Date.Ticks, contract.StartDate.Date.Ticks)) :
                        new DateTime(contract.StartDate.Ticks);
                }
                else
                {
                    hiringDate = new DateTime(listContracts.Min(x => x.StartDate).Date.Ticks);
                }
            }
            return CheckIfContractsHasAnyPayslipOrTimesheet(listContracts, hiringDate);
        }

        /// <summary>
        /// Check if there are any payslips or timesheets
        /// </summary>
        /// <param name="listContracts"></param>
        /// <param name="hiringDate"></param>
        /// <returns></returns>
        public ObjectToSaveViewModel CheckIfContractsHasAnyPayslipOrTimesheet(IList<Contract> listContracts, DateTime hiringDate)
        {
            ObjectToSaveViewModel objectToSaveViewModel = new ObjectToSaveViewModel
            {
                model = new ExpandoObject()
            };
            objectToSaveViewModel.model.TimeSheet = new List<TimeSheet>();
            objectToSaveViewModel.model.Payslip = new List<Payslip>();
            if (listContracts.Count > NumberConstant.Zero)
            {
                List<Payslip> payslips = new List<Payslip>();
                // List of contracts beforeUpdate
                IList<Contract> contractBeforeUpdates = _entityRepo.GetAllAsNoTracking()
                        .Include(x => x.BaseSalary)
                        .Include(x => x.ContractBenefitInKind)
                        .Include(x => x.ContractBonus)
                        .Where(x => listContracts.Select(c => c.Id).Contains(x.Id)).ToList();


                contractBeforeUpdates.ToList().ForEach(oldContract =>
                {

                });
                listContracts.ToList().ForEach(contract =>
                {
                    Contract contractBeforeUpdate = contractBeforeUpdates.FirstOrDefault(x => x.Id == contract.Id);
                    // Assign existing values for items that the user does not have access to
                    SetContractRemunerationsOldValues(contract, contractBeforeUpdate);
                    // Get timesheets to update
                    objectToSaveViewModel.model.TimeSheet = GetTimesheetsToUpdate(contract, contractBeforeUpdate, hiringDate);
                    if (objectToSaveViewModel.model.TimeSheet != null && objectToSaveViewModel.model.TimeSheet.Count > NumberConstant.Zero)
                    {
                        objectToSaveViewModel.model.TimeSheet = SetTimesheetLinesOfTimesheetsToUpdate(objectToSaveViewModel.model.TimeSheet, hiringDate);
                    }
                    if (contractBeforeUpdate != null)
                    {
                        // A date interval collection to contain the date intervals in which the generated payslips are corrupted
                        List<DateInterval> dateIntervals = new List<DateInterval>();
                        // For new base salaries added, retrieve date intervals with existing payslips
                        BaseSalaryChek(contract.BaseSalary.Where(x => x.Id == NumberConstant.Zero).ToList(), contractBeforeUpdate.BaseSalary.ToList(), dateIntervals);
                        // For new bonuses added, retrieve date intervals with existing payslips
                        ContractBonusChek(contract.ContractBonus.Where(x => x.Id == NumberConstant.Zero).ToList(), contractBeforeUpdate.ContractBonus.ToList(), dateIntervals);
                        // For new benefits in kind added, retrieve date intervals with existing payslips
                        ContractBenefitInKindChek(contract.ContractBenefitInKind.Where(x => x.Id == NumberConstant.Zero).ToList(), contractBeforeUpdate.ContractBenefitInKind.ToList(), dateIntervals);
                        // For existing base salaries modified or deleted, retrieve date intervals with existing payslips
                        BaseSalaryChek(contract.BaseSalary.Except(contractBeforeUpdate.BaseSalary, new BaseSalaryComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), contractBeforeUpdate.BaseSalary.ToList(), dateIntervals);
                        // For existing bonuses modified or deleted, retrieve date intervals with existing payslips
                        ContractBonusChek(contract.ContractBonus.Except(contractBeforeUpdate.ContractBonus, new ContractBonusComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), contractBeforeUpdate.ContractBonus.ToList(), dateIntervals);
                        // For existing benefits in kind modified or deleted, retrieve date intervals with existing payslips
                        ContractBenefitInKindChek(contract.ContractBenefitInKind.Except(contractBeforeUpdate.ContractBenefitInKind, new ContractBenefitInKindComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), contractBeforeUpdate.ContractBenefitInKind.ToList(), dateIntervals);
                        // If a contract property used in the Payroll calculation has been modified, retrieve the contract date range from the start date to the end date
                        if (!new ContractForPayslipComparer().Equals(contract, contractBeforeUpdate))
                        {
                            DateInterval dateInterval = contractBeforeUpdate.EndDate.HasValue ?
                                new DateInterval(contractBeforeUpdate.StartDate.FirstDateOfMonth(), contractBeforeUpdate.EndDate.Value) :
                                new DateInterval(contractBeforeUpdate.StartDate.FirstDateOfMonth());
                            dateIntervals.Add(dateInterval);
                        }
                        ContractStartDateAndEndDateCheck(contract, contractBeforeUpdate, dateIntervals);
                        // Retrieve the list of payslips corrupted by the changes
                        payslips.AddRange(_repoPayslip.GetAllWithRelations(x => x.IdSessionNavigation).AsEnumerable()
                            .Where(x => x.IdContract == contract.Id && dateIntervals.Any(d =>
                            d.EndDate.HasValue && x.Month.BetweenDateLimitIncluded(d.StartDate, d.EndDate.Value) ||
                            !d.EndDate.HasValue && x.Month.AfterDateLimitIncluded(d.StartDate))));
                    }
                });
                if (payslips.Count > NumberConstant.Zero)
                {
                    payslips.Select(x => { x.IdSessionNavigation.Payslip = null; return x; }).ToList();
                }
                objectToSaveViewModel.model.Payslip = payslips;
            }
            return objectToSaveViewModel;
        }

        /// <summary>
        /// Add dateIntervals if the contract start date or end date have changed
        /// </summary>
        /// <param name="contract"></param>
        /// <param name="contractBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void ContractStartDateAndEndDateCheck(Contract contract, Contract contractBeforeUpdate, List<DateInterval> dateIntervals)
        {
            if (!contract.StartDate.EqualsDate(contractBeforeUpdate.StartDate))
            {
                DateTime min = contract.StartDate.BeforeDate(contractBeforeUpdate.StartDate) ? contract.StartDate.Date : contractBeforeUpdate.StartDate.Date;
                DateTime max = contract.StartDate.AfterDate(contractBeforeUpdate.StartDate) ? contract.StartDate.Date : contractBeforeUpdate.StartDate.Date;
                DateInterval dateInterval = new DateInterval(min.FirstDateOfMonth(), max.LastDateOfMonth());
                dateIntervals.Add(dateInterval);
            }
            if (contract.EndDate.HasValue && contractBeforeUpdate.EndDate.HasValue && !contract.EndDate.Value.EqualsDate(contractBeforeUpdate.EndDate.Value))
            {
                DateTime min = contract.EndDate.Value.BeforeDate(contractBeforeUpdate.EndDate.Value) ? contract.EndDate.Value.Date : contractBeforeUpdate.EndDate.Value.Date;
                DateTime max = contract.EndDate.Value.AfterDate(contractBeforeUpdate.EndDate.Value) ? contract.EndDate.Value.Date : contractBeforeUpdate.EndDate.Value.Date;
                DateInterval dateInterval = new DateInterval(min.FirstDateOfMonth(), max);
                dateIntervals.Add(dateInterval);
            }
            else if (contract.EndDate.HasValue && !contractBeforeUpdate.EndDate.HasValue)
            {
                DateInterval dateInterval = new DateInterval(contract.EndDate.Value.FirstDateOfMonth(), contract.EndDate.Value.Date);
                dateIntervals.Add(dateInterval);
            }
            else if (!contract.EndDate.HasValue && contractBeforeUpdate.EndDate.HasValue)
            {
                DateInterval dateInterval = new DateInterval(contractBeforeUpdate.EndDate.Value.FirstDateOfMonth(), contractBeforeUpdate.EndDate.Value.Date);
                dateIntervals.Add(dateInterval);
            }
        }
        /// <summary>
        /// Get timesheets to update
        /// </summary>
        /// <param name="contract"></param>
        /// <param name="contractBeforeUpdate"></param>
        /// <returns></returns>
        private List<TimeSheet> GetTimesheetsToUpdate(Contract contract, Contract contractBeforeUpdate, DateTime hiringDate)
        {
            List<TimeSheet> timesheets = new List<TimeSheet>();
            if ((contractBeforeUpdate != null && !contract.StartDate.EqualsDate(contractBeforeUpdate.StartDate)) || contractBeforeUpdate == null)
            {
                // If contract already exists, take hiring date as start month otherwise start month should be contract start date
                DateTime startMonth = contractBeforeUpdate != null ? hiringDate : contract.StartDate;
                // If contract already exists, end date should be contract end date, otherwise if contract has end date, end month would be the contract end date
                // and in case there is no end date, end month would be contract start date
                DateTime endMonth = contractBeforeUpdate != null ? contractBeforeUpdate.StartDate : contract.EndDate.HasValue ? contract.EndDate.Value : contract.StartDate;
                IList<DateTime> monthsToUpdate = startMonth.GetFirstDatesOfMonths(endMonth);
                timesheets = _repoTimeSheet.GetAllWithConditionsRelationsAsNoTracking(x => monthsToUpdate.Contains(x.Month) && x.IdEmployee == contract.IdEmployee,
                    x => x.TimeSheetLine // x => x.Document
                    ).ToList();
            }
            return timesheets;
        }

        private List<TimeSheet> SetTimesheetLinesOfTimesheetsToUpdate(List<TimeSheet> timesheets, DateTime hiringDate)
        {
            timesheets.ToList().ForEach(timesheet =>
            {
                PeriodViewModel period = _servicePeriod.GetModelWithRelationsAsNoTracked(x => timesheet.Month.BetweenDateLimitIncluded(x.StartDate, x.EndDate), x => x.Hours);
                List<TimeSheetLine> timeSheetLines = new List<TimeSheetLine>();
                DateTime firstDay = timesheet.TimeSheetLine.Min(x => x.Day);
                if (!firstDay.Equals(hiringDate))
                {
                    if (firstDay.AfterDate(hiringDate))
                    {
                        if (!firstDay.Equals(firstDay.FirstDateOfMonth()))
                        {
                            List<DateTime> dates = new List<DateTime>();
                            if (hiringDate.FirstDateOfMonth().EqualsDate(timesheet.Month))
                            {
                                dates = hiringDate.AllDatesUntilLimitIncluded(firstDay.AddDays(NumberConstant.MinusOne)).ToList();
                            }
                            else
                            {
                                dates = timesheet.Month.AllDatesUntilLimitIncluded(firstDay.AddDays(NumberConstant.MinusOne)).ToList();
                            }
                            dates.ForEach(date =>
                            {
                                TimeSheetLine line = new TimeSheetLine
                                {
                                    Day = date,
                                    IdProject = null,
                                    IdTimeSheet = timesheet.Id,
                                    StartTime = period.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime,
                                    EndTime = period.LastDayOfWork >= (int)date.DayOfWeek && period.FirstDayOfWork <= (int)date.DayOfWeek ? period.Hours.OrderByDescending(x => x.EndTime).FirstOrDefault().EndTime
                                            : period.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime,
                                    Valid = false
                                };
                                timeSheetLines.Add(line);
                            });
                        }
                    }
                    else
                    {
                        List<TimeSheetLine> linesToDelete = timesheet.TimeSheetLine.Where(x => x.Day.BeforeDate(hiringDate)).Select(x => { x.IsDeleted = true; return x; }).ToList();
                        if (linesToDelete.Count == timesheet.TimeSheetLine.Count)
                        {
                            timesheet.IsDeleted = true;
                        }
                        else
                        {
                            timesheet.TimeSheetLine = linesToDelete;
                        }
                    }
                    timeSheetLines.ForEach(line =>
                    {
                        timesheet.TimeSheetLine.Add(line);
                    });
                }
            });
            timesheets.Select(x =>
            {
                x.TimeSheetLine.Select(y => { y.IdTimeSheetNavigation = null; return y; }).ToList(); return x;
                //x.Document.Select(y => { y.IdTimeSheetNavigation = null; return y; }).ToList(); 
            }).ToList();
            return timesheets;
        }

        /// <summary>
        /// Récupère la liste des intervalle de dates des concernés par les modifications de salaire de base
        /// </summary>
        /// <param name="referencedBaseSalaries"></param>
        /// <param name="baseSalariesBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void BaseSalaryChek(List<BaseSalary> referencedBaseSalaries, List<BaseSalary> baseSalariesBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedBaseSalaries.ForEach(baseSalaryAfterUpdate =>
            {
                // The existing baseSalary defined after the baseSalary (added or modified)
                BaseSalary baseSalary = baseSalariesBeforeUpdate.Where(x => x.Id != baseSalaryAfterUpdate.Id && x.StartDate.AfterDate(baseSalaryAfterUpdate.StartDate)).OrderBy(x => x.StartDate).FirstOrDefault();
                // The current baseSalary before it's update
                BaseSalary baseSalaryBeforeUpdate = baseSalariesBeforeUpdate.FirstOrDefault(x => x.Id == baseSalaryAfterUpdate.Id);
                // By default, the start are equal to the modified or added baseSalary startDate
                DateTime startDate = baseSalaryAfterUpdate.StartDate;
                if (baseSalaryBeforeUpdate != null)
                {
                    startDate = baseSalaryBeforeUpdate.StartDate.BeforeDate(baseSalaryAfterUpdate.StartDate) ?
                            baseSalaryBeforeUpdate.StartDate : baseSalaryAfterUpdate.StartDate;
                }
                // The start date of the interval is the date of the baseSalary (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth());
                // If a following baseSalary is defined, take its start date as the end date of the interval
                if (baseSalary != null)
                {
                    dateInterval.EndDate = baseSalary.StartDate.LastDateOfMonth();
                }
                dateIntervals.Add(dateInterval);
            });
        }

        /// <summary>
        /// Récupère la liste des intervalles de dates des concernés par les modifications de prime
        /// </summary>
        /// <param name="referencedContractBonuses"></param>
        /// <param name="contractBonusesBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void ContractBonusChek(List<ContractBonus> referencedContractBonuses, List<ContractBonus> contractBonusesBeforeUpdate, List<DateInterval> dateIntervals)
        {
            // Loop through the list of ContractBonus grouped by idBonus
            referencedContractBonuses.GroupBy(x => x.IdBonus).ToList().ForEach(bonusGrouped =>
            {
                bonusGrouped.ToList().ForEach(contractBonusAfterUpdate =>
                {
                    // The existing contractBonus defined after the contractBonus (added or modified)
                    ContractBonus nextContractBonus = contractBonusesBeforeUpdate.Where(x => x.IdBonus == contractBonusAfterUpdate.Id &&
                        x.ValidityStartDate.AfterDate(contractBonusAfterUpdate.ValidityStartDate)).OrderBy(p => p.ValidityStartDate).FirstOrDefault();
                    // By default, the start and end dates are equal to the modified or added contractBonus dates
                    DateTime startDate = contractBonusAfterUpdate.ValidityStartDate;
                    DateTime? endDate = contractBonusAfterUpdate.ValidityEndDate;
                    // The current contractBonus before it's update
                    ContractBonus contractBonusBeforeUpdate = contractBonusesBeforeUpdate.FirstOrDefault(x => x.IdBonus == contractBonusAfterUpdate.IdBonus && x.Id == contractBonusAfterUpdate.Id);
                    if (contractBonusBeforeUpdate != null)
                    {
                        startDate = contractBonusBeforeUpdate.ValidityStartDate.BeforeDate(contractBonusAfterUpdate.ValidityStartDate) ?
                            contractBonusBeforeUpdate.ValidityStartDate : contractBonusAfterUpdate.ValidityStartDate;
                        if (contractBonusBeforeUpdate.ValidityEndDate.HasValue)
                        {
                            if (contractBonusAfterUpdate.ValidityEndDate.HasValue)
                            {
                                endDate = contractBonusBeforeUpdate.ValidityEndDate.Value.AfterDate(contractBonusAfterUpdate.ValidityEndDate.Value) ?
                                    contractBonusBeforeUpdate.ValidityEndDate.Value.LastDateOfMonth() : contractBonusAfterUpdate.ValidityEndDate.Value.LastDateOfMonth();
                            }
                            else
                            {
                                endDate = null;
                            }
                        }
                        else
                        {
                            endDate = null;
                        }
                    }
                    // The start date of the interval
                    DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth(), endDate);
                    // If a following ContractBonus is defined, take its start date as the end date of the interval if the contractBonus (new or modified) does not have an end date
                    if (nextContractBonus != null && !dateInterval.EndDate.HasValue)
                    {
                        dateInterval.EndDate = nextContractBonus.ValidityStartDate;
                    }
                    dateIntervals.Add(dateInterval);
                });
            });
        }

        /// <summary>
        /// Récupère la liste des intervalles de dates des concernés par les modifications d'avantages en nature
        /// </summary>
        /// <param name="referencedContractBenefitInKinds"></param>
        /// <param name="dateIntervals"></param>
        private void ContractBenefitInKindChek(List<ContractBenefitInKind> referencedContractBenefitInKinds, List<ContractBenefitInKind> contractBenefitInKindsBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedContractBenefitInKinds.ForEach(benefitInKindAfterUpdate =>
            {
                // By default, the start are equal to the modified or added baseSalary startDate
                DateTime startDate = benefitInKindAfterUpdate.ValidityStartDate;
                DateTime? endDate = benefitInKindAfterUpdate.ValidityEndDate;
                // The current contractBenefitInKind before it's update
                ContractBenefitInKind ContractBenefitInKindBeforeUpdate = contractBenefitInKindsBeforeUpdate.FirstOrDefault(x => x.Id == benefitInKindAfterUpdate.Id);
                if (ContractBenefitInKindBeforeUpdate != null)
                {
                    startDate = ContractBenefitInKindBeforeUpdate.ValidityStartDate.BeforeDate(benefitInKindAfterUpdate.ValidityStartDate) ?
                            ContractBenefitInKindBeforeUpdate.ValidityStartDate : benefitInKindAfterUpdate.ValidityStartDate;

                    if (ContractBenefitInKindBeforeUpdate.ValidityEndDate.HasValue)
                    {
                        if (benefitInKindAfterUpdate.ValidityEndDate.HasValue)
                        {
                            endDate = ContractBenefitInKindBeforeUpdate.ValidityEndDate.Value.AfterDate(benefitInKindAfterUpdate.ValidityEndDate.Value) ?
                                ContractBenefitInKindBeforeUpdate.ValidityEndDate.Value.LastDateOfMonth() : benefitInKindAfterUpdate.ValidityEndDate.Value.LastDateOfMonth();
                        }
                        else
                        {
                            endDate = null;
                        }
                    }
                    else
                    {
                        endDate = null;
                    }
                }
                // The start date of the interval is the date of the baseSalary (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth(), endDate);
                dateIntervals.Add(dateInterval);
            });
        }

        /// <summary>
        /// Add or update or delete Users's contracts
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <param name="emlpoyeeBeforeUpdate"></param>
        public void ManageEmployeeContracts(EmployeeViewModel modelAfterUpdate, string userMail, EmployeeViewModel emlpoyeeBeforeUpdate)
        {
            if (emlpoyeeBeforeUpdate != null && emlpoyeeBeforeUpdate.Contract != null)
            {
                ICollection<ContractViewModel> contractsToDelete = emlpoyeeBeforeUpdate.Contract.Where(p => !modelAfterUpdate.Contract.Any(l => p.Id == l.Id)).ToList();
                foreach (ContractViewModel contract in contractsToDelete)
                {
                    DeleteModelwithouTransaction(contract.Id, nameof(Contract), userMail);
                }
            }
            CheckContractsOverLapping(modelAfterUpdate.Contract);
            foreach (ContractViewModel currentContract in modelAfterUpdate.Contract)
            {
                ValidateContractsDates(currentContract);
            }
        }

        /// <summary>
        /// Ensures that all the contract's constraints are respected
        /// </summary>
        /// <param name="oldContracts"></param>
        /// <param name="model"></param>
        /// <param name="employee"></param>
        /// <returns></returns>
        public ContractViewModel ContractValidation(ICollection<ContractViewModel> oldContracts, ContractViewModel model)
        {
            if ((bool)_entityRepoContractType.FindSingleBy(x => x.Id == model.IdContractType).HasEndDate && !model.EndDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.RequiredContractEndDate);
            }
            if (oldContracts != null && (oldContracts.Any(x => x.Id == model.Id) || model.Id == NumberConstant.Zero))
            {
                oldContracts = oldContracts.Where(x => x.Id != model.Id).ToList();
                oldContracts.Add(model);
                CheckContractsOverLapping(oldContracts);
            }
            ValidateContractsDates(model);
            return model;
        }

        /// <summary>
        /// Check the non overlapping of contracts and the non existence of two contracts with no end date
        /// </summary>
        /// <param name="contracts"></param>
        private void CheckContractsOverLapping(ICollection<ContractViewModel> contracts)
        {
            IList<ContractViewModel> contractsToCheck = contracts.Where(m => !m.IsDeleted).OrderBy(m => m.StartDate).ToList();
            if (contractsToCheck.Count(m => !m.EndDate.HasValue) > NumberConstant.One)
            {
                throw new CustomException(CustomStatusCode.MORE_THAN_ONE_CONTRACT_WITHOUT_ENDDATE);
            }
            if (contractsToCheck.Any(m => contractsToCheck.Any(n => m != n &&
                ((m.EndDate.HasValue && n.StartDate.BetweenDateLimitIncluded(m.StartDate, m.EndDate.Value)) ||
                (!m.EndDate.HasValue && m.StartDate.BeforeDateLimitIncluded(n.StartDate)))
                )))
            {
                throw new CustomException(CustomStatusCode.CONTRACT_OVERLAP);
            }
        }
        public void CheckContractsOverLappingFromExcel(ICollection<ContractViewModel> contracts)
        {
            IList<ContractViewModel> contractsToCheck = contracts.Where(m => !m.IsDeleted).OrderBy(m => m.StartDate).ToList();

            string matricule = contractsToCheck.FirstOrDefault(x => !string.IsNullOrEmpty(x.MatriculeEmployee)).MatriculeEmployee;

            if (contractsToCheck.Count(m => !m.EndDate.HasValue) > NumberConstant.One)
            {

                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.MATRICULE , matricule }
                    };
                throw new CustomException(CustomStatusCode.MORE_THAN_ONE_CONTRACT_WITHOUT_ENDDATE_WITH_PARAMS, paramtrs);
            }
            if (contractsToCheck.Any(m => contractsToCheck.Any(n => m != n &&
                ((m.EndDate.HasValue && n.StartDate.BetweenDateLimitIncluded(m.StartDate, m.EndDate.Value)) ||
                (!m.EndDate.HasValue && m.StartDate.BeforeDateLimitIncluded(n.StartDate)))
                )))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.MATRICULE , matricule }
                    };
                throw new CustomException(CustomStatusCode.CONTRACT_OVERLAP_WITH_PARAMS, paramtrs);

            }
        }

        /// <summary>
        /// Validate contract, with all base salary and contract bonus
        /// </summary>
        /// <param name="contract"></param>
        public void ValidateContractsDates(ContractViewModel contract)
        {
            if (contract.BaseSalary is null || !contract.BaseSalary.Any())
            {
                throw new CustomException(CustomStatusCode.BASE_SALARY_LACK);
            }
            if (contract.BaseSalary.Any(x => x.Value <= NumberConstant.Zero))
            {
                throw new CustomException(CustomStatusCode.BaseSalaryValue);
            }
            // If the contract has an end date and this date is less than the contract start date
            if (contract.EndDate.HasValue && contract.StartDate.AfterDateLimitIncluded(contract.EndDate.Value))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.SMALLEST_DATE, contract.StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture) },
                        { Constants.BIGGEST_DATE, contract.EndDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture) }
                    };
                throw new CustomException(CustomStatusCode.ContractDatesDependency, paramtrs);
            }

            // Prevent the addition of two base salaries at the same date
            if (contract.BaseSalary.Any(m => !m.IsDeleted &&
                contract.BaseSalary.Any(n => !n.IsDeleted && m != n && m.StartDate.EqualsDate(n.StartDate))))
            {
                throw new CustomException(CustomStatusCode.BASESALARY_STARTDATE_MUST_BE_UNIQUE);
            }

            // If the required BaseSalary have a start day different then the conract start date , throw exception
            if (!contract.StartDate.EqualsDate(contract.BaseSalary.Min(x => x.StartDate)))
            {
                throw new CustomException(CustomStatusCode.requiredBaseSalaryStartdate);
            }
            // If the startDate of the baseSalary is less than the startDate of the contract, throw exception
            BaseSalaryViewModel wrongBaseSalary = contract.BaseSalary.FirstOrDefault(m => !m.IsDeleted && m.StartDate.Date.BeforeDate(contract.StartDate.Date));
            if (wrongBaseSalary != null)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { Constants.BASE_SALARY_START_DATE, wrongBaseSalary.StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)},
                            { Constants.START_DATE, contract.StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                        };
                throw new CustomException(CustomStatusCode.AddBaseSalaryException, paramtrs);
            }

            // Group contract bonus by IdBonus
            IEnumerable<IGrouping<int, ContractBonusViewModel>> contractBonusViewModels = contract.ContractBonus.GroupBy(m => m.IdBonus);
            contractBonusViewModels.ToList().ForEach(contractBonuses =>
            {
                // If any contract bonus startValidity date is less than the startDate of the contract, throw exception
                ContractBonusViewModel wrongContractBonus = contractBonuses.FirstOrDefault(m => !m.IsDeleted && m.ValidityStartDate.Date.CompareTo(contract.StartDate.Date) < NumberConstant.Zero);
                if (wrongContractBonus != null)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { Constants.CONTRACT_BONUS_START_DATE,  wrongContractBonus.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)},
                            { Constants.START_DATE, contract.StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.AddContractBonusException, paramtrs);
                }
                // Check if there is more than one contractBonus with no ValidityEndDate
                if (contractBonuses.Count(x => !x.IsDeleted && !x.ValidityEndDate.HasValue) > NumberConstant.One)
                {
                    throw new CustomException(CustomStatusCode.MultipleContractOrOfferBonuesesWithoutEndDate);
                }
                // Check if there is an onverlap between contract bonuses
                if (contractBonuses.Count() > NumberConstant.One && contractBonuses.Any(m => !m.IsDeleted && contractBonuses.Any(n => !n.IsDeleted && !m.Equals(n) && (
                       (m.ValidityEndDate.HasValue &&
                           (n.ValidityEndDate.HasValue &&
                                   (n.ValidityEndDate.Value.BetweenDateLimitNotIncluded(m.ValidityStartDate, m.ValidityEndDate.Value)
                                || (n.ValidityStartDate.BetweenDateLimitIncluded(m.ValidityStartDate, m.ValidityEndDate.Value) && n.ValidityEndDate.Value.BetweenDateLimitIncluded(m.ValidityStartDate, m.ValidityEndDate.Value))
                                || (n.ValidityStartDate.BeforeDateLimitIncluded(m.ValidityStartDate) && n.ValidityEndDate.Value.AfterDateLimitIncluded(m.ValidityEndDate.Value)))
                                || n.ValidityStartDate.BetweenDateLimitNotIncluded(m.ValidityStartDate, m.ValidityEndDate.Value)
                           ))
                       || (!m.ValidityEndDate.HasValue && (n.ValidityStartDate.AfterDate(m.ValidityStartDate) || (n.ValidityEndDate.HasValue && n.ValidityEndDate.Value.AfterDate(m.ValidityStartDate))))
                       || m.ValidityStartDate.EqualsDate(n.ValidityStartDate)
                       ))))
                {
                    throw new CustomException(CustomStatusCode.OverlapOfSameBonusInContractOrOffer);
                }
            });

            // Check benefits in kind periodicity
            if (contract.ContractBenefitInKind != null)
            {
                List<ContractBenefitInKindViewModel> contractBenefits = contract.ContractBenefitInKind.Where(x => !x.IsDeleted).ToList();
                contractBenefits.ForEach(contractBenefit =>
                {
                    // If contract benefit in kind start date isn't included in contract period
                    if (contractBenefit.ValidityStartDate.Date.BeforeDate(contract.StartDate.Date) || (contract.EndDate.HasValue && contractBenefit.ValidityStartDate.Date.AfterDate(contract.EndDate.Value.Date)))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.START_DATE, contractBenefit.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                        throw new CustomException(CustomStatusCode.ContractBenefitInKindStartDateException, paramtrs);
                    }
                    // If contract benefit in kind start date is greater than contract benefit in kind expiration date
                    if (contractBenefit.ValidityEndDate.HasValue && contractBenefit.ValidityEndDate.Value.Date.BeforeDate(contractBenefit.ValidityStartDate.Date))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.START_DATE, contractBenefit.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)},
                        { Constants.END_DATE, contractBenefit.ValidityEndDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                        throw new CustomException(CustomStatusCode.ContractBenefitInKindStartDateGreaterThanExpirationDateException, paramtrs);
                    }
                    // If contract benefit in kind expiration date isn't included in contract period
                    if (contractBenefit.ValidityEndDate.HasValue && ((contract.EndDate.HasValue && contractBenefit.ValidityEndDate.Value.Date.AfterDate(contract.EndDate.Value.Date))
                            || contractBenefit.ValidityEndDate.Value.Date.BeforeDate(contract.StartDate.Date)))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.END_DATE, contractBenefit.ValidityEndDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                        throw new CustomException(CustomStatusCode.ContractBenefitInKindExpirationDateException, paramtrs);
                    }
                });
            }
        }

        /// <summary>
        /// Manage contract file
        /// </summary>
        /// <param name="model"></param>
        /// <param name="employeeFullName"></param>
        public void ManageFileContract(ContractViewModel model, string employeeFullName)
        {
            //Mange Contract 
            if (string.IsNullOrEmpty(model.ContractAttached))
            {
                if (model.ContractFileInfo != null && model.ContractFileInfo.Any())
                {
                    model.ContractAttached = Path.Combine("Payrool", "Employee", employeeFullName, "Contracts" + Guid.NewGuid());
                    CopyFiles(model.ContractAttached, model.ContractFileInfo);
                }
            }
            else
            {
                if (model.ContractFileInfo != null)
                {
                    DeleteFiles(model.ContractAttached, model.ContractFileInfo);
                    CopyFiles(model.ContractAttached, model.ContractFileInfo);
                }
            }
        }

        /// <summary>
        /// Recalculate employee entry date consider as hiring date
        /// </summary>
        /// <param name="contract"></param>
        private DateTime SetHiringDate(Employee employee, ContractViewModel contract)
        {
            DateTime hiringDate = default;
            if (employee.Contract is null || !employee.Contract.Any())
            {
                hiringDate = contract.StartDate;
            }
            else
            {
                if (employee.Contract.Where(x => x.Id != contract.Id).Count() > NumberConstant.Zero)
                {
                    hiringDate = new DateTime(Math.Min(employee.Contract.Where(x => x.Id != contract.Id).Min(x => x.StartDate).Date.Ticks, contract.StartDate.Date.Ticks));
                }
                else
                {
                    hiringDate = contract.StartDate;
                }
            }
            if (!employee.HiringDate.EqualsDate(hiringDate))
            {
                employee.HiringDate = hiringDate;
                employee.Contract.Clear();
                // update entity
                _employeeRepo.Update(employee);
                // commit 
                _unitOfWork.Commit();
            }
            return hiringDate;
        }


        /// <summary>
        /// Generate value for contract reference
        /// </summary>
        /// <param name="_entity"></param>
        /// <param name="_property"></param>
        /// <returns></returns>
        public string UpdateCodification(object _entity, string _property = null)
        {
            List<object> codification;
            codification = getCodification(_entity, _property, false);
            string codiedString = codification[2].ToString();
            if (codification.Any() && ((Codification)codification[0]).Id != 0)
            {
                ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                _entityRepoCodification.Update(((Codification)codification[0]));
                _unitOfWork.Commit();
            }
            return codiedString;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contractsList"></param>
        /// <param name="EmployeeFullName"></param>
        public void VerifyEmployeeContracts(IList<ContractViewModel> contractsList, string EmployeeFullName)
        {
            if (contractsList.Any())
            {
                CheckContractsOverLapping(contractsList);
                foreach (ContractViewModel contract in contractsList)
                {
                    ValidateContractsDates(contract);
                }
            }
        }

        /// <summary>
        /// Generate contrat fron candidate offer
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        public ContractViewModel GenerateContractFromOffer(OfferViewModel offer)
        {
            if (offer == null)
            {
                throw new ArgumentException("");
            }
            Contract contract = new Contract
            {
                Id = NumberConstant.Zero,
                StartDate = offer.StartDate,
                EndDate = offer.EndDate,
                WorkingTime = offer.WorkingHoursPerWeek,
                IdSalaryStructure = offer.IdSalaryStructure,
                IdCnss = offer.IdCnss,
                IdContractType = offer.IdContractType,
                ThirteenthMonthBonus = offer.ThirteenthMonthBonus,
                MealVoucher = offer.MealVoucher,
                AvailableCar = offer.AvailableCar,
                AvailableHouse = offer.AvailableHouse,
                CommissionType = offer.CommissionType,
                CommissionValue = offer.CommissionValue,
                State = (int)ContractStateEnumerator.New
            };
            contract.ContractReference = UpdateCodification(contract, null);
            ContractViewModel contractViewModel = _builder.BuildEntity(contract);
            contractViewModel.BaseSalary = new List<BaseSalaryViewModel>
            {
                new BaseSalaryViewModel { Id = NumberConstant.Zero, StartDate = offer.StartDate, Value = offer.Salary, State = (int)BaseSalaryStateEnumerator.New }
            };
            if (offer.Advantages != null && offer.Advantages.Count > NumberConstant.Zero)
            {
                contractViewModel.ContractAdvantage = new List<ContractAdvantageViewModel>();
                offer.Advantages.ToList().ForEach(advantage =>
                {
                    ContractAdvantageViewModel contractAdvantage = new ContractAdvantageViewModel
                    {
                        Id = NumberConstant.Zero,
                        Description = advantage.Description
                    };
                    contractViewModel.ContractAdvantage.Add(contractAdvantage);
                });
            }
            if (offer.OfferBenefitInKind.Count > NumberConstant.Zero)
            {
                contractViewModel.ContractBenefitInKind = new List<ContractBenefitInKindViewModel>();
                offer.OfferBenefitInKind.ToList().ForEach(offerBenefitInKind =>
                {
                    ContractBenefitInKindViewModel contractBenefitInKind = new ContractBenefitInKindViewModel
                    {
                        Id = NumberConstant.Zero,
                        IdBenefitInKind = offerBenefitInKind.IdBenefitInKind,
                        ValidityStartDate = offerBenefitInKind.ValidityStartDate,
                        Value = offerBenefitInKind.Value,
                        State = (int)BenefitInKindStateEnumerator.New
                    };
                    if (offerBenefitInKind.ValidityEndDate.HasValue)
                    {
                        contractBenefitInKind.ValidityEndDate = offerBenefitInKind.ValidityEndDate;
                    }
                    contractViewModel.ContractBenefitInKind.Add(contractBenefitInKind);
                });
            }
            if (offer.OfferBonus.Count > NumberConstant.Zero)
            {
                contractViewModel.ContractBonus = new List<ContractBonusViewModel>();
                offer.OfferBonus.ToList().ForEach(offerBonus =>
                {
                    ContractBonusViewModel contractBonus = new ContractBonusViewModel
                    {
                        Id = NumberConstant.Zero,
                        IdBonus = offerBonus.IdBonus,
                        ValidityStartDate = offerBonus.ValidityStartDate,
                        Value = offerBonus.Value
                    };
                    if (offerBonus.ValidityEndDate.HasValue)
                    {
                        contractBonus.ValidityEndDate = offerBonus.ValidityEndDate;
                    }
                    contractViewModel.ContractBonus.Add(contractBonus);
                });
            }
            return contractViewModel;
        }


        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            ContractViewModel contractViewModel = GetModelAsNoTracked(m => m.Id.Equals(id));
            if (contractViewModel.State == (int)ContractStateEnumerator.Expired)
            {
                throw new CustomException(CustomStatusCode.ContractDeleteCheck);
            }
            DeletedAssociateSession(id);
           return  new CreatedDataViewModel { Id = id, EntityName = contractViewModel.GetType().Name.ToUpper() }; ;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idsContracts"></param>
        public void DeletedAssociateSession(params int[] idsContracts)
        {
            idsContracts.ToList().ForEach(id =>
            {
                IQueryable<Session> sessionAssociatedToContract = _repoSession.GetAllWithConditionsRelationsQueryableAsNoTracking(x =>
                    x.Payslip.Any(p => p.IdContract == id), x => x.SessionContract);
                if (sessionAssociatedToContract.Any(x => x.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Contract)}
                    };
                    throw new CustomException(CustomStatusCode.CantUpdateEntityBecauseAnyPayslipIsUsedInClosedSesion, errorParams);
                }
                // If the contract to be deleted is referenced by itself in a payroll session, delete the sessions
                _repoSession.RemoveRange(sessionAssociatedToContract.Where(x => x.SessionContract.Count == NumberConstant.One).ToArray());
                base.DeleteModelwithouTransaction(id, nameof(Contract), ActiveAccountHelper.GetConnectedUserEmail());
            });
        }

        /// <summary>
        /// Retrieves the remunerations of the contract with respect to the permissions of the user
        /// </summary>
        /// <param name="contractBonus"></param>
        /// <returns></returns>
        public List<Expression<Func<Contract, object>>> PrepareContractPermissionExpression(Expression<Func<Contract, object>> contractBonus)
        {
            List<Expression<Func<Contract, object>>> filterExpressions = new List<Expression<Func<Contract, object>>> {
                    (c) => c.IdSalaryStructureNavigation,
                    (c) => c.IdCnssNavigation,
                    (c) => c.IdContractTypeNavigation,
                    (c) => c.ContractAdvantage };
            if (RoleHelper.HasPermission(RHPermissionConstant.SHOW_BASESALARY))
            {
                Expression<Func<Contract, object>> baseSalary = (c) => c.BaseSalary;
                filterExpressions.Add(baseSalary);
            }
            if (RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTBONUS))
            {
                contractBonus = (c) => c.ContractBonus;
                filterExpressions.Add(contractBonus);
            }
            if (RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTBENEFITINKIND))
            {
                Expression<Func<Contract, object>> contractBenefitInKind = (c) => c.ContractBenefitInKind;
                filterExpressions.Add(contractBenefitInKind);
            }
            return filterExpressions;
        }


        /// <summary>
        /// Assign existing values for items that the user does not have access to
        /// </summary>
        /// <param name="contractViewModel"></param>
        /// <param name="oldContractViewModel"></param>
        public void SetContractRemunerationsOldValues(dynamic contract, dynamic oldContract)
        {
            if (contract.GetType() == typeof(Contract) || contract.GetType() == typeof(ContractViewModel))
            {
                if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_BASESALARY))
                {
                    contract.BaseSalary = oldContract.BaseSalary;
                }
                if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTBONUS))
                {
                    contract.ContractBonus = oldContract.ContractBonus;
                }
                if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTBENEFITINKIND))
                {
                    contract.ContractBenefitInKind = oldContract.ContractBenefitInKind;
                }
                if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTOTHER_ADVANTAGES))
                {
                    contract.ThirteenthMonthBonus = oldContract.ThirteenthMonthBonus;
                    contract.MealVoucher = oldContract.MealVoucher;
                    contract.AvailableCar = oldContract.AvailableCar;
                    contract.AvailableHouse = oldContract.AvailableHouse;
                    contract.CommissionType = oldContract.CommissionType;
                    contract.CommissionValue = oldContract.CommissionValue;
                    contract.ContractAdvantage = oldContract.ContractAdvantage;
                }
            }
        }

        public override ContractViewModel GetModelById(int id)
        {
            Expression<Func<Contract, object>> contractBonus = null;
            List<Expression<Func<Contract, object>>> filterExpressions = PrepareContractPermissionExpression(contractBonus);
            IQueryable<Contract> contractQuery = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(c => c.Id == id, filterExpressions.ToArray())
                .Include(x => x.IdSalaryStructureNavigation).ThenInclude(x => x.SalaryStructureValidityPeriod);
            Contract contract = filterExpressions.Contains(contractBonus)
                    ? contractQuery.Include(x => x.ContractBonus).ThenInclude(x => x.IdBonusNavigation).ThenInclude(x => x.BonusValidityPeriod).FirstOrDefault()
                    : contractQuery.FirstOrDefault();
            if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTOTHER_ADVANTAGES))
            {
                contract.ThirteenthMonthBonus = null;
                contract.MealVoucher = null; ;
                contract.AvailableCar = null;
                contract.AvailableHouse = null;
                contract.CommissionType = null;
                contract.CommissionValue = null;
                contract.ContractAdvantage = null;
            }
            return _builder.BuildEntity(contract);
        }

        public override DataSourceResult<ContractViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            string userMail = ActiveAccountHelper.GetConnectedUserEmail();
            UserViewModel user = _serviceUserReduce.GetModelAsNoTracked(x => x.Email.ToLower() == userMail.ToLower(), x => x.IdEmployeeNavigation);
            if (user.IdEmployeeNavigation == null)
            {
                user.IdEmployeeNavigation = new EmployeeViewModel(true);
            }
            // Get employees ids from connected employee privilege
            IList<int> employeeIdsFromEmployeePrivilege = _serviceUserPrivilege.GetEmployeesWithConnectedUserPrivilege(userMail, user.IdEmployeeNavigation, Constants.CONTRACT).Select(x => x.Id).ToList();
            PredicateFilterRelationViewModel<Contract> predicateFilterRelationModel = PreparePredicate(predicateModel);
            Expression<Func<Contract, bool>> contractExpression = x => employeeIdsFromEmployeePrivilege.ToList().Contains(x.IdEmployee) || (x.IdEmployee == user.IdEmployeeNavigation.Id);
            // Combining two expressions
            ParameterExpression param = Expression.Parameter(typeof(Contract), "x");
            BinaryExpression body = Expression.AndAlso(Expression.Invoke(predicateFilterRelationModel.PredicateWhere, param),
                Expression.Invoke(contractExpression, param));
            predicateFilterRelationModel.PredicateWhere = Expression.Lambda<Func<Contract, bool>>(body, param);
            return GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }

        /// <summary>
        /// Calculates the number of days worked for a company configuration that does not depend on Timesheet
        /// </summary>
        /// <param name="contractViewModel"></param>
        /// <param name="month"></param>
        /// <param name="daysOfWork"></param>
        /// <returns></returns>
        public AttendanceViewModel NumberOfDaysWorkedByContractNotDependOnTimeSheet(ContractViewModel contractViewModel, DateTime month, double daysOfWork, IList<DayOfWeek> DaysOfWeekWorked)
        {
            DateTime startDate = contractViewModel.StartDate.BeforeDateLimitIncluded(month.FirstDateOfMonth())
                        ? month.FirstDateOfMonth() : contractViewModel.StartDate;
            DateTime endDate = contractViewModel.EndDate.HasValue && contractViewModel.EndDate.Value.BeforeDateLimitIncluded(month.LastDateOfMonth())
                ? contractViewModel.EndDate.Value : month.LastDateOfMonth();
            AttendanceViewModel attendanceViewModel = new AttendanceViewModel
            {
                NumberDaysPaidLeave = default,
                NumberDaysNonPaidLeave = default,
                IdEmployee = contractViewModel.IdEmployee,
                IdContract = contractViewModel.Id,
                StartDate = contractViewModel.StartDate.BeforeDate(month) ? month :
                                contractViewModel.StartDate,
                EndDate = contractViewModel.EndDate.HasValue &&
                            contractViewModel.EndDate.Value.BeforeDateLimitIncluded(month.LastDateOfMonth())
                            ? contractViewModel.EndDate.Value : month.LastDateOfMonth()
            };
            attendanceViewModel.NumberDaysWorked = (startDate.EqualsDate(month.FirstDateOfMonth()) && endDate.EqualsDate(month.LastDateOfMonth())) ?
                daysOfWork :
                startDate.AllDatesUntilLimitIncluded(endDate, DaysOfWeekWorked).Count;
            attendanceViewModel.MaxNumberOfDaysAllowed = Math.Round(attendanceViewModel.NumberDaysWorked + attendanceViewModel.NumberDaysPaidLeave + attendanceViewModel.NumberDaysNonPaidLeave, NumberConstant.Two);
            return attendanceViewModel;
        }
    }
}


