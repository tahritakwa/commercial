using System.Collections.ObjectModel;
using System.Dynamic;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales.Document
{
    public class ReducedDocumentLineForGarage
    {
        public int Id { get; set; }
        public int IdDocument { get; set; }
        public int IdItem { get; set; }
        public int IdTiers { get; set; }
        public int IdCurrency { get; set; }
        public int? IdWarehouse { get; set; }
        public double Quantity { get; set; }  
        public bool IsDeleted { get; set; }
        public bool? IsFromGarage { get; set; }
        public ItemViewModel IdItemNavigation { get; set; }

        public ReducedDocumentLineForGarage()
        {

        }

        public ReducedDocumentLineForGarage(ReducedItemForGarage reducedItemForGarage)
        {
            IdItem = reducedItemForGarage.IdItem;
            Quantity = reducedItemForGarage.Quantity;
            IdWarehouse = reducedItemForGarage.IdWarehouse;
            IsFromGarage = true;
            IdItemNavigation = new ItemViewModel
            {
                Id = reducedItemForGarage.IdItem,
                Code = reducedItemForGarage.Code,
                Description = reducedItemForGarage.Name,
                UnitHtsalePrice = reducedItemForGarage.Htprice,
                IsForSales = true,
                HavePriceRole = true,
                IsForPurchase = false,
                IsKit = false,
                IsFromGarage = true
            };

            if (reducedItemForGarage.IdTaxe > 0)
            {
                IdItemNavigation.TaxeItem = new Collection<TaxeItemViewModel>
                {
                    new TaxeItemViewModel
                    {
                        IdItem = reducedItemForGarage.IdItem,
                        IdTaxe = reducedItemForGarage.IdTaxe
                    }
                };
            }

        }
    }
}
