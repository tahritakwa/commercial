using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class RequestTypeBuilder : GenericBuilder<RequestTypeViewModel, RequestType>, IRequestTypeBuilder
    {
    }
}
