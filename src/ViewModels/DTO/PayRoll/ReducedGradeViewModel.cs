using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedGradeViewModel : GenericViewModel
    {
        public string Designation { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
    }
}
