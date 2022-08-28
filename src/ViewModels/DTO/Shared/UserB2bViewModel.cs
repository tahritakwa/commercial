using Settings.Config;
using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{

    public class UserB2bViewModel : GenericViewModel
    {

        public string FullName { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Login { get; set; }

        public string Password { get; set; }
        public string NewPassword { get; set; }
        public string Token { get; set; }
        public DateTime? Birthday { get; set; }
        public string Email { get; set; }

        public string WebSite { get; set; }
        public string Lang { get; set; }

        public byte[] Picture { get; set; }
        public string Phone { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }

        public string Language { get; set; }
        public string Message { get; set; }
        public int? IdTiers { get; set; }

        public TiersViewModel IdTiersNavigation { get; set; }
        public B2BSettings B2BSettings { get; set; }
    }
}
