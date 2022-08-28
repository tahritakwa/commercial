using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Inventory
{
    public class ReducedItemViewModel
    {

        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public string BarCode1D { get; set; }
        public string BarCode2D { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public ICollection<ReducedItemWarehouseViewModel> ItemWarehouse { get; set; }
        public ICollection<ReducedItemViewModel> ListOfEquivalenceItem { get; set; }
        public ReducedNatureViewModel IdNatureNavigation { get; set; }
        public ProductItemViewModel IdProductItemNavigation { get; set; }
        public int? IdProductItem { get; set; }
        public int? IdDocumentLine { get; set; }


        public ReducedItemViewModel()
        {
        }

        public ReducedItemViewModel(ItemViewModel idItemNavigation)
        {
            if (idItemNavigation != null)
            {
                Id = idItemNavigation.Id;
                Code = idItemNavigation.Code;
                Description = idItemNavigation.Description;
                UnitHtsalePrice = idItemNavigation.UnitHtsalePrice;
                BarCode1D = idItemNavigation.BarCode1D;
                BarCode2D = idItemNavigation.BarCode2D;
                EquivalenceItem = idItemNavigation.EquivalenceItem;
                ListOfEquivalenceItem = idItemNavigation.ListOfEquivalenceItem;
                IdNatureNavigation = new ReducedNatureViewModel(idItemNavigation.IdNatureNavigation);
                IdProductItemNavigation = idItemNavigation.IdProductItemNavigation;
                IdProductItem = idItemNavigation.IdProductItem;
                IdDocumentLine = idItemNavigation.IdDocumentLine;
            }
        }
    }
}
