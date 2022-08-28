using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SourceDeductionViewModel : GenericViewModel
    {
        public DateTime CreationDate { get; set; }
        public int Year { get; set; }
        public int Status { get; set; }
        public double TaxableWages { get; set; }
        public double NaturalAdvantage { get; set; }
        public double GrossTaxable { get; set; }
        public double RetainedReinvested { get; set; }
        public double SumIrpp { get; set; }
        public double Css { get; set; }
        public double NetToPay { get; set; }
        public string DeletedToken { get; set; }
        public int IdSourceDeductionSession { get; set; }
        public int IdEmployee { get; set; }

        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual SourceDeductionSessionViewModel IdSourceDeductionSessionNavigation { get; set; }

        // Flag for know if the generated source deduction is wrong or not
        public bool Wrong { get; set; }
        public string ErrorMessage { get; set; }

        public SourceDeductionViewModel()
        {

        }
        public SourceDeductionViewModel(int idEmployee, int idSourceDeductionSession, int year)
        {
            IdEmployee = idEmployee;
            IdSourceDeductionSession = idSourceDeductionSession;
            Year = year;
            NaturalAdvantage = default;
            GrossTaxable = default;
            RetainedReinvested = default;
            SumIrpp = default;
            Css = default;
        }

    }
}
