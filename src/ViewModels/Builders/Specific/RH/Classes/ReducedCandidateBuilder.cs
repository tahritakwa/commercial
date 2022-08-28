using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReducedCandidateBuilder : GenericBuilder<ReducedCandidateViewModel, Candidate>, IReducedCandidateBuilder
    {
        public ReducedCandidateBuilder()
        {

        }
        public override ReducedCandidateViewModel BuildEntity(Candidate entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }

            ReducedCandidateViewModel model = base.BuildEntity(entity);
            model.FullName = model.FirstName + " " + model.LastName;

            return model;

        }
    }
}
