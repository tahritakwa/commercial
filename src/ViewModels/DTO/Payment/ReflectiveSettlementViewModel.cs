namespace ViewModels.DTO.Payment
{
    public class ReflectiveSettlementViewModel
    {
        public int Id { get; set; }
        public int IdSettlement { get; set; }
        public int IdGapSettlement { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public virtual SettlementViewModel IdSettlementNavigation { get; set; }
        public virtual SettlementViewModel IdSettlementReplacedNavigation { get; set; }
    }
}
