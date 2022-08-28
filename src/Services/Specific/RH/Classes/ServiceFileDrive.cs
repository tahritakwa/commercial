using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Constants.RHConstants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceFileDrive : Service<FileDriveViewModel, FileDrive>, IServiceFileDrive
    {
        private readonly IServiceUser _serviceUser;

        public ServiceFileDrive(IRepository<FileDrive> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IFileDriveBuilder builder,
          IRepository<User> entityRepoUser,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceUser serviceUser, IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceUser = serviceUser;
        }  
        public List<FileDriveViewModel> GetListOfFiles()
        {
            {
                // Get list of files
                List<FileDriveViewModel> listOfAllFiles = GetAllModelsWithRelations(w => w.InverseIdParentNavigation).ToList();
                // Get list of files with file children
                List<FileDriveViewModel> listOfHiarchicFiles = GetChildrens(listOfAllFiles
                    .Where(c => !c.IdParent.HasValue).ToList(), listOfAllFiles);
                return listOfHiarchicFiles;
            }
        }
        public List<FileDriveViewModel> GetChildrens(List<FileDriveViewModel> list, List<FileDriveViewModel> listGlobal)
        {
            if (list != null)
            {
                foreach (FileDriveViewModel fileDrive in list)
                {                  
                    fileDrive.InverseIdParentNavigation = listGlobal.Where(c => c.IdParent == fileDrive.Id).ToList();
                    if (!fileDrive.InverseIdParentNavigation.Any())
                    {
                        fileDrive.InverseIdParentNavigation = null;
                    }
                    else
                    {
                        GetChildrens(fileDrive.InverseIdParentNavigation.ToList(), listGlobal);
                    }
                }
            }
            return list;
        }
        /// <summary>
        ///  //after renaming file and folder , update the path of children document
        /// </summary>
        /// <param name="children"></param>
        /// <param name="parent"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void SetPathToChildren(List<FileDriveViewModel> children, FileDriveViewModel parent, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            IList<FileDriveViewModel> listOfAllFiles = GetAllModelsAsNoTracking().ToList();
            if (children != null)
            {
            foreach (FileDriveViewModel fileDrive in children)
                {
                    UploadfileDrive(fileDrive);
                    fileDrive.Path = parent.Path + parent.Name + RHConstant.NextPath;
                    MoveFileDrive(fileDrive, parent);
                    fileDrive.FileDriveInfo = new List<FileDriveViewModel>();
                    fileDrive.FileDriveInfo.Add(fileDrive);
                    ServiceStarkdrive.MoveFiles(fileDrive.Path, fileDrive.FileDriveInfo);
                    fileDrive.InverseIdParentNavigation = listOfAllFiles.Where(c => c.IdParent == fileDrive.Id).ToList();


                    if (!fileDrive.InverseIdParentNavigation.Any())
                    {
                        fileDrive.InverseIdParentNavigation = null;
                    }
                    else
                    {
                        SetPathToChildren(fileDrive.InverseIdParentNavigation.ToList(), fileDrive, entityAxisValuesModelList, userMail,null);
                    }
                }
            }
           
        }
        /// <summary>
        ///uploading file 
        /// </summary>
        /// <param name="fileDriveViewModel"></param>
        private void AttachementFile(FileDriveViewModel fileDriveViewModel)
        {
            if (string.IsNullOrEmpty(fileDriveViewModel.Path))
            {
                if (fileDriveViewModel.FileDriveInfo.Count != NumberConstant.Zero)
                {
                    //adding the name of parent folder in the end of the path
                    fileDriveViewModel.Path = DocumentPath(fileDriveViewModel) + fileDriveViewModel.FileDriveInfo.FirstOrDefault().Path;
                    //the model name ,size and type should  have the same value name and size and type of File that we uploded
                    fileDriveViewModel.Name = fileDriveViewModel.FileDriveInfo.FirstOrDefault().Name;
                    fileDriveViewModel.Size = fileDriveViewModel.FileDriveInfo.FirstOrDefault().Size;
                    fileDriveViewModel.Type = fileDriveViewModel.FileDriveInfo.FirstOrDefault().Type;                 
                    ServiceStarkdrive.CopyFiles(fileDriveViewModel.Path, fileDriveViewModel.FileDriveInfo);
                }
            }
            else
            {
                ServiceStarkdrive.DeleteFiles(fileDriveViewModel.Path, fileDriveViewModel.FileDriveInfo);
                ServiceStarkdrive.CopyFiles(fileDriveViewModel.Path, fileDriveViewModel.FileDriveInfo);
            }
        }
        /// <summary>
        /// Returning base path
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string DocumentPath(FileDriveViewModel model)
        {
            // associate the connected user and the company name for the path
            UserViewModel user = _serviceUser.GetModelById(model.CreatedBy);
            string companyName = _entityRepoCompany.GetSingleNotTracked(x => true).Name;
            string documentPath = _appSettings.UploadFilePath + companyName + RHConstant.NextPath + RHConstant.FileDriveRootPath + user.FirstName +
                                        user.LastName + RHConstant.NextPath;
             return documentPath;
        }
        /// <summary>
        /// uploading file and saving folder
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(FileDriveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // saving a folder in the case that we don't have a fileDriveInfo 
            if (model.FileDriveInfo == null)
            {
                model.Path = DocumentPath(model) + model.Path;
            }
            else
            //saving a file
            {
                AttachementFile(model);
                //update the size of folder parent whenever you import a file 
                // the size of folder is the sum of size of children
                if (model.IdParent != null)
                {
                    FileDriveViewModel folder = GetModelAsNoTracked(u => u.Id == model.IdParent);
                    folder.Size += model.Size;
                    base.UpdateModelWithoutTransaction(folder, entityAxisValuesModelList, userMail, property);
                }
            }
            CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);          
            return entity;
        }
        public override object UpdateModelWithoutTransaction(FileDriveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)

        { if (model.Type != null)
            {
                model.FileDriveInfo = new List<FileDriveViewModel>();
                model.FileDriveInfo.Add(model);
                ServiceStarkdrive.DeleteFiles(model.Path, model.FileDriveInfo);
                ServiceStarkdrive.MoveFiles(model.Path, model.FileDriveInfo);
            }
            IList<FileDriveViewModel> listOfAllFiles = GetAllModelsAsNoTracking().ToList();
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            model.InverseIdParentNavigation = listOfAllFiles.Where(c => c.IdParent == model.Id).ToList();
            SetPathToChildren(model.InverseIdParentNavigation.ToList(), model, entityAxisValuesModelList, userMail,null);
            return result;
           
        }
        /// <summary>
        /// Upload FileDrive
        /// </summary>
        /// <param name="fileDriveViewModel"></param>
        /// <returns></returns>
        public FileDriveViewModel UploadfileDrive(FileDriveViewModel fileDriveViewModel)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, fileDriveViewModel.Path).Trim();
            if (Directory.Exists(path))
            {
                DirectoryInfo directory = new DirectoryInfo(path);
                //Fetch list of uploaded files
                string filePath = Path.Combine(path, fileDriveViewModel.Name);
                //Add data of file to fileInfoViewModel
                fileDriveViewModel.Data = File.ReadAllBytes(filePath);
            }
            return fileDriveViewModel;
        }

        /// <summary>
        /// DeleteModelwithouTransaction
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            var files = _entityRepo.GetAllWithConditionsRelationsQueryable(e => e.InverseIdParentNavigation.Any(x => x.IdParent == e.Id),
             e => e.InverseIdParentNavigation).ToList();
            var f = files.Where(x => x.Id == id).FirstOrDefault();
            string path = GetModelById(id).Path;
            
            if (f == null)
            {
                return base.DeleteModelwithouTransaction(id, tableName, userMail);
            }
            else
            {              
                return RecursiveDelete(f, tableName, userMail);
            }

        }
        /// <summary>
        /// Delete multiple files recursively
        /// </summary>
        /// <param name="file"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        private object RecursiveDelete(FileDrive file, string tableName, string userMail)
        {
            if (file.InverseIdParentNavigation.Count > NumberConstant.Zero)
            {
                file.InverseIdParentNavigation.ToList().ForEach(childFile =>
                {
                    RecursiveDelete(childFile, tableName, userMail);
                });
            }
            return base.DeleteModelwithouTransaction(file.Id, tableName, userMail);
        }
        /// <summary>
        /// Move element
        /// </summary>update
        /// <param name="element"></param>
        /// <param name="moveTo"></param>
        public void MoveFileDrive(FileDriveViewModel element, FileDriveViewModel moveTo) {
            element.FileDriveInfo = new List<FileDriveViewModel>();
            element.FileDriveInfo.Add(element);
            element.IdParent = moveTo.Id;
            ServiceStarkdrive.PermanentDelete(element.Path, element.FileDriveInfo);
            element.Path = moveTo.Path + moveTo.Name;
            ServiceStarkdrive.MoveFiles(element.Path, element.FileDriveInfo);
            base.UpdateModelWithoutTransaction(element, null, null, null);
        }
        /// <summary>
        /// Permanent delete
        /// </summary>
        /// <param name="element"></param>
        public void PermanantDelete(FileDriveViewModel element)
        {
            element.FileDriveInfo = new List<FileDriveViewModel>();
            element.FileDriveInfo.Add(element);
            DeleteModelwithouTransaction(element.Id, null, null);
            ServiceStarkdrive.PermanentDelete(element.Path, element.FileDriveInfo);
        }
    }
}
