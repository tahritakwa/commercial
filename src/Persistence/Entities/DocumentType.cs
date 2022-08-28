﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class DocumentType
    {
        public DocumentType()
        {
            DocumentTypeRelationCodeDocumentTypeAssociatedNavigation = new HashSet<DocumentTypeRelation>();
            DocumentTypeRelationCodeDocumentTypeNavigation = new HashSet<DocumentTypeRelation>();
            InverseDefaultCodeDocumentTypeAssociatedNavigation = new HashSet<DocumentType>();
        }

        public string CodeType { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string DefaultCodeDocumentTypeAssociated { get; set; }
        public bool IsStockAffected { get; set; }
        public string StockOperation { get; set; }
        public string StockOperationStatus { get; set; }
        public bool CreateAssociatedDocument { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public bool IsSaleDocumentType { get; set; }
        public bool IsFinancialCommitmentAffected { get; set; }
        public int? FinancialCommitmentDirection { get; set; }
        public bool IsActiveGeneration { get; set; }
        public string LabelEn { get; set; }

        public virtual DocumentType DefaultCodeDocumentTypeAssociatedNavigation { get; set; }
        public virtual ICollection<DocumentTypeRelation> DocumentTypeRelationCodeDocumentTypeAssociatedNavigation { get; set; }
        public virtual ICollection<DocumentTypeRelation> DocumentTypeRelationCodeDocumentTypeNavigation { get; set; }
        public virtual ICollection<DocumentType> InverseDefaultCodeDocumentTypeAssociatedNavigation { get; set; }
    }
}