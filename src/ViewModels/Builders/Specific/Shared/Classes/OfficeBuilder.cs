using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class OfficeBuilder : GenericBuilder<OfficeViewModel, Office>, IOfficeBuilder
    {
        private readonly IAddressBuilder _addressBuilder;
        private readonly IContactBuilder _contactBuilder;


        public OfficeBuilder(IAddressBuilder addressBuilder, IContactBuilder contactBuilder)
        {
            _addressBuilder = addressBuilder;
            _contactBuilder = contactBuilder;
        }
        public override OfficeViewModel BuildEntity(Office entity)
        {
            OfficeViewModel model = base.BuildEntity(entity);

            IList<AddressViewModel> addressViewModel = new List<AddressViewModel>();

            if (model.Address != null)
            {
                foreach (Address address in entity.Address)
                {
                    addressViewModel.Add(_addressBuilder.BuildEntity(address));
                }
                model.Address = addressViewModel;
            }


            IList<ContactViewModel> contractViewModel = new List<ContactViewModel>();
            if (model.Contact != null)
            {
                foreach (Contact contract in entity.Contact)
                {
                    contractViewModel.Add(_contactBuilder.BuildEntity(contract));
                }
                model.Contact = contractViewModel;
            }

            return model;

        }

        public override Office BuildModel(OfficeViewModel model)
        {
            Office office = base.BuildModel(model);
            IList<Contact> contacts = new List<Contact>();
            if (model.Contact != null)
            {
                foreach (ContactViewModel contact in model.Contact)
                {
                    contacts.Add(_contactBuilder.BuildModel(contact));
                }
                office.Contact = contacts;
            }

            return office;
        }

    }
}
