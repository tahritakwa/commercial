using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Sales
{
    public class PricesViewModel : GenericViewModel
    {
        public string LabelPrices { get; set; }
        public string CodePrices { get; set; }
        public DateTime? CurrentDate { get; set; }
        public double? CurrentQuantity { get; set; }
        public int? IdUsedCurrency { get; set; }
        public double UnitPriceHTaxe { get; set; }
        public double TotalDiscount { get; set; }
        public IList<int> IdPrices { get; set; }
        public string AttachmentUrl { get; set; }
        public string ContractCode { get; set; }
        public virtual IList<IFormFile> Files { get; set; }
        public virtual ICollection<FileInfoViewModel> FilesInfos { get; set; }
        public virtual ICollection<string> UploadedFiles { get; set; }
        public virtual CurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public ICollection<DocumentLinePricesViewModel> DocumentLinePrices { get; set; }
        public virtual ICollection<ItemPricesViewModel> ItemPrices { get; set; }
        public virtual ICollection<PriceDetailViewModel> PriceDetail { get; set; }
        public virtual ICollection<PriceDetailViewModel> PriceQuantityDiscountList { get; set; }
        public virtual ICollection<PriceDetailViewModel> PriceTotalPurchasesDiscountList  { get; set; }
        public virtual ICollection<PriceDetailViewModel> PriceSpecialPriceDiscountList { get; set; }
        public virtual ICollection<PriceDetailViewModel> PriceGiftedItemsDiscountList { get; set; }
        public virtual ICollection<TiersPricesViewModel> TiersPrices { get; set; }
        public IList<FileInfoViewModel> ObservationsFilesInfo { get; set; }
        public int? UsedDiscountType { get; set; }
    }
}
