using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class OfferBonusBuilder : GenericBuilder<OfferBonusViewModel, OfferBonus>, IOfferBonusBuilder
    {
        private readonly IBonusValidityPeriodBuilder _bonusValidityPeriodBuilder;

        public OfferBonusBuilder(IBonusValidityPeriodBuilder bonusValidityPeriodBuilder)
        {
            _bonusValidityPeriodBuilder = bonusValidityPeriodBuilder;
        }
        public override OfferBonusViewModel BuildEntity(OfferBonus entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            OfferBonusViewModel model = base.BuildEntity(entity);
            if (entity.IdBonusNavigation != null && entity.IdBonusNavigation.BonusValidityPeriod != null)
            {
                model.IdBonusNavigation.BonusValidityPeriod = entity.IdBonusNavigation.BonusValidityPeriod.Select(_bonusValidityPeriodBuilder.BuildEntity).ToList();
            }
            return model;

        }
    }
}
