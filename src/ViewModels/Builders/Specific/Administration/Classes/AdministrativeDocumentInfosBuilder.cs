using System;
using System.Collections.Generic;
using System.Text;
using Utils.Constants.PayrollConstants;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Administration.Classes
{
    public static class AdministrativeDocumentInfosBuilder
    {
        #region constants
        public const string CREATOR = "{CREATOR}";
        public const string DOC_CODE = "{DOC_CODE}";
        public const string PROFIL = "{PROFIL}";

        #endregion
        public static string PrepareMessage(UserViewModel user, EmployeeViewModel connectedEmployee, MessageViewModel msgVM, MailBrodcastConfigurationViewModel configMail)
        {
            StringBuilder msgBuilder = new StringBuilder();
            IDictionary<string, dynamic> Parameters = new Dictionary<string, dynamic>();
            switch (user.Lang)
            {
                case "fr":
                    msgBuilder.Append(msgVM.IdInformationNavigation.Fr);
                    break;
                case "en":
                    msgBuilder.Append(msgVM.IdInformationNavigation.En);
                    break;
                case "de":
                    msgBuilder.Append(msgVM.IdInformationNavigation.De);
                    break;
                case "ar":
                    msgBuilder.Append(msgVM.IdInformationNavigation.Ar);
                    break;
            }
            string msg = msgBuilder.ToString();
            if (JsonParser.ValidateJSON(configMail.Model.Code))
            {
                Parameters = JsonParser.GetParameters(configMail.Model.Code);
            }
            if (msg.IndexOf(CREATOR) > -1)
            {
                msg = msg.Replace(CREATOR, connectedEmployee.FullName, StringComparison.OrdinalIgnoreCase);
            }
            if (msg.IndexOf(DOC_CODE) > -1)
            {
                msg = msg.Replace(DOC_CODE, Parameters["DOC_CODE"].ToString(), StringComparison.OrdinalIgnoreCase);
            }
            if (msg.IndexOf(PROFIL) > -1)
            {
                msg = msg.Replace(PROFIL, Parameters["PROFIL"].ToString(), StringComparison.OrdinalIgnoreCase);
            }
            return msg;
        }
        public static string PrepareSubject(string action, string entityName, string culture)
        {
            AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(culture);
            StringBuilder subject = new StringBuilder();
            switch (action)
             {
                    case "ADDING":
                        subject.Append(administrativeDocumentConstant.Adding);
                        break;
                    case "CREATING":
                        subject.Append(administrativeDocumentConstant.Creating);
                        break;
                    case "UPDATING":
                        subject.Append(administrativeDocumentConstant.Updating);
                        break;
                    case "DELETION":
                        subject.Append(administrativeDocumentConstant.Deletion);
                        break;
                    case "VALIDATION":
                        subject.Append(administrativeDocumentConstant.Validation);
                        break;
                    case "REJECTION":
                        subject.Append(administrativeDocumentConstant.Rejection);
                        break;
                    case "CANCELLATION":
                        subject.Append(administrativeDocumentConstant.Cancellation);
                        break;
                    default:
                        break;
            }
          
            subject.Append(entityName);
            return subject.ToString();
        }
    }
}
