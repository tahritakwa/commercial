using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class BankBuilder : GenericBuilder<BankViewModel, Bank>, IBankBuilder
    {

        private readonly IBankAgencyBuilder _bankAgencyBuilder;

        public BankBuilder(IBankAgencyBuilder bankAgencyBuilder)
        {
            _bankAgencyBuilder = bankAgencyBuilder;
        }
        public override BankViewModel BuildEntity(Bank entity)
        {
            var model = base.BuildEntity(entity);
            if (entity.BankAgency != null && entity.BankAgency.Count > 0)
            {
                model.BankAgency = entity.BankAgency.Select(c => _bankAgencyBuilder.BuildEntity(c)).ToList();
            }
            return model;
        }
        public override Bank BuildModel(BankViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.BankAgency != null)
            {
                entity.BankAgency = model.BankAgency.Select(c => _bankAgencyBuilder.BuildModel(c)).ToList();
            }
            return entity;
        }
    }
}
