using System.IO;

namespace Utils.Constants.PayrollConstants
{
    public class LeaveBalanceRemainingEmailConstant
    {
        public string _lang;
        public LeaveBalanceRemainingEmailConstant(string lang)
        {
            _lang = lang;
        }

        public string LeaveBalanceRemainingSubject
        {
            get
            {
                if (_lang == "fr") return "Solde de congé de {YEAR}";
                if (_lang == "en") return "Leave balance of {YEAR}";
                return "Leave balance of ";
            }
        }

        public string LeaveBalanceRemainingTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveBalanceRemainingTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveBalanceRemainingTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RH-administrative-documents", "LeaveBalanceRemainingTemplate-en.html").Trim();
            }
        }
    }
}

