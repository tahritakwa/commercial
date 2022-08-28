using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class SerialNumberViewModel : GenericViewModel
    {
        public string SerialNumberLabel { get; set; }
        public int IdBatch { get; set; }
        public string BatchLabel { get; set; }
        public int IdArticle { get; set; }
        public string ArticleLabel { get; set; }
        public string ArticleBarCode { get; set; }
    }
}
