using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class NoteViewModel
    {

        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string Mark { get; set; }
        public int IdEmployee { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int IdCreator { get; set; }

        public virtual UserViewModel IdCreatorNavigation { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }

    }
}
