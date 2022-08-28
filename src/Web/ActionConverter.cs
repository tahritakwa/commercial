using log4net.Core;
using log4net.Util;
using System;

namespace Web
{
    public class ActionConverter : PatternConverter
    {
        protected override void Convert(System.IO.TextWriter writer, object state)
        {
            if (state == null)
            {
                writer.Write(SystemInfo.NullText);
                return;
            }

            var loggingEvent = state as LoggingEvent;
            var actionInfo = loggingEvent.MessageObject as ActionLoggerInfo;

            if (actionInfo == null)
            {
                writer.Write(SystemInfo.NullText);
            }
            else
            {
                switch (this.Option.ToLower())
                {
                    case "controller":
                        writer.Write(actionInfo.Controller);
                        break;
                    case "actionline":
                        writer.Write(actionInfo.ExceptionLine);
                        break;
                    case "actionoriginalmessage":
                        writer.Write(actionInfo.ActionOriginalMessage);
                        break;
                    case "method":
                        writer.Write(actionInfo.Method);
                        break;
                    case "exceptiondetails":
                        writer.Write(actionInfo.ExceptionDetails);
                        break;
                    default:
                        writer.Write(SystemInfo.NullText);
                        break;
                }
            }
        }
    }
}
