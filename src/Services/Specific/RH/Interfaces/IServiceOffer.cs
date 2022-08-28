using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceOffer : IService<OfferViewModel, Offer>
    {
        EmailViewModel GenerateOfferEmailByOffer(OfferViewModel offer, string lang, string userMail);
        OfferViewModel GetOfferWithHisNavigations(int id);
        OfferViewModel AcceptTheOffer(OfferViewModel model, string userMail);
        OfferViewModel RejectTheOffer(OfferViewModel model, string userMail);
        OfferViewModel UpdateOfferAfterEmailSend(OfferViewModel model, string userMail);
        int ConfirmOfferFromLink(string connectionString, string token);

    }
}
