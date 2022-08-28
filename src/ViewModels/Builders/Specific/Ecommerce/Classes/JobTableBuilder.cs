using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.DTO.Ecommerce;

namespace ViewModels.Builders.Specific.Ecommerce.Classes
{
    public class JobTableBuilder : GenericBuilder<JobTableViewModel, JobTable>, IJobTableBuilder
    {

    }
}
