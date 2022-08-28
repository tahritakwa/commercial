using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Treasury
{
    public class HpsOperationViewModel
    {
        public string AgentCode { get; set; }
        public string Type { get; set; }
        public double amount { get; set; }
    }
}
