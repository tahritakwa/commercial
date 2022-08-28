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
    public class ServiceDocumentType : Service<DocumentTypeViewModel, DocumentType>, IServiceDocumentType
    {

        internal readonly IRepository<User> _entityRepoUser;
        public ServiceDocumentType(IRepository<DocumentType> entityRepo, IUnitOfWork unitOfWork,
            IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser,
           ITypeDocumentBuilder typeDocumentBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, typeDocumentBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

            _entityRepoUser = entityRepoUser;
        }
    }
}
