using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class BillingEmployeeBuilder : GenericBuilder<BillingEmployeeViewModel, BillingEmployee>, IBillingEmployeeBuilder
    {
        private readonly IProjectBuilder _projectBuilder;

        public BillingEmployeeBuilder(IProjectBuilder projectBuilder)
        {
            _projectBuilder = projectBuilder;
        }   

        public override BillingEmployeeViewModel BuildEntity(BillingEmployee entity)
        {
            BillingEmployeeViewModel billingEmployeeViewModel = base.BuildEntity(entity);
            if (entity.IdProjectNavigation != null)
            {
                billingEmployeeViewModel.IdProjectNavigation = _projectBuilder.BuildEntity(entity.IdProjectNavigation);
            }
            return billingEmployeeViewModel;
        }
    }
}
