using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/cnssDeclaration")]
    public class CnssDeclarationController : BaseController
    {
        private readonly IServiceCnssDeclaration _serviceCnssDeclaration;
        public CnssDeclarationController(IServiceProvider serviceProvider,
            ILogger<CnssDeclarationController> logger, IServiceCnssDeclaration serviceCnssDeclaration)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceCnssDeclaration = serviceCnssDeclaration;
        }

        /// <summary>
        /// Generate cnss declaration
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <returns></returns>
        [HttpPost("generateDeclaration"), Authorize("ADD_CNSSDECLARATION,REGENERATE_CNSS_DECLARATION")]
        public ResponseData GenerateCnssDeclaration([FromBody] CnssDeclarationViewModel model)
        {
            GetUserMail();
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceCnssDeclaration.GenerateCnssDeclaration(model, userMail),
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return responseData;
        }

        [HttpGet("getTeleDeclaration/{idCnssDeclaration}"), Authorize("PRINT_TELE_DECLARATION")]
        public ResponseData GetTeleDeclaration(int idCnssDeclaration)
        {
            if (idCnssDeclaration == 0)
            {
                throw new ArgumentException("");
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceCnssDeclaration.GetTeleDeclaration(idCnssDeclaration),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_CNSSDECLARATION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_CNSS_DECLARATION_SUMMURY")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }

        [HttpPost("closeCnssDeclaration"), Authorize("CLOSE_CNSSDECLARATION")]
        public ResponseData CloseCnssDeclaration([FromBody] CnssDeclarationViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            GetUserMail();
            _serviceCnssDeclaration.CloseCnssDeclaration(model, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
    }
}
