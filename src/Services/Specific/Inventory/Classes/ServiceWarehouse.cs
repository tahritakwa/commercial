using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceWarehouse : Service<WarehouseViewModel, Warehouse>, IServiceWarehouse
    {
        private readonly IReducedWarehouseBuilder _reducedBuilder;
        private readonly IRepository<ItemWarehouse> _entityRepoItemWarehouse;
        private readonly IRepository<User> _entityRepoUser;
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IServiceShelf _serviceShelf;
        public ServiceWarehouse(IRepository<Warehouse> entityRepo,
            IUnitOfWork unitOfWork,
            IWarehouseBuilder builder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IReducedWarehouseBuilder reducedBuilder, IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification, IRepository<ItemWarehouse> entityRepoItemWarehouse,
            IRepository<User> entityRepoUser, IEmployeeBuilder employeeBuilder, IServiceShelf serviceShelf)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _reducedBuilder = reducedBuilder;
            _entityRepoItemWarehouse = entityRepoItemWarehouse;
            _entityRepoUser = entityRepoUser;
            _employeeBuilder = employeeBuilder;
            _serviceShelf = serviceShelf;
        }

        public override object AddModelWithoutTransaction(WarehouseViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                if (model.IdWarehouseParent == null && !model.IsCentral)
                {
                    throw new CustomException(CustomStatusCode.WAREHOUSE_MUST_HAVE_PARENT);
                }
                if (CheckWarehouseNameExistence(model))
                {
                    throw new CustomException(CustomStatusCode.WarehouseMustBeUniqueByWarehouseParent);
                }
                CreatedDataViewModel addedEntity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, EntityAxisValuesModelList, userMail, property);
                var shelf = new ShelfViewModel
                {
                    Id = 0,
                    Label = "AA",
                    IsDefault = true,
                    Storage = new List<ShelfStorageViewModel>() {
                        new ShelfStorageViewModel
                        {
                            Id = 0,
                            Label = "000",
                            IsDefault = true
                        }
                    },
                    IdWharehouse = ((CreatedDataViewModel)addedEntity).Id
                };
                var shel = _serviceShelf.AddModelWithoutTransaction(shelf, null, userMail);
                if(model.IsWarehouse == false)
                {
                    addedEntity.EntityName = "ZONE";
                }
                return addedEntity;

            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception e)
            {
                // thorw the original exception
                throw e;
            }
        }

        /// <summary>
        /// return list of document where condition
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public List<WarehouseViewModel> GetListOfWarehouses(string searchWarehouse)
        {
            // Get list of warehouses
                List<WarehouseViewModel> listOfAllWarehouses = GetAllModelsWithRelations(w => w.IdUserResponsableNavigation, r => r.IdResponsableNavigation).ToList();
            // Get list of warehouse with warehouse children
            List<WarehouseViewModel> listOfHiarchicWarehouses = GetChildrens(listOfAllWarehouses
                .Where(c => c.IdWarehouseParent == null).ToList(), listOfAllWarehouses, searchWarehouse);
            return listOfHiarchicWarehouses;
        }

        /// <summary>
        /// Return the list of warehouse recursively
        /// </summary>
        /// <param name="List"></param>
        /// <param name="ListGlobal"></param>
        /// <returns> the List Component view Model </returns>
        public List<WarehouseViewModel> GetChildrens(List<WarehouseViewModel> List, List<WarehouseViewModel> ListGlobal, string searchWarehouse= null)
        {

            if (List != null)
            {
                foreach (WarehouseViewModel warehouse in List)
                {
                    StringBuilder stringBuilder = new StringBuilder();
                    stringBuilder.Append(warehouse.WarehouseCode).Append(" - ").Append(warehouse.WarehouseName);
                    warehouse.Text = stringBuilder.ToString();
                    if (searchWarehouse.NotNullOrEmpty())
                    {
                        warehouse.Items = ListGlobal.Where(c => c.IdWarehouseParent == warehouse.Id && (c.WarehouseName.ToUpperInvariant().Contains(searchWarehouse.ToUpperInvariant()) || c.WarehouseCode.Contains(searchWarehouse))).ToList();
                    }else
                    {
                        warehouse.Items = ListGlobal.Where(c => c.IdWarehouseParent == warehouse.Id).ToList();
                    }
                   
                    if (!warehouse.Items.Any())
                    {
                        warehouse.Items = null;
                    }
                    else
                    {
                        GetChildrens(warehouse.Items.ToList(), ListGlobal, searchWarehouse);
                    }
                }
            }
            return List;
        }


        /// <summary>
        /// Delete Warehouse
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public void DeleteWarehouse(int id, string tableName, string userMail)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                // Add delete traitment
                DeleteModelwithouTransaction(id, tableName, userMail);
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
        }
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Warehouse> predicateFilterRelationModel)
        {
            IEnumerable<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).OrderBy(x=>x.WarehouseName).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).OrderBy(x => x.WarehouseName).ToList();
            }

            IList<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }

        public Warehouse GetCentralWarehouse()
        {
            return _entityRepo.FindByAsNoTracking(p => p.IsCentral).FirstOrDefault();
        }
        public DataSourceResult<WarehouseViewModel> GetWarehouseForInventory(PredicateFormatViewModel model)
        {
            return new DataSourceResult<WarehouseViewModel>
            {
                data = GetAllModelsQueryable(p => p.IsWarehouse || p.IsCentral).ToList(),
                total = GetAllModelsQueryable(p => p.IsWarehouse || p.IsCentral).Count()
            };
        }

        public DataSourceResult<ReducedWarehouseViewModel> GetWarehouseDropdownForInventory(PredicateFormatViewModel model)
        {
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.IsWarehouse || p.IsCentral).OrderBy(x=> x.WarehouseName);

            return new DataSourceResult<ReducedWarehouseViewModel>
            {
                data = entities.Select(c => _reducedBuilder.BuildEntity(c)).ToList(),
                total = GetAllModelsQueryable(p => p.IsWarehouse || p.IsCentral).Count()
            };
        }

        public DataSourceResult<ReducedWarehouseViewModel> GetWarehouseDropdownForEcommerce(PredicateFormatViewModel model)
        {
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(p => p.ForEcommerceModule);

            return new DataSourceResult<ReducedWarehouseViewModel>
            {
                data = entities.Select(c => _reducedBuilder.BuildEntity(c)).ToList(),
                total = entities.Count()
            };
        }
        public override object UpdateModel(WarehouseViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                var currentWarehouse = GetModelAsNoTracked(x => x.Id == model.Id);
                if(_entityRepoItemWarehouse.QuerableGetAll().Where(x=> x.IdWarehouse == currentWarehouse.Id).Count()>0)
                {
                    if(currentWarehouse.IdWarehouseParent != model.IdWarehouseParent || currentWarehouse.IsWarehouse != model.IsWarehouse)
                    {
                        throw new CustomException(CustomStatusCode.CANNOT_DELETE_WAREHOUSE);
                    }
                }
                // not allowed to change  the code of the warehouse in case it's used
                if (currentWarehouse.WarehouseCode != model.WarehouseCode && _entityRepoItemWarehouse.QuerableGetAll().Where(x => x.IdWarehouse == model.Id).Count() > 0)
                {
                    throw new CustomException(CustomStatusCode.CANNOT_DELETE_WAREHOUSE);
                }

                // not warehouseName must be unique
                if (_entityRepo.QuerableGetAll().Where(x => x.WarehouseName == model.WarehouseName).Count() > 1)
                {
                    throw new CustomException(CustomStatusCode.WAREHOUSE_NAME_MUST_BE_UNIQUE);
                }
                if (model.IdWarehouseParent == null && !model.IsCentral)
                {
                    throw new CustomException(CustomStatusCode.WAREHOUSE_MUST_HAVE_PARENT);
                }

                // get user and assign employeeNavigation to model if exist
                var currentUser = _entityRepoUser.GetAllAsNoTracking().Include(r => r.IdEmployeeNavigation).FirstOrDefault(x => x.Id == model.IdUserResponsable);
                if (currentUser != null && currentUser.IdEmployee > 0)
                {
                    model.IdResponsable = currentUser.IdEmployee;
                }
                return base.UpdateModel(model, entityAxisValuesModelList, userMail);
            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                throw;
            }

        }

        /// <summary>
        /// Check if warehouse name already exists
        /// </summary>
        /// <param name="warehouse"></param>
        /// <returns></returns>
        public bool CheckWarehouseNameExistence(WarehouseViewModel warehouse)
        {
            return warehouse.IdWarehouseParent.HasValue ?
                FindModelBy(x =>  x.IsWarehouse == warehouse.IsWarehouse && x.IdWarehouseParent.Value == warehouse.IdWarehouseParent.Value
                && x.WarehouseName.Trim().ToUpper().Equals(warehouse.WarehouseName.Trim().ToUpper())).Any() : false;
        }
    }
}
