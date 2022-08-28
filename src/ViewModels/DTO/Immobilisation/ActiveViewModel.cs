using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Immobilisation
{
    public class ActiveViewModel : GenericViewModel
    {

        public string Label { get; set; }
        public int? DepreciationPeriod { get; set; }
        public DateTime? AcquisationDate { get; set; }
        public DateTime? ServiceDate { get; set; }
        public int Status { get; set; }
        public int? IdDocumentLine { get; set; }
        public double Value { get; set; }
        public int? IdCategory { get; set; }
        public string Code { get; set; }
        public string DeletedToken { get; set; }
        public string NumSerie { get; set; }
        public string Description { get; set; }
        public int? IdWarehouse { get; set; }
        public string Ipaddress { get; set; }
        public string Macaddress { get; set; }
        public string HostName { get; set; }
        public string PhoneNumber { get; set; }
        public CategoryViewModel IdCategoryNavigation { get; set; }
        public DocumentLineViewModel IdDocumentLineNavigation { get; set; }
        public WarehouseViewModel IdWarehouseNavigation { get; set; }
        public ICollection<HistoryViewModel> History { get; set; }

    }
}
