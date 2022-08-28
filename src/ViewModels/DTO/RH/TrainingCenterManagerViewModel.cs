using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class TrainingCenterManagerViewModel : GenericViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string DeletedToken { get; set; }

        public virtual ICollection<TrainingCenterViewModel> TrainingCenter { get; set; }
    }
}
