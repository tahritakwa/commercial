using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceCnss : Service<CnssViewModel, Cnss>, IServiceCnss
    {
        internal readonly IRepository<User> _entityRepoUser;
        public readonly IReducedCnssBuilder _reducedBuilder;


        public ServiceCnss(IRepository<Cnss> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
 ICnssBuilder builder,
            IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser, IReducedCnssBuilder reducedBuilder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
            _reducedBuilder = reducedBuilder;
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

        public override object AddModelWithoutTransaction(CnssViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckCnssConditions(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CnssViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckCnssConditions(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        private void CheckCnssConditions(CnssViewModel cnss)
        {
            if (!RateComparator(cnss.EmployerRate))
            {
                throw new CustomException(CustomStatusCode.IncorrectEmployerRate);
            }
            if (!RateComparator(cnss.SalaryRate))
            {
                throw new CustomException(CustomStatusCode.IncorrectSalaryRate);
            }
            if (!RateComparator(cnss.WorkAccidentQuota))
            {
                throw new CustomException(CustomStatusCode.IncorrectWorkAccidentQuota);
            }
            if (cnss.OperatingCode.Length != NumberConstant.Four)
            {
                throw new CustomException(CustomStatusCode.CNSS_EXPLOITATION_CODE_INCORRECT, new Dictionary<string, dynamic>
                {
                    { PayRollConstant.Length, Convert.ToString(NumberConstant.Four) }
                });
            }
            else if (FindModelBy(x => x.OperatingCode == cnss.OperatingCode && x.Id != cnss.Id).Count > NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.ExistingOperatingCode);
            }
            if (cnss.SalaryRate + cnss.EmployerRate > NumberConstant.Hundred)
            {
                throw new CustomException(CustomStatusCode.EmployerSalaryRateExceedsLimit);
            }
        }

        private bool RateComparator(double rate)
        {
            return rate <= NumberConstant.Hundred && rate >= NumberConstant.Zero;
        }
    }
}
