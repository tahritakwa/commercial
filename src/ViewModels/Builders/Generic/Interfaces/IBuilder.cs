namespace ViewModels.Builders.Generic.Interfaces
{
    /// <summary>
    /// Interface IBuilder
    /// </summary>
    /// <typeparam name="TModel">The type of the t model.</typeparam>
    /// <typeparam name="TEntity">The type of the t entity.</typeparam>
    public interface IBuilder<TModel, TEntity>
            where TModel : class
            where TEntity : class
    {
        /// <summary>
        /// Builds the model.
        /// </summary>
        /// <param name="model">The model.</param>
        /// <returns>TEntity.</returns>
        TEntity BuildModel(TModel model);

        /// <summary>
        /// Builds the entity.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns>TModel.</returns>
        TModel BuildEntity(TEntity entity);
        object MappingEntity(object oldEntity, object newEntity);
        /// <summary>
        /// Build the Master Model from Slave model
        /// </summary>
        /// <param name="slaveModel"></param>
        /// <returns></returns>
        dynamic BuildMasterSlaveModel(dynamic slaveModel, dynamic model);
        /// <summary>
        /// Build the view Model from Drupal model
        /// </summary>
        /// <param name="DrupalModel"></param>
        /// <param name="ViewModel"></param>
        /// <returns></returns>
        dynamic BuildModelFromDrupalModel(dynamic DrupalModel, dynamic ViewModel, dynamic serviceProvider);


    }
}
