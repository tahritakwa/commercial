using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class DepartmentViewModel : GenericViewModel
    {
        public string DepartmentCode { get; set; }
        public string Name { get; set; }
        public DateTime CreationDate { get; set; }
        public string Domain { get; set; }
        public string DeletedToken { get; set; }
    }
}
