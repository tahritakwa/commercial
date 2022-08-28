using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceAttendance : Service<AttendanceViewModel, Attendance>, IServiceAttendance
    {       
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<Payslip> _entityRepoPayslip;

        public ServiceAttendance(IRepository<Attendance> entityRepo, IRepository<Payslip> entityRepoPayslip,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IAttendanceBuilder builder,
        IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser, IEntityAxisValuesBuilder builderEntityAxisValues )
        : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {           
            _entityRepoUser = entityRepoUser;
            _entityRepoPayslip = entityRepoPayslip;
        }

        /// <summary>
        /// Avoid the update of an invalid attendance
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(AttendanceViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.MaxNumberOfDaysAllowed < (model.NumberDaysWorked + model.NumberDaysPaidLeave + model.NumberDaysNonPaidLeave))
            {
                throw new CustomException(CustomStatusCode.AttendanceMaxDaysAllowed);
            }
            Attendance oldAttendace = _entityRepo.FindByAsNoTracking(attendance => attendance.Id == model.Id).FirstOrDefault();
            if (!oldAttendace.NumberDaysNonPaidLeave.IsApproximately(model.NumberDaysNonPaidLeave) ||
                !oldAttendace.NumberDaysPaidLeave.IsApproximately(model.NumberDaysPaidLeave) ||
                !oldAttendace.NumberDaysWorked.IsApproximately(model.NumberDaysWorked))
            {
                Payslip payslip = _entityRepoPayslip.FindByAsNoTracking(x => x.IdSession.Equals(model.IdSession) && x.IdContract == model.IdContract).FirstOrDefault();
                if (payslip != null)
                {
                    payslip.Status = (int)PayslipStatus.Wrong;
                    _entityRepoPayslip.Update(payslip);
                }
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
