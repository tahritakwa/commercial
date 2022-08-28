using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceBaseSalary : IService<BaseSalaryViewModel, BaseSalary>
    {
        double GetBaseSalary(PayslipViewModel payslipViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked, bool forPreview = false);
        IList<BaseSalary> UpdateBaseSalaryState(IList<BaseSalary> baseSalarys);
    }
}
