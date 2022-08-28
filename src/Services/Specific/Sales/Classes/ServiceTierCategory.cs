using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceTierCategory : Service<TierCategoryViewModel, TierCategory>, IServiceTierCategory
    {

        public ServiceTierCategory(IRepository<TierCategory> entityRepo, IUnitOfWork unitOfWork,
            ITierCategoryBuilder TierCategoryBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification
            )
            : base(entityRepo, unitOfWork, TierCategoryBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity,
                  entityRepoEntityCodification, entityRepoCodification){ }


    }
}
