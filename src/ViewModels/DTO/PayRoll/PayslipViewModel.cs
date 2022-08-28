using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class PayslipViewModel : GenericViewModel
    {
        public string PayslipNumber { get; set; }
        public DateTime Month { get; set; }
        public int IdContract { get; set; }
        public int IdEmployee { get; set; }
        public string DeletedToken { get; set; }
        public int IdSession { get; set; }
        public int Status { get; set; }
        public string ErrorMessage { get; set; }
        // Attributes to temporarily contain attendance data
        public double NumberDaysWorked { get; set; }
        public double NumberDaysPaidLeave { get; set; }
        public double AdditionalHourOne { get; set; }
        public double AdditionalHourTwo { get; set; }
        public double AdditionalHourThree { get; set; }
        public double AdditionalHourFour { get; set; }
        public bool CoversWholeMonth { get; set; }
        public int? IdTransferOrder { get; set; }

        public ContractViewModel IdContractNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public SessionViewModel IdSessionNavigation { get; set; }
        public TransferOrderViewModel IdTransferOrderNavigation { get; set; }
        public ICollection<PayslipDetailsViewModel> PayslipDetails { get; set; }
    }
}
