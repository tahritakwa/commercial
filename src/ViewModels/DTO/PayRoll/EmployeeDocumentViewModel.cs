using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeDocumentViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public int IdEmployee { get; set; }
        public int Type { get; set; }
        public string Value { get; set; }
        public string AttachedFile { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public bool IsPermanent { get; set; }
        public string DeletedToken { get; set; }
        public IList<FileInfoViewModel> AttachedFileInfo { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}