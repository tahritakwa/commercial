using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class QuestionViewModel : GenericViewModel
    {
        public string QuestionLabel { get; set; }
        public string ResponseLabel { get; set; }
        public int IdInterview { get; set; }
        public string DeletedToken { get; set; }

        public InterviewViewModel IdInterviewNavigation { get; set; }
    }
}
