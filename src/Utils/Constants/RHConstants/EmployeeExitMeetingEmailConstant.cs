using System.IO;

namespace Utils.Constants.RHConstants
{
    public class EmployeeExitMeetingEmailConstant
    {
        public string _lang;
        public EmployeeExitMeetingEmailConstant(string lang)
        {
            _lang = lang;
        }

        public string MaterialRecoveryTemplate
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "MaterialRecoveryMailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "MaterialRecoveryMailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "MaterialRecoveryMailTemplate-en.html").Trim();
            }
        }
        public string MaterialRecoverySubject
        {
            get
            {
                if (_lang == "fr") return "Demande de mise à disposition du matériel nécessaire au fonctionnement de l'entreprise";
                if (_lang == "en") return "Request for the provision of the equipment necessary for the operation of the business";
                return "Request for the provision of the equipment necessary for the operation of the business";
            }
        }




    }
}
