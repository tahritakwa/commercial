using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class RuleUniqueReferenceViewModel : GenericViewModel
    {
        public string Reference { get; set; }
        public int Type { get; set; }
        public string DeletedToken { get; set; }
    }
}
