using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions
{
    [Serializable]
    public class FormulaExcecutionFormatException : Exception
    {
        public FormulaExcecutionFormatException()
        {
        }

        public FormulaExcecutionFormatException(string message) : base(message)
        {
        }

        public FormulaExcecutionFormatException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected FormulaExcecutionFormatException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
