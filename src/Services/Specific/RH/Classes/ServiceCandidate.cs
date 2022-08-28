using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceCandidate : Service<CandidateViewModel, Candidate>, IServiceCandidate
    {
        private readonly IRepository<User> _userRepo;
        private readonly IRepository<Employee> _employeeRepo;
        public readonly IReducedCandidateBuilder _reducedBuilder;

        public ServiceCandidate(IRepository<Candidate> entityRepo,
            IRepository<User> userRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,ICandidateBuilder builder,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<Employee> employeeRepo,
            IReducedCandidateBuilder reducedBuilder)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _userRepo = userRepo;
            _employeeRepo = employeeRepo;
            _reducedBuilder = reducedBuilder;
        }
        public override object AddModelWithoutTransaction(CandidateViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckUniqueCase(model);
            if (userMail != null)
            {
                model.IdCreationUser = _userRepo.GetSingleWithRelationsNotTracked(u => u.Email.ToUpper() == userMail.ToUpper()).Id;
            }
            IList<CandidateViewModel> candidateViewModel = FindModelBy(result => result.Email.Equals(model.Email)).ToList();
            if (candidateViewModel.Any())
            {
                throw new CustomException(CustomStatusCode.AddExistingCandidate);
            }
            ManageCandidateFiles(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CandidateViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckUniqueCase(model);
            ManageCandidateFiles(model);
            // model.Qualification.ElementAt(0).IdCandidate = model.Id;
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        private void ManageCandidateFiles(CandidateViewModel model)
        {
            ManageCandidateCV(model);
            ManageQualificationFile(model);
        }
        private void ManageQualificationFile(CandidateViewModel model)
        {
            //Mange Employes Qualification Files
            if (model.Qualification != null)
            {
                foreach (var qualification in model.Qualification)
                {
                    if (string.IsNullOrEmpty(qualification.QualificationAttached))
                    {
                        if (qualification.QualificationFileInfo != null)
                        {
                            qualification.QualificationAttached = Path.Combine("RH", "Candidate", "Qualification", model.FirstName + model.LastName, Guid.NewGuid().ToString());
                            CopyFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                        }
                    }
                    else
                    {
                        if (qualification.QualificationFileInfo != null)
                        {
                            DeleteFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                            CopyFiles(qualification.QualificationAttached, qualification.QualificationFileInfo);
                        }

                    }
                }
            }
        }
        private void ManageCandidateCV(CandidateViewModel model)
        {
            //Manage CV 
            if (model.CurriculumVitae != null)
            {
                foreach (var cv in model.CurriculumVitae)
                {
                    if (string.IsNullOrEmpty(cv.CurriculumVitaePath))
                    {
                        if (cv.CvFileInfo != null)
                        {
                            string RCV = Path.Combine("RH", "Candidate", "Cv");
                            cv.CurriculumVitaePath = Path.Combine(RCV, model.FirstName + model.LastName, Guid.NewGuid().ToString());
                            CopyFiles(cv.CurriculumVitaePath, cv.CvFileInfo);
                        }
                    }
                    else
                    {
                        if (cv.CvFileInfo != null)
                        {
                            DeleteFiles(cv.CurriculumVitaePath, cv.CvFileInfo);
                            CopyFiles(cv.CurriculumVitaePath, cv.CvFileInfo);
                        }

                    }
                }
            }
        }


        public override CandidateViewModel GetModelById(int id)
        {
            CandidateViewModel candidate = base.GetModelAsNoTracked(x => x.Id == id, x => x.CurriculumVitae, x => x.Qualification);

            if (candidate.CurriculumVitae != null)
            {
                foreach (CurriculumVitaeViewModel cv in candidate.CurriculumVitae)
                {
                    if (cv.CurriculumVitaePath != null)
                    {
                        cv.CvFileInfo = GetFilesContent(cv.CurriculumVitaePath).ToList();
                    }
                }
            }

            if (candidate.Qualification != null)
            {
                foreach (var qualification in candidate.Qualification)
                {
                    qualification.QualificationFileInfo = GetFiles(qualification.QualificationAttached).ToList();
                }
            }
            return candidate;
        }

        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Candidate> predicateFilterRelationModel)
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

        private void CheckUniqueCase (CandidateViewModel candidate)
        {
            if (!string.IsNullOrEmpty(candidate.Cin))
            {
                if (FindModelBy(result => result.Cin.Equals(candidate.Cin) && result.Id != candidate.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.SameCandidateCinNumber);
                }
                else if (candidate.Cin.Length != NumberConstant.Eight)
                {
                    throw new CustomException(CustomStatusCode.InvalidCinLength);
                }
            }
            if (!string.IsNullOrEmpty(candidate.Email))
            {
                // Unicity mail in candidate list
                if (FindModelBy(result => result.Email.Equals(candidate.Email) && result.Id != candidate.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.DuplicatedCandidateEmailException);
                }
                // Unicity mail in employee list
                if (_employeeRepo.FindBy(result => result.Email.Equals(candidate.Email) && result.Id != candidate.IdEmployee).Any())
                {
                    throw new CustomException(CustomStatusCode.CandidateEmailIsAlreadyEmployeeEmail);
                }
            }
        }

        /// <summary>
        /// Get candidates who haven't accepted any offer
        /// </summary>
        /// <returns></returns>
        public DataSourceResult<CandidateViewModel> GetAvailableCandidates()
        {
            IList<CandidateViewModel> candidates = FindModelBy(x => !x.Candidacy.Any(y => y.IdCandidate == x.Id && y.Offer.Any(z => z.State == (int)OfferStateEnumerator.Accepted)))
                .OrderBy(x => x.FirstName).ThenBy(x => x.LastName).ToList();
            return new DataSourceResult<CandidateViewModel>
            {
                data = candidates,
                total = candidates.Count
            };
        }

    }
}