using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ContractAdvantageViewModel : GenericViewModel
    {
        public int IdContract { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }

        public ContractViewModel IdContractNavigation { get; set; }
    }
}
