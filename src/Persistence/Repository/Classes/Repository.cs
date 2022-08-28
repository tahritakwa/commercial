using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;

namespace Persistence.Repository.Classes
{
    public class Repository<TEntity> : GenericRepository<TEntity>, IRepository<TEntity>
        where TEntity : class
    {
        public Repository(IUnitOfWork unitOfWork)
            : base (unitOfWork)
        {

        }
    }
}
