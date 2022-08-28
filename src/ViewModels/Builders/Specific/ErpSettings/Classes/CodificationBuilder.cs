using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class CodificationBuilder : GenericBuilder<CodificationViewModel, Codification>, ICodificationBuilder
    {

        public override CodificationViewModel BuildEntity(Codification entity)
        {
            CodificationViewModel codificationViewModel = new CodificationViewModel();
            codificationViewModel = base.BuildEntity(entity);
            if (entity.IdCodificationParentNavigation != null)
            {
                codificationViewModel.IdCodificationParentNavigation = BuildEntity(entity.IdCodificationParentNavigation);
            }
            return codificationViewModel;
        }
    }


}

