using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SalaryStructureBuilder : GenericBuilder<SalaryStructureViewModel, SalaryStructure>, ISalaryStructureBuilder
    {
        private readonly ISalaryStructureValidityPeriodBuilder _salaryStructureValidityPeriodBuilder;

        public SalaryStructureBuilder(ISalaryStructureValidityPeriodBuilder salaryStructureValidityPeriodBuilder)
        {
            _salaryStructureValidityPeriodBuilder = salaryStructureValidityPeriodBuilder;
        }
        public override SalaryStructureViewModel BuildEntity(SalaryStructure entity)
        {
            if (entity != null)
            {
                var model = base.BuildEntity(entity);
                if (entity.SalaryStructureValidityPeriod != null && entity.SalaryStructureValidityPeriod.Any())
                {
                    model.StartDate = entity.SalaryStructureValidityPeriod.ToList().Min(x => x.StartDate);
                    model.SalaryStructureValidityPeriod = entity.SalaryStructureValidityPeriod.Select(_salaryStructureValidityPeriodBuilder.BuildEntity).ToList();
                }
             return model;
            }
            return null;
        }

        public override SalaryStructure BuildModel(SalaryStructureViewModel model)
        {
            if (model != null)
            {

                SalaryStructure entity = base.BuildModel(model);
                IList<SalaryStructureValidityPeriod> salaryStructureValidityPeriods = new List<SalaryStructureValidityPeriod>();
                if (model.SalaryStructureValidityPeriod != null)
                {
                    foreach (SalaryStructureValidityPeriodViewModel salaryStructureValidityPeriodViewModel in model.SalaryStructureValidityPeriod)
                    {
                        salaryStructureValidityPeriods.Add(_salaryStructureValidityPeriodBuilder.BuildModel(salaryStructureValidityPeriodViewModel));
                    }
                    entity.SalaryStructureValidityPeriod = salaryStructureValidityPeriods;
                }
                return entity;
            }
            return null;
        }
    }
}
