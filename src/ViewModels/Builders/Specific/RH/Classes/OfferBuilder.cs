using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class OfferBuilder : GenericBuilder<OfferViewModel, Offer>, IOfferBuilder
    {
        private readonly ICandidacyBuilder _candidacyBuilder;
        private readonly IOfferBenefitInKindBuilder _offerBenefitInKindBuilder;
        private readonly IOfferBonusBuilder _offerBonusBuilder;
        public OfferBuilder(ICandidacyBuilder candidacyBuilder, IOfferBenefitInKindBuilder offerBenefitInKindBuilder, IOfferBonusBuilder offerBonusBuilder)
        {
            _candidacyBuilder = candidacyBuilder;
            _offerBenefitInKindBuilder = offerBenefitInKindBuilder;
            _offerBonusBuilder = offerBonusBuilder;
        }
        public override OfferViewModel BuildEntity(Offer entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            OfferViewModel model = base.BuildEntity(entity);
            if (entity.IdCandidacyNavigation != null)
            {
                model.IdCandidacyNavigation = _candidacyBuilder.BuildEntity(entity.IdCandidacyNavigation);
            }
            if (entity.OfferBenefitInKind != null)
            {
                model.OfferBenefitInKind = entity.OfferBenefitInKind.Select(_offerBenefitInKindBuilder.BuildEntity).ToList();
            }
            if (entity.OfferBonus != null)
            {
                model.OfferBonus = entity.OfferBonus.Select(_offerBonusBuilder.BuildEntity).ToList();
            }
            return model;

        }
    }
}
