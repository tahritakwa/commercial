using SparkIt.ModelView.GenericModule;
using SparkIt.ModelView.Inventory;
using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.Inventory
{
    public class OemItemViewModel : GenericViewModel
    {
        public int IdItem { get; set; }
        public int? IdBrand { get; set; }
        public string OemNumber { get; set; }
        public string DeletedToken { get; set; }


        public virtual VehicleBrandViewModel IdBrandNavigation { get; set; }

        public virtual ItemViewModel IdItemNavigation { get; set; }
    }
}
