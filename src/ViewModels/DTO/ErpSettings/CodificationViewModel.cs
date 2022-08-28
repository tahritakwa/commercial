using System.Collections.Generic;

namespace ViewModels.DTO.ErpSettings
{
    public class CodificationViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int? Rank { get; set; }
        public string Path { get; set; }
        public string Format { get; set; }
        public string InitValue { get; set; }
        public int? IdCodificationParent { get; set; }
        public bool? IsCounter { get; set; }
        public int? Step { get; set; }
        public string LastCounterValue { get; set; }
        public int? CounterLength { get; set; }
        public virtual CodificationViewModel IdCodificationParentNavigation { get; set; }
        public virtual ICollection<EntityCodificationViewModel> EntityCodification { get; set; }
        public ICollection<CodificationViewModel> ListCodificationChildrens { get; set; }
        public virtual ICollection<CodificationViewModel> InverseIdCodificationParentNavigation { get; set; }
    }
}
