using System.Collections.Generic;

namespace ViewModels.DTO.DBConfig
{
    public class DBConfigViewModel
    {
        // Info Generale
        public List<string> ListOfModules { get; set; }
        public string SubscriptionId { get; set; }

        // Info Company
        public string OrganisationName { get; set; }
        public string Siret { get; set; }
        public string OrganisationPhone { get; set; }
        public string ActivityArea { get; set; }
        public string Currency { get; set; }
        public string Phone { get; set; }
        public string OrganisationTimeZone { get; set; }
        public string OrganisationWebsite { get; set; }
        public string taxRegistrationNumber { get; set; }
        // adresse company
        public string CountryName { get; set; }
        public string OrganisationAddress { get; set; }
        public string OrganisationCity { get; set; }
        public string OrganisationPostalCode { get; set; }
        public string OrganisationAdditionalAddress { get; set; }

        // Liscence company
        public string NumberOfUsers { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }

        // Info User
        public bool IsWithTecDoc { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string EmailUser { get; set; }
        public string Language { get; set; }

        public DBConfigViewModel()
        {

        }
      
    }
}
