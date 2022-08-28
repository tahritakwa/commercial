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
    public class ServiceConstantRate : Service<ConstantRateViewModel, ConstantRate>, IServiceConstantRate
    {
        private readonly IConstantRateValidityPeriodBuilder _constantRateValidityPeriodBuilder;
        private readonly IServiceConstantRateValidityPeriod _serviceConstantRateValidityPeriod;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly Dictionary<string, dynamic> Params;

        private const string SalaryRateValue = "Salary";
        private const string EmployerRateValue = "Employer";

        public ServiceConstantRate(IServiceConstantRateValidityPeriod serviceConstantRateValidityPeriod, IServiceRuleUniqueReference serviceRuleUniqueReference,
            IRepository<ConstantRate> entityRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork,
 IConstantRateBuilder builder, IConstantRateValidityPeriodBuilder constantRateValidityPeriodBuilder, IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            Params = new Dictionary<string, dynamic>();
            _serviceConstantRateValidityPeriod = serviceConstantRateValidityPeriod;
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _constantRateValidityPeriodBuilder = constantRateValidityPeriodBuilder;
        }

        public override object AddModelWithoutTransaction(ConstantRateViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model != null)
            {
                model.ConstantRateValidityPeriod.ToList().ForEach(x => x.Date = new DateTime(x.Date.Year, x.Date.Month, 1));
                foreach (ConstantRateValidityPeriodViewModel constantRateValidityPeriodViewModel in model.ConstantRateValidityPeriod.ToList())
                {
                    _constantRateValidityPeriodBuilder.BuildModel(constantRateValidityPeriodViewModel);
                }
                model.Type = (int)ExpressionTypeViewModel.ExpressionType.ConstantRate;
                object a = _serviceRuleUniqueReference.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                model.IdRuleUniqueReference = ((CreatedDataViewModel)a).Id;
                base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            }
            return model;
        }

        public override object UpdateModelWithoutTransaction(ConstantRateViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var result = new Object();
            if (model != null)
            {
                model.IdRuleUniqueReference = _serviceRuleUniqueReference.GetModel(r => r.Reference == model.Reference).Id;
                foreach (ConstantRateValidityPeriodViewModel constantRateValidityPeriodViewModel in model.ConstantRateValidityPeriod)
                {
                    constantRateValidityPeriodViewModel.IdConstantRate = model.Id;
                }
                result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            }
            return result;
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            ConstantRateViewModel constantRateViewModel = GetModel(r => r.Id == id);
            constantRateViewModel.ConstantRateValidityPeriod = _serviceConstantRateValidityPeriod.FindModelBy(r => r.IdConstantRate == id).ToList();
            foreach (ConstantRateValidityPeriodViewModel constantRateValidityPeriodViewModel in constantRateViewModel.ConstantRateValidityPeriod)
            {
                _serviceConstantRateValidityPeriod.DeleteModelwithouTransaction(constantRateValidityPeriodViewModel.Id, "ConstantRateValidityPeriod", userMail);
            }
            var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
            _serviceRuleUniqueReference.DeleteModelwithouTransaction(constantRateViewModel.IdRuleUniqueReference, "RuleUniqueReference", userMail);
            return obj;
        }


        /// <summary>
        /// Calculates for a ConstantRate, the SalaryRate value and EmployerRate value according to the date interval which is supplied to it as a parameter.
        /// </summary>
        /// <param name="Content"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public Dictionary<string, double> ReplaceConstantRate(int IdForeignReference, DateTime month)
        {
            try
            {
                //Retrieves the constant that IdRuleUniqueReference has the identifier of the Reference sent as a parameter
                ConstantRateViewModel Content = GetModel(p => p.IdRuleUniqueReference == IdForeignReference);
                Dictionary<string, double> Rates = new Dictionary<string, double>
                {
                    [SalaryRateValue] = 0.0,
                    [EmployerRateValue] = 0.0
                };
                ConstantRateValidityPeriodViewModel constantRateValidityPeriod = _serviceConstantRateValidityPeriod.FindModelBy(period => period.IdConstantRate == Content.Id &&
                    period.Date <= new DateTime(month.Year, month.Month, 01)).OrderBy(x => x.Date).Last();
                Rates[SalaryRateValue] = constantRateValidityPeriod.SalaryRate ?? 0;
                Rates[EmployerRateValue] = constantRateValidityPeriod.EmployerRate ?? 0;
                return Rates;
            }
            catch (Exception)
            {
                Params[PayRollConstant.PayslipErrorMessage] = PayRollConstant.MissConstantRateErrorMessage;
                throw new CustomException(CustomStatusCode.CONSTANT_RATE_LACK, Params);
            }
        }
    }
}
