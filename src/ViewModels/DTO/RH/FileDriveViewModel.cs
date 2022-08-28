using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class FileDriveViewModel : GenericViewModel
    {   public string Name { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreationDate { get; set; }
        public string Type { get; set; }
        public int? IdParent { get; set; }
        public int Size { get; set; }
        public string Path { get; set; }
        public string DeletedToken { get; set; }
        public byte[] Data { get; set; }
        public string FileData { get; set; }
        public IList<FileDriveViewModel> FileDriveInfo { get; set; }
        public UserViewModel CreatedByNavigation { get; set; }
        public FileDriveViewModel IdParentNavigation { get; set; }
        public  ICollection<FileDriveViewModel> InverseIdParentNavigation { get; set; }
        public  ICollection<UserFileAccessViewModel> UserFileAccess { get; set; }
        public ICollection<UserFileModificationViewModel> UserFileModification { get; set; }
    }
}
