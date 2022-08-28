using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceAddress : IService<AddressViewModel, Address>
    {
        string AddressBulkAdd(IList<AddressViewModel> address, string property);
        IList<AddressViewModel> GetOfficesAddress(IList<int> addressIdslist);
        string AddressBulkUpdate(IList<AddressViewModel> address, string property);
    }
}
