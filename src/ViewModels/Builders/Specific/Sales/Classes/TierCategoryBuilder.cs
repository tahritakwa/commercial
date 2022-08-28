using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class TierCategoryBuilder : GenericBuilder<TierCategoryViewModel, TierCategory>, ITierCategoryBuilder
    {
      
    }
}
