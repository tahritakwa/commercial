using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingCenter : Service<TrainingCenterViewModel, TrainingCenter>, IServiceTrainingCenter
    {
        public ServiceTrainingCenter(IRepository<TrainingCenter> entityRepo,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingCenterBuilder builder,
         IRepository<User> entityRepoUser,
         IEntityAxisValuesBuilder builderEntityAxisValues)
         : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        public override object AddModelWithoutTransaction(TrainingCenterViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {    
            if (model.OpeningTime >= model.ClosingTime)
            {
                throw new CustomException(CustomStatusCode.TrainingCenterOpeningTimeLessThanClosingTimeException);
            }
            else
            {
                var duplicatedNames = GetModelsWithConditionsRelations(x => x.Name == model.Name).ToList().Count;
                if (duplicatedNames > NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.DuplicatedTrainingCenterNameException);
                }
                else
                {
                    return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                }

            }
        }
    }
}
