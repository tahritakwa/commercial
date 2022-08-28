using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Classes
{
    public class ServiceAxisRelationShip : Service<AxisRelationShipViewModel, AxisRelationShip>, IServiceAxisRelationShip
    {       
        public ServiceAxisRelationShip(IRepository<AxisRelationShip> entityRepo, IUnitOfWork unitOfWork,
           IAxisRelationShipBuilder entityBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="axisId"></param>
        /// <param name="idAxisChildrens"></param>
        /// <returns></returns>
        public IEnumerable<int> GetAxisChildren(int axisId, List<int> idAxisChildrens)
        {
            List<AxisRelationShipViewModel> listAxisRs = FindModelBy(x => x.IdAxisParent == axisId).ToList();
            idAxisChildrens.AddRange(listAxisRs.Select(x => x.IdAxis));
            foreach (int axisCh in listAxisRs.Select(x => x.IdAxis))
            {
                GetAxisChildren(axisCh, idAxisChildrens);
            }
            return idAxisChildrens.Distinct();
        }
    }
}
