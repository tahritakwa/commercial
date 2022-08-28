using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServicePrices : IService<PricesViewModel, Prices>
    {
        PricesViewModel GetSpecificPrice(PriceGetterViewModel model, ItemPriceViewModel itemPriceViewModel=null);
        CurrencyViewModel GetCurrencyByTiers(int idTiers);
        CurrencyRateViewModel GetCurrencyRateByDate(dynamic model);
        object AddModelWithObservationFiles(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        object UpdateModelWithObservationFiles(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        DataSourceResult<TiersViewModel> GetPriceCustomers(PriceAffectionViewModel priceAffectionViewModel);
        DataSourceResult<ItemViewModel> GetPriceItems(PriceAffectionViewModel priceAffectionViewModel);
        void AffectCustomerToPrice(TiersPricesViewModel model, string userMail);
        void AffectItemToPrice(ItemPricesViewModel model, string userMail);
        void UnaffectCustomerFromPrice(TiersPricesViewModel model, string userMail);
        void UnaffectItemFromPrice(ItemPricesViewModel model, string userMail);
        void AffectAllCustomersToPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail);
        void AffectAllItemsToPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail);
        void UnaffectAllCustomersFromPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail);
        void UnaffectAllItemsFromPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail);
        List<DiscountForListViewModel> FindPriceDataSourceModelBy(List<PredicateFormatViewModel> predicateModel);
    }
}
