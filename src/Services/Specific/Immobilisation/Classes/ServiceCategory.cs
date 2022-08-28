using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Immobilisation.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Immobilisation;

namespace Services.Specific.Immobilisation.Classes
{
    public class ServiceCategory : Service<CategoryViewModel, Category>, IServiceCategory
    {
        public readonly IReducedCategoryBuilder _reducedBuilder;

        public ServiceCategory(IRepository<Category> entityRepo, IUnitOfWork unitOfWork,

          ICategoryBuilder CategoryBuilder, IReducedCategoryBuilder reducedBuilder, IRepository<User> entityRepoUser,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
          IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification)
            : base(entityRepo, unitOfWork, CategoryBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _reducedBuilder = reducedBuilder;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        public override object AddModelWithoutTransaction(CategoryViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // test code unicity
            CategoryViewModel categoryByCode = GetModelAsNoTracked(x => x.Code == model.Code);
            if (categoryByCode != null)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "CODE", model.Code }
                };
                throw new CustomException(CustomStatusCode.CodeUnicity, paramtrs);

            }
            // test label unicity
            CategoryViewModel categoryByLabel = GetModelAsNoTracked(x => x.Label == model.Label);
            if (categoryByLabel != null)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "LABEL", model.Label }
                };
                throw new CustomException(CustomStatusCode.LabelUnicity, paramtrs);
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CategoryViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CategoryViewModel category = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == model.Id)
                                                         .Include(x => x.Active)
                                                         .Select(_builder.BuildEntity)
                                                         .FirstOrDefault();
            if(category.Active != null && category.Active.Any())
            {
                throw new CustomException(CustomStatusCode.UpdateCategoryWithActives);
            }

            // test code unicity
            CategoryViewModel categoryByCode = GetModelAsNoTracked(x => x.Code == model.Code);
            if (categoryByCode != null && categoryByCode.Id != model.Id)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "CODE", model.Code }
                };
                throw new CustomException(CustomStatusCode.CodeUnicity, paramtrs);
            }
            // test label unicity
            CategoryViewModel categoryByLabel = GetModelAsNoTracked(x => x.Label == model.Label);
            if (categoryByLabel != null && categoryByLabel.Id != model.Id)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "LABEL", model.Label }
                };
                throw new CustomException(CustomStatusCode.LabelUnicity, paramtrs);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
