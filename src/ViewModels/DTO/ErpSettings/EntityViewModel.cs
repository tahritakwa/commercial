using System.Collections.Generic;
using ViewModels.DTO.Administration;

namespace ViewModels.DTO.ErpSettings
{
    public class EntityViewModel : GlobalizationViewModel
    {
        public string TableSchema { get; set; }
        public string EntityName { get; set; }
        public string TableName { get; set; }
        public bool? IsReference { get; set; }
        public int? IdRelatedEntity { get; set; }
        public ICollection<AxisEntityViewModel> AxisEntity { get; set; }
        public ICollection<EntityCodificationViewModel> EntityCodification { get; set; }
        public ICollection<EntityViewModel> InverseIdRelatedEntityNavigation { get; set; }
    }
}
