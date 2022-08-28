using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceUsersBtob : IService<UsersBtobViewModel, UsersBtob>
    {
        SynchronizeUsersBtobResponseViewModel SynchronizeUserBtoB(List<UsersBtobViewModel> listOfUsers);
        void UpdateUserBtoB(List<UsersBtobViewModel> listOfUsers);
    }
}
