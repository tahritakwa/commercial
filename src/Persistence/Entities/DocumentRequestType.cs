﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class DocumentRequestType
    {
        public DocumentRequestType()
        {
            DocumentRequest = new HashSet<DocumentRequest>();
            SharedDocument = new HashSet<SharedDocument>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual ICollection<DocumentRequest> DocumentRequest { get; set; }
        public virtual ICollection<SharedDocument> SharedDocument { get; set; }
    }
}