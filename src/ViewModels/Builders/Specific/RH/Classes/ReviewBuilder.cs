using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReviewBuilder : GenericBuilder<ReviewViewModel, Review>, IReviewBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        public ReviewBuilder(IEmployeeBuilder employeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
        }

        public override ReviewViewModel BuildEntity(Review entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            ReviewViewModel model = base.BuildEntity(entity);
            if (entity.IdEmployeeCollaboratorNavigation != null)
            {
                model.IdEmployeeCollaboratorNavigation = _employeeBuilder.BuildEntity(entity.IdEmployeeCollaboratorNavigation);   
            }
            if (entity.IdManagerNavigation != null)
            {
                model.IdManagerNavigation = _employeeBuilder.BuildEntity(entity.IdManagerNavigation);
            }
            return model;
        }
    }
}
