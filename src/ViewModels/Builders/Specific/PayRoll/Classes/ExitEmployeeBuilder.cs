using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ExitEmployeeBuilder : GenericBuilder<ExitEmployeeViewModel, ExitEmployee>, IExitEmployeeBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IExitEmailForEmployeeBuilder _employeeExitEmployeeBuilder;
        private readonly IExitActionEmployeeBuilder _actionExitEmployeeBuilder;
        public ExitEmployeeBuilder(IEmployeeBuilder employeeBuilder, IExitEmailForEmployeeBuilder employeeExitEmployeeBuilder,
            IExitActionEmployeeBuilder actionExitEmployeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
            _employeeExitEmployeeBuilder = employeeExitEmployeeBuilder;
            _actionExitEmployeeBuilder = actionExitEmployeeBuilder;
        }
        public override ExitEmployeeViewModel BuildEntity(ExitEmployee entity)
        {
            ExitEmployeeViewModel model = base.BuildEntity(entity);
            if (entity.IdEmployeeNavigation != null)
            {
                model.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdEmployeeNavigation);
            }
            if (entity.ExitEmailForEmployee != null)
            {
                model.ExitEmailForEmployee = entity.ExitEmailForEmployee.Select(_employeeExitEmployeeBuilder.BuildEntity).ToList();
            }
            if (entity.ExitActionEmployee != null)
            {
                model.ExitActionEmployee = entity.ExitActionEmployee.Select(_actionExitEmployeeBuilder.BuildEntity).ToList();
            }
            return model;
        }

       

        }
}
