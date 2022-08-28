using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Catalog.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Shared;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/company")]
    public class CompanyController : BaseController, ICompanyController
    {
        private readonly IServiceCompany _companyService;
        private readonly AppSettings _appSettings;
        private readonly IServiceMasterCompany _serviceMasterCompany;

        public CompanyController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, ILogger<CompanyController> logger, IServiceCompany companyService,
            IServiceMasterCompany serviceMasterCompany) : base(serviceProvider, logger)
        {
            _appSettings = appSettings.Value;
            _companyService = companyService;
            _serviceMasterCompany = serviceMasterCompany;
        }

        /// <summary>
        /// Update company
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <param name="objectJsonToSave"></param>
        /// <returns></returns>
        [HttpPut("updateCompany"), Authorize("UPDATE_COMPANY,SHOW_COMPANY")]
        public ResponseData UpdateCompany([FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            //if objectJsonToSave(object format json) not null ==> convert objectJsonToSave to ObjectToSaveViewModel
            ObjectToSaveViewModel objectToSave;
            bool role = SpecificAuthorizationCheck.CheckAuthorizationByName("Purchase-Responsible", Request.HttpContext);
            if (objectJsonToSave != null)
            {
                objectToSave = JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave);
            }
            else
            {
                objectToSave = objectSaved;
            }
            if (objectToSave.model != null)
            {
                CompanyViewModel instanceType = JsonConvert.DeserializeObject<CompanyViewModel>(objectToSave.model.ToString());

                GetUserMail();
                var obj = _companyService.UpdateCompany(instanceType, objectToSave.EntityAxisValues, userMail, role);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.objectData = obj;
                result.flag = 1;
            }
            return result;
        }

        /// <summary>
        /// Get current company
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrentCompany")]
        public CompanyViewModel getCurrentCompany()
        {
            return _companyService.GetCurrentCompany();
        }

        /// <summary>
        /// Get currency of current company
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrencyCompanyDetails")]
        [AllowAnonymous]
        public ReducedCurrencyViewModel GetCurrencyCompanyDetails()
        {
            return _companyService.GetCurrentCompanyCurrency();
        }

        /// <summary>
        /// Get all master companies
        /// </summary>
        /// <returns></returns>
        [HttpGet("getAllMasterCompanies"), Authorize("LIST_COMPANY,ADD_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT")]
        public IList<MasterCompanyViewModel> GetetAllMasterCompanies()
        {
            return _serviceMasterCompany.GetAllModels();
        }

        /// <summary>
        /// Get all master companies
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCommRhVersionProperties"), Authorize("LIST_COMPANY,SHOW_ABOUT")]
        public CommRhProperties GetCommRhVersionProperties()
        {
            return _companyService.GetCommRhVersionProperties();
        }

        /// <summary>
        /// Get currency symbole of current company
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrencyCompanySymbol")]
        public string GetCurrencyCompanySymbol()
        {
            return _companyService.GetCurrentCompany().IdCurrencyNavigation.Symbole;
        }

        /// <summary>
        /// Get some data of  current company
        /// </summary>
        /// <returns></returns>
        [HttpGet("getReducedDataOfCompany")]
        public ReducedDataOfCompanyViewModel GetReducedDataOfCompany()
        {
            CompanyViewModel company = _companyService.GetCurrentCompany();
            ReducedDataOfCompanyViewModel reducedDataOfCompanyViewModel = new ReducedDataOfCompanyViewModel()
            {
                AllowEditionItemDesignation = company.AllowEditionItemDesignation,
                PurchaseAllowItemRelatedToSupplier = company.PurchaseSettings.PurchaseAllowItemRelatedToSupplier,
                WithholdingTax = company.WithholdingTax,
                FiscalStamp = company.FiscalStamp,
                AllowRelationSupplierItems = company.AllowRelationSupplierItems,
                NoteIsRequired = company.NoteIsRequired
            };
            return reducedDataOfCompanyViewModel;
        }
        /// <summary>
        ///  Get current company with contact pictures
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrentCompanyWithContactPictures")]
        public CompanyViewModel GetCurrentCompanyWithContactPictures()
        {
            return _companyService.GetCurrentCompanyWithContactPictures();
        }
        [HttpPost("getPicture"), Authorize("SHOW_COMPANY,UPDATE_COMPANY,PRINT_RECONCILIATION_BANK,PRINT_RECONCILIATION_BANK_STATEMENT,PRINT_AMORTIZATION_TABLE," +
            "PRINT_EDITIONS_REPORTS,PRINT_FINANCIAL_STATES_REPORTS,PRINT_JOURNALS_REPORTS")]
        public override byte[] getPicture([FromBody] string path)
        {
            return base.getPicture(path);
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("SHOW_COMPANY,UPDATE_COMPANY,COMPANY")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getReportCompanyInformation"), Authorize("COMPANY")]
        public ResponseData GetReportCompanyInformation()
        {
            ResponseData result = new ResponseData
            {
                objectData = _companyService.GetReportCompanyInformation()
            };
            return result;
        }

        /// <summary>
        /// Get currency activity area of current company
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrencyCompanyActivityArea")]
        public int GetCurrencyCompanyActivityArea()
        {
            return _companyService.GetCurrentCompany().ActivityArea;
        }
    }
}
