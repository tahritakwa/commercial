using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{


    public class ServiceGrade : Service<GradeViewModel, Grade>, IServiceGrade
    {
        public readonly IReducedGradeBuilder _reducedBuilder;

        public ServiceGrade(IRepository<Grade> entityRepo, IReducedGradeBuilder reducedBuilder,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
 IGradeBuilder builder,
        IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser, IEntityAxisValuesBuilder builderEntityAxisValues )
        : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _reducedBuilder = reducedBuilder;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }
    }
}
