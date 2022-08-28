using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.Shared
{
    public class LanguageViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string DeletedToken { get; set; }
        public ICollection<RecruitmentLanguageViewModel> RecruitmentLanguage { get; set; }

    }
}
