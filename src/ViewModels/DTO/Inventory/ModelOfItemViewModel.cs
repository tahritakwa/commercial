using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class ModelOfItemViewModel : GenericViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public int IdVehicleBrand { get; set; }
        public string DeletedToken { get; set; }
        public string UrlPicture { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual FileInfoViewModel PictureFileInfo { get; set; }

        public virtual VehicleBrandViewModel IdVehicleBrandNavigation { get; set; }
        public virtual ICollection<SubModelViewModel> SubModel { get; set; }
        public  ICollection<VehicleViewModel> Vehicle { get; set; }

    }
}