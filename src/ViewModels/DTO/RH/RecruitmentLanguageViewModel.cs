using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class RecruitmentLanguageViewModel : GenericViewModel
    {
        public int IdRecruitment { get; set; }
        public int IdLanguage { get; set; }
        public string DeletedToken { get; set; }
        public int Rate { get; set; }

        public LanguageViewModel IdLanguageNavigation { get; set; }
        public RecruitmentViewModel IdRecruitmentNavigation { get; set; }
    }
}
