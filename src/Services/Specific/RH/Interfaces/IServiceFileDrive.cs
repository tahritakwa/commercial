using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceFileDrive : IService<FileDriveViewModel, FileDrive>
    {
        List<FileDriveViewModel> GetListOfFiles();
        FileDriveViewModel UploadfileDrive(FileDriveViewModel fileDriveViewModel);
        void MoveFileDrive(FileDriveViewModel element, FileDriveViewModel moveTo);
        void PermanantDelete(FileDriveViewModel element);
    }
}
