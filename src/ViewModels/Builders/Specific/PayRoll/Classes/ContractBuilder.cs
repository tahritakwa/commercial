using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ContractBuilder : GenericBuilder<ContractViewModel, Contract>, IContractBuilder
    {
        private readonly IGradeBuilder _gradeBuilder;
        private readonly IBaseSalaryBuilder _baseSalaryBuilder;
        private readonly IContractBonusBuilder _contractBonusBuilder;

        public ContractBuilder(IGradeBuilder gradeBuilder, IBaseSalaryBuilder baseSalaryBuilder,
            IContractBonusBuilder contractBonusBuilder)
        {
            _gradeBuilder = gradeBuilder;
            _baseSalaryBuilder = baseSalaryBuilder;
            _contractBonusBuilder = contractBonusBuilder;
        }

        public override Contract BuildModel(ContractViewModel model)
        {
            Contract contract = base.BuildModel(model);
            return contract;
        }

        public override ContractViewModel BuildEntity(Contract entity)
        {
            ContractViewModel model = base.BuildEntity(entity);
            if (entity.IdEmployeeNavigation != null && entity.IdEmployeeNavigation.IdGradeNavigation != null)
            {
                model.IdEmployeeNavigation.IdGradeNavigation = _gradeBuilder.BuildEntity(entity.IdEmployeeNavigation.IdGradeNavigation);
            }
            if (entity.BaseSalary != null)
            {
                model.BaseSalary = new List<BaseSalaryViewModel>();
                foreach (BaseSalary baseSalary in entity.BaseSalary)
                {
                    baseSalary.IdContract = entity.Id;
                    model.BaseSalary.Add(_baseSalaryBuilder.BuildEntity(baseSalary));
                }
            }
            if(entity.IdSalaryStructureNavigation != null && entity.IdSalaryStructureNavigation.SalaryStructureValidityPeriod.Any())
            {
                model.IdSalaryStructureNavigation.StartDate = entity.IdSalaryStructureNavigation.SalaryStructureValidityPeriod.ToList().Min(x => x.StartDate);
            }
            if (entity.ContractBonus != null)
            {
                model.ContractBonus = entity.ContractBonus.Select(_contractBonusBuilder.BuildEntity).ToList();
            }
            return model;
        }
    }
}
