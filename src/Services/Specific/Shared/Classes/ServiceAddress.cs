using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceAddress : Service<AddressViewModel, Address>, IServiceAddress
    {
        public ServiceAddress(IRepository<Address> entityRepo, IUnitOfWork unitOfWork,
            IAddressBuilder addressBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, addressBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
        public string AddressBulkAdd(IList<AddressViewModel> address, string property = null)
        {
            IList<Address> AddressList = new List<Address>();
            address.ToList().ForEach(model =>
            {
                AddressList.Add(_builder.BuildModel(model));
            });
            // add entity
            string AddressIds = string.Empty;
            _entityRepo.BulkAdd(AddressList);
            // commit
            _unitOfWork.Commit();
            AddressList.ToList().ForEach(entity =>
            {
                AddressIds = AddressIds + entity.Id.ToString() + GenericConstants.Point;
            });
            return AddressIds;
        }
        public IList<AddressViewModel> GetOfficesAddress(IList<int> addressIdslist)
        {
            return FindModelsByNoTracked(x => addressIdslist.Contains(x.Id), x => x.IdCountryNavigation, x => x.IdCityNavigation);
        }
        public string AddressBulkUpdate(IList<AddressViewModel> address, string property = null)
        {
            List<Address> AddressList = new List<Address>();
            address.ToList().ForEach(model =>
            {
                AddressList.Add(_builder.BuildModel(model));
            });
            string addressIds = string.Empty;
            // add entity
            _entityRepo.BulkUpdate(AddressList);
            // commit
            _unitOfWork.Commit();
            AddressList = AddressList.Where(x => !x.IsDeleted).ToList();
            AddressList.ToList().ForEach(entity =>
            {
                addressIds = addressIds + entity.Id.ToString() + GenericConstants.Point;
            });
            return addressIds;
        }
    }
}
