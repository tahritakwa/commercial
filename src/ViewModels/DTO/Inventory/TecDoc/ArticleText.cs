using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class ArticleText
    {
        public int informationTypeKey { get; set; }
        public string informationTypeDescription { get; set; }
        public bool isImmediateDisplay { get; set; }
        public List<string> text { get; set; }
    }
}
