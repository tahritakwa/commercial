using System.Globalization;

namespace Utils.Utilities.DataUtilities
{
    public static class CurrencyUtility
    {


        /// <summary>
        /// GenerateCurrencyByCulture
        /// </summary>
        /// <param name="currency"></param>
        /// <param name="precision"></param>
        /// <param name="symbol"></param>
        /// <param name="culture"></param>
        /// <returns></returns>
        public static string GenerateCurrencyByCulture(double amount, int precision, string currencySymbol, string culture)
        {
            string amountInString;
            CultureInfo cultureInfo = new CultureInfo("en-US");
            switch (culture)
            {
                case "fr":
                    cultureInfo = new CultureInfo("fr-FR");
                    amountInString = string.Format(cultureInfo, "{1}{0:n" + precision + "}",  " " + currencySymbol, amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                case "fr-FR":
                    cultureInfo = new CultureInfo("fr-FR");
                    amountInString = string.Format(cultureInfo, "{1}{0:n" + precision + "}",  " " + currencySymbol, amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                case "en":
                    amountInString = string.Format(cultureInfo, "{0}{1:n" + precision + "}", currencySymbol + " ", amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                case "en-US":
                    amountInString = string.Format(cultureInfo, "{0}{1:n" + precision + "}", currencySymbol + " ", amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                default:
                    amountInString = string.Format(cultureInfo, "{0}{1:n" + precision + "}", currencySymbol + " ", amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
            }
            return amountInString;
        }
        public static string GenerateCurrencyByCulture(double amount, int precision, string culture)
        {
            string amountInString;
            CultureInfo cultureInfo = new CultureInfo("en-US");
            switch (culture)
            {
                case "fr":
                    cultureInfo = new CultureInfo("fr-FR");
                    amountInString = string.Format(cultureInfo, "{1}{0:n" + precision + "}", " " + amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                case "en":
                    amountInString = string.Format(cultureInfo, "{0}{1:n" + precision + "}" + " ", amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
                default:
                    amountInString = string.Format(cultureInfo, "{0}{1:n" + precision + "}" + " ", amount.ToString($"n{0}" + precision, cultureInfo));
                    break;
            }
            return amountInString;
        }
    }
}
