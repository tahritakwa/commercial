using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TrainingRequiredSkillsBuilder : GenericBuilder<TrainingRequiredSkillsViewModel, TrainingRequiredSkills>, ITrainingRequiredSkillsBuilder
    {
        private readonly ISkillsBuilder _skillsBuilder;

        public TrainingRequiredSkillsBuilder(ISkillsBuilder skillsBuilder)
        {
            _skillsBuilder = skillsBuilder;
        }

        public override TrainingRequiredSkillsViewModel BuildEntity(TrainingRequiredSkills entity)
        {
            TrainingRequiredSkillsViewModel trainingRequiredSkillsViewModel = base.BuildEntity(entity);
            if (trainingRequiredSkillsViewModel != null)
            {
                if (trainingRequiredSkillsViewModel.IdSkillsNavigation != null)
                {
                    trainingRequiredSkillsViewModel.IdSkillsNavigation = _skillsBuilder.BuildEntity(entity.IdSkillsNavigation);
                }
            }
            return trainingRequiredSkillsViewModel;
        }
    }
}
