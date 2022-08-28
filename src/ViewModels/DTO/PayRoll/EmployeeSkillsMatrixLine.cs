using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeSkillsMatrixLine
    {
        public string Team { get; set; }
        public EmployeeViewModel Employee { get; set; }
        public IDictionary<int, int> Skills { get; set; }
    }
}
