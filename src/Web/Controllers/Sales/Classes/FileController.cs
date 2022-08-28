using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System.IO;
using Utils.Constants;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/Files")]
    public class FileController : Controller
    {
        private readonly IServiceDocument _serviceDocument;
        private readonly ILogger<FileController> _logger;
        internal readonly AppSettings _appSettings;
        public FileController(IServiceDocument serviceDocument, ILogger<FileController> logger, IOptions<AppSettings> appSettings)
        {
            _serviceDocument = serviceDocument;
            _logger = logger;
            if (appSettings != null)
                _appSettings = appSettings.Value;
        }

        [HttpGet("deleteZipFile")]
        public IActionResult DeleteZIPFile([FromQuery] string fileName)
        {
            string filePath = Path.Combine(_appSettings.UploadFilePath, GenericConstants.TEMP_PATH, fileName);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }
            return StatusCode(200);
        }
    }
}
