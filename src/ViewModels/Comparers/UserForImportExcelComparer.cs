using System;
using System.Collections.Generic;
using System.Globalization;
using Utils.Constants;
using ViewModels.DTO.Shared;

namespace ViewModels.Comparers
{
    public class UserForImportExcelComparer : IEqualityComparer<UserViewModel>
    {
        public bool Equals(UserViewModel x, UserViewModel y)
        {
            if ((x != null) && (y != null))
            {
                return string.Compare(StringToSafe(x.Email), StringToSafe(y.Email), false, CultureInfo.CurrentCulture) == NumberConstant.Zero &&
                         string.Compare(StringToSafe(x.FirstName), StringToSafe(y.FirstName), false, CultureInfo.CurrentCulture) == 0 &&
                         string.Compare(StringToSafe(x.LastName), StringToSafe(y.LastName), false, CultureInfo.CurrentCulture) == 0 &&
                         string.Compare(StringToSafe(x.WorkPhone), StringToSafe(y.WorkPhone), false, CultureInfo.CurrentCulture) == 0 &&
                         string.Compare(StringToSafe(x.Phone), StringToSafe(y.Phone), false, CultureInfo.CurrentCulture) == 0 &&
                         string.Compare(StringToSafe(x.MobilePhone), StringToSafe(y.MobilePhone), false, CultureInfo.CurrentCulture) == 0;
            }
            return false;
        }

        public int GetHashCode(UserViewModel obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Email.GetHashCode();
        }
        private static string StringToSafe(string myString)
        {
            return myString ?? "";
        }
    }
}
