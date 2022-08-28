using System.IO;

namespace Utils.Constants.TreasuryConstants
{
    public class InvoiceRevivalEmailConstant
    {
        public string _lang;
        public InvoiceRevivalEmailConstant(string lang)
        {
            _lang = lang;
        }

        public string InvoiceRevivalEmailTemplateByCulture
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "InvoiceRevivalTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "InvoiceRevivalTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "InvoiceRevivalTemplate-en.html").Trim();
            }
        }

        public string GenerateInvoiceRevivalSubjectByCulture
        {
            get
            {
                if (_lang == "fr") return "Relance de paiement de factures";
                if (_lang == "en") return "Bill payment reminder";
                return "Bill payment reminder";
            }

        }



    }
}
