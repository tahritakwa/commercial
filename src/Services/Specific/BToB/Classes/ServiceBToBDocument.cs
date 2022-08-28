using Microsoft.EntityFrameworkCore;
using ModelView.B2B;
using Newtonsoft.Json;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Administration;
using ViewModels.DTO.B2B;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{

    public partial class ServiceDocument
    {
        //get items list after filter
        public DataSourceResult<ItemViewModel> GetsItemsAfterFilter(PredicateFormatViewModel predicateModel)
        {
            int total;
            List<ItemViewModel> dataToSend = new List<ItemViewModel>();
            var bToBItems = GetItemsDataSourceModel(predicateModel, out total);
            var availableQty = _serviceItem.GetAvailbleQuantity(bToBItems.Select(x => x.Id).ToList());
            foreach (var itemAvalable in availableQty)
            {
                var item = bToBItems.FirstOrDefault(x => x.Id == itemAvalable.IdItem);
                if (itemAvalable.AvailableQuantityValue > 0)
                {
                    item.IsAvailable = true;
                }
                dataToSend.Add(item);
            }
            DataSourceResult<ItemViewModel> dataSourceResult = new DataSourceResult<ItemViewModel>
            {
                data = dataToSend,
                total = total
            };
            return dataSourceResult;
        }

        public IEnumerable<ItemViewModel> GetItemsDataSourceModel(PredicateFormatViewModel predicateModel, out int total)
        {

            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<Item, bool>> predicateWhere = PredicateUtility<Item>.PredicateFilter(predicateModel, key);
            IEnumerable<Item> entities = _itemEntityRepo.QuerableGetAll().Include(x => x.TaxeItem).ThenInclude(x => x.IdTaxeNavigation)
                   .Where(predicateWhere);
            var items = entities.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();
            total = entities.Count();
            return items.Select(c => _itemBuilder.BuildEntity(c));
        }

        public DocumentLineViewModel GetItemPriceForB2BDocument(BtoBDocumentLineViewModel btoBDocumentLineViewModel)
        {
            try
            {
                BeginTransaction();
                DocumentLineViewModel doc;
                var document = _entityRepo.GetSingle(x => x.Id == btoBDocumentLineViewModel.IdDocument);
                if (document == null || document.IsDeleted)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                var tiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == btoBDocumentLineViewModel.idUser);
                DocumentLineViewModel documentLine;
                if (btoBDocumentLineViewModel.idLine > 0)
                {
                    documentLine = _serviceDocumentLine.GetModelAsNoTracked(x => x.Id == btoBDocumentLineViewModel.idLine);

                    if (documentLine == null)
                    {
                        throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                    }

                    documentLine.MovementQty = btoBDocumentLineViewModel.MovementQty > 0 ? btoBDocumentLineViewModel.MovementQty : documentLine.MovementQty;
                    documentLine.IsDeleted = btoBDocumentLineViewModel.IsDeleted;

                }
                else
                {
                    var item = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == btoBDocumentLineViewModel.IdItem, x => x.TaxeItem);
                    documentLine = new DocumentLineViewModel
                    {
                        IdDocument = btoBDocumentLineViewModel.IdDocument,
                        Designation = item.Description,
                        IdItem = btoBDocumentLineViewModel.IdItem,
                        HtUnitAmountWithCurrency = item.UnitHtsalePrice,
                        HtAmountWithCurrency = item.UnitHtsalePrice,
                        MovementQty = btoBDocumentLineViewModel.MovementQty > 0 ? btoBDocumentLineViewModel.MovementQty : 1,
                        CodeDocumentLine=""
                    };
                }

                var itemPrice = new ItemPriceViewModel
                {
                    IsBToB = true,
                    DocumentDate = DateTime.Now,
                    DocumentType = DocumentEnumerator.SalesOrder,
                    IdCurrency = tiers.IdCurrency ?? 0,
                    IdTiers = tiers.Id,
                    DocumentLineViewModel = documentLine
                };

                if (!btoBDocumentLineViewModel.IsDeleted)
                {
                    itemPrice.DocumentLineViewModel = GetItemPrice(itemPrice, true);
                    itemPrice.DocumentLineViewModel.DocumentLineTaxe = null;
                }

                doc = InsertUpdateDocumentLineWithoutTransaction(itemPrice, null);
                UpdateDocumentAmountsWithoutTransaction(itemPrice.DocumentLineViewModel.IdDocument, null);
                _unitOfWork.Commit();
                EndTransaction();
                return doc;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception ex)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(ex);
                throw;
            }

        }

        public DocumentLineViewModel GetDocumentLineValuesForB2B(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleWithRelationsNotTracked(c => c.CodeType == itemPriceViewModel.DocumentType,
                p => p.DefaultCodeDocumentTypeAssociatedNavigation);
            if (documentType.IsStockAffected ||
                (documentType.DefaultCodeDocumentTypeAssociatedNavigation != null && documentType.DefaultCodeDocumentTypeAssociatedNavigation.IsStockAffected))
            {
                ItemViewModel item = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, x => x.IdNatureNavigation, x => x.TaxeItem);
                // if item is stock managed
                if (item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    if (documentType.IsSaleDocumentType && itemPriceViewModel.DocumentLineViewModel.IdWarehouse == null)
                    {
                        // Depot Required error
                        throw new CustomException(CustomStatusCode.DepotObligatoire);
                    }


                }
            }

            int precision = GetPrecissionValue(itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentType);
            return CalculeDocumentLine(itemPriceViewModel, precision);

        }

        public DocumentTotalPricesViewModel GetDocumentTotalPriceForB2BDocument(ReduisDocumentViewModel reduisDocumentViewModel)
        {
            reduisDocumentViewModel.DocumentType = DocumentEnumerator.SalesOrder;
            reduisDocumentViewModel.DocumentTotalPrices = new DocumentTotalPricesViewModel();
            reduisDocumentViewModel.DocumentOtherTaxe = 0;
            return GetDocumentTotalPrice(reduisDocumentViewModel);
        }

        public DocumentViewModel SaveOrder(DocumentViewModel document)
        {
            TiersViewModel tiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == document.IdTiers.Value);
            document.IdUsedCurrency = tiers.IdCurrency;
            document.DocumentTypeCode = DocumentEnumerator.SalesOrder;
            document.DocumentOtherTaxesWithCurrency = 0;
            document.DocumentOtherTaxes = 0;
            document.IsBToB = true;
            document.DocumentDate = DateTime.Now;
            document.CreationDate = DateTime.Now;
            document.IdDocumentStatus = (int)DocumentStatusEnumerator.Draft;
            BeginTransaction();
            var data = AddDocumentWithoutTransactionInRealTime(null, document, null, null);
            EndTransaction();
            document.Id = data.Id;
            return document;
        }
        public void UpdateOrder(DocumentViewModel document)
        {
            UpdateDocument(null, document, null, null,false);
        }

        public dynamic FindDocumentListForB2BDocument(PredicateFormatViewModel model)
        {
            DataSourceResult<DocumentListViewModel> dataSourceResult = FindDocumentList(model, true);
            if (dataSourceResult != null && dataSourceResult.data != null && dataSourceResult.data.Any())
            {
                dataSourceResult.data.ToList().ForEach(x =>
                {
                    x.isPartiallyLivred = false;
                    GetDocumentB2bStatus(x);
                });

            }
            return dataSourceResult;

        }
        private void GetDocumentB2bStatus(DocumentListViewModel document)
        {
            if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
            {
                document.isDraft = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
            {
                document.isBcSent = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Refused)
            {
                document.refused = true;
            }

            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
            {
                document.isTotallyLivred = false;
                document.isPartiallyLivred = false;
                document.isBcSent = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
            {
                document.isTotallyLivred = false;
                document.isPartiallyLivred = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)
            {
                document.isTotallyLivred = true;
            }
        }
        private void GetDocumentB2bStatus(DocumentViewModel document)
        {
            if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
            {
                document.isDraft = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
            {
                document.isBcSent = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Refused)
            {
                document.refused = true;
            }

            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
            {
                document.isTotallyLivred = false;
                document.isPartiallyLivred = false;
                document.isBcSent = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
            {
                document.isTotallyLivred = false;
                document.isPartiallyLivred = true;
            }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Balanced)
            {
                document.isTotallyLivred = true;
            }
        }
        public DocumentViewModel GetDocumentWithLines(int id)
        {
            try
            {
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == id, r => r.IdTiersNavigation, r => r.DocumentLine);
                if (document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                GetDocumentB2bStatus(document);
                foreach (var dl in document.DocumentLine)
                {
                    SetDocumentLine(dl);
                    dl.RemainingQuantity = dl.MovementQty - _serviceDocumentLine.GetModelsWithConditionsRelations(x => x.IdDocumentLineAssociated == dl.Id && (x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
             || x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Printed)).Sum(x => x.MovementQty);
                }
                return document;
            }
            catch (CustomException)
            {
                // rollback transaction
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                VerifyDuplication(e);
                throw;
            }

        }

        public DocumentViewModel GetDocumentForB2b(int id)
        {
            return GetModelWithRelationsAsNoTracked(c => c.Id == id, r => r.IdTiersNavigation);
        }
        public void SendDocument(int idDocument)
        {
            try
            {
                BeginTransaction();
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(x => x.Id == idDocument, x => x.DocumentLine);
                document.IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional;
                document.DocumentDate = DateTime.Now;
                document.CreationDate = DateTime.Now;
                Document entity = _builder.BuildModel(document);
                if (entity.DocumentLine != null && entity.DocumentLine.Any())
                {
                    entity.DocumentLine.ToList().ForEach(y =>
                    {
                        y.IdDocumentNavigation = null;
                        y.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                        _entityDocumentLineRepo.Update(y);
                    });
                }
                document.DocumentLine.Clear();
                _entityRepo.Update(entity);
                _unitOfWork.Commit();
                EndTransaction();
            }
#pragma warning disable CS0168 // The variable 'e' is declared but never used
            catch (Exception e)
#pragma warning restore CS0168 // The variable 'e' is declared but never used
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        public CurrencyViewModel getUserCurrency(int idTiers)
        {
            return _serviceTiers.GetModelWithRelations(x => x.Id == idTiers, x => x.IdCurrencyNavigation).IdCurrencyNavigation;
        }
        public int GetOrderCount()
        {
            try
            {
                BeginTransactionunReadUncommitted();
                var resul = _entityRepo.QuerableGetAll().AsNoTracking().Count(x => x.IsBtoB == true && x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional && x.DocumentTypeCode == DocumentEnumerator.SalesOrder);
                EndTransaction();
                return resul;
            }
            catch
            {
                return 0;
            }
        }
        public IList<CreatedDataViewModel> SaveBulkOrder(List <DocumentViewModel> documentList)
         {
            IList<CreatedDataViewModel> listOfCreatedDocument = new List<CreatedDataViewModel>();
            WarehouseViewModel centralWarhouse = _serviceWarehouse.GetModel(x => x.IsCentral);
            List<int> idItems = documentList.SelectMany(x => x.DocumentLine.Select(y => y.IdItem)).ToList();
            var listOfitem = _serviceItem.GetModelsWithConditionsRelations(x => idItems.Contains(x.Id), x => x.IdUnitStockNavigation, x => x.ItemTiers).ToList();
            List<string> emails = documentList.Select(x => x.UserMail).ToList();
            List<UsersBtob> listOfUsers = _repoUsersBtob.FindByAsNoTracking(x => emails.Contains(x.Email)).ToList();
            if (listOfUsers.Count == 0)
            {
                throw new CustomException(CustomStatusCode.UserNotSynchronized);
            }
            List<int> idsTiers = listOfUsers.Select(x => x.IdClient).ToList();
            List<TiersViewModel> listOfTiers = _serviceTiers.GetModelsWithConditionsRelations(x => idsTiers.Contains(x.Id)).ToList();
            bool itemIsDeleted = false;
            foreach (DocumentViewModel document in documentList)
            {
                CreatedDataViewModel createdDocument = new CreatedDataViewModel();
                UsersBtob user = listOfUsers.Where(x => x.Email == document.UserMail).FirstOrDefault();
                TiersViewModel tiers = listOfTiers.Where(x => x.Id == user.IdClient).FirstOrDefault();
                document.IdTiers = tiers.Id;
                document.IdUsedCurrency = tiers.IdCurrency;
                document.DocumentTypeCode = DocumentEnumerator.SalesOrder;
                document.DocumentOtherTaxesWithCurrency = 0;
                document.DocumentOtherTaxes = 0;
                document.IsBToB = true;
                document.DocumentDate = DateTime.Now;
                document.CreationDate = DateTime.Now;
                document.IdDocumentStatus = (int)DocumentStatusEnumerator.Draft;
                document.IsSynchronizedBtoB = true;
                SetDocumentDate(document);
                document.IdCreatorBtob = user.Id;
                foreach (var documentLine in document.DocumentLine)
                {
                    itemIsDeleted = false;
                    var item = listOfitem.Where(x=> x.Id == documentLine.IdItem).FirstOrDefault();
                    if (item == null || (item != null && item.IsForSales == false))
                    {
                        itemIsDeleted = true;
                        createdDocument.Reference = document.Reference;
                        createdDocument.ListInt.Add(documentLine.IdItem);
                    }
                    else
                    {
                        List<ItemTiersViewModel> itemTiers = _serviceItem.GetItemTiers(documentLine.IdItem);
                        ItemTiersViewModel itemtier = item.ItemTiers.Where(x => x.IdTiers == tiers.Id).FirstOrDefault();
                        documentLine.Designation = item.Description;
                        documentLine.IdMeasureUnit = item.IdUnitStock;
                        documentLine.IdMeasureUnitNavigation = item.IdUnitStockNavigation;
                        documentLine.HtUnitAmountWithCurrency = documentLine.Price;
                        documentLine.ItemTiers = itemTiers;
                        documentLine.IdSupplier = tiers;
                        documentLine.MovementQty = documentLine.MovementQty;
                        documentLine.Id = 0;
                        documentLine.IdWarehouse = 0;
                        documentLine.DiscountPercentage = 0;
                        documentLine.IdWarehouse = centralWarhouse.Id;
                        if (documentLine.HtUnitAmountWithCurrency == null)
                        {
                            documentLine.HtUnitAmountWithCurrency = 0;
                        }
                        documentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                    }
                }
                //Recuperate analytical Axis
                List<EntityAxisValuesViewModel> listOfAxisViewModel = _entityRepoEntityAxisValues.
                    FindBy(c => c.IdEntityItem == document.Id).Select(_builderEntityAxisValues.BuildEntity).ToList();
                if (itemIsDeleted == false)
                {
                    createdDocument = (CreatedDataViewModel)AddDocument(null, document, user.Email, listOfAxisViewModel);
                }
                listOfCreatedDocument.Add(createdDocument);

            }
            return listOfCreatedDocument;
        }
        public string GetHttpResponseFromRequest(HttpMethod post, Uri uri, string content, bool forDocumentStatus, string token)
        {
            using (var httpClient = new HttpClient())
            {
                HttpRequestMessage request = new HttpRequestMessage(post, uri);
                if (forDocumentStatus)
                {
                    request.Headers.Add("Authorization", "Bearer " + string.Format("{0}", token));
                }
                if (content != null)
                {
                    request.Content = new StringContent(content, Encoding.UTF8, "application/json");
                }

                try
                {
                    var response = httpClient.SendAsync(request);
                    Task.WaitAny(response);
                    object responseData = JsonConvert.DeserializeObject(response.Result.Content.ReadAsStringAsync().Result);
                    if (!forDocumentStatus)
                    {
                        CheckBtoBAccessAuthorization(responseData);
                    }
                    return responseData.ToString();
                }
                catch (Exception e)
                {

                    throw new CustomException(CustomStatusCode.BtoBServerIsUnreachable, e);
                }
            }
        }
        private void CheckBtoBAccessAuthorization(object jsonResponse)
        {
            InAuthorizedAccesstoBToBViewModel authorizedAccesstoECommerceViewModel = JsonConvert.DeserializeObject<InAuthorizedAccesstoBToBViewModel>(jsonResponse.ToString());
             if (authorizedAccesstoECommerceViewModel != null && authorizedAccesstoECommerceViewModel.code == "404")
             {
                 throw new CustomException(CustomStatusCode.BtoBServerIsUnreachable);
             }

        }
        /// <summary>
        /// Get Token From SignIn Btob 
        /// </summary>
        /// <returns></returns>
        public ResponseTokenFromBtoBViewModel GetTokenFromSignInBtob()
        {
            SignInBtoBViewmodel signInBtoB = new SignInBtoBViewmodel
            {
                client_id = _appSettings.BtoBConfig.client_id,
                client_secret = _appSettings.BtoBConfig.client_secret,
                grant_type = _appSettings.BtoBConfig.grant_type,
                username = _appSettings.BtoBConfig.username,
                password = _appSettings.BtoBConfig.password,
                company_code = GetCurrentCompany().Code,
            };
            string signInBody = JsonConvert.SerializeObject(signInBtoB);
            var baseUri = new Uri(_appSettings.BtoBConfig.BaseBtoBURL);
            Uri myUri = new Uri(baseUri, _appSettings.BtoBConfig.SignInUrl);
            string responseString =  GetHttpResponseFromRequest(HttpMethod.Post, myUri, signInBody, false, null);
            ResponseTokenFromBtoBViewModel responseFromBtoB = JsonConvert.DeserializeObject<ResponseTokenFromBtoBViewModel>(responseString);
            return responseFromBtoB;
        }
        public string SendDocumentStatusToBtoB(List<DocumentViewModel> documentList)
        {
            ListBtoBDocumentStatusViewModel listOfOrders = new ListBtoBDocumentStatusViewModel();
            List<BtoBDocumentStatusViewModel> btoBDocumentStatusviews = new List<BtoBDocumentStatusViewModel>();
            documentList.ForEach(x => {
                BtoBDocumentStatusViewModel btoBDocumentStatus = new BtoBDocumentStatusViewModel
                {
                    code = x.Code,
                    status = x.IdDocumentStatus,
                };
                btoBDocumentStatusviews.Add(btoBDocumentStatus);
            });
            ResponseTokenFromBtoBViewModel responseLogin =  GetTokenFromSignInBtob();
            listOfOrders.username = responseLogin.email;
            listOfOrders.company_code = GetCurrentCompany().Code;
            listOfOrders.orders = btoBDocumentStatusviews;
            string documentStatusBody = JsonConvert.SerializeObject(listOfOrders);
            var baseUri = new Uri(_appSettings.BtoBConfig.BaseBtoBURL);

            Uri myUri = new Uri(baseUri, _appSettings.BtoBConfig.DocumentStatusUrl);
           return GetHttpResponseFromRequest(HttpMethod.Post, myUri, documentStatusBody, true, responseLogin.access_token);
        }
        public async Task<dynamic> ValidateOrderBtoB(int idDocument, string userMail)
        {
            List<DocumentViewModel> documentList = new List<DocumentViewModel>();
            dynamic result = ValidateDocument(idDocument, userMail);
            DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == idDocument);
            documentList.Add(document);
            string response =  SendDocumentStatusToBtoB(documentList);
            BToBResponseStatusCodeViewModel responseFromBtoB = JsonConvert.DeserializeObject<BToBResponseStatusCodeViewModel>(response);
            if (responseFromBtoB.ListOfSuccess.Any())
            {
                var ctx = _unitOfWork.GetContext();
                var attachedEntity = ctx.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == document.Id);
                if (attachedEntity != null)
                {
                    ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
                }
                document.IsSynchronizedBtoB = true;
                UpdateModelWithoutTransaction(document);
            }
            return result; 

        }
        public Document  CanceledOrderFromBtob (string canceledOrderCode)
        {
            var document = _entityRepo.GetSingleNotTracked(x => x.Code == canceledOrderCode);
            if (document != null && document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
            {
                document.IdDocumentStatus = (int)DocumentStatusEnumerator.Refused;
                _entityRepo.Update(document);
                _unitOfWork.Commit();
            }
            return document;
        }

        public async Task<dynamic> CanceledOrderBtobFromStark(int idDocument)
        {
            List<DocumentViewModel> documentList = new List<DocumentViewModel>();
            var documentOrder = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idDocument, x => x.DocumentLine).FirstOrDefault();
            Document queryableListOfDocument = _entityRepo.GetAllAsNoTracking().Include(x=>x.DocumentLine).Where(x => x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional &&
               x.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.DocumentLine.Select(y => y.IdDocumentLineAssociatedNavigation.IdDocument).Contains(idDocument)).FirstOrDefault();
            if (queryableListOfDocument != null )
            {
                var totalLines = documentOrder.DocumentLine.Count();
               if ( queryableListOfDocument.DocumentLine.Count() == totalLines)
                {
                    DeleteModel(queryableListOfDocument.Id, "Document", null);
                }
                else
                {
                    List <int> documentLineIds = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocumentLineAssociatedNavigation.IdDocument == idDocument).Select(x => x.Id).ToList();
                    DeleteAllLinesFromId(documentLineIds);
                }
            }
            CancelDocument(idDocument);
            DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == idDocument);
            documentList.Add(document);
             SendDocumentStatusToBtoB(documentList);
            return document;
        }

        public bool ExistingBLToBToBOrder(int idDocument)
        {
             IQueryable <Document> queryableListOfDocument = _entityRepo.QuerableGetAll().Where(x => x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional &&
                x.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.DocumentLine.Select(y=> y.IdDocumentLineAssociatedNavigation.IdDocument).Contains(idDocument));
            return queryableListOfDocument.Any();
        }
        public void SynchronizeAllBToBDocuments(string userMail)
        {
            List<DocumentViewModel> documentList = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.DocumentTypeCode == DocumentEnumerator.SalesOrder && x.IsBtoB == true &&
            x.IsSynchronizedBtoB == false).Select(_builder.BuildEntity).ToList();
            string response =  SendDocumentStatusToBtoB(documentList);
            BToBResponseStatusCodeViewModel responseFromBtoB = JsonConvert.DeserializeObject<BToBResponseStatusCodeViewModel>(response);
            if (responseFromBtoB.ListOfSuccess.Any())
            {
                List<string> listOfCode = responseFromBtoB.ListOfSuccess.Select(x => x.Code).ToList();
                documentList.Where(x => listOfCode.Contains(x.Code)).ToList().ForEach(x => {
                    x.IsSynchronizedBtoB = true;
                });
                BulkUpdateModelWithoutTransaction(documentList, userMail);
            }
        }

    }
}
