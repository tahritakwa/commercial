using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Treasury;

namespace ViewModels.Builders.Specific.Treasury.Interfaces
{
    public interface IOperationCashBuilder : IBuilder<OperationCashViewModel, OperationCash>
    {
    }
}
