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
    public class ServiceSalaryStructureValidityPeriod : Service<SalaryStructureValidityPeriodViewModel, SalaryStructureValidityPeriod>, IServiceSalaryStructureValidityPeriod
    {
        private readonly IServiceSalaryRuleValidityPeriod _serviceSalaryRuleValidityPeriod;
        private readonly IServiceVariableValidityPeriod _serviceVariableValidityPeriod;
        public ServiceSalaryStructureValidityPeriod(IRepository<SalaryStructureValidityPeriod> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
           ISalaryStructureValidityPeriodBuilder builder,
           IServiceVariableValidityPeriod serviceVariableValidityPeriod,
           IServiceSalaryRuleValidityPeriod serviceSalaryRuleValidityPeriod,
           IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceVariableValidityPeriod = serviceVariableValidityPeriod;
            _serviceSalaryRuleValidityPeriod = serviceSalaryRuleValidityPeriod;
        }

        public void UpdateSalaryStructureValidityPeriodState()
        {
            IList<SalaryStructureValidityPeriodViewModel> salaryStructureValidityPeriodViewModels = GetAllModelsAsNoTracking();
            DateTime sysDate = DateTime.Now.Date;
            salaryStructureValidityPeriodViewModels.GroupBy(x => x.IdSalaryStructure).ToList().ForEach(salaryStructure => {
                IList<SalaryStructureValidityPeriodViewModel> salaryStructureValidityPeriod = salaryStructure.ToList().OrderBy(x => x.StartDate).ToList();
                salaryStructureValidityPeriod.ToList().ForEach(validityPeriod =>
                    {
                        if (validityPeriod.StartDate.Date.AfterDate(sysDate))
                        {
                            validityPeriod.State = (int)SalaryRuleValidityPeriodStateEnumerator.UpComing;
                        }
                        else
                        {
                            if (validityPeriod.StartDate.Date.BeforeDate(sysDate) &&
                                salaryStructureValidityPeriod.Where(m => m.StartDate.Date.BeforeDate(sysDate)
                                && m != validityPeriod).All(m => m.StartDate.BeforeDate(validityPeriod.StartDate)))
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
            BulkUpdateModelWithoutTransaction(salaryStructureValidityPeriodViewModels, "Stark@spark-it.fr");

        }
        public void UpdateSalaryStructureWithSalaryRuleWithVariableState(string connectionString)
        {
            try
            {
                BeginTransaction(connectionString);
                UpdateSalaryStructureValidityPeriodState();
                _serviceSalaryRuleValidityPeriod.UpdateSalaryRuleValidityPeriodState();
                _serviceVariableValidityPeriod.UpdateVariableValidityPeriodState();
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
    }
}
