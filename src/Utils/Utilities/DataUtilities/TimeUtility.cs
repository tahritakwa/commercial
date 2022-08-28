using System;
using Utils.Constants;

namespace Infrastruture.Utility
{
    public static class TimeUtility
    {
        /// <summary>
        /// Check if a time is between two times, with both edge times included
        /// </summary>
        /// <param name="time"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public static bool BetweenTimeLimitIncluded(this TimeSpan time, TimeSpan startTime, TimeSpan endTime)
        {
            return TimeSpan.Compare(time, startTime) >= NumberConstant.Zero && TimeSpan.Compare(time, endTime) <= NumberConstant.Zero;
        }

        /// <summary>
        /// Check if a time is between two times, with both edge times not included
        /// </summary>
        /// <param name="time"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public static bool BetweenTimeLimitNotIncluded(this TimeSpan time, TimeSpan startTime, TimeSpan endTime)
        {
            return TimeSpan.Compare(time, startTime) > NumberConstant.Zero && TimeSpan.Compare(time, endTime) < NumberConstant.Zero;
        }

        /// <summary>
        /// Check if time is after time passed in parameters
        /// </summary>
        /// <param name="time"></param>
        /// <param name="startTime"></param>
        /// <returns></returns>
        public static bool AfterTimeLimitIncluded(this TimeSpan time, TimeSpan startTime)
        {
            return TimeSpan.Compare(time, startTime) >= NumberConstant.Zero;
        }

        /// <summary>
        /// Check if time is before time passed in parameters
        /// </summary>
        /// <param name="time"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public static bool BeforeTimeLimitIncluded(this TimeSpan time, TimeSpan endTime)
        {
            return TimeSpan.Compare(time, endTime) <= NumberConstant.Zero;
        }
    }
}
