using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ArticleFeaturesViewModel : GenericViewModel
    {
        public int IdArticle { get; set; }
        public int IdFeature { get; set; }
        public string Value { get; set; }
        public virtual FeatureViewModel IdFeatureNavigation { get; set; }
    }
}
