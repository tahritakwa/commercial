using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions
{
    [Serializable]
    public class InvalidFormulaFormatException : Exception
    {
        public InvalidFormulaFormatException()
        {
        }

        public InvalidFormulaFormatException(string message) : base(message)
        {
        }

        public InvalidFormulaFormatException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected InvalidFormulaFormatException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
