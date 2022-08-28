using Persistence.Entities;
using Settings.Config;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Utils;

namespace ViewModels.Builders.Specific.ErpSettings.Interfaces
{
    public interface ICredentialsBuilder : IBuilder<CredentialsViewModel, User>
    {
    }
}
