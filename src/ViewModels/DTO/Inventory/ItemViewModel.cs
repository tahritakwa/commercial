using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class




        ItemViewModel : GenericViewModel
    {


        public ItemViewModel()
        {
            ItemWarehouse = new HashSet<ItemWarehouseViewModel>();
            TaxeItem = new HashSet<TaxeItemViewModel>();
        }
        public string Code { get; set; }
        public string Description { get; set; }
        public string RefDesignation { get; set; }
        public int? IdNature { get; set; }
        public string BarCode1D { get; set; }
        public string BarCode2D { get; set; }
        public int? IdUnitStock { get; set; }
        public int? IdUnitSales { get; set; }
        public double? CoeffConversion { get; set; }
        public int? IdPolicyValorization { get; set; }
        public double? UnitHtpurchasePrice { get; set; }
        public double? Htprice { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public double? UnitTtcpurchasePrice { get; set; }
        public double? UnitTtcsalePrice { get; set; }
        public double? Tvarate { get; set; }
        public double? FixedMargin { get; set; }
        public double? VariableMargin { get; set; }
        public int? ItemInt1 { get; set; }
        public double? ItemFloat1 { get; set; }
        public double? ItemFloat2 { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public double? AverageSalesPerDay { get; set; }
        public double? CentralMinQuantity { get; set; }
        public int TiersDeleveryDelay { get; set; }
        public double AllMovementQuantity { get; set; }
        public int? IdEmployee { get; set; }
        public int? IdProductItem { get; set; }
        public virtual ICollection<ItemWarehouseViewModel> ItemWarehouse { get; set; }
        public virtual ICollection<TaxeItemViewModel> TaxeItem { get; set; }
        public virtual TaxeViewModel IdTaxeNavigation { get; set; }
        public virtual MeasureUnitViewModel IdUnitSalesNavigation { get; set; }
        public virtual MeasureUnitViewModel IdUnitStockNavigation { get; set; }
        public virtual NatureViewModel IdNatureNavigation { get; set; }
        public List<WarehouseViewModel> listOfWarehouses { get; set; }
        public int? IdDocumentLine { get; set; }
        public double? QuanityToOrder { get; set; }

        public string TecDocBrandName { get; set; }

        public int? IdFamily { get; set; }
        public int? IdSubFamily { get; set; }
        public bool OnOrder { get; set; }
        public string Note { get; set; }
        public virtual FamilyViewModel IdFamilyNavigation { get; set; }
        public virtual SubFamilyViewModel IdSubFamilyNavigation { get; set; }
        public virtual ICollection<ExpenseViewModel> Expense { get; set; }
        public virtual ICollection<ReducedItemViewModel> ListOfEquivalenceItem { get; set; }
        public virtual ICollection<DeliveryViewModel> Delivery { get; set; }
        public bool? CreatedByDocumentLine { get; set; }
        public double AllAvailableQuantity { get; set; }
        public double WarhouseAvailableQuantity { get; set; }
        public double EcommerceAvailableQuantity { get; set; }
        public int? IdAccountingAccountSales { get; set; }
        public int? IdAccountingAccountPurchase { get; set; }
        [Key]
        public int? TecDocId { get; set; }
        public string TecDocRef { get; set; }
        public int? TecDocIdSupplier { get; set; }
        public ICollection<TiersViewModel> ListTiers { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public bool IsForSales { get; set; }
        public bool IsForPurchase { get; set; }
        public bool IsKit { get; set; }
        public ICollection<ItemKitViewModel> ItemKitIdKitNavigation { get; set; }
        public ICollection<ItemKitViewModel> ItemKitIdItemNavigation { get; set; }
        public virtual ICollection<ItemPricesViewModel> ItemPrices { get; set; }
        public int? IdItemReplacement { get; set; }
        public bool? IsAvailable { get; set; }
        public ICollection<ItemVehicleBrandModelSubModelViewModel> ItemVehicleBrandModelSubModel { get; set; }
        public ProductItemViewModel IdProductItemNavigation { get; set; }
        public bool? HaveClaims { get; set; }
        public double OrderedQuantity { get; set; }
        public double? DefaultUnitHtpurchasePrice { get; set; }
        public double RemainingQuantity { get; set; }
        public bool IsEcommerce { get; set; }
        public bool ExistInEcommerce { get; set; }
        public int? OnlineSynchonizationStatus { get; set; }
        public int? SynchonizationStatus { get; set; }
        public DateTime? LastUpdateEcommerce { get; set; }
        public ICollection<TriggerItemLogViewModel> TriggerItemLog { get; set; }
        public string CRP { get; set; }
        public double CMD { get; set; }
        public string LabelVehicule { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public DateTime? AvailableDate { get; set; }
        public bool IsUsed { get; set; }
        public ItemViewModel ShallowCopy()
        {
            return (ItemViewModel)MemberwiseClone();
        }
        public string userMail { set; get; }
        public double ReliquatQty { get; set; }
        public string TecDocImageUrl { get; set; }
        public string UrlPicture { get; set; }
        public virtual IList<FileInfoViewModel> FilesInfos { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public bool HavePriceRole { get; set; }
        public bool ProvInventory { get; set; }
        public bool? IsFromGarage { get; set; }
        public bool IsAffected { get; set; }
        public virtual ICollection<ItemTiersViewModel> ItemTiers { get; set; }
        public string NameTiers { get; set; }
        public string LabelProduct { get; set; }
        public NumberFormatOptionsViewModel UnitHtPurchasePriceFormatOption { get; set; }
        public double NumberDaysOutStock { get; set; }
        public string ListTiersNames { get; set; }
        public string SearchString { get; set; }
        public ICollection<OemItemViewModel> OemItem { get; set; }
        public List<string> TecDocImageList { get; set; }
        public double? CostPrice { get; set; }
        public DateTime? UpdatedDatePicture { get; set; }
        public bool IsUpdatedPicture { get; set; } = false;
        public virtual ICollection<ItemSalesPriceViewModel> ItemSalesPrice { get; set; }
    }
}
