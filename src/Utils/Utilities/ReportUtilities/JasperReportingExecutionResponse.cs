using System;
using System.Collections.Generic;

namespace Utils.Utilities.ReportUtilities
{
    /// <summary>
    /// Get the result of report excecution
    /// </summary>
    [Serializable]
    public partial class JasperReportingExecutionResponse
    {
        public string Status { get; set; }
        public long TotalPages { get; set; }
        public Guid RequestId { get; set; }
        public string ReportUri { get; set; }
        public List<Export> Exports { get; set; }
    }

    [Serializable]
    public partial class Export
    {
        public string Status { get; set; }
        public OutputResource OutputResource { get; set; }
        public Guid Id { get; set; }
    }

    [Serializable]
    public partial class OutputResource
    {
        public string ContentType { get; set; }
        public string FileName { get; set; }
        public bool OutputFinal { get; set; }
    }
}
