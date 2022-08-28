using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class NewUserEmailViewModel : GenericViewModel
    {
        public int IdUser { get; set; }
        public int IdEmail { get; set; }
        public string DeletedToken { get; set; }
        public virtual EmailViewModel IdEmailNavigation { get; set; }
        public virtual UserViewModel IdUserNavigation { get; set; }
    }
}
