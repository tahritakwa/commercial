using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions.ExceptionsDocument
{
    [Serializable]
    internal class DepoRequiredError : Exception
    {
        public DepoRequiredError()
        {
        }

        public DepoRequiredError(string message) : base(message)
        {
        }

        public DepoRequiredError(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected DepoRequiredError(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
