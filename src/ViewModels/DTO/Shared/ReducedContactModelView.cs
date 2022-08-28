using System.Collections.Generic;

namespace ViewModels.DTO.Shared
{
    public class ReducedContactModelView
    {

        public int? IdTiers { get; set; }
        public int? IdCompany { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Tel1 { get; set; }
        public string Fax1 { get; set; }
        public string Email { get; set; }
        public string Adress { get; set; }
        public int Type { get; set; }
        public ICollection<ContactTypeDocumentViewModel> ContactTypeDocument { get; set; }

    }
}
