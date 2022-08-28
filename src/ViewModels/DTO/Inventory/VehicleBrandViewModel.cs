using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class VehicleBrandViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Deleted_Token { get; set; }
        public string UrlPicture { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual FileInfoViewModel PictureFileInfo { get; set; }

        public ICollection<ModelOfItemViewModel> Model { get; set; }
        public ICollection<VehicleViewModel> Vehicle { get; set; }
    }
}