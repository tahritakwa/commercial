using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceProvisioning : IService<ProvisioningViewModel, Provisioning>
    {
        IList<CreatedDataViewModel> CreateDocument(int idProvision, string userMail);
        IList<ProvisioningDetailsViewModel> GetItemDetails(ProvisioningDetailsViewModel provision);
        CreatedDataViewModel GenerateProvisioning(ProvisioningViewModel provisioning);
        IList<TiersProvisioningViewModel> SupplierTotalRecap(int idProvision, int idProvisionDetail);
        IList<ProvisioningDetailsViewModel> GetEquivalentList(EquivalentItemViewModel equivalentItemViewModel, out int total);
        DataSourceResult<ProvisioningViewModel> ProvisioningList(ProvisionPredicateViewModel previsionPredicate);

        IList<ProvisioningDetailsViewModel> GetItemsWithPaging(int idProvision, PredicateFormatViewModel predicate, out int total);
        ProvisioningViewModel GetProvision(int idProvision);
        void AddEquivalentItemToProvisioningGrid(List<int> idEquivalentItem, int idProvision, int mvtQty);
        void importOrderProject(List<int> idProvisionList, int idProvision);
    }
}

