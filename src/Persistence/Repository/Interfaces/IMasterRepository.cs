namespace Persistence.Repository.Interfaces
{
    public interface IMasterRepository<TEntity> : IGenericRepository<TEntity>
        where TEntity : class
    {

    }
}
