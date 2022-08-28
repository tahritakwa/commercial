using iTextSharp.text.pdf;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public static class ServiceStarkdrive
    {
        //File Parameters
        static readonly AppSettings _appSettings;
        static readonly IRepository<Company> _entityRepoCompany;

        public static void CopyFiles(string url, IList<FileDriveViewModel> filesUploaded)
        {
            if (filesUploaded != null && filesUploaded.Any())
            {
                string path = CreateDirectory(url);
                //Fetch list of files
                foreach (var file in filesUploaded.Where(x => x.FileData != null))
                {
                    CreatFile(file, path);
                }
            }
        }

        private static string CreateDirectory(string url)
        {
            //If directory doesn't exist==> create directory
            if (!Directory.Exists(url))
            {
                Directory.CreateDirectory(url);
            }
            return url;
        }

        public static void CreatFile(FileDriveViewModel file, string path)
        {
            byte[] fileDataByteArray;
            if (file.FileData != null)
            {
                fileDataByteArray = Convert.FromBase64String(file.FileData);
            }
            else
            {
                fileDataByteArray = file.Data;
            }
            //When creating a stream, you need to reset the position, without it you will see that you always write files with a 0 byte length. 
            var fileDataStream = new MemoryStream(fileDataByteArray);

            //File name
            string nameFile = file.Name;
            //Combine url with name of file
            var fileUrl = Path.Combine(path, nameFile);
            //If File doesn't exist==> copy file
            if (!File.Exists(fileUrl))
            {
                //Initialize new instance of fileStream with the specified url and mode of creation
                using (var fileStream = new FileStream(fileUrl, FileMode.Create))
                {
                    //Copy file
                    fileDataStream.CopyTo(fileStream);
                }
            }
        }
        public static void DeleteFiles(string url, IList<FileDriveViewModel> filesUploaded)
        {
            // check wether the path output carry the main directory value -- url is null in this case
            if (Directory.Exists(url))
            {
                DirectoryInfo directory = new DirectoryInfo(url);
                //Fetch list of files
                foreach (FileInfo fileInfo in directory.GetFiles())
                {
                    //if file name dont exist in current list of files==> delete file
                    if (!filesUploaded.Where(x => x.FileData == null).Select(x => x.Name).Contains(fileInfo.Name))
                    {
                        //Delete file
                        fileInfo.Delete();
                    }
                }
            }
        }
        public static void PermanentDelete(string url, IList<FileDriveViewModel> filesUploaded)
        {
            // check wether the path output carry the main directory value -- url is null in this case
            if (Directory.Exists(url))
            {
                DirectoryInfo directory = new DirectoryInfo(url);
                //Fetch list of files
                foreach (FileInfo fileInfo in directory.GetFiles())
                {
                    //if file name dont exist in current list of files==> delete file
                    if (filesUploaded.Where(x => x.FileData == null).Select(x => x.Name).Contains(fileInfo.Name))
                    {
                        //Delete file
                        fileInfo.Delete();
                    }
                }
            }
        }
        public static void CopyPdfFilesWithSecurityPassword(string url, IList<FileDriveViewModel> filesUploaded, string password)
        {
            if (filesUploaded != null && filesUploaded.Any())
            {
                string path = CreateDirectory(url);
                //Fetch list of files
                foreach (var file in filesUploaded.Where(x => (x.FileData != null || x.Data != null)))
                {
                    CreatePdfFileWithSecurityPassword(file, path, password);
                }
            }
        }
        public static void CreatePdfFileWithSecurityPassword(FileDriveViewModel file, string path, string password)
        {
            byte[] fileDataByteArray;
            if (file.FileData != null)
            {
                fileDataByteArray = Convert.FromBase64String(file.FileData);
            }
            else
            {
                fileDataByteArray = file.Data;
            }
            //When creating a stream, you need to reset the position, without it you will see that you always write files with a 0 byte length. 
            var fileDataStream = new MemoryStream(fileDataByteArray);

            //File name
            string nameFile = file.Name;
            //Combine url with name of file
            var fileUrl = Path.Combine(path, nameFile);
            //If File doesn't exist==> copy file
            if (!File.Exists(fileUrl))
            {

                using (Stream output = new FileStream(fileUrl, FileMode.Create))
                {
                    PdfReader reader = new PdfReader(fileDataStream);
                    PdfEncryptor.Encrypt(reader, output, true, password, password, PdfWriter.ALLOW_PRINTING);
                }
            }
        }
        /// <summary>
        /// Move files in the specified url
        /// </summary>
        /// <param name="url"></param>
        /// <param name="filesUploaded"></param>
        public static void MoveFiles(string url, IList<FileDriveViewModel> filesUploaded)
        {
            if (filesUploaded != null && filesUploaded.Any())
            {
                string path = CreateDirectory(url);
                //Fetch list of files
                foreach (var file in filesUploaded)
                {
                    CreatFile(file, path);
                }
            }
        }
    }
}
