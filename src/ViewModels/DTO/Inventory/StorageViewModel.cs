using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class StorageViewModel : GenericViewModel
    {
        public int IdArticle { get; set; }
        public string ArticleDesignation { get; set; }
        public int IdSection { get; set; }
        public string SectionLabel { get; set; }
        public int StorageNumber { get; set; }
        public double Cump { get; set; }
        public virtual ICollection<DocumentLineViewModel> DocumentLine { get; set; }
    }
}
