using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Interfaces
{
    public interface IServiceOperationCash : IService<OperationCashViewModel, OperationCash> {
        DataSourceResult<OperationCashViewModel> GetOperationsCash(FilterSearchOperationViewModel model);
        void AddHpsOperation(HpsOperationViewModel model);
    }
}
