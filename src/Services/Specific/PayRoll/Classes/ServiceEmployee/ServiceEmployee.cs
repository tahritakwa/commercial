using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Context;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text.RegularExpressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes.ServiceEmployee
{
    public partial class ServiceEmployee : Service<EmployeeViewModel, Employee>, IServiceEmployee
    {
        private readonly IRepository<EmployeeSkills> _entityEmployeeSkills;
        private readonly IRepository<Contract> _entityContract;
        private readonly IServiceContract _serviceContract;
        private readonly IEmployeeSkillsBuilder _builderEmployeeSkills;
        private readonly IServiceJobEmployee _serviceJobEmployee;
        private readonly IServiceJob _serviceJob;
        private readonly IServiceUser _serviceUser;
        private readonly IServiceEmail _serviceEmail;
        private readonly IReducedEmployeeBuilder _reducedBuilder;
        private readonly IServiceEmployeeDocument _serviceEmployeeDocument;
        private readonly IServiceEmployeeTeam _serviceEmployeeTeam;
        private readonly IServiceUserPrivilege _serviceUserPrivilege;
        private readonly IContractBuilder _contractBuilder;
        private readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<Candidate> _entityCandidate;
        private readonly IRepository<Team> _repoTeam;
        private readonly IRepository<EmployeeTeam> _repoEmployeeTeam;


        public ServiceEmployee(IRepository<Employee> entityRepo,
            IRepository<Contract> entityContract,
            IUnitOfWork unitOfWork,
            IEmployeeBuilder employeeBuilder,
            IServiceEmployeeDocument serviceEmployeeDocument,
            IRepository<Entity> entityRepoEntity,
            IServiceContract serviceContract, IReducedEmployeeBuilder reducedBuilder,
            IServiceJobEmployee serviceJobEmployee,
            IServiceUser serviceUser, IServiceEmail serviceEmail,
            IServiceEmployeeTeam serviceEmployeeTeam,
            IRepository<EmployeeSkills> entityEmployeeSkills, IEmployeeSkillsBuilder builderEmployeeSkills,
            IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification, IServiceJob serviceJob,
            IServiceUserPrivilege serviceUserPrivilege,
            IRepository<Candidate> entityCandidate,
            IContractBuilder contractBuilder, IRepository<User> entityRepoUser,
            IRepository<Team> repoTeam, IRepository<EmployeeTeam> repoEmployeeTeam)
             : base(entityRepo, unitOfWork, employeeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityContract = entityContract;
            _serviceContract = serviceContract;
            _entityEmployeeSkills = entityEmployeeSkills;
            _builderEmployeeSkills = builderEmployeeSkills;
            _serviceJobEmployee = serviceJobEmployee;
            _serviceUser = serviceUser;
            _serviceJob = serviceJob;
            _serviceEmail = serviceEmail;
            _reducedBuilder = reducedBuilder;
            _serviceEmployeeDocument = serviceEmployeeDocument;
            _serviceEmployeeTeam = serviceEmployeeTeam;
            _serviceUserPrivilege = serviceUserPrivilege;
            _contractBuilder = contractBuilder;
            _entityRepoUser = entityRepoUser;
            _entityCandidate = entityCandidate;
            _repoTeam = repoTeam;
            _repoEmployeeTeam = repoEmployeeTeam;
        }


        /// <summary>
        /// AddModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(EmployeeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            EmployeeValidation(model);
            if (RoleHelper.HasPermission(RHPermissionConstant.ADD_CONTRACT) || RoleHelper.HasPermission(RHPermissionConstant.UPDATE_CONTRACT))
            {
                SetHiringDate(model);
            }
            _serviceContract.VerifyEmployeeContracts(model.Contract.ToList(), model.FullName);
            Employee entity = _builder.BuildModel(model);
            entity.Status = (int)EmployeeState.Active;
            // Generate Matricule            
            entity.Matricule = GenerateMatricule();
            UpdateCollections(entity, userMail);
            // add entity
            _entityRepo.Add(entity);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = entity.Id, Code = getModelCode(entity, GetPropertyName(entity)) };
            }
            return new CreatedDataViewModel { Id = entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        public override void BulkAddWithoutTransaction(IList<EmployeeViewModel> models, string userMail, string property = null)
        {
            models.ToList().ForEach((model) =>
            {
                EmployeeValidation(model);
                IsValidDataEmployee(model);
                if (RoleHelper.HasPermission(RHPermissionConstant.ADD_CONTRACT) || RoleHelper.HasPermission(RHPermissionConstant.UPDATE_CONTRACT))
                {
                    SetHiringDate(model);
                }
                CheckMatriculeValidity(model.Matricule);
                if (model.Contract != null)
                {
                    model.Contract.ToList().ForEach(c =>
                    {
                        c.BaseSalary = new List<BaseSalaryViewModel>();
                        c.BaseSalary.Add(new BaseSalaryViewModel
                        {
                            Value = c.BaseSalaryValue,
                            StartDate = c.StartDate
                        });
                        if (c.IdContractType == NumberConstant.Zero || c.IdCnss == NumberConstant.Zero || c.IdSalaryStructure == NumberConstant.Zero || c.StartDate == null ||
                        (c.IdContractTypeNavigation != null && c.IdContractTypeNavigation.HasEndDate.HasValue && !c.EndDate.HasValue))
                        {
                            IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), model.FirstName + " " + model.LastName}

                    };
                            throw new CustomException(CustomStatusCode.INVALID_DATA_INPUT_FROM_EXCEL_FILE, errorParams);
                        }
                        c.IdContractTypeNavigation = null;
                    });
                }

                _serviceContract.CheckContractsOverLappingFromExcel(model.Contract.ToList());
                _serviceContract.VerifyEmployeeContracts(model.Contract.ToList(), model.FullName);
            });
            base.BulkAddWithoutTransaction(models, userMail);
        }
        public override void BulkUpdateModelWithoutTransaction(IList<EmployeeViewModel> models, string userMail)
        {
            models.ToList().ForEach((model) =>
            {
                EmployeeValidation(model);
                IsValidDataEmployee(model);
                CheckMatriculeValidity(model.Matricule);
                EmployeeViewModel employeeBeforeUpdate = GetModelWithRelationsAsNoTracked(m => m.Id == model.Id, m => m.Contract);
                if (employeeBeforeUpdate == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                employeeBeforeUpdate.Contract.ToList().ForEach(contractBeforeUpdate =>
                {
                    model.Contract.Add(contractBeforeUpdate);
                });
                if (RoleHelper.HasPermission(RHPermissionConstant.ADD_CONTRACT) || RoleHelper.HasPermission(RHPermissionConstant.UPDATE_CONTRACT))
                {
                    SetHiringDate(model, employeeBeforeUpdate);
                }
                if (model.Contract != null)
                {
                    model.Contract.ToList().ForEach(c =>
                    {
                        if (c.Id == NumberConstant.Zero)
                        {
                            c.BaseSalary = new List<BaseSalaryViewModel>();
                            c.BaseSalary.Add(new BaseSalaryViewModel
                            {
                                Value = c.BaseSalaryValue,
                                StartDate = c.StartDate
                            });
                            if (c.IdContractType == NumberConstant.Zero || c.IdCnss == NumberConstant.Zero || c.IdSalaryStructure == NumberConstant.Zero || c.StartDate == null ||
                            (c.IdContractTypeNavigation != null && c.IdContractTypeNavigation.HasEndDate.HasValue && !c.EndDate.HasValue))
                            {
                                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                                {
                                    { nameof(Employee), model.FirstName + " " + model.LastName}

                                };
                                throw new CustomException(CustomStatusCode.INVALID_DATA_INPUT_FROM_EXCEL_FILE, errorParams);
                            }
                        }
                        c.IdContractTypeNavigation = null;
                    });
                }
                _serviceContract.CheckContractsOverLappingFromExcel(model.Contract.ToList());
                _serviceContract.VerifyEmployeeContracts(model.Contract.ToList(), model.FullName);
            });
            base.BulkUpdateModelWithoutTransaction(models, userMail);
        }
        /// <summary>
        /// Update model
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(EmployeeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            EmployeeValidation(model);
            Employee employee = _entityRepo.GetAllAsNoTracking()
                    .Include(x => x.Contract).ThenInclude(e => e.BaseSalary)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBenefitInKind)
                    .Include(x => x.Contract).ThenInclude(e => e.ContractBonus)
                    .Where(x => x.Id == model.Id).FirstOrDefault();
            EmployeeViewModel employeeBeforeUpdate = _builder.BuildEntity(employee);         
            if (employeeBeforeUpdate == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            CheckMatriculeValidity(model.Matricule);
            SetHiringDate(model, employeeBeforeUpdate);
            if (model.ResignationDepositDate.HasValue && model.Contract.Any() && model.ResignationDepositDate.Value.BeforeDate(model.HiringDate))
            {
                throw new CustomException(CustomStatusCode.CannotAddResignationDepositDateBeforeHiringDate);
            }
            // Assign existing values for items that the user does not have access to
            employeeBeforeUpdate.Contract.ToList().ForEach(oldContract =>
            {
                _serviceContract.SetContractRemunerationsOldValues(model.Contract.FirstOrDefault(x => x.Id == oldContract.Id), oldContract);
            });
            // Set employee status if he has set up resignation deposit date
            model.Status = model.Status != (int)EmployeeState.Resigned && model.ResignationDepositDate.HasValue ? (int)EmployeeState.Resigning :
                !model.ResignationDepositDate.HasValue ? (int)EmployeeState.Active : model.Status;
            CheckUpdateRight(model, employeeBeforeUpdate, userMail);
            Employee entity = _builder.BuildModel(model);
            entity.JobEmployee.Clear();
            if (RoleHelper.HasPermission(RHPermissionConstant.UPDATE_CONTRACT))
            {
                if (model.Contract.Any(x => x.UpdatePayslipAndTimeSheets))
                {
                    _serviceContract.UpdateContractAssociateWithPayslipOrTimesheet(entity.Contract.ToList(), entity.HiringDate);
                }
                // update collection entity
                _entityContract.BulkUpdate(entity.Contract.Where(x => x.Id > NumberConstant.Zero).ToList());
            }
            else
            {
                entity.Contract.Clear();
            }
            // Set employee status if he has set up resignation deposit date
            entity.Status = entity.Status != (int)EmployeeState.Resigned && entity.ResignationDepositDate.HasValue ? (int)EmployeeState.Resigning :
                !entity.ResignationDepositDate.HasValue ? (int)EmployeeState.Active : entity.Status;
            if (entity.Status == (int)EmployeeState.Resigning && entity.ResignationDate.HasValue && entity.ResignationDate.Value.Date.BeforeDate(DateTime.Today.Date))
            {
                entity.Status = (int)EmployeeState.Resigned;
                ResignedEmployeeActionsToDo(entity);
            }
            else
            {
                // update collection entity
                _entityContract.BulkUpdate(entity.Contract.Where(x => x.Id > NumberConstant.Zero).ToList());
            }
            // commit 
            _unitOfWork.Commit();
            UpdateCollections(entity, userMail);
            //entity.Contract.Clear();
            // update entity
            _entityRepo.Update(entity);
            // commit 
            _unitOfWork.Commit();
            // Synchronize employees after updated employee hierarchy level changed
            SynchronizeEmployees();
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };

        }

        /// <summary>
        /// Ensures that all the employee's constraints are respected
        /// </summary>
        /// <param name="model"></param>
        public void EmployeeValidation(EmployeeViewModel model)
        {
            CheckUniqueCase(model);
            // Manage employee picture and cin file
            ManageEmployeePictureAndCin(model);
            // Manage Employes Document Files
            ManageEmployeeDocument(model);
            // Manage Qualification Files
            ManageQualificationFile(model);
            // Manage employee hierrarchy level
            ManageHierrarchyLevel(model);

            if (model.Contract != null)
            {
                model.Contract.ToList().ForEach(contract =>
                {
                    _serviceContract.ManageFileContract(contract, model.FullName);
                    _serviceContract.SetBonusAndBeneFitInKindEndDates(contract);
                });
            }
        }

        /// <summary>
        /// Check the connected user has update rights 
        /// </summary>
        /// <param name="employeeViewModel"></param>
        /// <param name="employeeBeforeUpdate"></param>
        /// <param name="userMail"></param>
        private void CheckUpdateRight(EmployeeViewModel employeeViewModel, EmployeeViewModel employeeBeforeUpdate, string userMail)
        {
            // If connected user doesn't have pay privilege, set pay informations to their original values before trying to update the employee
            if (!CheckConnectedUserHasPrivilege(employeeBeforeUpdate, userMail, Constants.PAY))
            {
                employeeViewModel = EnableEmployeePayFields(employeeViewModel, employeeBeforeUpdate);
            }
            if (RoleHelper.HasPermission(RHPermissionConstant.UPDATE_CONTRACT))
            {
                _serviceContract.ManageEmployeeContracts(employeeViewModel, userMail, employeeBeforeUpdate);
            }
            if (RoleHelper.HasPermission(RHPermissionConstant.UPDATE_EMPLOYEE))
            {
                UpdateJobEmployee(employeeViewModel, userMail);
            }
        }

        /// <summary>
        /// Set employee hiring date
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="contractViewModels"></param>
        private void SetHiringDate(EmployeeViewModel employee, EmployeeViewModel employeeBeforeUpdate = null)
        {
            if (employee.Contract is null || !employee.Contract.Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyContract);
            }
            if (employee.Id == NumberConstant.Zero)
            {
                if (employee.Contract.Any())
                {
                    // Set hiring date
                    employee.HiringDate = employee.Contract.Min(x => x.StartDate);
                }
            }
            else
            {
                List<ContractViewModel> allContracts = new List<ContractViewModel>();
                allContracts.AddRange(employee.Contract);
                if (employeeBeforeUpdate.Contract != null && employeeBeforeUpdate.Contract.Any())
                {
                    allContracts.AddRange(employeeBeforeUpdate.Contract.Where(x => !employee.Contract.Select(y => y.Id).Contains(x.Id)));
                }
                // Set hiring date
                employee.HiringDate = allContracts.Min(x => x.StartDate);
            }
        }

        /// <summary>
        /// Generates an employee registration number
        /// </summary>
        /// <param name="_entity"></param>
        /// <param name="_property"></param>
        /// <returns></returns>
        public string GenerateMatricule()
        {
            Employee lastAddEmployee;
            try
            {
                lastAddEmployee = _entityRepo.QuerableGetAll().OrderByDescending(m => Convert.ToInt64(m.Matricule)).FirstOrDefault();
            }
            catch
            {
                throw new CustomException(CustomStatusCode.InvalidRegistrationNumber);
            }
            long newMatriculeValue = default;
            if (lastAddEmployee != null)
            {
                string lastMatriculeCounterValue = lastAddEmployee.Matricule;
                bool result = long.TryParse(lastMatriculeCounterValue, out newMatriculeValue);
                if (!result)
                {
                    throw new CustomException(CustomStatusCode.MatriculeMustBeANumber);
                }
            }
            newMatriculeValue += NumberConstant.One;
            string matricule = Convert.ToString(newMatriculeValue);
            CheckMatriculeValidity(matricule);
            return matricule;
        }

        /// <summary>
        /// Checks the validity of the registration number
        /// </summary>
        /// <param name="matricule"></param>
        private void CheckMatriculeValidity(string matricule)
        {
            if (long.TryParse(matricule, out long matriculeConverted))
            {
                if (matriculeConverted < NumberConstant.One)
                {
                    throw new CustomException(CustomStatusCode.RegistrationNumberMinimalAchieved);
                }
                if (matriculeConverted > NumberConstant.MaximalMatricule)
                {
                    throw new CustomException(CustomStatusCode.REGISTRATION_NUMBER_MAXIMAL_ACHIEVED);
                }
            }
            else
            {
                throw new CustomException(CustomStatusCode.InvalidRegistrationNumber);
            }
        }

        /// <summary>
        /// UpdateCodification
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

        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Employee> predicateFilterRelationModel)
        {
            IQueryable<Employee> query = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                         .OrderByRelation(predicateModel.OrderBy)
                                         .Where(predicateFilterRelationModel.PredicateWhere);
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                query = query.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
            }
            IList<Employee> entities = query.ToList();
            List<EmployeeViewModel> resultDropDown = entities.Select(x => _builder.BuildEntity(x)).ToList();
            foreach (EmployeeViewModel employee in resultDropDown)
            {
                employee.IsResigned = VerifyEmployeeResigned(employee) ? true : false;
            }
            IList<ReducedEmployeeViewModel> model = entities.Select(x => _reducedBuilder.BuildEntity(x))
                         .OrderBy(m => m.LastName).ThenBy(m => m.FirstName).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            var result = model.Select(x => (dynamic)x).ToList();
            return new DataSourceResult<dynamic> { data = result, total = total };
        }


        /// <summary>
        /// Update collection of Job Employee on update employee
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void UpdateJobEmployee(EmployeeViewModel model, string userMail)
        {
            List<JobEmployeeViewModel> oldJobEmployee = _serviceJobEmployee.FindModelBy(x => x.IdEmployee == model.Id).ToList();
            List<JobEmployeeViewModel> newJobEmployee = model.JobEmployee.ToList();
            newJobEmployee.ForEach(x => x.IdEmployee = model.Id);

            List<JobEmployeeViewModel> addedJobEmployee = newJobEmployee.Where(p => !oldJobEmployee.Select(s => s.IdJob).Contains(p.IdJob)).ToList();
            List<JobEmployeeViewModel> deletedJobEmployee = oldJobEmployee.Where(p => !newJobEmployee.Select(s => s.IdJob).Contains(p.IdJob)).ToList();
            foreach (JobEmployeeViewModel jobEmployee in deletedJobEmployee)
            {
                _serviceJobEmployee.DeleteModelPhysicallyWhithoutTransaction(jobEmployee.Id, userMail);
            }
            foreach (JobEmployeeViewModel jobEmployee in addedJobEmployee)
            {
                jobEmployee.Id = 0;
                _serviceJobEmployee.AddModelWithoutTransaction(jobEmployee, new List<EntityAxisValuesViewModel>(), userMail);
            }
        }

        /// <summary>
        /// Calculate employee hierarchy level
        /// </summary>
        /// <param name="employeeViewModel"></param>
        private void ManageHierrarchyLevel(EmployeeViewModel employeeViewModel)
        {
            if (employeeViewModel.IdUpperHierarchy.HasValue)
            {
                EmployeeViewModel superior = GetModelById(employeeViewModel.IdUpperHierarchy.Value);
                if (employeeViewModel.Id > NumberConstant.Zero)
                {
                    // Check existence of employee in upper employee hierarchical level
                    if (IsPartOfHierarchy(employeeViewModel.Id, superior.HierarchyLevel))
                    {
                        IDictionary<string, dynamic> param = new Dictionary<string, dynamic>
                        {
                            { Constants.SUPERIOR_EMPLOYEE_NAME, superior.FullName},
                            { Constants.INFERIOR_EMPLOYEE_NAME, employeeViewModel.FullName}
                        };
                        throw new CustomException(CustomStatusCode.EmployeeRecursivityViolation, param);
                    }
                    else if (employeeViewModel.Id == employeeViewModel.IdUpperHierarchy)
                    {
                        throw new CustomException(CustomStatusCode.EmployeeEqualToUpperEmployeeException);
                    }
                }
                // Update hierarchy level
                employeeViewModel.HierarchyLevel = superior.HierarchyLevel.NotNullOrEmpty() ?
                    superior.HierarchyLevel + PayRollConstant.LevelSeparator + superior.Id.ToString() : superior.Id.ToString();
            }
            else
            {
                employeeViewModel.HierarchyLevel = null;
            }
        }

        /// <summary>
        /// Manage qualification files
        /// </summary>
        /// <param name="model"></param>
        private void ManageQualificationFile(EmployeeViewModel model)
        {
            //Mange Employes Qualification Files
            if (model.Qualification != null)
            {
                foreach (var qualification in model.Qualification)
                {
                    if (string.IsNullOrEmpty(qualification.QualificationAttached))
                    {
                        if (qualification.QualificationFileInfo != null)
                        {
                            qualification.QualificationAttached = Path.Combine("Payrool", "Employee", "Qualification", model.FirstName + model.LastName, Guid.NewGuid().ToString());
                            CopyFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                        }
                    }
                    else
                    {
                        if (qualification.QualificationFileInfo != null)
                        {
                            DeleteFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                            CopyFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                        }

                    }
                }
            }
        }

        /// <summary>
        /// Manage employee's picture and CIN file
        /// </summary>
        /// <param name="model"></param>
        private void ManageEmployeePictureAndCin(EmployeeViewModel model)
        {
            //Mange Picture 
            if (model.PictureFileInfo != null)
            {
                model.Picture = Path.Combine("Payrool", "Employee", model.FirstName + model.LastName, Guid.NewGuid().ToString());
                CopyFiles(model.Picture, model.PictureFileInfo);
            }
            //Mange CIN
            if (string.IsNullOrEmpty(model.CinAttached))
            {
                if (model.CinFileInfo != null)
                {

                    model.CinAttached = Path.Combine("Payrool", "Employee", model.FirstName + model.LastName, Guid.NewGuid().ToString());
                    CopyFiles(model.CinAttached, model.CinFileInfo);
                }
            }
            else
            {
                if (model.CinFileInfo != null)
                {
                    DeleteFiles(model.CinAttached, model.CinFileInfo);
                    CopyFiles(model.CinAttached, model.CinFileInfo);
                }
            }
        }

        /// <summary>
        /// Manage Employee Document
        /// </summary>
        /// <param name="model"></param>
        private void ManageEmployeeDocument(EmployeeViewModel model)
        {
            if (model.EmployeeDocument != null)
            {
                foreach (var document in model.EmployeeDocument)
                {
                    if (string.IsNullOrEmpty(document.AttachedFile))
                    {
                        if (document.AttachedFileInfo != null)
                        {
                            document.AttachedFile = Path.Combine("Payrool", "Employee", model.FirstName + model.LastName, Guid.NewGuid().ToString());
                            CopyFiles(document.AttachedFile, document.AttachedFileInfo);
                        }
                    }
                    else
                    {
                        if (document.AttachedFileInfo != null)
                        {
                            DeleteFiles(document.AttachedFile, document.AttachedFileInfo);
                            CopyFiles(document.AttachedFile, document.AttachedFileInfo);
                        }

                    }
                }
            }


        }

        /// <summary>
        /// Generate Employee List From Excel file
        /// </summary>
        /// <param name="excelDataStream"></param>
        /// <returns></returns>
        public IList<EmployeeViewModel> GenerateEmployeeListFromExcel(Stream excelDataStream)
        {
            EmployeeForImportExcelComparer comparer = new EmployeeForImportExcelComparer();
            IList<EmployeeViewModel> employeesFromExcel = GenerateListFromExcel(excelDataStream, "Matricule", comparer);
            IList<ContractViewModel> contractFromExcel = _serviceContract.GenerateContractListFromExcel(excelDataStream);
            IList<EmployeeViewModel> employeeFromDB = GetAllModels().ToList();
            employeesFromExcel.ToList().ForEach(employeeExcel =>
            {
                IsValidDataEmployee(employeeExcel);
                List<ContractViewModel> contractViewModels = contractFromExcel.Where(x => x.MatriculeEmployee == employeeExcel.Matricule).ToList();
                employeeExcel.Contract = new List<ContractViewModel>();
                foreach (ContractViewModel contractViewModel in contractViewModels)
                {
                    IsValidDataContract(contractViewModel);
                    employeeExcel.Contract.Add(contractViewModel);
                    if (contractViewModel.BaseSalary == null)
                    {
                        contractViewModel.ContractReference = string.Empty;
                        contractViewModel.BaseSalary = new List<BaseSalaryViewModel>();
                        contractViewModel.ContractBonus = new List<ContractBonusViewModel>();
                        contractViewModel.State = (int)ContractStateEnumerator.New;
                    }
                    contractViewModel.BaseSalary.Add(new BaseSalaryViewModel
                    {
                        StartDate = contractViewModel.StartDate,
                        Value = contractViewModel.BaseSalaryValue,
                        State = (int)ContractStateEnumerator.New
                    });
                }
                if (employeeExcel.Contract.Count == NumberConstant.Zero)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), employeeExcel.FirstName +" "+ employeeExcel.LastName }
                    };
                    throw new CustomException(CustomStatusCode.EOMPLYEE_DID_NOT_HAVE_A_CONTRACT_FROM_EXCEL, paramtrs);
                }
            });
            // Returns the list of matricules not found
            List<string> result = contractFromExcel.Select(x => x.MatriculeEmployee).
                Except(employeesFromExcel.Select(x => x.Matricule)).
                Except(employeeFromDB.Select(x => x.Matricule)).ToList();
            if (result.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.MATRICULE , result.FirstOrDefault() }
                    };
                throw new CustomException(CustomStatusCode.NUMBERS_NOT_FOUND_FROM_DB, paramtrs);
            }
            #region Manage adding a contract to an existing employee from Excel
            // Returns the list of contract when the matriculeEmployee exist in db
            contractFromExcel = contractFromExcel.Where(o => contractFromExcel.Select(x => x.MatriculeEmployee).Intersect(employeeFromDB.Select(x => x.Matricule)).Contains(o.MatriculeEmployee)).ToList();
            contractFromExcel.ToList().ForEach(contractExcel =>
            {
                EmployeeViewModel employee = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Matricule == contractExcel.MatriculeEmployee)
                .Include(x => x.Contract).ThenInclude(x => x.BaseSalary)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();
                if (employee != null)
                {
                    if (employee.Contract == null)
                    {
                        employee.Contract = new List<ContractViewModel>();
                    }
                    employee.Contract.Add(contractExcel);
                    // control over the dates of contracts used from Excel
                    _serviceContract.CheckContractsOverLappingFromExcel(employee.Contract);
                    employee.Contract = employee.Contract.Where(c => c.Id == NumberConstant.Zero).ToList();
                    foreach (ContractViewModel contract in employee.Contract)
                    {
                        IsValidDataContract(contract);
                        contract.ContractReference = string.Empty;
                        contract.BaseSalary = new List<BaseSalaryViewModel>();
                        contract.ContractBonus = new List<ContractBonusViewModel>();
                        contract.State = (int)ContractStateEnumerator.New;
                        contract.BaseSalary.Add(new BaseSalaryViewModel
                        {
                            StartDate = contract.StartDate,
                            Value = contract.BaseSalaryValue,
                            State = (int)ContractStateEnumerator.New
                        });
                    }
                    employeesFromExcel.Add(employee);
                }
            });
            #endregion
            return employeesFromExcel;
        }
        private void IsValidDataEmployee(EmployeeViewModel employee)
        {

            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { Constants.MATRICULE, employee.Matricule }
                            };
            Regex rib = new Regex(@"^[0-9]{1,20}$");
            if (employee.Rib != null && !rib.IsMatch(employee.Rib))
            {
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.Fifteen);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_RIB_COLUMN, paramtrs);
            }
            Regex ssn = new Regex(@"^[0-9]{10}$");
            if (employee.SocialSecurityNumber != null && !ssn.IsMatch(employee.SocialSecurityNumber))
            {
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.Ten);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_SSN_COLUMN, paramtrs);
            }
            Regex r = new Regex(@"^(?:99|\d{1,2})(?:\.\d{1,2})?$");
            if (employee.ChildrenDisabled != null && !r.IsMatch(employee.ChildrenDisabled.ToString()))
            {
                paramtrs.Add(ExcelConstants.COLUMN, Constants.CHILDREN_DISABLED);
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.NinetyNine);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_DATA_COLUMN, paramtrs);
            }
            if (employee.ChildrenNumber != null && !r.IsMatch(employee.ChildrenNumber.ToString()))
            {
                paramtrs.Add(ExcelConstants.COLUMN, Constants.CHILDREN_NUMBER);
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.NinetyNine);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_DATA_COLUMN, paramtrs);
            }
            if (employee.ChildrenNoScholar != null && !r.IsMatch(employee.ChildrenNoScholar.ToString()))
            {
                paramtrs.Add(ExcelConstants.COLUMN, Constants.CHILDREN_NO_SCHOLAR);
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.NinetyNine);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_DATA_COLUMN, paramtrs);
            }
            Regex parentInCharge = new Regex(@"^([0-2])$");
            if (employee.ParentInCharge != null && !parentInCharge.IsMatch(employee.ParentInCharge.ToString()))
            {
                paramtrs.Add(ExcelConstants.COLUMN, Constants.PARENT_IN_CHARGE);
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.Two);
                throw new CustomException(CustomStatusCode.EXCEL_INVALID_DATA_COLUMN, paramtrs);

            }

        }
        private void IsValidDataContract(ContractViewModel contract)
        {
            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { Constants.MATRICULE, contract.MatriculeEmployee }
                            };
            Regex r = new Regex(@"^([1-9]|[1-5][0-9]|60)$");
            if (contract.WorkingTime != null && !r.IsMatch(contract.WorkingTime.ToString()))
            {
                paramtrs.Add(ExcelConstants.COLUMN, Constants.WORKING_TIME);
                paramtrs.Add(Constants.MAX_VALUE, NumberConstant.Sixty);
            }
        }
        /// <summary>
        /// GetModelById
        /// </summary>
        /// <param name="id"></param>
        /// <param name="userMail"></param>
        /// <param name="isWithContractManaging"></param>
        /// <returns></returns>
        public EmployeeViewModel GetModelById(int id, string userMail)
        {
            EmployeeViewModel employee = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.JobEmployee).ThenInclude(x => x.IdJobNavigation)
                .Include(x => x.EmployeeDocument)
                .Include(x => x.IdCitizenshipNavigation)
                .Include(x => x.IdCountryNavigation)
                .Include(x => x.IdCityNavigation)
                .Include(x => x.Qualification).ThenInclude(x => x.IdQualificationTypeNavigation)
                .Include(x => x.Qualification).ThenInclude(x => x.IdQualificationCountryNavigation)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();
            if (employee.Status == (int)EmployeeState.Resigned && !RoleHelper.HasPermission(RHPermissionConstant.SHOW_RESIGNED_EMPLOYEE))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            bool hasPayRight = false;
            bool hasContractRight = false;
            hasPayRight = CheckConnectedUserHasPrivilege(employee, userMail, Constants.PAY);
            hasContractRight = RoleHelper.HasPermission(RHPermissionConstant.LIST_CONTRACT) && CheckConnectedUserHasPrivilege(employee, userMail, Constants.CONTRACT);
            if (!hasPayRight)
            {
                employee = DisableEmployeePayFields(employee);
            }
            if (!hasContractRight)
            {
                employee.Contract = null;
            }
            else
            {
                Expression<Func<Contract, object>> contractBonus = null;
                List<Expression<Func<Contract, object>>> filterExpressions = _serviceContract.PrepareContractPermissionExpression(contractBonus);
                IQueryable<Contract> contractQuery = _entityContract.GetAllWithConditionsRelationsQueryable(c => c.IdEmployee == employee.Id, filterExpressions.ToArray())
                    .Include(x => x.IdSalaryStructureNavigation).ThenInclude(x => x.SalaryStructureValidityPeriod);
                employee.Contract = filterExpressions.Contains(contractBonus)
                    ? contractQuery.Include(x => x.ContractBonus).ThenInclude(x => x.IdBonusNavigation).ThenInclude(x => x.BonusValidityPeriod).OrderByDescending(m => m.StartDate).Select(_contractBuilder.BuildEntity).ToList()
                    : contractQuery.OrderByDescending(m => m.StartDate).Select(_contractBuilder.BuildEntity).ToList();
                foreach (ContractViewModel contractViewModel in employee.Contract)
                {
                    contractViewModel.ContractFileInfo = GetFiles(contractViewModel.ContractAttached).ToList();
                    if (!RoleHelper.HasPermission(RHPermissionConstant.SHOW_CONTRACTOTHER_ADVANTAGES))
                    {
                        contractViewModel.ThirteenthMonthBonus = null;
                        contractViewModel.MealVoucher = null; ;
                        contractViewModel.AvailableCar = null;
                        contractViewModel.AvailableHouse = null;
                        contractViewModel.CommissionType = null;
                        contractViewModel.CommissionValue = null;
                        contractViewModel.ContractAdvantage = null;
                    }
                }
            }
            if (employee.EmployeeDocument != null)
            {
                foreach (var employeeDocument in employee.EmployeeDocument)
                {
                    employeeDocument.AttachedFileInfo = GetFiles(employeeDocument.AttachedFile).ToList();
                }
            }
            if (employee.Qualification != null)
            {
                employee.Qualification = employee.Qualification.OrderBy(x => x.GraduationYearDate).ToList();
                foreach (var qualification in employee.Qualification)
                {
                    qualification.QualificationFileInfo = GetFiles(qualification.QualificationAttached).ToList();
                }
            }
            //employee.PictureFileInfo = GetFilesContent(employee.Picture).FirstOrDefault();
            employee.CinFileInfo = GetFiles(employee.CinAttached).ToList();

            employee.EmployeeSkills = _entityEmployeeSkills.GetAllWithConditionsRelations(
                x => x.IdEmployee == id && x.Rate > 0, x => x.IdSkillsNavigation)
                .OrderByDescending(x => x.Rate)
                .Select(_builderEmployeeSkills.BuildEntity).ToList();
            if (!IsUserInSuperHierarchicalEmployeeList(userMail, employee))
            {
                employee.Notes = null;
            }
            if (employee.Contract != null)
            {
                foreach (var contract in employee.Contract)
                {
                    contract.ContractFileInfo = GetFiles(contract.ContractAttached).ToList();
                }
            }
            return employee;
        }

        public EmployeeViewModel GetEmployeeByEmail(string email, string userMail)
        {
            EmployeeViewModel employee = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Email == email)
                .Include(x => x.JobEmployee).ThenInclude(x => x.IdJobNavigation)
                .Include(x => x.EmployeeDocument)
                .Include(x => x.IdCountryNavigation)
                .Include(x => x.IdCityNavigation)
                .Include(x => x.Qualification).ThenInclude(x => x.IdQualificationTypeNavigation)
                .Include(x => x.Qualification).ThenInclude(x => x.IdQualificationCountryNavigation)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();
            bool hasPayRight = false;
            bool hasContractRight = false;
            if (employee != null)
            {
                hasPayRight = CheckConnectedUserHasPrivilege(employee, userMail, Constants.PAY);
                hasContractRight = RoleHelper.HasPermission(RHPermissionConstant.LIST_CONTRACT) && CheckConnectedUserHasPrivilege(employee, userMail, Constants.CONTRACT);

                if (!hasPayRight)
                {
                    employee = DisableEmployeePayFields(employee);
                }
                if (!hasContractRight)
                {
                    employee.Contract = null;
                }
                else
                {
                    List<Expression<Func<Contract, object>>> filterExpressions = new List<Expression<Func<Contract, object>>> {
                    (c) => c.IdSalaryStructureNavigation, (c) => c.IdCnssNavigation, (c) => c.IdContractTypeNavigation, (c) => c.ContractAdvantage };
                    Expression<Func<Contract, object>> baseSalary = (c) => c.BaseSalary;
                    filterExpressions.Add(baseSalary);
                    Expression<Func<Contract, object>> contractBonus = null;
                    Expression<Func<Contract, object>> contractBenefitInKind = (c) => c.ContractBenefitInKind;
                    contractBonus = (c) => c.ContractBonus;
                    filterExpressions.Add(contractBonus);
                    filterExpressions.Add(contractBenefitInKind);
                    IQueryable<Contract> contractQuery = _entityContract.GetAllWithConditionsRelationsQueryable(c => c.IdEmployee == employee.Id, filterExpressions.ToArray());
                    employee.Contract = filterExpressions.Contains(contractBonus) ? contractQuery.Include(x => x.ContractBonus)
                        .ThenInclude(x => x.IdBonusNavigation).ThenInclude(x => x.BonusValidityPeriod).OrderByDescending(m => m.StartDate).Select(_contractBuilder.BuildEntity).ToList() :
                        contractQuery.OrderByDescending(m => m.StartDate).Select(_contractBuilder.BuildEntity).ToList();
                    foreach (ContractViewModel contractViewModel in employee.Contract)
                    {
                        contractViewModel.ContractFileInfo = GetFiles(contractViewModel.ContractAttached).ToList();
                    }
                }
                if (employee.EmployeeDocument != null)
                {
                    foreach (var employeeDocument in employee.EmployeeDocument)
                    {
                        employeeDocument.AttachedFileInfo = GetFiles(employeeDocument.AttachedFile).ToList();
                    }
                }
                if (employee.Qualification != null)
                {
                    employee.Qualification = employee.Qualification.OrderBy(x => x.GraduationYearDate).ToList();
                    foreach (var qualification in employee.Qualification)
                    {
                        qualification.QualificationFileInfo = GetFiles(qualification.QualificationAttached).ToList();
                    }
                }
                employee.PictureFileInfo = GetFilesContent(employee.Picture).FirstOrDefault();
                employee.CinFileInfo = GetFiles(employee.CinAttached).ToList();

                employee.EmployeeSkills = _entityEmployeeSkills.GetAllWithConditionsRelations(
                    x => x.IdEmployee == employee.Id && x.Rate > 0, x => x.IdSkillsNavigation)
                    .OrderByDescending(x => x.Rate)
                    .Select(_builderEmployeeSkills.BuildEntity).ToList();
                if (!IsUserInSuperHierarchicalEmployeeList(userMail, employee))
                {
                    employee.Notes = null;
                }
                if (employee.Contract != null)
                {
                    foreach (var contract in employee.Contract)
                    {
                        contract.ContractFileInfo = GetFiles(contract.ContractAttached).ToList();
                    }
                }
                return employee;
            }
            return null;
        }

        /// <summary>
        /// Disable employee pay fields
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private EmployeeViewModel DisableEmployeePayFields(EmployeeViewModel employee)
        {
            employee.IdPaymentType = null;
            employee.Rib = null;
            employee.SocialSecurityNumber = null;
            employee.Echelon = null;
            employee.Category = null;
            employee.ChildrenNumber = null;
            employee.ChildrenNoScholar = null;
            employee.ChildrenDisabled = null;
            employee.DependentParent = null;
            employee.MaritalStatus = null;
            employee.HomeLoan = null;
            employee.FamilyLeader = null;
            employee.IsForeign = false;
            return employee;
        }

        /// <summary>
        /// Enable Employee Pay Fields
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private EmployeeViewModel EnableEmployeePayFields(EmployeeViewModel employee, EmployeeViewModel employeeBeforeUpdate)
        {
            employee.IdPaymentType = employeeBeforeUpdate.IdPaymentType;
            employee.Rib = employeeBeforeUpdate.Rib;
            employee.SocialSecurityNumber = employeeBeforeUpdate.SocialSecurityNumber;
            employee.Echelon = employeeBeforeUpdate.Echelon;
            employee.Category = employeeBeforeUpdate.Category;
            employee.ChildrenNumber = employeeBeforeUpdate.ChildrenNumber;
            employee.ChildrenNoScholar = employeeBeforeUpdate.ChildrenNoScholar;
            employee.ChildrenDisabled = employeeBeforeUpdate.ChildrenDisabled;
            employee.DependentParent = employeeBeforeUpdate.DependentParent;
            employee.MaritalStatus = employeeBeforeUpdate.MaritalStatus;
            employee.HomeLoan = employeeBeforeUpdate.HomeLoan;
            employee.FamilyLeader = employeeBeforeUpdate.FamilyLeader;
            employee.IsForeign = employeeBeforeUpdate.IsForeign;
            return employee;
        }

        /// <summary>
        /// Check if id employee is in level of connected employee
        /// </summary>
        /// <param name="id"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        public bool IsPartOfHierarchy(int id, string level)
        {
            return !string.IsNullOrEmpty(level) && level.Split(PayRollConstant.LevelSeparator).ToArray().Contains(id.ToString());
        }

        /// <summary>
        /// this methode return -1 if employee has no superiors
        /// this methode return the id of the superior by level 
        /// if level does not exist it return the top hierarchy superior
        /// </summary>
        /// <param name="id"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        public int IdSuperiorOfEmployeeByLevel(int superiorLevel, string levelOfEmployee)
        {
            bool hasSuperiors = !string.IsNullOrEmpty(levelOfEmployee);
            if (hasSuperiors)
            {
                string[] superiorsArrayList = levelOfEmployee.Split(PayRollConstant.LevelSeparator).ToArray();
                if (superiorLevel >= superiorsArrayList.Length + NumberConstant.One)
                {
                    return int.Parse(superiorsArrayList[NumberConstant.Zero]);
                }
                else
                {
                    int superiorIndex = (superiorsArrayList.Length) - superiorLevel;
                    return int.Parse(superiorsArrayList[superiorIndex]);
                }
            }
            else
            {
                return NumberConstant.MinusOne;
            }
        }

        /// <summary>
        /// Get hierarchical List of employee without connected user if withTheSuperior = false
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="employees"></param>
        public void GetHierarchicalEmployeeList(string employeeMail, List<EmployeeViewModel> employees,
            bool withTheSuperior = false, PredicateFilterRelationViewModel<Employee> predicateFilterRelationViewModel = null)
        {
            EmployeeViewModel employee = GetModelsWithConditionsRelations(x => x.Email == employeeMail, x => x.InverseIdUpperHierarchyNavigation, x => x.EmployeeTeam).FirstOrDefault();
            if (employee != null)
            {
                if (withTheSuperior)
                {
                    employees.Add(employee);
                }
                if (employee.InverseIdUpperHierarchyNavigation != null && employee.InverseIdUpperHierarchyNavigation.Any())
                {
                    employee.InverseIdUpperHierarchyNavigation.ToList().ForEach(item =>
                    {
                        employees.Add(item);
                        GetHierarchicalEmployeeList(item.Email, employees, withTheSuperior, predicateFilterRelationViewModel);
                    });
                }
            }
        }

        public List<EmployeeViewModel> GetHierarchicalEmployeesList(string userMail, bool withTheSuperior = false, bool withTeamCollaborater = false, PredicateFormatViewModel predicateModel = null)
        {
            List<EmployeeViewModel> employees = new List<EmployeeViewModel>();
            string connectedEmployeeEmail = GetConnectedEmployee(userMail).Email;
            if (predicateModel != null)
            {
                if (predicateModel.Relation == null)
                {
                    predicateModel.Relation = new List<RelationViewModel>();
                }
                if (predicateModel.Filter == null)
                {
                    predicateModel.Filter = new List<FilterViewModel>();
                }
                predicateModel.Relation.Add(new RelationViewModel { Prop = nameof(Employee.InverseIdUpperHierarchyNavigation) });
                Operator key = predicateModel.Operator;
                Expression<Func<Employee, bool>> predicateFilter = PredicateUtility<Employee>.PredicateFilter(predicateModel, key);
                Expression<Func<Employee, object>>[] predicateRelation = PredicateUtility<Employee>.PredicateRelation(predicateModel.Relation);
                PredicateFilterRelationViewModel<Employee> predicateFilterRelationViewModel = new PredicateFilterRelationViewModel<Employee>(predicateFilter, predicateRelation);
                GetHierarchicalEmployeeList(connectedEmployeeEmail, employees, withTheSuperior, predicateFilterRelationViewModel);
            }
            else
            {
                GetHierarchicalEmployeeList(connectedEmployeeEmail, employees, withTheSuperior);
            }
            if (withTeamCollaborater)
            {
                employees.AddRange(GetEmployeeInConnectedUserTeam(userMail));
            }
            employees.Select(employee => { employee.IsResigned = VerifyEmployeeResigned(employee) ? true : false; return employee; }).ToList();
            return employees.Distinct(new EmployeeComparer()).OrderBy(m => m.LastName).ThenBy(m => m.FirstName).ToList();
        }

        /// <summary>
        /// Returns the list of employees belonging to the team of the logged-in user if he is Team Manager
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public IList<EmployeeViewModel> GetEmployeeInConnectedUserTeam(string userMail)
        {
            DateTime today = DateTime.Today.Date;
            UserViewModel userViewModel = _serviceUser.GetModel(x => x.Email == userMail);
            return userViewModel.IdEmployee != null ? FindModelsByNoTracked(x => x.EmployeeTeam.Any(t => t.IdTeamNavigation.State == true &&
                    (t.UnassignmentDate.HasValue && (DateTime.Compare(today.Date, t.AssignmentDate) >= NumberConstant.Zero
            && DateTime.Compare(today.Date, t.UnassignmentDate.Value.Date) <= NumberConstant.Zero) ||
                    !t.UnassignmentDate.HasValue && (DateTime.Compare(today.Date, t.AssignmentDate.Date) >= NumberConstant.Zero)) &&
                    t.IdTeamNavigation.IdManager == userViewModel.IdEmployee), x => x.EmployeeTeam).ToList() : new List<EmployeeViewModel>();


        }

        /// <summary>
        /// Get List of superiors 
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="employees"></param>
        public void GetSuperiorsHierarchicalEmployeeList(EmployeeViewModel employee, List<EmployeeViewModel> employees)
        {
            if (employee.IdUpperHierarchy != null && employee.IdUpperHierarchy != 0)
            {
                EmployeeViewModel superior = GetModelWithRelations(x => x.Id == employee.IdUpperHierarchy);
                if (superior != null)
                {
                    employees.Add(superior);
                    GetSuperiorsHierarchicalEmployeeList(superior, employees);
                }
            }
        }
        public List<UserViewModel> GetSuperiorsEmployeeAsUsers(int employeeId, bool withCurrentEmployee)
        {
            List<UserViewModel> users = new List<UserViewModel>();
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();
            EmployeeViewModel currentEmployee = GetModelById(employeeId);
            if (withCurrentEmployee)
            {
                employeesList.Add(currentEmployee);
            }
            GetSuperiorsHierarchicalEmployeeList(currentEmployee, employeesList);
            // get users list from employeeList
            if (employeesList.Any())
            {
                foreach (EmployeeViewModel employee in employeesList)
                {
                    UserViewModel user = _serviceUser.FindModelBy(x => x.IdEmployee == employee.Id).FirstOrDefault();
                    if (user != null)
                    {
                        users.Add(user);
                    }
                }
            }
            return users;
        }

        /// <summary>
        /// Returns the employee associated with the logged in user. If no employee is associated with him, create a fake Anonymous employee so that he does not catch.
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public EmployeeViewModel GetConnectedEmployee(string userMail)
        {
            UserViewModel user = GetUserByUserMail(userMail);
            if (user.IdEmployee == null)
            {
                return new EmployeeViewModel(true);
            }
            return GetModelAsNoTracked(x => x.Id == user.IdEmployee);
        }

        public EmployeeViewModel GetConnectedEmployee()
        {            
            string currentUserEmail = ActiveAccountHelper.GetConnectedUserEmail();
            return GetConnectedEmployee(currentUserEmail);
        }

        /// <summary>
        /// Get User by Email
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public UserViewModel GetUserByUserMail(string userMail)
        {
            return _serviceUser.GetModelAsNoTracked(x => x.Email.ToLower() == userMail.ToLower());
        }

        /// <summary>
        /// Get User by idEmployee
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <returns></returns>
        public UserViewModel GetUserByIdEmployee(int idEmployee)
        {
            return _serviceUser.FindByAsNoTracking(x => x.IdEmployee.HasValue && x.IdEmployee.Value.Equals(idEmployee)).FirstOrDefault();
        }

        public List<UserViewModel> GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(int idEmployee)
        {
            List<int> idEmployees = new List<int>
            {
                idEmployee
            };
            DateTime today = DateTime.Today.Date;
            Employee employee = _entityRepo.GetAllAsNoTracking()
                .Include(x => x.EmployeeTeam)
                .ThenInclude(x => x.IdTeamNavigation)
                .Where(x => x.Id == idEmployee).FirstOrDefault();
            idEmployees.AddRange(employee.EmployeeTeam.Where(x =>
                x.UnassignmentDate.HasValue && today.BetweenDateTimeLimitIncluded(x.AssignmentDate, x.UnassignmentDate.Value) ||
                !x.UnassignmentDate.HasValue && today.AfterDateLimitIncluded(x.AssignmentDate)).Select(x => x.IdTeamNavigation.IdManager).ToList());
            if (employee.IdUpperHierarchy != null)
            {
                idEmployees.Add((int)employee.IdUpperHierarchy);
            }
            List<UserViewModel> usersList = _serviceUser.FindModelsByNoTracked(x => idEmployees.Contains((int)x.IdEmployee)).ToList();
            List<int> employeesToInclude = idEmployees.Where(x => !usersList.Select(y => y.IdEmployee).Contains(x)).ToList();
            if (employeesToInclude != null && employeesToInclude.Count > NumberConstant.Zero)
            {
                List<Employee> employees = _entityRepo.FindByAsNoTracking(x => employeesToInclude.Contains(x.Id)).ToList();
                employees.ForEach(employeeToAdd =>
                {
                    usersList.Add(new UserViewModel
                    {
                        Email = employeeToAdd.Email
                    });
                });
            }
            return usersList;
        }

        /// <summary>
        /// verify if Is User In Super Hierarchical Employee List
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="employee"></param>
        /// <returns></returns>
        public bool IsUserInSuperHierarchicalEmployeeList(string userMail, EmployeeViewModel employee)
        {
            EmployeeViewModel connectedEmployee = GetConnectedEmployee(userMail);
            return IsPartOfHierarchy(connectedEmployee.Id, employee.HierarchyLevel);
        }

        /// <summary>
        /// Check if the connected user is in selected employee hierarchy
        /// </summary>
        /// <param name="connectedEmployeeId"></param>
        /// <param name="selectedEmployeeId"></param>
        /// <returns></returns>
        public bool IsInConnectedUserHierarchy(int connectedEmployeeId, int selectedEmployeeId)
        {
            string selectedEmployeeHierarchyLevel = base.GetModelById(selectedEmployeeId).HierarchyLevel;
            return IsPartOfHierarchy(connectedEmployeeId, selectedEmployeeHierarchyLevel);
        }

        /// <summary>
        /// return the not Crypted Password
        /// Generate Shared Documents Password if not generated and send it every time
        /// </summary>
        /// <param name="employeeId"></param>
        public string GetSharedDocumentsPasswordAndSendItEveryTime(int employeeId, string userMail, SmtpSettings smtpSettings)
        {
            Employee employee = _entityRepo.GetSingleNotTracked(e => e.Id == employeeId);
            Company company = _entityRepoCompany.GetSingle(x => true);
            string notCryptedPassword = GenerateOrUseSharedDocumentsPassword(employee,
                _appSettings.SharedDocumentsKey);
            PrepareAndSendSharedDocumentsPasswordEmail(employee, notCryptedPassword, userMail, smtpSettings);
            return notCryptedPassword;
        }

        /// <summary>
        /// return the not Crypted Password
        /// Generate And send Shared Documents Password if first generation
        /// </summary>
        /// <param name="employeeId"></param>
        /// <param name="userMail"></param>
        /// <param name="sharedDocumentsKey"></param>
        /// <param name="smtpSettings"></param>
        /// <returns></returns>
        public string GetSharedDocumentsPasswordAndSendItIfFirstGeneration(Employee employee, string userMail, SmtpSettings smtpSettings)
        {
            bool isFirstGeneration = employee.SharedDocumentsPassword == null || employee.SharedDocumentsPassword == "";
            Company company = _entityRepoCompany.GetSingle(x => true);
            string notCryptedPassword = GenerateOrUseSharedDocumentsPassword(employee, _appSettings.SharedDocumentsKey);

            if (isFirstGeneration)
            {
                PrepareAndSendSharedDocumentsPasswordEmail(employee, notCryptedPassword, userMail, smtpSettings);
            }

            return notCryptedPassword;
        }
        /// <summary>
        /// return the not Crypted Password
        /// Generate or use generated password
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="sharedDocumentsKey"></param>
        /// <returns></returns>
        public string GenerateOrUseSharedDocumentsPassword(Employee employee, string sharedDocumentsKey)
        {
            string notCryptedPassword;
            var context = (StarkContextFactory)_unitOfWork.GetContext();
            if (string.IsNullOrEmpty(employee.SharedDocumentsPassword))
            {
                var attachedEmployee = context.ChangeTracker.Entries<Employee>().FirstOrDefault(e => e.Entity.Id == employee.Id);
                if (attachedEmployee != null)
                {
                    context.Entry(attachedEmployee.Entity).State = EntityState.Detached;
                }

                notCryptedPassword = StringUtilityExtensions.GeneratePassword();
                employee.SharedDocumentsPassword = notCryptedPassword.Encrypt(sharedDocumentsKey);
                _entityRepo.Update(employee);
                _unitOfWork.Commit();
            }
            else
            {
                notCryptedPassword = employee.SharedDocumentsPassword.Decrypt(sharedDocumentsKey);
            }
            return notCryptedPassword;
        }
        /// <summary>
        /// Prepare And Send Shared Documents Password Email
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="notCryptedPassword"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void PrepareAndSendSharedDocumentsPasswordEmail(Employee employee, string notCryptedPassword, string userMail, SmtpSettings smtpSettings)
        {
            UserViewModel user = _serviceUser.GetModel(u => u.Email.ToLower() == employee.Email.ToLower());
            UserViewModel connectedUser = _serviceUser.GetModel(u => u.Email.ToLower() == userMail.ToLower());
            string lang = user != null && user.Lang != null && !string.IsNullOrEmpty(user.Lang) ? user.Lang : connectedUser.Lang;
            EmailViewModel generatedEmail = new EmailViewModel
            {
                Subject = GenerateSharedDocumentsPasswordSubjectByCulture(lang),
                Body = PrepareSharedDocumentsPassword(employee, connectedUser, notCryptedPassword, lang, userMail),
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = employee.Email
            };
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
        }

        /// <summary>
        /// Prepare Shared Documents Password
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="user"></param>
        /// <param name="notCryptedPassword"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private string PrepareSharedDocumentsPassword(Employee employee, UserViewModel connectUser, string notCryptedPassword, string lang, string userMail)
        {
            string templateRoot;
            switch (lang)
            {
                case "fr":
                    templateRoot = @Constants.SHARED_DOCUMENTS_PASSWORD_EMAIL_PATH_FR;
                    break;
                case "en":
                    templateRoot = @Constants.SHARED_DOCUMENTS_PASSWORD_EMAIL_PATH_EN;
                    break;
                default:
                    templateRoot = @Constants.SHARED_DOCUMENTS_PASSWORD_EMAIL_PATH_EN;
                    break;
            }
            string body = _serviceEmail.GetEmailHtmlContentFromFile(templateRoot);
            body = body.Replace("{EMPLOYEE_NAME}", employee.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{PASSWORD}", notCryptedPassword, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_EMAIL}", userMail, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", connectUser.FullName, StringComparison.OrdinalIgnoreCase);
            return body;
        }
        /// <summary>
        /// Generate Shared Documents Password Subject By Culture
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        private static string GenerateSharedDocumentsPasswordSubjectByCulture(string culture)
        {
            string subject = "";
            switch (culture)
            {
                case "fr":
                    subject = "Mot de passe des documents partagés";
                    break;
                case "en":
                    subject = "Shared documents password";
                    break;
                default:
                    subject = "Shared documents password";
                    break;
            }

            return subject;
        }

        /// <summary>
        /// Allows to check the unicity of identity information, email and employee documents.
        /// </summary>
        /// <param name="employee"></param>
        private void CheckUniqueCase(EmployeeViewModel employee)
        {
            if (!string.IsNullOrEmpty(employee.Cin))
            {
                if (FindModelBy(result => result.Cin.Equals(employee.Cin) && result.Id != employee.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.SameCinNumber);
                }
                else if (employee.Cin.Length != NumberConstant.Eight)
                {
                    throw new CustomException(CustomStatusCode.InvalidCinLength);
                }
            }
            if (!string.IsNullOrEmpty(employee.Email) && FindModelBy(result => result.Email.Equals(employee.Email) && result.Id != employee.Id).Any())
            {
                throw new CustomException(CustomStatusCode.CandidateEmailIsAlreadyEmployeeEmail);
            }
            if (!string.IsNullOrEmpty(employee.SocialSecurityNumber) && FindModelBy(result => result.SocialSecurityNumber.Equals(employee.SocialSecurityNumber) &&
                result.Id != employee.Id).Any())
            {
                throw new CustomException(CustomStatusCode.SameCnssNumber);
            }
            if (employee.EmployeeDocument != null && employee.EmployeeDocument.Any())
            {
                foreach (EmployeeDocumentViewModel employeeDocument in employee.EmployeeDocument)
                {
                    if (!string.IsNullOrEmpty(employeeDocument.Value) && _serviceEmployeeDocument.FindModelBy(result => result.Value.Equals(employeeDocument.Value) &&
                        result.Label.Equals(employeeDocument.Label) && result.Id != employeeDocument.Id).Any())
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { Constants.EMPLOYEE_DOCUMENT_LABEL, employeeDocument.Label}
                        };
                        throw new CustomException(CustomStatusCode.EmployeeIdendityPapersViolation, paramtrs);
                    }
                }
            }
            if (!string.IsNullOrEmpty(employee.Rib) && FindModelBy(result => result.Rib.Equals(employee.Rib) && result.Id != employee.Id).Any())
            {
                throw new CustomException(CustomStatusCode.DuplicatedEmployeeRibException);
            }
            // Manage employee nationality
            if (employee.IdCitizenship == null)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { Constants.EMPLOYEE, employee.FirstName + " " + employee.LastName}
                        };
                throw new CustomException(CustomStatusCode.INVALID_IDCITIZENSHIP, paramtrs);
            }
        }

        public bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail)
        {
            // check if user has the right to validate the request 
            List<int> hierarchicalEmployeesList = GetHierarchicalEmployeesList(userMail).Select(x => x.Id).ToList();
            IList<EmployeeViewModel> employeeInTeams = GetEmployeeInConnectedUserTeam(userMail);
            hierarchicalEmployeesList.AddRange(employeeInTeams.Select(x => x.Id));
            return hierarchicalEmployeesList.Contains(idEmployee);
        }

        public IList<EmployeeViewModel> GetEmployeeWithSkill(int idSkill)
        {
            Expression<Func<Employee, bool>> conditions = x => x.EmployeeSkills.Count > NumberConstant.Zero
                && x.EmployeeSkills.Any(y => y.IdSkills == idSkill);
            if (!RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES))
            {
                conditions = conditions.And(x => x.Status != (int)EmployeeState.Resigned);
            }
            return GetModelsWithConditionsRelations(conditions).ToList();
        }

        /// <summary>
        /// return list of all employees who have at least one payslip in specefic year
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public IList<EmployeeViewModel> GetEmployeesHasPayslip(int year)
        {
            if (year == NumberConstant.Zero)
            {
                return new List<EmployeeViewModel>();
            }
            return GetModelsWithConditionsRelations(x => x.Payslip.Any(y => y.Month.Year == year)).ToList();
        }

        // Synchronize employees hierarchical level
        public void SynchronizeEmployees()
        {
            List<Employee> employeesWithNoUpperHierarchy = _entityRepo.GetAllWithConditionsQueryable(x => x.IdUpperHierarchy == null).ToList();
            List<Employee> employeesToUpdate = new List<Employee>();
            employeesWithNoUpperHierarchy.ForEach(employee =>
            {
                employee.HierarchyLevel = null;
                employeesToUpdate.AddRange(GetLowerEmployees(employee));
            });
            if (employeesToUpdate.Count > NumberConstant.Zero)
            {
                BulkUpdateWithoutTransaction(employeesToUpdate);
            }
        }

        // Recursive method which update every employee hierarchical level
        public IList<Employee> GetLowerEmployees(Employee employee)
        {
            List<Employee> employees = new List<Employee>();
            List<Employee> lowerEmployees = _entityRepo.GetAllWithConditionsQueryable(x => x.IdUpperHierarchy == employee.Id).ToList();
            if (lowerEmployees.Count > NumberConstant.Zero)
            {
                lowerEmployees = employee.HierarchyLevel.NotNullOrEmpty() ?
                    lowerEmployees.Select(x => { x.HierarchyLevel = employee.HierarchyLevel + PayRollConstant.LevelSeparator + employee.Id.ToString(); return x; }).ToList() :
                    lowerEmployees.Select(x => { x.HierarchyLevel = employee.Id.ToString(); return x; }).ToList();
                employees.AddRange(lowerEmployees);
                lowerEmployees.ForEach(lower =>
                {
                    employees.AddRange(GetLowerEmployees(lower));
                });
            }
            return employees;
        }
        /// <summary>
        /// verify if the employee has resigned 
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        public static bool VerifyEmployeeResigned(EmployeeViewModel employee)
        {
            if (employee.ResignationDate.HasValue && employee.Status == (int)EmployeeState.Resigned)
            {
                if (DateTime.Now.AfterDateLimitIncluded(employee.ResignationDate.Value))
                {
                    return true;
                }

            }
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<ReducedEmployeeViewModel> GetEmployeeDropdownWithPredicate(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<ReducedEmployeeViewModel> dataSourceResult = new DataSourceResult<ReducedEmployeeViewModel>();
            PredicateFilterRelationViewModel<Employee> predicateFilterRelationModel = PreparePredicate(predicateModel);
            if (!RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES))
            {
                predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(x => x.Status != (int)EmployeeState.Resigned);
            }
            IQueryable<Employee> employees = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                                        .Include(m => m.ExitEmployee)
                                                        .OrderByRelation(predicateModel.OrderBy)
                                                        .Where(predicateFilterRelationModel.PredicateWhere);
            List<EmployeeViewModel> result = employees.Select(x => _builder.BuildEntity(x)).ToList();
            result.Select(employee => { employee.IsResigned = VerifyEmployeeResigned(employee) ? true : false; return employee; }).ToList();
            dataSourceResult.data = result.Select(x => new ReducedEmployeeViewModel
            {
                Id = x.Id,
                FirstName = x.FirstName,
                LastName = x.LastName,
                IsResigned = x.IsResigned,
                FullName = x.FullName,
                Email = x.Email,
                Status = x.Status,
                HiringDate = x.HiringDate,
                ResignationDate = x.ResignationDate
            }).ToList();
            dataSourceResult.total = result.Count;
            return dataSourceResult;
        }

        /// <summary>
        /// FindDataSourceModelBy ovveridde version of employee
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override DataSourceResult<EmployeeViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            Expression<Func<Employee, bool>> employeeListOnWichExpressionIsCheckedExpression = EmployeeListOnWichExpressionIsChecked(predicateModel);
            Expression<Func<Employee, bool>> idEmployeesExpression = IdEmployeesExpression(predicateModel);
            Expression<Func<Employee, bool>> employeeTeamExpression = EmployeeTeamExpression(predicateModel);
            // Prepare the predicate
            PredicateFilterRelationViewModel<Employee> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // Combine status expression
            predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(employeeListOnWichExpressionIsCheckedExpression);
            predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(idEmployeesExpression);
            predicateFilterRelationModel.PredicateWhere = predicateFilterRelationModel.PredicateWhere.And(employeeTeamExpression);
            DataSourceResult<EmployeeViewModel> dataSourceResult = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            GetCurrentEmployeeContract(dataSourceResult);
            return dataSourceResult;
        }

        /// <summary>
        /// Get current contract for each employee
        /// </summary>
        /// <param name="dataSourceResult"></param>
        private void GetCurrentEmployeeContract(DataSourceResult<EmployeeViewModel> dataSourceResult)
        {
            if (dataSourceResult.data.Count > NumberConstant.Zero)
            {
                List<int> employeeIds = dataSourceResult.data.Select(x => x.Id).ToList();
                List<ContractViewModel> contracts = _serviceContract.FindModelsByNoTracked(x => employeeIds.Contains(x.IdEmployee), x => x.IdContractTypeNavigation, x => x.IdSalaryStructureNavigation).ToList();
                dataSourceResult.data.ToList().ForEach(employee =>
                {
                    employee.CurrentContract = contracts.OrderByDescending(x => x.StartDate).FirstOrDefault(x => x.IdEmployee == employee.Id);
                });
            }
        }

        /// <summary>
        /// If the logged in user has LIST-EMPLOYEE permission, do not make any restrictions other than check against the privileges and his position to which employees he has access. 
        /// This method takes into account the employee's status with a LOGICAL AND.
        /// </summary>
        /// <param name="userMail"></param>
        private Expression<Func<Employee, bool>> EmployeeListOnWichExpressionIsChecked(PredicateFormatViewModel predicateModel)
        {
            Expression<Func<Employee, bool>> statusExpression = x => true;
            Expression<Func<Employee, bool>> accessExpression = x => true;
            if (predicateModel.Filter.Any(p => p.Prop == nameof(Employee.Status)))
            {
                int status = Convert.ToInt32(predicateModel.Filter.Where(p => p.Prop == nameof(Employee.Status)).Select(p => p.Value).FirstOrDefault());
                int secondStatus = Convert.ToInt32(predicateModel.Filter.Where(p => p.Prop == nameof(Employee.Status)).Select(p => p.Value).LastOrDefault());
                statusExpression = x => x.Status == status || x.Status == secondStatus;
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(Employee.Status)).ToList();
            }
            if (!RoleHelper.HasPermission("LIST_EMPLOYEE"))
            {
                string userMail = ActiveAccountHelper.GetConnectedUserEmail();
                EmployeeViewModel connectedEmployee = GetConnectedEmployee(userMail);
                List<int> employeesListIds = new List<int>();
                // Get employees from connected employee same team
                // Get jobs ids from connected user job privilege
                List<int> jobsIds = _serviceJob.GetJobsIdsFromPrivilege(connectedEmployee.Id);
                // Get employee ids which have jobs corresponding to jobs from privilege
                List<int> employeeIdsFromEmployeeJobs = _serviceJobEmployee.GetModelsWithConditionsRelations(x => jobsIds.Contains(x.IdJob.Value))
                    .Select(x => x.IdEmployee).Select(x => x.Value).Distinct().ToList();
                employeesListIds.AddRange(employeeIdsFromEmployeeJobs);
                // Get employee ids from connected employee privilege
                IList<int> employeeIdsFromEmployeePrivilege = _serviceUserPrivilege.GetEmployeesWithConnectedUserPrivilege(userMail, connectedEmployee, Constants.EMPLOYEE).Select(x => x.Id).ToList();
                employeesListIds.AddRange(employeeIdsFromEmployeePrivilege);
                accessExpression = x => (!string.IsNullOrEmpty(x.HierarchyLevel) && IsPartOfHierarchy(connectedEmployee.Id, x.HierarchyLevel)) || (x.Id == connectedEmployee.Id) || employeesListIds.Distinct().Contains(x.Id);
            }
            return statusExpression.And(accessExpression);
        }

        /// <summary>
        /// Process predicates with filters on employee Ids
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        private Expression<Func<Employee, bool>> IdEmployeesExpression(PredicateFormatViewModel predicateModel)
        {
            Expression<Func<Employee, bool>> idEmployeeExpression = x => true;
            if (predicateModel.Filter.Any(p => p.Prop == nameof(Employee.Id)))
            {
                predicateModel.Filter.Where(p => p.Prop == nameof(Employee.Id)).Select(p => new { p.Operation, Value = Convert.ToInt32(p.Value) }).ToList().ForEach(m =>
                {
                    Expression<Func<Employee, bool>> idEmployee = x => m.Operation == Operation.Equals ? x.Id == m.Value : x.Id != m.Value;
                    idEmployeeExpression = idEmployeeExpression.And(idEmployee);
                });
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(Employee.Id)).ToList();
            }
            return idEmployeeExpression;
        }

        /// <summary>
        /// Retrieves the list of employees belonging to the teams contained in the Idteam filters on the current date
        /// </summary>
        /// <param name="predicateModel"></param>
        private Expression<Func<Employee, bool>> EmployeeTeamExpression(PredicateFormatViewModel predicateModel)
        {
            Expression<Func<Employee, bool>> teamExpression = x => true;
            if (predicateModel.Filter.Any(p => p.Prop == nameof(EmployeeTeam.IdTeam)))
            {
                DateTime today = DateTime.Today;
                List<int> idTeams = predicateModel.Filter.Where(p => p.Prop == nameof(EmployeeTeam.IdTeam)).Select(p => Convert.ToInt32(p.Value)).ToList();
                teamExpression = x => x.EmployeeTeam.Any(m => idTeams.Contains(m.IdTeam) && m.IdTeamNavigation.State &&
                   (m.UnassignmentDate.HasValue && today.BetweenDateLimitIncluded(m.AssignmentDate, m.UnassignmentDate.Value) ||
                   !m.UnassignmentDate.HasValue && today.AfterDateLimitIncluded(m.AssignmentDate)));
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(EmployeeTeam.IdTeam)).ToList();
            }
            return teamExpression;
        }

        public IList<EmployeeViewModel> GetNotAssociatedEmployees()
        {
            return FindModelsByNoTracked(x => !x.User.Any(m => m.IdEmployee == x.Id)).ToList();
        }
        /// <summary>
        /// Delete employee
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            Candidate candidate = _entityCandidate.FindByAsNoTracking(e => e.IdEmployee == id).FirstOrDefault();
            if (candidate != null)
            {
                candidate.IdEmployee = null;
                _entityCandidate.Update(candidate);
            }
            List<EmployeeViewModel> employees = FindByAsNoTracking(e => e.IdUpperHierarchy == id).ToList();
            if (employees.Count != NumberConstant.Zero)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { Constants.FULL_NAME, GetModel(x=> x.Id == id).FullName },
            };
                throw new CustomException(CustomStatusCode.DeleteEmployeeError, paramtrs);
            }
            //get EmployeeTeams attached to employee 
            List<EmployeeTeam> employeeTeam = _repoEmployeeTeam.GetAllWithConditionsRelationsAsNoTracking(x => x.IdEmployee == id, y => y.IdTeamNavigation).ToList();
            //get attached Teams to employee 
            List<Team> teamsAttachedToEmployee = employeeTeam.Select(x => x.IdTeamNavigation).ToList();
            //update NumberOfAffected in all teams attached to employee
            teamsAttachedToEmployee.ForEach(t => t.NumberOfAffected = t.NumberOfAffected - NumberConstant.One);
            _repoTeam.BulkUpdate(teamsAttachedToEmployee);
           return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        /// <summary>
        /// Check if the employee is still available for operation
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="date"></param>
        public void ValidateResignedStatusEmployee(int idEmployee, DateTime? date = null)
        {
            EmployeeViewModel employee = GetModelById(idEmployee);
            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { Constants.EMPLOYEE, employee.FullName },
            };
            if (employee.Status == (int)EmployeeState.Resigned)
            {
                throw new CustomException(CustomStatusCode.ActionNotAllowedWithResignedEmployee, paramtrs);
            }
            if (employee.ResignationDate.HasValue && date.HasValue && employee.ResignationDate.Value.BeforeDate(date.Value))
            {
                throw new CustomException(CustomStatusCode.ValidateResignedEmployee, paramtrs);
            }
        }

        /// <summary>
        /// Update employee stauts througth job
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="userMail"></param>
        public void UpdateEmployeesStatusJob(string connectionString, string userMail)
        {
            try
            {
                BeginTransaction(connectionString);
                DateTime today = DateTime.Today;
                IList<Employee> employees = _entityRepo.FindByAsNoTracking(x => x.Status == (int)EmployeeState.Resigning).ToList();
                employees.ToList().ForEach(employee =>
                {
                    try
                    {
                        employee.Contract = _entityContract.GetAllWithConditionsRelationsQueryable(x => x.IdEmployee == employee.Id,
                            m => m.BaseSalary,
                            m => m.ContractBonus,
                            m => m.ContractBenefitInKind).ToList(); 
                        employee.Status = employee.ResignationDate.HasValue && DateTime.Compare(employee.ResignationDate.Value, today) <= NumberConstant.Zero ? (int)EmployeeState.Resigned : (int)EmployeeState.Resigning;
                        if (employee.Status == (int)EmployeeState.Resigned && !employee.ResignedFromExitEmployee)
                        {
                            ResignedEmployeeActionsToDo(employee);
                        }
                    }
                    catch (Exception e)
                    {
                    }
                });
                _entityRepo.BulkUpdate(employees);
                _unitOfWork.Commit();
                SynchronizeEmployees();
                EndTransaction();
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
        /// Desactivate associated users, close contract, release from teams and assign new superior to employees who have him as superior
        /// </summary>
        /// <param name="employee"></param>
        private void ResignedEmployeeActionsToDo(Employee employee)
        {
            // Desactivate users
            List<UserViewModel> usersToDesactivate = _serviceUser.FindByAsNoTracking(x => x.IdEmployee == employee.Id).ToList();
            _serviceUser.DesactivateMassiveUsers(usersToDesactivate);
            // Close contracts
            employee.Contract = employee.Contract.Where(x => x.State != (int)ContractStateEnumerator.Expired).ToList();

            // Check if there are planified contracts for resigned employee and delete them  
            List<Contract> contractsToDelete = employee.Contract.Where(x => DateTime.Compare(x.StartDate, employee.ResignationDate.Value) >= NumberConstant.Zero).ToList();
            if (contractsToDelete != null && contractsToDelete.Any())
            {
                employee.Contract = employee.Contract.Where(x => contractsToDelete.All(y => y.Id != x.Id)).ToList();
                _serviceContract.DeletedAssociateSession(contractsToDelete.Select(x => x.Id).ToArray());
            }
            // Close contracts
            employee.Contract.Select(x => { x.EndDate = employee.ResignationDate; return x; }).ToList();
            _serviceContract.UpdateContractsState(employee.Contract.ToList());
            // Release employee from teams
            IList<EmployeeTeamViewModel> employeeTeams = _serviceEmployeeTeam.FindByAsNoTracking(x => x.IdEmployee == employee.Id).ToList();
            employeeTeams.ToList().ForEach(employeeTeam =>
            {
                employeeTeam.IsAssigned = false;
                if (employeeTeam.AssignmentDate.Value.AfterDate(employee.ResignationDate.Value))
                {
                    employeeTeam.IsDeleted = true;
                }
                else
                {
                    employeeTeam.UnassignmentDate = employee.ResignationDate;
                }
            });
            _serviceEmployeeTeam.BulkUpdateModelWithoutTransaction(employeeTeams, null);
            // Assign new superior
            List<Employee> lowerEmployees = _entityRepo.FindByAsNoTracking(x => x.IdUpperHierarchy == employee.Id).ToList();
            lowerEmployees.ForEach(lowerEmployee =>
           {
               if (lowerEmployee.IdUpperHierarchy == employee.Id)
               {
                   lowerEmployee.IdUpperHierarchy = employee.IdUpperHierarchy;
               }
           });
            employee.IdUpperHierarchy = null;
            employee.HierarchyLevel = null;
            _entityRepo.BulkUpdate(lowerEmployees);
        }

        /// <summary>
        /// Check if connected user is team manager or hierarchic of selected employee
        /// </summary>
        /// <param name="idconnectedEmployee"></param>
        /// <returns></returns>
        public bool IsConnectedUserTeamManagerOrHierarchic(int idSelectedEmployee)
        {
            EmployeeViewModel connectedEmployee = GetConnectedEmployee(ActiveAccountHelper.GetConnectedUserEmail());
            return connectedEmployee.Id != NumberConstant.Zero ? IsInConnectedUserHierarchy(connectedEmployee.Id, idSelectedEmployee)
                || (idSelectedEmployee != connectedEmployee.Id && _repoTeam.FindByAsNoTracking(x => x.State && x.IdManager == connectedEmployee.Id
                        && x.EmployeeTeam.Any(y => y.IdEmployee == idSelectedEmployee && y.IsAssigned)).Any()) : false;
        }

        public int GetConnectedEmployeeId(string userMail)
        {
            return GetConnectedEmployee(userMail).Id;             
        }

    }
}
