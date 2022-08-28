
using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Settings.Config
{
    [Serializable]
    public partial class Parameters
    {
        public List<ReportParameter> ReportParameter { get; set; }
    }

    [Serializable]
    public partial class ReportParameter
    {
        public string Name { get; set; }
        public List<dynamic> Value { get; set; }
    }

    public partial struct Value
    {
        public string String;
        public List<string> StringArray;
        public static implicit operator Value(string String) => new Value { String = String };
        public static implicit operator Value(List<string> StringArray) => new Value { StringArray = StringArray };
    }
}
