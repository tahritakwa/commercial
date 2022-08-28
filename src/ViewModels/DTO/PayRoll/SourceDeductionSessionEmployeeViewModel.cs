using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SourceDeductionSessionEmployeeViewModel : GenericViewModel
    {
        public int IdSourceDeductionSession { get; set; }
        public int IdEmployee { get; set; }
        public string DeletedToken { get; set; }

        public virtual SourceDeductionSessionViewModel IdSourceDeductionSessionNavigation { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}
