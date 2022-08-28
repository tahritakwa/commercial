using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class MobilityRequestViewModel : GenericViewModel
    {
        public int? Status { get; set; }
        public int IdEmployee { get; set; }
        public int IdCurrentOffice { get; set; }
        public int IdDestinationOffice { get; set; }
        public DateTime DesiredMobilityDate { get; set; }
        public DateTime? EffectifMobilityDate { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public bool IsCurrentUserTheDepartureOfficeManager { get; set; }
        public bool IsCurrentUserTheDestinationOfficeManager { get; set; }
        public int? IdCreationUser { get; set; }
        public string DeletedToken { get; set; }

        public UserViewModel IdCreationUserNavigation { get; set; }
        public OfficeViewModel IdCurrentOfficeNavigation { get; set; }
        public OfficeViewModel IdDestinationOfficeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}
