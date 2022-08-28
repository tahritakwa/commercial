using System.IO;

namespace Utils.Constants
{
    public class EmailConstant
    {
        string _lang;
        public string Lang
        {
            get
            {
                return _lang;
            }
        }
        public EmailConstant(string lang)
        {
            if (string.IsNullOrEmpty(lang))
            {
                lang = "fr";
            }
            _lang = lang;
        }
        /** Payslip Constant Email **/
        public string SharingDocumentEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "SharingDocumentTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "SharingDocumentTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "SharingDocumentTemplate-en.html").Trim();
            }
        }
        public string PayslipEmailSubject
        {
            get
            {
                if (_lang == "fr") return "Bulletin de paie de la session ";
                if (_lang == "en") return "Payslip of the session ";
                return "Payslip of the session ";
            }
        }
        public string SourceDeductionEmailSubject
        {
            get
            {
                if (_lang == "fr") return "Retenue à la source ";
                if (_lang == "en") return "Source deduction ";
                return "Source deduction ";
            }
        }
        public string AccessToYourSpace
        {
            get
            {
                if (_lang == "fr") return "Accéder à votre espace";
                if (_lang == "en") return "Access to your space";
                return "Access to your space";
            }
        }
        public string SharedDocumentEmailSubject
        {
            get
            {
                if (_lang == "fr") return "Nouveau document partagé";
                if (_lang == "en") return "New shared document";
                return "New shared document";
            }
        }

        /** TimeSheet Constant Email **/
        public string TimeSheetTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "TimeSheetTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "TimeSheetTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "TimeSheetTemplate-en.html").Trim();
            }
        }
        public string TimeSheet
        {
            get
            {
                if (_lang == "fr") return "CRA";
                if (_lang == "en") return "TimeSheet";
                return "TimeSheet";
            }
        }

        public string TimesheetCorrectionSubject
        {
            get
            {
                if (_lang == "fr") return " - demande de correction";
                if (_lang == "en") return " - correction request";
                return " - correction request";
            }
        }

        public string TimesheetValidationRequestSubject
        {
            get
            {
                if (_lang == "fr") return " - demande de validation";
                if (_lang == "en") return " - validation request";
                return " - validation request";
            }
        }

        public string TimesheetValidationSubject
        {
            get
            {
                if (_lang == "fr") return " - validation";
                if (_lang == "en") return " - validation";
                return " - validation";
            }
        }

        public string TimesheetFillingRequestMessage
        {
            get
            {
                if (_lang == "fr") return "Veuillez s'il vous plait remplir votre CRA associé au mois de";
                if (_lang == "en") return "Please fill your timesheet associated to the month";
                return "Please fill your timesheet associated to the month";
            }
        }
        public string TimesheetSubmissionRequestMessage
        {
            get
            {
                if (_lang == "fr") return "Veuillez s'il vous plait soumettre votre CRA associé au mois de";
                if (_lang == "en") return "Please send your timesheet associated to the month";
                return "Please send your timesheet associated to the month";
            }
        }
        public string TimesheeRequestCorrection
        {
            get
            {
                if (_lang == "fr") return "Le CRA du mois de \"";
                if (_lang == "en") return "The timesheet of month \"";
                return "The timesheet of month \"";
            }
        }
        public string TimesheetEmployeeName
        {
            get
            {
                if (_lang == "fr") return "\" de l'employé ";
                if (_lang == "en") return "\" of the employee ";
                return "\" of the employee ";
            }
        }
        public string TimesheetCorrectionRequestMessage
        {
            get
            {
                if (_lang == "fr") return "nécessite une correction";
                if (_lang == "en") return "requires an correction";
                return "requires an correction";
            }
        }

        public string TimesheetValidationRequestMessage
        {
            get
            {
                if (_lang == "fr") return "Veuillez s'il vous plait valider le CRA associé au mois de";
                if (_lang == "en") return "Please validate the timesheet associated to the month";
                return "Please validate the timesheet associated to the month";
            }
        }

        public string TimesheetValidationMessage
        {
            get
            {
                if (_lang == "fr") return "a validé le CRA \"";
                if (_lang == "en") return "has validated the timesheet \"";
                return "has validated the timesheet \"";
            }
        }
        public string ForEmployee
        {
            get
            {
                if (_lang == "fr") return "Pour l'employé";
                if (_lang == "en") return "for the employee";
                return "for the employee";
            }
        }
        public string NotifNewUser
        {
            get
            {
                if (_lang == "fr") return "Création de compte Stark-ERP";
                if (_lang == "en") return "Creating of Stark-ERP Account";
                return "Creating of Stark-ERP Account";
            }
        }
        public string NotifNewUserEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-en.html").Trim();
            }
        }

    }
}
