using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq.Expressions;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceContract : IService<ContractViewModel, Contract>
    {
        ContractViewModel GenerateContractFromOffer(OfferViewModel offer);
        void ValidateContractsDates(ContractViewModel contract);
        void ManageEmployeeContracts(EmployeeViewModel model, string userMail, EmployeeViewModel employee);
        void VerifyEmployeeContracts(IList<ContractViewModel> contractsList, string EmployeeFullName);
        void ManageFileContract(ContractViewModel model, string employeeFullName);
        ContractViewModel ContractValidation(ICollection<ContractViewModel> oldContracts, ContractViewModel model);
        void UpdateContractAndRemunerationStateWithSendNotif(string connectionString);
        ObjectToSaveViewModel CheckIfContractsHasAnyPayslipOrTimesheet(IList<Contract> listContracts, DateTime hiringDate);
        void UpdateContractAssociateWithPayslipOrTimesheet(IList<Contract> listContracts, DateTime hiringDate);
        IList<ContractViewModel> GenerateContractListFromExcel(Stream excelDataStream);
        void CheckContractsOverLappingFromExcel(ICollection<ContractViewModel> contracts);
        AttendanceViewModel NumberOfDaysWorkedByContractNotDependOnTimeSheet(ContractViewModel contractViewModel, DateTime month, double daysOfWork, IList<DayOfWeek> DaysOfWeekWorked);
        ObjectToSaveViewModel CheckBeforeUpdateIfContractsHaveAnyPayslipOrTimesheet(IList<Contract> listContracts, bool isFromContract);
        void SetBonusAndBeneFitInKindEndDates(ContractViewModel contract);
        void DeletedAssociateSession(params int[] idsContracts);
        void UpdateContractsState(IList<Contract> contractViewModels, bool withUpdateOperation = false);
        List<Expression<Func<Contract, object>>> PrepareContractPermissionExpression(Expression<Func<Contract, object>> contractBonus);
        void SetContractRemunerationsOldValues(dynamic contract, dynamic oldContract);
    }
}
