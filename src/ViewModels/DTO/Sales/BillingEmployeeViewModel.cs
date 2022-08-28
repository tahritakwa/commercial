using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.Sales
{
    public class BillingEmployeeViewModel : GenericViewModel
    {
        public int IdBillingSession { get; set; }
        public int IdEmployee { get; set; }
        public int IdTimeSheet { get; set; }
        public int IdProject { get; set; }
        public bool IsChecked { get; set; }
        public IList<AdrDetail> AdrDetails { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }
        public string DeletedToken { get; set; }
        public BillingSessionViewModel IdBillingSessionNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ProjectViewModel IdProjectNavigation { get; set; }
        public TimeSheetViewModel IdTimeSheetNavigation { get; set; }
    }
}
