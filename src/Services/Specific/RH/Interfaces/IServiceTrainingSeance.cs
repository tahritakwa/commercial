using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTrainingSeance : IService<TrainingSeanceViewModel, TrainingSeance>
    {
        dynamic GetTrainingSeanceListInUpdateMode(int idTrainingSession);
    }
}
