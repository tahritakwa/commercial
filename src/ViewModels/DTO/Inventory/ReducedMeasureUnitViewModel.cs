using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class ReducedMeasureUnitViewModel : GenericViewModel
    {

        public string Label { get; set; }
        public string MeasureUnitCode { get; set; }
        public string Description { get; set; }

        public ReducedMeasureUnitViewModel()
        {
        }

        public ReducedMeasureUnitViewModel(MeasureUnitViewModel idMeasureUnitNavigation) : base(idMeasureUnitNavigation)
        {
            if (idMeasureUnitNavigation != null)
            {
                Label = idMeasureUnitNavigation.Label;
                MeasureUnitCode = idMeasureUnitNavigation.MeasureUnitCode;
                Description = idMeasureUnitNavigation.Description;
            }
        }
    }
}
