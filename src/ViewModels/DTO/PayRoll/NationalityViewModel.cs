using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class NationalityViewModel : GenericViewModel
    {
        public string CountryCode { get; set; }
        public string Name { get; set; }
        public int PhoneCode { get; set; }
        public string DeletedToken { get; set; }
    }
}
