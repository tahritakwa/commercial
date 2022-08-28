using System;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Services.Specific.BToB.interfaces
{
    public interface IServiceBToBShared
    {
        IList<VehicleBrandViewModel> GetVehiculeBrand(DateTime searchDate, string connectionString);
        IList<FamilyViewModel> GetFamilyList(DateTime searchDate, string connectionString);
        IList<ModelOfItemViewModel> GetModelOfItemList(DateTime searchDate, string connectionString);
        IList<SubModelViewModel> GetSubModelList(DateTime searchDate, string connectionString);
        IList<SubFamilyViewModel> GetSubFamilyList(DateTime searchDate, string connectionString);
        IList<ProductItemViewModel> GetProductItemList(DateTime searchDate, string connectionString);
    }
}
