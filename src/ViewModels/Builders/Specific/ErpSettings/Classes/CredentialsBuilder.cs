using Persistence.Entities;
using Settings.Config;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class CredentialsBuilder : GenericBuilder<CredentialsViewModel, User>, ICredentialsBuilder
    {
    }
}
