using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class DocumentRequestBuilder: GenericBuilder<DocumentRequestViewModel, DocumentRequest>, IDocumentRequestBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;

        public DocumentRequestBuilder(IEmployeeBuilder employeeBuilder)
        {
            _employeeBuilder = employeeBuilder;
        }

        public override DocumentRequestViewModel BuildEntity(DocumentRequest entity)
        {
            DocumentRequestViewModel documentRequestViewModel = base.BuildEntity(entity);
            if(documentRequestViewModel != null)
            {
                if (documentRequestViewModel.TreatedByNavigation != null && documentRequestViewModel.TreatedBy != null)
                {
                    documentRequestViewModel.TreatedByNavigation = _employeeBuilder.BuildEntity(entity.TreatedByNavigation);
                }
            }
            return documentRequestViewModel;
        }
        public override DocumentRequest BuildModel(DocumentRequestViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            DocumentRequest entity = base.BuildModel(model);
            if (model.IdEmployeeNavigation != null)
            {
                entity.IdEmployeeNavigation = null;
            }
            if (model.IdDocumentRequestTypeNavigation != null)
            {
                entity.IdDocumentRequestTypeNavigation = null;
            }
            return entity;
        }
    }
}
