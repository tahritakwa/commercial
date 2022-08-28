using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Immobilisation;

namespace Services.Specific.Immobilisation.Interfaces
{
    public interface IServiceActive : IService<ActiveViewModel, Active>
    {
        DataSourceResult<ActiveViewModel> GetActifsByFiltres(PredicateFormatViewModel predicate);

    }
}
