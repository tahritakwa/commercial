using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Inventory
{
    public class NatureViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public bool IsStockManaged { get; set; }
        public string DeletedToken { get; set; }
        public string UrlPicture { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public ICollection<ItemViewModel> Item { get; set; }

    }
}
