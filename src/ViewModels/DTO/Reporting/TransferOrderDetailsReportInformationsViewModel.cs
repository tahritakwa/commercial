using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class TransferOrderDetailsReportInformationsViewModel
    {
        public string EmployeeFullName { get; set; }
        public string Rib { get; set; }
        public string Label { get; set; }
        public double Amount { get; set; }
    }
}
