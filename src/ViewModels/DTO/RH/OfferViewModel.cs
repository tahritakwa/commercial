using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class OfferViewModel : GenericViewModel
    {
        public int State { get; set; }
        public int IdCandidacy { get; set; }
        public string DeletedToken { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public double WorkingHoursPerWeek { get; set; }
        public double Salary { get; set; }
        public bool? ThirteenthMonthBonus { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? SendingDate { get; set; }
        public int IdSalaryStructure { get; set; }
        public int? IdEmail { get; set; }
        public int IdCnss { get; set; }
        public int IdContractType { get; set; }
        public string Token { get; set; }
        public double? MealVoucher { get; set; }
        public bool? AvailableCar { get; set; }
        public bool? AvailableHouse { get; set; }
        public int? CommissionType { get; set; }
        public double? CommissionValue { get; set; }


        public CandidacyViewModel IdCandidacyNavigation { get; set; }
        public SalaryStructureViewModel IdSalaryStructureNavigation { get; set; }
        public CnssViewModel IdCnssNavigation { get; set; }
        public ContractTypeViewModel IdContractTypeNavigation { get; set; }
        public EmailViewModel IdEmailNavigation { get; set; }
        public ICollection<AdvantagesViewModel> Advantages { get; set; }
        public ICollection<OfferBenefitInKindViewModel> OfferBenefitInKind { get; set; }
        public ICollection<OfferBonusViewModel> OfferBonus { get; set; }
    }
}
