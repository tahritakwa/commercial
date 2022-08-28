using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class CnssDeclarationDetailsViewModel : GenericViewModel
    {
        public int PageNumber { get; set; }
        public int NumberOrder { get; set; }
        public int IdEmployee { get; set; }
        public double FirstMonthValue { get; set; }
        public double SecondMonthValue { get; set; }
        public double ThirdMonthValue { get; set; }
        public double Total { get; set; }
        public int IdCnssDeclaration { get; set; }
        public string DeletedToken { get; set; }

        public CnssDeclarationViewModel IdCnssDeclarationNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}
