namespace Persistence.Repository.Interfaces
{
    public interface IRepository<TEntity> : IGenericRepository<TEntity>
        where TEntity : class
    {

    }
}
