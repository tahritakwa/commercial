using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Reflection;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Generic.Classes
{
    public abstract partial class Service<TModel, TEntity> : GenericService<TModel, TEntity>, IService<TModel, TEntity>
       where TModel : class
       where TEntity : class
    {
        protected readonly IMemoryCache _cache;
        protected readonly IBuilder<CompanyViewModel, Company> _companyBuilder;
        public IServiceProvider _serviceProvider;
        private readonly IRepository<Address> _addressEntityRepo;
        protected readonly IBuilder<AddressViewModel, Address> _addressBuilder;
        /// <summary>
        /// Generic Constructor
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        protected Service(IRepository<TEntity> entityRepo,
            IUnitOfWork unitOfWork,
            IBuilder<TModel, TEntity> builder,
            IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork)
        {
            _builder = builder;
            _builderEntityAxisValues = builderEntityAxisValues;
            _entityRepoEntityAxisValues = entityRepoEntityAxisValues;
        }

        /// <summary>
        /// Generic Constructor with Memory cache
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        protected Service(IRepository<TEntity> entityRepo,
            IUnitOfWork unitOfWork,
            IBuilder<TModel, TEntity> builder,
            IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IBuilder<CompanyViewModel, Company> companyBuilder,
            IMemoryCache memoryCache)
            : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _companyBuilder = companyBuilder;
            _cache = memoryCache;
        }

        //generic Contractor with File
        protected Service(IRepository<TEntity> entityRepo,
            IUnitOfWork unitOfWork,
            IBuilder<TModel, TEntity> builder,
            IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany)
            : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
        }


        /// <summary>
        /// Generic Constructor with Codification
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="entityRepoEntity"></param>
        /// <param name="entityRepoEntityCodification"></param>
        /// <param name="entityRepoCodification"></param>
        protected Service(IRepository<TEntity> entityRepo,
           IUnitOfWork unitOfWork,
           IBuilder<TModel, TEntity> builder,
           IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification)
           : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoEntity = entityRepoEntity;
            _entityRepoEntityCodification = entityRepoEntityCodification;
            _entityRepoCodification = entityRepoCodification;
        }

        /// <summary>
        /// Generic Constructor with Codification with Memory cache
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="entityRepoEntity"></param>
        /// <param name="entityRepoEntityCodification"></param>
        /// <param name="entityRepoCodification"></param>
        /// <param name="companyBuilder"></param>
        /// <param name="memoryCache"></param>
        protected Service(IRepository<TEntity> entityRepo,
           IUnitOfWork unitOfWork,
           IBuilder<TModel, TEntity> builder,
           IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
           IBuilder<CompanyViewModel, Company> companyBuilder,
           IMemoryCache memoryCache)
            : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _companyBuilder = companyBuilder;
            _cache = memoryCache;
        }


        /// <summary>
        /// Generic Constructor with File
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="appSettings"></param>
        /// <param name="entityRepoCompany"></param>
        /// <param name="entityRepoEntity"></param>
        /// <param name="entityRepoEntityCodification"></param>
        /// <param name="entityRepoCodification"></param>
        protected Service(IRepository<TEntity> entityRepo,
           IUnitOfWork unitOfWork,
           IBuilder<TModel, TEntity> builder,
           IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany,
           IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification)
           : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
            _entityRepoEntity = entityRepoEntity;
            _entityRepoEntityCodification = entityRepoEntityCodification;
            _entityRepoCodification = entityRepoCodification;
        }

        protected Service(IRepository<TEntity> entityRepo,
           IUnitOfWork unitOfWork,
           IBuilder<TModel, TEntity> builder,
           IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany,
           IRepository<Entity> entityRepoEntity,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
            IBuilder<CompanyViewModel, Company> companyBuilder,
            IMemoryCache memoryCache)
           : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
                 appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification,
                 entityRepoCodification)
        {
            _companyBuilder = companyBuilder;
            _cache = memoryCache;
        }

        /// <summary>
        /// Generic Constructor with File and Memory cache
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="builder"></param>
        /// <param name="builderEntityAxisValues"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="appSettings"></param>
        /// <param name="entityRepoCompany"></param>
        /// <param name="companyBuilder"></param>
        /// <param name="memoryCache"></param>
        protected Service(IRepository<TEntity> entityRepo,
            IUnitOfWork unitOfWork,
            IBuilder<TModel, TEntity> builder,
            IBuilder<EntityAxisValuesViewModel, EntityAxisValues> builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IBuilder<CompanyViewModel, Company> companyBuilder,
            IMemoryCache memoryCache)
            : this(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _companyBuilder = companyBuilder;
            _cache = memoryCache;
        }

        public dynamic GetService(string module, string modelName)
        {
            Type model;
            var interfaceName = "Services.Specific." + module + ".Interfaces.IService" + modelName;
            var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);
            if (assemblyInterface == null)
            {
                return null;
            }
            Type type = Type.GetType(assemblyInterface);
            if (type == null)
            {
                return null;
            }
            Type[] implementedInterfaces = type.GetInterfaces();
            model = implementedInterfaces[0].GenericTypeArguments[0];
            dynamic service = _serviceProvider.GetRequiredService(type);
            if (service == null)
            {
                return null;
            }
            return service;
        }


        public virtual DataSourceResult<TModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<TEntity> entities = null;
            PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
            }

            return GetDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);

        }



        public IQueryable<TEntity> GetEntitiesDataWithSpecificFilterRelation(PredicateFormatViewModel predicateModel, IQueryable<TEntity> entities, PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            // Add specific relations (include in entities)
            if (predicateModel.SpecificRelation != null && predicateModel.SpecificRelation.Any())
            {
                foreach (string specificRelation in predicateModel.SpecificRelation)
                {
                    entities = entities.Include(specificRelation);
                }
            }

            // Add specific filter to entities search
            if (predicateModel.SpecFilter != null && predicateModel.SpecFilter.Any())
            {
                foreach (SpecificFilterViewModel specificFilter in predicateModel.SpecFilter)
                {
                    dynamic specificService = GetService(specificFilter.Module, specificFilter.Model);
                    if (specificService == null)
                    {
                        throw new Exception("Can't instanciate the service!");
                    }
                    else
                    {
                        List<dynamic> dataOfCurrentEntityToFilter = new List<dynamic>();
                        dataOfCurrentEntityToFilter.AddRange(specificService.FindNoTrackedModelBy((List<FilterViewModel>)specificFilter.Predicate.Filter));
                        List<int> ids = dataOfCurrentEntityToFilter
                            .Where(y => y.GetType().GetProperty(specificFilter.PropertyOfParentEntity).GetValue(y) != null)
                            .Select(y => (int)(y.GetType().GetProperty(specificFilter.PropertyOfParentEntity).GetValue(y))).ToList();

                        if (predicateModel.Operator == Operator.And)
                        {
                            entities = entities.ToList().Where(x => ids.Contains((int)x.GetType().GetProperty("Id").GetValue(x))).AsQueryable();

                        }
                        else
                        {
                            //get id exclut ids of entities
                            List<int> idsEntities = entities.Select(x => (int)x.GetType().GetProperty("Id").GetValue(x)).ToList();
                            if (ids != null && ids.Any())
                            {
                                List<int> idsSpecificFiltersEntities;
                                if (idsEntities != null && idsEntities.Any())
                                {
                                    idsSpecificFiltersEntities = ids.Where(x => !idsEntities.Contains(x)).ToList();
                                }
                                else
                                {
                                    idsSpecificFiltersEntities = ids;
                                }

                                if (predicateFilterRelationModel != null && idsSpecificFiltersEntities != null && idsSpecificFiltersEntities.Any())
                                {
                                    IQueryable<TEntity> entitiesToAdd = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
                                                   .ToList().Where(x => idsSpecificFiltersEntities.Contains((int)x.GetType().GetProperty("Id").GetValue(x))).AsQueryable();
                                    if (entitiesToAdd != null && entitiesToAdd.Count() > 0)
                                    {
                                        entities = entities.Concat(entitiesToAdd).OrderByRelation(predicateModel.OrderBy);
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return entities;
        }


        public void GetDataWithGenericFilterRelation(List<PredicateFormatViewModel> predicateModel, ref PredicateFormatViewModel predicateModelWithSpecificFilters,
            ref IQueryable<TEntity> entities, PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            PredicateFormatViewModel predIsDefaultPredicate = predicateModel.Where(x => x.IsDefaultPredicate).FirstOrDefault();
            if ((predicateModel.Count() > 1) && predIsDefaultPredicate != null)
            {

                predIsDefaultPredicate.Operator = Operator.And;
                predicateFilterRelationModel = PreparePredicate(predIsDefaultPredicate);
                IQueryable<TEntity> entitiesBeforeGenericFilter = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                                       .OrderByRelation(predIsDefaultPredicate.OrderBy)
                                                       .Where(predicateFilterRelationModel.PredicateWhere);
                PredicateFormatViewModel predOr = predicateModel.Where(x => !x.IsDefaultPredicate).First();
                PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModelOr = PreparePredicate(predOr);
                entities = entitiesBeforeGenericFilter.Where(predicateFilterRelationModelOr.PredicateWhere);
                predicateModelWithSpecificFilters = predOr;

            }
            else
            {
                predicateFilterRelationModel = PreparePredicate(predicateModel[0]);
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                                       .OrderByRelation(predicateModel[0].OrderBy)
                                                       .Where(predicateFilterRelationModel.PredicateWhere);
                predicateModelWithSpecificFilters = predicateModel[0];
            }

        }


        public virtual DataSourceResult<TModel> GetDataWithSpecificFilterRelation(PredicateFormatViewModel predicateModel, IQueryable<TEntity> entities, PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            entities = GetEntitiesDataWithSpecificFilterRelation(predicateModel, entities, predicateFilterRelationModel);
            var total = entities.Count();
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = entities.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
            }
            List<TEntity> listOfModel = entities.ToList();
            List<TModel> model = listOfModel.Select(_builder.BuildEntity).ToList();

            return new DataSourceResult<TModel> { data = model, total = total };
        }

        /// <returns></returns>
        public CompanyViewModel GetCurrentCompany()
        {
            CompanyViewModel companyViewModel;
            string username = ActiveAccountHelper.GetConnectedUserEmail();
            if (_cache is null || _companyBuilder is null || string.IsNullOrEmpty(username))
            {
                Company company = _entityRepoCompany.GetAllWithConditionsRelationsQueryable(
                                                x => true,
                                                x => x.PurchaseSettings,
                                                x => x.SaleSettings,
                                                x => x.Contact,
                                                x => x.IdDefaultTaxNavigation,
                                                x => x.IdCurrencyNavigation)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdCountryNavigation)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdCityNavigation)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdZipCodeNavigation)
                                                .FirstOrDefault();
                var adress = company.Address != null ? company.Address.FirstOrDefault() : null;
                companyViewModel = new CompanyViewModel()
                {
                    Id = company.Id,
                    Code = company.Code,
                    Name = company.Name,
                    TimeSheetPerHalfDay = company.TimeSheetPerHalfDay.Value,
                    PayDependOnTimesheet = company.PayDependOnTimesheet,
                    DaysOfWork = company.DaysOfWork,
                    IdCurrency = company.IdCurrency,
                    CommercialRegister = company.CommercialRegister,
                    AutomaticCandidateMailSending = company.AutomaticCandidateMailSending,
                    IdCurrencyNavigation = new CurrencyViewModel()
                    {
                        Code = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Code : string.Empty,
                        Symbole = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Symbole : string.Empty,
                        Description = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Description : string.Empty,
                        CurrencyInLetter = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.CurrencyInLetter : string.Empty,
                        FloatInLetter = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.FloatInLetter : string.Empty,
                        Precision = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.Precision : 0,
                        IsActive = company.IdCurrencyNavigation != null ? company.IdCurrencyNavigation.IsActive : false,
                    },
                    IdCityNavigation = new CityViewModel()
                    {
                        Code = adress != null && adress.IdCityNavigation != null ? adress.IdCityNavigation.Code : string.Empty,
                        Label = adress != null && adress.IdCityNavigation != null ? adress.IdCityNavigation.Label : string.Empty,
                    },
                    IdCountryNavigation = new CountryViewModel()
                    {
                        Code = adress != null && adress.IdCountryNavigation != null ? adress.IdCountryNavigation.Code : string.Empty,
                        Label = adress != null && adress.IdCountryNavigation != null ? adress.IdCountryNavigation.Label : string.Empty,
                        NameFr = adress != null && adress.IdCountryNavigation != null ? adress.IdCountryNavigation.NameFr : string.Empty,
                        NameEn = adress != null && adress.IdCountryNavigation != null ? adress.IdCountryNavigation.NameEn : string.Empty,
                    },
                    IdZipCodeNavigation = new ZipCodeViewModel()
                    {
                        Region = adress != null && adress.IdZipCodeNavigation != null ? adress.IdZipCodeNavigation.Region : string.Empty,
                        Code = adress != null && adress.IdZipCodeNavigation != null ? adress.IdZipCodeNavigation.Code : string.Empty,
                        IdCity = adress != null && adress.IdZipCodeNavigation != null ? adress.IdZipCodeNavigation.IdCity : null,
                    }
                };

            }
            else
            {
                var user = DecryptToken()["user"];
                UserViewModel newUser = JsonConvert.DeserializeObject<UserViewModel>(user.ToString());
                string userEmail = newUser.Email;
                string companyCode = _cache.Get(userEmail).ToString();
                companyViewModel = _cache.GetOrCreate("CurrentCompany" + username + companyCode, entry =>
                {
                    companyViewModel = _entityRepoCompany.GetAllWithConditionsRelationsQueryable(
                                                x => x.Code == companyCode,
                                                x => x.PurchaseSettings,
                                                x => x.SaleSettings,
                                                x => x.IdDefaultTaxNavigation,
                                                x => x.IdCurrencyNavigation)
                                                .Include(x => x.Contact)
                                                .ThenInclude(x => x.Phone)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdCountryNavigation)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdCityNavigation)
                                                .Include(x => x.Address)
                                                .ThenInclude(x => x.IdZipCodeNavigation)
                                                .Select(x => _companyBuilder.BuildEntity(x))
                                                .FirstOrDefault();
                    return companyViewModel;
                });
            }
            return companyViewModel;


        }

        public string GetConnectionString()
        {
            MasterUserViewModel user = JsonConvert.DeserializeObject<MasterUserViewModel>(DecryptToken()["user"].ToString());
            DbSettings dbSettings = _cache.Get(user.LastConnectedCompany) as DbSettings;
            return string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
            dbSettings.Server, dbSettings.DataBaseName, dbSettings.UserId, dbSettings.UserPassword);
        }
        public string GetBTobConnectionString()
        {
            DbSettings dbSettings = _cache.Get("companySetting") as DbSettings;
            return string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
            dbSettings.Server, dbSettings.DataBaseName, dbSettings.UserId, dbSettings.UserPassword);
        }
        /// <summary>
        /// Reset current company from the memory cache
        /// </summary>
        public void ResetCacheCurrentCompany()
        {
            try
            {
                string username = ActiveAccountHelper.GetConnectedUserEmail();
                var companyCode = _cache.Get(username);
                PropertyInfo field = typeof(MemoryCache).GetProperty("EntriesCollection", BindingFlags.NonPublic | BindingFlags.Instance);
                if (field.GetValue(_cache) is ICollection memoryCollection)
                {
                    foreach (var item in memoryCollection)
                    {
                        string value = item.GetType().GetProperty("Key").GetValue(item).ToString();
                        if (value.Contains("CurrentCompany") && value.Contains(companyCode.ToString()))
                        {
                            _cache.Remove(value);
                        }
                    }
                }
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


        public virtual ReportSettings GetDocumentReportSettings(DownloadReportDataViewModel data, HttpContext httpContext, string userMail, PrinterSettings printerSettings = null)
        {
            ReportSettings reportSetting = new ReportSettings();
            CompanyViewModel company = GetCurrentCompany();
            if (_appSettings != null)
            {
                reportSetting.Url = _appSettings.BaseUrl.ToString();
            }
            reportSetting.User = userMail;
            reportSetting.Id = data.Id;
            reportSetting.IsFromBL = data.IsFromBl ?? 0;
            reportSetting.NumberofCopies = 1;
            reportSetting._printerSettings = printerSettings;
            if (company != null && company.DataLogoCompany != null)
            {
                reportSetting.IdCompany = company.Id;
                reportSetting.DataLogoCompany = Convert.ToBase64String(company.DataLogoCompany);
            }
            else
            {
                reportSetting.ReportName = data.ReportName;
            }
            reportSetting.ReportConnectionString = GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.ReportParameters = data.Reportparameters;
            return reportSetting;

        }

        public IList<TModel> GenerateListFromExcel(Stream excelDataStream, string identificationColumn, IEqualityComparer<TModel> comparer = null, int index = 0)
        {
            List<string> excelColumnsName = new List<string>();
            IList<TModel> GenerateListFromExcel = GetModelListFromExcel(excelDataStream, identificationColumn, excelColumnsName, index);
            IEnumerable<TModel> existingItemsFromDB = GetAllModelsAsNoTracking();
            IList<TModel> listToReturn = new List<TModel>();
            foreach (TModel currentFromExcel in GenerateListFromExcel)
            {
                TModel existingItem;
                existingItem = existingItemsFromDB.FirstOrDefault(x =>
                string.Compare(x.GetType().GetProperty(x.GetType().GetProperty(identificationColumn).Name).
                    GetValue(x).ToString(),
                    currentFromExcel.GetType().GetProperty(currentFromExcel.GetType().GetProperty(identificationColumn).Name).
                    GetValue(currentFromExcel).ToString(), false, CultureInfo.CurrentCulture) == NumberConstant.Zero);
                // in update user mode
                if (existingItem != null)
                {
                    if ((comparer != null && !comparer.Equals(existingItem, currentFromExcel)) ||
                        (comparer == null && !IsEqualsComparingWithExcelColumns(currentFromExcel, existingItem, excelColumnsName)))
                    {
                        // if some data changed in excel compared to existing
                        listToReturn.Add(PatchedExcel(currentFromExcel, existingItem, excelColumnsName));
                    }

                }// in add user mode
                else
                {
                    listToReturn.Add(currentFromExcel);
                }
            }
            return listToReturn;
        }

        private static bool IsEqualsComparingWithExcelColumns(TModel currentFromExcel, TModel existingItem, List<string> excelColumnsName)
        {
            foreach (string column in excelColumnsName)
            {
                if ((currentFromExcel.GetType().GetProperty(column).GetValue(currentFromExcel) ?? "").ToString() !=
                (existingItem.GetType().GetProperty(column).GetValue(existingItem) ?? "").ToString())
                {
                    return false;
                }
            }
            return true;
        }
        private static TModel PatchedExcel(TModel currentFromExcel, TModel existingItem, List<string> excelColumnsName)
        {

            excelColumnsName.ForEach(x =>
            {

                existingItem.GetType().GetProperty(existingItem.GetType().GetProperty(x).Name).
                     SetValue(existingItem, currentFromExcel.GetType().GetProperty(currentFromExcel.GetType().GetProperty(x).Name).
                     GetValue(currentFromExcel));

            });
            return existingItem;
        }

        public virtual void UpdateReportSettings(DownloadReportDataViewModel data)
        {
            var language = ActiveAccountHelper.GetConnectedUserCredential().Language;
            if (language != null)
            {
                data.ReportName = language.Equals(GenericConstants.French) ? string.Concat(data.ReportName, GenericConstants.Underscore, GenericConstants.French) : string.Concat(data.ReportName, GenericConstants.Underscore, GenericConstants.English);
            }
            else
            {
                data.ReportName = string.Concat(data.ReportName, GenericConstants.Underscore, GenericConstants.French);
            }
        }

        public virtual string GetStarkWebSiteUrl()
        {
            return _appSettings != null && !string.IsNullOrEmpty(_appSettings.StarkWebSiteUrl) ? _appSettings.StarkWebSiteUrl : string.Empty;
        }

        public virtual string GetStarkLogo()
        {
            string path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "assets", "images", "StarkNewLogo.PNG");
            return File.Exists(path) ?
                   Convert.ToBase64String(File.ReadAllBytes(path)) :
                   string.Empty;
        }

        public int GetCompanyCurrencyPrecision()
        {
            CurrencyViewModel companyCurrency = GetCurrentCompany().IdCurrencyNavigation;
            return companyCurrency.Precision;
        }

        /// <summary>
        ///  Check if value precision is lower or equal to current company precision
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public int CheckWithCurrentCompanyCurrencyPrecision(string value)
        {
            if (value.NotNullOrEmpty() && value.Contains(GenericConstants.Point))
            {
                CompanyViewModel company = GetCurrentCompany();
                int numberOfDigitsAfterComma = value.Substring(value.IndexOf(GenericConstants.Point) + NumberConstant.One).Length;
                return numberOfDigitsAfterComma > company.IdCurrencyNavigation.Precision ? company.IdCurrencyNavigation.Precision : NumberConstant.Zero;
            }
            else
            {
                return NumberConstant.Zero;
            }
        }


    }
}
