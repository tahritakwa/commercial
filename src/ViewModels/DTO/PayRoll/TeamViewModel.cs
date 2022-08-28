using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class TeamViewModel : GenericViewModel
    {
        public string TeamCode { get; set; }
        public string Name { get; set; }
        public int IdManager { get; set; }
        public int? IdDepartment { get; set; }
        public int? IdTeamType { get; set; }

        public DateTime CreationDate { get; set; }
        public bool State { get; set; }
        public string DeletedToken { get; set; }
        public int? NumberOfAffected { get; set; }

        public DepartmentViewModel IdDepartmentNavigation { get; set; }
        public EmployeeViewModel IdManagerNavigation { get; set; }
        public ICollection<EmployeeViewModel> Employee { get; set; }

        public ICollection<EmployeeTeamViewModel> EmployeeTeam { get; set; }
        public TeamTypeViewModel IdTeamTypeNavigation { get; set; }


    }
}
