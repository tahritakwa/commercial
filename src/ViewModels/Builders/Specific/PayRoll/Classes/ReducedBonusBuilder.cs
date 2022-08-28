using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ReducedBonusBuilder : GenericBuilder<ReducedBonusViewModel, Bonus>, IReducedBonusBuilder
    {
        public override ReducedBonusViewModel BuildEntity(Bonus entity)
        {
            ReducedBonusViewModel reducedBonusViewModel = base.BuildEntity(entity);
            if (entity.BonusValidityPeriod.Any())
            {
                reducedBonusViewModel.StartDate = entity.BonusValidityPeriod.ToList().Min(x => x.StartDate);
            }
            return reducedBonusViewModel;
        }
    }
}
