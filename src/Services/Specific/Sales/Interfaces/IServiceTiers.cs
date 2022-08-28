using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceTiers : IService<TiersViewModel, Tiers>
    {
        void UpdateContactDocumentTypeRelation(Tiers tiers, string userMail);
        double CalculateTotalAmountOfSalesDelivery(int idTiers);
        void UpdateProvisoanAmountForTier(string generatedConnectionString);
        bool IsAmountGreaterThanCeiling(TiersViewModel tiers, double? amount, string documentType);
        DataSourceResult<TiersViewModel> GetSupplierDropdownList(PredicateFormatViewModel predicateModel, int? idProject);
        IList<ContactViewModel> GetTierContact(int typeTier);
        IList<TiersViewModel> GetByType(int type);
        IList<TiersViewModel> GetTiersListByArray(IEnumerable<int> listTiersId);
        FileInfoViewModel DownloadSupplierExcelTemplate();
        FileInfoViewModel DownloadCustomerExcelTemplate();
        IList<TiersViewModel> GenerateTiersListFromExcel(FileInfoViewModel model, int tiersType);
        TierGeneral GetGeneralTiers(TiersViewModel tier);
        DocumentBriefingViewModel GetLastTierArticles(int idTier);
        List<TierActivityViewModel> GetActivitiesTiers(TiersViewModel tier);
        DataSourceResultWithSelections<TiersViewModel> GetCustomersFillingIsAffectedToPricesWithSpecificFilter
                    (List<PredicateFormatViewModel> predicateModel, int idPrice);
        bool CheckTaxRegistration(CheckTaxRegistrationViewModel model);
        dynamic GetTiersAndInvoiceForGarageInterventionList(IList<int> idTiersList, IList<int?> idDocumentList);
        DataSourceResult<TiersViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel);
        List<SynchronizeBToBTierViewModel> SynchronizeClientBtoB( SynchronizeClientUserBToBViewModel listClientToSynchronize);
        void UpdateClientBtoB( SynchronizeClientUserBToBViewModel listClientToSynchronize);
        NumberFormatOptionsViewModel getFormatOptionsForPurchase(int idTier);
        List<ClientBToBViewModel> SearchTiersBtob(DateTime searchDate);
    }
}
