namespace ModelView.AppConfig
{
    public class DataBaseAutoCreationConfig
    {
        public string PathOfSqlFiles { get; set; }
        public string SizeMDFFile { get; set; }
        public string MaxSizeMDFFile { get; set; }
        public string FileGrowthMDFFile { get; set; } 
        public string SizeLDFFile { get; set; }
        public string MaxSizeLDFFile { get; set; }
        public string FileGrowthLDFFile { get; set; }
        public string RefDataBase { get; set; }
        public string TecDocDataBase { get; set; }
        public string DataBaseAutoCreationURL { get; set; }
        public string AddSubscriptionId { get; set; }
        public string  AccountingDataBaseURL { get; set; }
        public string AccountingBaseURL { get; set; }

    }
}
