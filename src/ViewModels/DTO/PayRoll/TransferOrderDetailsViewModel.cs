using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class TransferOrderDetailsViewModel : GenericViewModel
    {
        public string Rib { get; set; }
        public string Label { get; set; }
        public double Amount { get; set; }
        public int IdTransferOrder { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public TransferOrderViewModel IdTransferOrderNavigation { get; set; }
    }
}
