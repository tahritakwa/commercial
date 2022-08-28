﻿namespace Utils.Enumerators
{
    public static class MonthsEnumerator
    {
        public const string Janvier = "Jan";
        public const string Fevrier = "Feb";
        public const string Mars = "Mar";
        public const string Avril = "Apr";
        public const string Mai = "May";
        public const string Juin = "June";
        public const string Juillet = "July";
        public const string Aout = "Aug";
        public const string Septembre = "Sept";
        public const string Octobre = "Oct";
        public const string Novembre = "Nov";
        public const string Decembre = "Dec";

        public static string GetMonthName(int monthNumber)
        {

            switch (monthNumber)
            {
                case 1:
                    return Janvier;
                case 2:
                    return Fevrier;
                case 3:
                    return Mars;
                case 4:
                    return Avril;
                case 5:
                    return Mai;
                case 6:
                    return Juin;
                case 7:
                    return Juillet;
                case 8:
                    return Aout;
                case 9:
                    return Septembre;
                case 10:
                    return Octobre;
                case 11:
                    return Novembre;
                case 12:
                    return Decembre;
                default: return "";
            }
        }
    }
}
