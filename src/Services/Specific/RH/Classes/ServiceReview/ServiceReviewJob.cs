using Newtonsoft.Json;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Classes.ServiceReview
{
    public partial class ServiceReview
    {
        /// <summary>
        /// Get close employee list
        /// </summary>
        /// <returns></returns>
        public void GetCloseEmployeeList(string connectionString, SmtpSettings smtpSettings)
        {
            try
            {
                BeginTransaction(connectionString);

                List<EmployeeViewModel> targetEmployees = new List<EmployeeViewModel>();
                // getting notification days from data base
                List<JobsParametersViewModel> jobParameters = _serviceJobsParameters.GetModelsWithConditionsRelations(jobParam => jobParam.Keys == BackgroundJobConstant.ANNUAL_REVIEW_JOB_KEY).ToList();
                string days;
                if (jobParameters.Count != 0)
                {
                    days = jobParameters[0].Value;
                }
                else
                {
                    days = BackgroundJobConstant.ANNUAL_REVIEW_JOB_NOTIFICATION_DAYS_DEFAULT_VALUE;
                }

                List<int> notificationDays = JsonConvert.DeserializeObject<List<string>>(days).Select(int.Parse).ToList();
                targetEmployees = _serviceEmployee.GetModelsWithConditionsRelations(x => notificationDays.Contains(DaysBeforeReview(x.HiringDate)), x => x.ReviewIdEmployeeCollaboratorNavigation).ToList();

                foreach (EmployeeViewModel employee in targetEmployees)
                {
                    // create interview
                    CheckAndAddEmployeeReview(employee);
                    // send email and notification
                    SendMailAndNotifForAnnualInterview(Constants.DO_NOT_REPLY_EMAIL, smtpSettings, employee);
                }

                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }
        }

        /// <summary>
        /// add review to employee if not exist
        /// </summary>
        /// <returns>true if review is added</returns>
        private bool CheckAndAddEmployeeReview(EmployeeViewModel employee)
        {
            if (!HasReview(employee))
            {
                //prepare review
                ReviewViewModel review = new ReviewViewModel();
                review.ReviewDate = NextAnnualReviewDate(employee.HiringDate);
                review.State = (int)ReviewStateEnumerator.ToPlan;
                review.IdEmployeeCollaborator = employee.Id;
                review.IdEmployeeCollaboratorNavigation = employee;
                int idManager = GenerateManagerForReview(employee.Id);
                if (idManager != NumberConstant.Zero)
                {
                    review.IdManager = idManager;
                }
                //create review
                AddModelWithoutTransaction(review, null, null);
                return true;
            }
            return false;
        }

        /// <summary>
        /// return false if the review date is later than execution date and review is not created
        /// else return true
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private bool HasReview(EmployeeViewModel employee)
        {
            bool exist = false;
            if (employee.ReviewIdEmployeeCollaboratorNavigation != null)
            {
                foreach (ReviewViewModel review in employee.ReviewIdEmployeeCollaboratorNavigation)
                {
                    if (review.ReviewDate.AfterDate(DateTime.Now))
                    {
                        exist = true;
                    }
                }
            }
            return exist;
        }

    }
}
