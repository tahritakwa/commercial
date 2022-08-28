using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceSalesPrice : Service<SalesPriceViewModel, SalesPrice>, IServiceSalesPrice
    {
        public ServiceSalesPrice(IRepository<SalesPrice> entityRepo, IUnitOfWork unitOfWork,
           ISalesPriceBuilder salesPriceBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, salesPriceBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
        /// <summary>
        /// UpdateModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="EntityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        public override object UpdateModel(SalesPriceViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
        {
            CheckUpdateModel(model);
            var obj = base.UpdateModel(model, EntityAxisValuesModelList, userMail);
            return obj;
        }
        public void CheckUpdateModel(SalesPriceViewModel model)
        {
            SalesPriceViewModel oldModel = GetModelAsNoTracked(x => x.Id == model.Id);
            if (oldModel.Code != model.Code)
            {
                throw new CustomException(CustomStatusCode.CannotChangeStockManagedFromProductType);
            }
        }
    }
}
