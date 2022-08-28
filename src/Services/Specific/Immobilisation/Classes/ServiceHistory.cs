using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Immobilisation.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Immobilisation;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.Immobilisation.Classes
{
    public class ServiceHistory : Service<HistoryViewModel, History>, IServiceHistory
    {
        private readonly IRepository<Employee> _repoEmployee;
        private readonly IEmployeeBuilder _employeeBuilder;
        public ServiceHistory(IRepository<History> entityRepo, IUnitOfWork unitOfWork,
            IHistoryBuilder HistoryBuilder, IRepository<User> entityRepoUser,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Employee> repoEmployee,
            IEmployeeBuilder employeeBuilder)
             : base(entityRepo, unitOfWork, HistoryBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _repoEmployee = repoEmployee;
            _employeeBuilder = employeeBuilder;
        }
        public  override object AddModel(HistoryViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        { 
           EmployeeViewModel employee = _repoEmployee.GetAllWithConditionsRelationsQueryable(x => x.Id == model.IdEmployee)
                                             .Include(x => x.Contract)
                                             .Select(_employeeBuilder.BuildEntity)
                                             .FirstOrDefault();
            employee.Contract.ToList().ForEach( x =>
            {
                // test acquisition date is valid ( between start and end date of contract associated)
                bool acquisitionDateValid = x.StartDate <= model.AcquisationDate && model.AcquisationDate <= x.EndDate;
                if (!acquisitionDateValid)
                {
                    throw new CustomException(CustomStatusCode.AcquisitionDateIsInvalid);
                } 
            });
           
            return base.AddModel(model, null, userMail, property, isFromModal);
        }
    }
}
