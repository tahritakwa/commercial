using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class GeneralSettingsBuilder : GenericBuilder<GeneralSettingsViewModel, GeneralSettings>, IGeneralSettingsBuilder
    {
    }
}
