using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class StockDocumentTypeViewModel : GenericViewModel
    {
        public string CodeType { get; set; }
        public string Type { get; set; }
        public string MovementType { get; set; }
        public string Description { get; set; }
        public virtual ICollection<StockDocumentViewModel> StockDocument { get; set; }
    }
}
