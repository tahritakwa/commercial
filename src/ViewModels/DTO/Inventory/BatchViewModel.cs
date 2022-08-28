using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class BatchViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
    }
}
