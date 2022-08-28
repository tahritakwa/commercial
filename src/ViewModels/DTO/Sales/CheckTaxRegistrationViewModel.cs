using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{

    public class CheckTaxRegistrationViewModel : GenericViewModel
    {
        public string Value { get; set; }
        public int Type { get; set; }
        public string Code { get; set; }
}
}
