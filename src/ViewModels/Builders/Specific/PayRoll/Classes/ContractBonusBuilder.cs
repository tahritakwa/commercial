using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ContractBonusBuilder : GenericBuilder<ContractBonusViewModel, ContractBonus>, IContractBonusBuilder
    {
        private readonly IBonusBuilder _bonusBuilder;

        public ContractBonusBuilder(IBonusBuilder bonusBuilder)
        {
            _bonusBuilder = bonusBuilder;
        }

        public override ContractBonusViewModel BuildEntity(ContractBonus entity)
        {
            ContractBonusViewModel contractBonusViewModel = base.BuildEntity(entity);
            if (entity.IdBonusNavigation != null)
            {
                contractBonusViewModel.IdBonusNavigation = _bonusBuilder.BuildEntity(entity.IdBonusNavigation);
            }
            return contractBonusViewModel;
        }
    }
}
