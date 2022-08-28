using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class CriteriaMarkBuilder : GenericBuilder<CriteriaMarkViewModel, CriteriaMark>, ICriteriaMarkBuilder
    {

        public override CriteriaMarkViewModel BuildEntity(CriteriaMark entity)
        {
            return base.BuildEntity(entity);
        }
    }
}
