using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceAxisRelationShip : IService<AxisRelationShipViewModel, AxisRelationShip>
    {
        IEnumerable<int> GetAxisChildren(int axisId, List<int> idAxisChildrens);
    }
}
