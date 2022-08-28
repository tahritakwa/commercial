using Settings.Exceptions;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        private void CheckAmountCeilling(TiersViewModel idTiersNavigation, double? documentTtcpriceWithCurrency)
        {
            if (idTiersNavigation != null && idTiersNavigation.IdTypeTiers == (int)TiersType.Customer
                && (idTiersNavigation.AuthorizedAmountInvoice != null)
                && (_serviceTiers.CalculateTotalAmountOfSalesDelivery(idTiersNavigation.Id) + documentTtcpriceWithCurrency) >
                ((idTiersNavigation.AuthorizedAmountInvoice ?? 0) + (idTiersNavigation.ProvisionalAuthorizedAmountDelivery ?? 0)))
            {
                throw new CustomException(CustomStatusCode.AuthorizedAmountExceeded);
            }

        }
    }
}



