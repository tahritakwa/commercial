using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;
using Utils.Enumerators;

namespace Settings.Exceptions
{
    public class CustomException : Exception
    {
        public CustomStatusCode StatusCode { get; set; }
        public IDictionary<string, dynamic> Paramtrs { get; set; } = new Dictionary<string, dynamic>();
        public StringBuilder SpecificMessage { get; set; }
        public Exception OriginalException { get; set; }
        public CustomException()
        {
        }
        public CustomException(CustomStatusCode customStatusCode)
        {
            StatusCode = customStatusCode;
        }
        public CustomException(IDictionary<string, dynamic> paramtrs)
        {
            Paramtrs = paramtrs;
        }
        public CustomException(CustomStatusCode customStatusCode, IDictionary<string, dynamic> paramtrs)
        {
            StatusCode = customStatusCode;
            Paramtrs = paramtrs;
        }
        public CustomException(CustomStatusCode customStatusCode, Exception originalException)
        {
            StatusCode = customStatusCode;
            OriginalException = originalException;
        }
        public CustomException(CustomStatusCode customStatusCode, IDictionary<string, dynamic> paramtrs, Exception originalException)
        {
            StatusCode = customStatusCode;
            Paramtrs = paramtrs;
            OriginalException = originalException;
        }
        public CustomException(Exception originalException)
        {
            OriginalException = originalException;
        }
        public CustomException(string message)
         : base(message)
        {
        }

        public CustomException(string message, Exception innerException)
            : base(message, innerException)
        {
        }

        protected CustomException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }
    }
}
