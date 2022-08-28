using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Interfaces
{
    public interface IServiceReconciliation : IService<ReconciliationViewModel, Reconciliation>
    {
        void CashSettlements(ReconciliationViewModel model, List<int> settlementIds, string userMail);
    }
}
