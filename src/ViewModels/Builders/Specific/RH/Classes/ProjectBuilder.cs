using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ProjectBuilder : GenericBuilder<ProjectViewModel, Project>, IProjectBuilder
    {
        private readonly ITiersBuilder _tiersBuilder;
        private readonly ICurrencyBuilder _currencyBuilder;

        public ProjectBuilder(ITiersBuilder tiersBuilder, ICurrencyBuilder currencyBuilder)
        {
            _tiersBuilder = tiersBuilder;
            _currencyBuilder = currencyBuilder;
        }

        public override ProjectViewModel BuildEntity(Project entity)
        {
            ProjectViewModel projectViewModel = base.BuildEntity(entity);
            if (projectViewModel.IdTiersNavigation != null)
            {
                projectViewModel.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.IdTiersNavigation);
            }
            if (projectViewModel.IdCurrencyNavigation != null)
            {
                projectViewModel.IdCurrencyNavigation = _currencyBuilder.BuildEntity(entity.IdCurrencyNavigation);
            }
            return projectViewModel;
        }
    }
}
