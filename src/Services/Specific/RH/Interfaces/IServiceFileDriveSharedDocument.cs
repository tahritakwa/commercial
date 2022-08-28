using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceFileDriveSharedDocument : IService<FileDriveSharedDocumentViewModel, FileDriveSharedDocument>

    {
        object AddSharedDocumentAndSendMail(string url, FileDriveSharedDocumentViewModel model, string userMail);
    }
}
