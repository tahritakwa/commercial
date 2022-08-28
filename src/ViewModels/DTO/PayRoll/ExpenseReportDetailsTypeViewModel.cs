using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExpenseReportDetailsTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<ExpenseReportDetailsViewModel> ExpenseReportDetails { get; set; }
    }
}
