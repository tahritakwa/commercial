using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{
    public class DateToRememberViewModel: GenericViewModel
    {
        public string EventName { get; set; }
        public DateTime? Date { get; set; }
        public int? IdTiers { get; set; }
        public int? IdContact { get; set; }
        public string DeletedToken { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
    }
}