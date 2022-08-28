using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SessionViewModel : GenericViewModel
    {
        public string Title { get; set; }
        public DateTime Month { get; set; }
        public int State { get; set; }
        public DateTime CreationDate { get; set; }
        public string DeletedToken { get; set; }
        public bool DependOnTimesheet { get; set; }
        public double DaysOfWork { get; set; }
        public string Code { get; set; }
        public IList<DayOfWeek> DaysOfWeekWorked { get; set; }

        public ICollection<AttendanceViewModel> Attendance { get; set; }
        public ICollection<PayslipViewModel> Payslip { get; set; }
        public ICollection<SessionBonusViewModel> SessionBonus { get; set; }
        public ICollection<SessionContractViewModel> SessionContract { get; set; }
        public ICollection<CnssDeclarationSessionViewModel> CnssDeclarationSession { get; set; }
        public ICollection<SessionLoanInstallmentViewModel> SessionLoanInstallment { get; set; }
        public ICollection<TransferOrderSessionViewModel> TransferOrderSession { get; set; }
    }
}
