using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ConstantValueValidityPeriodViewModel : GenericViewModel
    {
        public DateTime Date { get; set; }
        public double Value { get; set; }
        public int IdConstantValue { get; set; }
        public string DeletedToken { get; set; }

        public ConstantValueViewModel IdConstantValueNavigation { get; set; }
    }
}
