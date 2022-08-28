namespace Utils.Utilities.DataUtilities
{
    public class DataSourceResultWithSelections<T> : DataSourceResult<T>
    {
        public long totalSelection { get; set; }
    }
}
