using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExitEmployee : IService<ExitEmployeeViewModel, ExitEmployee>
    {
        object ValidateExitEmployee(ExitEmployeeViewModel exitEmployeeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings);
        void SendMaterialRecoveryNotification(string connectionString, SmtpSettings smtpSettings);

        void ChooseMethodAccordingToAction(int idAction, ExitEmployeeViewModel model);
        ExitEmployeeViewModel GetEmployeeExitById(int id);
        void ValidateAllExitEmployeePayLine(int id);
    }
}
