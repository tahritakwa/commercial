using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class TrainingByEmployeeViewModel : GenericViewModel
    {
        public int IdEmployee { get; set; }
        public int IdTraining { get; set; }
        public string DeletedToken { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public TrainingViewModel IdTrainingNavigation { get; set; }
    }
}
