using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class CriteriaMarkViewModel : GenericViewModel
    {
        public double? Mark { get; set; }
        public int IdEvaluationCriteria { get; set; }
        public int IdInterviewMark { get; set; }
        public string DeletedToken { get; set; }

        public int IdEvaluationCriteriaTheme { get; set; }

        public InterviewMarkViewModel IdInterviewMarkNavigation { get; set; }
        public EvaluationCriteriaViewModel IdEvaluationCriteriaNavigation { get; set; }
    }
}
