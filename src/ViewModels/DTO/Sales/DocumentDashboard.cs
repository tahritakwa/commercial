using System;

namespace ViewModels.DTO.Sales
{

    public class DocumentDashboard
    {
        ////BCC/ BEGIN CUSTOM CODE SECTION 
        ////ECC/ END CUSTOM CODE SECTION 

        public int Id { get; set; }
        public string Code { get; set; }
        public string Reference { get; set; }
        public int IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public int IdCategory { get; set; }
        public string CategoryName { get; set; }
        public double PercentageAmount { get; set; }
        public double PercentageQty { get; set; }
        public int DocumentMonth { get; set; }
        public string MonthName { get; set; }
        public int DocumentYear { get; set; }
        public string YearMonthName { get; set; }
        public DateTime DocumentDate { get; set; }
        public double? DocumentHtprice { get; set; }
        public int TotalNumber { get; set; }

    }
}
