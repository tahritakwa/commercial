using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.DTO.Immobilisation;

namespace ViewModels.Builders.Specific.Immobilisation.Classes
{
    public class ActiveBuilder : GenericBuilder<ActiveViewModel, Active>, IActiveBuilder
    {
        public override ActiveViewModel BuildEntity(Active entity)
        {
            ActiveViewModel model = base.BuildEntity(entity);
            return model;
        }

    }
}
