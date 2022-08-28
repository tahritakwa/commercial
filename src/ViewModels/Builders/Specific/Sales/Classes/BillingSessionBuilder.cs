using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class BillingSessionBuilder : GenericBuilder<BillingSessionViewModel, BillingSession>, IBillingSessionBuilder
    {
        public override BillingSessionViewModel BuildEntity(BillingSession entity)
        {
            BillingSessionViewModel billingsessionViewModel = base.BuildEntity(entity);
            if (billingsessionViewModel.State == (int)BillingSessionStateViewModel.Closed)
            {
                billingsessionViewModel.CanDelete = false;
                billingsessionViewModel.CanEdit = false;
            }
            return billingsessionViewModel;
        }
    }
}
