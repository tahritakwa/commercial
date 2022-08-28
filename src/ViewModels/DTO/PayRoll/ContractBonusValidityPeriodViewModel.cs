using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class BonusValidityPeriodViewModel : GenericViewModel
    {
        public double Value { get; set; }
        public DateTime StartDate { get; set; }
        public int IdBonus { get; set; }
        public string DeletedToken { get; set; }

        public BonusViewModel IdBonusNavigation { get; set; }
    }
}
