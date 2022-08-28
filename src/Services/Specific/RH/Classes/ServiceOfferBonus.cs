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
    public class ServiceOfferBonus : Service<OfferBonusViewModel, OfferBonus>, IServiceOfferBonus
    {
        public ServiceOfferBonus(IRepository<OfferBonus> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            IOfferBonusBuilder builder, IRepository<User> entityRepoUser, IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        /// <summary>
        /// Check if there is an overlap between offer bonues
        /// </summary>
        /// <param name="offer"></param>
        public void CheckOfferBonusesPeriodicity(OfferViewModel offer)
        {
            // Group offer bonuses by IdBonus
            IEnumerable<IGrouping<int, OfferBonusViewModel>> groupedOfferBonuses = offer.OfferBonus.GroupBy(m => m.IdBonus);
            groupedOfferBonuses.ToList().ForEach(offerBonuses =>
            {
                // If any offer bonus startValidity date is less than the startDate of the offer, throw exception
                OfferBonusViewModel wrongOfferBonus = offerBonuses.FirstOrDefault(m => !m.IsDeleted && m.ValidityStartDate.Date.CompareTo(offer.StartDate.Date) < NumberConstant.Zero);
                if (wrongOfferBonus != null)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { Constants.CONTRACT_BONUS_START_DATE,  wrongOfferBonus.ValidityStartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)},
                            { Constants.START_DATE, offer.StartDate.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.AddContractBonusException, paramtrs);
                }
                // Check if there is more than one contractBonus with no ValidityEndDate
                if (offerBonuses.Count(x => !x.IsDeleted && !x.ValidityEndDate.HasValue) > NumberConstant.One)
                {
                    throw new CustomException(CustomStatusCode.MultipleContractOrOfferBonuesesWithoutEndDate);
                }
                // Check if there is an onverlap between contract bonuses
                if (offerBonuses.Count() > NumberConstant.One && offerBonuses.Any(m => !m.IsDeleted && offerBonuses.Any(n => !n.IsDeleted && !m.Equals(n) && (
                       (m.ValidityEndDate.HasValue &&
                           (n.ValidityEndDate.HasValue &&
                                   (n.ValidityEndDate.Value.BetweenDateLimitNotIncluded(m.ValidityStartDate, m.ValidityEndDate.Value)
                                || (n.ValidityStartDate.BetweenDateLimitIncluded(m.ValidityStartDate, m.ValidityEndDate.Value) && n.ValidityEndDate.Value.BetweenDateLimitIncluded(m.ValidityStartDate, m.ValidityEndDate.Value))
                                || (n.ValidityStartDate.BeforeDateLimitIncluded(m.ValidityStartDate) && n.ValidityEndDate.Value.AfterDateLimitIncluded(m.ValidityEndDate.Value)))
                                || n.ValidityStartDate.BetweenDateLimitNotIncluded(m.ValidityStartDate, m.ValidityEndDate.Value)
                           ))
                       || (!m.ValidityEndDate.HasValue && (n.ValidityStartDate.AfterDate(m.ValidityStartDate) || (n.ValidityEndDate.HasValue && n.ValidityEndDate.Value.AfterDate(m.ValidityStartDate))))
                       || m.ValidityStartDate.EqualsDate(n.ValidityStartDate)
                       ))))
                {
                    throw new CustomException(CustomStatusCode.OverlapOfSameBonusInContractOrOffer);
                }
            });
        }
    }
}
