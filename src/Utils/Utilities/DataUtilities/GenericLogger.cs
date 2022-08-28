using Serilog;
using Serilog.Events;
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;

namespace Utils.Utilities.DataUtilities
{
    public static class GenericLogger
    {
        /// <summary>
        /// loggers by files names
        /// </summary>
        private static readonly IDictionary<string,ILogger> loggers = new Dictionary<string, ILogger>();
        /// <summary>
        /// Log Message
        /// Accepted LogEventLevel must be in 
        /// {LogEventLevel.Information, LogEventLevel.Warning, LogEventLevel.Error, LogEventLevel.Fatal }
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="logEventLevel"></param>
        /// <param name="message"></param>
        public static void LogMessage(string fileName, LogEventLevel logEventLevel, string message)
        {
            GenericLog(fileName, logEventLevel,
                new Type[] { typeof(string) }, new object[] { message } ,null);

        }
        /// <summary>
        /// Log Message And Exception
        /// Accepted LogEventLevel must be in 
        /// {LogEventLevel.Information, LogEventLevel.Warning, LogEventLevel.Error, LogEventLevel.Fatal }
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="logEventLevel"></param>
        /// <param name="message"></param>
        /// <param name="exception"></param>
        public static void LogMessageAndException(string fileName, LogEventLevel logEventLevel, string message, Exception exception)
        {
            GenericLog(fileName, logEventLevel,
                new Type[] { typeof(Exception), typeof(string) }, new object[] { exception, message }, null);
        }
        /// <summary>
        /// Generic Log
        /// Accepted LogEventLevel must be in 
        /// {LogEventLevel.Information, LogEventLevel.Warning, LogEventLevel.Error, LogEventLevel.Fatal }
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="logEventLevel"></param>
        /// <param name="paramsTypes"></param>
        /// <param name="paramsValues"></param>
        public static void GenericLog(string fileName, LogEventLevel logEventLevel, Type[] paramsTypes, object[] paramsValues, string path)
        {
            if (path == null)
            {
                path = "Logs";
            }
            if (loggers == null)
            {
                return;
            }

            if (!loggers.ContainsKey(fileName))
            {
                loggers[fileName] = new LoggerConfiguration()
                  .MinimumLevel
                  .Information()
                  .WriteTo.RollingFile(Path.Combine(path, fileName + ".log")) 
                  .CreateLogger();
            }
            
            string methodName = logEventLevel.ToString();
            //logger = logger;

            // Use reflection to get the Method
            Type type = loggers[fileName].GetType();
            MethodInfo methodInfo = type.GetMethod(methodName, paramsTypes);

            // Invoke the method here
            methodInfo.Invoke(loggers[fileName], paramsValues);
        }
    }
}
