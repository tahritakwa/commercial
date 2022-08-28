using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ExternalTrainerViewModel : GenericViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public int? YearsOfExperience { get; set; }
        public double? HourCost { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<ExternalTrainerSkillsViewModel> ExternalTrainerSkills { get; set; }
        public ICollection<ExternalTrainingViewModel> ExternalTraining { get; set; }
        public ICollection<TrainingSessionViewModel> TrainingSession { get; set; }
    }
}
