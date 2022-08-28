using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class InterviewMarkBuilder : GenericBuilder<InterviewMarkViewModel, InterviewMark>, IInterviewMarkBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        public InterviewMarkBuilder(IEmployeeBuilder employeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
        }

        public override InterviewMark BuildModel(InterviewMarkViewModel model)
        {
            InterviewMark entity = base.BuildModel(model);
            return entity;
        }

        public override InterviewMarkViewModel BuildEntity(InterviewMark entity)
        {
            InterviewMarkViewModel model = base.BuildEntity(entity);
            if (model == null)
            {
                throw new ArgumentException();
            }
            if (entity != null && entity.IdEmployeeNavigation != null)
            {
                model.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdEmployeeNavigation);
            }

            return model;
        }
    }
}
