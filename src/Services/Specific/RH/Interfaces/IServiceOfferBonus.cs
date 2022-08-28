using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceOfferBonus : IService<OfferBonusViewModel, OfferBonus>
    {
        void CheckOfferBonusesPeriodicity(OfferViewModel offer);
    }
}
