using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TrainingByEmployeeBuilder : GenericBuilder<TrainingByEmployeeViewModel, TrainingByEmployee>, ITrainingByEmployeeBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;

        public TrainingByEmployeeBuilder(IEmployeeBuilder employeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
        }

        public override TrainingByEmployeeViewModel BuildEntity(TrainingByEmployee entity)
        {
            TrainingByEmployeeViewModel trainingByEmployeeViewModel = base.BuildEntity(entity);
            if (trainingByEmployeeViewModel != null)
            {
                if (trainingByEmployeeViewModel.IdEmployeeNavigation != null)
                {
                    trainingByEmployeeViewModel.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdEmployeeNavigation);
                }
            }
            return trainingByEmployeeViewModel;
        }
    }
}
