using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class CnssDeclarationSessionViewModel : GenericViewModel
    {
        public int IdSession { get; set; }
        public int IdCnssDeclaration { get; set; }
        public string DeletedToken { get; set; }

        public CnssDeclarationSessionViewModel IdCnssDeclarationNavigation { get; set; }
        public SessionViewModel IdSessionNavigation { get; set; }
    }
}
