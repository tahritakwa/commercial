namespace ViewModels.DTO.ErpSettings
{
    public class EntityCodificationViewModel
    {
        public int Id { get; set; }
        public int? IdEntity { get; set; }
        public string Property { get; set; }
        public string Value { get; set; }
        public int? IdCodification { get; set; }
        public virtual EntityViewModel IdEntityNavigation { get; set; }
    }
}
