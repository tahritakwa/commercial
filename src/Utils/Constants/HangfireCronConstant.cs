namespace Utils.Constants
{
    public static class HangfireCronConstant
    {
        public static string MidnightDaily
        {
            get { return "0 0 * * *"; }
        }
        public static string MidnightMonthly
        {
            get { return "0 0 1 * *"; }
        }
        public static string MidnightAnnually
        {
            get { return "0 0 31 12 *"; }
        }
        public static string EachTenMinute
        {
            get { return "*/10 * * * *"; }
        }
    }
}
