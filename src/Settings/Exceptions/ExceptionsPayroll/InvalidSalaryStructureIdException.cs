using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions.ExceptionsPayroll
{
    [Serializable]
    public class InvalidSalaryStructureIdException : Exception
    {
        public InvalidSalaryStructureIdException()
        {
        }

        public InvalidSalaryStructureIdException(string message) : base(message)
        {
        }

        public InvalidSalaryStructureIdException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected InvalidSalaryStructureIdException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
