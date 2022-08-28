using System.Collections.Generic;

namespace Utils.Utilities.DataUtilities
{
    public class DataSourceResult<T>
    {
        public long total { get; set; }
        public IList<T> data { get; set; }
        public double? sum { get; set; }
    }
}
