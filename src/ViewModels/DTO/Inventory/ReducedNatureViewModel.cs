namespace ViewModels.DTO.Inventory
{
    public class ReducedNatureViewModel
    {

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public bool IsStockManaged { get; set; }

        public ReducedNatureViewModel()
        {
        }

        public ReducedNatureViewModel(NatureViewModel idNatureNavigation)
        {
            if (idNatureNavigation != null)
            {
                Id = idNatureNavigation.Id;
                Code = idNatureNavigation.Code;
                Label = idNatureNavigation.Label;
                IsStockManaged = idNatureNavigation.IsStockManaged;
            }
        }
    }
}
