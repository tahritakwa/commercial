using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class UserWarehouseViewModel : GenericViewModel
    {
        public string UserMail { get; set; }
        public int? IdWarehouse { get; set; }
        public string WarehouseName { get; set; }
        public string DeletedToken { get; set; }
        public virtual WarehouseViewModel IdWarehouseNavigation { get; set; }
    }
}

