using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ConstantRateValidityPeriodViewModel : GenericViewModel
    {
        public DateTime Date { get; set; }
        public double? SalaryRate { get; set; }
        public double? EmployerRate { get; set; }
        public int IdConstantRate { get; set; }
        public string DeletedToken { get; set; }

        public ConstantRateViewModel IdConstantRateNavigation { get; set; }
    }
}
