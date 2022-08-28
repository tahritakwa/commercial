using System.ComponentModel.DataAnnotations.Schema;

namespace Persistence.Entities
{
    public partial class Item
    {

        [NotMapped]
        public bool IsAvailable { get; set; }
        [NotMapped]
        public double AllAvailableQuantity { get; set; }
    }
}
