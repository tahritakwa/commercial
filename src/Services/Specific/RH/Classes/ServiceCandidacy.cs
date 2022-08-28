using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Net.Http;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceCandidacy : Service<CandidacyViewModel, Candidacy>, IServiceCandidacy
    {
        private readonly IRepository<Interview> _entityRepoInterview;
        private readonly IServiceRecruitment _serviceRecruitment;
        private readonly IServiceOffer _serviceOffer;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceCandidate _serviceCandidate;
        private readonly IServiceQualification _serviceQualification;
        private readonly IReducedCandidacyBuilder _reducedBuilder;
        private readonly IServiceContract _serviceContract;
        private readonly IRepository<Job> _jobRepo;
        private readonly IServiceEmail _serviceEmail;
        private readonly IRepository<User> _userRepo;
        private readonly IServiceProvider _serviceProvider;
        private readonly SmtpSettings _smtpSettings;

        public ServiceCandidacy(IRepository<Candidacy> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IUnitOfWork unitOfWork,
          ICandidacyBuilder builder,
          IReducedCandidacyBuilder reducedBuilder,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IServiceContract serviceContract, IRepository<Interview> entityRepoInterview,
          IServiceRecruitment serviceRecruitment, IServiceQualification serviceQualification,
          IServiceOffer serviceOffer, IServiceEmployee serviceEmployee, IServiceCandidate serviceCandidate, IRepository<Job> jobRepo,
          IServiceEmail serviceEmail,
          IRepository<User> userRepo, IServiceProvider serviceProvider, IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
          ICompanyBuilder companyBuilder, IMemoryCache memoryCache, IOptions<SmtpSettings> smtpSettings)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _entityRepoInterview = entityRepoInterview;
            _serviceRecruitment = serviceRecruitment;
            _serviceOffer = serviceOffer;
            _serviceEmployee = serviceEmployee;
            _serviceCandidate = serviceCandidate;
            _reducedBuilder = reducedBuilder;
            _serviceQualification = serviceQualification;
            _serviceContract = serviceContract;
            _jobRepo = jobRepo;
            _serviceEmail = serviceEmail;
            _userRepo = userRepo;
            _serviceProvider = serviceProvider;
            _smtpSettings = smtpSettings.Value;

        }
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel)
        {
            IEnumerable<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }

            IList<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }




        /// <summary>
        ///  Set the candidacy state to Interview and set the recruitment state to Interview
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void PreSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                BeginTransaction();
                //Throw exception if the recruitment is closed
                if (model.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                if (model.State == (int)RecruitmentStateEnumerator.PreSelection)
                {
                    // Update the candidacy state to interview
                    model.State = (int)RecruitmentStateEnumerator.Interview;
                    // Update the recruitment state to Interview if its state is equals Preselection
                    RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) =>
                                            result.Id == model.IdRecruitment);
                    if (recruitment.State == (int)RecruitmentStateEnumerator.PreSelection)
                    {
                        recruitment.State = (int)RecruitmentStateEnumerator.Interview;
                        _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, entityAxisValuesModelList, userMail, property);
                    }
                    UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                }
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }

        /// <summary>
        /// Set the candidacy state to Preselection and set the recruitment state to Preselection 
        /// if its all candidacy state are less than Interview
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void UnPreSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                BeginTransaction();
                //Throw exception if the recruitment is closed
                if (model.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                // Unpreselectionned if the candidacy state not excedeed interview state
                if (model.State == (int)RecruitmentStateEnumerator.Interview)
                {
                    IList<Interview> interviews = _entityRepoInterview.GetAllWithConditions(
                                                                result => result.IdCandidacy.Equals(model.Id)
                                                            ).ToList();
                    // If the candidacy not have a planified interview update the candidacy else throw CustomException
                    if (!interviews.Any())
                    {
                        // Update the candidacy state to Preselection
                        model.State = (int)RecruitmentStateEnumerator.PreSelection;
                        // Update the recruitment state to Preselection if it doesn't have a candidacy which state is greater or equals Interview state
                        IList<CandidacyViewModel> candidacyViewModels = FindModelsByNoTracked(
                                                    result => !result.Id.Equals(model.Id)
                                                    && result.IdRecruitment.Equals(model.IdRecruitment)
                                                    && result.State >= (int)RecruitmentStateEnumerator.Interview
                                                ).ToList();
                        if (!candidacyViewModels.Any())
                        {
                            RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) =>
                                                result.Id == model.IdRecruitment);
                            recruitment.State = (int)RecruitmentStateEnumerator.PreSelection;
                            _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, entityAxisValuesModelList, userMail, property);
                        }
                        UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                    }
                    else
                    {
                        throw new CustomException(CustomStatusCode.CandidacyUnPreselectedViolation);
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.CandidacyUnPreselectedViolation);
                }
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }

        }

        /// <summary>
        /// This method is call in preselection step when we want to go to interview step
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<CandidacyViewModel> FromPreselectionToNextStep(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // get the candidacy wich are preselected
            DataSourceResult<CandidacyViewModel> candidacyViewModels = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            return candidacyViewModels;
        }

        public override object AddModelWithoutTransaction(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {

            IList<CandidacyViewModel> candidacyViewModels = FindModelsByNoTracked(result => result.IdRecruitment.Equals(model.IdRecruitment)
                || result.Offer.Any(x => x.State == (int)OfferStateEnumerator.Accepted && x.IdCandidacyNavigation.IdCandidate == model.IdCandidate), x => x.Offer);
            if (candidacyViewModels.Any(result => result.IdRecruitment.Equals(model.IdRecruitment) && result.IdCandidate.Equals(model.IdCandidate)))
            {
                throw new CustomException(CustomStatusCode.CandidacyAddExistingCandidate);
            }
            else if (candidacyViewModels.Any(x => x.IdCandidate == model.IdCandidate && x.Offer.Any(y => y.State == (int)OfferStateEnumerator.Accepted)))
            {
                throw new CustomException(CustomStatusCode.CannotAddCandidateWithAcceptedOfferToNewCandidacy);
            }
            model.State = (int)RecruitmentStateEnumerator.Interview;
            RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) => result.Id == model.IdRecruitment);

            if (recruitment.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            if (recruitment.State < (int)RecruitmentStateEnumerator.Interview)
            {
                recruitment.State = (int)RecruitmentStateEnumerator.Interview;
                _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, entityAxisValuesModelList, userMail, property);
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.Interview != null &&
                model.State < (int)RecruitmentStateEnumerator.Evaluation && model.Interview.Any())
            {
                throw new CustomException(CustomStatusCode.UpdateCandidacyWithInterviews);
            }
            IList<OfferViewModel> offerViewModels = _serviceOffer.FindModelBy(result => result.IdCandidacy.Equals(model.Id)).ToList();
            if (offerViewModels.Any())
            {
                throw new CustomException(CustomStatusCode.UpdateCandidacyWithSendedOffers);
            }
            CandidacyViewModel candidacy = GetModelAsNoTracked(x => x.Id == model.Id, x => x.IdRecruitmentNavigation, x => x.Offer);
            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            IList<CandidacyViewModel> candidacyViewModels = FindModelBy(result => result.IdRecruitment.Equals(model.IdRecruitment) &&
            result.Id != model.Id && result.IdCandidate == model.IdCandidate).ToList();

            if (candidacyViewModels.Any())
            {
                throw new CustomException(CustomStatusCode.CandidacyAddExistingCandidate);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            CandidacyViewModel candidacy = GetModelAsNoTracked(x => x.Id == id, x => x.IdRecruitmentNavigation);
            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            int idRecruitment = (int)GetModelAsNoTracked(result => result.Id.Equals(id)).IdRecruitment;
            var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
            IList<CandidacyViewModel> candidacyViewModels = FindModelBy(result => result.IdRecruitment.Equals(idRecruitment)).ToList();
            if (!candidacyViewModels.Any())
            {
                RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) => result.Id == idRecruitment);
                recruitment.State = (int)RecruitmentStateEnumerator.Candidacy;
                _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, null, userMail, null);
            }
            return obj;
        }

        public DataSourceResult<CandidacyViewModel> FromCandidacyToNextStep(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // get the candidacy wich are preselected
            DataSourceResult<CandidacyViewModel> candidacyViewModels = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            if (candidacyViewModels.total == 0)
            {
                throw new CustomException(CustomStatusCode.CandidacyEmptyList);
            }
            return candidacyViewModels;
        }

        /// <summary>
        /// Set the candidacy state to Offer and set the recruitment state to Offer
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void SelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                BeginTransaction();
                //Throw exception if the recruitment is closed
                if (model.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                if (model.State == (int)RecruitmentStateEnumerator.Selection)
                {
                    // Update the candidacy state to Offer
                    model.State = (int)RecruitmentStateEnumerator.Offer;
                    // Update the recruitment state to Offer if its state is equals Selection
                    if (model.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Selection)
                    {
                        RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) =>
                                               result.Id == model.IdRecruitment);
                        recruitment.State = (int)RecruitmentStateEnumerator.Offer;
                        _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, entityAxisValuesModelList, userMail, property);
                    }
                    UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                }
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Set the candidacy state to Selection and set the recruitment state to Selection 
        /// if its all candidacy state are less than Offer
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void UnSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                BeginTransaction();
                //Throw exception if the recruitment is closed
                if (model.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                //Preselectionned if the candidacy state not excedeed Offer state
                if (model.State == (int)RecruitmentStateEnumerator.Offer)
                {
                    IList<OfferViewModel> offerViewModels = _serviceOffer.FindModelBy(
                                                                result => result.IdCandidacy.Equals(model.Id)
                                                            ).ToList();
                    // If the candidacy not have a offer update the candidacy else throw CustomException
                    if (!offerViewModels.Any())
                    {
                        // Update the candidacy state to Selection
                        model.State = (int)RecruitmentStateEnumerator.Selection;
                        // Update the recruitment state to Selection if it doesn't have a candidacy which state is greater or equals Offer state
                        IList<CandidacyViewModel> candidacyViewModels = FindModelsByNoTracked(
                                                    result => !result.Id.Equals(model.Id)
                                                    && result.IdRecruitment.Equals(model.IdRecruitment)
                                                    && result.State >= (int)RecruitmentStateEnumerator.Offer
                                                ).ToList();
                        if (!candidacyViewModels.Any())
                        {
                            RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) =>
                                                result.Id == model.IdRecruitment);
                            recruitment.State = (int)RecruitmentStateEnumerator.Selection;
                            _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, entityAxisValuesModelList, userMail, property);
                        }
                        UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                    }
                    else
                    {
                        throw new CustomException(CustomStatusCode.CandidacyUnselectedViolation);
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.CandidacyUnselectedViolation);
                }
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw;
            }
        }

        public DataSourceResult<CandidacyViewModel> FromSelectionToNextStep(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // get the candidacy wich are preselected
            DataSourceResult<CandidacyViewModel> candidacyViewModels = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            return candidacyViewModels;
        }
        /// <summary>
        /// Generate Employee From Candidacy
        /// </summary>
        /// <param name="model"></param>
        public int GenerateEmployeeFromCandidacy(CandidacyViewModel candidacy)
        {
            if (candidacy == null)
            {
                throw new ArgumentException("");
            }
            RecruitmentViewModel recruitmentViewModel = _serviceRecruitment.GetModelAsNoTracked(r => r.Id == candidacy.IdRecruitment);
            if (recruitmentViewModel.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            try
            {
                BeginTransaction();
                if (recruitmentViewModel.ExpectedCandidateNumber.HasValue &&
                    recruitmentViewModel.RecruitedCandidateNumber >= recruitmentViewModel.ExpectedCandidateNumber.Value)
                {
                    throw new CustomException(CustomStatusCode.NumberOfCandidateExceeded);
                }
                recruitmentViewModel.RecruitedCandidateNumber += NumberConstant.One;
                OfferViewModel offer = _serviceOffer.GetModelWithRelationsAsNoTracked(o => o.IdCandidacy == candidacy.Id &&
                o.State == (int)OfferStateEnumerator.Accepted,
                o => o.OfferBenefitInKind,
                o => o.Advantages,
                o => o.OfferBonus,
                o => o.IdCandidacyNavigation.IdRecruitmentNavigation);
                EmployeeViewModel newEmployee = GenerateEmployeeFromCandidate(_serviceCandidate.GetModelAsNoTracked(c => c.Id == candidacy.IdCandidate));
                newEmployee.HiringDate = offer.StartDate;
                newEmployee.JobEmployee = new List<JobEmployeeViewModel> { new JobEmployeeViewModel { IdJob = offer.IdCandidacyNavigation.IdRecruitmentNavigation.IdJob } };
                newEmployee.Contract = new List<ContractViewModel>
                {
                    _serviceContract.GenerateContractFromOffer(offer)
                };
                int generatedEmployeeId = ((CreatedDataViewModel)_serviceEmployee.AddModelWithoutTransaction(newEmployee, null, null, null)).Id;
                candidacy.IdCandidateNavigation.IdEmployee = generatedEmployeeId;
                candidacy.IdCandidateNavigation.Candidacy.ElementAt(0).State = (int)RecruitmentStateEnumerator.Closed;
                _serviceCandidate.UpdateModelWithoutTransaction(candidacy.IdCandidateNavigation, null, null);
                if (candidacy.IdCandidateNavigation != null)
                {
                    List<QualificationViewModel> qualificationList = _serviceQualification.FindByAsNoTracking(x => x.IdCandidate == candidacy.IdCandidate).ToList();

                    foreach (QualificationViewModel qualificationViewModel in qualificationList)
                    {
                        qualificationViewModel.IdEmployee = generatedEmployeeId;
                        _serviceQualification.UpdateModelWithoutTransaction(qualificationViewModel, null, null);
                    }
                }
                _serviceRecruitment.UpdateModelWithoutTransaction(recruitmentViewModel, null, null);
                EndTransaction();
                return generatedEmployeeId;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Generate Employee From Candidate
        /// </summary>
        /// <param name="candidate"></param>
        /// <returns></returns>
        private EmployeeViewModel GenerateEmployeeFromCandidate(CandidateViewModel candidate)
        {
            if (candidate == null)
            {
                throw new ArgumentException("");
            }
            return new EmployeeViewModel(candidate);
        }

        /// <summary>
        /// FromOfferToNextStep
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<CandidacyViewModel> FromOfferToNextStep(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // get the candidacy wich offer state greater than offer
            DataSourceResult<CandidacyViewModel> candidacyViewModels = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            return candidacyViewModels;
        }


        /// <summary>
        /// GetCandidacyListInOfferStepWithSpecificPredicat
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<CandidacyViewModel> GetCandidacyListInOfferStepWithSpecificPredicat(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            DataSourceResult<CandidacyViewModel> listCandidacy = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            // Order the list considering the number of offer
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.NUMBER_OF_OFFER) && v.Direction.Equals(OrderByDirection.ASC)))
            {
                listCandidacy.data = listCandidacy.data.OrderBy(x => x.NumberOfOffer).ToList();
            }
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.NUMBER_OF_OFFER) && v.Direction.Equals(OrderByDirection.DESC)))
            {
                listCandidacy.data = listCandidacy.data.OrderByDescending(x => x.NumberOfOffer).ToList();
            }
            // Add predicate filter considering the number of offer
            if (predicateModel.Filter.Any(x => x.Prop.Equals(RHConstant.NUMBER_OF_OFFER)))
            {
                //Add Predicate
                PredicateFormatViewModel predicateEntity = new PredicateFormatViewModel();
                //Add filter with property EntityName
                predicateEntity.Filter = new List<FilterViewModel>();
                var listFilters = predicateModel.Filter.Where(x => x.Prop.Equals(RHConstant.NUMBER_OF_OFFER));
                listFilters.ToList().ForEach(p => predicateEntity.Filter.Add(p));
                Expression<Func<CandidacyViewModel, bool>> predicateEntityWhere = PredicateUtility<CandidacyViewModel>.PredicateFilter(predicateEntity, Operator.And);
                listCandidacy.data = listCandidacy.data.Where(predicateEntityWhere.Compile()).ToList();
            }
            return listCandidacy;
        }
        public DataSourceResult<CandidacyViewModel> GetCandidacyListInDoneStepWithSpecificPredicat(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            DataSourceResult<CandidacyViewModel> listCandidacy = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            // Order the list considering the number of offer
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.NUMBER_OF_OFFER) && v.Direction.Equals(OrderByDirection.ASC)))
            {
                listCandidacy.data = listCandidacy.data.OrderBy(x => x.NumberOfOffer).ToList();
            }
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.NUMBER_OF_OFFER) && v.Direction.Equals(OrderByDirection.DESC)))
            {
                listCandidacy.data = listCandidacy.data.OrderByDescending(x => x.NumberOfOffer).ToList();
            }
            // Add predicate filter considering the number of offer
            if (predicateModel.Filter.Any(x => x.Prop.Equals(RHConstant.NUMBER_OF_OFFER)))
            {
                //Add Predicate
                PredicateFormatViewModel predicateEntity = new PredicateFormatViewModel();
                //Add filter with property EntityName
                predicateEntity.Filter = new List<FilterViewModel>();
                var listFilters = predicateModel.Filter.Where(x => x.Prop.Equals(RHConstant.NUMBER_OF_OFFER));
                listFilters.ToList().ForEach(p => predicateEntity.Filter.Add(p));
                Expression<Func<CandidacyViewModel, bool>> predicateEntityWhere = PredicateUtility<CandidacyViewModel>.PredicateFilter(predicateEntity, Operator.And);
                listCandidacy.data = listCandidacy.data.Where(predicateEntityWhere.Compile()).ToList();
            }
            listCandidacy.total = listCandidacy.data.Count;
            return listCandidacy;
        }
        /// <summary>
        /// GetCandidacyListInSelectionStepWithSpecificPredicat
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<CandidacyViewModel> GetCandidacyListInSelectionStepWithSpecificPredicat(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Candidacy> predicateFilterRelationModel = PreparePredicate(predicateModel);
            //Get CandidacyList with interview details
            IQueryable<Candidacy> candidacyQueryable = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                .Include(x => x.Interview).ThenInclude(x => x.IdInterviewTypeNavigation)
                .Include(x => x.Interview).ThenInclude(x => x.InterviewMark).ThenInclude(x => x.IdEmployeeNavigation)
                .Include(x => x.IdEmailNavigation)
                .Where(predicateFilterRelationModel.PredicateWhere);

            DataSourceResult<CandidacyViewModel> listCandidacy = new DataSourceResult<CandidacyViewModel>();
            listCandidacy.total = candidacyQueryable.Count();
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                listCandidacy.data = candidacyQueryable.Skip((predicateModel.page - 1) * predicateModel.pageSize).
                        Take(predicateModel.pageSize).Select(x => _builder.BuildEntity(x)).ToList();
            }
            else
            {
                listCandidacy.data = candidacyQueryable.Select(x => _builder.BuildEntity(x)).ToList();
            }
            // Order the list considering the total average mark
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.TOTAL_AVERAGE_MARK) && v.Direction.Equals(OrderByDirection.ASC)))
            {
                listCandidacy.data = listCandidacy.data.OrderBy(x => x.TotalAverageMark).ToList();
            }
            if (predicateModel.OrderBy.Any(v => v.Prop.Equals(RHConstant.TOTAL_AVERAGE_MARK) && v.Direction.Equals(OrderByDirection.DESC)))
            {
                listCandidacy.data = listCandidacy.data.OrderByDescending(x => x.TotalAverageMark).ToList();
            }
            // Add predicate filter considering the total average mark
            if (predicateModel.Filter.Any(x => x.Prop.Equals(RHConstant.TOTAL_AVERAGE_MARK)))
            {
                //Add Predicate
                PredicateFormatViewModel predicateEntity = new PredicateFormatViewModel();
                //Add filter with property EntityName
                predicateEntity.Filter = new List<FilterViewModel>();
                var listFilters = predicateModel.Filter.Where(x => x.Prop.Equals(RHConstant.TOTAL_AVERAGE_MARK));
                listFilters.ToList().ForEach(p => predicateEntity.Filter.Add(p));
                Expression<Func<CandidacyViewModel, bool>> predicateEntityWhere = PredicateUtility<CandidacyViewModel>.PredicateFilter(predicateEntity, Operator.And);
                listCandidacy.data = listCandidacy.data.Where(predicateEntityWhere.Compile()).ToList();
            }
            return listCandidacy;
        }

        public EmailViewModel generateRejectedEmailByCandidacy(CandidacyViewModel candidacy, string lang, string userMail)
        {
            try
            {
                BeginTransaction();
                CompanyViewModel company = GetCurrentCompany();
                User user = _userRepo.GetSingle(u => u.Email.ToLower() == userMail.ToLower());
                OfferEmailContant offerEmailContant = new OfferEmailContant(lang != null && lang != "" ? lang : user.Lang);
                EmailViewModel generatedEmail = new EmailViewModel
                {
                    Subject = offerEmailContant.GenerateRejectedSubjectByCulture + _jobRepo.GetSingleNotTracked(x => x.Id == candidacy.IdRecruitmentNavigation.IdJob).Designation,
                    Body = PrepareRejectedMailBody(offerEmailContant, candidacy, company.Culture, company.Name, userMail),
                    Status = (int)EmailEnumerator.Sended,
                    Sender = userMail,
                    Receivers = candidacy.IdCandidateNavigation.Email,
                    From = _smtpSettings.AdministratorMail
                };
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                candidacy.IdEmail = generatedEmailId;
                base.UpdateModelWithoutTransaction(candidacy, null, userMail);
                EndTransaction();
                return generatedEmail;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        private string PrepareRejectedMailBody(OfferEmailContant offerEmailContant, CandidacyViewModel candidacy, string culture, string societyName, string userMail)
        {
            EmployeeViewModel creator = _serviceEmployee.GetModelAsNoTracked(e =>
               e.Email.ToUpper(CultureInfo.InvariantCulture) == userMail.ToUpper(CultureInfo.InvariantCulture));
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@offerEmailContant.OfferRejectedEmailTemplateByCulture);
            body = body.Replace("{CANDIDATE_GENDER}", offerEmailContant._lang.GetTheCurrentLanguageCivilityFromGender(candidacy.IdCandidateNavigation.Sex)
                , StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CANDIDATE_NAME}", candidacy.IdCandidateNavigation.FirstName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{JOB_TITLE}", _jobRepo.GetSingleNotTracked(x => x.Id == candidacy.IdRecruitmentNavigation.IdJob).Designation, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{SOCIETY_NAME}", societyName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", creator != null ? creator.FullName : "", StringComparison.OrdinalIgnoreCase);
            return body;
        }

        #region automatic jobs
        /// <summary>
        /// Get candidacy from web portal 
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="smtpSettings"></param>
        /// <param name="apiRelativePath"></param>
        /// <returns></returns>
        public void GetCandidacyFromDrupal(string connectionString, SmtpSettings smtpSettings, string apiRelativePath)
        {
            try
            {
                BeginTransaction(connectionString);
                object responseData = DrupalConnection(null, apiRelativePath, "application/json", HttpMethod.Get).Result;
                if (responseData != null)
                {
                    IList<CandidateDrupal> candidateListDrupal = JsonConvert.DeserializeObject<IList<CandidateDrupal>>(responseData.ToString());
                    CandidateViewModel candidateViewModel = new CandidateViewModel();
                    foreach (CandidateDrupal candidateDrupal in candidateListDrupal)
                    {
                        candidateViewModel = _builder.BuildModelFromDrupalModel(candidateDrupal, candidateViewModel, _serviceProvider);
                        if (!string.IsNullOrEmpty(candidateViewModel.Email))
                        {
                            // Unicity mail in candidate list
                            if (!_serviceCandidate.FindModelBy(result => result.Email.Equals(candidateViewModel.Email) && result.Id != candidateViewModel.Id).Any())
                            {
                                CreatedDataViewModel createdDataViewModel = (CreatedDataViewModel)_serviceCandidate.AddModelWithoutTransaction(candidateViewModel, null, null, null);
                                RecruitmentViewModel recruitmentViewModel = _serviceRecruitment.FindByAsNoTracking(x => x.Code == createdDataViewModel.Code).FirstOrDefault();
                                // Add candidacy of each candidate 
                                if (createdDataViewModel != null && recruitmentViewModel != null)
                                {
                                    CandidacyViewModel candidacyViewModel = new CandidacyViewModel();
                                    candidacyViewModel.IdCandidate = createdDataViewModel.Id;
                                    candidacyViewModel.IdRecruitment = recruitmentViewModel.Id;
                                    candidacyViewModel.DepositDate = DateTime.Now;
                                    AddModelWithoutTransaction(candidacyViewModel, null, null, null);
                                }
                            }
                        }
                    }
                }                
                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }
        }

        #endregion

    }
}
