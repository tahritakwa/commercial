using System;
using System.Globalization;

namespace Utils.Utilities.DataUtilities
{
    public static class DateUtility
    {

        /// <summary>
        /// Generate Interview Date By Culture
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="culture"></param>
        /// <returns></returns>
        public static string GenerateDateByCulture(DateTime interviewDate, string culture)
        {
            string date = "";
            switch (culture)
            {
                case "fr":
                    date = interviewDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                    break;
                case "en":
                    date = interviewDate.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);
                    break;
                default:
                    date = interviewDate.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);
                    break;

            }

            return date;
        }

        public static string GenerateDateTimeByCulture(DateTime interviewDate, string culture)
        {
            string date = "";
            switch (culture)
            {
                case "fr":
                    date = interviewDate.ToString("dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);
                    break;
                case "en":
                    date = interviewDate.ToString("MM/dd/yyyy hh:mm tt", CultureInfo.InvariantCulture);
                    break;
                default:
                    date = interviewDate.ToString("MM/dd/yyyy hh:mm tt", CultureInfo.InvariantCulture);
                    break;

            }

            return date;
        }
        /// <summary>
        /// Generate Interview Time By Culture
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="culture"></param>
        /// <returns></returns>
        public static string GenerateTimeByCulture(DateTime interviewDate, string culture)
        {
            string time = "";
            switch (culture)
            {
                case "fr":
                    time = interviewDate.ToString("HH:mm", CultureInfo.InvariantCulture);
                    break;
                case "en":
                    time = interviewDate.ToString("hh:mm tt", CultureInfo.InvariantCulture);
                    break;
                default:
                    time = interviewDate.ToString("hh:mm tt", CultureInfo.InvariantCulture);
                    break;

            }

            return time;
        }
    }
}
