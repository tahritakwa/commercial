using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceDocumentExpenseLine : Service<DocumentExpenseLineViewModel, DocumentExpenseLine>, IServiceDocumentExpenseLine
    {
        private readonly IServiceCurrency _serviceCurrency;
        private readonly IServiceTaxe _serviceTaxe;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IServiceTiers _serviceTiers;
        private readonly IRepository<Document> _entityRepoDocument;
        public ServiceDocumentExpenseLine(IRepository<DocumentExpenseLine> entityRepo, IUnitOfWork unitOfWork,
                      IServiceCurrency serviceCurrency, IServiceTaxe serviceTaxe, 
           IDocumentExpenseLineBuilder documentExpenseLineBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
            IServiceCompany serviceCompany, IServiceCurrencyRate serviceCurrencyRate, IRepository<Document> entityRepoDocument,
            IServiceTiers serviceTiers)
             : base(entityRepo, unitOfWork, documentExpenseLineBuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
                   entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceCurrency = serviceCurrency;
            _serviceTaxe = serviceTaxe;
            _serviceCompany = serviceCompany;
            _serviceCurrencyRate = serviceCurrencyRate;
            _entityRepoDocument = entityRepoDocument;
            _serviceTiers = serviceTiers;
        }


        /// <summary>
        /// Calculate TTC Amount From a documentExpenseLine 
        /// </summary>
        /// <param name="documentExpenseLine"></param>
        /// <returns></returns>
        public DocumentExpenseLineViewModel CalculateTTCAmount(DocumentExpenseLineViewModel documentExpenseLine)
        {
            if (documentExpenseLine.IdExpense != 0 && documentExpenseLine.IdCurrency != null && documentExpenseLine.IdCurrency != 0)
            {
                CurrencyViewModel currencyViewModel = _serviceCurrency.GetModel(currency => currency.Id == documentExpenseLine.IdCurrency);
                int purchasePrecision = currencyViewModel.Precision;
                // If n=2.565 => Result will be r=2.566
                documentExpenseLine.HtAmountLineWithCurrency = Math.Round(documentExpenseLine.HtAmountLineWithCurrency, purchasePrecision, MidpointRounding.ToEven);
                double TaxeValue = 0;


                TiersViewModel tier = _serviceTiers.GetModelById((int)documentExpenseLine.IdTiers);
                if (documentExpenseLine.TaxeAmount > 0)
                {
                    if (tier != null &&
                        tier.IdTaxeGroupTiers == (int)TaxeGroupEnumerator.NotExempt)
                    {
                        TaxeValue = documentExpenseLine.TaxeAmount ?? 0;
                    }
                    
                    documentExpenseLine.TtcAmoutLine = Math.Round(
                    TaxeValue + documentExpenseLine.HtAmountLineWithCurrency, purchasePrecision, MidpointRounding.ToEven);
                }
                else if (documentExpenseLine.IdTaxe != 0)
                {
                    if (tier != null && 
                        tier.IdTaxeGroupTiers == (int)TaxeGroupEnumerator.NotExempt)
                    {
                        TaxeValue = _serviceTaxe.GetModel(taxe => taxe.Id == documentExpenseLine.IdTaxe).TaxeValue ?? 0;
                    }
                    documentExpenseLine.TtcAmoutLine = Math.Round(
                    (1 + (TaxeValue / 100)) * documentExpenseLine.HtAmountLineWithCurrency, purchasePrecision, MidpointRounding.ToEven);
                }
                Document currentDocument = _entityRepoDocument.GetSingle(x => x.Id == documentExpenseLine.IdDocument);
                double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(documentExpenseLine.IdCurrency ?? 0,
                        currentDocument != null ? currentDocument.DocumentDate : DateTime.UtcNow, currentDocument.ExchangeRate);

                documentExpenseLine.TtcAmountLineWithCurrency = (exchangeRate != null && exchangeRate > 0) ? documentExpenseLine.TtcAmoutLine * exchangeRate : documentExpenseLine.TtcAmoutLine;


            }
            return documentExpenseLine;
        }

        public void UpdateDocumentExpenseLine(IList<DocumentExpenseLine> documentExpenseLineViewModels)
        {
            foreach (DocumentExpenseLine documentExpenseLine in documentExpenseLineViewModels)
            {
                // Add new documentExpenseLine 
                if (documentExpenseLine.Id == 0)
                {

                    _entityRepo.Add(documentExpenseLine);
                }
                else
                {
                    // Delete case
                    if (documentExpenseLine.IsDeleted)
                    {
                        documentExpenseLine.DeletedToken = Guid.NewGuid().ToString();
                    }
                    // Update case
                    _entityRepo.Update(documentExpenseLine);
                }
            }
        }
        /**
         * calculate total document expense lines
         */
        public double CalculateTotalExpose(TotalLineExpenseViewModel documentExpenseLines)
        {
            var idDocument = documentExpenseLines.ExposeLines.FirstOrDefault().IdDocument;

            var DocumentExchangeRate = _entityRepoDocument.GetSingle(x => x.Id == idDocument).ExchangeRate;
            double sumHtExpenses = 0;
            documentExpenseLines.ExposeLines.ToList().ForEach(line =>
               {
                   var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(line.IdCurrency ?? 0, documentExpenseLines.DocumentDate, DocumentExchangeRate);
                   var currency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == line.IdCurrency);
                   // var precision = (currency != null) ? currency.PurchasePrecision : 3;
                   var precision = 3;
                   sumHtExpenses += (exchangeRate != null && exchangeRate > 0) ? exchangeRate * AmountMethods.FormatValue(line.HtAmountLineWithCurrency, precision) : AmountMethods.FormatValue(line.HtAmountLineWithCurrency, precision);
               });
            return sumHtExpenses;
        }

        /*Calculate cost price peer item */
        public double CalculateCoefficientOfCostPrice(InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            if (priceCost != null && priceCost.IdDocument != 0)
            {
                var DocumentExchangeRate = _entityRepoDocument.GetSingleNotTracked (x => x.Id == priceCost.IdDocument).ExchangeRate;
                double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(priceCost.IdCurrency, priceCost.DocumentDate, DocumentExchangeRate);
                var total = ((exchangeRate != null && exchangeRate > 0) ? priceCost.TotalDocumentPrice * exchangeRate : priceCost.TotalDocumentPrice) + priceCost.TotalExpensePrice;
                return total / (priceCost.TotalDocumentPrice.IsApproximately(0, within: 0.0001) ? 1 : priceCost.TotalDocumentPrice);
            }
            return 0;
        }

        /*Calculate cost price peer item */
        public double CalculatePercentageCostPrice(InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            if (priceCost != null && priceCost.IdDocument != 0)
            {
                var DocumentExchangeRate = _entityRepoDocument.GetSingle(x => x.Id == priceCost.IdDocument).ExchangeRate;
                double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(priceCost.IdCurrency, priceCost.DocumentDate, DocumentExchangeRate);
                var total = ((exchangeRate != null && exchangeRate > 0) ? priceCost.TotalDocumentTtcPrice * exchangeRate : priceCost.TotalDocumentTtcPrice);
                var currency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == priceCost.IdCurrency);
                var precision = (currency != null) ? currency.Precision : 3;
                var resultData = total != NumberConstant.Zero ? (double)((priceCost.HtAmountLineWithCurrency ?? 0) / total) * 100 : NumberConstant.Zero;
                return AmountMethods.FormatValue(resultData, precision);
            }
            return 0;
        }


        /*Calculate cost price peer item */
        public double CalculateCostPricePercentage(InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            if (priceCost != null && priceCost.IdDocument != 0)
            {
                var DocumentExchangeRate = _entityRepoDocument.GetSingle(x => x.Id == priceCost.IdDocument).ExchangeRate;
                double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(priceCost.IdCurrency, priceCost.DocumentDate, DocumentExchangeRate);
                var total = ((exchangeRate != null && exchangeRate > 0) ? priceCost.TotalDocumentTtcPrice * exchangeRate : priceCost.TotalDocumentTtcPrice);
                var currency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == priceCost.IdCurrency);
                //var precision = (currency != null) ? currency.PurchasePrecision : 3;
                var precision = 3;
                var resultData = (double)(total * (priceCost.HtAmountLineWithCurrencyPercentage ?? 0)) / 100;
                return AmountMethods.FormatValue(resultData, precision);
            }
            return 0;
        }
    }
}
