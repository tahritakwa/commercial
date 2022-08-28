using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class FileDriveSharedDocumentViewModel : GenericViewModel
    {
        
        public DateTime? SharingDate { get; set; }
        public string AttachmentUrl { get; set; }
        public int IdEmployee { get; set; }
        
        public string DeletedToken { get; set; }
        public bool EncryptFile { get; set; }

        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public IList<FileDriveViewModel> FilesInfos { get; set; }
        public virtual UserViewModel TransactionUser { get; set; }
    }
}
