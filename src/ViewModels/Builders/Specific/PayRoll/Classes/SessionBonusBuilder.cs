using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SessionBonusBuilder : GenericBuilder<SessionBonusViewModel, SessionBonus>, ISessionBonusBuilder
    {
        private readonly ISalaryStructureBuilder _salaryStructureBuilder;
        private readonly IContractTypeBuilder _contractTypeBuilder;
        private readonly ICnssBuilder _cnssBuilder;

        public SessionBonusBuilder(ISalaryStructureBuilder salaryStructureBuilder,
            IContractTypeBuilder contractTypeBuilder, ICnssBuilder cnssBuilder)
        {
            _salaryStructureBuilder = salaryStructureBuilder;
            _contractTypeBuilder = contractTypeBuilder;
            _cnssBuilder = cnssBuilder;
        }

        public override SessionBonusViewModel BuildEntity(SessionBonus entity)
        {
            if (entity == null)
            {
                throw new ArgumentException("");
            }
            SessionBonusViewModel sessionBonusViewModel = base.BuildEntity(entity);
            if (entity.IdBonusNavigation != null && entity.IdBonusNavigation.IdCnssNavigation != null)
            {
                sessionBonusViewModel.IdBonusNavigation.IdCnssNavigation = _cnssBuilder.BuildEntity(entity.IdBonusNavigation.IdCnssNavigation);
            }
            if (sessionBonusViewModel.IdContractNavigation != null)
            {
                sessionBonusViewModel.IdContractNavigation.IdSalaryStructureNavigation = _salaryStructureBuilder.BuildEntity(entity.IdContractNavigation.IdSalaryStructureNavigation);
                sessionBonusViewModel.IdContractNavigation.IdContractTypeNavigation = _contractTypeBuilder.BuildEntity(entity.IdContractNavigation.IdContractTypeNavigation);
            }
            return sessionBonusViewModel;
        }
    }
}
