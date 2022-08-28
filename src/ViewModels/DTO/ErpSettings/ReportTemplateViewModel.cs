namespace ViewModels.DTO.ErpSettings
{
    public class ReportTemplateViewModel
    {
        public int Id { get; set; }
        public int? IdEntity { get; set; }
        public string TemplateCode { get; set; }
        public string TemplateNameFr { get; set; }
        public string TemplateNameEn { get; set; }
        public string text { get; set; }
        public string ReportCode { get; set; }
        public string ReportName { get; set; }
        public virtual EntityViewModel IdEntityNavigation { get; set; }
    }
}
