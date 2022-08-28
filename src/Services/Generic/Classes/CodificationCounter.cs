using Persistence.Entities;
using System.Collections.Generic;

namespace Services.Generic.Classes
{
    public class CodificationCounter
    {
        public Codification Counteur { get; internal set; }
        internal List<ObjectCounteur> ObjectCounteurList { get; set; }
    }
}