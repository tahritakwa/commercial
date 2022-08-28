using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceBillingSession : Service<BillingSessionViewModel, BillingSession>, IServiceBillingSession
    {
        private readonly IServiceTimeSheetCountDays _serviceTimeSheet;
        private readonly IServiceEmployeeProject _serviceEmployeeProject;
        private readonly IServiceBillingEmployee _serviceBillingEmployee;
        private readonly IServiceDocument _serviceDocument;
        private readonly Company company;

        public ServiceBillingSession(IRepository<BillingSession> entityRepo, IRepository<Company> entityRepoCompany,
            IUnitOfWork unitOfWork, IBillingSessionBuilder billingSessionBuilder,
            IServiceTimeSheetCountDays serviceTimeSheet, IServiceEmployeeProject serviceEmployeeProject, IServiceBillingEmployee serviceBillingEmployee,
            IServiceDocument serviceDocument, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings, IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification)
           : base(entityRepo, unitOfWork, billingSessionBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceTimeSheet = serviceTimeSheet;
            _serviceEmployeeProject = serviceEmployeeProject;
            _serviceBillingEmployee = serviceBillingEmployee;
            _serviceDocument = serviceDocument;
            company = _entityRepoCompany.GetSingleNotTracked(m => true);
        }

        /// <summary>
        /// Return an object that spacify for all employees passed in as parameters
        /// the list of projects assigned to each employee with the number of days worked by this employee on each project.
        /// </summary>
        /// <param name="month"></param>
        /// <param name="employeeIds"></param>
        /// <returns></returns>
        public IList<dynamic> GetTimeSheetDetailsByEmployee(int IdBillingSession)
        {
            BillingSessionViewModel billingSessionViewModel = GetModelAsNoTracked(x => x.Id == IdBillingSession);

            IList<BillingEmployeeViewModel> billingEmployeeViewModels = _serviceBillingEmployee.FindModelsByNoTracked(x => x.IdBillingSession == IdBillingSession,
                x => x.IdProjectNavigation,
                x => x.IdProjectNavigation.IdCurrencyNavigation,
                x => x.IdEmployeeNavigation);

            IList<TimeSheetViewModel> timeSheetAssociatedToEmployees = _serviceTimeSheet.FindModelsByNoTracked(x => billingEmployeeViewModels.Select(b => b.IdEmployee).Contains(x.IdEmployee)
                && x.Month.BetweenDateLimitIncluded(billingSessionViewModel.Month, billingSessionViewModel.Month.LastDateOfMonth()), x => x.TimeSheetLine).ToList();

            foreach (BillingEmployeeViewModel billingEmployeeViewModel in billingEmployeeViewModels)
            {
                billingEmployeeViewModel.IdTimeSheetNavigation = timeSheetAssociatedToEmployees.FirstOrDefault(x => x.IdEmployee == billingEmployeeViewModel.IdEmployee);
                // count numbber days leaves
                _serviceTimeSheet.CalculateTimeSheetDaysHours(billingEmployeeViewModel.IdTimeSheetNavigation, company.TimeSheetPerHalfDay.Value);
                DocumentViewModel doc = _serviceDocument.GetModel(y => y.IdTimeSheet == billingEmployeeViewModel.IdTimeSheet && y.IdProject == billingEmployeeViewModel.IdProject && y.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoice));
                if (doc != null)
                {
                    billingEmployeeViewModel.IdDocumentNavigation = doc;
                }
                // ARD = TJM
                List<AdrDetail> adrDetails = new List<AdrDetail>();
                Dictionary<double, double> NumberOfDaysWorkedByTJM = _serviceTimeSheet.NumberOfDaysWorkedByProjectInTimeSheet(billingEmployeeViewModel.IdTimeSheetNavigation != null ? billingEmployeeViewModel.IdTimeSheet : 0, billingEmployeeViewModel.IdProject);
                // If the project is mentioned in timeSheet
                if (NumberOfDaysWorkedByTJM.Count > NumberConstant.Zero)
                {
                    foreach (var key in NumberOfDaysWorkedByTJM.Keys)
                    {
                        AdrDetail adrDetail = new AdrDetail
                        {
                            // get the TJM of the project 
                            AverageDailyRate = key,
                            NumberWorkedDays = Math.Round(NumberOfDaysWorkedByTJM[key], NumberConstant.Two)
                        };
                        adrDetails.Add(adrDetail);
                    }
                }
                else
                {
                    // If the project is Not mentioned in timeSheet or if the timesheet is null 
                    List<EmployeeProjectViewModel> employeeProjectViewModel = _serviceEmployeeProject.FindByAsNoTracking(
                          x => (x.IdEmployee == billingEmployeeViewModel.IdEmployee && x.IdProject == billingEmployeeViewModel.IdProject &&
                             (
                                (x.AssignmentDate.BeforeDate(billingSessionViewModel.Month)
                                  && (
                                        !x.UnassignmentDate.HasValue
                                        || (x.UnassignmentDate.HasValue && x.UnassignmentDate.Value.AddDays(-NumberConstant.One).AfterDateLimitIncluded(billingSessionViewModel.Month))
                                     )
                                )
                               || x.AssignmentDate.BetweenDateLimitIncluded(billingSessionViewModel.Month, billingSessionViewModel.Month.LastDateOfMonth())
                             ) && x.IsBillable
                          )
                    ).ToList();
                    foreach (var employeeProject in employeeProjectViewModel)
                    {
                        AdrDetail adrDetail = new AdrDetail();
                        // get the TJM of the project 
                        double TJM = (employeeProject.AverageDailyRate.HasValue && employeeProject.AverageDailyRate.Value > NumberConstant.Zero) ?
                            (double)employeeProject.AverageDailyRate : (double)billingEmployeeViewModel.IdProjectNavigation.AverageDailyRate;
                        adrDetail.AverageDailyRate = TJM;
                        adrDetail.NumberWorkedDays = NumberConstant.Zero;
                        adrDetails.Add(adrDetail);
                    }
                }
                billingEmployeeViewModel.AdrDetails = adrDetails;
                billingEmployeeViewModel.CanEdit = adrDetails.Any(x => x.NumberWorkedDays > NumberConstant.Zero);
            }
            IList<dynamic> billingEmployeesGrouByEmployees = new List<dynamic>();
            billingEmployeeViewModels.Select(x => x.IdEmployee).Distinct().ToList().ForEach(idEmployee =>
            {
                BillingEmployeeViewModel currentBillingEmployeeViewModel = billingEmployeeViewModels.FirstOrDefault(x => x.IdEmployee == idEmployee);
                billingEmployeesGrouByEmployees.Add(new
                {
                    currentBillingEmployeeViewModel.IdEmployeeNavigation,
                    currentBillingEmployeeViewModel.IdTimeSheetNavigation,
                    BillingEmployee = billingEmployeeViewModels.Where(x => x.IdEmployee == idEmployee).ToList()
                });
            });
            return billingEmployeesGrouByEmployees;
        }


        /// <summary>
        /// add without transaction a billingSession based on the state
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(BillingSessionViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            BillingSessionViewModel newBillingSessionViewModel = new BillingSessionViewModel();
            if (model.State.Equals((int)BillingSessionStateViewModel.New))
            {
                newBillingSessionViewModel = NewAddModelTreatment(model, userMail, property);
            }
            else
            {
                newBillingSessionViewModel = UpdateModelTreatment(model, userMail);
            }
            // Close the transaction
            return newBillingSessionViewModel;
        }

        public override object UpdateModelWithoutTransaction(BillingSessionViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.State == (int)BillingSessionStateViewModel.Closed)
            {
                IList<BillingEmployeeViewModel> billingEmployeesWithNotvalidatedTimeSheets = _serviceBillingEmployee.FindModelsByNoTracked(x => x.IdBillingSession == model.Id
                    && x.IdTimeSheetNavigation.Status != (int)TimeSheetStatusEnumerator.Validated);
                // Throw exception when there are timesheets not validated
                if (billingEmployeesWithNotvalidatedTimeSheets.Any())
                {
                    throw new CustomException(CustomStatusCode.CannotCloseBillingSession);
                }
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        /// <summary>
        /// add new billingSession when the state is new
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public BillingSessionViewModel NewAddModelTreatment(BillingSessionViewModel billingsessionViewModel, string userMail, string property)
        {
            if (CheckUnicityPerMonth(billingsessionViewModel))
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SESSION_NUMBER_NOT_UNIQUE);
            }
            // Initiate the creation date of the Billingsession to the current date
            billingsessionViewModel.CreationDate = DateTime.Now;
            // Force the day of the month of the Billingsession to first day of month. Actually we only need the month and the year
            billingsessionViewModel.Month = billingsessionViewModel.Month.FirstDateOfMonth();
            // Make the state of Billingsession to Attendance 
            billingsessionViewModel.State = (int)BillingSessionStateViewModel.Project;
            // 
            billingsessionViewModel.BillingEmployee = AddBillingEmploye(billingsessionViewModel.BillingEmployee, billingsessionViewModel.Id, billingsessionViewModel.Month);
            // Save the Billingsession credentials data in database
            object Result = base.AddModelWithoutTransaction(billingsessionViewModel, null, userMail, property);
            // Set the id of BillingsessionviewModel with their id in database
            billingsessionViewModel.Id = ((CreatedDataViewModel)Result).Id;
            return billingsessionViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        public IList<BillingEmployeeViewModel> AddBillingEmploye(ICollection<BillingEmployeeViewModel> billingEmployeeViewModels, int idSession, DateTime month)
        {
            List<BillingEmployeeViewModel> newBillingEmployeeViewModels = new List<BillingEmployeeViewModel>();
            billingEmployeeViewModels.ToList().ForEach(billingEmployee =>
            {
                List<ProjectViewModel> projectViewModels = _serviceEmployeeProject.GetProjectsAffectedToTheEmployee(billingEmployee.IdEmployee, month);
                List<int> idProjecs = projectViewModels.Select(x => x.Id).Except(billingEmployeeViewModels.Where(x => x.IdEmployee == billingEmployee.IdEmployee).Select(x => x.IdProject).ToList()).ToList();
                idProjecs.ForEach(idProject =>
                {
                    newBillingEmployeeViewModels.Add(new BillingEmployeeViewModel
                    {
                        Id = NumberConstant.Zero,
                        IdBillingSession = idSession,
                        IdEmployee = billingEmployee.IdEmployee,
                        IdProject = idProject,
                        IdTimeSheet = billingEmployee.IdTimeSheet
                    });
                });
            });
            return newBillingEmployeeViewModels;
        }


        /// <summary>
        /// update billingSession
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public BillingSessionViewModel UpdateModelTreatment(BillingSessionViewModel billingsessionViewModel, string userMail)
        {
            if (billingsessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            UpdatedChangedSessionData(billingsessionViewModel, userMail);
            return billingsessionViewModel;
        }


        /// <summary>
        /// Update Changed BillingSessionData
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private bool UpdatedChangedSessionData(BillingSessionViewModel billingsessionViewModel, string userMail)
        {
            if (billingsessionViewModel == null || string.IsNullOrWhiteSpace(userMail))
            {
                throw new ArgumentException("");
            }
            SessionChangedData<BillingEmployeeViewModel> billingEmployeeChangedData = GetChangedBillingEmployee(billingsessionViewModel);
            if (billingEmployeeChangedData.AddedData.Any() || billingEmployeeChangedData.DeletedData.Any())
            {
                BillingEmployeeUpdateModelTreatment(billingsessionViewModel, billingEmployeeChangedData, userMail);
                return true;
            }
            return false;
        }


        /// <summary>
        /// Change BillingEmployee
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        /// <returns></returns>
        private SessionChangedData<BillingEmployeeViewModel> GetChangedBillingEmployee(BillingSessionViewModel billingsessionViewModel)
        {
            if (billingsessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            BillingSessionViewModel beforeUpdateSessionViewModel = GetModelWithRelationsAsNoTracked(session => session.Id == billingsessionViewModel.Id, session => session.BillingEmployee);
            if (beforeUpdateSessionViewModel.Title != billingsessionViewModel.Title
                || !beforeUpdateSessionViewModel.Month.ToShortDateString().Equals(billingsessionViewModel.Month.ToShortDateString()))
            {
                UpdateWithoutCollectionsWithoutTransaction(billingsessionViewModel);
                if (!beforeUpdateSessionViewModel.Month.ToShortDateString().Equals(billingsessionViewModel.Month.ToShortDateString()))
                {
                    SessionChangedData<BillingEmployeeViewModel> sessionChangedDataByMonth = new SessionChangedData<BillingEmployeeViewModel>
                    {
                        AddedData = billingsessionViewModel.BillingEmployee,
                        DeletedData = beforeUpdateSessionViewModel.BillingEmployee
                    };
                    sessionChangedDataByMonth.AddedData.ToList().ForEach(session => session.IdBillingSession = billingsessionViewModel.Id);
                    return sessionChangedDataByMonth;
                }
            }
            IList<BillingEmployeeViewModel> oldSessionEmployeeViewModels = _serviceBillingEmployee.FindModelsByNoTracked(sessionEmp => sessionEmp.IdBillingSession == billingsessionViewModel.Id).ToList();
            IList<BillingEmployeeViewModel> newSessionEmployeeViewModels = new List<BillingEmployeeViewModel>(billingsessionViewModel.BillingEmployee);
            SessionChangedData<BillingEmployeeViewModel> sessionChangedData = new SessionChangedData<BillingEmployeeViewModel>
            {
                AddedData = newSessionEmployeeViewModels.Except(oldSessionEmployeeViewModels, new BillingEmployeeIdComparer()).ToList()
            };
            sessionChangedData.AddedData.ToList().ForEach(session => session.IdBillingSession = billingsessionViewModel.Id);
            sessionChangedData.DeletedData = oldSessionEmployeeViewModels.Except(newSessionEmployeeViewModels, new BillingEmployeeIdComparer()).ToList();
            return sessionChangedData;
        }


        /// <summary>
        /// Update BillingEmployeeModelTreatment
        /// </summary>
        /// <param name="billingsessionViewModel"></param>
        /// <param name="billingEmployeeChangedData"></param>
        /// <param name="userMail"></param>
        private void BillingEmployeeUpdateModelTreatment(BillingSessionViewModel billingsessionViewModel, SessionChangedData<BillingEmployeeViewModel> billingEmployeeChangedData, string userMail)
        {
            if (billingsessionViewModel == null || billingEmployeeChangedData == null || string.IsNullOrWhiteSpace(userMail))
            {
                throw new ArgumentException("");
            }
            _serviceBillingEmployee.BulkDeleteModelsPhysicallyWhithoutTransaction(billingEmployeeChangedData.DeletedData.ToList());
            List<BillingEmployeeViewModel> Contract = _serviceBillingEmployee.FindModelsByNoTracked(x => billingEmployeeChangedData.DeletedData.Any(y => y.Id == x.Id)).ToList();
            if (Contract.Any())
            {
                _serviceBillingEmployee.BulkDeleteModelsPhysicallyWhithoutTransaction(_serviceBillingEmployee.FindModelsByNoTracked(x => Contract.Any(y => y.Id == x.Id) &&
                x.IdBillingSession.Equals(billingsessionViewModel.Id)), userMail);
            }
            IList<BillingEmployeeViewModel> billingEmployeeViewModels = AddBillingEmploye(billingEmployeeChangedData.AddedData.ToList(), billingsessionViewModel.Id, billingsessionViewModel.Month);
            _serviceBillingEmployee.BulkAddWithoutTransaction(billingEmployeeViewModels);
            billingsessionViewModel.BillingEmployee = null;
            if (!billingEmployeeChangedData.AddedData.Any() && !billingEmployeeChangedData.DeletedData.Any())
            {
                UpdateModelWithoutTransaction(billingsessionViewModel, null, userMail, null);
            }
        }


        /// <summary>
        ///  Get BillingSessionDetails by id
        /// </summary>
        /// <param name="IdBillingSession"></param>
        /// <returns></returns>
        public BillingSessionViewModel GetBillingSessionDetails(int IdBillingSession)
        {
            BillingSessionViewModel billingSessionViewModel = GetModelAsNoTracked(x => x.Id == IdBillingSession);
            IList<BillingEmployeeViewModel> billingEmployeeViewModels = _serviceBillingEmployee.FindModelsByNoTracked(x => x.IdBillingSession == IdBillingSession,
                x => x.IdProjectNavigation,
                x => x.IdProjectNavigation.IdCurrencyNavigation,
                x => x.IdEmployeeNavigation,
                x => x.IdTimeSheetNavigation);
            IList<DocumentViewModel> documentViewModels = _serviceDocument.FindModelsByNoTracked(x => billingEmployeeViewModels.Any(y => x.IdProject.HasValue && x.IdTimeSheet.HasValue &&
               y.IdProject == x.IdProject && y.IdTimeSheet == x.IdTimeSheet && x.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoice)),
                x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation);
            foreach (BillingEmployeeViewModel billingEmployeeViewModel in billingEmployeeViewModels)
            {
                billingEmployeeViewModel.IdDocumentNavigation = documentViewModels.FirstOrDefault(x => x.IdProject == billingEmployeeViewModel.IdProject && x.IdTimeSheet == billingEmployeeViewModel.IdTimeSheet);
            }
            billingSessionViewModel.BillingEmployee = billingEmployeeViewModels;
            return billingSessionViewModel;
        }

        /// <summary>
        /// return list of employees billingEmployees 
        /// </summary>
        /// <param name="month"></param>
        /// <param name="sessionEndDate"></param>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<BillingEmployeeViewModel> GetEmployeesAffectedToBillableProject(DateTime month, PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<BillingEmployeeViewModel> dataSourceResult = new DataSourceResult<BillingEmployeeViewModel>();
            int idBillingSession = NumberConstant.Zero;
            if (predicateModel.Filter.Any(p => p.Prop == nameof(BillingEmployeeViewModel.IdBillingSession)))
            {
                idBillingSession = Convert.ToInt32(predicateModel.Filter.Where(p => p.Prop == nameof(BillingEmployeeViewModel.IdBillingSession)).Select(p => p.Value).FirstOrDefault());
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(BillingEmployeeViewModel.IdBillingSession)).ToList();
            }
            DataSourceResult<EmployeeViewModel> dataSourceResultEmployeeViewModel = _serviceEmployeeProject.GetEmployeesAffectedToBillableProject(month.Date, predicateModel);
            IList<TimeSheetViewModel> timeSheetViewModels = _serviceTimeSheet.FindModelsByNoTracked(m => dataSourceResultEmployeeViewModel.data.Any(e => e.Id == m.IdEmployee) && m.Month.EqualsDate(month)).ToList();
            // If update mode, get all billng employee associate with the session
            List<BillingEmployeeViewModel> oldBillingEmployeeViewModels = _serviceBillingEmployee.FindModelsByNoTracked(x => x.IdBillingSession == idBillingSession,
                x => x.IdTimeSheetNavigation,
                x => x.IdEmployeeNavigation).ToList();
            List<BillingEmployeeViewModel> billingEmployeeViewModels = new List<BillingEmployeeViewModel>();
            dataSourceResultEmployeeViewModel.data.Where(x => oldBillingEmployeeViewModels.Any(b => b.IdEmployee == x.Id)).ToList().ForEach(employeeViewModel =>
            {
                billingEmployeeViewModels.Add(oldBillingEmployeeViewModels.FirstOrDefault(x => x.IdEmployee == employeeViewModel.Id));
            });
            dataSourceResultEmployeeViewModel.data.Where(x => !oldBillingEmployeeViewModels.Any(b => b.IdEmployee == x.Id)).ToList().ForEach(employeeViewModel =>
            {
                TimeSheetViewModel timeSheet = timeSheetViewModels.FirstOrDefault(x => x.IdEmployee == employeeViewModel.Id);
                billingEmployeeViewModels.Add(new BillingEmployeeViewModel
                {
                    IdEmployeeNavigation = employeeViewModel,
                    IdEmployee = employeeViewModel.Id,
                    IdTimeSheet = timeSheet != null ? timeSheet.Id : NumberConstant.Zero,
                    IdTimeSheetNavigation = timeSheet ?? new TimeSheetViewModel
                    {
                        Id = NumberConstant.Zero,
                        Status = (int)TimeSheetStatusEnumerator.ToDo
                    }
                });
            });
            dataSourceResult.data = billingEmployeeViewModels;
            dataSourceResult.total = dataSourceResult.data.Count;
            return dataSourceResult;
        }

        /// <summary>
        /// Get Documents Generated for the billingSession
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<DocumentViewModel> GetDocumentsGenerated(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<DocumentViewModel> dataSourceResult = new DataSourceResult<DocumentViewModel>();
            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = _serviceDocument.PreparePredicate(predicateModel);
            if (predicateModel.Filter.FirstOrDefault().Value != null)
            {
                BillingSessionViewModel billingSessionViewModel = GetBillingSessionDetails(int.Parse(predicateModel.Filter.FirstOrDefault().Value.ToString()));
                List<DocumentViewModel> documentViewModels = new List<DocumentViewModel>();
                foreach (BillingEmployeeViewModel m in billingSessionViewModel.BillingEmployee.Where(x => x.IsChecked))
                {
                    Expression<Func<Document, bool>> documentPredicate = y => y.IdTimeSheet == m.IdTimeSheet && y.IdProject == m.IdProject && y.DocumentTypeCode.Equals(DocumentEnumerator.SalesInvoice);
                    DocumentViewModel doc = _serviceDocument.GetModelWithRelations(documentPredicate, predicateFilterRelationModel.PredicateRelations);
                    documentViewModels.Add(doc);
                }
                dataSourceResult.data = documentViewModels;
                dataSourceResult.total = dataSourceResult.data.Count;
            }
            return dataSourceResult;
        }
    }

}
