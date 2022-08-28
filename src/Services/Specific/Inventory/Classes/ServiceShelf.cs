using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceShelf : Service<ShelfViewModel, Shelf>, IServiceShelf
    {
        IServiceStorage _servicesStorage;
        public readonly IRepository<Storage> _entityRepoStorage;
        public ServiceShelf(IRepository<Shelf> entityRepo,
            IUnitOfWork unitOfWork,
            IShelfBuilder builder,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IServiceStorage servicesStorage,
            IRepository<Storage> entityRepoStorage)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _servicesStorage = servicesStorage;
            _entityRepoStorage = entityRepoStorage;
        }

        public object addShelfAndStorage(ShelfViewModel shelf, string userMail)
        {
            CreatedDataViewModel result = null;
            BeginTransaction();
            var storageToAdd = shelf.Storage.First();
            // Check existence of shelf and storage
            if (CheckShelfAndStorageExistenceInWarehouse(shelf))
            {
                throw new CustomException(CustomStatusCode.ShelfAndStorageAlreadyExists);
            }
            ShelfViewModel shelftoupdate = GetAllModelsQueryableWithRelation(x => x.Label == shelf.OldShelfLabel && x.IdWharehouse == shelf.IdWharehouse).AsNoTracking().FirstOrDefault();
            //add new shelf and storage 
            if (shelftoupdate == null)
            {
                result = (CreatedDataViewModel)AddModelWithoutTransaction(shelf, new List<EntityAxisValuesViewModel>(), userMail);
                var storage = _servicesStorage.GetModelAsNoTracked(x => x.IdShelf == storageToAdd.IdShelf);
                if (storage == null)
                {
                    result = (CreatedDataViewModel)_servicesStorage.AddModelWithoutTransaction(storageToAdd, new List<EntityAxisValuesViewModel>(), userMail);
                }
            }
            //update shelf and storage 
            else
            {
                shelftoupdate.Label = shelf.Label;
                result = (CreatedDataViewModel)UpdateModelWithoutTransaction(shelftoupdate, new List<EntityAxisValuesViewModel>(), userMail);
                storageToAdd.IdShelf = shelftoupdate.Id;   
                var storage = _servicesStorage.GetModelAsNoTracked(x=> x.IdShelf == storageToAdd.IdShelf && x.Label == storageToAdd.OldStorageLabel);
                if (storage == null) {
                    result = (CreatedDataViewModel)_servicesStorage.AddModelWithoutTransaction(storageToAdd, new List<EntityAxisValuesViewModel>(), userMail);
                }else
                {
                    storageToAdd.Id = storage.Id;
                    result = (CreatedDataViewModel)_servicesStorage.UpdateModelWithoutTransaction(storageToAdd, new List<EntityAxisValuesViewModel>(), userMail);
                }
            }
            EndTransaction();
            result.EntityName = "SHELFANDSTORAGE";
            return result;
        }

        public List<ShelfViewModel> getShelfsByWarehouse(int idWarehouse)
        {
            var result = _entityRepo.GetAllAsNoTracking().Where(x => x.IdWharehouse == idWarehouse).Include(x => x.Storage).OrderBy(x=> x.Label).ToList();
            return result.Select(c => _builder.BuildEntity(c)).ToList();
        }

        /// <summary>
        /// Check if shelf and storage already exists in warehouse
        /// </summary>
        /// <param name="shelf"></param>
        public bool CheckShelfAndStorageExistenceInWarehouse(ShelfViewModel shelf)
        {
            Storage oldStorage = null;
            Shelf oldShelf = null;
            if (shelf.Id != NumberConstant.Zero)
            {
                oldStorage = _entityRepoStorage.GetSingleWithRelationsNotTracked(x => x.Id == shelf.Id, z => z.IdShelfNavigation);
                oldShelf = oldStorage != null ? oldStorage.IdShelfNavigation : null;
            }
            bool shelfExist = oldShelf != null && (oldShelf.Label != shelf.Label || oldShelf.Storage.FirstOrDefault().Label != shelf.Storage.FirstOrDefault().Label) 
                || shelf.Id == NumberConstant.Zero ? FindModelBy(x => x.IdWharehouse == shelf.IdWharehouse && x.Label == shelf.Label
                        && x.Storage.Any(storage => storage.Label.Equals(shelf.Storage.FirstOrDefault().Label))).Any() : false;
            return shelfExist;
        }
    }
}
