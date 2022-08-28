using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Http;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.DTO.Models;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity> where TModel : class
        where TEntity : class
    {
        string[] fileVideoFormatExtensions = { ".mp4", ".flv", ".avi", ".ts", ".wmv", ".amv", ".mpg", ".mpeg", ".3gp" };

        /// <summary>
        /// Prepare image for reporting
        /// </summary>
        /// <param name="company"></param>
        /// <returns></returns>
        public string PrepareImageForReporting(string imageUrl, string imagePath)
        {
            FileInfoViewModel fileInfoViewModel = null;
            // Test if company logo exist
            if (imageUrl != null)
            {
                // Prepare file info
                fileInfoViewModel = GetFilesContent(imageUrl).FirstOrDefault();
                if (fileInfoViewModel == null)
                {
                    //return imagePath because an exception will be generated if this method return empty
                    return string.Empty;
                }
                // Get path
                string path = Path.Combine(imagePath, imageUrl);
                if (!Directory.Exists(path))
                {
                    // Create directory
                    Directory.CreateDirectory(path);
                }
                fileInfoViewModel.FulPath = path;
                fileInfoViewModel.FulPathReportingImage = Path.Combine(path, fileInfoViewModel.Name);
                CreatFile(fileInfoViewModel, path);
            }
            string pathToSend = (fileInfoViewModel != null && fileInfoViewModel.FulPathReportingImage != null) ? fileInfoViewModel.FulPathReportingImage : imagePath;
            return File.Exists(pathToSend) ? Convert.ToBase64String(File.ReadAllBytes(pathToSend)) : string.Empty;

        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public IList<FileInfoViewModel> GetFilesContent(string url)
        {
            IList<FileInfoViewModel> filesInfos = new List<FileInfoViewModel>();
            if (!string.IsNullOrEmpty(url))
            {
                string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
                if (Directory.Exists(path))
                {
                    DirectoryInfo directory = new DirectoryInfo(path);

                    //Fetch list of uploaded files
                    foreach (FileInfo fileInfo in directory.GetFiles())
                    {
                        var fileInfoViewModel = new FileInfoViewModel
                        {
                            Name = fileInfo.Name,
                            Extension = fileInfo.Extension,
                            Size = Math.Round((fileInfo.Length / 1024f) / 1024f, 2),
                            FulPath = url,
                            FulPathReportingImage = Path.Combine(path, fileInfo.Name)

                        };
                        //Add name of file to fileInfoViewModel
                        //Add extension of file to fileInfoViewModel
                        //Add size of file en Mb to fileInfoViewModel
                        string filePath = Path.Combine(path, fileInfoViewModel.Name);
                        //Add data of file to fileInfoViewModel
                        fileInfoViewModel.Data = File.ReadAllBytes(filePath);
                        filesInfos.Add(fileInfoViewModel);
                    }
                }

            }
            return filesInfos;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public ICollection<FileInfoViewModel> GetFiles(string url)
        {
            ICollection<FileInfoViewModel> filesInfos = new List<FileInfoViewModel>();
            if (!string.IsNullOrEmpty(url))
            {
                string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
                if (Directory.Exists(path))
                {
                    DirectoryInfo directory = new DirectoryInfo(path);

                    //Fetch list of uploaded files
                    foreach (FileInfo fileInfo in directory.GetFiles())
                    {
                        var fileInfoViewModel = new FileInfoViewModel
                        {
                            Name = fileInfo.Name,
                            Extension = fileInfo.Extension,
                            Size = Math.Round((fileInfo.Length / 1024f) / 1024f, 2),
                            FulPath = url,
                            FulPathReportingImage = Path.Combine(path, fileInfo.Name)
                        };
                        //Add name of file to fileInfoViewModel
                        //Add extension of file to fileInfoViewModel
                        //Add size of file en Mb to fileInfoViewModel
                        string filePath = Path.Combine(path, fileInfoViewModel.Name);
                        //Add data of file to fileInfoViewModel
                        fileInfoViewModel.Data = File.ReadAllBytes(filePath);
                        if (fileVideoFormatExtensions.Contains(fileInfoViewModel.Extension))
                        {
                            fileInfoViewModel.FileData = "data:video/" + fileInfoViewModel.Extension.Replace(".", "") + ";base64," + Convert.ToBase64String(fileInfoViewModel.Data);
                        }
                        else if(fileInfoViewModel.Extension != ".pdf")
                        {
                            fileInfoViewModel.FileData = "data:image/" + fileInfoViewModel.Extension.Replace(".", "") + ";base64," + Convert.ToBase64String(fileInfoViewModel.Data);
                        }
                        else
                        {
                            fileInfoViewModel.FileData = Convert.ToBase64String(fileInfoViewModel.Data);
                        }
                        filesInfos.Add(fileInfoViewModel);
                    }
                }
            }
            return filesInfos;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="urls"></param>
        /// <returns></returns>
        public IList<FileInfoViewModel> GetFilesContents(List<string> urls)
        {
            IList<FileInfoViewModel> filesInfos = new List<FileInfoViewModel>();
            urls.ForEach(url =>
            {
                if (!string.IsNullOrEmpty(url))
                {
                    string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
                    if (Directory.Exists(path))
                    {
                        DirectoryInfo directory = new DirectoryInfo(path);

                        //Fetch list of uploaded files
                        foreach (FileInfo fileInfo in directory.GetFiles())
                        {
                            var fileInfoViewModel = new FileInfoViewModel
                            {
                                Name = fileInfo.Name,
                                Extension = fileInfo.Extension,
                                Size = Math.Round((fileInfo.Length / 1024f) / 1024f, 2),
                                FulPath = url,
                                FulPathReportingImage = Path.Combine(path, fileInfo.Name)

                            };
                            //Add name of file to fileInfoViewModel
                            //Add extension of file to fileInfoViewModel
                            //Add size of file en Mb to fileInfoViewModel
                            string filePath = Path.Combine(path, fileInfoViewModel.Name);
                            //Add data of file to fileInfoViewModel
                            fileInfoViewModel.Data = File.ReadAllBytes(filePath);
                            filesInfos.Add(fileInfoViewModel);
                        }
                    }

                }
            });
            return filesInfos;
        }

        public void DownloadFiles(string url, IList<string> filesUrls)
        {
            if (filesUrls != null)
            {
                var path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
                if (Directory.Exists(path) == false)
                {
                    string Path = CreateDirectory(url);
                }
                using (WebClient webClient = new WebClient())
                {
                    foreach (string file in filesUrls)
                    {
                        webClient.DownloadFile(file, Path.Combine(path, file.Split('/').Last()));
                    }
                }
            }
        }

        /// <summary>
        /// Copy list of files in the specified url
        /// </summary>
        /// <param name="url"></param>
        /// <param name="files"></param>
        public void CopyFiles(string url, IList<IFormFile> files)
        {
            if (files.Any())
            {
                string path = CreateDirectory(url);

                //Fetch list of files
                foreach (var file in files)
                {
                    //File name
                    string nameFile = file.FileName;
                    //Combine url with name of file
                    var fileUrl = Path.Combine(path, nameFile);
                    //If File doesn't exist==> copy file
                    if (!File.Exists(fileUrl))
                    {
                        //Initialize new instance of fileStream with the specified url and mode of creation
                        using (var fileStream = new FileStream(fileUrl, FileMode.Create))
                        {
                            //Copy file
                            file.CopyTo(fileStream);
                        }
                    }
                }
            }
        }



        /// <summary>
        /// Copy list of files in the specified url
        /// </summary>
        /// <param name="url"></param>
        /// <param name="filesUploaded"></param>
        public void CopyFiles(string url, IList<FileInfoViewModel> filesUploaded)
        {
            if (filesUploaded != null && filesUploaded.Any())
            {
                string path = CreateDirectory(url);
                //Fetch list of files
                foreach (var file in filesUploaded.Where(x => x.FileData != null || x.Data != null))
                {
                    CreatFile(file, path);
                }
            }
        }

        public void DeleteFiles(string url, IList<FileInfoViewModel> filesUploaded)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
            // check wether the path output carry the main directory value -- url is null in this case
            if (Directory.Exists(path))
            {
                DirectoryInfo directory = new DirectoryInfo(path);
                //Fetch list of files
                foreach (FileInfo fileInfo in directory.GetFiles())
                {
                    //if file name dont exist in current list of files==> delete file
                    if (!filesUploaded.Where(x => x.FileData == null && x.Data == null).Select(x => x.Name).Contains(fileInfo.Name))
                    {
                        //Delete file
                        fileInfo.Delete();
                    }
                }
            }
        }

        public void CreatFile(FileInfoViewModel file, string path)
        {
            byte[] fileDataByteArray;
            if (file.FileData != null && file.Data == null)
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

        private string CreateDirectory(string url)
        {
            var path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
            //If directory doesn't exist==> create directory
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            return path;
        }


        /// <summary>
        /// Copy list of files in the specified url
        /// </summary>
        /// <param name="url"></param>
        /// <param name="files"></param>
        public void CopyFiles(string url, FileInfoViewModel file)
        {
            if (file != null)
            {
                string path = CreateDirectory(url);
                CreatFile(file, path);
            }
        }
        public void CopyPdfFilesWithSecurityPassword(string url, IList<FileInfoViewModel> filesUploaded, string password)
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
        /// <summary>
        /// Copy Pdf File With Security Password
        /// </summary>
        /// <param name="url"></param>
        /// <param name="file"></param>
        /// <param name="password"></param>
        public void CopyPdfFileWithSecurityPassword(string url, FileInfoViewModel file, string password)
        {
            if (file != null)
            {
                string path = CreateDirectory(url);
                CreatePdfFileWithSecurityPassword(file, path, password);
            }
        }
        /// <summary>
        /// Create Pdf File With Security Password
        /// </summary>
        /// <param name="file"></param>
        /// <param name="path"></param>
        /// <param name="password"></param>
        public void CreatePdfFileWithSecurityPassword(FileInfoViewModel file, string path, string password)
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
                try
                {
                    using (Stream output = new FileStream(fileUrl, FileMode.Create))
                    {
                        PdfReader reader = new PdfReader(fileDataStream);
                        PdfEncryptor.Encrypt(reader, output, true, password, password, PdfWriter.ALLOW_PRINTING);
                    }
                }
                catch(DirectoryNotFoundException)
                {
                    throw new CustomException(CustomStatusCode.SpecifiedPathIsIncorrect);
                }
                catch(Exception)
                {
                    throw new CustomException(CustomStatusCode.CannotBroadCastFile);
                }
            }
        }


        /// <summary>
        /// Delete list of files 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="files"></param>
        public void DeleteUploadedFiles(string url, ICollection<string> files)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
            // check wether the path output carry the main directory value -- url is null in this case
            if (Directory.Exists(path) && _appSettings.UploadFilePath != path)
            {
                DirectoryInfo directory = new DirectoryInfo(path);
                //Fetch list of files
                foreach (FileInfo fileInfo in directory.GetFiles())
                {
                    //if file name dont exist in current list of files==> delete file
                    if (files == null || !files.Contains(fileInfo.Name))
                    {
                        //Delete file
                        fileInfo.Delete();
                    }
                }
            }
        }

        public FileInfoViewModel Uploadfile(FileInfoViewModel fileInfoViewModel)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, fileInfoViewModel.FulPath);

            if (Directory.Exists(path))
            {
                DirectoryInfo directory = new DirectoryInfo(path);
                //Fetch list of uploaded files
                string filePath = Path.Combine(path, fileInfoViewModel.Name);
                //Add data of file to fileInfoViewModel
                fileInfoViewModel.Data = File.ReadAllBytes(filePath);
            }
            return fileInfoViewModel;
        }


        /// <summary>
        /// Delete directory 
        /// </summary>
        /// <param name="url"></param>
        public void DeleteDirectoryFiles(string url)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
            if (Directory.Exists(path))
            {
                DirectoryInfo directory = new DirectoryInfo(path);
                //If list of file in current directory==> delete directory
                if (!directory.GetFiles().Any())
                {
                    //Delete directory
                    directory.Delete();
                }
            }
        }

        /// <summary>
        /// Delete non empty directory 
        /// </summary>
        /// <param name="url"></param>
        public void DeleteDirectory(string url)
        {
            string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, url);
            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }
        }

        public void DeleteFileAfterChangeConfiguration()
        {


        }

        protected string PrepareZipFile(List<DirectoryInfo> list)
        {
            StringBuilder subfile;
            string downloadPath = Path.Combine(_appSettings.UploadFilePath, GenericConstants.TEMP_PATH);
            // create temporry folder wich holds all requested documents' files
            var uniqueFileName = string.Format(@"{0}", Guid.NewGuid());
            Directory.CreateDirectory(uniqueFileName);
            // prepare zip file path that carry the latest created folder
            StringBuilder zipFilePath = new StringBuilder();
            zipFilePath.Append(GenericConstants.ZIP_FILE_NAME).Append(DateTime.Now.ToString("dd-MM-yyyy-HH-mm", CultureInfo.InvariantCulture)).Append(GenericConstants.ZIP_FILE_EXTENSION);
            string zipPath = zipFilePath.ToString();
            foreach (DirectoryInfo element in list)
            {
                subfile = new StringBuilder(uniqueFileName);
                // compress the current document's folder into the generated folder
                subfile.Append(GenericConstants.SLASH).Append(element.Name).Append(GenericConstants.ZIP_FILE_EXTENSION);
                ZipFile.CreateFromDirectory(element.FullName, subfile.ToString());
            }
            Directory.CreateDirectory(downloadPath);
            // create the final zip file, then delete the temporary folder
            ZipFile.CreateFromDirectory(uniqueFileName, downloadPath + zipPath);
            Directory.Delete(uniqueFileName, true);
            return zipPath;
        }
        private void DirectoryCopy(string sourceDirName, string destDirName, bool copySubDirs)
        {
            // Get the subdirectories for the specified directory.
            DirectoryInfo dir = new DirectoryInfo(sourceDirName);

            if (!dir.Exists)
            {
                throw new DirectoryNotFoundException(
                    "Source directory does not exist or could not be found: "
                    + sourceDirName);
            }

            DirectoryInfo[] dirs = dir.GetDirectories();
            // If the destination directory doesn't exist, create it.
            if (!Directory.Exists(destDirName))
            {
                Directory.CreateDirectory(destDirName);
            }

            // Get the files in the directory and copy them to the new location.
            FileInfo[] files = dir.GetFiles();
            foreach (FileInfo file in files)
            {
                string temppath = Path.Combine(destDirName, file.Name);
                file.CopyTo(temppath, false);
            }

            // If copying subdirectories, copy them and their contents to new location.
            if (copySubDirs)
            {
                foreach (DirectoryInfo subdir in dirs)
                {
                    string temppath = Path.Combine(destDirName, subdir.Name);
                    DirectoryCopy(subdir.FullName, temppath, copySubDirs);
                }
            }
        }


        public string GetFilesName(List<string> docsPath)
        {
            string path;
            List<DirectoryInfo> results = new List<DirectoryInfo>();
            docsPath.ForEach((dp) =>
            {
                path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name, dp);
                if (Directory.Exists(path))
                {
                    results.Add(new DirectoryInfo(path));
                }
            });
            string zipFileName = PrepareZipFile(results);
            return zipFileName;
        }

        public FileInfoViewModel GetFileInfoForDownload(FileInfoViewModel fileInfoViewModel)
        {
            if (fileInfoViewModel == null)
            {
                throw new ArgumentException("");
            }
            // Build complete path of file
            string completePath = fileInfoViewModel.FulPath;
            try
            {
                if (File.Exists(completePath))
                {
                    // Convert file data to bytes
                    fileInfoViewModel.Data = File.ReadAllBytes(completePath);
                    // Delete the payslip on the server temp folder
                    File.Delete(completePath);
                    return fileInfoViewModel;
                }
                else
                {
                    throw new ArgumentException("");
                }
            }
            catch (Exception)
            {
                throw;
            }
        }


        public FileInfoViewModel DownloadZipFile(IList<int> ids)
        {
            List<string> filesPath = GetFilesPath(ids);
            FileInfoViewModel fileInfo = new FileInfoViewModel();
            if (filesPath != null && filesPath.Any())
            {
                string fileName = GetFilesName(filesPath);
                string filePath = Path.Combine(_appSettings.UploadFilePath, GenericConstants.TEMP_PATH, fileName);
                FileInfoViewModel fileInfoViewModel = new FileInfoViewModel
                {
                    Extension = "Zip",
                    Name = fileName,
                    FulPath = filePath
                };
                fileInfo = GetFileInfoForDownload(fileInfoViewModel);
            }

            return fileInfo;
        }

        public virtual List<string> GetFilesPath(IList<int> ids)
        {
            string[] files = Directory.GetFiles(Path.Combine("C:", ""));
            List<string> filesList = files.ToList();
            return filesList;
        }
    }
}
