using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class CnssDeclarationViewModel : GenericViewModel
    {
        public string Title { get; set; }
        public int Trimester { get; set; }
        public int Year { get; set; }
        public double TotalAmount { get; set; }
        public int IdCnss { get; set; }
        public DateTime CreationDate { get; set; }
        public string DeletedToken { get; set; }
        public string Code { get; set; }
        public bool State { get; set; }
        public CnssViewModel IdCnssNavigation { get; set; }
        public ICollection<CnssDeclarationDetailsViewModel> CnssDeclarationDetails { get; set; }
        public ICollection<CnssDeclarationSessionViewModel> CnssDeclarationSession { get; set; }
    }
}
