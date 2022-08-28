using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Inventory
{
    public class FamilyViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Deleted_Token { get; set; }
        public string UrlPicture { get; set; }
        public int? IdCategoryEcommerce { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual FileInfoViewModel PictureFileInfo { get; set; }

        public virtual ICollection<SubFamilyViewModel> SubFamily { get; set; }
    }
}