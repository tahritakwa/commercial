using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Treasury.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using System.Threading;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Treasury;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;

namespace Services.Specific.Treasury.Classes
{
    public class ServiceTicket : Service<TicketViewModel, Ticket>, IServiceTicket
    {
        private readonly IServiceDocument _serviceDocument;
        IRepository<Settlement> _entityRepoSettlement;

        private readonly IRepository<Document> _repoDocument;
        private readonly IServiceSessionCash _serviceSessionCash;
        private readonly ITicketBuilder _ticketBuilder;
        private readonly IDocumentBuilder _documentBuilder;
        private readonly ICurrencyBuilder _builderCurrency;
        public ServiceTicket(IRepository<Ticket> entityRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
                     IUnitOfWork unitOfWork, ITicketBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues,
                     IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
                     IRepository<Codification> entityRepoCodification, IServiceDocument serviceDocument,
                     IServiceSessionCash serviceSessionCash, ITicketBuilder ticketBuilder, IRepository<Document> repoDocument,
                     IRepository<Settlement> entityRepoSettlement, IDocumentBuilder documentBuilder, ICurrencyBuilder builderCurrency)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity,
                 entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceDocument = serviceDocument;
            _repoDocument = repoDocument;
            _serviceSessionCash = serviceSessionCash;
            _ticketBuilder = ticketBuilder;
            _entityRepoSettlement = entityRepoSettlement;
            _documentBuilder = documentBuilder;
            _builderCurrency = builderCurrency;
        }


        public DataSourceResult<ReducedTicketViewModel> GetTicketsForSettlement(FilterSearchTicketViewModel model)
        {
            IQueryable<Ticket> entities = null;
            entities = _entityRepo.GetAllWithConditionsRelationsQueryable(x => 
            (model.IdTiers != NumberConstant.Zero ? x.IdDeliveryFormNavigation != null && x.IdDeliveryFormNavigation.IdTiers == model.IdTiers : true) &&
            (model.IdPaymentType != NumberConstant.Zero ? x.TicketPayment != null && x.TicketPayment.Select(y => y.IdPaymentType).Contains(model.IdPaymentType) : true) &&
            (model.PaidTicket.HasValue ? (model.PaidTicket.Value ? (x.IdInvoiceNavigation != null
                && (x.IdInvoiceNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                || x.IdInvoiceNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)) : x.IdInvoiceNavigation == null) :
                (x.IdInvoiceNavigation == null || (x.IdInvoiceNavigation != null 
                && (x.IdInvoiceNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                || x.IdInvoiceNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied))))
                &&
                (model.IdCashRegister != NumberConstant.Zero ? (x.IdSessionCashNavigation != null && x.IdSessionCashNavigation.IdCashRegisterNavigation != null
                && x.IdSessionCashNavigation.IdCashRegisterNavigation.Id == model.IdCashRegister) : true) &&
                (model.IdParentCash != NumberConstant.Zero ? (x.IdSessionCashNavigation != null && x.IdSessionCashNavigation.IdCashRegisterNavigation != null
                && x.IdSessionCashNavigation.IdCashRegisterNavigation.IdParentCash == model.IdParentCash) : true) &&
                (model.CreationDate != null ? DateTime.Compare(x.CreationDate.Date, model.CreationDate.Value.Date) == NumberConstant.Zero : true) 
                &&
                ((model.InvoiceBLCode != null && model.InvoiceBLCode != "")  ? (
                x.IdInvoiceNavigation != null && x.IdInvoiceNavigation.Code.ToLower().Contains(model.InvoiceBLCode.ToLower().Trim())) || (
                x.IdDeliveryFormNavigation != null && x.IdDeliveryFormNavigation.Code.ToLower().Contains(model.InvoiceBLCode.ToLower().Trim())): true)
                &&
                ((model.TicketCode != null && model.TicketCode != "") ? x.Code.ToLower().Contains(model.TicketCode.ToLower().Trim()) : true)
            )
                .Include(y => y.IdDeliveryFormNavigation).ThenInclude(y => y.IdTiersNavigation)
                .Include(y => y.IdDeliveryFormNavigation).ThenInclude(y => y.IdUsedCurrencyNavigation)
                .Include(y => y.IdInvoiceNavigation)
                .Include(y => y.TicketPayment).ThenInclude(y => y.IdPaymentTypeNavigation)
                .Include(y => y.IdSessionCashNavigation).ThenInclude(y => y.IdCashRegisterNavigation);

            IList<Ticket> listOfTickets = new List<Ticket>();
            if (model.OrderBy.Count > NumberConstant.Zero)
            {
                entities = entities.OrderByRelation(model.OrderBy);

            }
            List<ReducedTicketViewModel> models = _ticketBuilder.BuildTicket(entities.ToList(), model.IdPaymentType).ToList();
            var total = models.Count();
            if (model.page > NumberConstant.Zero && model.pageSize > NumberConstant.Zero)
            {
                models = models.Skip((model.page - 1) * model.pageSize).Take(model.pageSize).ToList();
            }
            DataSourceResult<ReducedTicketViewModel> result = new DataSourceResult<ReducedTicketViewModel>
            {
                data = models,
                total = total
            };
            return result;
        }

        public override DataSourceResult<TicketViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Ticket> predicateFilterRelationModel = PreparePredicate(predicateModel);
            IQueryable<Ticket> tickeLists = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
             .Include(y => y.TicketPayment).ThenInclude(y => y.IdPaymentTypeNavigation)
             .OrderByRelation(predicateModel.OrderBy);
            List<TicketViewModel> ticketFromBLProv = new List<TicketViewModel>();
            if (predicateModel.Filter.Where(x => x.Prop == "IdSessionCash").Any())
            {
                int idSessionCash = Convert.ToInt32(predicateModel.Filter.Where(x => x.Prop == "IdSessionCash").FirstOrDefault().Value);
                ticketFromBLProv = GetDeliveryDocumentByIdSession(idSessionCash);
            }

            var total = tickeLists.Count() + ticketFromBLProv.Count();
            if (predicateModel.page > NumberConstant.Zero && predicateModel.pageSize > NumberConstant.Zero)
            {
                var take = predicateModel.pageSize;
                var skip = (predicateModel.page - 1) * predicateModel.pageSize;
                if (predicateModel.page == 1)
                {
                    take -= ticketFromBLProv.Count();
                }
                else {
                    skip -= ticketFromBLProv.Count();
                }
               
                tickeLists = tickeLists.Skip(skip).Take(take);
            }
            List<TicketViewModel> models = tickeLists.ToList().Select(x => _ticketBuilder.BuildEntity(x)).ToList();
            DataSourceResult<TicketViewModel> result = new DataSourceResult<TicketViewModel>
            {
                total = total
            };
            if (predicateModel.page == 1)
            {
                ticketFromBLProv.AddRange(models);
                result.data = ticketFromBLProv.ToList();
            } 
            else
            {
                result.data = models.ToList();

            }

            return result;
        }

        public List<TicketViewModel> GetDeliveryDocumentByIdSession(int idSessionCash)
        {
            List<TicketViewModel> tickets = new List<TicketViewModel>();
            List<DocumentViewModel> deliveryFormProv = _repoDocument.GetAllWithConditionsRelations(x => x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
            && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery
            && x.IdSessionCounterSales != null && x.IdSessionCounterSales == idSessionCash,
            x => x.IdTiersNavigation, x => x.IdUsedCurrencyNavigation).ToList().Select(x=> _documentBuilder.BuildDocumentEntity(x)).ToList();
            if (deliveryFormProv != null && deliveryFormProv.Any())
            {            
                deliveryFormProv.ForEach(y =>
                {
                    TicketViewModel ticket = new TicketViewModel
                    {
                        IdDeliveryFormNavigation = y,
                        CreationDate = y.CreationDate.HasValue? y.CreationDate.Value : DateTime.Now ,
                        IdDeliveryForm = y.Id,
                        CreationDateTime = y.CreationDate.ToString(),
                        IdSessionCash = y.IdSessionCounterSales.Value
                    };
                    tickets.Add(ticket);
                });
            }
            return tickets;
        }

        public object ValidateBLAndGenerateTicket(int id, int idSession, string userMail, bool validateBl = true)
        {
            TicketViewModel result = null;
            DocumentViewModel res = null;
            BeginTransaction();
            if (validateBl)
            {
                res = _serviceDocument.ValidateDocumentWithoutTransaction(id, userMail,
                                                (int)DocumentStatusEnumerator.Valid, false);
            }
            if (res != null || !validateBl)
            {
                SessionCashViewModel sessionCashViewModel = _serviceSessionCash.GetModelAsNoTracked(x => x.Id == idSession);
                IList<string> codification = GenerateCodification(sessionCashViewModel);

                // BL has been validated so generate ticket 
                TicketViewModel ticket = new TicketViewModel
                {
                    IdDeliveryForm = id,
                    IdSessionCash = idSession,
                    CreationDate = DateTime.Now,
                    Status = (int)DocumentStatusEnumerator.Provisional,
                    Code = codification[0]
                };
                CreatedDataViewModel ticketGenerated = (CreatedDataViewModel)AddModelWithoutTransaction(ticket, null, userMail);
                sessionCashViewModel.LastCounter = codification[1];
                _serviceSessionCash.UpdateModelWithoutTransaction(sessionCashViewModel, null, userMail);
                _unitOfWork.Commit();
                EndTransaction();
                result = GetModelAsNoTracked(x => x.Id == ticketGenerated.Id);
                result.EntityName = new Ticket().GetType().Name.ToUpper();
            }
            return result;

        }

        private IList<string> GenerateCodification(SessionCashViewModel session)
        {
            StringBuilder code = new StringBuilder();
            StringBuilder counter = new StringBuilder();
            IList<string> codification = new List<string>();
            int nextCounter = int.Parse(session.LastCounter) + 1;
            var repeatCount = session.LastCounter.Length - nextCounter.ToString().Length;
            repeatCount = repeatCount <= 0 ? 0 : repeatCount;
            counter.Append('0', repeatCount);
            counter.Append(nextCounter);
            code.Append(session.Code);
            code.Append('-');
            code.Append(counter);
            codification.Add(code.ToString());
            codification.Add(counter.ToString());

            return codification;
        }

        public IList<TicketLineViewModel> GetTicketLines(int idTicket)
        {
            int idDelivery = _entityRepo.GetSingleNotTracked(x => x.Id == idTicket)?.IdDeliveryForm ?? 0;
            Document document = _repoDocument.GetAllWithConditionsQueryable(x => x.Id == idDelivery)
                                .Include(r => r.DocumentLine)
                                .ThenInclude(r => r.IdItemNavigation)
                                .Include(r => r.IdUsedCurrencyNavigation)
                                .FirstOrDefault();
            List<TicketLineViewModel> ticketLines = document?.DocumentLine?.Select(s => new TicketLineViewModel
            {
                Quantity = s.MovementQty,
                Designation= new StringBuilder().Append(s.Designation).Append(" ").Append(s.IdItemNavigation?.Code).ToString(),
                UnitSalesPrice = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + s.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision + "}", "", (s.HtUnitAmount + s.VatTaxAmount / s.MovementQty) ?? 0),
                TtcAmount = string.Format(Thread.CurrentThread.CurrentCulture, "{0}{1:n" + s.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision + "}", "", s.TtcTotalLine ?? 0)
            }).ToList();
            return ticketLines;
        }
    }
}
