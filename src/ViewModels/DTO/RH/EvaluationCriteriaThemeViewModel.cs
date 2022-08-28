using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class EvaluationCriteriaThemeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public int CriteriaNumber { get; set; }

        public ICollection<EvaluationCriteriaViewModel> EvaluationCriteria { get; set; }
    }
}
