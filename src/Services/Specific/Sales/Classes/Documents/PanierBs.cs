using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {

        public List<ReducedPanierDocumentLineViewModel> GetDocumentLinesToInvoicePanier(PredicateWithDateFilterInformationViewModel dateFilter)
        {
            var watch = System.Diagnostics.Stopwatch.StartNew();
            IQueryable<DocumentLine> docLinesQueryable = _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x =>
                ((x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS &&
                (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid ||
                (x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied &&
                (x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.PartiallySatisfied ||
                x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)))) ||
                (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE &&
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid) ||
                (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                x.IdDocumentNavigation.InoicingType == (int)InvoicingTypeEnumerator.Other)) && 
                (dateFilter != null && dateFilter.IdUser != null ? x.IdDocumentNavigation.IdCreator == dateFilter.IdUser : true),
                x => x.IdDocumentNavigation, x => x.IdItemNavigation, x=> x.IdDocumentNavigation.IdCreatorNavigation);

            if (dateFilter.StartDate != null && dateFilter.EndDate != null)
            {
                docLinesQueryable = docLinesQueryable.Where(x =>
                x.IdDocumentNavigation.DocumentDate.Date >= ((DateTime)dateFilter.StartDate).Date &&
                x.IdDocumentNavigation.DocumentDate.Date <= ((DateTime)dateFilter.EndDate).Date);
            }
            else if (dateFilter.StartDate != null)
            {
                docLinesQueryable = docLinesQueryable.Where(x =>
                x.IdDocumentNavigation.DocumentDate.Date >= ((DateTime)dateFilter.StartDate).Date);
            }
            else if (dateFilter.EndDate != null)
            {
                docLinesQueryable = docLinesQueryable.Where(x =>
                x.IdDocumentNavigation.DocumentDate.Date <= ((DateTime)dateFilter.EndDate).Date);

            }
            else if (dateFilter.Year != null)
            {
                docLinesQueryable = docLinesQueryable.Where(x =>
                x.IdDocumentNavigation.DocumentDate.Year == dateFilter.Year);
            }

            // List<DocumentLineViewModel> docLines = docLinesQueryable.ToList().Select(x => _documentLineBuilder.BuildEntity(x)).ToList();
            // Get list BS grouped by BS and item 
            IQueryable<DocumentLine> listLineBs = docLinesQueryable.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS);

            // Get list BE grouped By item
            var lineOfBE = docLinesQueryable.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE).ToList();
            var listLineBE = lineOfBE!=null ? lineOfBE.GroupBy(x => x.IdItem).ToList() : null;
            

            // Get list Facture other group by item
            IQueryable<DocumentLine> listLineInvoice = docLinesQueryable.Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice);

            // List line Bs which are associated to invoice
            List<int?> listIdsLineAssoc = listLineInvoice.Select(y => y.IdDocumentLineAssociated).ToList();
            List<DocumentLineViewModel> listInvoicedLineBS = listLineBs.Where(x => listIdsLineAssoc.Contains(x.Id)).Select(z => _documentLineBuilder.BuildEntity(z)).ToList();
            // List line Bs which are not associated to invoice
            List<DocumentLineViewModel> listNotInvoicedLineBS = listLineBs.Where(x => !listIdsLineAssoc.Contains(x.Id)).Select(z => _documentLineBuilder.BuildEntity(z)).ToList();
            // list of Bs Without elimination BE 
            List<DocumentLineViewModel> finalListBsWithoutEliminateBE = new List<DocumentLineViewModel>();
            List<DocumentLineViewModel> finalListBsWithoutEliminateBECopy = new List<DocumentLineViewModel>();
            finalListBsWithoutEliminateBE = finalListBsWithoutEliminateBE.Concat(listNotInvoicedLineBS).ToList();
            List<DocumentLine> ll = listLineInvoice.ToList();
            listInvoicedLineBS.ForEach(y =>
            {
                IEnumerable<DocumentLine> lineAssoc = ll.Where(z => z.IdDocumentLineAssociated == y.Id);
                if (lineAssoc != null && lineAssoc.Any())
                {
                    y.MovementQty = y.MovementQty - lineAssoc.Select(u => u.MovementQty).Sum();
                    if (y.MovementQty > 0)
                    {
                        finalListBsWithoutEliminateBE.Add(y);
                    }
                }

            });


            finalListBsWithoutEliminateBECopy = finalListBsWithoutEliminateBE;
            var listLineBsGroupedByItem = finalListBsWithoutEliminateBE.GroupBy(x => x.IdItem);
            listLineBsGroupedByItem.ToList().ForEach(x =>
            {
                var linesBeItemByKey = listLineBE !=null ? listLineBE.Where(y => y.Key == x.Key): null;
                if (linesBeItemByKey != null && linesBeItemByKey.Any())
                {
                    var linesBeItem = linesBeItemByKey.First();
                    if (linesBeItem != null && linesBeItem.Any())
                    {
                        if (x.Sum(v => v.MovementQty) <= linesBeItem.Sum(z => z.MovementQty))
                        {
                            finalListBsWithoutEliminateBECopy = finalListBsWithoutEliminateBECopy.Except(x.ToList()).ToList();
                        }
                        else
                        {
                            List<DocumentLineViewModel> listOrdredByQte = x.OrderBy(h => h.MovementQty).ToList();
                            if (listOrdredByQte != null && listOrdredByQte.Any())
                            {
                                bool isEliminated = false;
                                int compteur = 0;
                                double sommedQte = 0;
                                while (!isEliminated)
                                {
                                    if (listOrdredByQte.Count > compteur && listOrdredByQte[compteur] != null)
                                    {
                                        DocumentLineViewModel lineToModifQte = finalListBsWithoutEliminateBECopy.Where(u => u.Id == listOrdredByQte[compteur].Id).FirstOrDefault();
                                        if (lineToModifQte != null)
                                        {
                                            if (listOrdredByQte[compteur].MovementQty >= (linesBeItem.Sum(z => z.MovementQty) - sommedQte))
                                            {
                                                lineToModifQte.MovementQty = lineToModifQte.MovementQty - (linesBeItem.Sum(z => z.MovementQty) - sommedQte);
                                                finalListBsWithoutEliminateBECopy.Where(l => l.Id == lineToModifQte.Id).FirstOrDefault().MovementQty = lineToModifQte.MovementQty;
                                                isEliminated = true;
                                            }
                                            else
                                            {
                                                finalListBsWithoutEliminateBECopy.Remove(listOrdredByQte[compteur]);
                                                sommedQte = sommedQte + listOrdredByQte[compteur].MovementQty;
                                            }
                                        }
                                        compteur++;
                                    }
                                    else
                                    {
                                        isEliminated = true;
                                    }
                                }
                            }
                        }
                    }
                }

            });

            List<int> listIdsItems = finalListBsWithoutEliminateBECopy.Select(y => y.IdItem).Distinct().ToList();
            List<DocumentLineViewModel> listOfAllDocLineOfSelectedItems = _serviceDocumentLine.GetAllModelsQueryable(x => listIdsItems.Contains(x.IdItem) && x.CostPrice != null && x.CostPrice > 0).ToList()
                                                                     .GroupBy(row => row.IdItem)
                                                                     .Select(p => new DocumentLineViewModel
                                                                     {
                                                                         IdItem = p.First().IdItem,
                                                                         HtUnitAmountWithCurrency = p.Select(r => r.CostPrice).Min() * 1.2
                                                                     }).ToList();

            List<ReducedPanierDocumentLineViewModel> finalListOfBs = new List<ReducedPanierDocumentLineViewModel>();
            int companyPrecision = GetCompanyCurrencyPrecision();
            finalListBsWithoutEliminateBECopy.ForEach(x =>
            {
                if (x.MovementQty > 0)
                {
                    ReducedPanierDocumentLineViewModel docLineBs = new ReducedPanierDocumentLineViewModel()
                    {
                        IdItem = x.IdItem,
                        DesignationItem = x.IdItemNavigation.Description,
                        CodeItem = x.IdItemNavigation.Code,
                        Designation = x.Designation,
                        CodeDocumentLine = "",
                        DiscountPercentage = 10,
                        CostPrice = 0,
                        PercentageMargin = 0,
                        UnitPriceFromQuotation = 0,
                        SellingPrice = 0,
                        IdWarehouse = x.IdWarehouse,
                        MovementQty = x.MovementQty,
                        HtUnitAmountWithCurrency = x.IdItemNavigation.DefaultUnitHtpurchasePrice != null ? x.IdItemNavigation.DefaultUnitHtpurchasePrice * 1.2 : 0,
                        IdDocumentLineAssociated = x.Id,
                        IdDocumentAssociated = x.IdDocument,
                        IdDocumentAssociatedNavigation = new ReducedPanierDocumentViewModel()
                        {
                            Code = x.IdDocumentNavigation.Code,
                            DocumentDate = x.IdDocumentNavigation.DocumentDate,
                            Id = x.IdDocumentNavigation.Id
                        },
                        IdMeasureUnit = x.IdMeasureUnit,
                        IdUser = x.IdDocumentNavigation != null && x.IdDocumentNavigation.IdCreator != null ? x.IdDocumentNavigation.IdCreator : null,
                        CreatorFullName = x.IdDocumentNavigation != null && x.IdDocumentNavigation.IdCreatorNavigation != null && x.IdDocumentNavigation.IdCreatorNavigation.FullName != null ?
                        x.IdDocumentNavigation.IdCreatorNavigation.FullName : null,

                    };

                    List<DocumentLineViewModel> lineOfCurrentItem = listOfAllDocLineOfSelectedItems.Where(y => y.IdItem == x.IdItem).ToList();
                    if (lineOfCurrentItem != null && lineOfCurrentItem.Any())
                    {
                        docLineBs.HtUnitAmountWithCurrency = AmountMethods.FormatValue(lineOfCurrentItem.First().HtUnitAmountWithCurrency, companyPrecision);
                    }
                    else if (docLineBs.HtUnitAmountWithCurrency == null)
                    {
                        docLineBs.HtUnitAmountWithCurrency = 0;
                    }
                    docLineBs.HtUnitAmountWithCurrency = AmountMethods.FormatValue(docLineBs.HtUnitAmountWithCurrency, companyPrecision);
                    docLineBs.HtTotalLineWithCurrency = AmountMethods.FormatValue(docLineBs.HtUnitAmountWithCurrency * docLineBs.MovementQty, companyPrecision);
                    finalListOfBs.Add(docLineBs);
                }
            });
            watch.Stop();
            var elapsedMs = watch.ElapsedMilliseconds;
            return finalListOfBs.OrderBy(x => x.IdDocumentAssociatedNavigation.Code).ToList();
        }



        public DocumentViewModel ImportLineToInvoiced(ItemPriceViewModel itemPriceViewModel)
        {
            try
            {
                BeginTransaction();

                DocumentViewModel documentViewModel = new DocumentViewModel();
                List<DocumentLineViewModel> documentLine = new List<DocumentLineViewModel>();
                if (itemPriceViewModel.DocumentLines != null && itemPriceViewModel.DocumentLines.Any())
                {
                    // check if the document the Invoice already containes imported Bl Lines
                    var idDocLines = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == itemPriceViewModel.DocumentLines.First().IdDocument).Select(x => x.IdDocumentLineAssociated).ToList();
                    var isBlImported = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery && idDocLines.Contains(x.Id)).Count() > 0;
                    if (isBlImported)
                    {
                        throw new CustomException(CustomStatusCode.CANNOT_IMPORT_BS_BL);
                    }
                    DocumentLineViewModel docLineViewModel = itemPriceViewModel.DocumentLines[0];
                    PrepareDocLinePrices(itemPriceViewModel);

                    DocumentViewModel doc = new DocumentViewModel();
                    if (docLineViewModel.IdDocument > 0)
                    {
                        doc = GetModelWithRelationsAsNoTracked(x => x.Id == docLineViewModel.IdDocument, x => x.DocumentLine);
                        VerifyIfValidatedOrDeletedDocument(docLineViewModel.IdDocument,null,false, _builder.BuildModel(doc));
                        if (doc.DocumentLine != null && doc.DocumentLine.Any())
                        {
                            itemPriceViewModel.DocumentLines.ForEach(u =>
                            {
                                DocumentLineViewModel existDocLine = doc.DocumentLine.Where(z => z.IdDocumentLineAssociated == u.IdDocumentLineAssociated).FirstOrDefault();
                                if (existDocLine != null)
                                {
                                    existDocLine.MovementQty = existDocLine.MovementQty + u.MovementQty;
                                }
                                else
                                {
                                    doc.DocumentLine = doc.DocumentLine.Concat(itemPriceViewModel.DocumentLines).ToList();
                                }
                            });

                        }
                        else
                        {
                            doc.DocumentLine = itemPriceViewModel.DocumentLines;
                        }
                    }
                    else
                    {
                        doc = new DocumentViewModel()
                        {
                            Id = 0,
                            DocumentDate = itemPriceViewModel.DocumentDate,
                            DocumentTypeCode = itemPriceViewModel.DocumentType,
                            IdTiers = itemPriceViewModel.IdTiers,
                            IdUsedCurrency = itemPriceViewModel.IdCurrency
                        };
                        doc.DocumentLine = itemPriceViewModel.DocumentLines;
                    }

                    if (doc.IdTiers != null && doc.IdTiers != 0)
                    {
                        CalculateDocumentAndDocumenLineValues(doc);
                    }

                    SetDocumentLinesStatus(doc);
                    SetDocumentDate(doc);
                    // Modif type of Document
                    doc.InoicingType = (int)InvoicingTypeEnumerator.Other;
                    Document docEntity = _builder.BuildModel(doc);
                    UpdateDocumentLine(docEntity);
                    _entityDocumentTaxsResume.BulkUpdate(docEntity.DocumentTaxsResume.ToList());
                    docEntity.DocumentTaxsResume.Clear();
                    _entityRepo.Update(docEntity);
                    _unitOfWork.Commit();

                    Document document = _entityRepo.GetAllAsNoTracking().Include(x => x.DocumentTaxsResume).ThenInclude(x=>x.IdTaxNavigation).FirstOrDefault(x => x.Id == doc.Id);

                    documentViewModel = _builder.BuildEntity(document);

                }

                EndTransaction();
                return documentViewModel;
            }
            catch (CustomException ex)
            {
                RollBackTransaction();
                throw;
            }
            catch (Exception ex)
            {

                throw;
            }

        }


        private void PrepareDocLinePrices(ItemPriceViewModel itemPriceViewModel)
        {

            itemPriceViewModel.DocumentLines.ForEach(x =>
            {
                itemPriceViewModel.DocumentLineViewModel = x;
                int PrecisionValues = GetPrecissionValue((int)itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentType);
                if(x.HtUnitAmountWithCurrency.Value.IsApproximately(0, within: 0.0001))
                {
                    x.HtUnitAmountWithCurrency = _serviceItem.GetModelById(x.IdItem).UnitHtsalePrice;
                }
                
                x.HtAmountWithCurrency = x.HtUnitAmountWithCurrency - x.HtUnitAmountWithCurrency * x.DiscountPercentage / 100;
                  
                GetDocumentLinePrice(itemPriceViewModel);
            });

        }

    }
}
