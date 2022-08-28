using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServicePriceRequest : Service<PriceRequestViewModel, PriceRequest>, IServicePriceRequest
    {


        internal readonly IServiceItem _serviceItem;
        internal readonly IServiceTiers _serviceTiers;
        internal readonly IServiceContact _serviceContact;
        internal readonly IServiceInformation _serviceInformation;
        internal readonly IServiceMessagePriceRequest _serviceMessagePriceRequest;
        private readonly IItemBuilder _itemBuilder;
        public ServicePriceRequest(IRepository<PriceRequest> entityRepo, IUnitOfWork unitOfWork,

          IServiceItem serviceItem,
          IPriceRequestBuilder priceRequestBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
            IServiceTiers serviceTiers, IServiceInformation serviceInformation, IServiceContact serviceContact, IServiceMessagePriceRequest serviceMessagePriceRequest,
             IItemBuilder itemBuilder
            )
            : base(entityRepo, unitOfWork, priceRequestBuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceItem = serviceItem;
            _serviceTiers = serviceTiers;
            _serviceInformation = serviceInformation;
            _serviceContact = serviceContact;
            _serviceMessagePriceRequest = serviceMessagePriceRequest;
            _itemBuilder = itemBuilder;

        }



        /// <summary>
        /// Get PriceRequest with Item navigation 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override PriceRequestViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            PriceRequestViewModel priceRequestViewModel = base.GetModelWithRelations(predicateModel);

            if (priceRequestViewModel.PriceRequestDetail != null)
            {
                var itemsList = priceRequestViewModel.PriceRequestDetail.Select(y => y.IdItem);
                var itemObject = _serviceItem.GetModelsWithConditionsRelations(x => itemsList.Contains(x.Id));

                var tiersList = priceRequestViewModel.PriceRequestDetail.Select(y => y.IdTiers);
                var tiersListobject = _serviceTiers.GetModelsWithConditionsRelations(x => tiersList.Contains(x.Id));
                var contactList = priceRequestViewModel.PriceRequestDetail.Select(y => y.IdContact);
                var contactListobject = _serviceContact.GetModelsWithConditionsRelations(x => contactList.Contains(x.Id));
                // Get PriceRequest with Item Navigation 
                foreach (PriceRequestDetailViewModel priceRequestDetail in priceRequestViewModel.PriceRequestDetail)
                {
                    priceRequestDetail.IdItemNavigation = itemObject.First(x => x.Id == priceRequestDetail.IdItem);
                    priceRequestDetail.IdTiersNavigation = tiersListobject.First(x => x.Id == priceRequestDetail.IdTiers);
                    if (priceRequestDetail.IdContact != null)
                    {
                        priceRequestDetail.IdContactNavigation = contactListobject.Where(z => z.Id == priceRequestDetail.IdContact).FirstOrDefault();
                        if (priceRequestDetail.IdContactNavigation == null)
                        {
                            priceRequestDetail.IdContact = null;
                        }
                    }
                }
            }

            return priceRequestViewModel;
        }

        /// <summary>
        /// Find PriceRequest with Suppliers navigation  
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override DataSourceResult<PriceRequestViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<PriceRequestViewModel> dataSourceResultPriceReq = base.FindDataSourceModelBy(predicateModel);
            List<int> tiersList = new List<int>();
            foreach (var priceRequest in dataSourceResultPriceReq.data)
            {
                tiersList.AddRange(priceRequest.PriceRequestDetail.Select(y => y.IdTiers));
            }
            var tiersViewModelList = _serviceTiers.GetAllModelsQueryable().Where(x => tiersList.Contains(x.Id)).ToList();

            foreach (var priceRequest in dataSourceResultPriceReq.data)
            {
                priceRequest.SupplierName = tiersViewModelList
                    .Where(x => priceRequest.PriceRequestDetail.Select(y => y.IdTiers).Contains(x.Id)).Select(x => x.Name).ToList();
                foreach (var names in priceRequest.SupplierName)
                {
                    if (priceRequest.Suppliers == null)
                    {
                        priceRequest.Suppliers = names;
                    }
                    else
                    { 
                        priceRequest.Suppliers = new StringBuilder().Append(priceRequest.Suppliers).Append(",").Append(names).ToString();
                    }
                }
            }
            if(predicateModel.OrderBy.FirstOrDefault().Prop == "Suppliers")
            {
                if (predicateModel.OrderBy.FirstOrDefault().Direction == OrderByDirection.ASC)
                {
                    dataSourceResultPriceReq.data = dataSourceResultPriceReq.data.OrderBy(x => x.SupplierName.FirstOrDefault()).ToList();
                }
                else
                {
                    dataSourceResultPriceReq.data = dataSourceResultPriceReq.data.OrderByDescending(x => x.SupplierName.FirstOrDefault()).ToList();
                }
            }
            return dataSourceResultPriceReq;
        }

        /*generate price request from provsionning item*/
        public IList<CreatedDataViewModel> CreatePriceRquestFromProvisionning(IList<ObjectToOrder> Lines)
        {
            IList<CreatedDataViewModel> listOfCreatedDocument = new List<CreatedDataViewModel>();

            var results = Lines.GroupBy(p => p.IdTiers, (key, g) => new { IdTiers = key, ObjectToOrder = g.ToList() });
            PriceRequestViewModel PriceRequest = new PriceRequestViewModel();
            foreach (var item in results)
            {
                TiersViewModel tiers = _serviceTiers.GetModelWithRelations(x => x.Id == item.IdTiers, x => x.Contact);
                ContactViewModel contact = tiers.Contact.FirstOrDefault();

                PriceRequest.DocumentDate = DateTime.Now;
                PriceRequest.CreationDate = DateTime.Now;
                PriceRequest.PriceRequestDetail = new List<PriceRequestDetailViewModel>();
                foreach (var itemList in item.ObjectToOrder)
                {
                    PriceRequestDetailViewModel priceRequestDetails = new PriceRequestDetailViewModel
                    {
                        IdItem = itemList.IdItem,
                        IdTiers = item.IdTiers,
                        MovementQty = itemList.MouvementQuantity,
                        Id = 0,
                        Designation = _serviceItem.GetModelById(itemList.IdItem).Description
                    };
                    PriceRequest.PriceRequestDetail.Add(priceRequestDetails);
                }

                CreatedDataViewModel createdDocument = (CreatedDataViewModel)AddModel(PriceRequest, new List<EntityAxisValuesViewModel>(), null);
                listOfCreatedDocument.Add(createdDocument);
            }
            return listOfCreatedDocument;
        }

        /// <summary>
        /// Send mail of price request to suppliers
        /// </summary>
        /// <param name="idPriceRequest"></param>
        /// <param name="informationType"></param>
        /// <param name="user"></param>
        /// <param name="smtpSettings"></param>
        /// <param name="url"></param>
        public object SendPriceRequestMail(int idPriceRequest, string informationType, UserViewModel user, SmtpSettings smtpSettings, string url)
        {
            IList<TiersViewModel> listOfTiersWithContact = new List<TiersViewModel>();
            IList<TiersViewModel> listOfTiersWithoutContact = new List<TiersViewModel>();
            IList<string> listOfMail = new List<string>();
            // Get information
            InformationViewModel information = _serviceInformation.GetModelWithRelations(x => x.Type == informationType);
            // Get price request
            PriceRequestViewModel priceRequest = GetModelWithRelations(p => p.Id == idPriceRequest, p => p.PriceRequestDetail);
            // If list of tiers of current price request not null ==> recuperate list of mail
            if (priceRequest != null && priceRequest.PriceRequestDetail != null && priceRequest.PriceRequestDetail.Any())
            {
                List<string> listOfTiersWithoutContactEmail = new List<string>();
                // Fetch list of tiers
                foreach (var tiersPriceRequest in priceRequest.PriceRequestDetail)
                {
                    TiersViewModel tiers = _serviceTiers.GetModel(t => t.Id == tiersPriceRequest.IdTiers);
                    // if contact of tiers not null ==> add mail to listOfMail and add tiers to listOfTiers
                    if (tiersPriceRequest.IdContact > 0)
                    {
                        listOfTiersWithContact.Add(tiers);
                        string emailTiers = _serviceContact.GetModel(c => c.Id == tiersPriceRequest.IdContact).Email;
                        if (emailTiers == null)
                        {
                            listOfTiersWithoutContactEmail.Add(tiers.Name);
                        }
                        else
                        {
                            listOfMail.Add(emailTiers);
                        }
                    }
                    else
                    {
                        listOfTiersWithoutContact.Add(tiers);
                    }
                }
                // If listOfTiersWithoutContact contains elements ==> throw exception can not send mail
                if (listOfTiersWithoutContact.Any())
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "listOfTiersWithoutContact", listOfTiersWithoutContact }
                    };
                    // Error of send Mail
                    throw new CustomException(CustomStatusCode.SendMailError, paramtrs);
                }
                if (listOfTiersWithoutContactEmail.Any())
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "listOfTiersWithoutContactEmail", listOfTiersWithoutContactEmail }
                    };
                    // Error of send Mail
                    throw new CustomException(CustomStatusCode.SendMailErrorTiersWithoutContactEmail, paramtrs);
                }

                // Prepare message 
                MessageViewModel message = new MessageViewModel
                {
                    IdCreator = user.Id,
                    IdInformation = information.IdInfo,
                    EntityReference = priceRequest.Id,
                    CodeEntity = priceRequest.Code,
                    tiers = listOfTiersWithContact
                };

                // Save message in dataBase
                int idMsg = _serviceMessagePriceRequest.AddMessage(message, null, user.Email);

                // Prepare mail to send
                MailBrodcastConfigurationViewModel mailBrodcastConfiguration = new MailBrodcastConfigurationViewModel
                {
                    IdMsg = idMsg,
                    URL = url,
                    Model = new CreatedDataViewModel
                    {
                        Id = priceRequest.Id,
                        Code = priceRequest.Code
                    },
                    users = listOfMail
                };
                // Config and send mail
                _serviceMessagePriceRequest.ConfigureMail(mailBrodcastConfiguration, smtpSettings);
            }
            var entity = _builder.BuildModel(priceRequest);
            return new CreatedDataViewModel { Id = 0, EntityName = entity.GetType().Name.ToUpper() };
        }
        // generate purchase order and Purchase budget(devis) from price request
        public DocumentViewModel GeneratePurchaseOrder(DocumentLineWithPriceRequestViewModel priceRequest)
        {
            TiersViewModel tiers = _serviceTiers.GetModel(x => x.Id == priceRequest.IdTier);
            DocumentViewModel document = new DocumentViewModel
            {
                CreationDate = DateTime.Now,
                DocumentDate = DateTime.Now,
                DocumentTypeCode = priceRequest.DocumnetType,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                IdUsedCurrency = tiers.IdCurrency,
                DocumentLine = priceRequest.documentLines,
                IdTiers = tiers.Id
            };
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseBudget)
            {
                document.IdPriceRequest = priceRequest.IdDocumentAssociated;
            }
            else
            {
                document.IdDocumentAssociated = priceRequest.IdDocumentAssociated;
            }
            document.DocumentLine.ToList().ForEach(x =>
            {
                x.Id = 0;
                x.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                x.DocumentLineTaxe = null;
                x.IdDocumentLineAssociated = null;
                if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
                {
                    x.HtUnitAmountWithCurrency = _serviceItem.GetModel(item => item.Id == x.IdItem).UnitHtpurchasePrice ?? 0;
                }
            });
            return document;
        }
      public override object UpdateModelWithoutTransaction(PriceRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            foreach (var taxe in from doc in model.Document
                                 from line in doc.DocumentLine
                                 from taxe in line.DocumentLineTaxe
                                 select taxe)
            {
                taxe.IdDocumentLineNavigation = null;
                taxe.IdTaxeNavigation = null; 
            };
             model.Document.SelectMany(x => x.DocumentLine).ToList().ForEach(y=> {
                y.IdItemNavigation = null;
                 y.IdDocumentNavigation = null;
                 y.IdMeasureUnitNavigation = null;
                 y.IdWarehouseNavigation = null;
            });
            model.Document.ToList().ForEach(z =>
            {
                z.IdTiersNavigation = null;

            });
            model.PriceRequestDetail.ToList().ForEach(y => {
                y.IdTiersNavigation = null;
                y.IdItemNavigation = null;
                y.IdContactNavigation = null;
                y.IdPriceRequestNavigation = null;
                
            });
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        public override object AddModelWithoutTransaction(PriceRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            List<TiersViewModel> tiers = new List<TiersViewModel>();
            if (model.PriceRequestDetail.Any(x=> x.IdTiersNavigation == null))
            {
                List<int> idTiers = model.PriceRequestDetail.Select(x => x.IdTiers).Distinct().ToList();
                tiers = _serviceTiers.GetAllModelsQueryableWithRelation(x => idTiers.Contains(x.Id)).ToList();
            }
            else
            {
                tiers = model.PriceRequestDetail.Select(x => x.IdTiersNavigation).ToList();
            }
            List<int> idItems = model.PriceRequestDetail.Select(x => x.IdItem).Distinct().ToList();
            List<ItemViewModel> items = _serviceItem.GetAllModelsQueryableWithRelation(x => idItems.Contains(x.Id), y => y.ItemTiers).ToList();
            List<ItemViewModel> itemsToUpdate = new List<ItemViewModel>();
            model.PriceRequestDetail.ToList().ForEach(priceRequest => {
                ItemViewModel item = items.Where(x => x.Id == priceRequest.IdItem).FirstOrDefault();
                if(items.Where(x=> x.Id == priceRequest.IdItem).FirstOrDefault().ItemTiers.Select(x=> x.IdTiers).Contains(priceRequest.IdTiers) == false)
                {
                    ItemTiersViewModel itemTiersView = new ItemTiersViewModel
                    {
                        IdItem = priceRequest.IdItem,
                        IdTiers = priceRequest.IdTiers
                    };
                    item.ListTiers.Add(tiers.Where(x=> x.Id == priceRequest.IdTiers).FirstOrDefault());
                    item.ItemTiers.Add(itemTiersView);
                    itemsToUpdate.Add(item);
                }
                priceRequest.IdTiersNavigation = null;
            });
            if (itemsToUpdate.Any())
            {
                List<ItemTiersViewModel> itemtier = itemsToUpdate.SelectMany(x => x.ItemTiers).ToList();
                foreach (var itemT in itemtier)
                {
                    itemT.IdItemNavigation = null;
                }
                List<Item> itemsEntitys = itemsToUpdate.Select(x => _itemBuilder.BuildModel(x)).ToList();
                var ctx = _unitOfWork.GetContext();
                itemsEntitys.ForEach(x =>
                {
                    var attachedDL = ctx.ChangeTracker.Entries<Item>().FirstOrDefault(e => e.Entity.Id == x.Id);
                    if (attachedDL != null)
                    {
                        ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                    }
                });
                _serviceItem.BulkUpdateModelWithoutTransaction(itemsEntitys);
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
