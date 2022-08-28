using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.DTO.Reporting;

namespace ViewModels.Builders.Specific.Reporting.Classes
{
    public class DocumentLineExpenseReportingBuilder : GenericBuilder<DocumentLineExpenseReportingViewModel, DocumentExpenseLine>, IDocumentLineExpenseReportingBuilder
    {

        public override DocumentLineExpenseReportingViewModel BuildEntity(DocumentExpenseLine entity)
        {
            
            Currency currency = new Currency();
            if (entity.IdDocumentNavigation != null)
            {
                currency =
                currency = entity.IdDocumentNavigation.IdUsedCurrencyNavigation;
                entity.IdDocumentNavigation.IdUsedCurrencyNavigation = null;
                entity.IdDocumentNavigation.DocumentLine = null;
            }

            DocumentLineExpenseReportingViewModel model = base.BuildEntity(entity);
            if (entity.IdDocumentNavigation != null)
            {
                if (currency != null && currency.Symbole != null)
                {
                    model.Symbole = currency.Symbole;
                    model.CurrencyPrecision = entity.IdDocumentNavigation.DocumentTypeCode.Contains("SA") ? currency.Precision : currency.Precision;
                }
            }

            model.Reference = entity.IdExpense.ToString();
            model.Designation = entity.Designation;
            model.MNTHT = entity.HtAmountLineWithCurrency;


            //model.MNTTVA = entity.IdTaxeNavigation!=null && entity.IdTaxeNavigation.IsCalculable ? entity.TaxeAmount : entity.IdTaxeNavigation.TaxeValue;
            model.MNTTVA = entity.IdTaxeNavigation != null && entity.IdTaxeNavigation.IsCalculable ? entity.TtcAmountLineWithCurrency - entity.HtAmountLineWithCurrency: entity.TaxeAmount;
            
            model.MNTTTC = entity.TtcAmountLineWithCurrency;


            return model;
        }



    }
}
