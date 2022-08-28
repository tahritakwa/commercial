using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceOffer : Service<OfferViewModel, Offer>, IServiceOffer
    {
        private readonly IServiceCompany _companyService;
        private readonly IServiceEmail _serviceEmail;
        private readonly IRepository<Candidacy> _candidacyEntityRepos;
        private readonly IRepository<Recruitment> _recruitmentEntityRepos;
        private readonly IRepository<User> _userRepo;
        private readonly IServiceOfferBonus _serviceOfferBonus;
        private readonly IServiceOfferBenefitInKind _serviceOfferBenefitInKind;
        private readonly SmtpSettings _smtpSettings;

        public ServiceOffer(IRepository<Offer> entityRepo,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues,
         IUnitOfWork unitOfWork,        IOfferBuilder builder,
        IEntityAxisValuesBuilder builderEntityAxisValues,
        IServiceCompany companyService,
        IServiceEmail serviceEmail,
        IRepository<User> userRepo,
        IRepository<Candidacy> candidacyEntityRepos,
        IRepository<Recruitment> recruitmentEntityRepos,
        IOptions<AppSettings> appSettings,
        IRepository<Company> entityRepoCompany,
        ICompanyBuilder companyBuilder,
        IMemoryCache memoryCache,
        IServiceOfferBonus serviceOfferBonus,
        IServiceOfferBenefitInKind serviceOfferBenefitInKind,
        IOptions<SmtpSettings> smtpSettings
        )
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _companyService = companyService;
            _serviceEmail = serviceEmail;
            _userRepo = userRepo;
            _candidacyEntityRepos = candidacyEntityRepos;
            _recruitmentEntityRepos = recruitmentEntityRepos;
            _serviceOfferBonus = serviceOfferBonus;
            _serviceOfferBenefitInKind = serviceOfferBenefitInKind;
            _smtpSettings = smtpSettings.Value;
        }

        public override object AddModelWithoutTransaction(OfferViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //Throw exception if the recruitment is closed
            Candidacy candidacy = _candidacyEntityRepos.GetSingleWithRelationsNotTracked(x => x.Id == model.IdCandidacy, x => x.IdRecruitmentNavigation, x => x.Offer);
            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            IList<OfferViewModel> candidateOfferList = FindModelsByNoTracked(x => x.IdCandidacyNavigation.IdCandidate == candidacy.IdCandidate);
            if (candidateOfferList != null && candidateOfferList.Any(x => x.Id != model.Id && x.State == (int)OfferStateEnumerator.Accepted))
            {
                throw new CustomException(CustomStatusCode.CandidateAlreadyAcceptedInOtherOffer);
            }
            // Check if the start date is greater than end date
            if (model.EndDate != null && model.StartDate > model.EndDate)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.SMALLEST_DATE, Constants.START_DATE },
                        { Constants.BIGGEST_DATE, Constants.END_DATE }
                    };
                throw new CustomException(CustomStatusCode.DatesDependency, paramtrs);
            }
            //Check if the candidacy has an offer which state is not draf, sended or accepted
            IList<OfferViewModel> offerViewModels = FindModelBy(result => result.IdCandidacy.Equals(model.IdCandidacy)
                                                                && (result.State.Equals((int)OfferStateEnumerator.Draft) ||
                                                                     result.State.Equals((int)OfferStateEnumerator.Sended) ||
                                                                     result.State.Equals((int)OfferStateEnumerator.Accepted)
                                                              )).ToList();
            if (offerViewModels.Any())
            {
                throw new CustomException(CustomStatusCode.AddOfferViolation);
            }

            model.State = (int)OfferStateEnumerator.Draft;
            CheckBonusesAndBenefitsInKind(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property); ;
        }

        // Check bonues and benefits in kinds periodicity
        private void CheckBonusesAndBenefitsInKind(OfferViewModel model)
        {
            if (model.OfferBenefitInKind != null)
            {
                _serviceOfferBenefitInKind.CheckOfferBenefitsInKind(model);
            }
            if (model.OfferBonus != null)
            {
                _serviceOfferBonus.CheckOfferBonusesPeriodicity(model);
            }
        }

        public override object UpdateModelWithoutTransaction(OfferViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //Throw exception if the recruitment is closed
            Candidacy candidacy = _candidacyEntityRepos.GetSingleWithRelationsNotTracked(x => x.Id == model.IdCandidacy, x => x.IdRecruitmentNavigation);
            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            //Can't update a offer wich state is  not draft
            if (model.State != (int)OfferStateEnumerator.Draft)
            {
                throw new CustomException(CustomStatusCode.UpdateOfferViolation);
            }
            CheckBonusesAndBenefitsInKind(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Methode call to accept the offer
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public OfferViewModel AcceptTheOffer(OfferViewModel model, string userMail)
        {
            try
            {
                BeginTransaction();
                OfferViewModel oldOffer = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.IdCandidacyNavigation, x => x.IdCandidacyNavigation.IdRecruitmentNavigation);
                //Throw exception if the recruitment is closed
                if (oldOffer.IdCandidacyNavigation.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }

                IList<OfferViewModel> candidateOfferList = FindModelsByNoTracked(x => x.IdCandidacyNavigation.IdCandidate == oldOffer.IdCandidacyNavigation.IdCandidate);
                if (candidateOfferList != null && candidateOfferList.Any(x => x.Id != model.Id && x.State == (int)OfferStateEnumerator.Accepted))
                {
                    throw new CustomException(CustomStatusCode.CandidateAlreadyAcceptedInOtherOffer);
                }
                //Condidtion execute to accepted the offer
                if (model.IdEmail != null && model.State == (int)OfferStateEnumerator.Sended)
                {
                    model.State = (int)OfferStateEnumerator.Accepted;
                    // Set candidacy state to hiring
                    Candidacy candidacy = _candidacyEntityRepos.GetSingleWithRelationsNotTracked(c => c.Id == model.IdCandidacy);
                    candidacy.State = (int)RecruitmentStateEnumerator.Hiring;
                    _candidacyEntityRepos.Update(candidacy);
                    // Set recruitment state to Hiring
                    Recruitment recruitment = _recruitmentEntityRepos.GetSingleWithRelationsNotTracked(r => r.Id == candidacy.IdRecruitment);
                    if (recruitment.State == (int)RecruitmentStateEnumerator.Offer)
                    {
                        recruitment.State = (int)RecruitmentStateEnumerator.Hiring;
                        _recruitmentEntityRepos.Update(recruitment);
                    }
                    base.UpdateModelWithoutTransaction(model, null, userMail);
                }
                else
                {
                    throw new CustomException(CustomStatusCode.OfferAcceptViolation);
                }
                EndTransaction();
                return model;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }

        /// <summary>
        /// Methode call to reject the offer
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public OfferViewModel RejectTheOffer(OfferViewModel model, string userMail)
        {
            try
            {
                BeginTransaction();
                OfferViewModel oldOffer = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.IdCandidacyNavigation, x => x.IdCandidacyNavigation.IdRecruitmentNavigation);
                //Throw exception if the recruitment is closed
                if (oldOffer.IdCandidacyNavigation.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                //Condidtion execute to rejected the offer
                if (model.IdEmail != null && model.State == (int)OfferStateEnumerator.Sended)
                {
                    model.State = (int)OfferStateEnumerator.Rejected;
                    base.UpdateModelWithoutTransaction(model, null, userMail);
                }
                else
                {
                    throw new CustomException(CustomStatusCode.OfferRejectViolation);
                }
                EndTransaction();
                return model;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }

        /// <summary>
        /// Methode call when the offer Email was send to the candidate
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public OfferViewModel UpdateOfferAfterEmailSend(OfferViewModel model, string userMail)
        {
            try
            {
                BeginTransaction();
                OfferViewModel oldOffer = GetModelAsNoTracked(x => x.Id == model.Id);
                //Condition execute when the offer Email was generated and was sended to the candidate
                if (oldOffer.IdEmail != null && model.State == (int)OfferStateEnumerator.Draft)
                {
                    model.State = (int)OfferStateEnumerator.Sended;
                    model.SendingDate = DateTime.Now.Date;
                    model.Token = oldOffer.Token;
                    base.UpdateModelWithoutTransaction(model, null, userMail);
                }
                EndTransaction();
                return model;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }
        /// <summary>
        /// Get offer by Id with his relation, this will help to have all information to generate the Email
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public OfferViewModel GetOfferWithHisNavigations(int id)
        {
            Offer offerEntity = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.Advantages)
                .Include(x => x.IdSalaryStructureNavigation)
                .Include(x => x.IdCandidacyNavigation)
                .Include(x => x.IdCnssNavigation)
                .Include(x => x.IdCandidacyNavigation.IdCandidateNavigation)
                .Include(x => x.IdCandidacyNavigation.IdRecruitmentNavigation.IdJobNavigation)
                .Include(x => x.IdEmailNavigation)
                .Include(x => x.OfferBenefitInKind)
                .ThenInclude(x => x.IdBenefitInKindNavigation)
                .Include(x => x.OfferBonus)
                .ThenInclude(x => x.IdBonusNavigation)
                .ThenInclude(x => x.BonusValidityPeriod)
                .FirstOrDefault();
            OfferViewModel offer = _builder.BuildEntity(offerEntity);
            if (offer.IdEmailNavigation != null)
            {
                offer.IdEmailNavigation.From = _smtpSettings.AdministratorMail;
            }
            return offer;
        }

        /// <summary>
        /// Generate offer Email by offer
        /// </summary>
        /// <param name="offer"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public EmailViewModel GenerateOfferEmailByOffer(OfferViewModel offer, string lang, string userMail)
        {
            try
            {
                BeginTransaction();
                offer = GetOfferWithHisNavigations(offer.Id);
                //Throw exception if the recruitment is closed
                if (offer.IdCandidacyNavigation.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                EmailViewModel generatedEmail = offer.IdEmailNavigation;
                CompanyViewModel company = _companyService.GetCurrentCompany();                
                User user = _userRepo.GetSingleWithRelationsNotTracked(x => x.Email.ToLower() == userMail.ToLower());
                OfferEmailContant offerEmailContant = new OfferEmailContant(!string.IsNullOrEmpty(lang) ? lang : user.Lang);
                if (generatedEmail == null)
                {
                    generatedEmail = new EmailViewModel
                    {
                        Subject = GenerateOfferSubjectByCulture(offerEmailContant, offer),
                        Body = PrepareOfferMailBody(offerEmailContant, offer, company.Culture, company, userMail, lang),
                        Status = (int)EmailEnumerator.Draft,
                        Sender = userMail,
                        Receivers = offer.IdCandidacyNavigation.IdCandidateNavigation.Email,
                        From = _smtpSettings.AdministratorMail
                    };
                    int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                    generatedEmail.Id = generatedEmailId;
                    offer.IdEmail = generatedEmailId;
                    base.UpdateModelWithoutTransaction(offer, null, userMail);
                }
                else
                {
                    generatedEmail.From = _smtpSettings.AdministratorMail;
                    generatedEmail.Subject = GenerateOfferSubjectByCulture(offerEmailContant, offer);
                    generatedEmail.Body = PrepareOfferMailBody(offerEmailContant, offer, company.Culture, company, userMail, lang);
                    _serviceEmail.UpdateModelWithoutTransaction(generatedEmail, null, userMail);
                }
                EndTransaction();
                return generatedEmail;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Generate the subject of the Offer Email
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        private string GenerateOfferSubjectByCulture(OfferEmailContant offerEmailContant, OfferViewModel offer)
        {
            return offerEmailContant.GenerateOfferSubjectByCulture + GenerateJobTitle(offer);
        }

        private string GenerateJobTitle(OfferViewModel offer)
        {
            return offer.IdCandidacyNavigation.IdRecruitmentNavigation.IdJobNavigation.Designation;
        }

        /// <summary>
        /// Generate a list of all renumeration of the offer
        /// </summary>
        /// <param name="offer"></param>
        /// <param name="culture"></param>
        /// <returns></returns>
        private string GenerateRenumerationListByCulture(OfferEmailContant offerEmailContant, OfferViewModel offer, string culture, CompanyViewModel company)
        {
            StringBuilder renumeration = new StringBuilder();
            renumeration.Append("<ul>");
            renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.SalaryStructureByCulture + "<strong>" + offer.IdSalaryStructureNavigation.SalaryStructureReference + "</strong></li></span>");
            renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.StartDateByCulture + "<strong>" + DateUtility.GenerateDateByCulture(offer.StartDate, culture) + "</strong></li></span>");
            if (offer.EndDate != null)
            {
                renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.EndtDateByCulture + "<strong>" + DateUtility.GenerateDateByCulture((DateTime)offer.EndDate, culture) + "</strong></li></span>");
            }
            renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.WorkingHoursPerWeekByCulture + "<strong>" + offer.WorkingHoursPerWeek + "</strong></li></span>");
            renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.SalaryByCulture + "<strong>" + offer.Salary + " " +
                (company != null && company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : "") + "</strong></li></span>");
            renumeration.Append("<span class=\"ql - font - serif\"><li>" + offerEmailContant.SocialContributionByCulture + "<strong>" + offer.IdCnssNavigation.Label + " </strong></li></span>");
            renumeration.Append("</ul>");
            return renumeration.ToString();
        }

        /// <summary>
        /// Generate a list of all existing advantages of the offer
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        private string GenerateAdvantagesListByCulture(OfferEmailContant offerEmailContant, OfferViewModel offer, CompanyViewModel company, string culture)
        {
            StringBuilder renumeration = new StringBuilder();
            if ((offer.Advantages != null && offer.Advantages.Count > 0) || (offer.ThirteenthMonthBonus.HasValue && offer.ThirteenthMonthBonus.Value)
                || (offer.AvailableHouse.HasValue && offer.AvailableHouse.Value) || (offer.AvailableCar.HasValue && offer.AvailableCar.Value) || offer.MealVoucher.HasValue || offer.CommissionType.HasValue)
            {
                renumeration.Append("<p><span class=\"ql - font - serif\">" + offerEmailContant.AdvantagesByCulture + "</span>");
                renumeration.Append("<ul>");
                // Advantages
                if (offer.ThirteenthMonthBonus.HasValue && offer.ThirteenthMonthBonus.Value)
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerEmailContant.ThirteenthMonthBonusByCulture);
                    renumeration.Append("</li></span>");
                }
                if (offer.AvailableCar.HasValue && offer.AvailableCar.Value)
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerEmailContant.AvailableCarByCulture);
                    renumeration.Append("</li></span>");
                }
                if (offer.MealVoucher.HasValue && !offer.MealVoucher.Equals(NumberConstant.Zero))
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerEmailContant.MealVoucherByCulture + "<strong>" + offer.MealVoucher + PayRollConstant.BlankSpace
                        + (company != null && company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : ""));
                    renumeration.Append("</strong></li></span>");
                }
                if (offer.AvailableHouse.HasValue && offer.AvailableHouse.Value)
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerEmailContant.AvailableHouseByCulture);
                    renumeration.Append("</li></span>");
                }
                if (offer.CommissionType.HasValue && offer.CommissionType != NumberConstant.Zero)
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerEmailContant.CommissionByCulture);
                    if (offer.CommissionType == (int)CommissionType.Proportion)
                    {
                        renumeration.Append(offerEmailContant.CommissionInProportionalByCulture + " <strong>");
                        renumeration.Append(offer.CommissionValue + " %");
                    }
                    else
                    {
                        renumeration.Append(offerEmailContant.CommissionInValueByCulture + "<strong>");
                        renumeration.Append(offer.CommissionValue + PayRollConstant.BlankSpace + (company != null && company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : ""));
                    }
                    renumeration.Append(" </strong></li></span>");
                }
                // Other advantages
                if (offer.Advantages != null && offer.Advantages.Count > NumberConstant.Zero)
                {
                    foreach (AdvantagesViewModel advantage in offer.Advantages)
                    {
                        renumeration.Append("<span class=\"ql - font - serif\"><li>");
                        renumeration.Append(advantage.Description);
                        renumeration.Append("</li></span>");
                    }
                }
                renumeration.Append("</ul></p>");
            }
            // Benefits in kind
            if (offer.OfferBenefitInKind != null && offer.OfferBenefitInKind.Count > NumberConstant.Zero)
            {
                renumeration.Append("<p><span class=\"ql - font - serif\">" + offerEmailContant.BenefitInKindsByCulture + "</span>");
                renumeration.Append("<ul>");
                foreach (OfferBenefitInKindViewModel offerBenefitInKind in offer.OfferBenefitInKind)
                {
                    renumeration.Append("<span class=\"ql - font - serif\"><li>");
                    renumeration.Append(offerBenefitInKind.IdBenefitInKindNavigation.Name + PayRollConstant.BlankSpace);
                    renumeration.Append(offerEmailContant.ValidFrom + PayRollConstant.BlankSpace + DateUtility.GenerateDateByCulture(offerBenefitInKind.ValidityStartDate, culture) + PayRollConstant.BlankSpace);
                    if (offerBenefitInKind.ValidityEndDate.HasValue)
                    {
                        renumeration.Append(offerEmailContant.Until + DateUtility.GenerateDateByCulture(offerBenefitInKind.ValidityEndDate.Value, culture));
                    }
                    renumeration.Append(offerEmailContant.WithAValueOf);
                    renumeration.Append("<strong>" + offerBenefitInKind.Value + PayRollConstant.BlankSpace + (company != null && company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : "") + "</strong>");
                    renumeration.Append("</li></span>");
                }
                renumeration.Append("</ul></p>");
            }
            return renumeration.ToString();
        }

        /// <summary>
        /// Generate a list of bonuses
        /// </summary>
        /// <param name="offerEmailContant"></param>
        /// <param name="offer"></param>
        /// <param name="company"></param>
        /// <returns></returns>
        private string GenerateBonusesListByCulture(OfferEmailContant offerEmailContant, OfferViewModel offer, CompanyViewModel company, string culture)
        {
            StringBuilder bonuses = new StringBuilder();
            // Bonuses
            if (offer.OfferBonus != null && offer.OfferBonus.Count > NumberConstant.Zero)
            {
                bonuses.Append("<p><span class=\"ql - font - serif\">" + offerEmailContant.BonusesByCulture + "</span>");
                bonuses.Append("<ul>");
                foreach (OfferBonusViewModel offerBonus in offer.OfferBonus)
                {
                    bonuses.Append("<span class=\"ql - font - serif\"><li>");
                    bonuses.Append(offerBonus.IdBonusNavigation.Name + PayRollConstant.BlankSpace);
                    bonuses.Append(offerEmailContant.ValidFrom + PayRollConstant.BlankSpace + DateUtility.GenerateDateByCulture(offerBonus.ValidityStartDate, culture) + PayRollConstant.BlankSpace);
                    if (offerBonus.ValidityEndDate.HasValue)
                    {
                        bonuses.Append(offerEmailContant.Until + DateUtility.GenerateDateByCulture(offerBonus.ValidityEndDate.Value, culture));
                    }
                    bonuses.Append(offerEmailContant.WithAValueOf);
                    double value = offerBonus.Value.HasValue ? offerBonus.Value.Value : offerBonus.IdBonusNavigation.BonusValidityPeriod.Where(x => offerBonus.ValidityStartDate.AfterDateLimitIncluded(x.StartDate))
                        .OrderByDescending(x => x.StartDate).FirstOrDefault().Value;
                    bonuses.Append("<strong>" + value + PayRollConstant.BlankSpace + (company != null && company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : "") + "</strong>");
                    bonuses.Append("</li></span>");
                }
                bonuses.Append("</ul></p>");
            }
            return bonuses.ToString();
        }

        /// <summary>
        /// Preepare the body of the offer Email
        /// </summary>
        /// <param name="offerEmailContant"></param>
        /// <param name="offer"></param>
        /// <param name="culture"></param>
        /// <param name="company"></param>
        /// <param name="userMail"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        private string PrepareOfferMailBody(OfferEmailContant offerEmailContant, OfferViewModel offer, string culture, CompanyViewModel company, string userMail, string lang)
        {
            User user = _userRepo.GetSingleWithRelationsNotTracked(x => x.Email.ToLower() == userMail.ToLower(), x => x.IdEmployeeNavigation);
            string creatoFullName = user is null ? string.Empty :
                user.IdEmployeeNavigation is null ? user.FullName : user.IdEmployeeNavigation.FullName;
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@offerEmailContant.OfferRequestEmailTemplateByCulture);
            body = body.Replace("{CANDIDATE_GENDER}", offerEmailContant._lang.GetTheCurrentLanguageCivilityFromGender(offer.IdCandidacyNavigation.IdCandidateNavigation.Sex)
                , StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CANDIDATE_NAME}", offer.IdCandidacyNavigation.IdCandidateNavigation.FirstName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{JOB_TITLE}", GenerateJobTitle(offer), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{SOCIETY_NAME}", company.Name, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{RENUMERATION_LIST}", GenerateRenumerationListByCulture(offerEmailContant, offer, culture, company), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{BONUS_LIST}", GenerateBonusesListByCulture(offerEmailContant, offer, company, culture), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{ADVANTAGES_LIST}", GenerateAdvantagesListByCulture(offerEmailContant, offer, company, culture), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", creatoFullName != null ? creatoFullName : "", StringComparison.OrdinalIgnoreCase);
            if (offer.Token == null)
            {
                offer.Token = Guid.NewGuid().ToString();
            }
            body = body.Replace("{CONFIRM_EMAIL}", _appSettings.BaseUrl + "api/confirmation/offer/" + offer.Token + "/" + lang);
            return body;
        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            try
            {
                BeginTransaction();
                OfferViewModel offer = GetModelWithRelationsAsNoTracked(x => x.Id == id, x => x.IdCandidacyNavigation, x => x.IdCandidacyNavigation.IdRecruitmentNavigation);
                //Throw exception if the recruitment is closed
                if (offer.IdCandidacyNavigation.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
                {
                    throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                }
                // Check if the offer state is not draft
                if (offer.State != (int)OfferStateEnumerator.Draft)
                {
                    throw new CustomException(CustomStatusCode.OfferDelteViolation);
                }
                var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
                EndTransaction();
                return obj;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }
        /// <summary>
        /// Confirm the offer proposal 
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="token"></param>
        /// <returns></returns>
        public int ConfirmOfferFromLink(string connectionString, string token)
        {
            int state = NumberConstant.Zero;
            try
            {
                BeginTransaction(connectionString);
                Offer offer = _entityRepo.GetSingleNotTracked(x => x.Token == token);
                EndTransaction();
                if (offer != null && offer.State == (int)OfferStateEnumerator.Sended)
                {
                    AcceptTheOffer(_builder.BuildEntity(offer), null);
                    state = (int)OfferConfirmationEnumerator.OfferConfirmed;
                }
                else if (offer != null && offer.State == (int)OfferStateEnumerator.Accepted)

                {
                    state = (int)OfferConfirmationEnumerator.OfferAlreadyConfirmed;
                }
                else
                {
                    state = (int)OfferConfirmationEnumerator.InvalidUrl;
                }
            }
            catch (Exception e)
            {
                throw;
            }
            return state;


        }

    }

}
