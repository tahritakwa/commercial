using System;

namespace ViewModels.DTO.Inventory
{
    public class ReducedEquivalentItem
    {
        public string Description { get; set; }
        public Guid? EquivalenceItem { get; set; }

        public ReducedEquivalentItem()
        {
        }
    }
}
