using Newtonsoft.Json;
using System;
using Utils.Enumerators;
using Utils.Utilities.ConverterUtilities;

namespace Utils.Utilities.PredicateUtilities
{
    public class FilterViewModel : ICloneable
    {
        public Guid IdFilter { get; set; }
        public string Prop { get; set; }
        public Operation Operation { get; set; }
        public object Value { get; set; }
        public bool IsDynamicValue { get; set; }
        public bool IsSearchPredicate { get; set; }
        public int? Type { get; set; }
        public virtual PredicateFormatViewModel IdPredicateFormatNavigation { get; set; }

        public FilterViewModel(FilterViewModel filterViewModel)
        {
            IdFilter = filterViewModel.IdFilter;
            Prop = filterViewModel.Prop;
            Operation = filterViewModel.Operation;
            Value = filterViewModel.Value;
            IsDynamicValue = filterViewModel.IsDynamicValue;
            Type = filterViewModel.Type;
        }

        public FilterViewModel()
        {

        }

        public object Clone()
        {
            return JsonConvert.DeserializeObject<FilterViewModel>(JsonConvert.SerializeObject(this));
        }
    }
}
