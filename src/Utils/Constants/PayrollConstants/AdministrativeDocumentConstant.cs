using System.IO;

namespace Utils.Constants.PayrollConstants
{
    public class AdministrativeDocumentConstant
    {
        string _lang;
        public AdministrativeDocumentConstant(string lang)
        {
            if (string.IsNullOrEmpty(lang))
            {
                lang = "fr";
            }
            _lang = lang;
        }


        public string Creating
        {
            get
            {
                if (_lang == "fr") return "Creation ";
                if (_lang == "en") return "Creation ";
                return "Creation ";
            }
        }

        public string Adding
        {
            get
            {
                if (_lang == "fr") return "Ajout ";
                if (_lang == "en") return "Addition ";
                return "Addition ";
            }
        }
        public string Updating
        {
            get
            {
                if (_lang == "fr") return "Modification ";
                if (_lang == "en") return "Edition ";
                return "Edition ";
            }
        }
        public string Deletion
        {
            get
            {
                if (_lang == "fr") return "Suppression ";
                if (_lang == "en") return "Deletion ";
                return "Deletion ";
            }
        }
        public string Validation
        {
            get
            {
                if (_lang == "fr") return "Validation ";
                if (_lang == "en") return "Validation ";
                return "Validation ";
            }
        }
        public string Rejection
        {
            get
            {
                if (_lang == "fr") return "Refus ";
                if (_lang == "en") return "Refusal ";
                return "Refusal ";
            }
        }
        public string Cancellation
        {
            get
            {
                if (_lang == "fr") return "Annulation ";
                if (_lang == "en") return "cancellation ";
                return "cancellation ";
            }
        }
        // Leave Request Constants 
        public string LeaveRequest
        {
            get
            {
                if (_lang == "fr") return "d'une demande de congé";
                if (_lang == "en") return "of a leave request";
                return "of a leave request";
            }
        }

        public string NotifNewUserEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-en.html").Trim();
                return Path.Combine(" ", "wwwroot", "views", "MallingTemplate", "NotifNewUserEmailTemplate-en.html").Trim();
            }
        }

        public string LeaveRequestEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveEmailTemplate-en.html").Trim();
            }
        }
        public string LeaveRequestEmailUpdateTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveUpdateEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveUpdateEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveUpdateEmailTemplate-en.html").Trim();
            }
        }

        public string NotifNewUser
        {
            get
            {
                if (_lang == "fr") return "de compte Stark-ERP";
                if (_lang == "en") return "of Stark-ERP Account";
                return "of Stark-ERP Account";
            }
        }

        // document Request Constants
        public string DocumentRequest
        {
            get
            {
                if (_lang == "fr") return "d'une demande de document";
                if (_lang == "en") return "of a document request";
                return "of a document request";
            }
        }
        public string DocumentRequestEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestEmailTemplate-en.html").Trim();
            }
        }
        public string DocumentRequestEmailUpdateTemplate
        {
            get
            {

                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestUpdateEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestUpdateEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "DocumentRequestUpdateEmailTemplate-en.html").Trim();
            }
        }

        // Expense Report Constants
        public string ExpenseReport
        {
            get
            {
                if (_lang == "fr") return "d'une note de frais";
                if (_lang == "en") return "of an expense report";
                return "of an expense report";
            }
        }
        public string ExpenseReportEmailTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportEmailTemplate-en.html").Trim();
            }
        }
        public string ExpenseReportEmailUpdateTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportUpdateEmailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportUpdateEmailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "ExpenseReportUpdateEmailTemplate-en.html").Trim();
            }
        }
        public string ExpenseReportDetails
        {
            get
            {
                if (_lang == "fr") return "Détails de la note de frais";
                if (_lang == "en") return "Details of the expense report";
                return "Details of the expense report";
            }

        }
        public string Description
        {
            get
            {
                if (_lang == "fr") return "Description";
                if (_lang == "en") return "Description";
                return "Description";
            }

        }
        public string Type
        {
            get
            {
                if (_lang == "fr") return "Type";
                if (_lang == "en") return "Type";
                return "Type";
            }
        }

        public string Date
        {
            get
            {
                if (_lang == "fr") return "Date";
                if (_lang == "en") return "Date";
                return "Date";
            }
        }
        public string Amount
        {
            get
            {
                if (_lang == "fr") return "Montant";
                if (_lang == "en") return "Amount";
                return "Amount";
            }
        }
        public string Currency
        {
            get
            {
                if (_lang == "fr") return "Devise";
                if (_lang == "en") return "Currency";
                return "Currency";
            }
        }

        public string AddingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a ajouté une demande de congé";
                if (_lang == "en") return "added a leave request";
                return "added a leave request";
            }
        }
        public string UpdatingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a modifié la demande de congé";
                if (_lang == "en") return "updated the leave request";
                return "updated the leave request";
            }
        }
        public string ValidatingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a validé la demande de congé de";
                if (_lang == "en") return "validated the leave request of";
                return "validated the leave request of";
            }
        }
        public string RejectingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a refusé la demande de congé de";
                if (_lang == "en") return "rejected the leave request of";
                return "rejected the leave request of";
            }
        }
        public string CancellingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a annulé la demande de congé de";
                if (_lang == "en") return "canceled the leave request of";
                return "canceled the leave request of";
            }
        }

        public string DeletingLeaveRequest
        {
            get
            {
                if (_lang == "fr") return "a supprimé une demande de congé";
                if (_lang == "en") return "deleted a leave request";
                return "deleted a leave request";
            }
        }

        public string Of
        {
            get
            {
                if (_lang == "fr") return "de";
                if (_lang == "en") return "of";
                return "of";
            }
        }
        public string AddingExpenseReport
        {
            get
            {
                if (_lang == "fr") return "a ajouté une demande de note de frais";
                if (_lang == "en") return "added a new expense report";
                return "added a new expense report";
            }
        }

        public string UpdatingExpenseReport
        {
            get
            {
                if (_lang == "fr") return "a modifié la demande de note de frais";
                if (_lang == "en") return "updated the expense report";
                return "updated the expense report";
            }
        }

        public string For
        {
            get
            {
                if (_lang == "fr") return "pour";
                if (_lang == "en") return "for";
                return "for";
            }
        }

        public string Code
        {
            get
            {
                return "Code";
            }
        }

        public string DeletingExpenseReport
        {
            get
            {
                if (_lang == "fr") return "a supprimé une demande de note de frais";
                if (_lang == "en") return "deleted an expense report request";
                return "deleted an expense report request";
            }
        }

        public string ExpenseReportValidation
        {
            get
            {
                if (_lang == "fr") return "a validé la demande de note de frais";
                if (_lang == "en") return "validated the expense report request";
                return "validated the expense report request";
            }
        }

        public string ExpenseReportRejection
        {
            get
            {
                if (_lang == "fr") return "a refusé la demande de note de frais";
                if (_lang == "en") return "refused the expense report";
                return "refused the expense report";
            }
        }

        public string AddingDocumentRequest
        {
            get
            {
                if (_lang == "fr") return "a ajouté une demande de document";
                if (_lang == "en") return "added a document request";
                return "added a document request";
            }
        }
        public string UpdatingDocumentRequest
        {
            get
            {
                if (_lang == "fr") return "a modifié la demande de document";
                if (_lang == "en") return "updated the document request";
                return "updated the document request";
            }
        }
        public string ValidatingDocumentRequest
        {
            get
            {
                if (_lang == "fr") return "a validé la demande de document";
                if (_lang == "en") return "validated the document request";
                return "validated the document request";
            }
        }
        public string RejectingDocumentRequest
        {
            get
            {
                if (_lang == "fr") return "a refusé la demande de document";
                if (_lang == "en") return "rejected the document request";
                return "rejected the document request";
            }
        }

        public string DeletingDocumentRequest
        {
            get
            {
                if (_lang == "fr") return "a supprimé une demande de document";
                if (_lang == "en") return "deleted a document request";
                return "deleted a document request";
            }
        }
    }
}
