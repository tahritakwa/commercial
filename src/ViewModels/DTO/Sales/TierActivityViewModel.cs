using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class TierActivityViewModel : GenericViewModel
    {
        public int DocumentId { get; set; }
        public string DocumentCode { get; set; }
        public string DocumentType { get; set; }
        public string ValidatorName { get; set; }
        public DateTime? ValidationDate { get; set; }
    }
}
