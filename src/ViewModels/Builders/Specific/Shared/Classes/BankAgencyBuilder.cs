using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class BankAgencyBuilder : GenericBuilder<BankAgencyViewModel, BankAgency>, IBankAgencyBuilder
    {
        private readonly IContactBuilder _contactBuilder;

        public BankAgencyBuilder(IContactBuilder contactBuilder)
        {
            _contactBuilder = contactBuilder;
        }
        public override BankAgencyViewModel BuildEntity(BankAgency entity)
        {
            var model = base.BuildEntity(entity);
            if (entity.Contact != null && entity.Contact.Count > 0)
            {
                model.Contact = entity.Contact.Select(c => _contactBuilder.BuildEntity(c)).ToList();
            }
            return model;
        }
        public override BankAgency BuildModel(BankAgencyViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.Contact != null)
            {
                entity.Contact = model.Contact.Select(c => _contactBuilder.BuildModel(c)).ToList();
            }
            return entity;
        }
    }
}
