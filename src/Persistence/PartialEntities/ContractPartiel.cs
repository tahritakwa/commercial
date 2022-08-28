using System.ComponentModel.DataAnnotations.Schema;

namespace Persistence.Entities
{
    public partial class Contract
    {
        [NotMapped]
        public string MatriculeEmployee
        {
            get { return ""; }
            set { }
        }
        [NotMapped]
        public double BaseSalaryValue
        {
            get { return 0; }
            set { }
        }
    }
}
