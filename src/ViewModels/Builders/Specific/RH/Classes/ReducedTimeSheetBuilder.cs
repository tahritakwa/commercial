using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReducedTimeSheetBuilder : GenericBuilder<ReducedTimeSheetViewModel, TimeSheet>, IReducedTimeSheetBuilder
    {
        public override TimeSheet BuildModel(ReducedTimeSheetViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException();
            }
            return base.BuildModel(model);
        }
        public override ReducedTimeSheetViewModel BuildEntity(TimeSheet entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            return base.BuildEntity(entity);
        }
    }
}
