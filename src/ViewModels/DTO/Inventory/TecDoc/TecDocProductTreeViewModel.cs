using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocProductTreeViewModel
    {
        public int IdNode { get; set; }
        public string NodeText { get; set; }
        public bool IsRoot { get; set; }
        public List<TecDocProductTreeViewModel> children { get; set; }
    }
}
