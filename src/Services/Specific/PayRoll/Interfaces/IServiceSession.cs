using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSession : IService<SessionViewModel, Session>
    {
        SessionViewModel GetSessionDetails(int IdSession);
        dynamic GetSessionBonusByIdBonus(int IdSession);
        IList<SessionViewModel> SessionOfTrimester(PredicateFormatViewModel predicate, DateTime dateTime);
        IList<SalaryRuleViewModel> GetAvailableSalaryRulesForResume(int idSession);
        DataSourceResult<EmployeeResumeLine> GetSessionResume(SessionResumeFilter sessionResumeFilter);
        IEnumerable<SessionResumeLineViewModel> GetSessionResumeReportLines(int IdSession);
        List<SessionViewModel> SessionsWithEmployeesWithTransferPaymentType(DateTime month);
        void CloseSession(SessionViewModel model);
        ReturnedDataSessionViewModel GetListOfAvailableEmployeesByContracts(PredicateFormatViewModel predicate, int idSession);
        ObjectToSaveViewModel AddContractToSession(int idContract, int idSession, int idSelected, int idTimeSheet);
        IList<int> AddAllContractsToSession(PredicateFormatViewModel predicate, bool allSelected, int idSession);
        ReturnedDataAttendanceViewModel GetListOfAttendances(PredicateFormatViewModel predicate, int idSession);
        ReturnedDataBonusViewModel GetListOfBonusesForSession(PredicateFormatViewModel predicate, int idSession);
        IList<int> AddBonusToAllContracts(PredicateFormatViewModel predicate, bool allSelected, int idSession, int idBonus, double value);
        void BonusUpdatePayslipsTreatement(int idSession, IList<SessionBonus> sessionBonus);
        void AddBonusToContract(int idContract, int idSession, int idSelected, int idBonus, double value);
        void UpdateBonusType(int idSession, int idBonus, int idOldBonus);
        ObjectToSaveViewModel CheckBonusExistanceInSession(int idSession, int idBonus);
        void DeleteBonusFromSession(int idSession, int idBonus);
        ReturnedDataLoanViewModel GetListOfLoanInstallmentForSession(PredicateFormatViewModel predicate, int idSession);
        void AddLoanInstallmentToSession(int idContract, int idSession, int idSelected, int idLoanInstallment, double value);
        void AddAllLoanInstallmentToSession(PredicateFormatViewModel predicate, bool allSelected, int idSession);
        void UpdateAllBonusValues(int idSession, int idBonus, double value);
        void UpdateSessionStates(SessionViewModel model);
    }
}
