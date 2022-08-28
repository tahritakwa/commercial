using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceVariableValidityPeriod: Service<VariableValidityPeriodViewModel, VariableValidityPeriod>, IServiceVariableValidityPeriod
    {
        public ServiceVariableValidityPeriod(IRepository<VariableValidityPeriod> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,           IVariableValidityPeriodBuilder builder,
           IRepository<Entity> entityRepoEntity,
           IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {


        }

        public void UpdateVariableValidityPeriodState()
        {
            IList<VariableValidityPeriodViewModel> variableValidityPeriodViewModels = GetAllModelsAsNoTracking();
            DateTime sysDate = DateTime.Now.Date;
            variableValidityPeriodViewModels.GroupBy(x => x.IdVariable).ToList().ForEach(variableValidityPeriod => {

                variableValidityPeriod.ToList().ForEach(validityPeriod =>
                    {
                        if (validityPeriod.StartDate.Date.AfterDate(sysDate))
                        {
                            validityPeriod.State = (int)VariableValidityPeriodStateEnumerator.UpComing;
                        }
                        else
                        {
                            if (validityPeriod.StartDate.Date.BeforeDate(sysDate) &&
                                variableValidityPeriod.Where(m => m.StartDate.Date.BeforeDate(sysDate) && m != validityPeriod).All(m => m.StartDate.BeforeDate(validityPeriod.StartDate)))
                            {
                                validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.InProgress;
                            }
                            else
                            {
                                validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.Expired;
                            }
                        }
                    });
                
            });
            BulkUpdateModelWithoutTransaction(variableValidityPeriodViewModels, "Stark@spark-it.fr");

        }
    }
}
