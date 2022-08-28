using Persistence.Entities;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class LeaveBalanceRemainingBuilder : GenericBuilder<LeaveBalanceRemainingViewModel, LeaveBalanceRemaining>, ILeaveBalanceRemainingBuilder
    {
        public override LeaveBalanceRemainingViewModel BuildEntity(LeaveBalanceRemaining entity)
        {
            LeaveBalanceRemainingViewModel leaveBalanceRemainingViewModel = base.BuildEntity(entity);
            leaveBalanceRemainingViewModel.CumulativeTaken = new DayHour(entity.CumulativeTakenDay, entity.CumulativeTakenHour);
            leaveBalanceRemainingViewModel.RemainingBalance = new DayHour(entity.RemainingBalanceDay, entity.RemainingBalanceHour);
            leaveBalanceRemainingViewModel.CumulativeAcquired = new DayHour(entity.CumulativeAcquiredDay, entity.CumulativeAcquiredHour);
            return leaveBalanceRemainingViewModel;
        }

        public override LeaveBalanceRemaining BuildModel(LeaveBalanceRemainingViewModel model)
        {
            LeaveBalanceRemaining leaveBalanceRemaining = base.BuildModel(model);
            if (model.CumulativeTaken != null)
            {
                leaveBalanceRemaining.CumulativeTakenDay = model.CumulativeTaken.Day;
                leaveBalanceRemaining.CumulativeTakenHour = model.CumulativeTaken.Hour;
            }
            if (model.RemainingBalance != null)
            {
                leaveBalanceRemaining.RemainingBalanceDay = model.RemainingBalance.Day;
                leaveBalanceRemaining.RemainingBalanceHour = model.RemainingBalance.Hour;
            }
            if (model.CumulativeAcquired != null)
            {
                leaveBalanceRemaining.CumulativeAcquiredDay = model.CumulativeAcquired.Day;
                leaveBalanceRemaining.CumulativeAcquiredHour = model.CumulativeAcquired.Hour;
            }
            return leaveBalanceRemaining;
        }

    }
}
