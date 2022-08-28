using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ParentInChargeViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string FirstName { get; set; }
        public DateTime BirthDate { get; set; }
        public string DeletedToken { get; set; }
        public int IdParentType { get; set; }
        public int IdEmployee { get; set; }
    }
}
