using Persistence.Context;
using Persistence.UnitOfWork.Interfaces;

namespace Persistence.UnitOfWork.Classes
{
    public class UnitOfWork : GenericUnitOfWork, IUnitOfWork
    {
        public UnitOfWork(StarkContextFactory context)
            : base(context)
        {

        }
    }
}
