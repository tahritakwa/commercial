using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReducedCandidacyBuilder : GenericBuilder<ReducedCandidacyViewModel, Candidacy>, IReducedCandidacyBuilder
    {
        private readonly ICandidateBuilder _candidateBuilder;
        public ReducedCandidacyBuilder(ICandidateBuilder candidateBuilder)
        {
            _candidateBuilder = candidateBuilder;
        }

        public override ReducedCandidacyViewModel BuildEntity(Candidacy entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }

            ReducedCandidacyViewModel model = base.BuildEntity(entity);

            if (entity.IdCandidateNavigation != null)
            {
                model.IdCandidateNavigation = _candidateBuilder.BuildEntity(entity.IdCandidateNavigation);
            }

            return model;
        }
    }
}
