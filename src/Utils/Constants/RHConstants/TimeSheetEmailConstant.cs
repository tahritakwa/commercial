using System.IO;

namespace Utils.Constants.RHConstants
{
    public class TimeSheetEmailConstant
    {
        public string _lang;
        public TimeSheetEmailConstant(string lang)
        {
            _lang = lang;
        }

        public string submitTimeSheet
        {
            get
            {
                if (_lang == "fr") return "soumettre CRA";
                if (_lang == "en") return "Submit Timesheet ";
                return "Submit Timesheet ";
            }
        }

        public string validateTimeSheet
        {
            get
            {
                if (_lang == "fr") return "validation CRA";
                if (_lang == "en") return "Validate Timesheet ";
                return "Validate Timesheet ";
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

        public string SubmitTimeSheetTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetSubmitMailReminderTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetSubmitMailReminderTemplate-en.html").Trim();
                return Path.Combine(" ", "wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetSubmitMailReminderTemplate-en.html").Trim();
            }
        }

        public string ValidateTimeSheetTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetValidateMailReminderTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetValidateMailReminderTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-timeSheet-mail-template", "TimeSheetValidateMailReminderTemplate-en.html").Trim();
            }
        }
    }
}
