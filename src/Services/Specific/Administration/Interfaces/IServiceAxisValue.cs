using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceAxisValue : IService<AxisValueViewModel, AxisValue>
    {
        List<AxisValueViewModel> GetAxisValueByAxis(int idAxis, string[] listIdAxisValue = null);
        IList<EntityAxisValuesViewModel> GetAxisValueByEntity(int idEntity, string tableName);
    }
}
