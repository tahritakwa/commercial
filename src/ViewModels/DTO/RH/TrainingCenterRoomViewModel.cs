using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class TrainingCenterRoomViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public int? Capacity { get; set; }
        public int? Availability { get; set; }
        public int? RoomType { get; set; }
        public double? RentPerHour { get; set; }
        public string DeletedToken { get; set; }
        public int IdTrainingCenter { get; set; }

        public TrainingCenterViewModel IdTrainingCenterNavigation { get; set; }
        public ICollection<ExternalTrainingViewModel> ExternalTraining { get; set; }
    }
}
