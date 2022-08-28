using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class JobEmployeeBuilder : GenericBuilder<JobEmployeeViewModel, JobEmployee>, IJobEmployeeBuilder
    {
        private readonly IJobBuilder _jobBuilder;
        public JobEmployeeBuilder(IJobBuilder jobBuilder)
        {
            _jobBuilder = jobBuilder;
        }

        public override JobEmployeeViewModel BuildEntity(JobEmployee entity)
        {

            JobEmployeeViewModel model = base.BuildEntity(entity);
            if (entity.IdJobNavigation != null)
            {
                if (entity.IdJobNavigation.InverseIdUpperJobNavigation != null)
                {
                    model.IdJobNavigation.InverseIdUpperJobNavigation = entity.IdJobNavigation.InverseIdUpperJobNavigation.Select(x => _jobBuilder.BuildEntity(x)).ToList();
                }
            }
            return model;
        }
    }
}
