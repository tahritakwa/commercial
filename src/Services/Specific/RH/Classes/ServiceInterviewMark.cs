using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceInterviewMark : Service<InterviewMarkViewModel, InterviewMark>, IServiceInterviewMark
    {
        private readonly IRepository<Interview> _interviewEntityRepo;
        private readonly IRepository<Candidacy> _candidacyRepository;
        private readonly IServiceEvaluationCriteria _serviceEvaluationCriteria;
        private readonly IServiceRecruitment _serviceRecruitment;
        private readonly IServiceCriteriaMark _serviceCriteriaMark;
        private readonly IServiceOffer _serviceOffer;

        public ServiceInterviewMark(IRepository<InterviewMark> entityRepo,
          IServiceEvaluationCriteria serviceEvaluationCriteria,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IUnitOfWork unitOfWork,
          IInterviewMarkBuilder builder,
          IRepository<Candidacy> candidacyRepository,
          IServiceRecruitment serviceRecruitment,
          IServiceCriteriaMark serviceCriteriaMark,
          IServiceOffer serviceOffer,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IRepository<Interview> interviewEntityRepo)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _interviewEntityRepo = interviewEntityRepo;
            _serviceEvaluationCriteria = serviceEvaluationCriteria;
            _serviceRecruitment = serviceRecruitment;
            _candidacyRepository = candidacyRepository;
            _serviceCriteriaMark = serviceCriteriaMark;
            _serviceOffer = serviceOffer;
        }

        /// <summary>
        /// Get Interview Mark by Id
        /// </summary>
        /// <param name="idInterviewMark"></param>
        /// <returns></returns>
        public InterviewMarkViewModel GetInterviewMark(int idInterviewMark)
        {
            InterviewMarkViewModel interviewMarkViewModel = GetModelAsNoTracked(iM => iM.Id == idInterviewMark,
                iM => iM.IdEmployeeNavigation, iM => iM.IdInterviewNavigation, iM => iM.CriteriaMark);
            return interviewMarkViewModel;
        }

        /// <summary>
        /// InterviewMark CriteriaMark List initialization
        /// </summary>
        /// <param name="idInterviewMark"></param>
        /// <returns></returns>
        public IList<CriteriaMarkViewModel> GetInterviewMarkCriteriaMarkList(int idInterviewMark)
        {
            List<CriteriaMarkViewModel> interviewMarkIsCriteriaMarkList = _serviceCriteriaMark.GetModelsWithConditionsRelations(x => x.IdInterviewMark == idInterviewMark,
                x => x.IdInterviewMarkNavigation, x => x.IdEvaluationCriteriaNavigation, x => x.IdEvaluationCriteriaNavigation.IdEvaluationCriteriaThemeNavigation).ToList();

            List<EvaluationCriteriaViewModel> evaluationCriteriaList = _serviceEvaluationCriteria.GetAllModels().ToList();

            foreach (EvaluationCriteriaViewModel evaluationCriteriaViewModel in evaluationCriteriaList)
            {
                if(interviewMarkIsCriteriaMarkList.Select(x => x.IdEvaluationCriteria).ToList().Contains(evaluationCriteriaViewModel.Id))
                {
                    interviewMarkIsCriteriaMarkList.FirstOrDefault(x => 
                        x.IdEvaluationCriteria == evaluationCriteriaViewModel.Id).IdEvaluationCriteriaTheme = evaluationCriteriaViewModel.IdEvaluationCriteriaTheme;
                }
                else
                {
                    interviewMarkIsCriteriaMarkList.Add(new CriteriaMarkViewModel
                    {
                        Mark = NumberConstant.Zero,
                        IdEvaluationCriteria = evaluationCriteriaViewModel.Id,
                        IdEvaluationCriteriaNavigation = evaluationCriteriaViewModel,
                        IdInterviewMark = idInterviewMark,
                        IdEvaluationCriteriaTheme = evaluationCriteriaViewModel.IdEvaluationCriteriaTheme
                    });
                }
            }
            return interviewMarkIsCriteriaMarkList.OrderBy(x => x.IdEvaluationCriteriaNavigation.Label).ToList();
        }

        /// <summary>
        /// add criteria marks to this interview mark were mark is different from null and change Recruitment state to selection
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void UpdateInterviewMarkWithCriteriaMark(InterviewMarkViewModel model, string userMail)
        {
            try
            {
                BeginTransaction();

                if(model == null)
                {
                    throw new ArgumentException("");
                }

                IList<OfferViewModel> offerViewModels = _serviceOffer.FindModelBy(
                                                               result => result.IdCandidacy.Equals(model.IdInterviewNavigation.IdCandidacy) &&
                                                               (result.State >= (int)OfferStateEnumerator.Sended)
                                                           ).ToList();

                if (offerViewModels.Any())
                {
                    throw new CustomException(CustomStatusCode.UpdateEvaluationWithSendedOffers);
                }

                if (model.CriteriaMark != null)
                {
                    Candidacy candidacy = _candidacyRepository.GetSingleNotTracked(m => m.Id == model.IdInterviewNavigation.IdCandidacy);
                    int idRecruitment = (int)candidacy.IdRecruitment;
                    RecruitmentViewModel recruitment = _serviceRecruitment.GetModelAsNoTracked((result) => result.Id == idRecruitment);

                    if (recruitment.State == (int)RecruitmentStateEnumerator.Closed)
                    {
                        throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
                    }

                    model.CriteriaMark = model.CriteriaMark.Where(criteriaMark => !criteriaMark.Mark.Value.IsApproximately(0, within: 0.0001)).ToList();
                    model.Mark = 0;
                    foreach (CriteriaMarkViewModel critertiaMark in model.CriteriaMark)
                    {
                        model.Mark += ((critertiaMark.Mark.Value / 6) * 20);

                    }
                    if (model.CriteriaMark.Count != 0)
                    {
                        model.Mark = Math.Round(model.Mark / model.CriteriaMark.Count, 2);
                    }
                    
                    if (recruitment.State < (int)RecruitmentStateEnumerator.Selection)
                    {
                        recruitment.State = (int)RecruitmentStateEnumerator.Selection;
                        _serviceRecruitment.UpdateModelWithoutTransaction(recruitment, null, userMail);
                    }
                    if (candidacy.State < (int)RecruitmentStateEnumerator.Selection)
                    {
                        candidacy.State = (int)RecruitmentStateEnumerator.Selection;
                        _candidacyRepository.Update(candidacy);
                    }


                }

                model.IdInterviewNavigation = null;
                base.UpdateModelWithoutTransaction(model, null, userMail);

                Interview interview = _interviewEntityRepo.GetSingleWithRelationsNotTracked(i => i.Id == model.IdInterview, i => i.InterviewMark);
                interview.InterviewMark = interview.InterviewMark.Where(iM => !iM.Mark.Value.IsApproximately(0, within: 0.0001)).ToList();
                if (interview.InterviewMark != null && interview.InterviewMark.Count != 0)
                {
                    interview.AverageMark = 0;
                    foreach (InterviewMark interviewMark in interview.InterviewMark)
                    { 
                        interview.AverageMark = interview.AverageMark + interviewMark.Mark ;
                    }
                    interview.AverageMark = Math.Round(interview.AverageMark.Value / interview.InterviewMark.Count, 2);
                    interview.InterviewMark = null;
                }
                interview.Status = (int)InterviewEnumerator.InterviewDone;
                _interviewEntityRepo.Update(interview);
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch
            {
                RollBackTransaction();
                throw;
            }
            
        }   

    }
}
