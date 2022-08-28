using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.Comparers
{
    public class BillingEmployeeIdComparer: IEqualityComparer<BillingEmployeeViewModel>
    {
         bool IEqualityComparer<BillingEmployeeViewModel>.Equals(BillingEmployeeViewModel x, BillingEmployeeViewModel y)
         {
                return (x.IdEmployee == y.IdEmployee);
         }   

        int IEqualityComparer<BillingEmployeeViewModel>.GetHashCode(BillingEmployeeViewModel obj)
        {
             if (ReferenceEquals(obj, null))
                 return 0;

                return (obj.IdEmployee.GetHashCode());
        }
    }
}
