using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceConstantValue
        : Service<ConstantValueViewModel, ConstantValue>, IServiceConstantValue
    {
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IServiceConstantValueValidityPeriod _serviceConstantValueValidityPeriod;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly Dictionary<string, dynamic> Params;

        public ServiceConstantValue(IServiceConstantValueValidityPeriod serviceConstantValueValidityPeriod,
            IServiceRuleUniqueReference serviceRuleUniqueReference, IRepository<ConstantValue> entityRepo,
            IRepository<ConstantValueValidityPeriod> entityConstantValueValidityPeriod,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,

            IConstantValueBuilder builder, IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            Params = new Dictionary<string, dynamic>();
            _serviceConstantValueValidityPeriod = serviceConstantValueValidityPeriod;
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _entityRepoUser = entityRepoUser;
        }

        public override object AddModelWithoutTransaction(ConstantValueViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model != null)
            {
                model.ConstantValueValidityPeriod.ToList().ForEach(x => x.Date = new DateTime(x.Date.Year, x.Date.Month, 1));
                model.Type = (int)ExpressionTypeViewModel.ExpressionType.ConstantValue;
                object a = _serviceRuleUniqueReference.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                model.IdRuleUniqueReference = ((CreatedDataViewModel)a).Id;
                base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            }
            return model;
        }

        public override object UpdateModelWithoutTransaction(ConstantValueViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var result = new Object();
            if (model != null)
            {
                model.IdRuleUniqueReference = _serviceRuleUniqueReference.GetModel(r => r.Reference == model.Reference).Id;
                foreach (ConstantValueValidityPeriodViewModel constantValueValidityPeriodViewModel in model.ConstantValueValidityPeriod)
                {
                    constantValueValidityPeriodViewModel.IdConstantValue = model.Id;
                }
                result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            }
            return result;
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            ConstantValueViewModel constantValueViewModel = GetModel(r => r.Id == id);
            constantValueViewModel.ConstantValueValidityPeriod = _serviceConstantValueValidityPeriod.FindModelBy(r => r.IdConstantValue == id).ToList();
            foreach (ConstantValueValidityPeriodViewModel constantValueValidityPeriodViewModel in constantValueViewModel.ConstantValueValidityPeriod)
            {
                _serviceConstantValueValidityPeriod.DeleteModelwithouTransaction(constantValueValidityPeriodViewModel.Id, "ConstantValueValidityPeriod", userMail);
            }
            var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
            _serviceRuleUniqueReference.DeleteModelwithouTransaction(constantValueViewModel.IdRuleUniqueReference, "RuleUniqueReference", userMail);
            return obj;
        }

        /// <summary>
        /// Calculates for a ConstantValue, the value according to the date interval which is supplied to it as a parameter.
        /// </summary>
        /// <param name="Content"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public double ReplaceConstantValue(int idForeignReference, DateTime month)
        {
            try
            {
                ConstantValueViewModel Content = GetModel(p => p.IdRuleUniqueReference == idForeignReference);
                return _serviceConstantValueValidityPeriod.FindModelBy(period => period.IdConstantValue == Content.Id &&
                    period.Date <= new DateTime(month.Year, month.Month, 01)).OrderBy(x => x.Date).Last().Value;
            }
            catch (Exception)
            {
                Params[PayRollConstant.PayslipErrorMessage] = PayRollConstant.MissConstantValueErrorMessage;
                throw new CustomException(CustomStatusCode.CONSTANT_VALUE_LACK, Params);
            }
        }
    }
}
