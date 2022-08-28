using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeSkillsMatrixFilter
    {
        public int IdTeam { get; set; }
        public List<int> EmployeesId { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public List<SkillsRating> SkillsLevels { get; set; }
    }
}
