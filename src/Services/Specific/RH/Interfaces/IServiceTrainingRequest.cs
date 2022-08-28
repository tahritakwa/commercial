using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTrainingRequest : IService<TrainingRequestViewModel, TrainingRequest>
    {
        DataSourceResult<TrainingRequestViewModel> GetEmployeeListNotIncludedInTrainingSession(List<int> idEmployeeListInTrainingSession, int idTraining);
        void AddSelectedEmployeesToTrainingRequest(string userMail, IList<TrainingRequestViewModel> trainingRequestList);
        DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListByHierarchy(string userMail, PredicateFormatViewModel predicateModel);
        DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListForPanifing(int idTraining, PredicateFormatViewModel predicate);
        DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListInUpdateMode(int idTraining, int idTrainingSession, PredicateFormatViewModel predicate);

    }
}
