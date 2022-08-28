using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocRowArticleDetails
    {
        public int DataSupplierId { get; set; }
        public string ArticleNumber { get; set; }
        public int MfrId { get; set; }
        public string MfrName { get; set; }
        public Misc Misc { get; set; }
        public List<GenericArticle> GenericArticles { get; set; }
        public List<ArticleText> ArticleText { get; set; }
        public List<string> Gtins { get; set; }
        public List<object> TradeNumbers { get; set; }
        public List<OemNumber> OemNumbers { get; set; }
        public List<object> ReplacesArticles { get; set; }
        public List<object> ReplacedByArticles { get; set; }
        public List<ArticleCriteria> ArticleCriteria { get; set; }
        public List<Linkage> Linkages { get; set; }
        public List<object> Pdfs { get; set; }
        public List<Image> Images { get; set; }
        public List<object> ComparableNumbers { get; set; }
        public List<object> links { get; set; }
        public int TotalLinkages { get; set; }
        public List<object> Prices { get; set; }
    }
}
