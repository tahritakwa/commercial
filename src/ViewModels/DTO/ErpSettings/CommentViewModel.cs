using System;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.ErpSettings
{
    public class CommentViewModel
    {
        public int Id { get; set; }
        public int IdEntityReference { get; set; }
        public int? IdEntityCreated { get; set; }
        public string EmailCreator { get; set; }
        public string Message { get; set; }
        public DateTime? CreationDate { get; set; }
        public bool? IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public string EntityName { get; set; }
        public EntityViewModel IdEntityReferenceNavigation { get; set; }
        public EmployeeViewModel Employee { get; set; }
    }
}
