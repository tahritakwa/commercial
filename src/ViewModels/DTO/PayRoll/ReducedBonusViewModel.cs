using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedBonusViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        /// <summary>
        /// To memorize the minimum start date of the periodicity in order to carry out checks
        /// </summary>
        public DateTime StartDate { get; set; }
    }
}
