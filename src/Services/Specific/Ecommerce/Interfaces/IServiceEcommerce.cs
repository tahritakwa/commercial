using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace Services.Specific.Ecommerce.Interfaces
{
    public interface IServiceEcommerce : IService<JobTableViewModel, JobTable>
    {
        Task EcommerceGetDeliveryForms(string connectionString);
        Task GetAndUpdateAddedProductsFromEcommerce(string connectionString);
        Task<string> EcommerceMovement(string json);
        Task<DataSourceResult<ClientViewModel>> GetEcommerceCustomerListAsync(PredicateFormatViewModel predicateModel);
        Task<bool> ChangePremuimEcommerceCustomerAsync(int id, bool isPremium);

        Task<string> SynchonizeIsEcommerceOfProductsAsync(string connectionString, string stringData,
           List<ItemViewModel> addItemViewModels, List<ItemViewModel> editItemViewModels, List<ItemViewModel> editOldItemViewModels,
           ProductsIntListViewModel updateEditProductsToIsEcommerce, ProductsIntListViewModel updateEditProductsToNotIsEcommerce);

        Task<string> SynchronizeAllProductsDetailsAsync(string connectionString, string stringData, List<ItemViewModel> itemViewModels);

        void UpdateIsEcommerceOfProducts(string connectionString, string result, List<ItemViewModel> addItemViewModels, List<ItemViewModel> editItemViewModels,
            List<ItemViewModel> editOldItemViewModels, ProductsIntListViewModel productsIntListIsEcommerce,
            ProductsIntListViewModel productsIntListNotIsEcommerce);

        void UpdateAllProductsDetails(string connectionString, string json_response, List<ItemViewModel> itemViewModels);
        ProductViewModel ConvertProductToJson(ItemViewModel item, bool isEcommerce);
        Task<string> GetHttpResponseFromRequest(HttpMethod post, Uri uri, string content, List<ItemViewModel> listProducts);
        Task<int> getFailedSalesDeliveryCountAsync();
        Task<List<OrderMagentoViewModel>> getFailedSalesDeliveryDetailsAsync();
        Task<string> SynchronizeWithEcommerce(List<int> listidItem);
        void MagentoResponseData(ResponseSynchronizedProductViewModel responseSynchronizedProduct);
        Task AddTotalShipment(DocumentViewModel document);
        Task AddInvoice(DocumentViewModel document);
        Task AddCategoryFromMagento(FamilyViewModel familyModel);
        Task UpdateCategoryFromMagento(FamilyViewModel categoryModel);
        Task AddSubCategoryFromMagento(SubFamilyViewModel familySubModel);
        Task UpdateSubCategoryFromMagento(SubFamilyViewModel familySubModel);
    }
}
