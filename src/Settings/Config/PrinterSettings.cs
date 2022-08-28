using System.Collections.Generic;

namespace Settings.Config
{
    public class PrinterSettings
    {
        public string DefaultAction { get; set; }
        public IList<PrinterConfig> PrinterConfigs { get; set; }

        public PrinterSettings()
        {

        }
    }

}
