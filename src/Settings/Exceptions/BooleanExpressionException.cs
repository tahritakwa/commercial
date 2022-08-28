using System;
using System.Runtime.Serialization;

namespace Settings.Exceptions
{
    [Serializable]
    public  class BooleanExpressionException : Exception
    {
        public BooleanExpressionException()
        {
        }

        public BooleanExpressionException(string message) : base(message)
        {
        }

        public BooleanExpressionException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected BooleanExpressionException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
