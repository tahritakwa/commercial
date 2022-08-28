using System.IO;

namespace ViewModels.DTO.RH
{
    public class OfferEmailContant
    {
        public string _lang;
        public OfferEmailContant(string lang)
        {
            _lang = lang;
        }

        public string OfferRequestEmailTemplateByCulture
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "OfferMailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "OfferMailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "OfferMailTemplate-en.html").Trim();
            }
        }
        
        public string GenerateOfferSubjectByCulture
        {
            get
            {
                if (_lang == "fr") return "Proposition d'offre d'embauche pour le poste: ";
                if (_lang == "en") return "Job offer proposal for the post: ";
                return "Job offer proposal for the post: ";
            }
        }
        public string OfferRejectedEmailTemplateByCulture
        {
            get
            {
                if (_lang == "fr") return Path.Combine("wwwroot", "views", "MallingTemplate", "RejectedMailTemplate-fr.html").Trim();
                if (_lang == "en") return Path.Combine("wwwroot", "views", "MallingTemplate", "RejectedMailTemplate-en.html").Trim();
                return Path.Combine("wwwroot", "views", "MallingTemplate", "RejectedMailTemplate-en.html").Trim();
            }
        }
        public string GenerateRejectedSubjectByCulture
        {
            get
            {
                if (_lang == "fr") return "Réponse a la candidature d'offre d'embauche pour le poste: ";
                if (_lang == "en") return "Response to the job offer application for the position: ";
                return "Candidacy rejected for the post: ";
            }
        }

        public string SalaryStructureByCulture
        {
            get
            {
                if (_lang == "fr") return "Type de contrat: ";
                if (_lang == "en") return "Salary structure: ";
                return "Salary structure: ";
            }
        }

        public string StartDateByCulture
        {
            get
            {
                if (_lang == "fr") return "Date de début: ";
                if (_lang == "en") return "Start date: ";
                return "Start date: ";
            }
        }
        public string EndtDateByCulture
        {
            get
            {
                if (_lang == "fr") return "Date de fin: ";
                if (_lang == "en") return "End date: ";
                return "End date: ";
            }
        }

        public string WorkingHoursPerWeekByCulture
        {
            get
            {
                if (_lang == "fr") return "Nombre d'heures de travail par semaine: ";
                if (_lang == "en") return "Number of hours of work per week: ";
                return "Number of hours of work per week: ";
            }
        }
        public string SalaryByCulture
        {
            get
            {
                if (_lang == "fr") return "Salaire: ";
                if (_lang == "en") return "Salary: ";
                return "Salary: ";
            }
        }
        public string SocialContributionByCulture
        {
            get
            {
                if (_lang == "fr") return "Cotisation sociale: ";
                if (_lang == "en") return "Social contribution: ";
                return "Social contribution: ";
            }
        }

        public string AdvantagesByCulture
        {
            get
            {
                if (_lang == "fr") return "Nous ajoutons les avantages ci-dessous: ";
                if (_lang == "en") return "We add the advantages below:";
                return "We add the advantages below:";
            }
        }
        public string BenefitInKindsByCulture
        {
            get
            {
                if (_lang == "fr") return "Nous vous offrons aussi les avantages en nature suivants: ";
                if (_lang == "en") return "We also offer you the following benefits in kind: ";
                return "We also offer you the following benefits in kind: ";
            }
        }
        public string BonusesByCulture
        {
            get
            {
                if (_lang == "fr") return "Nous vous offrons les primes suivantes: ";
                if (_lang == "en") return "We offer you the following bonuses: ";
                return "We also offer you the following benefits in kind: ";
            }
        }
        public string WithAValueOf
        {
            get
            {
                if (_lang == "fr") return " d'une valeur de: ";
                if (_lang == "en") return " with a value of: ";
                return " with a value of: ";
            }
        }
        public string ThirteenthMonthBonusByCulture
        {
            get
            {
                if (_lang == "fr") return "Prime 13ème mois ";
                if (_lang == "en") return "Premium 13th month ";
                return "Premium 13th month ";
            }
        }
        public string AvailableCarByCulture
        {
            get
            {
                if (_lang == "fr") return "Une voiture disponible ";
                if (_lang == "en") return "An available car ";
                return "An available car ";
            }
        }
        public string MealVoucherByCulture
        {
            get
            {
                if (_lang == "fr") return "Des tickets resto d'une valeur de: ";
                if (_lang == "en") return "Restaurant meal vouchers with a value of: ";
                return "Restaurant meal vouchers with a value of: ";
            }
        }
        public string AvailableHouseByCulture
        {
            get
            {
                if (_lang == "fr") return "Une maison disponible ";
                if (_lang == "en") return "An available house ";
                return "An available house ";
            }
        }
        public string CommissionByCulture
        {
            get
            {
                if (_lang == "fr") return "Une commission, ";
                if (_lang == "en") return "A commission, ";
                return "A commission, ";
            }
        }
        public string CommissionInProportionalByCulture
        {
            get
            {
                if (_lang == "fr") return "en proportion de: ";
                if (_lang == "en") return "in proportion to: ";
                return "in proportion to: ";
            }
        }
        public string CommissionInValueByCulture
        {
            get
            {
                if (_lang == "fr") return "une valeur de: ";
                if (_lang == "en") return "a value of: ";
                return "a value of: ";
            }
        }

        public string ValidFrom
        {
            get
            {
                if (_lang == "fr") return "valable à partir du";
                if (_lang == "en") return "valid from ";
                return "valid from ";
            }
        }

        public string Until
        {
            get
            {
                if (_lang == "fr") return "jusqu'au ";
                if (_lang == "en") return "until ";
                return "until ";
            }
        }
    }
}
