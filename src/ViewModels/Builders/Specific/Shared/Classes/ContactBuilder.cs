using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class ContactBuilder : GenericBuilder<ContactViewModel, Contact>, IContactBuilder
    {
        private readonly IPhoneBuilder _phoneBuilder;

        public ContactBuilder(IPhoneBuilder phoneBuilder)
        {
            _phoneBuilder = phoneBuilder;
        }
        public override Contact BuildModel(ContactViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.CreationDate == null)
            {
                entity.CreationDate = DateTime.Now;
            }
            if (model.Phone != null)
            {
                entity.Phone = model.Phone.Select(c => _phoneBuilder.BuildModel(c)).ToList();
            }
            return entity;
        }

        public override ContactViewModel BuildEntity(Contact entity)
        {

            var model = base.BuildEntity(entity);
            if (entity.Phone != null && entity.Phone.Count > 0)
            {
                model.Phone = entity.Phone.Select(c => _phoneBuilder.BuildEntity(c)).ToList();
            }
            return model;
        }
    }

}
