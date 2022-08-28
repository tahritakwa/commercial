using ModelView.B2B;
using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Inventory
{
    public class




        ItemB2bViewModel : GenericViewModel
    {


        public ItemB2bViewModel()
        {
            ItemWarehouse = new HashSet<ItemWarehouseViewModel>();
        }
        public string Code { get; set; }
        public string Description { get; set; }
        public double? Htprice { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public double? UnitTtcpurchasePrice { get; set; }
        public double? UnitTtcsalePrice { get; set; }
        public int? IdProductItem { get; set; }
        public virtual ICollection<ItemWarehouseViewModel> ItemWarehouse { get; set; }
        public int? IdFamily { get; set; }
        public int? IdSubFamily { get; set; }
        public List <int> ListOfEquivalenceItem { get; set; }
        public double AllAvailableQuantity { get; set; }
        public bool IsForSales { get; set; }
        public bool IsForPurchase { get; set; }
        public int? IdItemReplacement { get; set; }
        public bool? IsAvailable { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsUpdatedPicture { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public string UrlPicture { get; set; }
        public virtual IList<FileInfoViewModel> FilesInfos { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public string LabelProduct { get; set; }
        public int Id { get; set; }
        public virtual ICollection<PriceCategoryViewModel> ItemSalesPrice { get; set; }
        public IList<int?> IdBrands { get; set; }
    }
}
