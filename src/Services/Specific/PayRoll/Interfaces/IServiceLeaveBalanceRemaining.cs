using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceLeaveBalanceRemaining : IService<LeaveBalanceRemainingViewModel, LeaveBalanceRemaining>
    {
        void CalculateAllLeaveBalance(string connectionString = null, LeaveBalanceRemainingFilter leaveBalanceRemainingFilter = null, int leavePeriod = 0);
        DataSourceResult<LeaveBalanceRemainingViewModel> GetLeaveBalanceRemainingList(PredicateFormatViewModel predicateModel, string userMail);
        IList<LeaveBalanceRemainingViewModel> GetDataLeaveBalanceRemainingByIdEmployee(int idEmployee);
        DataSourceResult<LeaveBalanceRemainingLine> GetLeaveBalanceRemaining(LeaveBalanceRemainingFilter leaveBalanceRemainingFilter);
    }
}
