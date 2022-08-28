using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class InterviewQuestionThemeViewModel : GenericViewModel
    {
        public string Theme { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<InterviewQuestionViewModel> InterviewQuestion { get; set; }
    }
}