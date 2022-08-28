using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class AttendanceViewModel : GenericViewModel
    {
        public int IdSession { get; set; }
        public int IdContract { get; set; }
        // To store the employee ID temporarily, It is not stored in the database
        public int IdEmployee { get; set; }
        public double NumberDaysWorked { get; set; }
        public double NumberDaysPaidLeave { get; set; }
        public double NumberDaysNonPaidLeave { get; set; }
        public double MaxNumberOfDaysAllowed { get; set; }
        public string DeletedToken { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public double AdditionalHourOne { get; set; }
        public double AdditionalHourTwo { get; set; }
        public double AdditionalHourThree { get; set; }
        public double AdditionalHourFour { get; set; }
        public ContractViewModel IdContractNavigation { get; set; }
        public SessionViewModel IdSessionNavigation { get; set; }
    }
}
