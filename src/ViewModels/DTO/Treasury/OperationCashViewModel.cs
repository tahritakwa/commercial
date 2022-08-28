using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class OperationCashViewModel : GenericViewModel
    {
        public int Type { get; set; }
        public string AgentCode { get; set; }
        public int IdSession { get; set; }
        public DateTime OperationDate { get; set; }
        public double Amount { get; set; }
        public double AmountWithCurrency { get; set; }

        public virtual SessionCashViewModel IdSessionNavigation { get; set; }
    }
}
