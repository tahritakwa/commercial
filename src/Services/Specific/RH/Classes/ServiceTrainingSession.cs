using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingSession : Service<TrainingSessionViewModel, TrainingSession>, IServiceTrainingSession
    {
        private readonly IServiceTrainingRequest _serviceTrainingRequest;
        private readonly IServiceTraining _serviceTraining;
        private readonly IServiceExternalTraining _serviceExternalTraining;
        public ServiceTrainingSession(IRepository<TrainingSession> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingSessionBuilder builder,
          IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
          IServiceTrainingRequest serviceTrainingRequest,
          IServiceTraining serviceTraining, IServiceExternalTraining serviceExternalTraining)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceTrainingRequest = serviceTrainingRequest;
            _serviceTraining = serviceTraining;
            _serviceExternalTraining = serviceExternalTraining;
        }


        private void AddStatus(TrainingSessionViewModel trainingSession)
        {
            if ((trainingSession.EndDate == null) || (trainingSession.EndDate.Value.Date.AfterDateLimitIncluded(DateTime.Now.Date)))
            {
                trainingSession.Status = (int)TrainingSessionState.Open;
            }
            else
            {
                trainingSession.Status = (int)TrainingSessionState.Closed;
            }
        }
        public override object AddModelWithoutTransaction(TrainingSessionViewModel trainingSession, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //Add status of session
            AddStatus(trainingSession);
            //Verify if training session period exists
            VerifyExistenceOfTrainingSessionPeriod(trainingSession);
            // Manage training session plan file
            ManageTrainngSessionFile(trainingSession);
            return base.AddModelWithoutTransaction(trainingSession, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(TrainingSessionViewModel trainingSession, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //Update status of session
            AddStatus(trainingSession);
            //Verify if training session period exists
            VerifyExistenceOfTrainingSessionPeriod(trainingSession);
            // Manage training session plan file
            ManageTrainngSessionFile(trainingSession);
            return base.UpdateModelWithoutTransaction(trainingSession, entityAxisValuesModelList, userMail, property);
        }

        private void ManageTrainngSessionFile(TrainingSessionViewModel trainingSessionViewModel)
        {
            if (string.IsNullOrEmpty(trainingSessionViewModel.SessionPlanUrl))
            {
                if (trainingSessionViewModel.SessionPlanFileInfo != null && trainingSessionViewModel.SessionPlanFileInfo.Count != NumberConstant.Zero)
                {

                    trainingSessionViewModel.SessionPlanUrl = RHConstant.RHTrainingSessionPlanFileRootPath + Guid.NewGuid();
                    CopyFiles(trainingSessionViewModel.SessionPlanUrl, trainingSessionViewModel.SessionPlanFileInfo);
                }
            }
            else
            {
                if (trainingSessionViewModel.SessionPlanFileInfo != null)
                {
                    DeleteFiles(trainingSessionViewModel.SessionPlanUrl, trainingSessionViewModel.SessionPlanFileInfo);
                    CopyFiles(trainingSessionViewModel.SessionPlanUrl, trainingSessionViewModel.SessionPlanFileInfo);
                }

            }
        }

        public override TrainingSessionViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            var trainingSession = base.GetModelWithRelations(predicateModel);

            // get Plan file related to the current training session
            if (trainingSession != null)
            {
                trainingSession.SessionPlanFileInfo = GetFiles(trainingSession.SessionPlanUrl).ToList();
                trainingSession.IdTrainingNavigation= _serviceTraining.GetModelById(trainingSession.IdTraining);
            }
            return trainingSession;

        }

        private void VerifyExistenceOfTrainingSessionPeriod(TrainingSessionViewModel model)
        {
            if (model.StartDate.HasValue && model.EndDate.HasValue)
            {
                var trainingSessionWithSameDate = GetModelsWithConditionsRelations(x => x.IdTraining == model.IdTraining
            && x.Id != model.Id && x.StartDate.HasValue && x.EndDate.HasValue
            && (model.StartDate.Value.Date.BetweenDateLimitIncluded(x.StartDate.Value.Date, x.EndDate.Value.Date)
            || model.EndDate.Value.Date.BetweenDateLimitIncluded(x.StartDate.Value.Date, x.EndDate.Value.Date)));
                if (trainingSessionWithSameDate.Count() > 0)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { PayRollConstant.START_DATE,
                                    model.StartDate.Value.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                                },
                                { PayRollConstant.END_DATE,
                                    model.EndDate.Value.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                                }
                            };
                    throw new CustomException(CustomStatusCode.AddTrainingSessionPeriodException, paramtrs);
                }
            }  
        }


        /// <summary>
        /// Verify if the startHours if less than the endHours of one date of the seance
        /// </summary>
        /// <param name="trainingSeance"></param>
        private void VerifyHoursOfTheSeanceDate(TrainingSeanceViewModel trainingSeance, string DayName)
        {
            if (!trainingSeance.IsDeleted && (trainingSeance.StartHour.Duration() >= trainingSeance.EndHour.Duration()))
            {
                if (trainingSeance.Date.HasValue)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(DateTime.Date),
                        trainingSeance.Date.Value.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                    }
                };
                    throw new CustomException(CustomStatusCode.AddTrainingSeanceHoursException, paramtrs);
                }
                if (DayName != null)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {PayRollConstant.DAY,
                        DayName
                    }
                };
                    throw new CustomException(CustomStatusCode.AddTrainingSeanceWeeklyHoursException, paramtrs);
                }
               
            }
        }


        /// <summary>
        /// GetTrainingSessionList
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<TrainingSessionViewModel> GetTrainingSessionList(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<TrainingSessionViewModel> trainingSessionDataSourceList = new DataSourceResult<TrainingSessionViewModel>();
            predicateModel.Operator = Operator.And;
            PredicateFilterRelationViewModel<TrainingSession> predicateFilterRelationModel = base.PreparePredicate(predicateModel);
            IQueryable<TrainingSessionViewModel> dataSourceList = base.GetAllModelsQueryable(predicateFilterRelationModel.PredicateWhere,
                           x => x.IdTrainingNavigation, x => x.TrainingRequest, x => x.TrainingSeance).OrderByDescending(x => x.Id);
            trainingSessionDataSourceList.total = dataSourceList.Count();
            trainingSessionDataSourceList.data = dataSourceList.Skip((predicateModel.page - NumberConstant.One) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();
            return trainingSessionDataSourceList;
        }

        //Add training requests to training session
         public void AddTrainingRequestToTrainingSession(string userMail,int idTraining, IList<TrainingRequestViewModel> trainingRequestList)
         {
            TrainingSessionViewModel trainingSession = new TrainingSessionViewModel();
            trainingSession.IdTraining = idTraining;
            AddStatus(trainingSession);
            //Add the training session and update the training request list SELECTED
            int generateTrainingSessionId = ((CreatedDataViewModel)base.AddModelWithoutTransaction(trainingSession, null, userMail)).Id;
                trainingRequestList.ToList().ForEach((trainingRequest) =>
                {
                    trainingRequest.IdTrainingSession = generateTrainingSessionId;
                });
            _serviceTrainingRequest.BulkUpdateModelWithoutTransaction(trainingRequestList, userMail);
         }

        /// <summary>
        /// Update training session and update the training requestList associated
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="trainingSessionViewModel"></param>
        /// <param name="newTrainingRequestSelectedList"></param>
        /// <param name="trainingRequestSelectedToUnSelectedList"></param>
        public void UpdateTrainingRequestToTrainingSession(string userMail,int idTrainingSession,
            IEnumerable<TrainingRequestViewModel> newTrainingRequestSelectedList, IEnumerable<TrainingRequestViewModel> trainingRequestSelectedToUnSelectedList)
        {
                // For each new training request selected list update the idTrainingSession
                newTrainingRequestSelectedList.ToList().ForEach((trainingRequest) =>
                {
                    trainingRequest.IdTrainingSession = idTrainingSession;
                });
                // For each training request selected to unselected list update the idTrainingSession
                trainingRequestSelectedToUnSelectedList.ToList().ForEach((trainingRequest) =>
                {
                    trainingRequest.IdTrainingSession = null;
                });
                // join the new training request list and the training request list which state pass from selected to unselected
                List<TrainingRequestViewModel> trainingRequestListToUpdate = new List<TrainingRequestViewModel>(trainingRequestSelectedToUnSelectedList);
                trainingRequestListToUpdate.AddRange(newTrainingRequestSelectedList);
                if (trainingRequestListToUpdate.Count > NumberConstant.Zero)
                {
                    _serviceTrainingRequest.BulkUpdateModelWithoutTransaction(trainingRequestListToUpdate, userMail);
                }
        }

        /// <summary>
        /// Add training seances and with training session
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="idTraining"></param>
        /// <param name="traningSeancesPerDate"></param>
        /// <param name="trainingSeancesFrequently"></param>
        public void AddTrainingSeancesWithTrainingSession(string userMail, int idTraining,
           IEnumerable<TrainingSeanceViewModel> traningSeancesPerDate,
           IEnumerable<TrainingSeanceDayViewModel> trainingSeancesFrequently)
        {
            List<TrainingSeanceViewModel> trainingSeances = new List<TrainingSeanceViewModel>();

            CheckSeancesHours(traningSeancesPerDate, null);
            trainingSeances.AddRange(traningSeancesPerDate);
            trainingSeancesFrequently.ToList().ForEach((trainingSeancesPerDay) =>
            {
                CheckSeancesHours(trainingSeancesPerDay.TrainingSeanceLine, trainingSeancesPerDay.DayName);
                trainingSeances.AddRange(trainingSeancesPerDay.TrainingSeanceLine);
            });
            TrainingSessionViewModel trainingSession = new TrainingSessionViewModel();
            // Verify hours of seances with the same date
            VerifyHoursOfTheSeancesWithTheSameDate(trainingSession, traningSeancesPerDate, trainingSeancesFrequently);
            trainingSession.IdTraining = idTraining;
            trainingSession.TrainingSeance = trainingSeances;
            AddStatus(trainingSession);
            //Add the training session and add the training seances
            base.AddModelWithoutTransaction(trainingSession, null, userMail);
        }

        /// <summary>
        /// Update training seances and with training session
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="trainingSession"></param>
        /// <param name="traningSeancesPerDate"></param>
        /// <param name="trainingSeancesFrequently"></param>
        public void UpdateTrainingSeancesWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession,
           IEnumerable<TrainingSeanceViewModel> traningSeancesPerDate,
           IEnumerable<TrainingSeanceDayViewModel> trainingSeancesFrequently)
        {
            VerifySeanceDateIncludedInSessionLapse(traningSeancesPerDate, trainingSession.StartDate, trainingSession.EndDate);
            List<TrainingSeanceViewModel> trainingSeances = new List<TrainingSeanceViewModel>();
            CheckSeancesHours(traningSeancesPerDate, null);
            trainingSeances.AddRange(traningSeancesPerDate);
            trainingSeancesFrequently.ToList().ForEach((trainingSeancesPerDay) =>
            {
                CheckSeancesHours(trainingSeancesPerDay.TrainingSeanceLine, trainingSeancesPerDay.DayName);
                trainingSeances.AddRange(trainingSeancesPerDay.TrainingSeanceLine);
            });

            // Verify hours of seances with the same date
            VerifyHoursOfTheSeancesWithTheSameDate(trainingSession, traningSeancesPerDate, trainingSeancesFrequently);
            AddStatus(trainingSession);
            trainingSession.TrainingSeance = trainingSeances;
            //Update the training session 
            UpdateModelWithoutTransaction(trainingSession, null, userMail);
        }
        /// <summary>
        /// Verify if all of the training session seances dates are included in the period of the session
        /// </summary>
        /// <param name="trainingSession"></param>
        private void VerifySeanceDateIncludedInSessionLapse(IEnumerable<TrainingSeanceViewModel> trainingSeances, DateTime? startDate, DateTime? endDate)
        {
            trainingSeances.ToList().ForEach((trainingSeance) =>
            {
                if (startDate.HasValue && endDate.HasValue)
                {
                    if (!trainingSeance.Date.Value.BetweenDateLimitIncluded(startDate.Value, endDate.Value))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { nameof(DateTime.Date),
                                    trainingSeance.Date.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                                }
                            };
                        throw new CustomException(CustomStatusCode.AddTrainingSeanceDateLapsException, paramtrs);
                    }
                }
                else if (startDate.HasValue && !endDate.HasValue)
                {
                    if (!trainingSeance.Date.Value.AfterDateLimitIncluded(startDate.Value))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { nameof(DateTime.Date),
                                    trainingSeance.Date.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                                }
                            };
                        throw new CustomException(CustomStatusCode.AddTrainingSeanceDateLapsWithoutEndDateOfSessionException, paramtrs);
                    }
                }
                else if (!startDate.HasValue && endDate.HasValue)
                {
                    if (!trainingSeance.Date.Value.BeforeDateLimitIncluded(endDate.Value))
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { nameof(DateTime.Date),
                                    trainingSeance.Date.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                                }
                            };
                        throw new CustomException(CustomStatusCode.AddTrainingSeanceDateLapsWithoutStartDateOfSessionException, paramtrs);
                    }
                }
            }
            );
        }

        // Check seances hours comparaison
        private void CheckSeancesHours(IEnumerable<TrainingSeanceViewModel> trainingSeances, string DayName)
        {
            // For each Seance verify if the startHours is less than the endHours
            foreach (TrainingSeanceViewModel trainingSeance in trainingSeances)
            {
                VerifyHoursOfTheSeanceDate(trainingSeance, DayName);
            }
        }

        private void CheckExistenceOfSessionStartDate(TrainingSessionViewModel trainingSession)
        {
            if (!trainingSession.StartDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.SessionWithEndDateAndWithoutStartDate);
            }
        }

        // Verify if there is an overlap of seances
        private void VerifyHoursOfTheSeancesWithTheSameDate(TrainingSessionViewModel trainingSession, IEnumerable<TrainingSeanceViewModel> trainingSeancesPerDate, IEnumerable<TrainingSeanceDayViewModel> trainingSeancesFrequently)
        {
            DateTime startDate = new DateTime();
            DateTime endDate = new DateTime();
            if (trainingSession.StartDate.HasValue && trainingSession.EndDate.HasValue)
            {
                startDate = trainingSession.StartDate.Value.Date;
                endDate = trainingSession.EndDate.Value.Date;
            }
            else if (trainingSession.StartDate.HasValue && !trainingSession.EndDate.HasValue)
            {
                startDate = trainingSession.StartDate.Value.Date;
                if (trainingSeancesPerDate.Where(x => !x.IsDeleted).Count() > 0)
                {
                    // EndDate gets last date of training seances planned per date
                    endDate = trainingSeancesPerDate.Select(x => x.Date).Max().Value;
                }
                else if (trainingSeancesFrequently.Count() > 0)
                {
                    endDate = DateTime.Now.FirstDateFromDayOfWeek(trainingSeancesFrequently.Last().DayOfWeek);
                }
            }
            else if (!trainingSession.StartDate.HasValue && trainingSession.EndDate.HasValue)
            {
                CheckExistenceOfSessionStartDate(trainingSession);
            }
            else
            {
                if (trainingSeancesPerDate.Where(x => !x.IsDeleted).Count() > 0)
                {
                    // Start gets first date of training seances planned per date
                    startDate = trainingSeancesPerDate.Select(x => x.Date).Min().Value;
                    // EndDate gets last date of training seances planned per date
                    endDate = trainingSeancesPerDate.Select(x => x.Date).Max().Value;
                }
                else if (trainingSeancesFrequently.Count() > 0)
                {
                    startDate = DateTime.Now.FirstDateFromDayOfWeek(trainingSeancesFrequently.First().DayOfWeek);
                    endDate = DateTime.Now.FirstDateFromDayOfWeek(trainingSeancesFrequently.Last().DayOfWeek);
                }
            }
           if (startDate.Date !=  new DateTime() && endDate.Date != new DateTime())
           {
                List<DateInterval> dateIntervals = new List<DateInterval>();
                List<DateInterval> dateIntervalsPerDay = new List<DateInterval>();
                var daysPlanifiedPerDate = trainingSeancesPerDate.Select(x => x.Date.Value.DayOfWeek).Distinct();
                daysPlanifiedPerDate.ToList().ForEach((dayOfWork) =>
                {
                    var dayOfWorkTraningSeancesPerDate = trainingSeancesPerDate.Where(m => m.Date.Value.DayOfWeek.Equals(dayOfWork) && !m.IsDeleted)
                    .Select(x => new DateInterval
                    {
                        StartDate = x.Date.Value.Date.Add(new TimeSpan(x.StartHour.Hours, x.StartHour.Minutes, NumberConstant.Zero)),
                        EndDate = x.Date.Value.Date.Add(new TimeSpan(x.EndHour.Hours, x.EndHour.Minutes, NumberConstant.Zero))
                    }).ToList();
                    dateIntervals.AddRange(dayOfWorkTraningSeancesPerDate);
                });
                // Fetch days to plan frequently
                var daysToPlan = trainingSeancesFrequently.Select(x => x.DayOfWeek);
                daysToPlan.ToList().ForEach((dayOfWork) =>
                {
                    // Get all dates to plan frequently
                    var dayOfWorkTrainingSeancesFrequently = startDate.AllDatesUntilLimitIncluded(endDate, new List<DayOfWeek> { dayOfWork });
                    // Get all planified seances frequently
                    List<TrainingSeanceViewModel> trainingSeanceLine = trainingSeancesFrequently.FirstOrDefault(x => x.DayOfWeek == dayOfWork)
                    .TrainingSeanceLine.Where(y => !y.IsDeleted).ToList();
                    // Create date intervals with start date and end date based on start hour and end hour
                    
                    dayOfWorkTrainingSeancesFrequently.ToList().ForEach(m =>
                    {
                        dateIntervalsPerDay.AddRange(trainingSeanceLine.Select(x => new DateInterval
                        {
                            StartDate = m.Date.Add(new TimeSpan(x.StartHour.Hours, x.StartHour.Minutes, NumberConstant.Zero)),
                            EndDate = m.Date.Add(new TimeSpan(x.EndHour.Hours, x.EndHour.Minutes, NumberConstant.Zero)),
                            DayOfWeek = dayOfWork,
                            DayName = trainingSeancesFrequently.Where(y => y.DayOfWeek == dayOfWork).Select(z => z.DayName).FirstOrDefault()
                        }).ToList());
                    });
                    var overLapPerDay = OverLapList(dateIntervalsPerDay);
                    if (overLapPerDay.Any())
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { PayRollConstant.DAY,
                                overLapPerDay.Last().DayName.ToString()
                            }
                        };
                        throw new CustomException(CustomStatusCode.AddTrainingSeanceHoursWeeklyLapsException, paramtrs);
                    }
                });
                dateIntervals.AddRange(dateIntervalsPerDay);
                // Check if there is an overlap of seances
                var overLappingList = OverLapList(dateIntervals);
                // Send customized exception if there is an overlap
                if (overLappingList.Any())
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { nameof(DateTime.Date),
                                overLappingList.Last().StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                            }
                        };
                    throw new CustomException(CustomStatusCode.AddTrainingSeanceHoursLapsException, paramtrs);
                }
           }
        }
        private IEnumerable<DateInterval> OverLapList(List<DateInterval> dateIntervals)
        {
            return dateIntervals.Where(a => dateIntervals.Any(b => (b != a) && (a.StartDate.BetweenDateTimeLimitNotIncluded(b.StartDate, b.EndDate.Value) ||
                   a.EndDate.Value.BetweenDateTimeLimitNotIncluded(b.StartDate, b.EndDate.Value) ||
                    (DateTime.Compare(a.StartDate, b.StartDate) == NumberConstant.Zero &&
                   DateTime.Compare(a.EndDate.Value, b.EndDate.Value) == NumberConstant.Zero) ||
                   (DateTime.Compare(a.StartDate, b.StartDate) < NumberConstant.Zero &&
                   DateTime.Compare(a.EndDate.Value, b.EndDate.Value) > NumberConstant.Zero) ||
                   (DateTime.Compare(a.StartDate, b.StartDate) > NumberConstant.Zero &&
                   DateTime.Compare(a.EndDate.Value, b.EndDate.Value) < NumberConstant.Zero))));
        }

        public void AddExternalTrainingWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession, int idRoom, List<int> idSelectedEmployee)
        {
            if (trainingSession.IdExternalTrainer.HasValue && idRoom != NumberConstant.Zero && idSelectedEmployee.Count() == NumberConstant.Zero)
            {
                int generateTrainingSessionId = ((CreatedDataViewModel)AddModelWithoutTransaction(trainingSession, null, userMail)).Id;
                ExternalTrainingViewModel externalTraining = new ExternalTrainingViewModel();
                externalTraining.IdTrainingCenterRoom = idRoom;
                externalTraining.IdExternalTrainer = trainingSession.IdExternalTrainer.Value;
                externalTraining.IdTrainingSession = generateTrainingSessionId;
                _serviceExternalTraining.AddModelWithoutTransaction(externalTraining, null, userMail, null);
            }
            else
            {
                if (trainingSession.IdExternalTrainer.HasValue || idSelectedEmployee.Count() > NumberConstant.Zero)
                {
                    // Create list of employee associated to training session
                    if (idSelectedEmployee.Count() > NumberConstant.Zero)
                    {
                        List<EmployeeTrainingSessionViewModel> employeeTrainingSessions = new List<EmployeeTrainingSessionViewModel>();
                        idSelectedEmployee.ForEach(id =>
                        {
                            EmployeeTrainingSessionViewModel employee = new EmployeeTrainingSessionViewModel();
                            employee.IdEmployee = id;
                            employeeTrainingSessions.Add(employee);
                        });
                        trainingSession.EmployeeTrainingSession = employeeTrainingSessions;
                    }

                }
                else if (!trainingSession.IdExternalTrainer.HasValue && idRoom > NumberConstant.Zero)
                {
                    // Launch exception when there is no external trainer
                    throw new CustomException(CustomStatusCode.MissingExternalTrainerException);
                }
                AddModelWithoutTransaction(trainingSession, null, userMail);
            }
        }

        public void UpdateExternalTrainingWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession, int idRoom, ExternalTrainingViewModel externalTraining,
            List<int> idSelectedEmployee)
        {
            if (idSelectedEmployee.Count() > NumberConstant.Zero || trainingSession.EmployeeTrainingSession.Count() > NumberConstant.Zero)
            {
                List<EmployeeTrainingSessionViewModel> newEmployeesTrainingSession = new List<EmployeeTrainingSessionViewModel>();

               // if ( trainingSession.EmployeeTrainingSession.Count() > NumberConstant.Zero)
               // {
                    // Get existing employee in training session
                    List<EmployeeTrainingSessionViewModel> oldEmployeesInTrainingSession = trainingSession.EmployeeTrainingSession.Where(x => idSelectedEmployee.Contains(x.IdEmployee)).ToList();
                    
                    newEmployeesTrainingSession.AddRange(oldEmployeesInTrainingSession);
                    // Get employees to delete from training session
                    List<EmployeeTrainingSessionViewModel> employeesToDeleteInTrainingSession = trainingSession.EmployeeTrainingSession.Where(x => !idSelectedEmployee.Contains(x.IdEmployee)).ToList();
                    employeesToDeleteInTrainingSession.ForEach(employeeToDelete =>
                    {
                        employeeToDelete.IsDeleted = true;
                    });
                    newEmployeesTrainingSession.AddRange(employeesToDeleteInTrainingSession);
                //}
               
                // Get new employees to add to training session 
                List<int> newIdsEmployee = idSelectedEmployee.Where(x => !trainingSession.EmployeeTrainingSession.Select(y => y.IdEmployee).ToList().Contains(x)).ToList();
               
                newIdsEmployee.ForEach(id =>
                {
                    EmployeeTrainingSessionViewModel employee = new EmployeeTrainingSessionViewModel();
                    employee.IdEmployee = id;
                    newEmployeesTrainingSession.Add(employee);
                });
                trainingSession.EmployeeTrainingSession = newEmployeesTrainingSession;
            }

            if (trainingSession.IdExternalTrainer.HasValue)
            {
                if (idRoom != NumberConstant.Zero)
                {
                    if (externalTraining.IdTrainingCenterRoom != idRoom)
                    {
                        externalTraining.IdTrainingCenterRoom = idRoom;
                    }
                    if (externalTraining.IdExternalTrainer != trainingSession.IdExternalTrainer)
                    {
                        externalTraining.IdExternalTrainer = trainingSession.IdExternalTrainer.Value;
                    }
                    if (externalTraining.Id == NumberConstant.Zero)
                    {
                        externalTraining.IdTrainingSession = trainingSession.Id;
                        _serviceExternalTraining.AddModelWithoutTransaction(externalTraining, null, userMail, null);
                    }
                    else
                    {
                        _serviceExternalTraining.UpdateModelWithoutTransaction(externalTraining, null, userMail, null);
                    }
                }
                else if (idRoom == NumberConstant.Zero && externalTraining.Id != NumberConstant.Zero)
                {
                    _serviceExternalTraining.DeleteModelwithouTransaction(externalTraining.Id, "ExternalTraining", userMail);
                }
                if (trainingSession.EmployeeTrainingSession.Count() > NumberConstant.Zero)
                {
                    trainingSession.EmployeeTrainingSession.ToList().ForEach(employeeToDelete =>
                    {
                        employeeToDelete.IsDeleted = true;
                    });
                }
                UpdateModelWithoutTransaction(trainingSession, null, userMail);
            }
            else if (idRoom != NumberConstant.Zero && !trainingSession.IdExternalTrainer.HasValue)
            {
                // Launch exception when there is no external trainer
                throw new CustomException(CustomStatusCode.MissingExternalTrainerException);
            }
            else
            {
                if (idRoom == NumberConstant.Zero && externalTraining.Id != NumberConstant.Zero)
                {
                    _serviceExternalTraining.DeleteModelwithouTransaction(externalTraining.Id, "ExternalTraining", userMail);
                }
                UpdateModelWithoutTransaction(trainingSession, null, userMail);
            }
        }
    }
}
