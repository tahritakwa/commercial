using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class EmployeeProjectViewModel : GenericViewModel
    {
        public DateTime? AssignmentDate { get; set; }
        public DateTime? UnassignmentDate { get; set; }
        public int IdEmployee { get; set; }
        public int IdProject { get; set; }
        public string DeletedToken { get; set; }
        public double? AverageDailyRate { get; set; }
        public bool IsBillable { get; set; }
        public double? AssignmentPercentage { get; set; }
        public string CompanyCode { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ProjectViewModel IdProjectNavigation { get; set; }
    }
}
