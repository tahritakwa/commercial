using Persistence.Entities;
using System;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class LeaveBuilder : GenericBuilder<LeaveViewModel, Leave>, ILeaveBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly ILeaveTypeBuilder _leaveTypeBuilder;

        public LeaveBuilder(ILeaveTypeBuilder leaveTypeBuilder, IEmployeeBuilder employeeBuilder)
        {
            _leaveTypeBuilder = leaveTypeBuilder;
            _employeeBuilder =  employeeBuilder;
        }

        public override LeaveViewModel BuildEntity(Leave entity)
        {
            LeaveViewModel leaveViewModel = base.BuildEntity(entity);
            leaveViewModel.NumberDaysLeave = new DayHour(entity.DaysNumber, entity.HoursNumber);
            if (leaveViewModel != null)
            {
                if (leaveViewModel.IdLeaveTypeNavigation != null)
                {
                    leaveViewModel.IdLeaveTypeNavigation = _leaveTypeBuilder.BuildEntity(entity.IdLeaveTypeNavigation);
                }
                if (leaveViewModel.TreatedByNavigation != null && leaveViewModel.TreatedBy != null)
                {
                    leaveViewModel.TreatedByNavigation = _employeeBuilder.BuildEntity(entity.TreatedByNavigation);
                }
            }
            return leaveViewModel;
        }

        public override Leave BuildModel(LeaveViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            Leave entity = base.BuildModel(model);
            entity.DaysNumber = model.NumberDaysLeave.Day;
            entity.HoursNumber = model.NumberDaysLeave.Hour;
            if (model.IdEmployeeNavigation != null)
            {
                entity.IdEmployeeNavigation = null;
            }
            if (model.IdLeaveTypeNavigation != null)
            {
                entity.IdLeaveTypeNavigation = null;
            }
            return entity;
        }
    }
}
