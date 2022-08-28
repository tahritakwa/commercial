using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTimeSheetCountDays : IService<TimeSheetViewModel, TimeSheet>
    {
        Dictionary<double, double> NumberOfDaysWorkedByProjectInTimeSheet(int idTimeSheet, int idProject);
         void CalculateTimeSheetDaysHours(TimeSheetViewModel timeSheetViewModel, bool halfDay, IList<PeriodViewModel> periodViewModels = null, int idProjet = 0);
    }
}
