using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Treasury.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Classes
{
    public class ServiceDetailTimetable : Service<DetailTimetableViewModel, DetailTimetable>, IServiceDetailTimetable
    {
        public ServiceDetailTimetable(IRepository<DetailTimetable> entityRepo,
              IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,              IDetailTimetableBuilder builder,
              IRepository<User> entityRepoUser,
              IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }



    }
}
