using Persistence.Entities;
using System;
using System.Linq;
using Utils.Enumerators.RHEnumerators;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class CandidacyBuilder : GenericBuilder<CandidacyViewModel, Candidacy>, ICandidacyBuilder
    {
        private readonly ICandidateBuilder _candidateBuilder;
        private readonly IRecruitmentBuilder _recruitmentBuilder;
        private readonly IInterviewBuilder _interviewBuilder;

        public CandidacyBuilder(ICandidateBuilder candidateBuilder, IRecruitmentBuilder recruitmentBuilder, IInterviewBuilder interviewBuilder)
        {
            _candidateBuilder = candidateBuilder;
            _recruitmentBuilder = recruitmentBuilder;
            _interviewBuilder = interviewBuilder; 
        }

        public override CandidacyViewModel BuildEntity(Candidacy entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }

            CandidacyViewModel model = base.BuildEntity(entity);
            if (entity.Interview != null)
            {
                model.Interview = entity.Interview.Select(_interviewBuilder.BuildEntity).ToList();
                model.TotalAverageMark = 0;
                int index = 0;
                foreach (Interview interview in entity.Interview)
                {
                    if (interview.AverageMark != null)
                    {
                        model.TotalAverageMark += interview.AverageMark;
                        index++;
                    }
                }
                model.TotalAverageMark = (index != 0) ? model.TotalAverageMark / index : 0;
            }
            model.NumberOfOffer = 0;
            model.HasAlreadyAnOffer = false;
            if (entity.Offer != null)
            {
                model.NumberOfOffer = entity.Offer.Count;
                if (entity.Offer.ToList().Any(m => !m.State.Equals((int)OfferStateEnumerator.Rejected)))
                {
                    model.HasAlreadyAnOffer = true;
                }
            }
            if (entity.IdCandidateNavigation != null)
            {
                model.IdCandidateNavigation = _candidateBuilder.BuildEntity(entity.IdCandidateNavigation);
            }
            if (entity.IdRecruitmentNavigation != null)
            {
                model.IdRecruitmentNavigation = _recruitmentBuilder.BuildEntity(entity.IdRecruitmentNavigation);
            }
            return model;
        }
    }
}
