using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Payment
{
    public class CashRegisterViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public string Address { get; set; }
        public int Status { get; set; }
        public int IdWarehouse { get; set; }
        public int? IdResponsible { get; set; }
        public int? IdParentCash { get; set; }
        public int? IdCity { get; set; }
        public int? IdCountry { get; set; }
        public string AgentCode { get; set; }
        public CityViewModel IdCityNavigation { get; set; }
        public CountryViewModel IdCountryNavigation { get; set; }
        public CashRegisterViewModel IdParentCashNavigation { get; set; }
        public UserViewModel IdResponsibleNavigation { get; set; }
        public ICollection<CashRegisterViewModel> InverseIdPrincipalCashNavigation { get; set; }
        public  ICollection<SessionCashViewModel> SessionCash { get; set; }
        public WarehouseViewModel IdWarehouseNavigation { get; set; }
    }
}
