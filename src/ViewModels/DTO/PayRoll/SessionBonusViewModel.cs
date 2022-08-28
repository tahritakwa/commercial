using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SessionBonusViewModel : GenericViewModel
    {
        public int IdBonus { get; set; }
        public int IdSession { get; set; }
        public int IdContract { get; set; }
        public double Value { get; set; }
        public string DeletedToken { get; set; }

        public BonusViewModel IdBonusNavigation { get; set; }
        public ContractViewModel IdContractNavigation { get; set; }
        public SessionViewModel IdSessionNavigation { get; set; }
    }
}
