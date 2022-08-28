using System;
using System.Collections.Generic;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentListViewModel
    {
        public bool isPartiallyLivred;
        public bool isDraft;
        public bool isBcSent;
        public bool refused;
        public bool isTotallyLivred;

        public bool haveReservedLines { get; set; }
        public int? IdUsedCurrency { get; set; }
        public int Id { get; set; }
        public DateTime DocumentDate { get; set; }
        public string Code { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public int? InoicingType { get; set; }
        public IdTiersNavigation IdTiersNavigation { get; set; }
        public IdCreatorNavigation IdCreatorNavigation { get; set; }
        public IdDocumentStatusNavigation IdDocumentStatusNavigation { get; set; }
        public int IdDocumentStatus { get; set; }
        public bool? IsDeliverySuccess { get; set; }
        public string DocumentTypeCode { get; set; }
        public bool? IsBToB { get; set; }
        public int? IdInvoiceEcommerce { get; set; }
        public string CurrencyCode { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
        public ICollection<ClaimViewModel> ClaimIdAssetDocumentNavigation { get; set; }
        public string ProvisionalCode { get; set; }
        
    }

    public class IdTiersNavigation
    {
        public string Name { get; set; }
        public string Region { get; set; }
        public string UrlPicture { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
    }

    public class ClaimIdAssetDocumentNavigation
    {
        public string Code { get; set; }
    }

    public class IdCreatorNavigation
    {
        public string FullName { get; set; }
    }

    public class IdDocumentStatusNavigation
    {
        public string Label { get; set; }
        public string Color { get; set; }
    }

}