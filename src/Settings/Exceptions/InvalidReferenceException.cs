using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions
{
    [Serializable]
    internal class InvalidReferenceException : Exception
    {
        public InvalidReferenceException()
        {
        }

        public InvalidReferenceException(string message) : base(message)
        {
        }

        public InvalidReferenceException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected InvalidReferenceException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
