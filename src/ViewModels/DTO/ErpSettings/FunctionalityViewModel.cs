using System;
using System.Collections.Generic;

namespace ViewModels.DTO.ErpSettings
{
    public class FunctionalityViewModel : TranslationViewModel
    {
        public Guid IdFunctionality { get; set; }
        public string FunctionalityName { get; set; }
        public int? IdRequestType { get; set; }
        public RequestTypeViewModel IdRequestTypeNavigation { get; set; }
        public string ApiRole { get; set; }

        public string DefaultRoute { get; set; }
        public bool? IsDefaultRoute { get; set; }
        public ICollection<InformationViewModel> Information { get; set; }

    }
}
