using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Accounting;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        /// <summary>
        /// Get List Of Accounting document
        /// </summary>
        /// <param name="imoptedDocument"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public List<AccountingDocument> GetAccountingDocument(PredicateFormatViewModel importedDocument, out int total)
        {
            IQueryable<Document> documentQuerable = null;
            int companyPrecision = GetCompanyCurrencyPrecision();
            var documentType = importedDocument.Filter.First(x => x.Prop == "DocumentTypeCode").Value;
            importedDocument.Operator = Operator.And;
            PredicateFilterRelationViewModel<Document> predicateFilterRelationModel = PreparePredicate(importedDocument);
            documentQuerable = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere,predicateFilterRelationModel.PredicateRelations)
                                                   .OrderByRelation(importedDocument.OrderBy);
            DataSourceResult<DocumentViewModel> result = GetDataWithSpecificFilterRelation(importedDocument, documentQuerable, predicateFilterRelationModel);
            total = documentQuerable.Count();
            documentQuerable = result.data.Select(x => _builder.BuildModel(x)).ToList().AsQueryable();
            List<Document> documents = documentQuerable.ToList();
            List<AccountingDocument> accountingDocuments = new List<AccountingDocument>();
            documents.ForEach(currentDocument =>
            {
                List<AccountingDocumentDetail> accountingDocumentDetails = new List<AccountingDocumentDetail>();
                currentDocument.DocumentTaxsResume.ToList().ForEach(recap =>
                {

                    if ((documentType.ToString() == DocumentEnumerator.PurchaseInvoice || documentType.ToString() == DocumentEnumerator.PurchaseAsset)
                    && recap.IdTaxNavigation.TaxeType == (int)TaxTypeEnumerator.Vat)
                    {
                        AccountingDocumentDetail accountingDocumentDetail = new AccountingDocumentDetail
                        {
                            idTax = recap.IdTax.Value,
                            vatName = recap.IdTaxNavigation.Label,
                            vatAmount = recap.TaxAmount.Value,
                            vatType = recap.IdTaxNavigation.TaxeType,
                            pretaxAmount = AmountMethods.FormatValue(recap.HtAmount.Value + (recap.DiscountAmount ?? 0), companyPrecision)
                        };
                        accountingDocumentDetails.Add(accountingDocumentDetail);
                    }
                    else if (documentType.ToString() == DocumentEnumerator.SalesInvoiceAsset || documentType.ToString() == DocumentEnumerator.SalesInvoice)
                    {
                        AccountingDocumentDetail accountingDocumentDetail = new AccountingDocumentDetail
                        {
                            idTax = recap.IdTax.Value,
                            vatName = recap.IdTaxNavigation.Label,
                            vatAmount = recap.TaxAmount.Value,
                            vatType = recap.IdTaxNavigation.TaxeType,
                            pretaxAmount = recap.IdTaxNavigation.TaxeType == (int)TaxTypeEnumerator.BaseVat ? 0 : AmountMethods.FormatValue(recap.HtAmount.Value + (recap.DiscountAmount ?? 0) - (recap.ExcVatTaxAmount ?? 0), companyPrecision)
                        };
                        accountingDocumentDetails.Add(accountingDocumentDetail);
                    }

                });

                accountingDocuments.Add(new AccountingDocument
                {
                    idDocument = currentDocument.Id,
                    codeDocument = currentDocument.Code,
                    documentType = currentDocument.DocumentTypeCode,
                    amountTTC = currentDocument.DocumentTtcprice != null && currentDocument.DocumentTtcprice > 0 ? currentDocument.DocumentTtcprice.Value : 0,
                    tierId = currentDocument.IdTiersNavigation.Id,
                    documentDate = currentDocument.DocumentDate,
                    isAccounted = currentDocument.IsAccounted,
                    tierName = currentDocument.IdTiersNavigation.Name,
                    taxStamp = currentDocument.DocumentOtherTaxes ?? 0,
                    billDetails = accountingDocumentDetails,
                    ristourn = currentDocument.DocumentTotalDiscount ?? 0
                });
            });
            return accountingDocuments.OrderByDescending(x => x.codeDocument).ToList();
        }


        /// <summary>
        /// AccountDocument unique document
        /// </summary>
        /// <param name="documentViewModel"></param>
        public void AccountDocument(DocumentViewModel documentViewModel)
        {
            if (!documentViewModel.IsAccounted)
            {
                documentViewModel.IsAccounted = true;
                BeginTransaction();
                UpdateModelWithoutTransaction(documentViewModel);
                EndTransaction();
            }
        }

        /// <summary>
        /// Accout list of documents
        /// </summary>
        /// <param name="documentViewModels"></param>
        /// <param name="userMail"></param>
        public void AccountDocuments(IEnumerable<DocumentViewModel> documentViewModels, string userMail)
        {
            documentViewModels.Where(m => !m.IsAccounted).ToList().ForEach(m =>
            {
                m.IsAccounted = true;
            });
            BeginTransaction();
            BulkUpdateModelWithoutTransaction(documentViewModels.ToList(), userMail);
            EndTransaction();
        }


        /// <summary>
        /// UnaccountedDocument
        /// </summary>
        /// <param name="documentViewModel"></param>
        public void UnaccountedDocument(DocumentViewModel documentViewModel)
        {
            if (documentViewModel.IsAccounted)
            {
                documentViewModel.IsAccounted = false;
                BeginTransaction();
                UpdateModelWithoutTransaction(documentViewModel);
                EndTransaction();
            }
        }


        /// <summary>
        /// UnaccountedDocument
        /// </summary>
        /// <param name="settlement"></param>
        public void UnaccountedSettlement(Settlement settlement)
        {
            if (settlement.IsAccounted)
            {
                settlement.IsAccounted = false;
                _settlementRepo.Update(settlement);
                _unitOfWork.Commit();
            }
        }
        /// <summary>
        /// AccountDocument 
        /// </summary>
        /// <param name="settlement"></param>
        public void AccountSettlement(Settlement settlement)
        {

            if (!settlement.IsAccounted)
            {
                settlement.IsAccounted = true;
                _settlementRepo.Update(settlement);
                _unitOfWork.Commit();
            }
        }




    }
}
