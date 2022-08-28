using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Common
{
    [Serializable]
    public class SendedObject
    {
        public string Message { get; set; }
        public List<string> Mails { get; set; }
        public string EntityName { get; set; }
        public int IdEntityCreated { get; set; }
    }
}
