using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.Comparers
{
    public class DocumentWithholdingTaxComparer : IEqualityComparer<DocumentWithholdingTaxViewModel>
    {
        bool IEqualityComparer<DocumentWithholdingTaxViewModel>.Equals(DocumentWithholdingTaxViewModel x, DocumentWithholdingTaxViewModel y)
        {
            if (x == null && y != null || x != null && y == null)
            {
                return false;
            }
            return x.IdWithholdingTax == y.IdWithholdingTax;
        }

        int IEqualityComparer<DocumentWithholdingTaxViewModel>.GetHashCode(DocumentWithholdingTaxViewModel obj)
        {
            if (obj != null)
            {
             return obj.IdWithholdingTax.GetHashCode();
            }
            return 0;
        }
    }
}
