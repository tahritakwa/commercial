using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class BillingSessionViewModel : GenericViewModel
    {
        public string Title { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime Month { get; set; }
        public int State { get; set; }
        public string DeletedToken { get; set; }
        public IList<int> EmployeesIds { get; set; }
        public string Code { get; set; }
        public int? NumberOfNotGeneratedDocuments { get; set; }
        public ICollection<BillingEmployeeViewModel> BillingEmployee { get; set; }
        public ICollection<DocumentViewModel> GeneratedDocuments { get; set; }
    }
}
