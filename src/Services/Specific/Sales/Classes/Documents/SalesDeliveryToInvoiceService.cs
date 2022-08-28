using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        private DateTime GetDateOfInvoicing(DateTime now)
        {
            DateTime dayOfInvoicing;

            //Get sale setting
            SaleSettingsViewModel saleSettingsVM = _serviceCompany.GetCurrentCompany().SaleSettings;
            if (saleSettingsVM.InvoicingEndMonth ||
                !saleSettingsVM.InvoicingDay.HasValue ||
                saleSettingsVM.InvoicingDay.Equals(31) ||
                (now.Month.Equals(2) && (saleSettingsVM.InvoicingDay.Equals(30) || saleSettingsVM.InvoicingDay.Equals(29))))
            {
                DateTime firstDayCurrentMonth = new DateTime(now.Year, now.Month, 1).AddMonths(1);
                dayOfInvoicing = firstDayCurrentMonth.AddDays(-1);
            }
            else
            {
                dayOfInvoicing = new DateTime(now.Year, now.Month, saleSettingsVM.InvoicingDay.Value);
            }
            return dayOfInvoicing;
        }



        /// <summary>
        /// Execute All Customer Invoices Generation
        /// </summary>
        public void ExecuteAllCustomerInvoicesGenereation(DateTime dayOfInvoicing, string connectionstring)
        {
            BeginTransaction(connectionstring);
            //Get Inovice line IDs associated during a month
            List<int> invoiceILineAssociated = _entityRepo.QuerableGetAll().Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesInvoice
           && x.DocumentDate >= dayOfInvoicing.AddMonths(-1)).Include(y => y.DocumentLine).SelectMany(t => t.DocumentLine).Select(x => x.IdDocumentLineAssociated ?? 0).Distinct().ToList();

            //Get Sales Delivery Documents
            List<Document> salesDeliveryList = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => true).Include(x => x.DocumentLine).Where(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery &&
                 x.IsTermBilling && x.DocumentDate <= dayOfInvoicing && (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid || x.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed)).ToList();


            var documentList = new List<DocumentViewModel>();
            // For each Sales Delivery Document Get docments line non-existatant in invoices
            foreach (var selesDelivery in salesDeliveryList)
            {
                if (!selesDelivery.DocumentLine.Any(w => invoiceILineAssociated.Contains(w.Id)))
                {
                    documentList.Add(_builder.BuildEntity(selesDelivery));
                }
            }
            // Group By Costumer
            var DocumentListByTier = documentList.GroupBy(x => x.IdTiers).ToList();
            EndTransaction();
            // genenrate invoice by costumer
            foreach (var tier in DocumentListByTier)
            {

                try
                {
                    _logger.LogError("Begin Generat Invoice for Customer: " + (tier.FirstOrDefault() != null ? tier.FirstOrDefault().IdTiers : 0) + " At: " + DateTime.Now); ;
                    BeginTransaction(connectionstring);
                    DocumentViewModel generatedInvoice = new DocumentViewModel
                    {
                        IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                        DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                        IdTiers = tier.Key,
                        DocumentDate = dayOfInvoicing,
                        IdUsedCurrency = tier.First().IdUsedCurrency,
                        DocumentLine = new List<DocumentLineViewModel>(),
                        DocumentOtherTaxesWithCurrency = _serviceCompany.GetCurrentCompany().SaleSettings.SaleOtherTaxes
                    };
                    // for each SalesDelivery get the all Document Lines related
                    foreach (DocumentViewModel currentSalesDelivery in tier)
                    {
                        int documentStatus = currentSalesDelivery.IdDocumentStatus;

                        // Validate the printed document and balance it 
                        if (documentStatus == (int)DocumentStatusEnumerator.Printed)
                        {
                            ValidateDocumentWithoutTransaction(currentSalesDelivery.Id, "", (int)DocumentStatusEnumerator.Valid, false);
                        }
                        else // Balance valid document
                        {
                            currentSalesDelivery.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                        }

                        generatedInvoice.IdUsedCurrency = currentSalesDelivery.IdUsedCurrency;
                        generatedInvoice.DocumentOtherTaxesWithCurrency = _serviceCompany.GetCurrentCompany().SaleSettings.SaleOtherTaxes;

                        AddDocumentLinesToGeneratedInvoiceWithBalancingValidLines(currentSalesDelivery.DocumentLine, generatedInvoice, documentStatus);

                    }
                    DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == generatedInvoice.DocumentTypeCode);
                    AddDocumentWithoutTransaction(null, generatedInvoice, documentType, "", null);
                    _logger.LogError("End Generat Invoice for Customer: " + (tier.FirstOrDefault() != null ? tier.FirstOrDefault().IdTiers : 0) + " At: " + DateTime.Now);
                    EndTransaction();
                }
                catch (Exception ex)
                {
                    _logger.LogError("Fatal ERROR Generat Invoice for Customer: " + (tier.FirstOrDefault() != null ? tier.FirstOrDefault().IdTiers : 0) + " Exception: " + ex);
                    RollBackTransaction();
                }
            }
        }

        public void CleanInvoicingLog()
        {
            List<SalesInvoiceLog> log = _entityRepoInvoiceLog.GetAll().ToList();
            _entityRepoInvoiceLog.BulkDeletePhysically(log);
            // commit transaction
            _unitOfWork.Commit();
        }

        public int CheckInvoiceErrors()
        {
            return _entityRepoInvoiceLog.GetCount();
        }


        /// <summary>
        /// Generate All Customer Invoices
        /// </summary>
        public void GenerateAllCustomerInvoices(string connectionstring)
        {
            try
            {
                BeginTransaction(connectionstring);
                DateTime now = DateTime.Now;
                _logger.LogError(new StringBuilder().Append("Info : <<Begin Generat Invoice>>").Append(now).ToString());
                DateTime dayOfInvoicing = GetDateOfInvoicing(now).AddMonths(-1);
                EndTransaction();
                ExecuteAllCustomerInvoicesGenereation(dayOfInvoicing, connectionstring);
                _logger.LogError(new StringBuilder().Append("Info : <<End Generat Invoice>> Delay excuted Milsecond : ").Append((DateTime.Now - now).Milliseconds)
                    .Append((DateTime.Now - now).Minutes * 1000).ToString());
                BeginTransaction(connectionstring);
                CleanInvoicingLog();
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                SalesInvoiceLog invoiceLog = new SalesInvoiceLog
                {

                    Message = new StringBuilder().Append("Error At ").Append(DateTime.Now.ToString()).Append(":").Append(e.Message).Append(e.StackTrace).ToString()
                };
                BeginTransaction();
                _entityRepoInvoiceLog.Add(invoiceLog);
                _unitOfWork.Commit();
                EndTransaction();
            }
        }

        /// <summary>
        /// Get TermBilling SalesDelivery List By Tier
        /// </summary>
        /// <param name="customer"></param>
        /// <returns></returns>
        private IEnumerable<DocumentViewModel> GetTermBillingSalesDeliveryOfMonthListByTier(DateTime now)
        {
            return FindModelsByNoTracked(x => x.DocumentTypeCode == DocumentEnumerator.SalesDelivery &&
            x.IsTermBilling &&
            (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid || x.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed) &&
            x.DocumentDate.Year <= now.Year && x.DocumentDate.Month <= now.Month && x.DocumentDate.Day <= now.Day);
        }

        /// <summary>
        /// Add DocumentLines To Generated Invoice
        /// </summary>
        /// <param name="currentSalesDeliveryDocumentLineList"></param>
        /// <param name="generatedInvoice"></param>
        private void AddDocumentLinesToGeneratedInvoiceWithBalancingValidLines(
            IEnumerable<DocumentLineViewModel> currentSalesDeliveryDocumentLineList, DocumentViewModel generatedInvoice, int documentStatus)
        {
            if (currentSalesDeliveryDocumentLineList.Any())
            {
                foreach (DocumentLineViewModel currentDocumentLine in currentSalesDeliveryDocumentLineList)
                {
                    // Balancing valid document line
                    if (documentStatus == (int)DocumentStatusEnumerator.Valid)
                    {
                        currentDocumentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced;
                        _serviceDocumentLine.UpdateModelWithoutTransaction(currentDocumentLine);
                    }

                    // Copying Document line
                    DocumentLineViewModel intermDocumentLine = currentDocumentLine;
                    intermDocumentLine.IdDocumentLineAssociated = currentDocumentLine.Id;
                    intermDocumentLine.Id = 0;
                    intermDocumentLine.IdDocument = 0;
                    intermDocumentLine.IdDocumentNavigation = null;
                    intermDocumentLine.IdDocumentLineStatus = generatedInvoice.IdDocumentStatus;

                    // add the Document line to the created invoice
                    generatedInvoice.DocumentLine.Add(intermDocumentLine);
                }

            }
        }
    }
}
