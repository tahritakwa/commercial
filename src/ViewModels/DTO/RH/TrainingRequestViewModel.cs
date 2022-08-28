using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class TrainingRequestViewModel : GenericViewModel
    {
        public DateTime? ExpectedDate { get; set; }
        public int Status { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int IdTraining { get; set; }
        public int IdEmployeeAuthor { get; set; }
        public int IdEmployeeCollaborator { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }
        public int? IdTrainingSession { get; set; }

        public EmployeeViewModel IdEmployeeAuthorNavigation { get; set; }
        public EmployeeViewModel IdEmployeeCollaboratorNavigation { get; set; }
        public TrainingViewModel IdTrainingNavigation { get; set; }
        public TrainingSessionViewModel IdTrainingSessionNavigation { get; set; }
    }
}
