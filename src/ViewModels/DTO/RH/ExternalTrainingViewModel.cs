using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ExternalTrainingViewModel : GenericViewModel
    {
        public int IdExternalTrainer { get; set; }
        public int IdTrainingCenterRoom { get; set; }
        public string DeletedToken { get; set; }
        public int? IdTrainingSession { get; set; }

        public ExternalTrainerViewModel IdExternalTrainerNavigation { get; set; }
        public TrainingCenterRoomViewModel IdTrainingCenterRoomNavigation { get; set; }
        public TrainingSessionViewModel IdTrainingSessionNavigation { get; set; }
    }
}
