using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes.ServiceContract
{
    public partial class ServiceContract
    {
        public void UpdateContractAndRemunerationStateWithSendNotif(string connectionString)
        {
            try
            {
                BeginTransaction(connectionString);
                // Allows to update the state of contracts
                IList<Contract> contracts = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.State != (int)ContractStateEnumerator.Expired,
                    x => x.BaseSalary, x => x.ContractBonus, x => x.ContractBenefitInKind).ToList();
                UpdateContractsState(contracts, withUpdateOperation: true);
                // Send end of contract arrival notifications
                CheckNotifOfEndsContracts();
                EndTransaction();
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }
        }

        /// <summary>
        /// Updates contract states
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="smtpSettings"></param>
        public void UpdateContractsState(IList<Contract> contracts, bool withUpdateOperation = false)
        {
            if (contracts != null)
            {
                contracts.ToList().ForEach(contract =>
                {
                    #region Allows to update the state of contract
                    if (contract.StartDate.Date.AfterDate(DateTime.Today.Date))
                    {
                        contract.State = (int)ContractStateEnumerator.UpComing;
                    }
                    else if (contract.EndDate.HasValue && contract.EndDate.Value.BeforeDate(DateTime.Today.Date))
                    {
                        contract.State = (int)ContractStateEnumerator.Expired;
                    }
                    else
                    {
                        contract.State = (int)ContractStateEnumerator.InProgress;
                    }
                    #endregion
                    #region Allows to update the state of Remuneration contract
                    if (contract.State == (int)ContractStateEnumerator.Expired || contract.State == (int)ContractStateEnumerator.UpComing)
                    {
                        if (contract.BaseSalary != null)
                        {
                            contract.BaseSalary.Select(bs => { bs.State = contract.State; return bs; }).ToList();
                        }
                        if (contract.ContractBonus != null)
                        {
                            contract.ContractBonus.Select(cb => { cb.State = contract.State; return cb; }).ToList();
                        }
                        if (contract.ContractBenefitInKind != null)
                        {
                            contract.ContractBenefitInKind.Select(cb => {  cb.State = contract.State; return cb; }).ToList();
                        }
                    }
                    if (contract.State == (int)ContractStateEnumerator.InProgress)
                    {
                        // Allows to update the state of baseSalary
                        contract.BaseSalary = _serviceBaseSalary.UpdateBaseSalaryState(contract.BaseSalary.ToList());
                        // Allows to update the state of bonus
                        contract.ContractBonus = _serviceContractBonus.UpdateContractsBonusState(contract.ContractBonus.ToList());
                        if (contract.ContractBenefitInKind != null)
                        {
                            //Allows to update the state of benefitInKind
                            contract.ContractBenefitInKind = _serviceContractBenefitInKind.UpdateContractsBenefitInKindState(contract.ContractBenefitInKind.ToList());
                        }
                    }
                    #endregion
                });
                if (withUpdateOperation)
                {
                    _entityRepo.BulkUpdate(contracts);
                    _unitOfWork.Commit();
                }
            }
        }

        /// <summary>
        /// Check Notifications Of Ends Contracts
        /// </summary>
        private void CheckNotifOfEndsContracts()
        {
            List<ContractViewModel> listOfContract = GetModelsWithConditionsRelations(x => x.EndDate.HasValue &&
                DateTime.Today.AddMonths(NumberConstant.One).FirstDateOfMonth().EqualsDate(x.EndDate.Value.FirstDateOfMonth()), x => x.IdEmployeeNavigation).ToList();
            foreach (ContractViewModel contract in listOfContract)
            {
                NotificationItemEndContractViewModel notificationItemEndContractViewModel = new NotificationItemEndContractViewModel()
                {
                    FullName = contract.IdEmployeeNavigation.FullName,
                    DateEndContract = contract.EndDate.Value.ToShortDateString(),
                    IdEmployee = contract.IdEmployee
                };
                _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction("PAYROLL_END_CONTRACT", contract.Id, "",
                    (int)MessageTypeEnumerator.AlertEndContract, null, notificationItemEndContractViewModel);
            }
        }
    }
}
