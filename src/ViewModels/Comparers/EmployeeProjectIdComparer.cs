using System.Collections.Generic;
using ViewModels.DTO.RH;

namespace ViewModels.Comparers
{
    public class EmployeeProjectIdComparer : IEqualityComparer<EmployeeProjectViewModel>
    {
        bool IEqualityComparer<EmployeeProjectViewModel>.Equals(EmployeeProjectViewModel x, EmployeeProjectViewModel y)
        {
            return (x.Id == y.Id);
        }

        int IEqualityComparer<EmployeeProjectViewModel>.GetHashCode(EmployeeProjectViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return (obj.IdEmployee.GetHashCode());
        }
    }
}
