using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System;

namespace Settings.Exceptions
{
    public class ExceptionLogger
    {
        private ILogger logger;

        public ILogger Logger { get => logger; set => logger = value; }

        public ExceptionLogger(ILogger logger)
        {
            Logger = logger;
        }
        public void AddInformation(string message)
        {
            Logger.LogInformation(message);
        }
        public void ExceptionObject(string source, Exception ex)
        {
            Logger.LogError("Exception from {1} layer. \r Main error: {2}. \r Inner Exception : {3}. \r Trace : {4}",
                        source, ex.Message, ex.InnerException, ex.StackTrace);
        }
        public void ExceptionMethodSimpleMessage(string message)
        {
            Logger.LogError(message);
        }
        public void ExceptionMethodWithParameter(IHeaderDictionary header, string source, string message, Exception innerException = null, string stackTrace = null)
        {
            Logger.LogError("HTTP Header : {0}. \rException from {1} layer. \r Main error: {2}. \r Inner Exception : {3}. \r Trace : {4}",
                        header, source, message, innerException, stackTrace);
        }
    }
}
