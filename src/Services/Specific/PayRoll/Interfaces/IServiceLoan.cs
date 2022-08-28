using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceLoan : IService<LoanViewModel, Loan>
    {
        void ValidateRequest(LoanViewModel loanViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings);
        double GetNetToPay(LoanViewModel model);
    }
}
