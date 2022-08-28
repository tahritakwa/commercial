using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.RH
{
    public class TrainingSessionViewModel : GenericViewModel
    {

        public int Status { get; set; }
        public int IdTraining { get; set; }
        public string DeletedToken { get; set; }
        public int NumberOfSeance { get; set; }
        public int NumberOfParticipant { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double? Duration { get; set; }
        public string SessionPlan { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string SessionPlanUrl { get; set; }
        public int? IdExternalTrainer { get; set; }

        public ExternalTrainerViewModel IdExternalTrainerNavigation { get; set; }
        public IList<FileInfoViewModel> SessionPlanFileInfo { get; set; }
        public TrainingViewModel IdTrainingNavigation { get; set; }
        public ICollection<TrainingRequestViewModel> TrainingRequest { get; set; }
        public ICollection<TrainingSeanceViewModel> TrainingSeance { get; set; }
        public ICollection<ExternalTrainingViewModel> ExternalTraining { get; set; }
        public ICollection<EmployeeTrainingSessionViewModel> EmployeeTrainingSession { get; set; }
    }
}
