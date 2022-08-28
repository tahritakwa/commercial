using Persistence.Entities;
using System.Text;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.Immobilisation;

namespace ViewModels.Builders.Specific.Immobilisation.Classes
{
    public class HistoryBuilder : GenericBuilder<HistoryViewModel, History>, IHistoryBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        public HistoryBuilder(IEmployeeBuilder employeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
        }
        public override HistoryViewModel BuildEntity(History entity)
        {
            if (entity != null)
            {
                HistoryViewModel model = base.BuildEntity(entity);

                if (entity.IdEmployeeNavigation != null)
                {
                    StringBuilder fullName = new StringBuilder();
                    model.IdEmployeeNavigation.FullName = fullName.Append(model.IdEmployeeNavigation.FirstName).Append(" ").Append(model.IdEmployeeNavigation.LastName).ToString();
                }
                return model;
            }
            return null;
        }
    }
}
