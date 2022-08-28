using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Helpdesk
{
    public class ReducedClaimViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public string Reference { get; set; }
        public string Informations { get; set; }
        public string DeletedToken { get; set; }
        public bool IsTreated { get; set; }
        public int? IdClaimStatus { get; set; }
        public string ClaimType { get; set; }
        public int? IdClaimType { get; set; }
        public int? IdWarehouse { get; set; }
        public int? IdItem { get; set; }
        public int? IdClient { get; set; }
        public int? IdContact { get; set; }
        public int? IdFournisseur { get; set; }
        public int? IdDocument { get; set; }
        public int? IdDocumentLine { get; set; }
        public DateTime? DocumentDate { get; set; }
        public DateTime? ValidationDate { get; set; }
    }
}
