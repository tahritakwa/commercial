using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceMobilityRequest : IService<MobilityRequestViewModel, MobilityRequest>
    {
        MobilityRequestViewModel GetModelById(int id, string userMail);
        void MobilityRequestValidation(MobilityRequestViewModel model);
    }
}
