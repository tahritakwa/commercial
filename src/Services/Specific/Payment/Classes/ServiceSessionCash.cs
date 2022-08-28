using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.TreasuryEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServiceSessionCash : Service<SessionCashViewModel, SessionCash>, IServiceSessionCash
    {
        private readonly IRepository<CashRegister> _repoCashRegister;
        private readonly IRepository<User> _repoUser;
        private readonly IRepository<Ticket> _ticketRepo;
        private readonly IRepository<TicketPayment> _ticketPaymentRepo;
        private readonly IRepository<Settlement> _settlementRepo;
        public ServiceSessionCash(IRepository<SessionCash> entityRepo, IUnitOfWork unitOfWork,
           ISessionCashBuilder CashRegisterBuilder,
            IRepository<Entity> entityRepoEntity, IRepository<Codification> entityRepoCodification, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<CashRegister> repoCashRegister, IRepository<User> repoUser, IRepository<Ticket> ticketRepo, IRepository<TicketPayment> ticketPaymentRepo,
           IRepository<Settlement> settlementRepo)
            : base(entityRepo, unitOfWork, CashRegisterBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity,
                 entityRepoEntityCodification, entityRepoCodification)
        {
            _repoCashRegister = repoCashRegister;
            _repoUser = repoUser;
            _ticketRepo = ticketRepo;
            _ticketPaymentRepo = ticketPaymentRepo;
            _settlementRepo = settlementRepo;
        }

        public override object AddModel(SessionCashViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();
                CashRegister cashRegister = _repoCashRegister.FindBy(x => x.Id == model.IdCashRegister).FirstOrDefault();
                var existUserSession = GetModel(x => x.IdSeller == model.IdSeller && x.State == (int)CashRegisterStatusEnumerator.Opened);
                if (existUserSession != null)
                {
                    throw new CustomException(CustomStatusCode.USER_ALREADY_HAS_CASH_SESSION);
                }
                // add sessionCash
                object session = AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                // update cashRegister
                cashRegister.Status = (int)CashRegisterStatusEnumerator.Opened;
                _repoCashRegister.Update(cashRegister);
                _unitOfWork.Commit();
                EndTransaction();
                return session;
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // throw the error
                VerifyDuplication(e);
                throw;
            }
        }

        public override object UpdateModel(SessionCashViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                CashRegister cashRegister = _repoCashRegister.FindBy(x => x.Id == model.IdCashRegister).FirstOrDefault();
                // get sessionCash
                var sessionCash = GetModelAsNoTracked(x => x.Id == model.Id);
                sessionCash.ClosingAmount = model.ClosingAmount;
                sessionCash.ClosingCashAmount = model.ClosingCashAmount;
                sessionCash.CalculatedTotalAmount = model.CalculatedTotalAmount;
                sessionCash.ClosingDate = model.ClosingDate;
                sessionCash.State = (int)CashRegisterStatusEnumerator.Closed;
                // update sessionCash
                var addedEntity = UpdateModelWithoutTransaction(sessionCash, entityAxisValuesModelList, userMail);
                // update cashRegister
                cashRegister.Status = (int)CashRegisterStatusEnumerator.Closed;
                _repoCashRegister.Update(cashRegister);
                _unitOfWork.Commit();
                EndTransaction();
                return addedEntity;
            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw exception
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }

        public SessionCashViewModel GetOpenedSession(string email)
        {

            User user = _repoUser.FindSingleBy(x => x.Email == email);
            return GetModelsWithConditionsRelations(x => x.State == (int)CashRegisterStatusEnumerator.Opened && x.IdSeller == user.Id, r => r.IdSellerNavigation, r => r.IdCashRegisterNavigation,
                r => r.IdCashRegisterNavigation.IdWarehouseNavigation, r => r.IdCashRegisterNavigation.IdResponsibleNavigation).FirstOrDefault();

        }

        public object GetDataForClosingSessionCash(string email)
        {
            SessionCashViewModel sessionCash = GetOpenedSession(email);
            if (sessionCash != null)
            {
                IQueryable<TicketPayment> tickettPayment = _ticketPaymentRepo.GetAllWithConditionsRelationsQueryable(x => x.IdTicketNavigation.IdSessionCash == sessionCash.Id
                                                       , r => r.IdPaymentTypeNavigation);

                double total_cash = tickettPayment.Where(x => x.IdPaymentTypeNavigation.Code == PaymentMethodEnumerator.ESP).Sum(x => x.Amount);

                total_cash += sessionCash.OpeningAmount;

                double total = sessionCash.OpeningAmount + tickettPayment.Sum(x => x.Amount);

                // add treasury settlement to total 
                var settlements = _settlementRepo.GetAllWithConditionsRelations(x => x.IdSessionCash == sessionCash.Id, r => r.IdPaymentMethodNavigation);
                total_cash += settlements.Where(x => x.IdPaymentMethodNavigation.Code == PaymentMethodEnumerator.ESP).Sum(x => x.AmountWithCurrency);
                total += settlements.Where(x => x.IdPaymentMethodNavigation.Code != PaymentMethodEnumerator.ESP).Sum(x => x.AmountWithCurrency);
                dynamic data = new ExpandoObject();
                data.Id = sessionCash.Id;
                data.IdCashRegister = sessionCash.IdCashRegister;
                data.warehouseName = sessionCash.IdCashRegisterNavigation.IdWarehouseNavigation.WarehouseName;
                data.responsibleName = sessionCash.IdCashRegisterNavigation.IdResponsibleNavigation.FirstName + " " + sessionCash.IdCashRegisterNavigation.IdResponsibleNavigation.LastName;
                data.cashierSeller = sessionCash.IdSellerNavigation.FirstName + " " + sessionCash.IdSellerNavigation.LastName;
                data.totalCash = total_cash;
                data.total = total;
                data.openingAmount = sessionCash.OpeningAmount;
                data.openingDate = sessionCash.OpeningDate;

                return data;
            }
            return null;
        }

        public DataSourceResult<SessionCashViewModel> GetCashRegisterSessionDetails(PredicateFormatViewModel predicateModel, int idCashRegister)
        {

            CashRegister selectedCash = _repoCashRegister.GetSingleNotTracked(x => x.Id == idCashRegister);
            Expression<Func<SessionCash, bool>> expression = (p) => (selectedCash.Type == (int)CashRegisterTypeEnumerator.Central)
                    || ((selectedCash.Type == (int)CashRegisterTypeEnumerator.Principal) && (p.IdCashRegisterNavigation.IdParentCash == idCashRegister))
                    || ((selectedCash.Type == (int)CashRegisterTypeEnumerator.ExpenseFund || selectedCash.Type == (int)CashRegisterTypeEnumerator.RecipeBox) && (p.IdCashRegister == idCashRegister));

            var query = _entityRepo.QuerableGetAll()
                    .Include(r => r.IdSellerNavigation)
                    .Include(r => r.IdCashRegisterNavigation)
                    .ThenInclude(r => r.IdParentCashNavigation)
                    .Include(r => r.IdCashRegisterNavigation)
                    .ThenInclude(r => r.IdCityNavigation)
                    .Where(expression);
            if (predicateModel.OrderBy == null)
            {
                query = query.OrderByDescending(x => x.Id);
            }
            else
            {
                query = query.OrderByRelation(predicateModel.OrderBy);
            }
                
            List<SessionCash> entities = query.Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();

            List<SessionCashViewModel> model = entities.Select(_builder.BuildEntity).ToList();

            int total = _entityRepo.GetCountWithPredicate(expression);

            DataSourceResult<SessionCashViewModel> dataResult = new DataSourceResult<SessionCashViewModel>
            {
                data = model,
                total = total
            };
            return dataResult;
        }
        public SessionCashViewModel GetSessionByIdTicket(int idTicket)
        {
            return GetModelsWithConditionsRelations(x => x.Ticket.Select(x => x.Id).Contains(idTicket), r => r.IdSellerNavigation, r => r.IdCashRegisterNavigation,
                            r => r.IdCashRegisterNavigation.IdWarehouseNavigation, r => r.IdCashRegisterNavigation.IdResponsibleNavigation).FirstOrDefault();
        }

        public SessionCashViewModel GetSessionByIdDocument(int idDocument)
        {
            return GetModelsWithConditionsRelations(x => x.Document.Select(x => x.Id).Contains(idDocument), r => r.IdSellerNavigation, r => r.IdCashRegisterNavigation,
                            r => r.IdCashRegisterNavigation.IdWarehouseNavigation, r => r.IdCashRegisterNavigation.IdResponsibleNavigation).FirstOrDefault();
        }


    }

}
