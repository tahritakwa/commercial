using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class SharedDocumentViewModel : GenericViewModel
    {
        public DateTime SubmissionDate { get; set; }
        public int IdEmployee { get; set; }
        public string AttachmentUrl { get; set; }
        public int? IdType { get; set; }
        public bool EncryptFile { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public DocumentRequestTypeViewModel IdTypeNavigation { get; set; }
        public IList<FileInfoViewModel> FilesInfos { get; set; }
        public UserViewModel TransactionUser { get; set; }
    }
}
