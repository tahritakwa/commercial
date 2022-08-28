using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using OfficeOpenXml;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Enumerators;
using static Utils.Enumerators.CommercialEnumerators.DocumentEnumerator;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;
using ViewModels.DTO.B2B;

namespace Services.Specific.Sales.Classes
{
    public class ServiceTiers : Service<TiersViewModel, Tiers>, IServiceTiers
    {
        private readonly IRepository<Document> _entityDocumentRepo;
        private readonly IRepository<DocumentLine> _entityDocumentLineRepo;
        private readonly IRepository<ContactTypeDocument> _entityContactTypeDocumentRepo;
        internal readonly IRepository<Contact> _entityRepoContact;
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IReducedTiersBuilder _reducedBuilder;
        private readonly IContactBuilder _contactBuilder;
        private readonly IItemBuilder _itemBuilder;
        private readonly IDocumentBuilder _documentBuilder;
        private readonly IServiceContact _serviceContact;
        private readonly IRepository<PriceRequestDetail> _entityPriceRequestDetailRepo;
        internal readonly IRepository<Currency> _entityRepoCurrency;
        internal readonly IRepository<TaxeGroupTiers> _entityRepoTaxeGroupTiers;
        internal readonly IRepository<Phone> _entityRepoPhone;
        internal readonly IServiceTiersPrices _serviceTiersPrices;
        private readonly IRepository<ZipCode> _entityRepoZipCode;
        private readonly IServiceAddress _serviceAddress;
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<FinancialCommitment> _entityFinancialCommitment;
        private readonly ITiersBuilder _tierBuilder;

        public ServiceTiers(IRepository<Tiers> entityRepo, IRepository<ContactTypeDocument> entityContactTypeDocumentRepo, IRepository<Document> entityDocumentRepo, IRepository<DocumentLine> entityDocumentLineRepo, IUnitOfWork unitOfWork,
           ITiersBuilder tiersBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification, IRepository<Contact> entityRepoContact, IReducedTiersBuilder reducedBuilder,
            IRepository<PriceRequestDetail> entityPriceRequestDetailRepo, IContactBuilder contactBuilder, IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IRepository<Currency> entityRepoCurrency,
            IRepository<TaxeGroupTiers> entityRepoTaxeGroupTiers, IServiceContact serviceContact, IServiceProvider serviceProvider,
            IRepository<Phone> entityRepoPhone, IDocumentBuilder documentBuilder, IItemBuilder itemBuilder, IServiceTiersPrices serviceTiersPrices,
            IRepository<ZipCode> entityRepoZipCode, IServiceAddress serviceAddress,
            IServiceCompany serviceCompany, IRepository<FinancialCommitment> entityFinancialCommitment, ITiersBuilder tierBuilder)
            : base(entityRepo, unitOfWork, tiersBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceProvider = serviceProvider;
            _entityContactTypeDocumentRepo = entityContactTypeDocumentRepo;
            _entityDocumentRepo = entityDocumentRepo;
            _reducedBuilder = reducedBuilder;
            _entityDocumentLineRepo = entityDocumentLineRepo;
            _entityRepoContact = entityRepoContact;
            _entityRepoUser = entityRepoUser;
            _entityPriceRequestDetailRepo = entityPriceRequestDetailRepo;
            _contactBuilder = contactBuilder;
            _entityRepoCurrency = entityRepoCurrency;
            _entityRepoTaxeGroupTiers = entityRepoTaxeGroupTiers;
            _serviceContact = serviceContact;
            _entityRepoPhone = entityRepoPhone;
            _documentBuilder = documentBuilder;
            _itemBuilder = itemBuilder;
            _serviceTiersPrices = serviceTiersPrices;
            _entityRepoZipCode = entityRepoZipCode;
            _serviceAddress = serviceAddress;
            _serviceCompany = serviceCompany;
            _entityFinancialCommitment = entityFinancialCommitment;
            _tierBuilder = tierBuilder;
        }
        public override object UpdateModel(TiersViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
        {
            try
            {

                // begin transaction
                BeginTransaction();
                Tiers tier = _entityRepo.GetSingleNotTracked(x => x.Id == model.Id);
                if (tier.IdCurrency != model.IdCurrency)
                {
                    model.IdCurrency = tier.IdCurrency;
                }
                //update with files pictures 
                if (model.PictureFileInfo != null)
                {
                    ManagePicture(model);
                }

                if (model.Contact != null)
                {
                    foreach (ContactViewModel contact in model.Contact)
                    {
                        if (!contact.IsDeleted)
                        {
                            _serviceContact.ManagePicture(contact);
                        }
                    }
                }
                if (model.Address != null && model.Address.Any(x => x.Region != null || x.CodeZip != null))
                {
                    List<AddressViewModel> adress = model.Address.Where(x => x.Region != null || x.CodeZip != null).ToList();
                    List<ZipCode> zipCodes = _entityRepoZipCode.GetAllAsNoTracking().ToList();
                    foreach (var adr in adress)
                    {
                        ZipCode zipCode = zipCodes.Where(x => (adr.CodeZip != null ? (x.Code != null ? x.Code.ToUpper() == adr.CodeZip.ToUpper() : false) : x.Code == null) &&
                        (adr.Region != null ? (x.Region != null ? x.Region.ToUpper() == adr.Region.ToUpper() : false) : x.Region == null)).FirstOrDefault();
                        if (zipCode != null)
                        {
                            adr.IdZipCode = zipCode.Id;
                        }
                        else
                        {
                            ZipCode zipC = new ZipCode
                            {
                                Code = adr.CodeZip,
                                Region = adr.Region,
                                IdCity = adr.IdCity
                            };
                            _entityRepoZipCode.Add(zipC);
                            _unitOfWork.Commit();
                            adr.IdZipCode = zipC.Id;
                        }
                    };
                }
                model.UpdatedDate = DateTime.Now;
                // save entity traceability
                Tiers entity = _builder.BuildModel(model);
                // update the relation between Tier's contact and Type Document
                UpdateContactDocumentTypeRelation(entity, userMail);
                // update collection entity                
                UpdateCollections(entity, userMail);
                // update phone related to tiers
                if (entity.IdPhoneNavigation != null)
                {
                    Phone phoneToUpdate = entity.IdPhoneNavigation;
                    phoneToUpdate.Tiers = null;
                    if (phoneToUpdate.Id == 0)
                    {
                        _entityRepoPhone.Add(phoneToUpdate);
                    }
                    else
                    {
                        _entityRepoPhone.Update(phoneToUpdate);
                    }
                }

                // update entity
                _entityRepo.Update(entity);
                //update entity axes value
                UpdateEntityAxesValues(EntityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
                _unitOfWork.Commit();
                EndTransaction();
                if (GetPropertyName(entity) != null)
                {
                    var entityName = model.IdTypeTiers == 1 ? "CUSTOMER" : model.IdTypeTiers == 2 ? "SUPPLIER" : "TIER";
                    return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entityName };
                }
                return new CreatedDataViewModel { Id = (int)entity.Id };
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }

        public override void BulkAdd(IList<TiersViewModel> models, string userMail, string property = null)
        {
            ValidateDataExcelImport(models);
            base.BulkAdd(models, userMail);
        }
        public override void BulkUpdateModel(IList<TiersViewModel> models, string userMail)
        {
            ValidateDataExcelImport(models);
            base.BulkUpdateModel(models, userMail);
        }
        private void ValidateDataExcelImport(IList<TiersViewModel> models)
        {
            List<int> currencyIds = models.Select(x => x.IdCurrency.Value).
               Except(_entityRepoCurrency.GetAllAsNoTracking().Select(x => x.Id)).ToList();
            List<int> taxeGroupTiersIds = models.Select(x => x.IdTaxeGroupTiers.Value).
               Except(_entityRepoTaxeGroupTiers.GetAllAsNoTracking().Select(x => x.Id)).ToList();
            if (currencyIds.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Tiers) , models.FirstOrDefault(x=>x.IdCurrency == currencyIds.First()).CodeTiers }
                    };
                throw new CustomException(CustomStatusCode.INVALID_IDCURRENCY_EXCEL_COLUMN, paramtrs);
            }
            if (taxeGroupTiersIds.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Tiers) , models.FirstOrDefault(x=>x.IdTaxeGroupTiers == taxeGroupTiersIds.First()).CodeTiers }
                    };
                throw new CustomException(CustomStatusCode.INVALID_IDTAXEGROUPTIERS_EXCEL_COLUMN, paramtrs);
            }
        }

        private Tiers UpdatePhone(Tiers entity)
        {
            if (entity.IdPhone == null)
            {
                Phone phone = _entityRepoPhone.FindBy(x => x.Tiers.Count() > 0 && x.Tiers.First().Id == entity.Id).FirstOrDefault();
                if (phone != null)
                {
                    _entityRepoPhone.Remove(phone);
                    entity.IdPhoneNavigation = null;

                }
            }
            else
            {
                if (entity.IdPhone == 0)
                {
                    _entityRepoPhone.Add(entity.IdPhoneNavigation);
                }
                else
                {
                    _entityRepoPhone.Update(entity.IdPhoneNavigation);
                }
            }
            return entity;
        }

        public override object AddModelWithoutTransaction(TiersViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            model.CreationDate = DateTime.Now;
            dynamic entity = _builder.BuildModel(model);

            // Generate Codification
            GenerateCodification(entity, "IdTypeTiers", false);

            // add entity
            _entityRepo.Add(entity);
            // add entityAxesValues
            //AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                var entityName = model.IdTypeTiers == 1 ? "CUSTOMER" : model.IdTypeTiers == 2 ? "SUPPLIER" : "TIER";
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entityName };
            }
            return new CreatedDataViewModel { Id = (int)entity.Id };


        }
        public override object AddModel(TiersViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            ManagePicture(model);
            if (model.Contact != null)
            {
                foreach (ContactViewModel contact in model.Contact)
                {
                    _serviceContact.ManagePicture(contact);
                }
            }
            if (model.Address != null && model.Address.Any(x => x.Region != null || x.CodeZip != null))
            {
                List<AddressViewModel> adress = model.Address.Where(x => x.Region != null || x.CodeZip != null).ToList();
                List<ZipCode> zipCodes = _entityRepoZipCode.GetAllAsNoTracking().ToList();
                foreach (var adr in adress)
                {
                    ZipCode zipCode = zipCodes.Where(x => (adr.CodeZip != null ? (x.Code != null ? x.Code.ToUpper() == adr.CodeZip.ToUpper() : false) : x.Code == null) &&
                    (adr.Region != null ? (x.Region != null ? x.Region.ToUpper() == adr.Region.ToUpper() : false) : x.Region == null)).FirstOrDefault();
                    if (zipCode != null)
                    {
                        adr.IdZipCode = zipCode.Id;
                    }
                    else
                    {
                        ZipCode zipC = new ZipCode
                        {
                            Code = adr.CodeZip,
                            Region = adr.Region,
                            IdCity = adr.IdCity
                        };
                        _entityRepoZipCode.Add(zipC);
                        _unitOfWork.Commit();
                        adr.IdZipCode = zipC.Id;
                    }
                };
            }
            return base.AddModel(model, entityAxisValuesModelList, userMail, property);
        }


        /// <summary>
        /// Manget File Delete file and copy new file 
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        public void ManagePicture(TiersViewModel tiers)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(tiers.UrlPicture))
            {
                if (tiers.PictureFileInfo?.FileData != null)
                {
                    tiers.UrlPicture = Path.Combine("Sales", "Tiers", tiers.Name, Guid.NewGuid().ToString());
                    CopyFiles(tiers.UrlPicture, tiers.PictureFileInfo);
                }
            }
            else
            {
                if (tiers.PictureFileInfo != null)
                {
                    List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                    fileInfo.Add(tiers.PictureFileInfo);
                    DeleteFiles(tiers.UrlPicture, fileInfo);
                    CopyFiles(tiers.UrlPicture, fileInfo);
                }
            }
            if (tiers.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }


        /// <summary>
        /// Gets the model with relations.
        /// The method receive a generic predicate
        /// and return the model with relations according to the predicate
        /// and the where condition included on the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>TModel.</returns>
        public override TiersViewModel GetModelWithRelations(Expression<Func<Tiers, bool>> predicate1, params Expression<Func<Tiers, object>>[] predicate2)
        {
            IQueryable<Tiers> tiers = _entityRepo.QuerableGetAll(predicate2)
                                                     .Where(predicate1)
                                                     .Include(x => x.Contact).ThenInclude(x => x.Phone)
                                                     .Include(x => x.Address).ThenInclude(x => x.IdZipCodeNavigation);
            TiersViewModel tiersViewModel = _tierBuilder.BuildEntity(tiers.FirstOrDefault());
            return tiersViewModel;
        }
        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public override DataSourceResult<TiersViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<Tiers> predicateFilterRelationModel = PreparePredicate(predicateModel);
            return GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }
        public override DataSourceResult<TiersViewModel> GetListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Tiers> predicateFilterRelationModel)
        {
            IQueryable<Tiers> entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                                     .OrderByRelation(predicateModel.OrderBy)
                                                     .Where(predicateFilterRelationModel.PredicateWhere)
                                                     .Include(x => x.Address).ThenInclude(x => x.IdCountryNavigation)
                                                     .Include(x => x.Address).ThenInclude(x => x.IdCityNavigation);
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = entities.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
            }
            IList<TiersViewModel> model = entities.ToList().Select(_builder.BuildEntity).ToList();
            foreach (var tier in model)
            {
                if (tier.UrlPicture != null)
                {
                    tier.PictureFileInfo = GetFiles(tier.UrlPicture).FirstOrDefault();
                }
            }
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<TiersViewModel> { data = model, total = total };
        }
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Tiers> predicateFilterRelationModel)
        {
            IEnumerable<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }

            IList<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }
        public void UpdateContactDocumentTypeRelation(Tiers tiers, string userMail)
        {
            foreach (Contact contact in tiers.Contact)
            {
                //update contact-TypeDocument relation
                if (contact.Id != 0)
                {
                    // line deleted
                    if (contact.IsDeleted)
                    {
                        // delete contact-TypeDocument relation of contact
                        foreach (ContactTypeDocument contactTypeDocument in contact.ContactTypeDocument)
                        {
                            contactTypeDocument.IsDeleted = true;
                            // Get price request which use current contact
                            List<PriceRequestDetail> priceRequestsDetail = _entityPriceRequestDetailRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdContact == contact.Id).ToList();
                            if (priceRequestsDetail != null && priceRequestsDetail.Any())
                            {
                                priceRequestsDetail.ForEach(y =>
                                {
                                    y.IdContact = null;
                                });
                                _entityPriceRequestDetailRepo.BulkUpdate(priceRequestsDetail);
                            }
                            _entityContactTypeDocumentRepo.Update(contactTypeDocument);
                        }
                    }
                    else // line updated
                    {
                        //recuperate collection before update
                        List<ContactTypeDocument> oldContactTypeDocument = _entityContactTypeDocumentRepo.FindByAsNoTracking(p => p.IdContact == contact.Id).ToList();

                        List<ContactTypeDocument> newContactTypeDocument = new List<ContactTypeDocument>();
                        if (contact.ContactTypeDocument.Count > 0)
                        {
                            newContactTypeDocument = contact.ContactTypeDocument.ToList();
                        }

                        foreach (ContactTypeDocument entityContactTypeDocument in newContactTypeDocument)
                        {
                            // verify ContactTypeDocument existence ==> 
                            // add element if not exist 
                            // update element if exist and isDeleted == true
                            ContactTypeDocument entityOldContactTypeDocument =
                                oldContactTypeDocument.Find(c => c.CodeTypeDocument == entityContactTypeDocument.CodeTypeDocument);
                            if (entityOldContactTypeDocument == null) //add element if not exist 
                            {
                                entityContactTypeDocument.IdContact = contact.Id;
                                _entityContactTypeDocumentRepo.Add(entityContactTypeDocument);
                            }
                            else //update element if exist and isDeleted == true
                            {
                                if (entityOldContactTypeDocument.IsDeleted)
                                {
                                    entityOldContactTypeDocument.IsDeleted = false;
                                    _entityContactTypeDocumentRepo.Update(entityOldContactTypeDocument);
                                }
                                oldContactTypeDocument.Remove(entityOldContactTypeDocument);
                            }
                        }
                        // delete old userRole
                        foreach (ContactTypeDocument entityContactTypeDocument in oldContactTypeDocument)
                        {
                            ContactTypeDocument entityNewContactTypeDocument = newContactTypeDocument.Find(c => c.CodeTypeDocument == entityContactTypeDocument.CodeTypeDocument);
                            if (entityNewContactTypeDocument == null) //add element if not exist 
                            {
                                entityContactTypeDocument.IsDeleted = true;
                                _entityContactTypeDocumentRepo.Update(entityContactTypeDocument);
                            }
                        }
                        contact.ContactTypeDocument.Clear();
                    }
                    UpdateCollections(contact, userMail);
                    _entityRepoContact.Update(contact);
                }
            }
        }
        public override IList<TiersViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IList<TiersViewModel> model = base.FindModelBy(predicateModel);
            foreach (TiersViewModel tiers in model)
            {
                var OrderEnumerator = tiers.IdTypeTiers == 1 ? SalesOrder : PurchaseOrder;
                var DeliveryEnumerator = tiers.IdTypeTiers == 1 ? SalesDelivery : PurchaseDelivery;
                var InvoiceEnumerator = tiers.IdTypeTiers == 1 ? SalesInvoice : PurchaseInvoice;
                tiers.OrderAmount = _entityDocumentLineRepo.GetAllWithConditionsRelations(c => c.IdDocumentNavigation.IdTiers == tiers.Id
                        && c.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
                        && c.IdDocumentNavigation.DocumentTypeCode == OrderEnumerator)
                        .Sum(c => c.HtTotalLine);
                tiers.DeliveryAmount = _entityDocumentLineRepo.GetAllWithConditionsRelations(c => c.IdDocumentNavigation.IdTiers == tiers.Id
                        && c.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
                        && c.IdDocumentNavigation.DocumentTypeCode == DeliveryEnumerator)
                        .Sum(c => c.HtTotalLine);
                tiers.InvoiceAmount = _entityDocumentLineRepo.GetAllWithConditionsRelations(c => c.IdDocumentNavigation.IdTiers == tiers.Id
                        && c.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
                        && c.IdDocumentNavigation.DocumentTypeCode == InvoiceEnumerator)
                        .Sum(c => c.HtTotalLine);
                // calculate total OrderAmount
                tiers.OrderAmount = CalculateCurrentTotalAmountPerType(tiers, OrderEnumerator);
                // calculate total DeliveryAmount
                tiers.DeliveryAmount = CalculateCurrentTotalAmountPerType(tiers, DeliveryEnumerator);
                // calculate total InvoiceAmount
                tiers.InvoiceAmount = CalculateCurrentTotalAmountPerType(tiers, InvoiceEnumerator);
            }
            return model;
        }

        /// <summary>
        /// calculate current total amount TTC of documents where the type is documentType for the tiers. 
        /// </summary>
        /// <param name="tiers"></param>
        /// <param name="documentType"></param>
        /// <returns></returns>
        private double CalculateCurrentTotalAmountPerType(TiersViewModel tiers, string documentType)
        {
            // calculate sum of TtcpriceWithCurrency for current documents of the tires.
            return (double)_entityDocumentRepo.GetAllWithConditionsRelations(doc => doc.IdTiers == tiers.Id
                            && doc.DocumentTypeCode == documentType
                            && doc.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                            .Sum(doc => doc.DocumentTtcpriceWithCurrency);
        }

        public double CalculateTotalAmountOfSalesDelivery(int idTiers)
        {
            int currentMonth = DateTime.Now.Month;
            // calculate sum invoice remaining amount - asset remaining amount.
            return _entityDocumentRepo.GetAllAsNoTracking().Where(doc => doc.IdTiers == idTiers && doc.DocumentDate.Month == currentMonth && doc.DocumentTypeCode == SalesDelivery && doc.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
              .Sum(x => x.DocumentTtcpriceWithCurrency ?? 0);
        }

        public void UpdateProvisoanAmountForTier(string generatedConnectionString)
        {
            BeginTransaction(generatedConnectionString);
            _entityRepo.GetAllAsNoTracking().UpdateFromQuery(x => new Tiers { ProvisionalAuthorizedAmountDelivery = 0 });
            EndTransaction();
        }

        public DocumentBriefingViewModel GetLastTierArticles(int Idtier)
        {
            DocumentBriefingViewModel document = new DocumentBriefingViewModel();
            var lastReciept = _entityDocumentRepo.QuerableGetAll().Include("DocumentLine.IdItemNavigation")
                .Where(x => x.IdTiers == Idtier &&
                (x.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery || x.DocumentTypeCode == DocumentEnumerator.SalesDelivery) &&
              (x.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid ||
              x.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced ||
              x.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied ||
              x.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)).ToList().FirstOrDefault();
            if (lastReciept != null)
            {
                var listArticles = lastReciept.DocumentLine.Select(y => _itemBuilder.BuildEntity(y.IdItemNavigation));
                document = new DocumentBriefingViewModel
                {
                    Id = lastReciept.Id,
                    DocumentDate = lastReciept.DocumentDate,
                    DocumentStatus = lastReciept.IdDocumentStatus,
                    DocumentType = lastReciept.DocumentTypeCode,
                    items = listArticles.Take(4).ToList(),
                    totalItems = listArticles.Count()
                };
            }
            return (document);
        }

        public DataSourceResult<TiersViewModel> GetSupplierDropdownList(PredicateFormatViewModel predicateModel, int? idProject)
        {
            PredicateFilterRelationViewModel<Tiers> predicateFilterRelationModel = PreparePredicate(predicateModel);
            DataSourceResult<TiersViewModel> dataSource = new DataSourceResult<TiersViewModel>();
            IEnumerable<Tiers> entities = new List<Tiers>();
            if (!idProject.HasValue || (idProject.HasValue && idProject <= NumberConstant.Zero))
            {
                if (predicateModel.page > 0 && predicateModel.pageSize > 0)
                {
                    entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                   .OrderByRelation(predicateModel.OrderBy).
                   Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                   Take(predicateModel.pageSize).OrderBy(x => x.Name).ToList();
                }
                else
                {
                    entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                  .OrderByRelation(predicateModel.OrderBy).
                  Where(predicateFilterRelationModel.PredicateWhere).OrderBy(x => x.Name).ToList();
                }
            }
            else if (idProject.HasValue && idProject > NumberConstant.Zero)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).Where(x => x.Project.Count > NumberConstant.Zero && x.Project.Any(y => y.Id == idProject)).
                    Where(predicateFilterRelationModel.PredicateWhere).OrderBy(x => x.Name).ToList();
            }
            dataSource.data = entities.Select(x => _builder.BuildEntity(x)).ToList();
            dataSource.total = entities.Count();
            return dataSource;
        }

        public IList<ContactViewModel> GetTierContact(int typeTier)
        {
            var list = _entityRepoContact.QuerableGetAll().Include(x => x.IdTiersNavigation).Where(x => x.IdTiersNavigation.IdTypeTiers == typeTier).ToList();
            return list.Select(x => _contactBuilder.BuildEntity(x)).ToList();
        }

        public IList<TiersViewModel> GetByType(int type)
        {
            return FindByAsNoTracking(p => p.IdTypeTiers == type).ToList();
        }

        public IList<TiersViewModel> GetTiersListByArray(IEnumerable<int> listTiersId)
        {
            return _entityRepo.QuerableGetAll().Where(x => listTiersId.Contains(x.Id)).Select(y => _builder.BuildEntity(y)).ToList();
        }

        public bool IsAmountGreaterThanCeiling(TiersViewModel tiers, double? amount, string documentType)
        {
            throw new NotImplementedException();
        }

        public FileInfoViewModel DownloadSupplierExcelTemplate()
        {
            return DownloadTierExcelTemplate("ImportSupplier.xlsx");
        }
        public FileInfoViewModel DownloadCustomerExcelTemplate()
        {
            return DownloadTierExcelTemplate("ImportCustomer.xlsx");
        }
        public FileInfoViewModel DownloadTierExcelTemplate(string fileName)
        {

            string excelPath = Path.Combine(".", "ExcelTemplate", fileName);
            if (!File.Exists(excelPath))
            {
                throw new CustomException(CustomStatusCode.NotFound);
            }
            return new FileInfoViewModel
            {
                Data = GenerateTierExcelModel(excelPath),
                Extension = "xlsx",
                Name = fileName
            };




        }
        private byte[] GenerateTierExcelModel(string path)
        {
            ExcelWorkbook excelWorkBook = GetExcelWorkbookByPath(path, out ExcelPackage excelPackage);
            GenerateCurrencySheet(excelWorkBook);
            GenerateTaxeGroupSheet(excelWorkBook);
            return excelPackage.GetAsByteArray();
        }



        private void GenerateCurrencySheet(ExcelWorkbook excelWorkBook)
        {
            List<dynamic> currencys = _entityRepoCurrency.GetAll().Select(x => (dynamic)x).ToList();
            if (currencys != null && currencys.Count > 0)
            {
                FillSheetUsingDataStartingFromStartRow(excelWorkBook, "Currency", currencys, new List<string> { "Id", "Code", "Symbole", "Description" });
            }

        }
        private void GenerateTaxeGroupSheet(ExcelWorkbook excelWorkBook)
        {
            List<dynamic> taxeGroups = _entityRepoTaxeGroupTiers.GetAll().Select(x => (dynamic)x).ToList();
            if (taxeGroups != null)
            {
                FillSheetUsingDataStartingFromStartRow(excelWorkBook, "TaxeGroup", taxeGroups, new List<string> { "Id", "Code", "Label" });
            }

        }

        public IList<TiersViewModel> GenerateTiersListFromExcel(FileInfoViewModel model, int tiersType)
        {
            var excelDataByteArray = Convert.FromBase64String(model.FileData);
            // When creating a stream, you need to reset the position, without it you will see that you always write files with a 0 byte length. 
            var excelDataStream = new MemoryStream(excelDataByteArray);
            IList<TiersViewModel> tiersListToReturn = GenerateListFromExcel(excelDataStream, "CodeTiers");
            foreach (TiersViewModel currentTier in tiersListToReturn)
            {
                currentTier.IdTypeTiers = tiersType;
            }
            return tiersListToReturn;
        }



        /// <summary>
        /// Get Customers Filling IsAffected ToPrices
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public DataSourceResultWithSelections<TiersViewModel> GetCustomersFillingIsAffectedToPricesWithSpecificFilter
            (List<PredicateFormatViewModel> predicateModel, int idPrice)
        {


            IQueryable<Tiers> allQueryableTiersInPredicates = GetAllModelsQueryable();

            if (predicateModel != null && predicateModel.Count > 1 && predicateModel.Skip(1).FirstOrDefault() != null)
            {
                PredicateFilterRelationViewModel<Tiers> filterPredicateFilterRelationModel = PreparePredicate(predicateModel.Skip(1).FirstOrDefault());
                allQueryableTiersInPredicates = allQueryableTiersInPredicates.Where(filterPredicateFilterRelationModel.PredicateWhere);
            }

            IList<int> allTiersIdInFilter = allQueryableTiersInPredicates.Select(x => x.Id).ToList();
            DataSourceResult<TiersViewModel> resultTiers = base.GetDataWithSpecificFilter(predicateModel);


            IList<TiersPricesViewModel> affectedTiersPrices = _serviceTiersPrices
                .FindByAsNoTracking(x => x.IdPrices == idPrice && allTiersIdInFilter.Any(y => y == x.IdTiers));
            foreach (var tier in resultTiers.data)
            {
                IList<TiersPricesViewModel> tiersPricesOfCurrentTier = affectedTiersPrices.Where(x => x.IdTiers == tier.Id).ToList();
                tier.IsAffected = tiersPricesOfCurrentTier != null && tiersPricesOfCurrentTier.Count > 0;
                if (tier.UrlPicture != null)
                {
                    tier.PictureFileInfo = GetFiles(tier.UrlPicture).FirstOrDefault();
                }
            }
            return new DataSourceResultWithSelections<TiersViewModel>
            {
                data = resultTiers.data,
                total = resultTiers.total,
                totalSelection = affectedTiersPrices.Count
            };
        }

        public TierGeneral GetGeneralTiers(TiersViewModel tier)
        {
            string invoice = "";
            var userFullName = "";
            string asset = "";
            //select document types (purchase / sales)
            if (tier.IdTypeTiers == ((int)TiersType.Supplier))
            {
                invoice = DocumentEnumerator.PurchaseInvoice;
                asset = DocumentEnumerator.PurchaseAsset;
            }
            if (tier.IdTypeTiers == ((int)TiersType.Customer))
            {
                invoice = DocumentEnumerator.SalesInvoice;
                asset = DocumentEnumerator.SalesInvoiceAsset;
            }
            //calculate Left To Pay Amount
            var Remaininginvoices = _entityDocumentRepo.FindBy(x => x.IdTiers == tier.Id
            && (x.DocumentTypeCode == invoice)
            && x.IdDocumentStatus != ((int)DocumentStatusEnumerator.Provisional)
            && x.IdDocumentStatus != ((int)DocumentStatusEnumerator.Draft)
            ).Sum(x => x.DocumentRemainingAmountWithCurrency);
            var Remainingassets = _entityDocumentRepo.FindBy(x => x.IdTiers == tier.Id
            && (x.DocumentTypeCode == asset)
            && x.IdDocumentStatus != ((int)DocumentStatusEnumerator.Provisional)
            ).Sum(x => x.DocumentRemainingAmountWithCurrency);

            var leftToPay = Remaininginvoices - Remainingassets;

            //calculate Revenue (chiffre d'affaire)

            var revenue = GetTiersRevenue(tier.Id, tier.IdTypeTiers);

            var lastAction = _entityDocumentRepo.GetAllWithConditionsRelations(x => x.IdTiers == tier.Id, x => x.IdCreatorNavigation).OrderByDescending(y => y.DocumentDate).FirstOrDefault();
            if (lastAction != null)
            {
                userFullName = lastAction.IdCreatorNavigation?.FullName;
                lastAction.IdCreatorNavigation = null;
            }
            return new TierGeneral
            {
                UserFullName = userFullName,
                LastDocumentAdded = _documentBuilder.BuildEntity(lastAction),
                Revenue = revenue,
                LeftToPay = leftToPay,
                score = 00
            };
        }
        double GetTiersRevenue(int idTiers, int tiersType)
        {
            // Build the predicate for documentLine which come from deliveryForm and which are not billed
            Expression<Func<DocumentLine, bool>> predicateForBL = (p) => p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentEnumerator.SalesDelivery.ToLower()
                                                                         && p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid &&
                                                                         p.IdDocumentNavigation.IdTiers.HasValue && p.IdDocumentNavigation.IdTiers.Value == idTiers;

            // Build the predicate for financial commitment which provides from invoices that meet the following requirements:
            // - the invoices must be: purchase or sales or asset
            // - the invoice status must be: valid or partiaalySatisfied or totallySatisfied 
            var DocumentTypeInvoice = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoice : DocumentEnumerator.PurchaseInvoice;
            string DocumentTypeAsset = tiersType == (int)TiersType.Customer ? DocumentEnumerator.SalesInvoiceAsset : DocumentEnumerator.PurchaseAsset;
            Expression<Func<FinancialCommitment, bool>> predicateFinancialCommitmentWhere =
                                                  (p) => (p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentTypeInvoice.ToLower()
                                                           || p.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentTypeAsset.ToLower()
                                                         )
                                                         && (p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid
                                                             || p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied
                                                             || p.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.TotallySatisfied
                                                         ) && p.IdTiers.HasValue && p.IdTiers.Value == idTiers;



            IQueryable<DocumentLine> queryDocumentLineNotBilled = _entityDocumentLineRepo.GetAllAsNoTracking().AsQueryable().Where(predicateForBL);
            double documentLineNotBilledRevenue = queryDocumentLineNotBilled.Sum(s => s.TtcTotalLineWithCurrency.Value);


            IQueryable<FinancialCommitment> queryFinancialCommitment = _entityFinancialCommitment.GetAllAsNoTracking()
                                                                           .Where(predicateFinancialCommitmentWhere)
                                                                           .Include(r => r.IdTiersNavigation).AsQueryable();
            double financialCommitmentRevenu = queryFinancialCommitment.Sum(s => !(s.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentEnumerator.SalesInvoiceAsset.ToLower())
                                                        && !(s.IdDocumentNavigation.DocumentTypeCode.ToLower() == DocumentEnumerator.PurchaseAsset.ToLower())
                                                     ? s.AmountWithCurrency.Value : -s.AmountWithCurrency.Value);

            // GetPrecision from company
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            int companyPrecision = companyCurrency.Precision;

            return Math.Round((documentLineNotBilledRevenue + financialCommitmentRevenu), companyPrecision);
        }
        public bool CheckTaxRegistration(CheckTaxRegistrationViewModel model)
        {
            List<Tiers> tier;
            if (model.Code != null)
            {
                tier = _entityRepo.GetAllAsNoTracking().Where(x => x.IdTypeTiers == model.Type && x.MatriculeFiscale == model.Value && x.CodeTiers != model.Code).ToList();
            }
            else
            {
                tier = _entityRepo.GetAllAsNoTracking().Where(x => x.IdTypeTiers == model.Type && x.MatriculeFiscale == model.Value).ToList();
            }
            return tier.Count() != 0;
        }

        public List<TierActivityViewModel> GetActivitiesTiers(TiersViewModel tier)
        {
            var result = _entityDocumentRepo.GetAllWithConditionsRelations(x => x.IdTiers == tier.Id && x.ValidationDate != null && x.IdValidator != null && x.IdDocumentStatus != ((int)DocumentStatusEnumerator.Draft), x => x.IdValidatorNavigation).OrderByDescending(x => x.ValidationDate).Take(20).Select(y =>
                       new TierActivityViewModel
                       {
                           DocumentCode = y.Code,
                           DocumentId = y.Id,
                           DocumentType = y.DocumentTypeCode,
                           ValidationDate = y.ValidationDate,
                           ValidatorName = y.IdValidatorNavigation != null ? y.IdValidatorNavigation.FullName : ""
                       }
              ).ToList();
            return result;
        }

        public override DataSourceResult<TiersViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Tiers> entities = null;
            PredicateFilterRelationViewModel<Tiers> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "Country")
                {
                    if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                    {
                        entities = entities.OrderBy(x => x.Address.FirstOrDefault().IdCountryNavigation.NameFr);
                    }
                    else
                    {
                        entities = entities.OrderByDescending(x => x.Address.FirstOrDefault().IdCountryNavigation.NameFr);
                    }
                }
                if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Prop == "City")
                {
                    if (predicateModel.FirstOrDefault().OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                    {
                        entities = entities.OrderBy(x => x.Address.FirstOrDefault().IdCityNavigation.Label);
                    }
                    else
                    {
                        entities = entities.OrderByDescending(x => x.Address.FirstOrDefault().IdCityNavigation.Label);
                    }
                }
            }

            return GetDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
        }
        public NumberFormatOptionsViewModel getFormatOptionsForPurchase(int idTier)
        {
            TiersViewModel tier = GetModelsWithConditionsRelations(y=> y.Id == idTier ,x => x.IdCurrencyNavigation).FirstOrDefault();
            return tier.FormatOption;
        }
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            // test if tiers has dependencies
            if(_entityRepo.GetAllWithConditionsQueryable(x => x.Id == id && (x.Document.Any() || x.ClaimIdClientNavigation.Any() || x.DocumentExpenseLine.Any() || x.FinancialCommitment.Any()||
            x.StockDocument.Any() || x.ItemTiers.Any() || x.PriceRequestDetail.Any() || x.Project.Any() || x.TiersProvisioning.Any() || x.ProvisioningDetails.Any() || x.ReceiptSpent.Any() || 
            x.Settlement.Any())).Count() > 0)
            {
                throw new CustomException(CustomStatusCode.DeleteTiersError);
            }

            Tiers tiersToDelete = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == id, r => r.Vehicle,r => r.Address, r => r.Contact, r => r.TiersPrices).FirstOrDefault();

            tiersToDelete.Vehicle.ToList().ForEach(vehicle =>
           {
               vehicle.IsDeleted = true;
               vehicle.DeletedToken = Guid.NewGuid().ToString();
           });
            tiersToDelete.Address.ToList().ForEach(address =>
            {
                address.IsDeleted = true;
                address.DeletedToken = Guid.NewGuid().ToString();
            });
            tiersToDelete.Contact.ToList().ForEach(contact =>
            {
                contact.IsDeleted = true;
                contact.DeletedToken = Guid.NewGuid().ToString();
            });
            tiersToDelete.TiersPrices.ToList().ForEach(tiersPrices =>
            {
                tiersPrices.IsDeleted = true;
                tiersPrices.DeletedToken = Guid.NewGuid().ToString();
            });
            tiersToDelete.SearchItem.ToList().ForEach(searchItem =>
            {
                searchItem.IsDeleted = true;
                searchItem.DeletedToken = Guid.NewGuid().ToString();
            });

            tiersToDelete.IsDeleted = true;
            tiersToDelete.DeletedToken = Guid.NewGuid().ToString();

            var ctx = _unitOfWork.GetContext();
            var attachedEntity = ctx.ChangeTracker.Entries<Tiers>().FirstOrDefault(e => e.Entity.Id == id);
            if (attachedEntity != null)
            {
                ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
            }
            _entityRepo.Update(tiersToDelete);
            // commit transaction
            _unitOfWork.Commit();
             if (GetPropertyName(tiersToDelete) != null)
            {
                return new CreatedDataViewModel { Id = (int)tiersToDelete.Id, Code = getModelCode(tiersToDelete, GetPropertyName(tiersToDelete)), EntityName = tiersToDelete.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)tiersToDelete.Id, EntityName = tiersToDelete.GetType().Name.ToUpper() };
        }
            #region  Garage
            /// <summary>
            /// Get ties and invoice for garage intevention list
            /// </summary>
            /// <param name="predicateModel"></param>
            /// <param name="idDocument"></param>
            /// <returns></returns>
            public dynamic GetTiersAndInvoiceForGarageInterventionList(IList<int> idTiersList, IList<int?> idDocumentList)
        {
            IList<TiersViewModel> tiersList = new List<TiersViewModel>();
            if (idTiersList != null && idTiersList.Count > 0)
            {
                IList<Tiers> tiersEntities = _entityRepo.FindByAsNoTracking(x => idTiersList.Contains(x.Id)).ToList();

                tiersList = tiersEntities.Select(_builder.BuildEntity).ToList();
            }
            foreach (var tier in tiersList)
            {
                if (tier.UrlPicture != null)
                {
                    tier.PictureFileInfo = GetFiles(tier.UrlPicture).FirstOrDefault();
                }
            }
            IList<DocumentViewModel> documentList = new List<DocumentViewModel>();
            if (idDocumentList != null && idDocumentList.Count > 0)
            {
                IList<Document> documentEntities = _entityDocumentRepo
                                        .FindByAsNoTracking(x => idDocumentList.Contains(x.Id)).ToList();
                documentList = documentEntities.Select(_documentBuilder.BuildEntity).ToList();
            }

            dynamic result = new ExpandoObject();
            result.TiersList = tiersList;
            result.DocumentList = documentList;

            return result;
        }

        #endregion
        #region Synchronize client-users BtoB
        public List<SynchronizeBToBTierViewModel>  SynchronizeClientBtoB( SynchronizeClientUserBToBViewModel listClientToSynchronize)
        {
            List<Tiers> ListOfClients = new List<Tiers>();
            List<string> currencyList = listClientToSynchronize.Clients.Select(x => x.currency_code).ToList();
            List<Currency> listOfCurrency = _entityRepoCurrency.FindByAsNoTracking(x => currencyList.Contains(x.Code)).ToList();
            List<string> taxeList = listClientToSynchronize.Clients.Select(x => x.tax_group).ToList();
            List<TaxeGroupTiers> listOfTaxes = _entityRepoTaxeGroupTiers.FindByAsNoTracking(x => taxeList.Contains(x.Label)).ToList();
            foreach (ClientBToBViewModel tier in listClientToSynchronize.Clients)
            {
                var currency = listOfCurrency.Where(x => x.Code == tier.currency_code).Select(x => x.Id).FirstOrDefault();
                var taxeGroup = listOfTaxes.Where(x => x.Label == tier.tax_group).Select(x => x.Id).FirstOrDefault();
                List<Address> address = new List<Address>();
                Address firstAddress = new Address();
                firstAddress.PrincipalAddress = tier.Address;
                address.Add(firstAddress);
                Tiers newTier = new Tiers
                {
                    Name = tier.Name,
                    Email = tier.Email,
                    Address = address,
                    IdTypeTiers = 1,
                    CreationDate = DateTime.Now,
                    Adress = tier.Address,
                    IdTaxeGroupTiers = taxeGroup,
                    IdCurrency = currency,
                    ActivitySector = tier.sector,
                    IsSynchronizedBtoB = true
                };
                newTier.IdPhoneNavigation = new Phone();
                newTier.IdPhoneNavigation.DialCode = tier.DialCode;
                newTier.IdPhoneNavigation.Number = tier.Phone;
                newTier.IdPhoneNavigation.CountryCode = tier.CountryCode;
                VerifyUnicityOfEmailForBtoB(newTier);
                // Generate Codification
                GenerateCodification(newTier, "IdTypeTiers", false);
                ListOfClients.Add(newTier);
            }
            _entityRepo.BulkAdd(ListOfClients);
            _unitOfWork.Commit();
            List<string> emailsClients = ListOfClients.Select(x => x.Email).ToList();
            IQueryable<Tiers> entities = _entityRepo.GetAllWithConditionsRelationsQueryable(x =>emailsClients.Contains(x.Email));
            List<SynchronizeBToBTierViewModel> clients = entities.Select(x => _tierBuilder.BuildResponseTiersForBToB(x)).ToList();
            return clients;
        }
        /// <summary>
        /// Check the user's mail unicity
        /// </summary>
        /// <param name="model"></param>
        private void VerifyUnicityOfEmailForBtoB(Tiers model)
        {
            Tiers tier = _entityRepo.FindSingleBy(x => x.Id != model.Id && x.Email == model.Email);
            if (tier != null)
                throw new CustomException(CustomStatusCode.UserEmailUnicity, new Dictionary<string, dynamic>
                        {
                            { nameof(Tiers), model.Email },
                            { Constants.ID, tier.Id}
                        });
        }

        public void UpdateClientBtoB( SynchronizeClientUserBToBViewModel listClientToSynchronize)
        {
            List<int> idTiers = listClientToSynchronize.Clients.Select(x => x.IdTierStark).ToList();
            List<Tiers> listOfTier = _entityRepo.GetAllWithConditionsRelations(x => idTiers.Contains(x.Id), x => x.Address, x => x.IdPhoneNavigation).ToList();
            List<Tiers> ListOfUpdatedTier = new List<Tiers>();
            List<string> currencyList = listClientToSynchronize.Clients.Select(x => x.currency_code).ToList();
            List<Currency> listOfCurrency = _entityRepoCurrency.FindByAsNoTracking(x => currencyList.Contains(x.Code)).ToList();
            List<string> taxeList = listClientToSynchronize.Clients.Select(x => x.tax_group).ToList();
            List<TaxeGroupTiers> listOfTaxes = _entityRepoTaxeGroupTiers.FindByAsNoTracking(x => taxeList.Contains(x.Label)).ToList();
            foreach (ClientBToBViewModel tier in listClientToSynchronize.Clients)
            {
                Tiers updatedTier = listOfTier.Where(x => x.Id == tier.IdTierStark).FirstOrDefault();
                int currency = listOfCurrency.Where(x => x.Code == tier.currency_code).Select(x => x.Id).FirstOrDefault();
                int taxeGroup = listOfTaxes.Where(x => x.Label == tier.tax_group).Select(x => x.Id).FirstOrDefault();
                updatedTier.IdCurrency = currency;
                updatedTier.IdTaxeGroupTiers = taxeGroup;
                updatedTier.Name = tier.Name;
                updatedTier.Address.FirstOrDefault().PrincipalAddress = tier.Address;
                updatedTier.IdPhoneNavigation.CountryCode = tier.CountryCode;
                updatedTier.IdPhoneNavigation.Number = tier.Phone;
                updatedTier.IdPhoneNavigation.DialCode = tier.DialCode;
                updatedTier.ActivitySector = tier.sector;
                ListOfUpdatedTier.Add(updatedTier);
            }
            base.BulkUpdateWithoutTransaction(ListOfUpdatedTier);
        }
        public List<ClientBToBViewModel> SearchTiersBtob ( DateTime searchDate)
        {
            IQueryable <Tiers> entities  = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.IdTypeTiers == 1 && x.IsSynchronizedBtoB == false &&((x.CreationDate.HasValue && x.CreationDate>= searchDate.Date) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero)))),x=> x.IdPhoneNavigation, x => x.IdTaxeGroupTiersNavigation, x => x.IdCurrencyNavigation, x => x.Address).AsQueryable();
            List<ClientBToBViewModel> clients = entities.Select(x => _tierBuilder.BuildListClientBtoB(x)).ToList();
            return clients; 
        }
        #endregion
    }
}
