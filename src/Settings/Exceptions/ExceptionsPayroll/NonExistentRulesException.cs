using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions.ExceptionsPayroll
{
    [Serializable]
    public class NonExistentRulesException : Exception
    {
        public NonExistentRulesException()
        {
        }

        public NonExistentRulesException(string message) : base(message)
        {
        }

        public NonExistentRulesException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected NonExistentRulesException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
