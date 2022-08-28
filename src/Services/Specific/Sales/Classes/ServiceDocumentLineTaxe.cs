using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceDocumentLineTaxe : Service<DocumentLineTaxeViewModel, DocumentLineTaxe>, IServiceDocumentLineTaxe
    {
        internal readonly IRepository<User> _entityRepoUser;
        public ServiceDocumentLineTaxe(IRepository<DocumentLineTaxe> entityRepo,
            IUnitOfWork unitOfWork,
            IRepository<User> entityRepoUser,
            IDocumentLineTaxeBuilder builder, 
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }
    }
}