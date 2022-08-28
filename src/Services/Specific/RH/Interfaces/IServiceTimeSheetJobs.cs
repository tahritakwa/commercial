using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTimeSheetJobs : IService<TimeSheetViewModel, TimeSheet>
    {
        void SendSubmitTimeSheetNotification(string connectionString, SmtpSettings smtpSettings);
        void SendValidateTimeSheetNotification(string connectionString, SmtpSettings smtpSettings);
    }
}
