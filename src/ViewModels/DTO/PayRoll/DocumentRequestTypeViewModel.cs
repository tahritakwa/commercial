using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class DocumentRequestTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }
    }
}
