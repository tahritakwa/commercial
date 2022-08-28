using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TrainingBuilder : GenericBuilder<TrainingViewModel, Training>, ITrainingBuilder
    {
        private readonly ITiersBuilder _tiersBuilder;
        private readonly ITrainingByEmployeeBuilder _trainingByEmployeeBuilder;
        private readonly ITrainingExpectedSkillsBuilder _trainingExpectedSkills;
        private readonly ITrainingRequiredSkillsBuilder _trainingRequiredSkills;

        public TrainingBuilder(ITiersBuilder tiersBuilder, ITrainingByEmployeeBuilder trainingByEmployeeBuilder,
            ITrainingExpectedSkillsBuilder trainingExpectedSkills, ITrainingRequiredSkillsBuilder trainingRequiredSkills)
        {
            _tiersBuilder = tiersBuilder;
            _trainingByEmployeeBuilder = trainingByEmployeeBuilder;
            _trainingExpectedSkills = trainingExpectedSkills;
            _trainingRequiredSkills = trainingRequiredSkills;
        }

        public override TrainingViewModel BuildEntity(Training entity)
        {
            TrainingViewModel trainingViewModel = base.BuildEntity(entity);
            if(trainingViewModel != null)
            {
                if (trainingViewModel.IdSupplierNavigation != null)
                {
                    trainingViewModel.IdSupplierNavigation = _tiersBuilder.BuildEntity(entity.IdSupplierNavigation);
                }
                if (trainingViewModel.TrainingByEmployee != null)
                {
                    trainingViewModel.TrainingByEmployee = entity.TrainingByEmployee.Select(x => _trainingByEmployeeBuilder.BuildEntity(x)).ToList();
                }
                if (trainingViewModel.TrainingRequiredSkills != null)
                {
                    trainingViewModel.TrainingRequiredSkills = entity.TrainingRequiredSkills.Select(x => _trainingRequiredSkills.BuildEntity(x)).ToList();
                }
                if (trainingViewModel.TrainingExpectedSkills != null)
                {
                    trainingViewModel.TrainingExpectedSkills = entity.TrainingExpectedSkills.Select(x => _trainingExpectedSkills.BuildEntity(x)).ToList();
                }
               
            }
            return trainingViewModel;
        }
    }
}
