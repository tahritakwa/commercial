using System;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Services.Reporting.Interfaces
{
    public interface IDailySalesServiceReporting
    {
        IList<DailySalesLineViewModel> GetDailySalesLines(int idwarehouse, DateTime? startdate, DateTime? endate);
    }
}
