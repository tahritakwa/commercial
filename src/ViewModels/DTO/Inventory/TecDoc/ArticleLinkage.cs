namespace ViewModels.DTO.Inventory.TecDoc
{
    public class ArticleLinkage
    {
        public int articleLinkId { get; set; }
        public int linkingTargetId { get; set; }
        public string linkingTargetType { get; set; }
    }
}
