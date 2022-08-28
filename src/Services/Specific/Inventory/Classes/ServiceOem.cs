using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Classes.TecDocFactory;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceOem : Service<OemViewModel, Oem>, IServiceOem
    {
        private readonly IServiceTecDoc _serviceTecDoc;
        public ServiceOem(IRepository<Oem> entityRepo, IUnitOfWork unitOfWork,
          IOemBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IServiceItem serviceItem,
          IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<OtherDataBaseSettings> appSettings)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            TecDocDBFactory tecDocDBFactory = new TecDocDBFactory();
            _serviceTecDoc = tecDocDBFactory.CreateTecDocConnection(serviceItem, appSettings);
        }

        public List<TecDocArticleViewModel> getOemSubs(TeckDockWithWarehouseFilterViewModel TecDocItem)
        {
            var listOem = _serviceTecDoc.GetTecDocByExactOem(TecDocItem);
            var listunsubbed = GetAllModelsQueryable(x => x.OemCode == TecDocItem.oem).ToList();
            var plo = listOem.Where(x => listunsubbed.Any(y => x.Id == y.IdTecDoc)).ToList();
            foreach (var item in listOem.Where(x => listunsubbed.Any(y => y.IdTecDoc.Equals(x.Id)))){
                item.IsUnsubbed = true;
                item.IdOem = listunsubbed.First(y=>y.IdTecDoc==item.Id).Id;
            }
            return listOem;
        }
    }
}
