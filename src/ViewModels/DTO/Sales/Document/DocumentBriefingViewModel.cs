using System;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentBriefingViewModel
    {
        public int Id { set; get; }
        public string DocumentType { set; get; }
        public int DocumentStatus { set; get; }
        public DateTime DocumentDate { get; set; }
        public ICollection<ItemViewModel> items { get; set; }
        public int totalItems { get; set; }
    }
}
