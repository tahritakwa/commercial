using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Interfaces
{
    public interface IReducedJobBuilder : IBuilder<ReducedJobViewModel, Job>
    {
    }
}
