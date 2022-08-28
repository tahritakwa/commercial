using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExpenseReport : IService<ExpenseReportViewModel, ExpenseReport>
    {
        double CalculateTotalAmount(IList<ExpenseReportDetailsViewModel> expenseReportDetails);
        DataSourceResult<ExpenseReportViewModel> GetExpenseReportsRequestsWithHierarchy(string userMail, PredicateFormatViewModel predicate, DateTime? month,
            bool onlyFirstLevelOfHierarchy = false);
        void PrepareAndSendMail(MailBrodcastConfigurationViewModel configMail, string userMail, string action,
            ExpenseReportViewModel oldExpenseReport, SmtpSettings smtpSettings);
        object ValidateExpenseReport(ExpenseReportViewModel expenseReportViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        List<ExpenseReportViewModel> GetExpenseFromListId(List<int> listIdExpenses);
        void ValidateMassiveExpenses(List<ExpenseReportViewModel> listOfExpenses, string userMail);
        void DeleteMassiveexpenseReport(List<int> listIdLeaves, string userMail);
        void RefuseMassiveexpenseReport(List<int> listIdLeaves, string userMail);
        FileInfoViewModel DownloadExpenseReportDocumentsWar(int idExpenseReport);

    }
}
