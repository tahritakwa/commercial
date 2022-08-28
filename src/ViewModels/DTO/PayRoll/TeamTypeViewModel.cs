using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class TeamTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }

        public ICollection<TeamViewModel> Team { get; set; }
    }
}
