using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class FeatureViewModel : GenericViewModel
    {
        public string FeatureName { get; set; }
        public string FeatureCode { get; set; }
        public int? IdUnitType { get; set; }
        public virtual ICollection<ArticleFeaturesViewModel> ArticleFeatures { get; set; }
        public string unitTypeLabel { get; set; }
    }
}
