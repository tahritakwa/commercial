using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeSkillsViewModel : GenericViewModel
    {
        public int Rate { get; set; }
        public int IdSkills { get; set; }
        public int IdEmployee { get; set; }
        public string DeletedToken { get; set; }

        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual SkillsViewModel IdSkillsNavigation { get; set; }
    }
}
