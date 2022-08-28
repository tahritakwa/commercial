using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class DeliveryTypeViewModel : GenericViewModel
    {
       
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }

        public virtual ICollection<DocumentViewModel> Document { get; set; }
    }
}
