using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class SearchItemViewModel
    {
        public int Id { get; set; }
        public int IdTiers { get; set; }
        public DateTime? Date { get; set; }
        public int IdCashier { get; set; }
        public string SearchMethod { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public UserViewModel IdCashierNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }

    }
}
