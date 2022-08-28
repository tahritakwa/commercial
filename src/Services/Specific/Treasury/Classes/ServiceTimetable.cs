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
    public class ServiceTimetable : Service<TimetableViewModel, Timetable>, IServiceTimetable
    {
        public ServiceTimetable(IRepository<Timetable> entityRepo,
              IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,              ITimetableBuilder builder,
              IRepository<User> entityRepoUser,
              IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }



    }
}
