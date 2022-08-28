using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ReviewViewModel : GenericViewModel
    {
        public DateTime ReviewDate { get; set; }
        public int IdEmployeeCollaborator { get; set; }
        public int State { get; set; }
        public string DeletedToken { get; set; }
        public int? IdManager { get; set; }
        public int? FormManager { get; set; }
        public int? FormEmployee { get; set; }

        public  EmployeeViewModel IdEmployeeCollaboratorNavigation { get; set; }
        public virtual EmployeeViewModel IdManagerNavigation { get; set; }
        public  ICollection<ObjectiveViewModel> Objective { get; set; }
        public  ICollection<ReviewFormationViewModel> ReviewFormation { get; set; }
        public  ICollection<ReviewResumeViewModel> ReviewResume { get; set; }
        public  ICollection<ReviewSkillsViewModel> ReviewSkills { get; set; }
        public  ICollection<InterviewViewModel> Interview { get; set; }
    }
}
