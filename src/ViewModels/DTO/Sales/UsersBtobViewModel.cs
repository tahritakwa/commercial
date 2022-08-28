using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Sales
{
    public class UsersBtobViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public string TransactionUserEmail { get; set; }
        public string Email { get; set; }
        public string FullName { get; set; }
        public int IdClient { get; set; }
        public virtual TiersViewModel IdClientNavigation { get; set; }
    }
}
