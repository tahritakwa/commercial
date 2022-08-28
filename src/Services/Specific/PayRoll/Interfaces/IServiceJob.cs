using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceJob : IService<JobViewModel, Job>
    {
        List<JobViewModel> GetListOfJobs();
        void SynchronizeJobs();
        List<int> GetJobsIdsFromPrivilege(int connectedEmployeeId);
    }
}
