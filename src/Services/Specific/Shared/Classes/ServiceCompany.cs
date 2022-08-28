using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Shared.Classes
{
    public class ServiceCompany : Service<CompanyViewModel, Company>, IServiceCompany
    {
        private readonly IRepository<PurchaseSettings> _entityRepoPurchaseSettings;

        private readonly IRepository<SaleSettings> _entityRepoSaleSettings;
        private readonly IRepository<Address> _entityRepoAddress;
        private readonly IRepository<FinancialCommitment> _entityRepoFinancialCommitment;
        private readonly IServiceMasterCompany _serviceMasterCompany;
        private readonly IMasterDbSettingsBuilder _masterDbSettingsBuilder;
        private readonly IRepository<ZipCode> _entityRepoZipCode;
        private readonly IReducedCurrencyBuilder _reducedCurrencyBuilder;
        private readonly IRepository<Phone> _repoPhone;
        public ServiceCompany(IServiceMasterCompany serviceMasterCompany,
            IRepository<PurchaseSettings> entityRepoPurchaseSettings,
            IRepository<SaleSettings> entityRepoSaleSettings,
            IRepository<FinancialCommitment> entityRepoFinancialCommitment,
            IRepository<Company> entityRepo,
            IUnitOfWork unitOfWork,
            ICompanyBuilder builder,
            IMasterDbSettingsBuilder masterDbSettingsBuilder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Address> entityRepoAddress,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<ZipCode> entityRepoZipCode,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache,
            IReducedCurrencyBuilder reducedCurrencyBuilder,
            IRepository<Phone> repoPhone)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _entityRepoPurchaseSettings = entityRepoPurchaseSettings;
            _entityRepoSaleSettings = entityRepoSaleSettings;
            _entityRepoFinancialCommitment = entityRepoFinancialCommitment;
            _serviceMasterCompany = serviceMasterCompany;
            _masterDbSettingsBuilder = masterDbSettingsBuilder;
            _entityRepoAddress = entityRepoAddress;
            _entityRepoZipCode = entityRepoZipCode;
            _reducedCurrencyBuilder = reducedCurrencyBuilder;
            _repoPhone = repoPhone;
        }




        public override object UpdateModelWithoutTransaction(CompanyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                ResetCacheCurrentCompany();
                // save entity traceability
                Company entity = _builder.BuildModel(model);
                // update collection entity                
                UpdateCollections(entity, userMail);
                // recuperate entity before update
                Company entityBeforeUpdate = _entityRepo.FindByAsNoTracking(p => p.Id == entity.Id).FirstOrDefault();
                //Get saved AttachmentUrl
                if (entityBeforeUpdate.AttachmentUrl != null && !string.IsNullOrEmpty(entityBeforeUpdate.AttachmentUrl))
                    model.AttachmentUrl = entityBeforeUpdate.AttachmentUrl;
                else
                    //Add url of attachment image
                    model.AttachmentUrl = Path.Combine("Shared", "Company", DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff"));

                entity.AttachmentUrl = model.AttachmentUrl;
                entity.Code = entityBeforeUpdate.Code;
                // update entity
                _entityRepo.Update(entity);
                // update entityAxesValues
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
                ICollection<string> filesNames = null;
                //If list of images not null ==> recuperate list of images name
                if (model.Files != null && model.Files.Any() && model.Files[0].Name != null)
                {
                    filesNames = new List<string>
                    {
                        model.Files[0].FileName
                    };
                }

                //Delete files from directory
                DeleteUploadedFiles(model.AttachmentUrl, filesNames);
                //Copy images to specific url
                if (model.Files != null && model.Files.Any())
                {
                    CopyFiles(model.AttachmentUrl, model.Files);
                    if (Directory.Exists(Path.Combine(_appSettings.UploadFilePath, entity.Name, model.AttachmentUrl)))
                    {
                        var FileUrl = Path.Combine(_appSettings.UploadFilePath, entity.Name, model.AttachmentUrl, model.Files[0].FileName);
                        entity.DataLogoCompany = File.ReadAllBytes(FileUrl);
                    }

                }
                //Delete directory if list of file in current directory null
                DeleteDirectoryFiles(model.AttachmentUrl);
                // commit 
                _unitOfWork.Commit();
                return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                VerifyDuplication(e);
                throw;
            }
        }
        private void CheckDaysOfWorkValidity(CompanyViewModel company)
        {
            if (company.DaysOfWork.HasValue)
            {
                if (company.DaysOfWork.Value > NumberConstant.ThirtyOne)
                {
                    throw new CustomException(CustomStatusCode.NumberOfWorkedDaysExceeded);
                }
                else if (company.DaysOfWork.Value < NumberConstant.Twenty)
                {
                    throw new CustomException(CustomStatusCode.NumberOfWorkedDaysNotReached);
                }
            }
        }
        //check if the zipCode exist or create a new zipcode 
        private ZipCode checkExistingZipCode(CompanyViewModel company)
        {
                ZipCode zipCoderesult = new ZipCode();
                var address = company.Address != null ? company.Address.FirstOrDefault() : null;
                if (company.Address != null && company.Address.Any())
                {
                    zipCoderesult = _entityRepoZipCode.GetAllAsNoTracking().Where(x => x.Code == address.CodeZip && x.IdCity == address.IdCity && x.Region == address.Region).FirstOrDefault();
                    if (zipCoderesult != null)
                    {
                        return zipCoderesult;
                    }
                    else
                    {
                        zipCoderesult = new ZipCode
                        {
                            Id = 0,
                            Code = address.CodeZip,
                            IdCity = address.IdCity,
                            Region = address.Region
                        };
                        _entityRepoZipCode.Add(zipCoderesult);
                        _unitOfWork.Commit();

                    }

                }
                return zipCoderesult;
        }
        public void UpdateCompanyWithoutTransaction(CompanyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            try
            {
                CheckDaysOfWorkValidity(model);
                CheckWithholdingTax(model);
                CheckContacts(model);
                ResetCacheCurrentCompany();
                ZipCode zipCodeEntity = checkExistingZipCode(model);
                //Mange Picture 
                if (model.PictureFileInfo != null)
                {
                    ManagePicture(model);

                }
                // save entity traceability
                Company entity = _builder.BuildModel(model);
                if (entity.Contact != null && entity.Contact.Count > NumberConstant.Zero)
                {
                    List<Phone> phones = entity.Contact.SelectMany(x => x.Phone).ToList();
                    phones.Select(x => {
                        x.IsDeleted = !x.Number.HasValue ? true : x.IsDeleted;
                        x.DeletedToken = x.IsDeleted ? Guid.NewGuid().ToString() : null; return x; }).ToList();
                    _repoPhone.BulkUpdate(phones);
                }
                foreach (Address address in entity.Address)
                {
                    address.IdZipCode = zipCodeEntity.Id;
                }
                // manage defaultTax
                if (entity.IdDefaultTax == null)
                {
                    entity.IdDefaultTaxNavigation = null;
                }
                // update collection entity                
                UpdateCollections(entity, userMail);
                // recuperate entity before update
                Company entityBeforeUpdate = _entityRepo.FindByAsNoTracking(p => p.Id == entity.Id).FirstOrDefault();
                entity.AttachmentUrl = model.AttachmentUrl;
                entity.Code = entityBeforeUpdate.Code;
                // update entity
                _entityRepo.Update(entity);
                _entityRepoPurchaseSettings.Update(entity.PurchaseSettings);
                _entityRepoSaleSettings.Update(entity.SaleSettings);
                // update entityAxesValues
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
                // commit 
                _unitOfWork.Commit();
            }
            catch (CustomException ex)
            {
                throw;
            }
            catch (Exception e)
            {
                VerifyDuplication(e);
                throw;
            }
        }
        


        /// <summary>
        /// Check if there are missing data in contacts
        /// </summary>
        /// <param name="model"></param>
        private void CheckContacts(CompanyViewModel model)
        {
            if (model.Contact != null && model.Contact.Count > NumberConstant.Zero &&
                model.Contact.Any(x => !x.IsDeleted && (string.IsNullOrEmpty(x.FirstName) || string.IsNullOrEmpty(x.LastName))))
            {
                throw new CustomException(CustomStatusCode.MissingData);
            }
            if (model.Contact.Any())
            {
                model.Contact.ToList().ForEach(contact =>
                {
                    if (contact.PictureFileInfo != null)
                    {
                        ManagePictureForContact(contact);

                    }
                });
            }
        }
        public void CheckWithholdingTax(CompanyViewModel model)
        {
            if (model != null && model.WithholdingTax == false)
            {
                // throw error if user try to change company setting and set withoholding Tax to false
                // while there is already financial commitment configured with withholdingTax 
                bool financialCommitmentsHasWithholdingTax = _entityRepoFinancialCommitment.GetAllWithConditionsRelations(x =>
                x.WithholdingTaxWithCurrency.HasValue && x.WithholdingTaxWithCurrency.Value > 0).Any();
                if (financialCommitmentsHasWithholdingTax)
                {
                    throw new CustomException(CustomStatusCode.changingWithholdingTaxCompanySettings);
                }
            }
        }
        public object UpdateCompany(CompanyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, bool role)
        {
            try
            {
                BeginTransaction();

                Company company = _entityRepoCompany.GetSingleWithRelationsNotTracked(x => x.Id == model.Id, y => y.PurchaseSettings);
                if (company.PurchaseSettings.IdPurchasingManager != model.PurchaseSettings.IdPurchasingManager)
                {
                    if (!role)
                    {
                        model.PurchaseSettings.IdPurchasingManager = company.PurchaseSettings.IdPurchasingManager;
                    }
                }

                UpdateCompanyWithoutTransaction(model, entityAxisValuesModelList, userMail);
                ResetCacheCurrentCompany();
                EndTransaction();
                return new CreatedDataViewModel { Id = (int)company.Id, EntityName = company.GetType().Name.ToUpper() };
            }
            catch (CustomException e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw exception
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }

        /// <summary>
        /// Get MasterCompany with specified code as CompanyViewModel with DbSettings
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public CompanyViewModel GetCompanyWithDbSettings(string code)
        {
            MasterCompanyViewModel masterCompanyViewModel = _serviceMasterCompany.FindModelsByNoTracked(x => x.Code == code, x => x.IdMasterDbSettingsNavigation).FirstOrDefault();
            CompanyViewModel companyViewModel = _companyBuilder.BuildMasterSlaveModel(masterCompanyViewModel, Activator.CreateInstance<CompanyViewModel>());
            companyViewModel.DbSettings = _masterDbSettingsBuilder.BuildMasterSlaveModel(masterCompanyViewModel.IdMasterDbSettingsNavigation, Activator.CreateInstance<DbSettings>());
            SetDefaultSettings(companyViewModel);
            return companyViewModel;
        }

        /// <summary>
        /// Get All MasterCompanyViewModel as Slave CompanyViewModel with their DBSettings
        /// </summary>
        /// <returns></returns>
        public IList<CompanyViewModel> GetCompaniesWithDbSettings()
        {
            IList<CompanyViewModel> companyViewModels = new List<CompanyViewModel>();
            IEnumerable<MasterCompanyViewModel> masterCompanyViewModels = _serviceMasterCompany.GetAllModelsWithRelations(x => x.IdMasterDbSettingsNavigation);
            foreach (MasterCompanyViewModel masterCompanyViewModel in masterCompanyViewModels)
            {
                CompanyViewModel companyViewModel = (CompanyViewModel)_companyBuilder.BuildMasterSlaveModel(masterCompanyViewModel, Activator.CreateInstance<CompanyViewModel>());
                companyViewModel.DbSettings = _masterDbSettingsBuilder.BuildMasterSlaveModel(masterCompanyViewModel.IdMasterDbSettingsNavigation, Activator.CreateInstance<DbSettings>());
                SetDefaultSettings(companyViewModel);
                companyViewModels.Add(companyViewModel);
            };
            return companyViewModels;
        }

        /// <summary>
        /// Use the default parameters if ever a parameter is not mentioned
        /// </summary>
        /// <param name="companyViewModel"></param>
        private void SetDefaultSettings(CompanyViewModel companyViewModel)
        {
            if (string.IsNullOrEmpty(companyViewModel.DbSettings.Server))
            {
                companyViewModel.DbSettings.Server = _appSettings.DbSettings.Server;
            }
            if (string.IsNullOrEmpty(companyViewModel.DbSettings.UserId))
            {
                companyViewModel.DbSettings.UserId = _appSettings.DbSettings.UserId;
            }
            if (string.IsNullOrEmpty(companyViewModel.DbSettings.UserPassword))
            {
                companyViewModel.DbSettings.UserPassword = _appSettings.DbSettings.UserPassword;
            }
        }

        /// <summary>
        /// Get All DBSettings, used often for Jobs
        /// </summary>
        /// <returns></returns>
        public IEnumerable<DbSettings> GetAllDbSettings()
        {
            return GetCompaniesWithDbSettings().Select(m => m.DbSettings);
        }

        public CommRhProperties GetCommRhVersionProperties()
        {
            string version = "1.0.0";
            string location = Directory.GetCurrentDirectory();
            // string location = Path.Combine("..", "..", "..", "01-Web", "SparkIt.Web");

            if (Directory.Exists(location))
            {
                using (StreamReader r = new StreamReader(Path.Combine("package.json")))
                {
                    string jsonEnv = r.ReadToEnd();
                    dynamic dynamicJsonEnv = JsonConvert.DeserializeObject(jsonEnv);
                    version = dynamicJsonEnv["version"];
                }

            }
            CommRhProperties properties = new CommRhProperties()
            {
                BaseURL = _appSettings.BaseUrl.ToString(),
                Version = version
            };
            return properties;
        }
        /// <summary>
        /// get company information for report 
        /// </summary>
        public ReportCompanyInformationViewModel GetReportCompanyInformation()
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            AddressViewModel adress = (companyViewModel.Address != null && companyViewModel.Address.Any()) ? companyViewModel.Address.ToList()[NumberConstant.Zero] : null;
            ReportCompanyInformationViewModel model = new ReportCompanyInformationViewModel
            {
                CompanyName = companyViewModel.Name ?? string.Empty,
                CompanyAdress = adress != null ? adress.PrincipalAddress : string.Empty,
                CompanyEmail = companyViewModel.Email ?? string.Empty,
                CompanyWebSite = companyViewModel.WebSite ?? string.Empty,
                CompanyCountry = adress != null && adress.IdCountry != null && adress.IdCountryNavigation != null && !string.IsNullOrEmpty(adress.IdCountryNavigation.NameFr) ? adress.IdCountryNavigation.NameFr : string.Empty,
                CompanyCity = adress != null && adress.IdCity != null && adress.IdCityNavigation != null && !string.IsNullOrEmpty(adress.IdCityNavigation.Label) ? adress.IdCityNavigation.Label : string.Empty,
                CompanyZipCode = adress != null && adress.IdZipCode != null && adress.IdZipCodeNavigation != null && !string.IsNullOrEmpty(adress.IdZipCodeNavigation.Code) ? adress.IdZipCodeNavigation.Code : string.Empty,

                CompanyTel = companyViewModel.Tel1 != null ? companyViewModel.Tel1 : string.Empty,
                CompanyCommercialRegister = companyViewModel.CommercialRegister ?? string.Empty,
                CompanySiret = companyViewModel.Siret ?? string.Empty,
                StarkWebSiteUrl = GetStarkWebSiteUrl(),
                StarkLogo = GetStarkLogo(),
                CompanyLogo = PrepareImageForReporting(companyViewModel.AttachmentUrl, _appSettings.UploadFilePath),
                CompanyMatriculeFisc = companyViewModel.MatriculeFisc ?? string.Empty,
                CompanyCnssAffiliation = companyViewModel.CnssAffiliation ?? string.Empty,
                CompanyCurrency = companyViewModel.IdCurrencyNavigation != null && !string.IsNullOrEmpty(companyViewModel.IdCurrencyNavigation.Symbole) ? companyViewModel.IdCurrencyNavigation.Symbole : string.Empty,
                VatNumber = companyViewModel.VatNumber
            };
            return model;
        }
        public void ManagePicture(CompanyViewModel company)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(company.AttachmentUrl))
            {
                if (company.PictureFileInfo?.FileData != null)
                {
                    company.AttachmentUrl = Path.Combine("Administration", "Company", company.Name, Guid.NewGuid().ToString());
                    CopyFiles(company.AttachmentUrl, company.PictureFileInfo);
                }
            }
            else
            {
                if (company.PictureFileInfo != null)
                {
                    List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                    fileInfo.Add(company.PictureFileInfo);
                    DeleteFiles(company.AttachmentUrl, fileInfo);
                    CopyFiles(company.AttachmentUrl, fileInfo);
                }
            }
            if (company.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }

        private void ManagePictureForContact(ContactViewModel contact)
        {
            if (string.IsNullOrEmpty(contact.UrlPicture))
            {
                if (contact.PictureFileInfo != null)
                {
                    contact.UrlPicture = Path.Combine("Shared", "Contact", contact.Label, Guid.NewGuid().ToString());
                    CopyFiles(contact.UrlPicture, contact.PictureFileInfo);
                }
            }
            else
            {
                if (contact.PictureToDelete)
                {
                    DeleteDirectory(Path.Combine("Shared", "Contact", contact.Label));
                    contact.UrlPicture = null;
                }
                else
                {
                    CopyFiles(contact.UrlPicture, contact.PictureFileInfo);
                }
            }
            if (contact.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        public ReducedCurrencyViewModel GetCurrentCompanyCurrency()
        {
            Company company = _entityRepo.GetAllWithConditionsRelationsQueryable(
                                                x => true,
                                                x => x.IdCurrencyNavigation).FirstOrDefault();

            ReducedCurrencyViewModel reducedCurrencyViewModel = _reducedCurrencyBuilder.BuildEntity(
                company.IdCurrencyNavigation);

            return reducedCurrencyViewModel;
        }

        /// <summary>
        /// Get current company with contact pictures
        /// </summary>
        /// <returns></returns>
        public CompanyViewModel GetCurrentCompanyWithContactPictures()
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            if (companyViewModel.Contact != null && companyViewModel.Contact.Any())
            {
                companyViewModel.Contact.ToList().ForEach(contact =>
                {
                    if (contact.UrlPicture != null)
                    {
                        contact.PictureFileInfo = GetFiles(contact.UrlPicture).FirstOrDefault();
                    }
                });
            }
            return companyViewModel;
        }

        public int GetMasterCompanyId(string companyCode)
        {
            return _serviceMasterCompany.GetModelAsNoTracked(c => c.Code == companyCode).Id;
        }
        public DbSettings GetCompanyDbSettings(string companyCode)
        {
            return GetCompaniesWithDbSettings().Where(c => c.Code == companyCode).Select(m => m.DbSettings).FirstOrDefault();
        }

        public int GetCurrentCompanyActivityArea()
        {
            return _entityRepo.GetAllWithConditionsRelationsQueryable(x => true).FirstOrDefault().ActivityArea;
        }
        /// <summary>
        /// method get current company activity area and currency
        /// </summary>
        /// <returns></returns>
        public ReducedCurrencyAndActivityAreaViewModel GetCurrentCompanyActivityAreaAndCurrency()
        {
            Company company = _entityRepo.GetAllWithConditionsRelationsQueryable(
                                                x => true,
                                                x => x.IdCurrencyNavigation).FirstOrDefault();
            ReducedCurrencyAndActivityAreaViewModel model = new ReducedCurrencyAndActivityAreaViewModel
            {
                IdCurrency = company.IdCurrencyNavigation.Id,
                CurrencyCode = company.IdCurrencyNavigation.Code,
                CurrencySymbole = company.IdCurrencyNavigation.Symbole,
                CurrencyDescription = company.IdCurrencyNavigation.Description,
                CurrencyPrecision = company.IdCurrencyNavigation.Precision,
                ActivityArea = company.ActivityArea
            };
            return model;
        }
    }
}
