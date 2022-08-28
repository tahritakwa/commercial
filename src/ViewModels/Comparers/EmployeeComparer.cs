using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class EmployeeComparer : IEqualityComparer<EmployeeViewModel>
    {
        public bool Equals(EmployeeViewModel x, EmployeeViewModel y)
        {
            if(x == null || y == null)
            {
                throw new ArgumentException("");
            }
            return (x.Id == y.Id && x.LastName == y.LastName && x.FirstName == y.FirstName && x.Sex == y.Sex
                 && x.HiringDate == y.HiringDate && x.Matricule == y.Matricule);
        }

        public int GetHashCode(EmployeeViewModel obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode() ^
                obj.LastName.GetHashCode() ^
                obj.FirstName.GetHashCode() ^
                obj.Sex.GetHashCode() ^
                obj.HiringDate.GetHashCode() ^
                obj.Matricule.GetHashCode();
        }
    }
}
