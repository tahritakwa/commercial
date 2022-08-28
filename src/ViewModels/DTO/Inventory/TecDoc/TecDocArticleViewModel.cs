using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocArticleViewModel
    {
        public int Id { get; set; }
        public string Reference { get; set; }
        public string Description { get; set; }
        public int IdSupplier { get; set; }
        public string Supplier { get; set; }
        public List<string> PassengerCarList { get; set; }
        public bool IsInDb { get; set; }
        public ReducedListItemViewModel ItemInDB { get; set; }
        public ItemExportPdfViewModel B2bItems { get; set; }
        public string BarCode { get; set; }
        public bool IsUnsubbed { get; set; }
        public int? IdOem { get; set; }
        public string ImagesUrl { get; set; }
        public List<OemNumber> OemNumbers { get; set; }
        public List<String> TecDocImageList { get; set; }


    }
}
