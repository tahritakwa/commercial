using ViewModels.DTO.GenericModel;

namespace ViewModels.Builders.Generic.Interfaces
{
    /// <summary>
    /// Interface IBuilder
    /// </summary>
    /// <typeparam name="TModel">The type of the t model.</typeparam>
    /// <typeparam name="TEntity">The type of the t entity.</typeparam>
    public interface IBuilderMaster<TModel, TEntity> : IBuilder<TModel, TEntity>
            where TModel : GenericMasterViewModel
            where TEntity : class
    {
       
    }
}
