using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class SessionContractViewModel : GenericViewModel
    {
        public int IdSession { get; set; }
        public int IdContract { get; set; }
        public string DeletedToken { get; set; }

        public TimeSheetViewModel IdTimeSheetNavigation { get; set; }
        public ContractViewModel IdContractNavigation { get; set; }
        public SessionViewModel IdSessionNavigation { get; set; }
    }
}
