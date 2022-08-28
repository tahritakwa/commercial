using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Interfaces
{
    public interface ITimeSheetLineBuilder : IBuilder<TimeSheetLineViewModel, TimeSheetLine>
    {
        IList<ProjectViewModel> BuildProjectDay(IEnumerable<ProjectViewModel> projectViewModel);
        ProjectViewModel BuildProjectDay(ProjectViewModel projectViewModel);
    }
}
