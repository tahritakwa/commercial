using Persistence.Entities;
using System;
using System.Collections.Generic;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class InterviewBuilder : GenericBuilder<InterviewViewModel, Interview>, IInterviewBuilder
    {
        private readonly ICandidateBuilder _candidateBuilder;
        private readonly IInterviewMarkBuilder _interviewMarkBuilder;
        private readonly IReviewBuilder _reviewBuilder;
        private readonly IExitEmployeeBuilder _employeeExitBuilder;
        private readonly IEmployeeBuilder _employeeBuilder;
        public InterviewBuilder(ICandidateBuilder candidateBuilder,
            IInterviewMarkBuilder interviewMarkBuilder,
            IReviewBuilder reviewBuilder, IExitEmployeeBuilder employeeExitBuilder, IEmployeeBuilder employeeBuilder)
        {
            _candidateBuilder = candidateBuilder;
            _interviewMarkBuilder = interviewMarkBuilder;
            _reviewBuilder = reviewBuilder;
            _employeeExitBuilder = employeeExitBuilder;
            _employeeBuilder = employeeBuilder;
        }

        public override Interview BuildModel(InterviewViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }

            if (model.InterviewMark != null && model.OptionalInterviewMark != null)
            {
                foreach (InterviewMarkViewModel inteviewMark in model.OptionalInterviewMark)
                {
                    model.InterviewMark.Add(inteviewMark);

                }
            }
            model.InterviewDate = new DateTime(model.InterviewDate.Year, model.InterviewDate.Month, model.InterviewDate.Day,
                model.StartTime.Hours, model.StartTime.Minutes, NumberConstant.Zero);

            Interview entity = base.BuildModel(model);

            return entity;
        }

        public override InterviewViewModel BuildEntity(Interview entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }

            InterviewViewModel model = base.BuildEntity(entity);

            if (entity.IdCandidacyNavigation != null && entity.IdCandidacyNavigation.IdCandidateNavigation != null)
            {
                    model.IdCandidacyNavigation.IdCandidateNavigation = _candidateBuilder.BuildEntity(entity.IdCandidacyNavigation.IdCandidateNavigation);
            }
            if (entity.IdExitEmployeeNavigation != null)
            {
                model.IdExitEmployeeNavigation = _employeeExitBuilder.BuildEntity(entity.IdExitEmployeeNavigation);
            }
            if (entity.IdSupervisorNavigation != null)
            {
                model.IdSupervisorNavigation = _employeeBuilder.BuildEntity(entity.IdSupervisorNavigation);
            }
            if (entity.IdReviewNavigation != null)
            {
                model.IdReviewNavigation = _reviewBuilder.BuildEntity(entity.IdReviewNavigation);
            }
            if (entity.InterviewMark != null)
            {
                IList<InterviewMarkViewModel> requiredInterviewMarkList = new List<InterviewMarkViewModel>();
                IList<InterviewMarkViewModel> optionalInterviewMarkList = new List<InterviewMarkViewModel>();
                foreach (InterviewMark inteviewMark in entity.InterviewMark)
                {
                    if (inteviewMark.IsRequired)
                    {
                        requiredInterviewMarkList.Add(_interviewMarkBuilder.BuildEntity(inteviewMark));
                    }
                    else
                    {
                        optionalInterviewMarkList.Add(_interviewMarkBuilder.BuildEntity(inteviewMark));
                    }

                }
                model.InterviewMark = requiredInterviewMarkList;
                model.OptionalInterviewMark = optionalInterviewMarkList;
            }
            model.StartTime = model.InterviewDate.TimeOfDay;

            return model;
        }
    }
}
