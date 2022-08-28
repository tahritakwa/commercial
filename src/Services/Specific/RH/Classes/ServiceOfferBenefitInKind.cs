using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceOfferBenefitInKind : Service<OfferBenefitInKindViewModel, OfferBenefitInKind>, IServiceOfferBenefitInKind
    {
        public ServiceOfferBenefitInKind(IRepository<OfferBenefitInKind> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IOfferBenefitInKindBuilder builder,
          IRepository<User> entityRepoUser,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        /// <summary>
        /// Check Offer benefits in kind validity
        /// </summary>
        /// <param name="offer"></param>
        public void CheckOfferBenefitsInKind(OfferViewModel offer)
        {
            // Check benefits in kind periodicity
            List<OfferBenefitInKindViewModel> offersBenefits = offer.OfferBenefitInKind.Where(x => !x.IsDeleted).ToList();
            offersBenefits.ForEach(offerBenefits =>
            {
                // If offer benefit in kind start date isn't included in offer period
                if (offerBenefits.ValidityStartDate.Date.BeforeDate(offer.StartDate.Date) || (offer.EndDate.HasValue && offerBenefits.ValidityStartDate.Date.AfterDate(offer.EndDate.Value.Date)))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.START_DATE, offerBenefits.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.OfferBenefitInKindStartDateException, paramtrs);
                }
                // If offer benefit in kind start date is greater than offer benefit in kind expiration date
                if (offerBenefits.ValidityEndDate.HasValue && offerBenefits.ValidityEndDate.Value.Date.BeforeDate(offerBenefits.ValidityStartDate.Date))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.START_DATE, offerBenefits.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)},
                        { Constants.END_DATE, offerBenefits.ValidityEndDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.OfferBenefitInKindStartDateGreaterThanExpirationDateException, paramtrs);
                }
                // If offer benefit in kind expiration date isn't included in offer period
                if (offerBenefits.ValidityEndDate.HasValue && ((offer.EndDate.HasValue && offerBenefits.ValidityEndDate.Value.Date.AfterDate(offer.EndDate.Value.Date))
                        || offerBenefits.ValidityEndDate.Value.Date.BeforeDate(offer.StartDate.Date)))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.END_DATE, offerBenefits.ValidityEndDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.OfferBenefitInKindExpirationDateException, paramtrs);
                }
            });
        }
    }
}
