using Humanizer;
using Persistence.Entities;
using System;
using System.Globalization;
using System.Text;
using System.Threading;

namespace ViewModels.Comparers
{
    /// <summary>
    /// HumanizerUtils
    /// </summary>
    public class HumanizerUtils
    {
        /// <summary>
        /// This method humanize an amount using humananizer framework
        /// </summary>
        /// <param name="number">amount to convert</param>
        /// <param name="culture">the language to use in convertion</param>
        /// <param name="currency">used to concatinate amount in letter with the currency in letter</param>
        /// <returns></returns>
        public static string DecimalToWords(decimal number, string culture, Currency currency)
        {
            CultureInfo cultureInfo = CultureInfo.CreateSpecificCulture("en-US");
            Thread.CurrentThread.CurrentCulture = cultureInfo;
            Thread.CurrentThread.CurrentUICulture = cultureInfo;

            var cultureSymbol = GetCultureSymbol(culture);
            if (number == 0)
            {
                return GetZeroString(culture);
            }
            if (number < 0)
            {
                return GetMinusString(culture) + " " + DecimalToWords(Math.Abs(number), culture, currency);
            }
            StringBuilder words = new StringBuilder();
            if(number >Int32.MaxValue)
            {
                return "-";
            }
            Int64 intPortion = (Int64)Math.Truncate(number);
            var regex = new System.Text.RegularExpressions.Regex("(?<=[\\.])[0-9]+");
            string decimal_places = "";
            if (regex.IsMatch(number.ToString()))
            {
                decimal_places = regex.Match(number.ToString()).Value;
            }
            // convert the int part of amount
            if (intPortion <= Int32.MaxValue)
            {
                words.Append(intPortion.ToWords(new CultureInfo(cultureSymbol, false)));
                words.Append(" ");
                words.Append(currency.CurrencyInLetter);
            }

            int num;
            if (Int32.TryParse(decimal_places, out num) && Convert.ToInt32(decimal_places) > 0)
            {
                words.Append(" ");
                words.Append(GetPointString(culture));
                words.Append(" ");
                //get the converted string of the float part
                string entier = decimal_places + "000";
                words.Append(Convert.ToInt32(entier.Substring(0, currency.Precision)).ToWords(new CultureInfo(cultureSymbol, false)));
                words.Append(" ");
                words.Append(currency.FloatInLetter);
            }
            return words.ToString();
        }
        /// <summary>
        /// <summary>
        /// get the symbol of the geted language from the frontend
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        private static string GetCultureSymbol(string culture)
        {
            if (culture.ToUpper().Contains("FR")) return "fr-FR";
            else if (culture.ToUpper().Contains("EN")) return "en-EN";
            else if (culture.ToUpper().Contains("DE")) return "de-DE";
            else if (culture.ToUpper().Contains("AR")) return "ar-AR";
            else throw new Exception("Culture not found");
        }
        /// <summary>
        /// get zero letter
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        private static string GetZeroString(string culture)
        {
            switch (culture.ToUpper())
            {
                case Languages.FR:
                    return ZeroTranslation.FR;
                case Languages.EN:
                    return ZeroTranslation.EN;
                case Languages.DE:
                    return ZeroTranslation.DE;
                case Languages.AR:
                    return ZeroTranslation.AR;
                default:
                    throw new Exception("Culture not found");
            }
        }
        /// <summary>
        /// get minus letter
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        private static string GetMinusString(string culture)
        {
            switch (culture.ToUpper())
            {
                case Languages.FR:
                    return MinusTranslation.FR;
                case Languages.EN:
                    return MinusTranslation.EN;
                case Languages.DE:
                    return MinusTranslation.DE;
                case Languages.AR:
                    return MinusTranslation.AR;
                default:
                    throw new Exception("Culture not found");
            }
        }
        /// <summary>
        /// get point letter
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        private static string GetPointString(string culture)
        {
            switch (culture.ToUpper())
            {
                case Languages.FR:
                    return PointTranslation.FR;
                case Languages.EN:
                    return PointTranslation.EN;
                case Languages.DE:
                    return PointTranslation.DE;
                case Languages.AR:
                    return PointTranslation.AR;
                default:
                    throw new Exception("Culture not found");
            }
        }
    }
    /// <summary>
    /// string enumerator of language
    /// </summary>
    public class Languages
    {
        public const string FR = "FR";
        public const string EN = "EN";
        public const string DE = "DE";
        public const string AR = "AR";
    }
    /// <summary>
    /// string minus enumerator translation
    /// </summary>
    public class MinusTranslation
    {
        public const string FR = "moins";
        public const string EN = "minus";
        public const string DE = "minus";
        public const string AR = "ناقص";
    }
    /// <summary>
    /// string point enumerator translation
    /// </summary>
    public class PointTranslation
    {
        public const string FR = "et";
        public const string EN = "and";
        public const string DE = "und";
        public const string AR = "و";
    }
    /// <summary>
    /// string zero enumerator translation
    /// </summary>
    public class ZeroTranslation
    {
        public const string FR = "zéro";
        public const string EN = "zero";
        public const string DE = "Null";
        public const string AR = "صفر";
    }

}
