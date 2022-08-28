using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class EvaluationCriteriaViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public int IdEvaluationCriteriaTheme { get; set; }
        public string DeletedToken { get; set; }

        public EvaluationCriteriaThemeViewModel IdEvaluationCriteriaThemeNavigation { get; set; }
        public ICollection<CriteriaMarkViewModel> CriteriaMark { get; set; }
    }
}
