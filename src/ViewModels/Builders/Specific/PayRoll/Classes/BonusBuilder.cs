using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class BonusBuilder : GenericBuilder<BonusViewModel, Bonus>, IBonusBuilder
    {
        public override BonusViewModel BuildEntity(Bonus entity)
        {
            BonusViewModel bonusViewModel = base.BuildEntity(entity);
            if (entity.BonusValidityPeriod.Any())
            {
                bonusViewModel.StartDate = entity.BonusValidityPeriod.ToList().Min(x => x.StartDate);
            }
            return bonusViewModel;
        }
    }
}
