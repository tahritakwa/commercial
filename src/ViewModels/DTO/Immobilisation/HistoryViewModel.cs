using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.Immobilisation
{
    public class HistoryViewModel : GenericViewModel
    {

        public int? IdEmployee { get; set; }
        public int? IdActive { get; set; }
        public DateTime? AcquisationDate { get; set; }
        public DateTime? AbandonmentDate { get; set; }
        public string DeletedToken { get; set; }

        public ActiveViewModel IdActiveNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}
