using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceAxis : IService<AxisViewModel, Axis>
    {
        Entity GetEntityFromName(string entityName);
        IList<AxisViewModel> GetAxisByEntity(string entityName);
        IList<AxisTreeListViewModel> GetTreeListAxis(int entityId);
        IList<AxisTreeListViewModel> GetAxesHierarchy();
        IList<AxisViewModel> GetEntityAxis(PredicateFormatViewModel predicate);
    }
}
