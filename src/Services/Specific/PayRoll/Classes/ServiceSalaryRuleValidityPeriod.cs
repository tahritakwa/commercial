using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSalaryRuleValidityPeriod : Service<SalaryRuleValidityPeriodViewModel, SalaryRuleValidityPeriod>, IServiceSalaryRuleValidityPeriod
    {
        public ServiceSalaryRuleValidityPeriod(IRepository<SalaryRuleValidityPeriod> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ISalaryRuleValidityPeriodBuilder builder,
           IRepository<Entity> entityRepoEntity,
           IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            
         }
        public void UpdateSalaryRuleValidityPeriodState()
        {
            IList<SalaryRuleValidityPeriodViewModel> salaryRuleValidityPeriodViewModels = GetAllModelsAsNoTracking();
            DateTime sysDate = DateTime.Now.Date;
            salaryRuleValidityPeriodViewModels.GroupBy(x => x.IdSalaryRule).ToList().ForEach(sRule => {
                if (sRule != null)
                {
                    IList<SalaryRuleValidityPeriodViewModel> salaryRuleValidityPeriod = sRule.ToList().OrderBy(x => x.StartDate).ToList();

                    salaryRuleValidityPeriod.ToList().ForEach(validityPeriod =>
                    {
                        if (validityPeriod.StartDate.Date.AfterDate(sysDate))
                        {
                            validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.UpComing;
                        }
                        else
                        {
                            if (validityPeriod.StartDate.Date.BeforeDate(sysDate) &&
                                salaryRuleValidityPeriod.Where(m => m.StartDate.Date.BeforeDate(sysDate) && m != validityPeriod).All(m => m.StartDate.BeforeDate(validityPeriod.StartDate)))
                            {
                                validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.InProgress;
                            }
                            else
                            {
                                validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.Expired;
                            }
                        }
                    });
                }

            });
            BulkUpdateModelWithoutTransaction(salaryRuleValidityPeriodViewModels, "Stark@spark-it.fr");

        }
    }
}
