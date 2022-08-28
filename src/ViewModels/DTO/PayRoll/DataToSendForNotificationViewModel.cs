using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.PayRoll
{
    public class DataToSendForNotificationViewModel
    {
        public string InformationType { get; set; }
        public int IdEntityReference { get; set; }
        public string CodeEntity { get; set; }
        public int TypeMessage { get; set; }
        public string UserMail { get; set; }
        public dynamic SpecificData { get; set; }
        public List<int> UsersIds { get; set; }
        public string CompanyCode { get; set; }

    }
}
