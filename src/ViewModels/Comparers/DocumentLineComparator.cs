using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.Comparers
{
    public class DocumentLineComparator : IEqualityComparer<DocumentLineViewModel>
    {
        public bool Equals(DocumentLineViewModel x, DocumentLineViewModel y)
        {
            if (x.IdItem == y.IdItem && x.IdDocumentNavigation.DocumentTypeCode != y.IdDocumentNavigation.DocumentTypeCode)
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(DocumentLineViewModel obj)
        {
            return obj.IdItem.GetHashCode();
        }
    }

    public class DocumentLineWarhousecComparator : IEqualityComparer<DocumentLineViewModel>
    {
        public bool Equals(DocumentLineViewModel x, DocumentLineViewModel y)
        {
            if (x.IdItem == y.IdItem && x.IdWarehouse == y.IdWarehouse)
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(DocumentLineViewModel obj)
        {
            return obj.IdItem.GetHashCode();
        }
    }

    public class ProvisioningDetailsComparator : IEqualityComparer<ProvisioningDetails>
    {
        public bool Equals(ProvisioningDetails x, ProvisioningDetails y)
        {
            if (x.IdItem == y.IdItem)
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(ProvisioningDetails obj)
        {
            return obj.IdItem.GetHashCode();
        }
    }
    public class TiersProvisioningComparator : IEqualityComparer<TiersProvisioning>
    {
        public bool Equals(TiersProvisioning x, TiersProvisioning y)
        {
            if (x.IdTiers == y.IdTiers)
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(TiersProvisioning obj)
        {
            return obj.IdTiers.GetHashCode();
        }
    }
}
