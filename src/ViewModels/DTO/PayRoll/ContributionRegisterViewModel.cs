using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ContributionRegisterViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
    }
}
