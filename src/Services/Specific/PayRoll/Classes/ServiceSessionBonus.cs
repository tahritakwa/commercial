using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSessionBonus : Service<SessionBonusViewModel, SessionBonus>, IServiceSessionBonus
    {
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<Payslip> _entityRepoPayslip;
        public ServiceSessionBonus(IRepository<SessionBonus> entityRepo,
            IUnitOfWork unitOfWork,
            ISessionBonusBuilder builder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Payslip> entityRepoPayslip)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
            _entityRepoPayslip = entityRepoPayslip;
        }

        public override object UpdateModelWithoutTransaction(SessionBonusViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            double oldBonusValue = GetModelAsNoTracked(x => x.Id == model.Id).Value;
            if(model.Value == NumberConstant.Zero)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.BonusValueEqualToZero);
            }
            if(oldBonusValue != model.Value)
            {
                Payslip payslip = _entityRepoPayslip.FindSingleBy(x => x.IdSession.Equals(model.IdSession) && x.IdContract == model.IdContract);
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
