using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class CaisseViewModel : GenericViewModel
    {
        public string CodeCaisse { get; set; }
        public string Libelle { get; set; }
        public int? IdUser { get; set; }
        public string NameUser { get; set; }
    }
}
