using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Treasury;

namespace ViewModels.Builders.Specific.Treasury.Classes
{
    public class OperationCashBuilder: GenericBuilder<OperationCashViewModel, OperationCash>, IOperationCashBuilder
    {
    }
}
