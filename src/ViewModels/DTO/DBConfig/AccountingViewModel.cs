using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.DBConfig
{
    public class AccountingViewModel
    {
        public string dataBaseName { get; set; }
        public string companyCode { get; set; }

        public AccountingViewModel(string dataBaseName, string companyCode)
        {
            this.dataBaseName = dataBaseName;
            this.companyCode = companyCode;
        }
    }
}
