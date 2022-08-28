using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingSeance : Service<TrainingSeanceViewModel, TrainingSeance>, IServiceTrainingSeance
    {
        private readonly IServiceTrainingSession _serviceTrainingSession;
        public ServiceTrainingSeance(IRepository<TrainingSeance> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingSeanceBuilder builder,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceTrainingSession serviceTrainingSession)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceTrainingSession = serviceTrainingSession;
        }

        public dynamic GetTrainingSeanceListInUpdateMode(int idTrainingSession)
        {
            DataSourceResult<TrainingSeanceViewModel> trainingSeancesDataSourceList = new DataSourceResult<TrainingSeanceViewModel>();
            IQueryable<TrainingSeanceViewModel> dataSourceList = base.GetAllModelsQueryable
                ( x => x.IdTrainingSession == idTrainingSession);

            List<TrainingSeanceViewModel> trainingSeances = dataSourceList.ToList();
            List<TrainingSeanceViewModel> trainingSeancesPerDate = new List<TrainingSeanceViewModel>();
            trainingSeancesPerDate = trainingSeances.Where(x => x.DayOfWeek == null).ToList();
            var trainingSeancesPerDay = trainingSeances.Where(x => x.DayOfWeek != null).GroupBy(x => x.DayOfWeek);
            List<TrainingSeanceDayViewModel> trainingSeancesDay = new List<TrainingSeanceDayViewModel>();

            trainingSeancesPerDay.ToList().ForEach((trainingSeancePerDay) => {
                TrainingSeanceDayViewModel trainingSeanceDay = new TrainingSeanceDayViewModel();
                trainingSeanceDay.TrainingSeanceLine = trainingSeancePerDay.ToList();
                trainingSeanceDay.DayOfWeek = (DayOfWeek)trainingSeanceDay.TrainingSeanceLine.First().DayOfWeek;
                trainingSeancesDay.Add(trainingSeanceDay);
                
            });
            dynamic result = new ExpandoObject();
            result.TrainingSeancesDay = trainingSeancesDay;
            result.TrainingSeancesPerDate = trainingSeancesPerDate;

          
            return result;
        }
        
    }
}
