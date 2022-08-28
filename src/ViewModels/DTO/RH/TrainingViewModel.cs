using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.RH
{
    public class TrainingViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public double? Duration { get; set; }
        public bool IsCertified { get; set; }
        public bool IsInternal { get; set; }
        public int? IdSupplier { get; set; }
        public string TrainingPictureUrl { get; set; }
        public FileInfoViewModel TrainingPictureFileInfo { get; set; }
        public string DeletedToken { get; set; }
        public TiersViewModel IdSupplierNavigation { get; set; }
        public ICollection<TrainingByEmployeeViewModel> TrainingByEmployee { get; set; }
        public ICollection<TrainingExpectedSkillsViewModel> TrainingExpectedSkills { get; set; }
        public ICollection<TrainingRequestViewModel> TrainingRequest { get; set; }
        public ICollection<TrainingRequiredSkillsViewModel> TrainingRequiredSkills { get; set; }
        public ICollection<TrainingSessionViewModel> TrainingSession { get; set; }


    }
}
