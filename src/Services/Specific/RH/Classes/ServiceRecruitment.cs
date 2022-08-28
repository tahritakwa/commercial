using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.RH;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceRecruitment : Service<RecruitmentViewModel, Recruitment>, IServiceRecruitment
    {
        private readonly IServiceUser _serviceUser;
        private readonly IRepository<Candidacy> _CandidacyRepo;
        private readonly IServiceComment _serviceComment;
        private readonly IRepository<Skills> _SkillsRepo;
        private readonly IRepository<Language> _LanguageRepo;
        private readonly IRepository<ContractType> _ContractTypeRepo;

        public ServiceRecruitment(
            IServiceUser serviceUser,
            IServiceComment serviceComment,
            IRepository<Recruitment> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            IRecruitmentBuilder builder,
            IRepository<Candidacy> CandidacyRepo,
            IRepository<Entity> entityRepoEntity,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<Skills> SkillsRepo,
            IRepository<Language> LanguageRepo,
            IRepository<ContractType> ContractTypeRepo,
            IRepository<EntityCodification> entityRepoEntityCodification,
             IRepository<Codification> entityRepoCodification,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)

        {
            _CandidacyRepo = CandidacyRepo;
            _serviceUser = serviceUser;
            _serviceComment = serviceComment;
            _SkillsRepo = SkillsRepo;
            _LanguageRepo = LanguageRepo;
            _ContractTypeRepo = ContractTypeRepo;
        }

        /// <summary>
        /// Set some filed value to the new recruitment and add the new recruitment model
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(RecruitmentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckDuplicatedLanguages(model);
            var currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            // Set request user by the current user
            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { Constants.FULL_NAME, currentUser.FirstName + " " +  currentUser.LastName}
            };
            model.IdEmployeeAuthor = currentUser.IdEmployee;
            // Set the Creation date
            model.CreationDate = DateTime.Now.Date;
            // Set state
            model.State = (int)RecruitmentStateEnumerator.Draft;
            ManageOfferPictureFile(model);
            if (model.Type == (int)RecruitmentTypeEnumerator.Offer && RoleHelper.HasPermission(RHPermissionConstant.ADD_RECRUITMENTOFFER))
            {
                model.RecruitmentTypeCode = RecruitmentTypeCodeEnumerator.RecruitmentOffer;
                return (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, "RecruitmentTypeCode");
            }
            if (model.Type == (int)RecruitmentTypeEnumerator.Request && RoleHelper.HasPermission(RHPermissionConstant.ADD_RECRUITMENTREQUEST))
            {
                model.RecruitmentTypeCode = RecruitmentTypeCodeEnumerator.RecruitmentRequest;
                return (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, "RecruitmentTypeCode"); 
            }
            if (model.Type == (int)RecruitmentTypeEnumerator.RecruitmentSession && RoleHelper.HasPermissions(new List<string>
            { RHPermissionConstant.ADD_RECRUITMENT , RHPermissionConstant.FULL_RECRUITMENT }))
            {
                model.RecruitmentTypeCode = RecruitmentTypeCodeEnumerator.Recruitment;
                return (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, "RecruitmentTypeCode");
            }
            else
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
        }

        /// <summary>
        /// Check if there is a duplicated language in recruitment offer
        /// </summary>
        /// <param name="recruitment"></param>
        private void CheckDuplicatedLanguages(RecruitmentViewModel recruitment)
        {
            if (recruitment.RecruitmentLanguage != null && recruitment.RecruitmentLanguage.Count > NumberConstant.Zero)
            {
                var groupedLanguages = recruitment.RecruitmentLanguage.GroupBy(x => x.IdLanguage);
                if (groupedLanguages.Count() != recruitment.RecruitmentLanguage.Count)
                {
                    int idOfDuplicatedLanguage = groupedLanguages.OrderByDescending(x => x.Count()).FirstOrDefault().FirstOrDefault().IdLanguage;
                    string languageName = _LanguageRepo.FindSingleBy(x => x.Id == idOfDuplicatedLanguage).Name;
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.LANGUAGE, languageName}
                    };
                    throw new CustomException(CustomStatusCode.DuplicatedLanguageInRecuitmentOffer, paramtrs);
                }
            }
        }

        /// <summary>
        /// Set the employee validator to the recruitment and update the recruitment state to candidacy
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(RecruitmentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckDuplicatedLanguages(model);
            //Throw exception if the recruitment is closed
            if (model.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            if (userMail!= null)
            {
                var currentUser = _serviceUser.GetModel(user => user.Email == userMail);
                // Set employee validator of recruitment
                if (model.IdEmployeeValidator == null && model.State == (int)RecruitmentStateEnumerator.Candidacy)
                {
                    model.IdEmployeeValidator = currentUser.IdEmployee;
                }
            }
            ManageOfferPictureFile(model);
            // Update Model 
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        public void DoneRecruitment(int recruitmentId)
        {
            RecruitmentViewModel recruitment = GetModelAsNoTracked(r => r.Id == recruitmentId);
            if (recruitment.State != (int)RecruitmentStateEnumerator.Hiring)
            {
                throw new CustomException(CustomStatusCode.DoneRecruitmentViolation);
            }
            recruitment.State = (int)RecruitmentStateEnumerator.Closed;
            if (recruitment.OfferStatus.HasValue)
            {
                recruitment.OfferStatus = (int)RecruitmentOfferStatus.Closed;
            }
            recruitment.ClosingDate = DateTime.Now;
            base.UpdateModelWithoutTransaction(recruitment, null, null);
        }

        public DataSourceResult<RecruitmentViewModel> GetRecruitmentsList(PredicateFormatViewModel predicate, int IdCandidate, DateTime? endDate, DateTime? startDate)
        {
            PredicateFilterRelationViewModel<Recruitment> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<Recruitment> recrutementQueryable = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                              .Where(predicateFilterRelationModel.PredicateWhere).OrderByRelation(predicate.OrderBy);
            if (IdCandidate != NumberConstant.Zero)
            {
                int operation = (int)predicate.Filter.FirstOrDefault(x => x.Prop == RHConstant.ID_CANDIDATE).Operation;
                List<int?> candidacyList = _CandidacyRepo.FindBy(x => operation == NumberConstant.One ? x.IdCandidate == IdCandidate : x.IdCandidate != IdCandidate).Select(y => y.IdRecruitment).Distinct().ToList();
                recrutementQueryable = recrutementQueryable.Where(x => candidacyList.Contains(x.Id));
            }
            if (startDate != null)
            {
                recrutementQueryable = recrutementQueryable.Where(x => DateTime.Compare(x.CreationDate.Date, startDate.Value.Date) >= NumberConstant.Zero);
            }
            if (endDate != null)
            {
                recrutementQueryable = recrutementQueryable.Where(x => DateTime.Compare(x.CreationDate.Date, endDate.Value.Date) <= NumberConstant.Zero);
            }
            DataSourceResult<RecruitmentViewModel> dataSourceResult = new DataSourceResult<RecruitmentViewModel>();
            dataSourceResult.total = recrutementQueryable.Count();
            dataSourceResult.data = recrutementQueryable.Skip((predicate.page - 1) * predicate.pageSize).Take(predicate.pageSize).Select(x => _builder.BuildEntity(x)).ToList();
            return dataSourceResult;
        }

        /// <summary>
        /// Validate recruitment request
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void ValidateRequest(RecruitmentViewModel recruitmentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings)
        {
            CheckDuplicatedLanguages(recruitmentViewModel);
            // User want to Change the status 
            RecruitmentViewModel oldRequest = GetModelAsNoTracked(x => x.Id == recruitmentViewModel.Id);
            if (recruitmentViewModel.RequestStatus != oldRequest.RequestStatus)
            {
                if (oldRequest.RequestStatus == (int)AdministrativeDocumentStatusEnumerator.Refused ||
                  oldRequest.RequestStatus == (int)AdministrativeDocumentStatusEnumerator.Canceled)
                { // we can not change a status already refused or canceled  
                    throw new CustomException(CustomStatusCode.recruitmentUpdateViolation);
                }
                else
                {
                    // Get connected employee
                    var currentUser = _serviceUser.GetModel(user => user.Email == userMail);
                    // Set request user by the current user
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                     {
                        { Constants.FULL_NAME, currentUser.FirstName + " " +  currentUser.LastName}
                    };
                    // Set employee validator
                    recruitmentViewModel.IdEmployeeValidator = currentUser.IdEmployee;

                    // Set the treatment date
                    recruitmentViewModel.TreatmentDate = DateTime.Now.Date;
                    // Set the recruitment type
                    if (recruitmentViewModel.RequestStatus == (int)AdministrativeDocumentStatusEnumerator.Accepted)
                    {
                        recruitmentViewModel.Type = (int)RecruitmentTypeEnumerator.Offer;
                        recruitmentViewModel.OfferStatus = (int)RecruitmentOfferStatus.New;
                        recruitmentViewModel.RecruitmentTypeCode = RecruitmentTypeCodeEnumerator.RecruitmentOffer;
                        GenerateCodification(recruitmentViewModel);
                    }
                    else if (oldRequest.RequestStatus == (int)AdministrativeDocumentStatusEnumerator.Accepted &&
                        recruitmentViewModel.RequestStatus == (int)AdministrativeDocumentStatusEnumerator.Canceled)
                    {
                        recruitmentViewModel.OfferStatus = (int)RecruitmentOfferStatus.Closed;

                    }
                }
            }
            // Update Model
            base.UpdateModelWithoutTransaction(recruitmentViewModel, entityAxisValuesModelList, userMail);
        }
        /// <summary>
        /// GetModelWithRelations overrided
        /// </summary>
        /// <param name="predicateModel"></param>
        public override RecruitmentViewModel GetModelById(int id)
        {
            RecruitmentViewModel recruitmentViewModel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.IdJobNavigation)
                .Include(x => x.IdOfficeNavigation)
                .Include(x => x.IdQualificationTypeNavigation)
                .Include(x => x.IdContractTypeNavigation)
                .Include(x => x.RecruitmentLanguage)
                .ThenInclude(x => x.IdLanguageNavigation)
                .Include(x => x.RecruitmentSkills)
                .ThenInclude(x => x.IdSkillsNavigation)
                .ToList().Select(_builder.BuildEntity).FirstOrDefault();

            // get comments related to the current request
            if (recruitmentViewModel != null)
            {
                recruitmentViewModel.Comments = _serviceComment.GetComments(nameof(Recruitment), recruitmentViewModel.Id);
                recruitmentViewModel.PictureFileInfo = GetFilesContent(recruitmentViewModel.OfferPicture).FirstOrDefault();

            }
            return recruitmentViewModel;

        }
        /// <summary>
        /// Open or close the job offer
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void PublishJobOffer(RecruitmentViewModel recruitmentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings)
        {
            try
            {
                // User want to Change the status 
                RecruitmentViewModel oldRequest = GetModelAsNoTracked(x => x.Id == recruitmentViewModel.Id);
                if (recruitmentViewModel.OfferStatus != oldRequest.OfferStatus)
                {
                    if (oldRequest.OfferStatus == (int)RecruitmentOfferStatus.Closed)
                    { // we can not change a status already closed  
                        throw new CustomException(CustomStatusCode.recruitmentUpdateViolation);
                    }
                    else
                    {
                        // Set type offer to recruitment session 
                        if (recruitmentViewModel.OfferStatus == (int)RecruitmentOfferStatus.Opened)
                        {
                            recruitmentViewModel.Type = (int)RecruitmentTypeEnumerator.RecruitmentSession;
                            recruitmentViewModel.State = (int)RecruitmentStateEnumerator.Candidacy;
                            recruitmentViewModel.RecruitmentTypeCode = RecruitmentTypeCodeEnumerator.Recruitment;
                            GenerateCodification(recruitmentViewModel);
                        }
                        else if (recruitmentViewModel.OfferStatus == (int)RecruitmentOfferStatus.Closed)
                        {
                            recruitmentViewModel.ClosingDate = DateTime.Now;
                        }
                    }

                }
                //object responseData = new object();
                //if (recruitmentViewModel.OfferStatus == (int)RecruitmentOfferStatus.Opened)
                //{
                //    object offerToPublishModel = BuildOfferModelToPublish(recruitmentViewModel);
                //    responseData = DrupalConnection(offerToPublishModel, "/drupal/node?_format=json",
                //        "application/json", HttpMethod.Post).Result;
                //}
                //else if (recruitmentViewModel.OfferStatus == (int)RecruitmentOfferStatus.Closed)
                //{
                //    object offerToCloseModel = BuildOfferModelToClose(recruitmentViewModel);
                //    responseData = DrupalConnection(offerToCloseModel, "/drupal/jsonapi/node/article/" + recruitmentViewModel.Code,
                //        "application/vnd.api+json", HttpMethod.Patch).Result;
                //}
                //if (responseData == null) {
                //    throw new CustomException(CustomStatusCode.FailedDrupalConnection);
                //}
            }
            finally
            {
                UpdateModelWithoutTransaction(recruitmentViewModel, entityAxisValuesModelList, userMail);
            }
        }
        /// <summary>
        /// Manage Offer picture file attachement
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        private void ManageOfferPictureFile(RecruitmentViewModel recruitmentViewModel)
        {
            if (string.IsNullOrEmpty(recruitmentViewModel.OfferPicture))
            {
                if (recruitmentViewModel.PictureFileInfo != null)
                {
                    recruitmentViewModel.OfferPicture = Path.Combine(RHConstant.RHOfferPictureFileRootPath, Guid.NewGuid().ToString());
                    CopyFiles(recruitmentViewModel.OfferPicture, recruitmentViewModel.PictureFileInfo);
                }
            }
            else
            {
                if (recruitmentViewModel.PictureFileInfo != null)
                {
                    List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                    fileInfo.Add(recruitmentViewModel.PictureFileInfo);
                    DeleteFiles(recruitmentViewModel.OfferPicture, fileInfo);
                    CopyFiles(recruitmentViewModel.OfferPicture, fileInfo);
                }
            }
        }

        /// <summary>
        /// Generate validation or publish codification
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        private void GenerateCodification(RecruitmentViewModel recruitmentViewModel)
        {
            List<object> codification;
            Recruitment entity = _builder.BuildModel(recruitmentViewModel);
            codification = getCodification(entity, "RecruitmentTypeCode", false);
            recruitmentViewModel.Code = codification[2].ToString();
            if (codification.Any() && ((Codification)codification[0]).Id != NumberConstant.Zero)
            {
                ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                _entityRepoCodification.Update(((Codification)codification[0]));
                _unitOfWork.Commit();
            }
        }
        /// <summary>
        /// Build model to close offer in portal web
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        /// <returns></returns>
        private object BuildOfferModelToClose(RecruitmentViewModel recruitmentViewModel)
        {
            OfferDrupalModel offerDrupal = new OfferDrupalModel();
            offerDrupal.Id = recruitmentViewModel.Code;
            Dictionary<string, OfferDrupalModel> modelToSend = new Dictionary<string, OfferDrupalModel>();
            modelToSend.Add("data", offerDrupal);
            return modelToSend;
        }
        /// <summary>
        /// Build picture model to send it to portal web
        /// </summary>
        /// <param name="pictureFileInfo"></param>
        /// <returns></returns>
        private object BuildPictureModelToSend(FileInfoViewModel pictureFileInfo)
        {

            RecruitmentPictureDrupalModel recruitmentPictureDrupalModel = new RecruitmentPictureDrupalModel();
            recruitmentPictureDrupalModel.Filename[0].Add("value", pictureFileInfo.Name);
            recruitmentPictureDrupalModel.Uri[0].Add("value", Path.Combine("public:","RH","recruitment-offer", Guid.NewGuid() + pictureFileInfo.Extension));
            recruitmentPictureDrupalModel.Data[0].Add("value", pictureFileInfo.Data);
            return recruitmentPictureDrupalModel;
        }
        /// <summary>
        /// Build offer model to send it to portal web
        /// </summary>
        /// <param name="recruitmentViewModel"></param>
        /// <returns></returns>
        private object BuildOfferModelToPublish(RecruitmentViewModel recruitmentViewModel)
        {
            RecruitmentDrupal recruitmentDrupal = new RecruitmentDrupal();
            if(recruitmentViewModel.PictureFileInfo != null)
            {
                ManageOfferPictureFile(recruitmentViewModel);
                object responseData = DrupalConnection(BuildPictureModelToSend(recruitmentViewModel.PictureFileInfo),
                "/drupal/entity/file?_format=hal_json", "application/hal+json", HttpMethod.Post).Result;
                dynamic pictureDrupalModel = JsonConvert.DeserializeObject<dynamic>(responseData.ToString());
                recruitmentDrupal.Field_image[0].Add("target_id", pictureDrupalModel.fid[0].value.ToString());
            }
            recruitmentDrupal.Title[0].Add("value", recruitmentViewModel.IdJobNavigation.Designation);
            recruitmentDrupal.Body[0].Add("value", recruitmentViewModel.Description);
            recruitmentDrupal.Field_yearofexperience[0].Add("value", recruitmentViewModel.YearOfExperience);
            recruitmentDrupal.Field_office[0].Add("value", recruitmentViewModel.IdOfficeNavigation.OfficeName);
            recruitmentDrupal.Field_contract[0].Add("value", _ContractTypeRepo.FindByAsNoTracking(
                result => result.Id == recruitmentViewModel.IdContractType).FirstOrDefault().Code);
            recruitmentDrupal.Field_diploma_type[0].Add("value", recruitmentViewModel.IdQualificationTypeNavigation.Label);
            recruitmentDrupal.Field_gender[0].Add("value", StringUtilityExtensions.GetTheCurrentGenderNameFromGenderId("fr", recruitmentViewModel.Sex));
            recruitmentDrupal.Uuid[0].Add("value", recruitmentViewModel.Code);
            foreach (RecruitmentSkillsViewModel r in recruitmentViewModel.RecruitmentSkills)
            {
                Skills skill = _SkillsRepo.FindByAsNoTracking(result => result.Id == r.IdSkills).FirstOrDefault();
                Dictionary<string, string> skills = new Dictionary<string, string>();
                skills.Add("value", skill.Label);
                recruitmentDrupal.Field_skills.Add(skills);
            }
            foreach (RecruitmentLanguageViewModel r in recruitmentViewModel.RecruitmentLanguage)
            {
                Language language = _LanguageRepo.FindByAsNoTracking(result => result.Id == r.IdLanguage).FirstOrDefault();
                Dictionary<string, string> languages = new Dictionary<string, string>();
                languages.Add("value", language.Name);
                recruitmentDrupal.Field_languages.Add(languages);

            }
            return recruitmentDrupal;
        }
    }
}
