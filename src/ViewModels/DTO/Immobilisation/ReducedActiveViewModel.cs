using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Immobilisation
{
    public class ReducedActiveViewModel : GenericViewModel
    {

        public string Label { get; set; }

        public int Status { get; set; }
        public int? IdDocumentLine { get; set; }
        public double Value { get; set; }
        public int? IdCategory { get; set; }
        public string Code { get; set; }
        public string DeletedToken { get; set; }
        public string NumSerie { get; set; }
        public string Description { get; set; }
        public DateTime? AcquisationDate { get; set; }
        public DateTime? ServiceDate { get; set; }

    }
}
