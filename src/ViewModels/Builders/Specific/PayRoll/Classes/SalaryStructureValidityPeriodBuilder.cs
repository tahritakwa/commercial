using Persistence.Entities;
using System;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SalaryStructureValidityPeriodBuilder : GenericBuilder<SalaryStructureValidityPeriodViewModel, SalaryStructureValidityPeriod>, ISalaryStructureValidityPeriodBuilder
    {
        public override SalaryStructureValidityPeriodViewModel BuildEntity(SalaryStructureValidityPeriod entity)
        {
            if (entity != null)
            {
                var model = base.BuildEntity(entity);
                DateTime sysDate = DateTime.Now.Date;
                if (model.StartDate.Date.AfterDate(sysDate))
                {
                    model.State = (int)SalaryRuleValidityPeriodStateEnumerator.UpComing;
                }
                else
                {
                    var max = entity.IdSalaryStructureNavigation.SalaryStructureValidityPeriod.Where(x => x.StartDate.Date.BeforeDate(sysDate)).Max(x => x.StartDate);
                    model.State = entity.IdSalaryStructureNavigation.SalaryStructureValidityPeriod.Count == NumberConstant.One ? (int)SalaryRuleValidityPeriodStateEnumerator.InProgress :
                        max.EqualsDate(model.StartDate)? (int)SalaryRuleValidityPeriodStateEnumerator.InProgress : (int)SalaryRuleValidityPeriodStateEnumerator.Expired;
                }
                return model;
            }
            return null;

        }
    }
}
