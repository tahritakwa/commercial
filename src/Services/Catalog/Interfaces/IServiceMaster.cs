using Services.Generic.Interfaces;
using ViewModels.DTO.GenericModel;

namespace Services.Catalog.Interfaces
{
    public interface IServiceMaster<TModel, TEntity> : IGenericService<TModel, TEntity>
        where TModel : GenericMasterViewModel
        where TEntity : class
    {

    }
}
