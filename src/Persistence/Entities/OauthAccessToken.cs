﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class OauthAccessToken
    {
        public string TokenId { get; set; }
        public byte[] Token { get; set; }
        public string AuthenticationId { get; set; }
        public string UserName { get; set; }
        public string ClientId { get; set; }
        public byte[] Authentication { get; set; }
        public string RefreshToken { get; set; }
    }
}