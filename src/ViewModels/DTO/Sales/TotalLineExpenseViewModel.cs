using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class TotalLineExpenseViewModel
    {
        public IList<DocumentExpenseLineViewModel> ExposeLines { get; set; }
        public DateTime DocumentDate { get; set; }

    }
}
