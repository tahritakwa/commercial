using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Payroll
{
    public class EmployerDeclarationViewModel
    {
        public DateTime Year { get; set; }
        public string CompanyName { get; set; }
        public string ItemCode { get; set; }
        public string Code { get; set; }
        public string CompanyTaxRegistrationNumber { get; set; }
        public long NumberOfRecipient { get; set; }
        public long NumberOfPage { get; set; }
        public IList<EmployerDeclarationLinesViewModel> EmployerDeclarationLinesViewModels { get; set; }
    }
}
