using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceOffice : Service<OfficeViewModel, Office>, IServiceOffice
    {
        private readonly IServiceContact _serviceContact;
        private readonly IRepository<ZipCode> _repoZipCode;

        public ServiceOffice(IRepository<Office> entityRepo, IUnitOfWork unitOfWork,
            IReducedOfficeBuilder reducedBuilder, IServiceContact serviceContact, IServiceProvider serviceProvider,
            IOfficeBuilder officeBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<ZipCode> repoZipCode)
             : base(entityRepo, unitOfWork, officeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceContact = serviceContact;
            _serviceProvider = serviceProvider;
            _repoZipCode = repoZipCode;
        }
        public override OfficeViewModel GetModelById(int id)
        {
            OfficeViewModel office = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.Address).ThenInclude(x => x.IdCountryNavigation)
                .Include(x => x.Address).ThenInclude(x => x.IdCityNavigation)
                .Include(x => x.Address).ThenInclude(x => x.IdZipCodeNavigation)
                .Include(x => x.Contact).ThenInclude(x => x.Phone)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();
            if(office.Contact != null)
            {
                office.Contact = _serviceContact.GetContactsPicture(office.Contact.ToList());
            }
            return office;
        }


        public override object AddModel(OfficeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            ManageOfficeContactPicture(model.Contact);
            AddOrUpdateZipCode(model);
            return base.AddModel(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Add or update zipcode of address
        /// </summary>
        /// <param name="model"></param>
        private void AddOrUpdateZipCode(OfficeViewModel model)
        {
            if (model.Address != null && model.Address.Any(x => x.Region != null || x.CodeZip != null))
            {
                List<AddressViewModel> adress = model.Address.Where(x => x.Region != null || x.CodeZip != null).ToList();
                List<ZipCode> zipCodes = _repoZipCode.GetAllAsNoTracking().ToList();
                List<ZipCode> zipCodesToAdd = new List<ZipCode>();
                adress.ForEach(address =>
                {
                    ZipCode zipCode = zipCodes.Where(x => (address.CodeZip != null ? (x.Code != null ? x.Code.TrimEnd().ToUpper() == address.CodeZip.TrimEnd().ToUpper() : false) : x.Code == null) &&
                        (address.Region != null ? (x.Region != null ? x.Region.ToUpper() == address.Region.ToUpper() : false) : x.Region == null)).FirstOrDefault();
                    if (zipCode != null)
                    {
                        address.IdZipCode = zipCode.Id;
                    }
                    else
                    {
                        ZipCode zipC = new ZipCode
                        {
                            Code = address.CodeZip,
                            Region = address.Region,
                            IdCity = address.IdCity
                        };
                        _repoZipCode.Add(zipC);
                        _unitOfWork.Commit();
                        address.IdZipCode = zipC.Id;
                    }
                });
            }
        }

        public override object UpdateModel(OfficeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {            
            ManageOfficeContactPicture(model.Contact);
            AddOrUpdateZipCode(model);
            return base.UpdateModel(model, entityAxisValuesModelList, userMail);
        }

        private void ManageOfficeContactPicture(ICollection<ContactViewModel> contactList)
        {
            if (contactList != null)
            {
                foreach (ContactViewModel contact in contactList)
                {
                    _serviceContact.ManagePicture(contact);
                }
            }
        }
        public override DataSourceResult<OfficeViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            DataSourceResult<OfficeViewModel> result = base.GetDataWithSpecificFilter(predicateModel);
            foreach (var office in result.data)
            {
                if (office.Address != null  && office.Address.Any())
                {
                    office.City = office.Address.First().IdCityNavigation != null ? office.Address.First().IdCityNavigation.Label : null;
                    office.Country = office.Address.First().IdCountryNavigation != null ? office.Address.First().IdCountryNavigation.NameFr : null;
                }
            }
            return result;
        }
    }
}
