using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Treasury.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators.TreasuryEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Classes
{
    public class ServiceOperationCash : Service<OperationCashViewModel, OperationCash>, IServiceOperationCash
    {
        private readonly IRepository<SessionCash> _sessionCashRepo;
        public ServiceOperationCash(IRepository<OperationCash> entityRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            IEntityAxisValuesBuilder builderEntityAxisValues, IOperationCashBuilder builder,
            IRepository<SessionCash> sessionCashRepo) : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _sessionCashRepo = sessionCashRepo;
        }

        public void AddHpsOperation(HpsOperationViewModel model)
        {
            int idSession = 0;
            SessionCash sessionCash = _sessionCashRepo.FindByAsNoTracking(x => x.IdCashRegisterNavigation.AgentCode == model.AgentCode && x.State == (int)CashRegisterStatusEnumerator.Opened).FirstOrDefault();
            if (sessionCash != null)
            {
                idSession = sessionCash.Id;
                OperationCashViewModel operationCashViewModel = new OperationCashViewModel
                {
                    AmountWithCurrency = model.amount,
                    IdSession = idSession,
                    OperationDate = DateTime.Now,
                    AgentCode = model.AgentCode,
                    Type = OperationCashTypeEnum.GetOperationType(model.Type)
                };
                var entity = AddModel(operationCashViewModel,null,"");
            }
        }

        public DataSourceResult<OperationCashViewModel> GetOperationsCash(FilterSearchOperationViewModel model)
        {
            IQueryable<OperationCash> entities = null;
            entities = _entityRepo.GetAllWithConditionsRelationsQueryable(x => true).Include(y => y.IdSessionNavigation);

            entities = SearchTickets(entities, model);
            IList<OperationCash> listOfTickets = new List<OperationCash>();
            if (model.OrderBy.Count > NumberConstant.Zero)
            {
                entities = entities.OrderByRelation(model.OrderBy);

            }
            if (model.page > NumberConstant.Zero && model.pageSize > NumberConstant.Zero)
            {
                listOfTickets = entities.Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
            }
            List<OperationCashViewModel> models = entities.Select(x => _builder.BuildEntity(x)).ToList();
            
            var total = models.Count();

            DataSourceResult<OperationCashViewModel> result = new DataSourceResult<OperationCashViewModel>
            {
                data = models,
                total = total
            };
            return result;
        }
        public IQueryable<OperationCash> SearchTickets(IQueryable<OperationCash> queryItem, FilterSearchOperationViewModel model)
        {
           
            if (model.IdCashRegister != NumberConstant.Zero)
            {
                queryItem = queryItem.Where(x => x.IdSessionNavigation != null && x.IdSessionNavigation.IdCashRegister == model.IdCashRegister);
            }
            return queryItem;
        }
    }
}
