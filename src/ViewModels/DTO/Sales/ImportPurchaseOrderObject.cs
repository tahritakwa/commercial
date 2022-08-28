
using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class ImportDocumentBalancesViewModel
    {
        public List<DocumentViewModel> DocumentsList { get; set; }
        public List<DocumentLineViewModel> BalancesList { get; set; }
    }
}
