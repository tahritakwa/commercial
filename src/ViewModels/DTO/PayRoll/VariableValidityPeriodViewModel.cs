using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class VariableValidityPeriodViewModel : GenericViewModel
    {
        public DateTime StartDate { get; set; }
        public string Formule { get; set; }
        public string DeletedToken { get; set; }
        public int IdVariable { get; set; }
        public int? State { get; set; }

        public virtual VariableViewModel IdVariableNavigation { get; set; }
    }
}
