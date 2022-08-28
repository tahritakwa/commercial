using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class VariableComparer : IEqualityComparer<VariableViewModel>
    {
        public bool Equals(VariableViewModel x, VariableViewModel y)
        {
            if (x == null || y == null)
            {
                return false;
            }
            return x.Id == y.Id && 
                x.IdRuleUniqueReferenceNavigation != null && y.IdRuleUniqueReferenceNavigation != null
                    ? x.IdRuleUniqueReferenceNavigation.Reference == y.IdRuleUniqueReferenceNavigation.Reference:
                    x.Reference == y.Reference;
        }

        public int GetHashCode(VariableViewModel obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode() ^
                obj.IdRuleUniqueReference.GetHashCode();
        }
    }
}
