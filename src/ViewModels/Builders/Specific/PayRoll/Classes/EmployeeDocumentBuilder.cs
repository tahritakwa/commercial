using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class EmployeeDocumentBuilder : GenericBuilder<EmployeeDocumentViewModel, EmployeeDocument>, IEmployeeDocumentBuilder
    {
        public override EmployeeDocument BuildModel(EmployeeDocumentViewModel model)
        {
            EmployeeDocument employeeDocument = base.BuildModel(model);
            return employeeDocument;
        }
    }
}
