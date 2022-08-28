using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class Linkage
    {
        public int linkageTargetTypeId { get; set; }
        public int linkageTargetId { get; set; }
        public int legacyArticleLinkId { get; set; }
        public int genericArticleId { get; set; }
        public string genericArticleDescription { get; set; }
        public List<object> linkageCriteria { get; set; }
        public List<object> linkageText { get; set; }
    }
}
