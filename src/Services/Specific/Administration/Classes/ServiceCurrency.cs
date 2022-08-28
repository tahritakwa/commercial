using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.Administration.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="ModuleViewModel.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceCurrency : Service<CurrencyViewModel, Currency>, IServiceCurrency
    {
        private readonly IReducedCurrencyBuilder _reducedBuilder;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IRepository<Document> _entityRepoDocument;
        private readonly IRepository<ExpenseReportDetails> _entityRepoExpenseReportDetails;
        private readonly ICurrencyBuilder _currencyBuilder;

        public ServiceCurrency(IRepository<Currency> entityRepo, IUnitOfWork unitOfWork,
           ICurrencyBuilder entityBuilder,  IReducedCurrencyBuilder reducedBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceCurrencyRate serviceCurrencyRate, IRepository<Document> entityRepoDocument, IRepository<ExpenseReportDetails> entityRepoExpenseReportDetails,
            ICurrencyBuilder currencyBuilder)
            : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _reducedBuilder = reducedBuilder;
            _serviceCurrencyRate = serviceCurrencyRate;
            _entityRepoDocument = entityRepoDocument;
            _entityRepoExpenseReportDetails = entityRepoExpenseReportDetails;
            _currencyBuilder = currencyBuilder;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().OrderBy(x=>x.Code).ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        /// <summary>
        /// Gets the model with relations.
        /// The method receive a generic predicate
        /// and return the model with relations according to the predicate
        /// and the where condition included on the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>TModel.</returns>
        public override CurrencyViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            int idCurrency = (int)(long)predicateModel.Filter.Where(x => x.Prop == "Id").FirstOrDefault().Value;
            CurrencyViewModel currencyViewModel = GetModelById(idCurrency);
            var startDatePredicate = predicateModel.Filter.Where(x => x.Prop == "StartDateCurrencyRate").FirstOrDefault();
            var endDatePredicate = predicateModel.Filter.Where(x => x.Prop == "ENDDateCurrencyRate").FirstOrDefault();
            DateTime? StartDate = null ;
            DateTime? EndDate = null;
            if (startDatePredicate != null)
            {
                StartDate = DateTime.Parse((startDatePredicate.Value).ToString());
            }
            if(endDatePredicate != null)
            {
                EndDate = DateTime.Parse((endDatePredicate.Value).ToString());
            }
            List<CurrencyRateViewModel> currencyRate = (List<CurrencyRateViewModel>)_serviceCurrencyRate.GetModelsWithConditionsRelations(x => x.IdCurrency == idCurrency &&  
            (StartDate != null ? DateTime.Compare(x.StartDate.Value, (DateTime)StartDate) >= 0 : true)
            && (EndDate != null ? DateTime.Compare(x.EndDate.Value, (DateTime)EndDate) <=0 : true),x=> x.Document);
            var fromDoc = currencyRate.Where(x=> x.Document != null && x.Document.Any()).Select(x => x.Id).Distinct();
            currencyViewModel.CurrencyRateDocument = currencyRate.Where(x => fromDoc.Contains(x.Id)).OrderByDescending(x => x.StartDate).ToList();
            currencyViewModel.CurrencyRate = currencyRate.Where(x => !fromDoc.Contains(x.Id)).OrderByDescending(x => x.StartDate).ToList();
            foreach ( var curr in currencyViewModel.CurrencyRateDocument)
            {
                
                    curr.IdDocument = curr.Document.FirstOrDefault().Id;
                    curr.CodeDocument = curr.Document.FirstOrDefault().Code;
                    curr.DocumentStatus = curr.Document.FirstOrDefault().IdDocumentStatus;
                    curr.DocumentType = curr.Document.FirstOrDefault().DocumentTypeCode;
                    curr.Document = null;
            }
            return currencyViewModel;
        }

        public override object AddModelWithoutTransaction(CurrencyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckCurrencyCodeLength(model.Code);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CurrencyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckCurrencyCodeLength(model.Code);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check if currency code is equal to three or not
        /// </summary>
        /// <param name="code"></param>
        private void CheckCurrencyCodeLength(string code)
        {
            if (code.Length != NumberConstant.Three)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.CurrencyCodeNotVerfied);
            }
        }

    }
}
