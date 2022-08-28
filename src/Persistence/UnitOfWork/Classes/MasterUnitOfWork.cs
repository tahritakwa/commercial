using Persistence.Context;
using Persistence.UnitOfWork.Interfaces;

namespace Persistence.UnitOfWork.Classes
{
    public class MasterUnitOfWork : GenericUnitOfWork, IMasterUnitOfWork
    {
        public MasterUnitOfWork(CatalogContextFactory context)
            : base(context)
        {

        }
    }
}
