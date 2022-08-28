using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Reporting.Classes
{
    public class DocumentLineCostReportingBuilder : GenericBuilder<DocumentLineCostReportingViewModel, CostPriceViewModel>, IDocumentLineCostReportingBuilder
    {

        public override DocumentLineCostReportingViewModel BuildEntity(CostPriceViewModel entity)
        {

            DocumentLineCostReportingViewModel model = base.BuildEntity(entity);
            model.Reference = entity.Reference;
            model.Designation = entity.DesignationItem;
            model.MovementQty = entity.Quantity;
            model.PUDEV = entity.HtUnitAmountWithCurrency;
            model.PUDEVString = entity.HtUnitAmountWithCurrency.ToString();
            model.PREV = entity.CostPrice;
            model.PREVString = entity.CostPrice.ToString();
            model.PVHT = entity.ConclusiveSellingPrice;
            model.PVHTString = entity.ConclusiveSellingPrice.ToString();
            if (entity.DocumentLineTaxe != null)
            {
                List<DocumentLineTaxeViewModel> listDocLineWithCalculableTaxe = entity.DocumentLineTaxe.Where(y => y.IdTaxeNavigation.IsCalculable && y.IdTaxeNavigation.TaxeValue != null).ToList();
                List<DocumentLineTaxeViewModel> listDocLineWithoutCalculableTaxe = entity.DocumentLineTaxe.Where(y => !y.IdTaxeNavigation.IsCalculable).ToList();
                model.VatTaxAmount = "-";
                if (listDocLineWithCalculableTaxe != null && listDocLineWithCalculableTaxe.Any())
                {
                    model.VatTaxAmount = string.Join(GenericConstants.CommaPers, listDocLineWithCalculableTaxe.Select(x => x.IdTaxeNavigation.TaxeValue.Value.ToString())) ?? "-";
                    if (model.VatTaxAmount != "-")
                    {
                        model.VatTaxAmount += "%";
                    }
                }
                else if (listDocLineWithoutCalculableTaxe != null && listDocLineWithoutCalculableTaxe.Any())
                {
                    double? taxeValue = listDocLineWithoutCalculableTaxe.First().TaxeValueWithCurrency;
                    model.VatTaxAmount = taxeValue!=null ? taxeValue.Value.ToString():"-";
                }
            }

            return model;
        }



    }
}
