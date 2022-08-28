using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.Inventory
{
    public class SubModelViewModel : GenericViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public int IdModel { get; set; }
        public string Deleted_Token { get; set; }
        public string UrlPicture { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual FileInfoViewModel PictureFileInfo { get; set; }

        public virtual ModelOfItemViewModel IdModelNavigation { get; set; }
        public string ModelLabel { get; set; }
    }
}