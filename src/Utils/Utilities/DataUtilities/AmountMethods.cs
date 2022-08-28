using System;
using Utils.Constants;

namespace Utils.Utilities.DataUtilities
{
    public static class AmountMethods
    {
        /// <summary>
        /// Foramt Value
        /// </summary>
        /// <param name="Value"></param>
        /// <param name="PrecissionValue"></param>
        /// <returns></returns>
        public static double FormatValue(double? Value, int PrecissionValue)
        {
            double newValue = Value ?? NumberConstant.Zero;
            return Math.Round(newValue, PrecissionValue);
        }

        public static double RoundDown(double i, int decimalPlaces)
        {
            var power = Convert.ToDouble(Math.Pow(10, decimalPlaces));
            return Math.Floor(i * power) / power;
        }

        public static string FormatValueString(double? Value, int PrecissionValue)
        {
            
            double newValue = Value ?? NumberConstant.Zero;
            newValue = Math.Round(newValue, PrecissionValue);            
            string format = "{0:# ### ### ##0.}";
            for (int i = 0; i < PrecissionValue; i++)
            {
                format = format.Insert(format.LastIndexOf(GenericConstants.Point) + NumberConstant.One, NumberConstant.Zero.ToString());
            }
            return string.Format(format, newValue).Trim();
        }
    }
}
