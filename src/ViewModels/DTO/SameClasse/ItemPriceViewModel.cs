using Newtonsoft.Json;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.SameClasse
{
    [Serializable]
    public class ItemPriceViewModel : ICloneable
    {
        public string DocumentType { get; set; }
        public DateTime DocumentDate { get; set; }
        public int IdTiers { get; set; }
        public int IdCurrency { get; set; }
        public DocumentLineViewModel DocumentLineViewModel { get; set; }
        public bool? IsBToB { get; set; }
        public bool? IsToImport { get; set; }
        public bool? isAllLinesAreAvailbles { get; set; }
        public List<DocumentLineViewModel> DocumentLines { get; set; }
        public int? InoicingType { get; set; }
        public bool? IsRestaurn { get; set; }
        public bool? RecalculateDiscount { get; set; }
       
       

        [JsonIgnore]
        public double exchangeRate { get; set; }

        [JsonIgnore]
        public Tiers Tiers { get; set; }

        [JsonIgnore]
        public Item Item { get; set; }

        [JsonIgnore]
        public Document Document { get; set; }

        [JsonIgnore]
        public int CompanyPrecison { get; set; }

        [JsonIgnore]
        public int TiersPrecison { get; set; }
        public DocumentType DocumentTypeObject { get; set; }

        [JsonIgnore]
        public bool IsTaxCalculable { get; set; }
        [JsonIgnore]
        public int TaxeType { get; set; }

        [JsonIgnore]
        public TaxeGroupTiers TaxeGroupTiers { get; set; }

        public object Clone()
        {
            return JsonConvert.DeserializeObject<ItemPriceViewModel>(JsonConvert.SerializeObject(this));
        }
    }
}
