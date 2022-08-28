using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class TrainingCenterViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string Place { get; set; }
        public TimeSpan? OpeningTime { get; set; }
        public TimeSpan? ClosingTime { get; set; }
        public int? ModeOfPayment { get; set; }
        public string CenterPhoneNumber { get; set; }
        public string DeletedToken { get; set; }
        public int? IdTrainingCenterManager { get; set; }

        public virtual TrainingCenterManagerViewModel IdTrainingCenterManagerNavigation { get; set; }
        public virtual ICollection<TrainingCenterRoomViewModel> TrainingCenterRoom { get; set; }
    }
}
