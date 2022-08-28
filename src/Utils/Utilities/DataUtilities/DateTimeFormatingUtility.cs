using System;
using System.Globalization;
using Utils.Constants;

namespace Utils.Utilities.DataUtilities
{
    /// <summary>
    /// Defines the possible formatting types corresponding to the formatting provided by the Framework in the DateTimeFormatInfo class
    /// </summary>
    public enum DateFormat
    {
        ShortDateFormat,
        LongDateFormat,
        YearMonthDateFormat,
        MonthDayDateFormat
    }

    /// <summary>
    /// Date formatting utility
    /// </summary>
    public static class DateTimeFormatingUtility
    {
        /// <summary>
        /// Method allowing to format a date according to French or English culture. 
        /// The format is an enumeration defining the type of formatting desired and the second parameter for the type of culture to be used.
        /// </summary>
        /// <param name="dateTime"></param>
        /// <param name="dateFormat"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public static string Format(this DateTime dateTime, DateFormat dateFormat, string lang = "en")
        {
            // Create the culture from the language specified in parameter
            CultureInfo cultureInfo = lang.Equals(GenericConstants.English) ? CultureInfo.CreateSpecificCulture("en-US") : CultureInfo.CreateSpecificCulture("fr-FR");
            // Provides culture-specific information about the format of date value.
            DateTimeFormatInfo dateTimeFormatInfo = cultureInfo.DateTimeFormat;
            string pattern;
            switch (dateFormat)
            {
                case DateFormat.ShortDateFormat:
                    pattern = dateTimeFormatInfo.ShortDatePattern;
                    break;
                case DateFormat.LongDateFormat:
                    pattern = dateTimeFormatInfo.LongDatePattern;
                    break;
                case DateFormat.YearMonthDateFormat:
                    pattern = dateTimeFormatInfo.YearMonthPattern;
                    break;
                case DateFormat.MonthDayDateFormat:
                    pattern = dateTimeFormatInfo.MonthDayPattern;
                    break;
                default:
                    pattern = dateTimeFormatInfo.DateSeparator;
                    break;
            }
            // Capitalize the corresponding string returned
            return cultureInfo.TextInfo.ToTitleCase(dateTime.ToString(pattern, cultureInfo));
        }
    }
}
