using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace Services.Specific.Helpdesk.Classes
{
    public class ServiceClaimType : Service<ClaimTypeViewModel, ClaimType>, IServiceClaimType
    {
        public ServiceClaimType(IRepository<ClaimType> entityRepo,
            IClaimTypeBuilder claimTypeBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IUnitOfWork unitOfWork,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
            IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, claimTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
        }

        ///// <summary>
        ///// Recuperat elment Related to Id 
        ///// </summary>
        ///// <param name="id"> Id Item</param>
        ///// <returns></returns>
        //public virtual ClaimTypeViewModel GetClaimTypeByCode(string id)
        //{
        //    var relationinclude = new Expression<Func<ClaimType, object>>[]
        //    {
        //        p => p.Claim
        //    };
        //    return GetAllModelsQueryable(x => x.CodeType == id, relationinclude).FirstOrDefault();
        //}


        ///// <summary>
        ///// return list of document where condition
        ///// </summary>
        ///// <param name="predicateModel"></param>
        ///// <returns></returns>
        //public IList<ClaimTypeViewModel> GetClaimType()
        //{
        //    // Get list of Claims type
        //    return base.GetAllModels();
        //}

        ///// <summary>
        ///// return list of document where condition
        ///// </summary>
        ///// <param name="predicateModel"></param>
        ///// <returns></returns>
        //public DataSourceResult<ClaimTypeViewModel> GetClaimTypeList(PredicateFormatViewModel predicateModel)
        //{
        //    // Get list of Claims
        //    DataSourceResult<ClaimTypeViewModel> listOfReclamationType = base.FindDataSourceModelBy(predicateModel);
        //    return listOfReclamationType;
        //}



        //public ClaimTypeViewModel AddClaimType(ClaimTypeViewModel claimTypeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        //{
        //    try
        //    {
        //        BeginTransaction();
        //        if (FindByAsNoTracking(c => c.CodeType == claimTypeViewModel.CodeType).Any())
        //        {
        //            throw new CustomException(CustomStatusCode.AddExistingInventory);
        //        }

        //        var addresult = (CreatedDataViewModel)AddModelWithoutTransaction(claimTypeViewModel, entityAxisValuesModelList, userMail, "ClaimType");
        //        var result = FindByAsNoTracking(c => c.CodeType == claimTypeViewModel.CodeType).FirstOrDefault();
        //        claimTypeViewModel = result;

        //        EndTransaction();
        //        return claimTypeViewModel;

        //    }
        //    catch (CustomException e)
        //    {
        //        RollBackTransaction();
        //        throw e;
        //    }
        //    catch (Exception e)
        //    {
        //        RollBackTransaction();
        //        // thorw the original exception
        //        throw new CustomException(CustomStatusCode.InternalServerError, e);
        //    }
        //}

        //public ClaimTypeViewModel UpdateClaimType(ClaimTypeViewModel claimTypeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        //{
        //    try
        //    {
        //        BeginTransaction();
        //        if (!FindByAsNoTracking(c => c.CodeType == claimTypeViewModel.CodeType).Any())
        //        {
        //            throw new CustomException(CustomStatusCode.AddExistingInventory);
        //        }

        //        UpdateModelWithoutTransaction(claimTypeViewModel, entityAxisValuesModelList, userMail, "ClaimType");
        //        var result = FindByAsNoTracking(c => c.CodeType == claimTypeViewModel.CodeType).FirstOrDefault();
        //        claimTypeViewModel = result;
        //        EndTransaction();
        //        return claimTypeViewModel;

        //    }
        //    catch (CustomException e)
        //    {
        //        RollBackTransaction();
        //        throw e;
        //    }
        //    catch (Exception e)
        //    {
        //        RollBackTransaction();
        //        // thorw the original exception
        //        throw new CustomException(CustomStatusCode.InternalServerError, e);
        //    }
        //}



        //public DataSourceResult<ClaimTypeViewModel> GetTypeDropdownForClaims(PredicateFormatViewModel model)
        //{
        //    var relationinclude = new Expression<Func<ClaimType, object>>[] { p => p.Claim };
        //    var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.IsDeleted == false, relationinclude);
        //    var count = entities.Count();
        //    return new DataSourceResult<ClaimTypeViewModel>
        //    {
        //        data = entities.Select(c => _builder.BuildEntity(c)).ToList(),
        //        total = count
        //    };
        //}

        //public override DataSourceResult<dynamic> GetDataDropdown()
        //{
        //    IEnumerable<dynamic> list = _entityRepo.GetAll().Select(x => _builder.BuildEntity(x));
        //    long total = _entityRepo.GetCount();
        //    return new DataSourceResult<dynamic>
        //    {
        //        data = list.ToList(),
        //        total = total
        //    };
        //}
    }
}
