using System.IO;

namespace Utils.Constants.RHConstants
{
    public class AnnualReviewEmailConstant
    {
        public string _lang;
        public AnnualReviewEmailConstant(string lang)
        {
            _lang = lang;
        }

        public string AnnualInterview
        {
            get
            {
                if (_lang == "fr") return "l'Entretien Annuel ";
                if (_lang == "en") return "Annual Interview ";
                return "Annual Interview ";
            }
        }

        public string Reminder
        {
            get
            {
                if (_lang == "fr") return " - Rappel";
                if (_lang == "en") return " - Reminder";
                return " - Reminder";
            }
        }

        public string SamePerson
        {
            get
            {
                if (_lang == "fr") return "que votre entretien";
                if (_lang == "en") return "your interview";
                return "your interview";
            }
        }

        public string DifferentPerson
        {
            get
            {
                if (_lang == "fr") return "que l'entretien de";
                if (_lang == "en") return "the interview of";
                return "the interview of";
            }
        }

        public string CancellationReason
        {
            get
            {
                if (_lang == "fr") return "Motif d'annulation: ";
                if (_lang == "en") return "Cancellation reason: ";
                return "Cancellation reason: ";
            }
        }

        public string AnnualReviewTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "AnnualReviewMailReminderTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "AnnualReviewMailReminderTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "AnnualReviewMailReminderTemplate-en.html").Trim();
            }
        }

        public string AnnualInterviewInterviewerInvitation
        {
            get
            {
                if (_lang == "fr") return "Invitation de participation à un entretien annuel";
                if (_lang == "en") return "Invitation to participate in an annual review";
                return "Invitation to participate in an annual review";
            }
        }

        public string AnnualInterviewCancelInterview
        {
            get
            {
                if (_lang == "fr") return "Annulation d'entretien Annuel";
                if (_lang == "en") return "Cancel Annual Review";
                return "Cancel Annual Review";
            }
        }

        public string ExitEmployeeMeetingCancelInterview
        {
            get
            {
                if (_lang == "fr") return "Annulation d'une réunion de sortie employé";
                if (_lang == "en") return "Cancel exit employee meeting";
                return "Cancel exit employee meeting";
            }
        }

        public string InterviewMailCancellationTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewMailCancellationTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewMailCancellationTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewMailCancellationTemplate-en.html").Trim();
            }
        }
        public string InterviewerInvitationForInterview
        {
            get
            {
                if (_lang == "fr") return "Invitation à un entretien";
                if (_lang == "en") return "Invitation for an interview";
                return "Invitation for an interview";
            }
        }
        public string ExitEmployeeInterviewInvitationForInterviewer
        {
            get
            {
                if (_lang == "fr") return "Invitation à un entretien pour une sortie employé";
                if (_lang == "en") return "Invitation to an interview for an employee exit";
                return "Invitation to an interview for an employee exit";
            }
        }
        public string InterviewInvitationTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewInvitationTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewInvitationTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "InterviewInvitationTemplate-en.html").Trim();
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

        public string RequiredInterviewers
        {
            get
            {
                if (_lang == "fr") return "Interviewers requis";
                if (_lang == "en") return "Required interviewers";
                return "Required interviewers";
            }
        }
        public string OptionalInterviewers
        {
            get
            {
                if (_lang == "fr") return "Interviewers facultatifs";
                if (_lang == "en") return "Optional interviewers";
                return "Required interviewers";
            }
        }

        public string UpdateInterviewersList
        {
            get
            {
                if (_lang == "fr") return "Mise à jour de la liste des interviewers";
                if (_lang == "en") return "Update of the interviewer list";
                return "Update of the interviewer list";
            }
        }

        public string PostponedInterview
        {
            get
            {
                if (_lang == "fr") return "Entretien reporté";
                if (_lang == "en") return "Postponed interview";
                return "Postponed interview";
            }
        }

        public string PostponedInterviewEmailInvitationTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "PostponedInterviewEmailInvitationTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "PostponedInterviewEmailInvitationTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-interview-mail-template", "PostponedInterviewEmailInvitationTemplate-en.html").Trim();
            }
        }

        public string EmployeeExitMeeting
        {
            get
            {
                if (_lang == "fr") return " une réunion de sortie employé";
                if (_lang == "en") return " in an employee exit meeting";
                return " in an employee exit meeting";
            }
        }
        public string AnnualReviewInterview
        {
            get
            {
                if (_lang == "fr") return "l'entretien annuel";
                if (_lang == "en") return "the annual review";
                return "the annual review";
            }
        }
        public string AnnualReview
        {
            get
            {
                if (_lang == "fr") return "un entretien annuel";
                if (_lang == "en") return "an annual review";
                return "an annual review";
            }
        }

        public string MeetingEmployeeInvitation
        {
            get
            {
                if (_lang == "fr") return "Invitation pour une réunion";
                if (_lang == "en") return "Meeting invitation";
                return "Meeting invitation";
            }
        }

        public string Interview
        {
            get
            {
                if (_lang == "fr") return "un entretien";
                if (_lang == "en") return "an interview";
                return "an interview";
            }
        }
        public string CanceledInterview
        {
            get
            {
                if (_lang == "fr") return "Entretien annulé";
                if (_lang == "en") return "Canceled interview";
                return "Canceled interview";
            }
        }
    }
}
