using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {


        /// <summary>
        /// Manget File Delete file and copy new file 
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        public void ManageFile(IList<IFormFile> files, DocumentViewModel document)
        {
            if (files != null)
            {
                DeleteUploadedFiles(document.AttachmentUrl, document.UploadedFiles);
                //Copy files to specific url
                if (document.Files != null && document.Files.Any())
                {
                    CopyFiles(document.AttachmentUrl, document.Files);
                }
                //Delete directory if list of file in current directory null
                DeleteDirectoryFiles(document.AttachmentUrl);
            }
            else
            {

                //Mange Observations Files
                if (string.IsNullOrEmpty(document.AttachmentUrl))
                {
                    if (document.FilesInfos != null)
                    {
                        document.AttachmentUrl = Path.Combine("Sales", "Document", document.DocumentTypeCode, Guid.NewGuid().ToString());
                        CopyFiles(document.AttachmentUrl, document.FilesInfos);
                    }
                }
                else
                {
                    DeleteFiles(document.AttachmentUrl, document.FilesInfos);
                    CopyFiles(document.AttachmentUrl, document.FilesInfos);
                }
            }


        }


        /// <summary>
        /// copy document file
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        /// <returns></returns>
        protected void CopyFile(IList<IFormFile> files, DocumentViewModel document)
        {
            if (files != null)
            {
                SetFileDocument(files, document);
                if (document.Files != null && document.Files.Any())
                    Task.Run(() => CopyFiles(document.AttachmentUrl, document.Files));
            }
            else
            {

                //Mange Observations Files
                if (string.IsNullOrEmpty(document.AttachmentUrl))
                {
                    if (document.FilesInfos != null)
                    {
                        document.AttachmentUrl = Path.Combine("Sales", "Document", document.DocumentTypeCode, Guid.NewGuid().ToString());
                        CopyFiles(document.AttachmentUrl, document.FilesInfos);
                    }
                }
                else
                {
                    if (document.FilesInfos != null)
                    {
                        DeleteFiles(document.AttachmentUrl, document.FilesInfos);
                        CopyFiles(document.AttachmentUrl, document.FilesInfos);
                    }

                }
            }


        }


        public void SetFileDocument(IList<IFormFile> files, DocumentViewModel document)
        {

            if (files != null && files.Any())
            {
                //Add list of files to document
                document.Files = files;
            }
            if (string.IsNullOrEmpty(document.AttachmentUrl) && files != null)
            {
                //Add url of attachment files
                document.AttachmentUrl = Path.Combine("Sales", "Document", document.DocumentTypeCode, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff") + document.DocumentDate.ToString("_dd-MM-yyyy"));
            }
        }
    }
}
