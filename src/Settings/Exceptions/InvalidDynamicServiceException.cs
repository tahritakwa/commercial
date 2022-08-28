using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions
{
    [Serializable]
    public class InvalidDynamicServiceException : Exception
    {
        public InvalidDynamicServiceException()
        {
        }

        public InvalidDynamicServiceException(string message) : base(message)
        {
        }

        public InvalidDynamicServiceException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected InvalidDynamicServiceException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
