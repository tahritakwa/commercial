using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSalaryStructure : IService<SalaryStructureViewModel, SalaryStructure>
    {
        SalaryStructureViewModel GetStructureSalaryByIdContract(int idContract);
        SalaryStructureViewModel GetSalaryStructureWithSalaryRules(int idSalaryStructure);
        IList<Payslip> CheckIfSalaryStructureIsAssociatedWithAnyPayslip(SalaryStructureViewModel salaryStructureViewModel, SalaryStructureViewModel salaryStructureBeforeUpdate = null);
    }
}
