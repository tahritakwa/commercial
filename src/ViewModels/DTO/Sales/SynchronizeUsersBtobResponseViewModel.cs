using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Sales
{
    public class SynchronizeUsersBtobResponseViewModel
    {
        public List<ResponseMailOfUserBtob> listOfSuccess { get; set; }
        public List<ResponseMailOfUserBtob> listOfEchec { get; set; }
    }
}
