using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceRuleUniqueReference : IService<RuleUniqueReferenceViewModel, RuleUniqueReference>
    {
        string GetReferenceByIdReference(int idReference);
    }
}
