using System.Collections.Generic;
using ViewModels.DTO.Utils;

namespace ViewModels.DTO.ErpSettings
{
    public class MailBrodcastConfigurationViewModel
    {
        public int IdMsg { get; set; }
        public string URL { get; set; }
        public CreatedDataViewModel Model { get; set; }
        public IList<string> users { get; set; }
    }
}
