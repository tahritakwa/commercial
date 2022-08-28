using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class PaymentConditionViewModel : GenericViewModel
    {
        public int Nbr { get; set; }
        public string Designation { get; set; }
        public string Unit { get; set; }
    }
}
