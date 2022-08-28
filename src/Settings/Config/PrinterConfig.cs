using System.Collections.Generic;

namespace Settings.Config
{
    public class PrinterConfig
    {
        public string Id { get; set; }
        public string IsDefault { get; set; }
        public string ServerAddress { get; set; }
        public string ReportName { get; set; }
        public string PrinterName { get; set; }
        public string DocumentCode { get; set; }

        public PrinterConfig()
        {

        }

    }

}
