using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        #region DashboardRegion

        public IEnumerable<DocumentDashboard> SaleInvoiceAmountPerMonth()
        {
            // get invoice of the current year
            IList<Document> saleInvoiceOfTheYear = _entityRepo.FindBy(p => p.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                                                                            (p.DocumentDate.Date.Year == DateTime.Today.Year ||
                                                                            p.DocumentDate.Date.Year == (DateTime.Today.Year - 1))).ToList();
            // group invoice per month
            var saleGroupedByMonth = saleInvoiceOfTheYear.GroupBy(p => new { p.DocumentDate.Date.Month, p.DocumentDate.Date.Year });
            // calculate the sum of grouped invoices
            var saleAmountPerMonth = saleGroupedByMonth.Select(p => new DocumentDashboard
            {
                DocumentYear = p.First().DocumentDate.Date.Year,
                DocumentDate = p.First().DocumentDate.Date,
                DocumentMonth = p.First().DocumentDate.Date.Month,
                MonthName = MonthsEnumerator.GetMonthName(p.First().DocumentDate.Date.Month),
                DocumentHtprice = p.Sum(c => c.DocumentHtprice) / 1000
            }).Where(p => p.DocumentHtprice > 0);
            return saleAmountPerMonth.OrderBy(p => p.DocumentYear).ThenBy(p => p.DocumentMonth);
        }

        private IList<EntityAxisValues> getEntityAxisValue(string codeAxe, string entityName)
        {
            IList<EntityAxisValues> entityAxisValues = new List<EntityAxisValues>();
            Axis axis = _entityRepoAxis.FindBy(p => p.Code == codeAxe).FirstOrDefault();
            if (axis != null)
            {
                int axisCategoryId = axis.Id;

                // get item having category axis value 
                entityAxisValues = _entityRepoEntityAxisValues
                    .GetAllWithConditionsRelations(p => p.IdAxisValueNavigation.IdAxisNavigation.Id == axisCategoryId
                    && p.EntityNavigation.EntityName == entityName,
                c => c.IdAxisValueNavigation, c => c.IdAxisValueNavigation.IdAxisNavigation, c => c.EntityNavigation).ToList();
            }
            return entityAxisValues;
        }

        public IEnumerable<DocumentDashboard> AmountPerCategoryPerMonthInSalesInvoice()
        {
            List<DocumentDashboard> resultDocumentDashboard = GetAmountPerCategoryPerMonthForSpecialDocumentType(DocumentEnumerator.SalesInvoice).ToList();
            resultDocumentDashboard.ForEach(p => p.DocumentHtprice /= 1000);
            return resultDocumentDashboard.OrderBy(p => p.DocumentYear).ThenBy(p => p.DocumentMonth);
        }

        public IEnumerable<DocumentDashboard> AmountPerCategoryInSalesInvoice()
        {
            List<DocumentDashboard> resultDocumentDashboard = GetAmountPerCategoryForSpecialDocumentType(DocumentEnumerator.SalesInvoice, 0).ToList();
            resultDocumentDashboard.ForEach(p => p.DocumentHtprice /= 1000);
            return resultDocumentDashboard;
        }


        /*****************Purchase dashboard**********************/
        public IEnumerable<DocumentDashboard> PurchaseInvoiceAmountPerMonth()
        {
            // get invoice of the current year
            IList<Document> purchaseInvoiceOfTheYear = _entityRepo.FindBy(p => p.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice &&
                                                                            p.DocumentDate.Date.Year == DateTime.Today.Year).ToList();
            // group invoice per month
            var purchaseGroupedByMonth = purchaseInvoiceOfTheYear.GroupBy(p => new { p.DocumentDate.Date.Month, p.DocumentDate.Date.Year });
            // calculate the sum of grouped invoices
            var purchaseAmountPerMonth = purchaseGroupedByMonth.Select(p => new DocumentDashboard
            {
                DocumentMonth = p.First().DocumentDate.Date.Month,
                MonthName = MonthsEnumerator.GetMonthName(p.First().DocumentDate.Date.Month),
                DocumentHtprice = p.Sum(c => c.DocumentHtprice) / 1000
            }).Where(p => p.DocumentHtprice > 0);
            return purchaseAmountPerMonth.OrderBy(p => p.DocumentMonth);
        }

        public IEnumerable<DocumentDashboard> PurchaseDeliveryAmountPerMonth()
        {
            // get order of the current year
            IList<Document> purchaseOrderOfTheYear = _entityRepo.GetAllWithConditionsRelations(p => p.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
                                                                            (p.DocumentDate.Date.Year == DateTime.Today.Year || p.DocumentDate.Date.Year == DateTime.Today.Year - 1),
                                                                            r => r.IdTiersNavigation).ToList();
            // group order per month
            var purchaseGroupedBySupplier = purchaseOrderOfTheYear.GroupBy(p => p.IdTiers);
            // calculate the sum of grouped orders
            IEnumerable<DocumentDashboard> purchaseAmountPerMonth = purchaseGroupedBySupplier.Select(p => new DocumentDashboard
            {
                IdTiers = p.First().IdTiers.Value,
                TiersName = p.First().IdTiersNavigation.Name,
                DocumentYear = p.First().DocumentDate.Date.Year,
                DocumentDate = p.First().DocumentDate,
                DocumentMonth = p.First().DocumentDate.Date.Month,
                MonthName = MonthsEnumerator.GetMonthName(p.First().DocumentDate.Date.Month),
                DocumentHtprice = p.Sum(c => c.DocumentHtprice) / 1000
            }).Where(p => p.DocumentHtprice > 0);
            return purchaseAmountPerMonth.OrderBy(p => p.DocumentMonth);
        }
        public IEnumerable<DocumentDashboard> AmountItemPerCategoryInPurchaseOrder()
        {
            List<DocumentDashboard> resultDocumentDashboard = GetAmountPerCategoryPerMonthForSpecialDocumentType(DocumentEnumerator.PurchaseOrder).ToList();
            return resultDocumentDashboard.OrderBy(p => p.DocumentYear).ThenBy(p => p.DocumentMonth);
        }
        public IEnumerable<DocumentDashboard> PurchaseDeliveryAmountPerSupplier()
        {
            // prepare final list
            IList<DocumentDashboard> resultPurchaseAmountPerSupplier = GetAmountPerThirdPartyForSpecialType(DocumentEnumerator.PurchaseDelivery).ToList();
            return resultPurchaseAmountPerSupplier;
        }
        public IEnumerable<DocumentDashboard> PurchaseInvoiceAmountPerSupplier()
        {
            // prepare final list
            IList<DocumentDashboard> resultPurchaseAmountPerSupplier = GetAmountPerThirdPartyForSpecialType(DocumentEnumerator.PurchaseInvoice).ToList();
            return resultPurchaseAmountPerSupplier;
        }



        /************************SHARED METHODS*************************************/
        private IEnumerable<DocumentDashboard> GetAmountPerCategoryPerMonthForSpecialDocumentType(string documentType)
        {
            // get axis value of 'Category' Axis 
            List<DocumentDashboard> resultDocumentDashboard = new List<DocumentDashboard>();
            IList<EntityAxisValues> items = getEntityAxisValue("CAT", "Item");
            if (items.NotNullOrEmpty())
            {
                IList<AxisValue> axisValue = _entityRepoAxisValue.FindBy(p => p.IdAxis == items.FirstOrDefault().IdAxisValueNavigation.IdAxisNavigation.Id).ToList();
                var itemsPerCategory = items.GroupBy(p => p.IdAxisValue).ToList();
                IList<DocumentLine> purchaseDocumentLine = _entityDocumentLineRepo.GetAllWithConditionsRelations(p => p.IdDocumentNavigation.DocumentTypeCode == documentType &&
                                                            p.IdDocumentNavigation.DocumentDate.Year == DateTime.Today.Year, c => c.IdDocumentNavigation).ToList();

                double totalLineAmount = purchaseDocumentLine.Sum(p => p.HtTotalLineWithCurrency.GetValueOrDefault());
                // calcul qty and amount per category
                foreach (var category in itemsPerCategory)
                {
                    IList<DocumentLine> dLPerCategory = purchaseDocumentLine.Where(dl => category.Select(p => p.IdEntityItem).Contains(dl.IdItem)).ToList();
                    var dLPerCategoryPerMonth = dLPerCategory.GroupBy((p => new { p.IdDocumentNavigation.DocumentDate.Date.Month }));
                    foreach (var categoryPerMonth in dLPerCategoryPerMonth)
                    {
                        DocumentDashboard documentDashboard = new DocumentDashboard
                        {
                            DocumentMonth = categoryPerMonth.First().IdDocumentNavigation.DocumentDate.Date.Month,
                            MonthName = MonthsEnumerator.GetMonthName(categoryPerMonth.First().IdDocumentNavigation.DocumentDate.Date.Month),
                            DocumentYear = categoryPerMonth.First().IdDocumentNavigation.DocumentDate.Date.Year,
                            YearMonthName = MonthsEnumerator.GetMonthName(categoryPerMonth.First().IdDocumentNavigation.DocumentDate.Date.Month) + " "
                                                                            + categoryPerMonth.First().IdDocumentNavigation.DocumentDate.Date.Year,
                            DocumentHtprice = categoryPerMonth.Sum(c => c.HtTotalLineWithCurrency),
                            CategoryName = axisValue.FirstOrDefault(s => s.Id == category.Key.GetValueOrDefault()).Label,
                            PercentageAmount = (categoryPerMonth.Sum(c => c.HtTotalLineWithCurrency).Value / totalLineAmount) * 100,
                        };
                        resultDocumentDashboard.Add(documentDashboard);
                    }
                }
            }
            return resultDocumentDashboard;
        }

        private IEnumerable<DocumentDashboard> GetAmountPerCategoryForSpecialDocumentType(string documentType, float seuile)
        {
            // get axis value of 'Category' Axis 
            List<DocumentDashboard> resultDocumentDashboard = new List<DocumentDashboard>();
            IList<EntityAxisValues> items = getEntityAxisValue("CAT", "Item");
            if (items.NotNullOrEmpty())
            {
                IList<AxisValue> axisValue = _entityRepoAxisValue.FindBy(p => p.IdAxis == items.FirstOrDefault().IdAxisValueNavigation.IdAxisNavigation.Id).ToList();
                List<DocumentDashboard> otherDocumentDashboard = new List<DocumentDashboard>();
                var itemsPerCategory = items.GroupBy(p => p.IdAxisValue).ToList();
                IList<DocumentLine> purchaseDocumentLine = _entityDocumentLineRepo.GetAllWithConditionsRelations(p => p.IdDocumentNavigation.DocumentTypeCode == documentType &&
                                                            p.IdDocumentNavigation.DocumentDate.Year == DateTime.Today.Year, c => c.IdDocumentNavigation).ToList();

                double totalLineAmount = purchaseDocumentLine.Sum(p => p.HtTotalLineWithCurrency.GetValueOrDefault());
                // calcul qty and amount per category
                foreach (var category in itemsPerCategory)
                {
                    IList<DocumentLine> dLPerCategory = purchaseDocumentLine.Where(dl => category.Select(p => p.IdEntityItem).Contains(dl.IdItem)).ToList();

                    DocumentDashboard documentDashboard = new DocumentDashboard
                    {
                        DocumentHtprice = dLPerCategory.Sum(c => c.HtTotalLineWithCurrency),
                        CategoryName = axisValue.FirstOrDefault(s => s.Id == category.Key.GetValueOrDefault()).Label,
                        PercentageAmount = (dLPerCategory.Sum(c => c.HtTotalLineWithCurrency).Value / totalLineAmount) * 100,
                    };

                    if (documentDashboard.DocumentHtprice >= seuile)
                    {
                        resultDocumentDashboard.Add(documentDashboard);
                    }
                    else
                    {
                        otherDocumentDashboard.Add(documentDashboard);
                    }
                }
                if (otherDocumentDashboard.Any())
                {
                    DocumentDashboard documentDashboard = new DocumentDashboard
                    {
                        DocumentHtprice = otherDocumentDashboard.Sum(c => c.DocumentHtprice),
                        CategoryName = "Other",
                        PercentageAmount = (otherDocumentDashboard.Sum(c => c.DocumentHtprice).Value / totalLineAmount) * 100,
                    };
                    resultDocumentDashboard.Add(documentDashboard);
                }
            }
            return resultDocumentDashboard;
        }
        private IEnumerable<DocumentDashboard> GetAmountPerThirdPartyForSpecialType(string documentType)
        {
            // get invoice of the current year
            IList<Document> purchaseInvoiceOfTheYear = _entityRepo.GetAllWithConditionsRelations(p => p.DocumentTypeCode == documentType,
                c => c.IdTiersNavigation).ToList();
            // Totaux invoice amount
            double sumInvoiceAmount = purchaseInvoiceOfTheYear.Sum(p => p.DocumentHtprice).GetValueOrDefault();
            // group invoice per month
            var purchaseGroupedBySupplier = purchaseInvoiceOfTheYear.GroupBy(p => p.IdTiers);
            // calculate the sum of grouped invoices
            var purchaseAmountPerSupplier = purchaseGroupedBySupplier.Select(p => new DocumentDashboard
            {
                IdTiers = p.First().IdTiers.Value,
                TiersName = p.First().IdTiersNavigation.Name,
                DocumentHtprice = p.Sum(c => c.DocumentHtprice) / 1000,
                PercentageAmount = (p.Sum(c => c.DocumentHtprice).GetValueOrDefault() / sumInvoiceAmount) * 100
            });
            // prepare final list
            IList<DocumentDashboard> resultPurchaseAmountPerSupplier = new List<DocumentDashboard>();
            DocumentDashboard otherDocumentDashboard = new DocumentDashboard
            {
                DocumentHtprice = 0
            };

            purchaseAmountPerSupplier.Where(p => p.PercentageAmount > 5).ToList().ForEach(elt => resultPurchaseAmountPerSupplier.Add(elt));
            purchaseAmountPerSupplier.Where(p => p.PercentageAmount <= 5).ToList().ForEach(elt => otherDocumentDashboard.DocumentHtprice += elt.DocumentHtprice);

            if (otherDocumentDashboard.DocumentHtprice > 0)
            {
                otherDocumentDashboard.IdTiers = int.MaxValue;
                otherDocumentDashboard.TiersName = "Other";
                otherDocumentDashboard.PercentageAmount = (otherDocumentDashboard.DocumentHtprice.GetValueOrDefault() / sumInvoiceAmount) * 100;
                resultPurchaseAmountPerSupplier.Add(otherDocumentDashboard);
            }
            return resultPurchaseAmountPerSupplier;
        }

        public DocumentDashboard NumberSalesInvoices()
        {
            DocumentDashboard result = new DocumentDashboard();
            DateTime currentDate = DateTime.Today;
            result.DocumentMonth = currentDate.Month == 1 ? 12 : currentDate.Month - 1;
            result.DocumentYear = currentDate.Month == 1 ? currentDate.Year - 1 : currentDate.Year;
            result.DocumentDate = new DateTime(year: result.DocumentYear, month: result.DocumentMonth, day: 01);
            result.TotalNumber = _entityRepo.FindBy(p => p.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                                                                            p.DocumentDate.Date.Year == result.DocumentYear &&
                                                                            p.DocumentDate.Date.Month == result.DocumentMonth).Count();


            return result;
        }

        public DocumentDashboard WorkforceNumber()
        {
            DocumentDashboard result = new DocumentDashboard
            {
                TotalNumber = _entityRepoEmployee.GetAll().Count()
            };
            return result;
        }

        public DocumentDashboard StaffingTurnover()
        {
            DocumentDashboard result = new DocumentDashboard();
            DateTime currentDate = DateTime.Today;
            result.DocumentMonth = currentDate.Month == 1 ? 12 : currentDate.Month - 1;
            result.DocumentYear = currentDate.Month == 1 ? currentDate.Year - 1 : currentDate.Year;
            result.DocumentDate = new DateTime(year: result.DocumentYear, month: result.DocumentMonth, day: 01);
            IList<EntityAxisValues> items = getEntityAxisValue("TypeContrat", "Item");
            if (items.NotNullOrEmpty())
            {
                IList<AxisValue> axisValue = _entityRepoAxisValue.FindBy(p => p.IdAxis == items.FirstOrDefault().IdAxisValueNavigation.IdAxisNavigation.Id
                                            && p.Code != "SousTrai").ToList();
                if (axisValue.NotNullOrEmpty())
                {
                    IList<int> idItems = items.Where(item => axisValue.Select(p => p.Id).Contains(item.IdAxisValue.Value)).Select(p => p.IdEntityItem.Value).ToList();
                    IList<DocumentLine> saleDocumentLine = _entityDocumentLineRepo.GetAllWithConditionsRelations(p => p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                                                                && idItems.Contains(p.IdItem) && p.IdDocumentNavigation.DocumentDate.Month == result.DocumentMonth &&
                                                                p.IdDocumentNavigation.DocumentDate.Year == result.DocumentYear,
                                                                c => c.IdDocumentNavigation
                                                                ).ToList();

                    result.DocumentHtprice = saleDocumentLine.Sum(p => p.HtTotalLineWithCurrency);
                }

            }
            if (!result.DocumentHtprice.HasValue)
            {
                result.DocumentHtprice = 0;
            }
            return result;
        }

        public DocumentDashboard IndirectStaffingTurnover()
        {
            DocumentDashboard result = new DocumentDashboard();
            DateTime currentDate = DateTime.Today;
            result.DocumentMonth = currentDate.Month == 1 ? 12 : currentDate.Month - 1;
            result.DocumentYear = currentDate.Month == 1 ? currentDate.Year - 1 : currentDate.Year;
            result.DocumentDate = new DateTime(year: result.DocumentYear, month: result.DocumentMonth, day: 01);
            IList<EntityAxisValues> items = getEntityAxisValue("TypeContrat", "Item");
            if (items.NotNullOrEmpty())
            {
                IList<AxisValue> axisValue = _entityRepoAxisValue.FindBy(p => p.IdAxis == items.FirstOrDefault().IdAxisValueNavigation.IdAxisNavigation.Id
                                            && p.Code == "SousTrai").ToList();
                if (axisValue.NotNullOrEmpty())
                {
                    IList<int> idItems = items.Where(item => axisValue.Select(p => p.Id).Contains(item.IdAxisValue.Value)).Select(p => p.IdEntityItem.Value).ToList();
                    IList<DocumentLine> saleDocumentLine = _entityDocumentLineRepo.GetAllWithConditionsRelations(p => p.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                                                                && idItems.Contains(p.IdItem) && p.IdDocumentNavigation.DocumentDate.Month == result.DocumentMonth &&
                                                                p.IdDocumentNavigation.DocumentDate.Year == result.DocumentYear,
                                                                c => c.IdDocumentNavigation
                                                                ).ToList();

                    result.DocumentHtprice = saleDocumentLine.Sum(p => p.HtTotalLineWithCurrency);
                }
            }
            if (!result.DocumentHtprice.HasValue)
            {
                result.DocumentHtprice = 0;
            }
            return result;
        }
        #endregion
    }
}
