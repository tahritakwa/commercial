﻿using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceReviewResume : Service<ReviewResumeViewModel, ReviewResume>, IServiceReviewResume
    {
        public ServiceReviewResume(IRepository<ReviewResume> entityRepo,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues,
         IRepository<User> entityRepoUser,
         IUnitOfWork unitOfWork,
         IReviewResumeBuilder builder,
         IEntityAxisValuesBuilder builderEntityAxisValues) :
          base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
