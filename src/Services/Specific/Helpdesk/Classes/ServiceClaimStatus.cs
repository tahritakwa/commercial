using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Helpdesk.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Utils;

namespace Services.Specific.Helpdesk.Classes
{
    public class ServiceClaimStatus : Service<ClaimStatusViewModel, ClaimStatus>, IServiceClaimStatus
    {
        public readonly IClaimStatusBuilder _entityBuilder;

        public ServiceClaimStatus(IRepository<ClaimStatus> entityRepo,
            IClaimStatusBuilder claimStatusBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IUnitOfWork unitOfWork,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
            IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, claimStatusBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityBuilder = claimStatusBuilder;
            _entityRepoEntity = entityRepoEntity;
        }

        /// <summary>
        /// Recuperat elment Related to Id 
        /// </summary>
        /// <param name="id"> Id Item</param>
        /// <returns></returns>
        public virtual ClaimStatusViewModel GetClaimStatusById(int id)
        {
            var relationinclude = new Expression<Func<ClaimStatus, object>>[]
            {
                p => p.Claim
            };
            return GetAllModelsQueryable(x => x.Id == id, relationinclude).FirstOrDefault();
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<ClaimStatusViewModel> GetClaimStatusList(PredicateFormatViewModel predicateModel)
        {
            // Get list of Claims status
            DataSourceResult<ClaimStatusViewModel> listOfReclamationStatus = base.FindDataSourceModelBy(predicateModel);
            return listOfReclamationStatus;
        }



        public ClaimStatusViewModel AddClaimStatus(ClaimStatusViewModel claimStatusViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                if (FindByAsNoTracking(c => c.Id == claimStatusViewModel.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.AddExistingInventory);
                }

                var addresult = (CreatedDataViewModel)AddModelWithoutTransaction(claimStatusViewModel, entityAxisValuesModelList, userMail, "ClaimType");
                var result = FindByAsNoTracking(c => c.Id == claimStatusViewModel.Id).FirstOrDefault();
                claimStatusViewModel = result;

                EndTransaction();
                return claimStatusViewModel;

            }
            catch (CustomException e)
            {
                RollBackTransaction();
                throw e;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                // thorw the original exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        public ClaimStatusViewModel UpdateClaimStatus(ClaimStatusViewModel claimStatusViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                if (!FindByAsNoTracking(c => c.Id == claimStatusViewModel.Id).Any())
                {
                    throw new CustomException(CustomStatusCode.AddExistingInventory);
                }

                UpdateModelWithoutTransaction(claimStatusViewModel, entityAxisValuesModelList, userMail, "ClaimType");
                var result = FindByAsNoTracking(c => c.Id == claimStatusViewModel.Id).FirstOrDefault();
                claimStatusViewModel = result;
                EndTransaction();
                return claimStatusViewModel;

            }
            catch (CustomException e)
            {
                RollBackTransaction();
                throw e;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                // thorw the original exception
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }



        public DataSourceResult<ClaimStatusViewModel> GetStatusDropdownForClaims(PredicateFormatViewModel model)
        {
            var relationinclude = new Expression<Func<ClaimStatus, object>>[] { p => p.Claim };
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.IsDeleted == false, relationinclude);
            var count = entities.Count();
            return new DataSourceResult<ClaimStatusViewModel>
            {
                data = entities.Select(c => _builder.BuildEntity(c)).ToList(),
                total = count
            };
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            IEnumerable<dynamic> list = _entityRepo.GetAll().Select(x => _builder.BuildEntity(x));
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }
    }
}
