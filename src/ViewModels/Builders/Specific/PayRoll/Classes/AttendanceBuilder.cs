using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class AttendanceBuilder : GenericBuilder<AttendanceViewModel, Attendance>, IAttendanceBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        //private readonly ISalaryStructureBuilder _salaryStructureBuilder;
        private readonly IContractTypeBuilder _contractTypeBuilder;

        public AttendanceBuilder(IEmployeeBuilder employeeBuilder,/* ISalaryStructureBuilder salaryStructureBuilder,*/ IContractTypeBuilder contractTypeBuilder)
        {
            _employeeBuilder = employeeBuilder;
            //_salaryStructureBuilder = salaryStructureBuilder;
            _contractTypeBuilder = contractTypeBuilder;
        }

        public override AttendanceViewModel BuildEntity(Attendance entity)
        {
            AttendanceViewModel attendanceViewModel = base.BuildEntity(entity);
            if(attendanceViewModel.IdContractNavigation != null)
            {
                attendanceViewModel.IdContractNavigation.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdContractNavigation.IdEmployeeNavigation);
                //attendanceViewModel.IdContractNavigation.IdSalaryStructureNavigation = _salaryStructureBuilder.BuildEntity(entity.IdContractNavigation.IdSalaryStructureNavigation);
                attendanceViewModel.IdContractNavigation.IdContractTypeNavigation = _contractTypeBuilder.BuildEntity(entity.IdContractNavigation.IdContractTypeNavigation);
            }
            return attendanceViewModel;
        }
    }
}
