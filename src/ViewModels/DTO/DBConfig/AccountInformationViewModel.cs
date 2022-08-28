using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.DBConfig
{
    public class AccountInformationViewModel
    {
        public string EmailUser { get; set; }
        public string Password { get; set; }
        public int SubscriptionId { get; set; }

        public AccountInformationViewModel(int SubscriptionId, string EmailUser)
        {
            this.EmailUser = EmailUser;
            this.SubscriptionId = SubscriptionId;
            Password = "00000000";
        }
    }
}
