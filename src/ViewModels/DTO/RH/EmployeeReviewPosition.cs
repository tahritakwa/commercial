using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.RH
{
    public class EmployeeReviewPosition
    {
        public bool IsManagement { get; set; }
        public bool IsReviewManager { get; set; }
        public bool IshierarchicalSuperior { get; set; }
        public bool IsCollaborator { get; set; }
        public bool IsInterviewer { get; set; }
    }
}
