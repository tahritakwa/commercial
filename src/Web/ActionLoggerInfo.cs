 

using Newtonsoft.Json;
using System;
using System.Text;
using System.Text.RegularExpressions;

namespace Web
{
    public class ActionLoggerInfo
    {
        public dynamic Controller { get; set; }
        public string ExceptionLine { get; set; }
        public string Method { get; set; }
        public string ActionOriginalMessage{ get; set; }
        public string ExceptionDetails { get; set; }

        public override string ToString()
        {
            return String.Format("Exception type: {0} " + Environment.NewLine + "Details about entity: {1}  " + Environment.NewLine +
                "Details about action : < {2} >." + Environment.NewLine + "Line exception specification : {3}" + Environment.NewLine + "Action message from original exception:{4}",
            ExceptionDetails, Controller, Method, ExceptionLine, ActionOriginalMessage);
        }
    }
}
