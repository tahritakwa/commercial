using System.Collections.Generic;
using System.Globalization;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class EmployeeForImportExcelComparer : IEqualityComparer<EmployeeViewModel>
    {
        public bool Equals(EmployeeViewModel x, EmployeeViewModel y)
        {
            if((x != null) && (y != null)){
                return string.Compare(StringToSafe(x.Matricule), StringToSafe(y.Matricule), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.FirstName), StringToSafe(y.FirstName), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.LastName), StringToSafe(y.LastName), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.Cin), StringToSafe(y.Cin), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.SocialSecurityNumber), StringToSafe(y.SocialSecurityNumber), false, CultureInfo.CurrentCulture) == 0 &&
                        x.Sex == y.Sex &&
                        x.ChildrenNumber == y.ChildrenNumber &&
                        string.Compare(StringToSafe(x.PersonalPhone), StringToSafe(y.PersonalPhone), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.ProfessionalPhone), StringToSafe(y.ProfessionalPhone), false, CultureInfo.CurrentCulture) == 0 &&
                        x.BirthDate == y.BirthDate &&
                        string.Compare(StringToSafe(x.BirthPlace), StringToSafe(y.BirthPlace), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.AddressLine1), StringToSafe(y.AddressLine1), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.AddressLine2), StringToSafe(y.AddressLine2), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.AddressLine3), StringToSafe(y.AddressLine3), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.AddressLine4), StringToSafe(y.AddressLine4), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.AddressLine5), StringToSafe(y.AddressLine5), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.ZipCode), StringToSafe(y.ZipCode), false, CultureInfo.CurrentCulture) == 0 &&
                        x.HiringDate == y.HiringDate &&
                        string.Compare(StringToSafe(x.Email), StringToSafe(y.Email), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.Facebook), StringToSafe(y.Facebook), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.Linkedin), StringToSafe(y.Linkedin), false, CultureInfo.CurrentCulture) == 0 &&
                        x.Echelon == y.Echelon &&
                        ((!x.HomeLoan.HasValue && !y.HomeLoan.HasValue) || x.HomeLoan.Value.IsApproximately(y.HomeLoan.Value, within: 0.0001)) &&
                        x.ChildrenNoScholar == y.ChildrenNoScholar &&
                        x.ChildrenDisabled == y.ChildrenDisabled &&
                        x.IsForeign == y.IsForeign &&
                        x.DependentParent == y.DependentParent &&
                        string.Compare(StringToSafe(x.Rib), StringToSafe(y.Rib), false, CultureInfo.CurrentCulture) == 0 &&
                        string.Compare(StringToSafe(x.Category), StringToSafe(y.Category), false, CultureInfo.CurrentCulture) == 0 &&
                        x.FamilyLeader == y.FamilyLeader;
            }

            return false;
            
        }

        public int GetHashCode(EmployeeViewModel obj)
        {
            if (obj is null)
            {
                return 0;
            }                

            return obj.Matricule.GetHashCode() ^
                        obj.FirstName.GetHashCode() ^
                        obj.LastName.GetHashCode() ^
                        obj.Cin.GetHashCode() ^
                        obj.SocialSecurityNumber.GetHashCode() ^
                        obj.Sex.GetHashCode() ^
                        obj.ChildrenNumber.GetHashCode() ^
                        obj.PersonalPhone.GetHashCode() ^
                        obj.ProfessionalPhone.GetHashCode() ^
                        obj.BirthDate.GetHashCode() ^
                        obj.BirthPlace.GetHashCode() ^
                        obj.AddressLine1.GetHashCode() ^
                        obj.AddressLine2.GetHashCode() ^
                        obj.AddressLine3.GetHashCode() ^
                        obj.AddressLine4.GetHashCode() ^
                        obj.AddressLine5.GetHashCode() ^
                        obj.ZipCode.GetHashCode() ^
                        obj.HiringDate.GetHashCode() ^
                        obj.Email.GetHashCode() ^
                        obj.Facebook.GetHashCode() ^
                        obj.Linkedin.GetHashCode() ^
                        obj.Echelon.GetHashCode() ^
                        obj.HomeLoan.GetHashCode() ^
                        obj.ChildrenNoScholar.GetHashCode() ^
                        obj.ChildrenDisabled.GetHashCode() ^
                        obj.IsForeign.GetHashCode() ^
                        obj.DependentParent.GetHashCode() ^
                        obj.Rib.GetHashCode() ^
                        obj.Category.GetHashCode() ^
                        obj.FamilyLeader.GetHashCode();
        }

        private static string StringToSafe(string myString)
        {
            return myString ?? "";
        }
    }
}
