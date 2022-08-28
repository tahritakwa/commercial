using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class InterviewQuestionViewModel : GenericViewModel
    {
        public int Type { get; set; }
        public string Question { get; set; }
        public string DeletedToken { get; set; }
        public int IdTheme { get; set; }

        public InterviewQuestionThemeViewModel IdThemeNavigation { get; set; }
    }
}