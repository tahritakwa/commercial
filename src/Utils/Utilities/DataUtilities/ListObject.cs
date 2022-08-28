namespace Utils.Utilities.DataUtilities
{
    public class ListObject
    {
        private object _listData;
        private long _total;
        private double? _sum;

        public object listData { get => _listData; set => _listData = value; }
        public long total { get => _total; set => _total = value; }
        public double? sum { get => _sum; set => _sum = value; }
    }
}
