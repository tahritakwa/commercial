using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class DbcomptaConfig
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string DriverClassName { get; set; }
        public string CompanyCode { get; set; }
        public string Env { get; set; }
        public string Module { get; set; }
    }
}