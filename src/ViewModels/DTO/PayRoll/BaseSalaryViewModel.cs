using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class BaseSalaryViewModel : GenericViewModel
    {
        public int IdContract { get; set; }
        public string DeletedToken { get; set; }
        public double Value { get; set; }
        public DateTime StartDate { get; set; }
        public int? State { get; set; }
        public ContractViewModel IdContractNavigation { get; set; }
    }
}
