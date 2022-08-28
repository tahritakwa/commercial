using System.Collections.Generic;

namespace ViewModels.DTO.Inventory
{
    public class EquivalentItemViewModel
    {
        public int IdItem { get; set; }
        public int Skip { get; set; }
        public int PageSize { get; set; }
        public List<int> ListOfExisting { get; set; }
        public string ValueToFind { get; set; }

    }
}
