using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceGeneralSettings : IService<GeneralSettingsViewModel, GeneralSettings>
    {
        List<GeneralSettingsViewModel> GetReviewManagerSettings();
        object updateReviewManagerSettings(List<GeneralSettingsViewModel> models, string userMail);
    }
}
