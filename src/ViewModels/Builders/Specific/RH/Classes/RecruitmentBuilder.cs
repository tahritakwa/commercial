using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class RecruitmentBuilder : GenericBuilder<RecruitmentViewModel, Recruitment>, IRecruitmentBuilder
    {
        private readonly IJobBuilder _jobBuilder;
        private readonly IRecruitmentLanguageBuilder _recruitmentLanguageBuilder;
        private readonly IRecruitmentSkillsBuilder _recruitmentSkillsBuilder;



        public RecruitmentBuilder(IJobBuilder jobBuilder, IRecruitmentLanguageBuilder recruitmentLanguageBuilder,IRecruitmentSkillsBuilder recruitmentSkillsBuilder)
        {
            _jobBuilder = jobBuilder;
            _recruitmentLanguageBuilder = recruitmentLanguageBuilder;
            _recruitmentSkillsBuilder = recruitmentSkillsBuilder;
        }
        public override RecruitmentViewModel BuildEntity(Recruitment entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            RecruitmentViewModel model = base.BuildEntity(entity);
            if (entity.IdJobNavigation != null)
            {
                model.IdJobNavigation = _jobBuilder.BuildEntity(entity.IdJobNavigation);
            }
            if (entity.RecruitmentLanguage != null)
            {
                model.RecruitmentLanguage = entity.RecruitmentLanguage.Select(_recruitmentLanguageBuilder.BuildEntity).ToList();
            }
            if (entity.RecruitmentSkills != null)
            {
                model.RecruitmentSkills = entity.RecruitmentSkills.Select(_recruitmentSkillsBuilder.BuildEntity).ToList();
            }
            return model;
        }
    }
}
