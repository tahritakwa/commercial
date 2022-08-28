using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceTranslation : IService<FunctionalityViewModel, Functionality>
    {
        string GetLanguage(string lang, string directoryConfig);
        string getCurrentConnectedCompany();
    }
}
