using System;

namespace Utils.Utilities.DataUtilities
{
    public static class FloatAndDoubleExt
    {
        /// <summary>
        /// Utility to check if a double is equal to 0 (Is approximately equal to zero)
        /// </summary>
        /// <param name="self"></param>
        /// <param name="other"></param>
        /// <param name="within"></param>
        /// <returns></returns>
        public static bool IsApproximately(this double self, double other = 0, double within = 0.0001)
        {
            return Math.Abs(self - other) <= within;
        }

        /// <summary>
        /// Utility to check if a float is equal to 0 (Is approximately equal to zero)
        /// </summary>
        /// <param name="self"></param>
        /// <param name="other"></param>
        /// <param name="within"></param>
        /// <returns></returns>
        public static bool IsApproximately(this float self, float other, float within)
        {
            return Math.Abs(self - other) <= within;
        }

        public static bool BetweenQuantitiesLimitIncluded(this double self, double? minQte, double? maxQte)
        {
            return minQte != null && maxQte != null && self >= minQte && self <= maxQte;
        }
    }
}
