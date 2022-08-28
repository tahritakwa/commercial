using ViewModels.DTO.GenericModel;

/// <summary>
/// The Builder namespace.
/// </summary>
namespace ViewModels.Builders.Generic.Classes
{
    /// <summary>
    /// Class GenericBuilder.
    /// </summary>
    /// <typeparam name="TModel">The type of the t model.</typeparam>
    /// <typeparam name="TEntity">The type of the t entity.</typeparam>
    /// <seealso cref="IBuilder{TModel,TEntity}" />
    public class GenericBuilderMaster<TModel, TEntity> : GenericBuilder<TModel, TEntity>
    where TModel : GenericMasterViewModel
    where TEntity : class
    {

    }
}
