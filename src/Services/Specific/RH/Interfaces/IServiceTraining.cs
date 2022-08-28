using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTraining : IService<TrainingViewModel, Training>
    {
        DataSourceResult<TrainingViewModel> GetCatalog(PredicateFormatViewModel predicateModel);
    }
}
