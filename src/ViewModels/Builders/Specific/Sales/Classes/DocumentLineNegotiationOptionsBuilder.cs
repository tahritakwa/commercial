using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales.Document;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class DocumentLineNegotiationOptionsBuilder : GenericBuilder<DocumentLineNegotiationOptionsViewModel, DocumentLineNegotiationOptions>, IDocumentLineNegotiationOptionsBuilder
    {
        private readonly IDocumentLineBuilder _documentLineBuilder;
        public DocumentLineNegotiationOptionsBuilder(IDocumentLineBuilder documentLineBuilder)
        {
            _documentLineBuilder = documentLineBuilder;
        }
        public override DocumentLineNegotiationOptionsViewModel BuildEntity(DocumentLineNegotiationOptions entity)
        {
            var neg = base.BuildEntity(entity);
            if (neg != null)
            {
                if (entity != null && entity.IdDocumentLineNavigation != null)
                {
                    neg.IdDocumentLineNavigation = _documentLineBuilder.BuildEntity(entity.IdDocumentLineNavigation);
                }

            }
            return neg;
        }
    }
}
