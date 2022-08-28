using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceTaxeGroupTiers : Service<TaxeGroupTiersViewModel, TaxeGroupTiers>, IServiceTaxeGroupTiers
    {
        private readonly IServiceTaxe _serviceTaxe;
        public ServiceTaxeGroupTiers(IRepository<TaxeGroupTiers> entityRepo,
            IUnitOfWork unitOfWork,
            ITaxeGroupTiersBuilder builder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IServiceTaxe serviceTaxe
            )
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceTaxe = serviceTaxe;
        }
        public override IList<TaxeGroupTiersViewModel> GetAllModels()
        {
            var entities = _entityRepo.GetAll().OrderBy(x => x.Label);
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }

        public override object UpdateModel(TaxeGroupTiersViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
        {
            var idsTaxe = model.TaxeGroupTiersConfig.Select(x => x.IdTaxe);
            TaxeViewModel taxeAvance = _serviceTaxe.GetModelAsNoTracked(x => x.CodeTaxe == "TVA_Avance0%");
            if(model.TaxeGroupTiersConfig.Any(x=> x.IdTaxe == taxeAvance.Id) && model.TaxeGroupTiersConfig.Where(x=> x.IdTaxe == taxeAvance.Id).First().Value != 0)
            {
                model.TaxeGroupTiersConfig.Where(x => x.IdTaxe == taxeAvance.Id).First().Value = 0;
            }
            if (idsTaxe.Any() && idsTaxe.Count() != idsTaxe.Distinct().Count())
            {
                throw new CustomException(CustomStatusCode.duplicateTaxe);
            }
            return base.UpdateModel(model, EntityAxisValuesModelList, userMail);
        }

        public override object AddModel(TaxeGroupTiersViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            var idsTaxe = model.TaxeGroupTiersConfig.Select(x => x.IdTaxe);
            if (idsTaxe.Any() && idsTaxe.Count() != idsTaxe.Distinct().Count())
            {
                throw new CustomException(CustomStatusCode.duplicateTaxe);
            }
            return base.AddModel(model, EntityAxisValuesModelList, userMail);
        }
    }
}
