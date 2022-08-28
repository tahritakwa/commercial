using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Common;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {

        public List<int> GenerateTermInvoice(List<TierSettelementMode> data, DateTime date, DateTime invoicingDate, string userMail, bool isBl , int? idTierCategory)
        {
            try
            {
                if (!data.Any())
                {
                    return new List<int>();
                }
                List<int> settlementModeIds = data.Where(x => x.IdSettlementMode != NumberConstant.Zero).Select(x => x.IdSettlementMode).Distinct().ToList();
                // get settlement mode ids that exists in data from Database
                List<int> listSettlementMode = _entitySettlementModeRepo.GetAllWithConditionsRelationsAsNoTracking(x => settlementModeIds.Contains(x.Id)).Select(x => x.Id).ToList();
                if(listSettlementMode.Count < settlementModeIds.Count)
                {
                    throw new CustomException(CustomStatusCode.DeletedSettlementMode);
                }
                lock (string.Intern(string.Join(GenericConstants.Comma, data)) as object)
                {
                    BeginTransaction();
                    List<int> idsTier = data.Select(x => x.IdTier).ToList();
                    VerifExistingInvoiceProvisional(invoicingDate, idsTier,isBl);

                    // Group By Costumer
                    List<Document> salesDeliveryList = GetdeliveryformsByDetailsByCustomer(idTierCategory, date, idsTier, true, isBl).ToList();

                    var DocumentListByTier = salesDeliveryList.GroupBy(x => x.IdTiers).ToList();
                    User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);

                    SettlementMode settlementMode = _entitySettlementModeRepo.GetSingle(p => p.Code == "Comptant");
                    if (settlementMode == null)
                    {
                        settlementMode = _entitySettlementModeRepo.GetFirst();
                    }

                    string documentEnumerator = isBl ? DocumentEnumerator.SalesInvoice : DocumentEnumerator.SalesInvoiceAsset;
                    List<Document> invoicesToAdd = GenerateDocumentFromTermInvoice(DocumentListByTier, invoicingDate, connectedUser, settlementMode, documentEnumerator, salesDeliveryList,data);
                    EndTransaction();
                    var listGeneratedInvoice = _entityRepo.FindBy(x => invoicesToAdd.Select(f => f.Code).Contains(x.Code) == true).OrderBy(f => f.Code).ToList();
                    var listIdGeneratedInvoice = listGeneratedInvoice.Select(c => c.Id).ToList();
                    if (listIdGeneratedInvoice.Count == 0)
                    {
                        throw new CustomException(CustomStatusCode.AllDeleveryInvoiced);
                    }
                    if (isBl)
                    {
                        DocumentListByTier.ForEach(x =>
                        {
                            var salesDeliveryByTier = x.ToList();
                            var invoice = listGeneratedInvoice.Where(y => y.IdTiers == x.Key).FirstOrDefault();
                            _ticketRepo.GetAllAsNoTracking().Where(y => y.IdDeliveryFormNavigation.IdTiers == x.Key && salesDeliveryByTier.Select(delivery => delivery.Id).Contains(y.IdDeliveryForm) && y.TicketPayment.Count > 0)
                            .UpdateFromQuery(p => new Ticket { IdInvoice = invoice.Id });
                        });
                    }
                    return listIdGeneratedInvoice;
                }
            }
            catch (Exception ex)
            {
                RollBackTransaction();
                throw;
            }
        }
        private List<Document> GenerateDocumentFromTermInvoice(List<IGrouping<int?, Document>> DocumentListByTier, DateTime invoicingDate, User connectedUser, SettlementMode settlementMode, string documentEnumerator,
            List<Document> salesDeliveryList, List<TierSettelementMode> data)
        {
            List<Document> invoicesToAdd = new List<Document>();
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            DocumentType documentType = _entityDocumentTypeRepo.GetSingle(p => p.Code == documentEnumerator);
            Dictionary<int, List<DocumentLine>> linesToAdd = new Dictionary<int, List<DocumentLine>>();
            foreach (var tier in DocumentListByTier)
            {
                int settlementMd = data.Where(x => x.IdTier == tier.Key).Select(y=>y.IdSettlementMode).FirstOrDefault();

                Document generatedInvoice = new Document
                {
                    IdDocumentStatus = (int)DocumentStatusEnumerator.Valid,
                    DocumentTypeCode = documentEnumerator,
                    IdTiers = tier.Key,
                    DocumentDate = invoicingDate,
                    ValidationDate = DateTime.Today,
                    IdUsedCurrency = tier.First().IdUsedCurrency,
                    DocumentLine = new List<DocumentLine>(),
                    DocumentOtherTaxesWithCurrency = documentType.Code == DocumentEnumerator.SalesInvoice ? _serviceCompany.GetCurrentCompany().SaleSettings.SaleOtherTaxes : 0,
                    IdValidator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId,
                    IdCreator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId,
                    IdSettlementMode = (settlementMd!=0) ? settlementMd : settlementMode.Id,
                    InoicingType = (int)InvoicingTypeEnumerator.Term,
                };

                // il manque les echeances
                // generer et valider l'écheance

                List<DocumentLine> lines = new List<DocumentLine>();
                tier.ToList().ForEach(p => lines.AddRange(p.DocumentLine));
                List<int> documentLinesId = lines.Select(x => x.Id).ToList();
                linesToAdd.Add(tier.Key.Value, lines);

                lines.ForEach(p =>
                {
                    p.IdDocumentLineAssociated = p.Id;
                    p.Id = 0;
                    p.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid;
                    p.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                });
                generatedInvoice.DocumentLine = lines;

                DocumentViewModel documentViewModel = _builder.BuildEntity(generatedInvoice);
                List<DocumentTaxsResume> UpdatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
                CalculDocument(documentViewModel, UpdatedDocumentTaxsResumes, documentLinesId, generatedInvoice);
                SetDocumentValueCurrency(documentViewModel, companyCurrency.Precision);
                SetRemainingAmount(documentViewModel);
                this.ConvertAmountToLetter(documentViewModel);
                Document document = _builder.BuildModel(documentViewModel);
                document.IdCreator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
                document.DocumentTaxsResume = UpdatedDocumentTaxsResumes;
                invoicesToAdd.Add(document);
            }
            if (invoicesToAdd.Any())
            {

                var document = invoicesToAdd.FirstOrDefault();
                var codificationCounter = GetCodificationCounter(invoicesToAdd.FirstOrDefault(), nameof(document.DocumentTypeCode), document.DocumentTypeCode,true);
                SetCodification(invoicesToAdd, codificationCounter);
            }

            _entityRepo.BulkAdd(invoicesToAdd);
            _unitOfWork.Commit();

            SetDocumentFinancialCommitmentForTerm(invoicesToAdd, documentType);

            List<int> salesDeliveryIds = salesDeliveryList.Select(p => p.Id).ToList();
            _entityRepo.GetAllAsNoTracking().Where(p => salesDeliveryIds.Contains(p.Id)).UpdateFromQuery(p => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
            _entityDocumentLineRepo.GetAllAsNoTracking().Where(p => salesDeliveryIds.Contains(p.IdDocument)).UpdateFromQuery(p => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced });
            return invoicesToAdd;
        }
        private List<Document> GetdeliveryformsByDetailsByCustomer(int? idTierCategory, DateTime date, List<int> tiersId, bool fromGenerationInvoice = false, bool isBl = true)
        {
            DateTime startDate = new DateTime(date.Year, date.Month, 1);
            DateTime endDate = startDate.AddMonths(1).AddDays(-1);
            endDate = endDate.AddHours(23).AddMinutes(59).AddSeconds(59);
            IQueryable<Document> invoiceQuery = null;
            IQueryable<Document> invoiceDraftOrProvisional = null;

            if (isBl)
            {
                invoiceQuery = _entityRepo.GetAllAsNoTracking().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                 && (x.DocumentDate <= endDate && x.DocumentDate >= startDate));

                invoiceDraftOrProvisional = _entityRepo.GetAllAsNoTracking().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                 && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft || x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional));
            }
            else
            {
                invoiceQuery = _entityRepo.GetAllAsNoTracking().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset && x.IsRestaurn == false
                 && (x.DocumentDate <= endDate && x.DocumentDate >= startDate));

                invoiceDraftOrProvisional = _entityRepo.GetAllAsNoTracking().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset && x.IsRestaurn == false
                 && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft || x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional));
            }
            //Get Inovice line IDs associated during the period


            IQueryable<Document> deliveryQuery = _entityRepo.GetAllAsNoTracking()
               .Where(x => x.DocumentLine.Any()
                       && (x.DocumentDate <= endDate && x.DocumentDate >= startDate)
                        && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid || x.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed));

            if (isBl)
            {
                deliveryQuery = deliveryQuery.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.IsTermBilling);
            }
            else
            {
                deliveryQuery = deliveryQuery.Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset);
            }

            if (tiersId.Any())
            {
                invoiceQuery = invoiceQuery.Where(x => tiersId.Contains(x.IdTiers.Value));
                invoiceDraftOrProvisional = invoiceDraftOrProvisional.Where(x => tiersId.Contains(x.IdTiers.Value));
                deliveryQuery = deliveryQuery.Where(x => tiersId.Contains(x.IdTiers ?? 0));
            }

            if(idTierCategory > NumberConstant.Zero)
            {
                deliveryQuery = deliveryQuery.Where(x => x.IdTiersNavigation.IdTierCategory == idTierCategory);
            }

            List<int> invoiceILineAssociated = invoiceQuery.Include(y => y.DocumentLine).SelectMany(t => t.DocumentLine).Select(x => x.IdDocumentLineAssociated ?? 0)
            .Distinct().ToList();
            List<int> idTiersHavingDraftInvoices = invoiceDraftOrProvisional.Select(x => x.IdTiers ?? 0).Distinct().ToList();

            deliveryQuery = deliveryQuery.Where(x => !idTiersHavingDraftInvoices.Contains(x.IdTiers.Value));

            List<Document> documentList = new List<Document>();

            if (fromGenerationInvoice)
            {
                //Get Sales Delivery Documents 
                List<Document> salesDeliveryList = deliveryQuery.ToList();
                List<int> salesDeliveryIds = salesDeliveryList.Select(s => s.Id).ToList();
                List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.DocumentLineTaxe)
                    .Where(p => salesDeliveryIds.Contains(p.IdDocument)).ToList();
                // For each Sales Delivery Document Get docments line non-existatant in invoices
                foreach (var selesDelivery in salesDeliveryList)
                {
                    if (!selesDelivery.DocumentLine.Any(w => invoiceILineAssociated.Contains(w.Id)))
                    {
                        selesDelivery.DocumentLine = documentLines.Where(p => p.IdDocument == selesDelivery.Id).ToList();
                        documentList.Add(selesDelivery);
                    }
                }
                return documentList;
            }
            else
            {
                //Get Sales Delivery Documents 
                List<Document> salesDeliveryList = deliveryQuery.Include(x => x.IdTiersNavigation).ThenInclude(x => x.IdCurrencyNavigation).Include(x => x.DocumentLine).ToList();
                // For each Sales Delivery Document Get docments line non-existatant in invoices
                foreach (var selesDelivery in salesDeliveryList)
                {
                    if (!selesDelivery.DocumentLine.Any(w => invoiceILineAssociated.Contains(w.Id)))
                    {
                        documentList.Add(selesDelivery);
                    }
                }
                return documentList;
            }

        }

        public DataSourceResult<BlforTierViewModel> GetBlsForTermBilling(DateTime date, bool isBl , int? idTierCategory )
        {
            // Group By Costumer
            var DocumentListByTier = GetdeliveryformsByDetailsByCustomer(idTierCategory, date, new List<int>(), false, isBl).GroupBy(x => x.IdTiers).ToList();
            List<BlforTierViewModel> result = new List<BlforTierViewModel>();
            List<SettlementMode> settlementList = _entitySettlementModeRepo.GetAllAsNoTracking().ToList();
            foreach (var tier in DocumentListByTier)
            {
                var settlementCode = settlementList.Where(x => x.Id == tier.First().IdTiersNavigation.IdSettlementMode).Select(y => y.Code).FirstOrDefault();
                result.Add(new BlforTierViewModel
                {
                    IdTiers = tier.First().IdTiersNavigation.Id,
                    TierName = tier.First().IdTiersNavigation.Name,
                    CodeTier = tier.First().IdTiersNavigation.CodeTiers,
                    formatOptions = new CurrencyDisplayObject
                    {
                        style = "currency",
                        currency = tier.First().IdTiersNavigation.IdCurrencyNavigation.Code,
                        currencyDisplay = "symbol",
                        minimumFractionDigits = tier.First().IdTiersNavigation.IdCurrencyNavigation.Precision
                    },
                    HtAmount = tier.ToList().Sum(row => (row.DocumentHtpriceWithCurrency == null) ? 0 : (double)row.DocumentHtpriceWithCurrency),
                    BlNumber = tier.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery),
                    InAssNumber = tier.Count(x => x.DocumentTypeCode == DocumentEnumerator.SalesAsset),
                    IdSettlementMode = tier.First().IdTiersNavigation.IdSettlementMode,
                    SettlementModeCode = settlementCode != null ? settlementCode : string.Empty
                });
            };


            DataSourceResult<BlforTierViewModel> listModel = new DataSourceResult<BlforTierViewModel>
            {
                data = result.OrderBy(p => p.TierName).ToList(),
                total = result.Count()
            };

            return listModel;
        }
        public void VerifExistingInvoiceProvisional(DateTime invoicingDate, List<int> tiersId, bool isBl)
        {
            IQueryable<Document> invoiceProvisional = null;
            if (isBl)
            {
                invoiceProvisional = _entityRepo.GetAllAsNoTracking().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                 && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional && x.DocumentDate.Date < invoicingDate.Date && x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment);
            }else {
            invoiceProvisional = _entityRepo.GetAllAsNoTracking().Where(x =>(x.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset && x.IsRestaurn == false )
                 &&  x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional && x.DocumentDate.Date <invoicingDate.Date);
            }
            if (invoiceProvisional.Count() > 0)
            {
                throw new CustomException(CustomStatusCode.ValidatePreviousInvoiceForTermInvoicing);
            }
        }

    }
}
