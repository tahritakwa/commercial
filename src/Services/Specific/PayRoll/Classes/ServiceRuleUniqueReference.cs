using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceRuleUniqueReference : Service<RuleUniqueReferenceViewModel, RuleUniqueReference>, IServiceRuleUniqueReference
    {
        public ServiceRuleUniqueReference(IRepository<RuleUniqueReference> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,            IRuleUniqueReferenceBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues )
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        public string GetReferenceByIdReference(int idReference)
        {
            return _entityRepo.GetSingle(r => r.Id == idReference).Reference;
        }
    }
}
