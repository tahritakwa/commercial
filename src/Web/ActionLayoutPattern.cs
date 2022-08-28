using log4net.Layout;
using log4net.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web
{
    public class ActionLayoutPattern : PatternLayout
    {
        
        public ActionLayoutPattern()
        {
            AddConverter(new ConverterInfo
            {
                Name = "actionInfo",
                Type = typeof(ActionConverter)
            }
            );
        }
    }
}
