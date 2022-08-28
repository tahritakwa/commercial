using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class EmployeeTrainingSessionViewModel : GenericViewModel
    {
        public int IdEmployee { get; set; }
        public int IdTrainingSession { get; set; }
        public string DeletedToken { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public TrainingSessionViewModel IdTrainingSessionNavigation { get; set; }
    }
}
