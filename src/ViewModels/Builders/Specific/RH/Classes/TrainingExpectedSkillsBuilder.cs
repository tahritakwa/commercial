using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TrainingExpectedSkillsBuilder : GenericBuilder<TrainingExpectedSkillsViewModel, TrainingExpectedSkills>, ITrainingExpectedSkillsBuilder
    {
        private readonly ISkillsBuilder _skillsBuilder;

        public TrainingExpectedSkillsBuilder(ISkillsBuilder skillsBuilder)
        {
            _skillsBuilder = skillsBuilder;
        }

        public override TrainingExpectedSkillsViewModel BuildEntity(TrainingExpectedSkills entity)
        {
            TrainingExpectedSkillsViewModel trainingExpectedSkillsViewModel = base.BuildEntity(entity);
            if (trainingExpectedSkillsViewModel != null)
            {
                if (trainingExpectedSkillsViewModel.IdSkillsNavigation != null)
                {
                    trainingExpectedSkillsViewModel.IdSkillsNavigation = _skillsBuilder.BuildEntity(entity.IdSkillsNavigation);
                }
            }
            return trainingExpectedSkillsViewModel;
        }
    }
}
