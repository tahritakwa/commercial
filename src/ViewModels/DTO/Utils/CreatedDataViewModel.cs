using System.Collections.Generic;

namespace ViewModels.DTO.Utils
{
    public class CreatedDataViewModel
    {
        public int Id { get; set; }

        public string Code { get; set; } = "";
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public string Reference { get; set; } = "";
        public string EntityName { get; set; } = "";
        public IList<string> ListOfData { get; set; } = new List<string>();
        public IList<int> ListInt { get; set; } = new List<int>();
        public IList<CreatedDataViewModel> ListOfCreatedData { get; set; } = new List<CreatedDataViewModel>();
    }
}
