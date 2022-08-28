using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceComment : IService<CommentViewModel, Comment>
    {
        IList<CommentViewModel> GetComments(string entityName, int idEntityCreated);
    }
}
