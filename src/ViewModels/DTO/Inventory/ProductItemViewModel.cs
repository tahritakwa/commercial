using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Inventory
{
    public class ProductItemViewModel : GenericViewModel
    {
        public string CodeProduct { get; set; }
        public string LabelProduct { get; set; }
        public string DeletedToken { get; set; }
        public string UrlPicture { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }

        public ICollection<ItemViewModel> Item { get; set; }

    }
}
