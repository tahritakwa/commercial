using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;

namespace Persistence.Repository.Classes
{
    public class MasterRepository<TEntity> : GenericRepository<TEntity>, IMasterRepository<TEntity>
        where TEntity : class
    {
        public MasterRepository(IMasterUnitOfWork unitOfWork)
            : base(unitOfWork)
        {

        }
    }
}
