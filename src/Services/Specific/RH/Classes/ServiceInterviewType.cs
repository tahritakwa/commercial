using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceInterviewType : Service<InterviewTypeViewModel, InterviewType>, IServiceInterviewType
    {
        public ServiceInterviewType(IRepository<InterviewType> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IInterviewTypeBuilder builder,
          IRepository<User> entityRepoUser,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }

        public override object AddModelWithoutTransaction(InterviewTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            InterviewTypeViewModel interviewType = GetModelAsNoTracked(x => x.Label.ToLower() == model.Label.ToLower());

            if(interviewType != null)
            {
                throw new CustomException(CustomStatusCode.AddInterviewTypeException);
            }

            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(InterviewTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            InterviewTypeViewModel interviewType = GetModelAsNoTracked(x => x.Id != model.Id && x.Label.ToLower() == model.Label.ToLower());

            if (interviewType != null)
            {
                throw new CustomException(CustomStatusCode.AddInterviewTypeException);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
