using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceEntityAxisValues : IService<EntityAxisValuesViewModel, EntityAxisValues>
    {
        void AddRangeEntityAxisValue(IList<EntityAxisValuesViewModel> model, int id);
        void UpdateRangeEntityAxisValue(IList<EntityAxisValuesViewModel> model, int id);
    }
}
