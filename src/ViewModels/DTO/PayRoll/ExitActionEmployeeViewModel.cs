using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExitActionEmployeeViewModel : GenericViewModel
    {
        public int? IdExitEmployee { get; set; }
        public int? IdExitAction { get; set; }
        public bool VerifyAction { get; set; }
        public string DeletedToken { get; set; }

        public ExitActionViewModel IdExitActionNavigation { get; set; }
        public ExitEmployeeViewModel IdExitEmployeeNavigation { get; set; }

    }
}
