using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class UserBuilder : GenericBuilder<UserViewModel, User>, IUserBuilder
    {

        private readonly IUserPrivilegeBuilder _userPrivilegeBuilder;
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly ITimeSheetBuilder _timesheetBuilder;
        private readonly ILeaveBuilder _leaveBuilder;
        public UserBuilder(IUserPrivilegeBuilder userPrivilegeBuilder, IEmployeeBuilder employeeBuilder
            , ITimeSheetBuilder timesheetBuilder, ILeaveBuilder leaveBuilder)
        {
            _userPrivilegeBuilder = userPrivilegeBuilder;
            _employeeBuilder = employeeBuilder;
            _timesheetBuilder = timesheetBuilder;
            _leaveBuilder = leaveBuilder;
        }

        public override UserViewModel BuildEntity(User entity)
        {
            UserViewModel model = base.BuildEntity(entity);
            if (model != null)
            {
                model.Language = model.Lang;
            }
            if (entity.FirstName != null && entity.LastName != null)
            {
                model.FullName = entity.FirstName + " " + entity.LastName;
            }
            if (model != null && model.UserPrivilege != null)
            {
                model.UserPrivilege = entity.UserPrivilege.Select(x => _userPrivilegeBuilder.BuildEntity(x)).ToList();
            }
            if (entity != null && entity.IdEmployeeNavigation != null && entity.IdEmployeeNavigation.TimeSheetIdEmployeeNavigation != null)
            {
                model.IdEmployeeNavigation.TimeSheetIdEmployeeNavigation = entity.IdEmployeeNavigation.TimeSheetIdEmployeeNavigation.Select(x => _timesheetBuilder.BuildEntity(x)).ToList();

            }
            if (entity != null && entity.IdEmployeeNavigation != null && entity.IdEmployeeNavigation.LeaveIdEmployeeNavigation != null)
            {
                model.IdEmployeeNavigation.LeaveIdEmployeeNavigation = entity.IdEmployeeNavigation.LeaveIdEmployeeNavigation.Select(x => _leaveBuilder.BuildEntity(x)).ToList();

            }
           
            if(model != null  && (model.FirstName != null || model.LastName != null))
            {
                model.UserName = (model.FirstName != null ? model.FirstName : string.Empty) + " " + (model.LastName != null ? model.LastName : string.Empty);
            }
            return model;
        }

        public override User BuildModel(UserViewModel model)
        {
            
            User entity = base.BuildModel(model);
            entity.IsActif = model.IsActif == null ? true : model.IsActif;
            if (entity.IdEmployeeNavigation != null)
            {
                model.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdEmployeeNavigation);
            }


            return entity;
        }
    }
}
