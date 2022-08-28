using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeTeamViewModel : GenericViewModel
    {
        public DateTime? AssignmentDate { get; set; }
        public DateTime? UnassignmentDate { get; set; }
        public int IdEmployee { get; set; }
        public int IdTeam { get; set; }
        public string DeletedToken { get; set; }
        public double AssignmentPercentage { get; set; }
        public bool IsAssigned { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual TeamViewModel IdTeamNavigation { get; set; }
    }
}
