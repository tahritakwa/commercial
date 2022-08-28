using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Reporting;

namespace ViewModels.Builders.Specific.Reporting.Interfaces
{
    public interface IDocumentLineReportingBuilder : IBuilder<DocumentLineReportingViewModel, DocumentLine>
    {
        DocumentLineReportingViewModel BuildEntity(DocumentLine entity, List<Taxe> taxes = null, Company company = null);
    }
}
