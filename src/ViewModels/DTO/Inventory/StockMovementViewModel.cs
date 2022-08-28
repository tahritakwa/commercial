using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class StockMovementViewModel : GenericViewModel
    {
        public int? IdDocumentLine { get; set; }
        public int? IdStockDocumentLine { get; set; }
        public int? IdItem { get; set; }
        public int? IdClaim { get; set; }
        public int IdWarehouse { get; set; }
        public int IdSection { get; set; }
        public DateTime? CreationDate { get; set; }
        public double? RealStock { get; set; }
        public double MovementQty { get; set; }
        public double? Cump { get; set; }
        public string Operation { get; set; }
        public string Status { get; set; }
        public string DeletedToken { get; set; }
        public DocumentLineViewModel IdDocumentLineNavigation { get; set; }
        public ClaimViewModel IdClaimNavigation { get; set; }
    }
}
