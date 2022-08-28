using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceInformation : IService<InformationViewModel, Information>
    {
        IList<dynamic> GetTargetedUsers(TargetUserViewModel targetUserViewModel);
        IList<User> GetTargetedUsersByInformation(int IdInformation, int? idUser = null);
    }
}
