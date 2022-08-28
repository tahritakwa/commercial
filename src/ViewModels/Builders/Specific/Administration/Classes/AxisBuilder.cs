using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;

namespace ViewModels.Builders.Specific.Administration.Classes
{
    public class AxisBuilder : GenericBuilder<AxisViewModel, Axis>, IAxisBuilder
    {
        readonly AxisValueBuilder axisValueBuilder = new AxisValueBuilder();
        public override Axis BuildModel(AxisViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.AxisValue != null)
            {
                entity.AxisValue = model.AxisValue.Select(c => axisValueBuilder.BuildModel(c)).ToList();
            }
            return entity;
        }
    }
}
