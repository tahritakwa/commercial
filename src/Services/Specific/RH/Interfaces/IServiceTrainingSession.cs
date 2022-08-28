using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTrainingSession : IService<TrainingSessionViewModel, TrainingSession>
    {
        DataSourceResult<TrainingSessionViewModel> GetTrainingSessionList(PredicateFormatViewModel predicateModel);
        void AddTrainingRequestToTrainingSession(string userMail,int idTraining, IList<TrainingRequestViewModel> trainingRequestList);
        void UpdateTrainingRequestToTrainingSession(string userMail, int idTrainingSession,
          IEnumerable<TrainingRequestViewModel> newTrainingRequestSelectedList, IEnumerable<TrainingRequestViewModel> trainingRequestSelectedToUnSelectedList);
        void AddTrainingSeancesWithTrainingSession(string userMail, int idTraining, IEnumerable<TrainingSeanceViewModel> traningSeancesPerDate,
                IEnumerable<TrainingSeanceDayViewModel> trainingSeancesFrequently);
        void UpdateTrainingSeancesWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession,
         IEnumerable<TrainingSeanceViewModel> traningSeancesPerDate, IEnumerable<TrainingSeanceDayViewModel> trainingSeancesFrequently);
        void AddExternalTrainingWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession, int idRoom, List<int> idSelectedEmployee);
        void UpdateExternalTrainingWithTrainingSession(string userMail, TrainingSessionViewModel trainingSession, int idRoom, ExternalTrainingViewModel externalTraining,
            List<int> idSelectedEmployee);
    }
}
