using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Payment
{
    public class CashRegisterItemViewModel
    {
        public dynamic Id { get; set; }
        public string Text { get; set; }
        public int Type { get; set; }
        public int IdCity { get; set; }
        public string CityName { get; set; }
        public ICollection<CashRegisterItemViewModel> Items { get; set; }

        public CashRegisterItemViewModel() { }
        public CashRegisterItemViewModel(dynamic Id, string Text, int Type, int IdCity, ICollection<CashRegisterItemViewModel> Items = null, 
            string CityName = null)
        {
            this.Id = Id;
            this.Text = Text;
            this.Type = Type;
            this.IdCity = IdCity;
            this.Items = Items;
            this.CityName = CityName;
        }
    }
}
