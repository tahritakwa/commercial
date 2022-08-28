using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Helpdesk
{
    public class ClaimViewModel : GenericViewModel
    {
        public ClaimViewModel()
        {
            ClaimInteraction = new List<ClaimInteractionViewModel>();
            StockMovement = new List<StockMovementViewModel>();
        }
        public string Code { get; set; }
        public string Description { get; set; }
        public string Reference { get; set; }
        public string Informations { get; set; }
        public string DeletedToken { get; set; }
        public bool IsTreated { get; set; }
        public int? IdClaimStatus { get; set; }
        public string ClaimType { get; set; }
        public int? IdWarehouse { get; set; }
        public int? IdItem { get; set; }
        public int? IdClient { get; set; }
        public int? IdContact { get; set; }
        public int? IdFournisseur { get; set; }
        public int? IdDocument { get; set; }
        public int? IdDocumentLine { get; set; }
        public double? ClaimQty { get; set; }
        public double? ClaimMaxQty { get; set; }
        public int? IdSalesAssetDocument { get; set; }
        public bool IsClaimQtyLocked { get; set; }
        public DateTime? DocumentDate { get; set; }
        public DateTime? ValidationDate { get; set; }
        public int? IdMovementIn { get; set; }
        public int? IdMovementOut { get; set; }
        public string ReferenceOldDocument { get; set; }
        public virtual ClaimStatusViewModel IdClaimStatusNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseNavigation { get; set; }
        public virtual ItemViewModel IdItemNavigation { get; set; }
        public virtual ReducedDocumentViewModel IdDocumentNavigation { get; set; }
        public virtual ReducedDocumentViewModel IdSalesAssetDocumentNavigation { get; set; }
        public virtual ReducedDocumentLineViewModel IdDocumentLineNavigation { get; set; }
        public virtual TiersViewModel IdClientNavigation { get; set; }
        public virtual ContactViewModel IdContactNavigation { get; set; }
        public virtual TiersViewModel IdFournisseurNavigation { get; set; }
        public virtual ClaimTypeViewModel ClaimTypeNavigation { get; set; }
        public virtual ICollection<ClaimInteractionViewModel> ClaimInteraction { get; set; }
        public virtual ICollection<StockMovementViewModel> StockMovement { get; set; }
        public virtual ReducedDocumentViewModel IdMovementInNavigation { get; set; }
        public virtual ReducedDocumentViewModel IdMovementOutNavigation { get; set; }
    }
}
