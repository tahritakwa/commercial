using System.Collections.Generic;

namespace ViewModels.DTO.Utils
{
    public class OrganizationChartViewModel
    {
        public string label { get; set; }
        public DataOrganizationChartViewModel data { get; set; }
        public dynamic icon { get; set; }
        public IList<OrganizationChartViewModel> children { get; set; }
        public bool expanded { get; set; }
        public string type { get; set; }
        public OrganizationChartViewModel parent { get; set; }
        public bool selectable { get; set; }
        public bool hasChildren { get; set; }
    }

    public class DataOrganizationChartViewModel
    {
        public string name { get; set; }
        public string function { get; set; }
        public string styleClass { get; set; }
        public int idEmployee { get; set; }
        public int idJob { get; set; }
        public int idJobEmployee { get; set; }
        public string team { get; set; }
        public byte[] img { get; set; }
    }
}
