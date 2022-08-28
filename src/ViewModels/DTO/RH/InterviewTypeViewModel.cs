using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class InterviewTypeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public ICollection<InterviewViewModel> Interview { get; set; }
    }
}
