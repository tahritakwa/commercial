using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TrainingSessionBuilder : GenericBuilder<TrainingSessionViewModel, TrainingSession>, ITrainingSessionBuilder
    {
        public override TrainingSessionViewModel BuildEntity(TrainingSession entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            TrainingSessionViewModel model = base.BuildEntity(entity);
            model.NumberOfSeance = NumberConstant.Zero;
            if (entity.TrainingSeance != null)
            {
                var numberOfTrainingSeancesPlannedPerDate = entity.TrainingSeance.ToList().Where(x => x.Date != null && !x.IsDeleted).Count();
                model.NumberOfSeance = numberOfTrainingSeancesPlannedPerDate;
                var trainingSeancesPlannedFrequently = entity.TrainingSeance.ToList().Where(x => x.DayOfWeek != null && !x.IsDeleted);
                if (model.StartDate != null && model.EndDate != null)
                {
                    var daysToPlan = trainingSeancesPlannedFrequently.Select(x => x.DayOfWeek).Distinct();
                    daysToPlan.ToList().ForEach(day =>
                    {
                        var dayOfWorkTrainingSeancesFrequently = entity.StartDate.Value.Date.AllDatesUntilLimitIncluded(entity.EndDate.Value.Date)
                        .Where(x => day == (int)x.DayOfWeek);
                        var trainingSeancePerDay = trainingSeancesPlannedFrequently.ToList().Where(x => x.DayOfWeek == (int)day);
                        model.NumberOfSeance += dayOfWorkTrainingSeancesFrequently.Count() * trainingSeancePerDay.Count();
                    });
                }
                else
                {
                    model.NumberOfSeance += trainingSeancesPlannedFrequently.Count();
                }
            }
            model.NumberOfParticipant = NumberConstant.Zero;
            if (entity.TrainingRequest != null)
            {
                model.NumberOfParticipant = entity.TrainingRequest.Count;
            }
            return model;
        }
    }
}
