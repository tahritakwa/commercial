namespace ViewModels.DTO.Sales
{
    public class ReducedTiersViewModel
    {
        public int Id { get; set; }
        public int IdTypeTiers { get; set; }
        public string Name { get; set; }
        public string CodeTiers { get; set; }
        public int? IdTaxeGroupTiers { get; set; }
        public int? IdCurrency { get; set; }
        public int? TiersClassification { get; set; }

        public ReducedTiersViewModel()
        {

        }

        public ReducedTiersViewModel(TiersViewModel idSupplier)
        {
            if (idSupplier != null)
            {
                Id = idSupplier.Id;
                IdCurrency = idSupplier.IdCurrency;
                IdTaxeGroupTiers = idSupplier.IdTaxeGroupTiers;
                Name = idSupplier.Name;
                IdTypeTiers = idSupplier.IdTypeTiers;
                CodeTiers = idSupplier.CodeTiers;
                TiersClassification = idSupplier.TiersClassification;
            }
        }
    }
}
