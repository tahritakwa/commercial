using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ReducedTimeSheetViewModel : GenericViewModel
    {
        public ReducedTimeSheetViewModel()
        {

        }

        public ReducedTimeSheetViewModel(TimeSheetViewModel timeSheetViewModel)
        {
            Id = timeSheetViewModel.Id;
            IdEmployee = timeSheetViewModel.IdEmployee;
            Month = timeSheetViewModel.Month;
            CreationDate = timeSheetViewModel.CreationDate;
            Status = timeSheetViewModel.Status;
            IdEmployeeTreated = timeSheetViewModel.IdEmployeeTreated;
            IdEmployeeNavigation = timeSheetViewModel.IdEmployeeNavigation; 
            IdEmployeeTreatedNavigation = timeSheetViewModel.IdEmployeeTreatedNavigation; 
        }
        public int IdEmployee { get; set; }
        public string DeletedToken { get; set; }
        public DateTime Month { get; set; }
        public DateTime CreationDate { get; set; }
        public int Status { get; set; }
        public int? IdEmployeeTreated { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeTreatedNavigation { get; set; }
    }
}
