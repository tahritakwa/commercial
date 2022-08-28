using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SourceDeductionSessionViewModel : GenericViewModel
    {
        public string Title { get; set; }
        public DateTime CreationDate { get; set; }
        public int Year { get; set; }
        public int State { get; set; }
        public string DeletedToken { get; set; }
        public string Code { get; set; }

        public virtual ICollection<SourceDeductionViewModel> SourceDeduction { get; set; }
        public virtual ICollection<SourceDeductionSessionEmployeeViewModel> SourceDeductionSessionEmployee { get; set; }

    }
}
