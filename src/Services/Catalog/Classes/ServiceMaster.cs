using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.MasterConfig;

namespace Services.Catalog.Classes
{
    public abstract partial class ServiceMaster<TModel, TEntity> : GenericService<TModel, TEntity>
        where TModel : GenericMasterViewModel
        where TEntity : class
    {
        //Generic Parameters
        protected readonly IBuilder<TModel, TEntity> _builderMaster;
        //File Parameters
        protected readonly MasterAppSettings _masterAppSettings;
               
        //generic Contractor with File
        protected ServiceMaster(IMasterRepository<TEntity> entityRepo,
            IMasterUnitOfWork unitOfWork,
            IBuilder<TModel, TEntity> builder,
            IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork)
        {
            _builder = builder;
            _builderEntityAxisValues = builderEntityAxisValues;
            _entityRepoEntityAxisValues = entityRepoEntityAxisValues;
            _builderMaster = builder;
        }
    }
}
