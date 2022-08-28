using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class TransferOrderSessionViewModel : GenericViewModel
    {
        public int IdSession { get; set; }
        public int IdTransferOrder { get; set; }
        public string DeletedToken { get; set; }

        public SessionViewModel IdSessionNavigation { get; set; }
        public TransferOrderViewModel IdTransferOrderNavigation { get; set; }
    }
}
