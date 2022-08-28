using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceLeaveType : Service<LeaveTypeViewModel, LeaveType>, IServiceLeaveType
    {
        private readonly IReducedLeaveTypeBuilder _reducedBuilder;

        public ServiceLeaveType(IRepository<LeaveType> entityRepo, 
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
            ILeaveTypeBuilder builder, IRepository<Entity> entityRepoEntity, IReducedLeaveTypeBuilder reducedBuilder,
            IRepository<User> entityRepoUser, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _reducedBuilder = reducedBuilder;
            _entityRepoEntity = entityRepoEntity;
            _entityRepoEntityCodification = entityRepoEntityCodification;
            _entityRepoCodification = entityRepoCodification;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        public override object AddModelWithoutTransaction(LeaveTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckMaximumNumberOfDays(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(LeaveTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckMaximumNumberOfDays(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check if the maximum number of days is exceeded or not
        /// </summary>
        /// <param name="leaveType"></param>
        private void CheckMaximumNumberOfDays(LeaveTypeViewModel leaveType)
        {
            if ((leaveType.Period == NumberConstant.One && leaveType.MaximumNumberOfDays > NumberConstant.ThirtyOne)
                || (leaveType.Period == NumberConstant.Two && leaveType.MaximumNumberOfDays > NumberConstant.ThreeHundredSixtyFive))
            {
                throw new CustomException(CustomStatusCode.LeaveTypeMaximumNumberOfDaysLimitException);
            }
        }
    }
}
