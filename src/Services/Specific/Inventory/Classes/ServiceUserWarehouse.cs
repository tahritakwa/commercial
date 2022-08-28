using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceUserWarehouse : Service<UserWarehouseViewModel, UserWarehouse>, IServiceUserWarehouse
    {
        private readonly IServiceWarehouse _serviceWarehouse;
        public ServiceUserWarehouse(IRepository<UserWarehouse> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork,
            IUserWarehouseBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IServiceWarehouse serviceWarehouse)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceWarehouse = serviceWarehouse;
        }

        /// <summary>
        /// method update warehouse in user
        /// </summary>
        /// <param name="userEmail"></param>
        /// <param name="idWarehouse"></param>
        public void UpdateUserWarehouse(string userEmail, int? idWarehouse)
        {
            UserWarehouseViewModel userWarehouseViewModel = GetModelAsNoTracked(x => x.UserMail == userEmail);
            if (userWarehouseViewModel != null)
            {
                if (userWarehouseViewModel.IdWarehouse != idWarehouse)
                {
                    if (idWarehouse != null)
                    {
                        userWarehouseViewModel.IdWarehouse = idWarehouse.Value;
                    }
                    else
                    {
                        userWarehouseViewModel.IdWarehouse = null;
                    }
                    UpdateModelWithoutTransaction(userWarehouseViewModel, null, null);
                }
            }
            else
            {
                UserWarehouseViewModel model = new UserWarehouseViewModel
                {
                    IdWarehouse = idWarehouse.Value,
                    UserMail = userEmail
                };
                AddModelWithoutTransaction(model, null, null);
            }

        }

        /// <summary>
        /// method to get warehouse by email 
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public WarehouseViewModel GetWarehouse(string email)
        {
            UserWarehouseViewModel userWarehouse = GetModelAsNoTracked(x => x.UserMail == email);
            WarehouseViewModel warehouse = new WarehouseViewModel();
            if (userWarehouse != null)
            {
                warehouse = _serviceWarehouse.GetModelAsNoTracked(warehouse => warehouse.Id == userWarehouse.IdWarehouse);
            }
            return warehouse;
        }
    }
}

