using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceBillingSession : IService<BillingSessionViewModel, BillingSession>
    {
        IList<dynamic> GetTimeSheetDetailsByEmployee(int IdBillingSession);
        BillingSessionViewModel GetBillingSessionDetails(int IdBillingSession);
        DataSourceResult<BillingEmployeeViewModel> GetEmployeesAffectedToBillableProject(DateTime month, PredicateFormatViewModel predicateModel);
        DataSourceResult<DocumentViewModel> GetDocumentsGenerated(PredicateFormatViewModel predicateModel);

    }
}
