using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions.ExceptionsPayroll
{
    [Serializable]
    public class InvalidContractIdException : Exception
    {
        public InvalidContractIdException()
        {
        }

        public InvalidContractIdException(string message) : base(message)
        {
        }

        public InvalidContractIdException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected InvalidContractIdException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
