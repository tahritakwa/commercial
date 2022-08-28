using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Sales.Classes
{
    public class ServicePrices : Service<PricesViewModel, Prices>, IServicePrices
    {

        internal readonly ICurrencyBuilder _currencyBuilder;
        internal readonly ICurrencyRateBuilder _currencyRateBuilder;
        internal readonly IRepository<Tiers> _entityRepoTiers;
        internal readonly IRepository<CurrencyRate> _entityRepoCurrencyRate;
        internal readonly IRepository<Item> _entityRepoItem;
        internal readonly IRepository<User> _entityRepoUser;
        internal readonly IRepository<DocumentLinePrices> _entityDocumentLinePricesRepo;
        internal readonly IServiceTiersPrices _serviceTiersPrices;
        internal readonly IServiceItemPrices _serviceItemPrices;
        internal readonly IServicePriceDetail _servicePriceDetail;

        public ServicePrices(IRepository<Prices> entityRepo, IUnitOfWork unitOfWork,
            ICurrencyBuilder currencyBuilder, IRepository<User> entityRepoUser,
            ICurrencyRateBuilder currencyRateBuilder,
            IPricesBuilder pricesBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Tiers> entityRepoTiers,
            IRepository<CurrencyRate> entityRepoCurrencyRate,
            IRepository<Codification> entityRepoCodification,
            IRepository<Company> entityRepoCompany,
            IRepository<Item> entityRepoItem,
            IOptions<AppSettings> appSettings,
            IRepository<DocumentLinePrices> entityDocumentLinePricesRepo,
            IServiceTiersPrices serviceTiersPrices,
            IServiceItemPrices serviceItemPrices,
            IServicePriceDetail servicePriceDetail,
            IServiceProvider serviceProvider
            )
            : base(entityRepo, unitOfWork, pricesBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, entityRepoEntity,
                  entityRepoEntityCodification, entityRepoCodification)
        {

            _entityRepoTiers = entityRepoTiers;
            _currencyBuilder = currencyBuilder;
            _entityRepoCurrencyRate = entityRepoCurrencyRate;
            _currencyRateBuilder = currencyRateBuilder;
            _entityRepoItem = entityRepoItem;
            _entityRepoUser = entityRepoUser;
            _entityDocumentLinePricesRepo = entityDocumentLinePricesRepo;

            _serviceTiersPrices = serviceTiersPrices;
            _serviceItemPrices = serviceItemPrices;
            _servicePriceDetail = servicePriceDetail;
            _serviceProvider = serviceProvider;
        }

        public override IList<PricesViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IList<PricesViewModel> model = base.FindModelBy(predicateModel);
            if (model.Count() == 1)
            {
                PricesViewModel price = model.First();
                //attach list of file to current document
                price.FilesInfos = GetFilesContent(price.AttachmentUrl);
            }
            return model;
        }

        public override object AddModel(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {

            try
            {
                PatchPriceDetails(model);
                CheckPriceDetailsChevauchement(model);
                CheckValuePrices(model);
                //Add url of attachment files
                model.AttachmentUrl = Path.Combine("Sales", "Prices", DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff"));
                object obj = base.AddModel(model, entityAxisValuesModelList, userMail, null);
                //Copy files to specific url
                if (model.Files != null && model.Files.Any())
                    CopyFiles(model.AttachmentUrl, model.Files);
                return obj;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        private void CheckValuePrices(PricesViewModel model)
        {
            if (model.PriceDetail.Any(element => element.Percentage < 0 || element.Percentage > 100))
            {
                throw new CustomException(CustomStatusCode.ValueDiscountePrices);
            }
        }

        /// <summary>
        /// check If there is a chevauchement 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static void CheckPriceDetailsChevauchement(PricesViewModel model)
        {
            if (model.PriceDetail != null && model.PriceDetail.Count > 0)
            {
                model.PriceDetail.Where(x => !x.IsDeleted).ToList().ForEach(element =>
                {
                    if (model.PriceDetail.Any(x => x != element && !x.IsDeleted && IsWithDateTimeCheveauchment(element, x) &&
                        IsWithQuantityCheveauchmentOrEmpty(element, x)))
                    {
                        throw new CustomException(CustomStatusCode.OverlapPriceDetail);
                    }
                });
            }
        }

        private static bool IsWithDateTimeCheveauchment(PriceDetailViewModel price1, PriceDetailViewModel price2)
        {
            return price1.StartDateTime.BetweenDateTimeLimitNotIncluded(price2.StartDateTime, price2.EndDateTime) ||
                        price1.EndDateTime.BetweenDateTimeLimitNotIncluded(price2.StartDateTime, price2.EndDateTime);
        }
        private static bool IsWithQuantityCheveauchmentOrEmpty(PriceDetailViewModel price1, PriceDetailViewModel price2)
        {
            return (price1.MinimumQuantity != null && price1.MinimumQuantity >= price2.MinimumQuantity && price1.MinimumQuantity <= price2.MaximumQuantity) ||
             (price1.MaximumQuantity != null && price1.MaximumQuantity >= price2.MinimumQuantity && price1.MaximumQuantity <= price2.MaximumQuantity) ||
             price1.MinimumQuantity == null || price1.MaximumQuantity == null;
        }

        /// <summary>
        /// Add Price with observations files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public object AddModelWithObservationFiles(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {

            try
            {
                if (model.IdUsedCurrency == null)
                {
                    throw new CustomException(CustomStatusCode.RequiredCurrency);
                }
                PatchPriceDetails(model);
                //verify chevauchement
                CheckPriceDetailsChevauchement(model);
                CheckValuePrices(model);
                //Add Observation Files
                ManageFileEmployee(model);

                return base.AddModel(model, entityAxisValuesModelList, userMail, null);

            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }


        /// <summary>
        /// Update Price with observations files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object UpdateModelWithObservationFiles(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {

            try
            {
                if (model.IdUsedCurrency == null)
                {
                    throw new CustomException(CustomStatusCode.RequiredCurrency);
                }
                //List<DocumentLinePrices> documentLinesOfPrice = _entityDocumentLinePricesRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdPrices == model.Id).ToList();
                //if(documentLinesOfPrice !=null && documentLinesOfPrice.Any())
                //{
                //    throw new CustomException(CustomStatusCode.CantUpdateUsedPrice);
                //}

                PatchPriceDetails(model);
                //verify chevauchement
                CheckPriceDetailsChevauchement(model);
                CheckValuePrices(model);
                //Add Observation Files
                ManageFileEmployee(model);
                return base.UpdateModel(model, entityAxisValuesModelList, userMail);

            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }
        /// <summary>
        /// Save Observations Files and update the attachement Url
        /// </summary>
        /// <param name="model"></param>
        private void ManageFileEmployee(PricesViewModel model)
        {
            //Mange Observations Files
            if (string.IsNullOrEmpty(model.AttachmentUrl))
            {
                if (model.ObservationsFilesInfo != null)
                {
                    model.AttachmentUrl = Path.Combine("Sales", "Prices", model.LabelPrices, Guid.NewGuid().ToString());
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            else
            {
                DeleteFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
            }

        }
        public override object UpdateModel(PricesViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {

                PatchPriceDetails(model);
                CheckPriceDetailsChevauchement(model);
                CheckValuePrices(model);
                // If url not valide create new one.
                if (string.IsNullOrEmpty(model.AttachmentUrl) || model.Files != null)
                {
                    model.AttachmentUrl = Path.Combine("Sales", "Prices", DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff"));
                }
                var result = base.UpdateModel(model, entityAxisValuesModelList, userMail);
                //Delete files from directory
                DeleteUploadedFiles(model.AttachmentUrl, model.UploadedFiles);
                //Copy files to specific url
                if (model.Files != null && model.Files.Any())
                    CopyFiles(model.AttachmentUrl, model.Files);
                //Delete directory if list of file in current directory null
                DeleteDirectoryFiles(model.AttachmentUrl);
                return result;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }

        }

        /// <summary>
        /// Get Model By Id With Observations Files Uploaded
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override PricesViewModel GetModelById(int id)
        {
            PricesViewModel prices = GetModelAsNoTracked(x => x.Id == id, x => x.PriceDetail, x => x.IdUsedCurrencyNavigation);
            DispatchPriceDetails(prices);
            prices.ObservationsFilesInfo = GetFiles(prices.AttachmentUrl).ToList();
            return prices;
        }
        private void DispatchPriceDetails(PricesViewModel prices)
        {
            if (prices.PriceDetail != null && prices.PriceDetail.Count > 0)
            {
                prices.PriceQuantityDiscountList = prices.PriceDetail.Where
                    (element => element.TypeOfPriceDetail == (int)DiscountType.Quantity).ToList();
                prices.PriceTotalPurchasesDiscountList = prices.PriceDetail.Where
                    (element => element.TypeOfPriceDetail == (int)DiscountType.TotalPurchases).ToList();
                prices.PriceSpecialPriceDiscountList = prices.PriceDetail.Where
                    (element => element.TypeOfPriceDetail == (int)DiscountType.SpecialPrice).ToList();
                prices.PriceGiftedItemsDiscountList = prices.PriceDetail.Where
                    (element => element.TypeOfPriceDetail == (int)DiscountType.GiftedItems).ToList();
            }
        }
        private void PatchPriceDetails(PricesViewModel prices)
        {
            prices.PriceDetail = prices.PriceGiftedItemsDiscountList.Union(prices.PriceQuantityDiscountList).
                Union(prices.PriceSpecialPriceDiscountList).Union(prices.PriceTotalPurchasesDiscountList).ToList();
        }
        public PricesViewModel GetSpecificPrice(PriceGetterViewModel priceGetter, ItemPriceViewModel itemPriceViewModel = null)
        {
            PricesViewModel priceEntity;

            ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel = GetValidPriceDetail(priceGetter);
            // get discount UnitPriceHTaxe and TotalDiscount 
            priceEntity = GetPriceValues(priceGetter, validPriceWithOneDetailViewModel, itemPriceViewModel);
            return priceEntity;

        }
        /// <summary>
        /// calcul le prix unitaire hores taxe 
        /// </summary>
        /// <param name="getter"></param>
        /// <returns></returns>
        public ValidPriceWithOneDetailViewModel GetValidPriceDetail(PriceGetterViewModel getter)
        {
            PriceDetailViewModel priceEntity = new PriceDetailViewModel();
            // all the prices have current date between details dates  
            // And have current quantity between details quantity or havent quantity
            // And have item or tier equal to current item or tier
            List<PricesViewModel> priceList = GetAllModelsQueryableWithRelation(c =>
            c.PriceDetail.Any(pD => (getter.CurrentDate.Date >= pD.StartDateTime.Date && getter.CurrentDate.Date <= pD.EndDateTime.Date) &&
                            (pD.MinimumQuantity != null && pD.MaximumQuantity != null && getter.CurrentQuantity >= pD.MinimumQuantity
                            && getter.CurrentQuantity <= pD.MaximumQuantity ||
                            pD.MinimumQuantity == null || pD.MaximumQuantity == null)) &&
            (c.TiersPrices.Select(x => x.IdTiers).Contains(getter.IdTiers) || c.ItemPrices.Select(x => x.IdItem).Contains(getter.IdItem)),
            c => c.PriceDetail, c => c.TiersPrices.Where(x => x.IdTiers == getter.IdTiers), c => c.ItemPrices.Where(x => x.IdItem == getter.IdItem)).ToList();


            if (priceList.Any())
            {
                // Case1 have item and tier
                PricesViewModel price = priceList.Where(c => c.TiersPrices != null && c.TiersPrices.Where(tP => tP.IdTiers == getter.IdTiers).Any() &&
                c.ItemPrices != null && c.ItemPrices.Any(tP => tP.IdItem == getter.IdItem)).FirstOrDefault();
                if (price == null)
                {
                    // case 2 have item and no tiers afeccted
                    price = priceList.Where(c => (c.TiersPrices == null || !c.TiersPrices.Any()) &&
                    c.ItemPrices != null && c.ItemPrices.Any(tP => tP.IdItem == getter.IdItem)).FirstOrDefault();
                }
                if (price == null)
                {
                    // Else case 3 have tier and no items affected
                    price = priceList.Where(c => c.TiersPrices != null && c.TiersPrices.Any(tP => tP.IdTiers == getter.IdTiers) &&
                    (c.ItemPrices == null || !c.ItemPrices.Any())).FirstOrDefault();
                }
                if (price != null)
                {
                    PriceDetailViewModel priceDetail = price.PriceDetail.Where(pD => getter.CurrentDate.BetweenDateTimeLimitNotIncluded(pD.StartDateTime, pD.EndDateTime) &&
                             (pD.MinimumQuantity != null && pD.MaximumQuantity != null && getter.CurrentQuantity >= pD.MinimumQuantity && getter.CurrentQuantity <= pD.MaximumQuantity ||
                             pD.MinimumQuantity == null || pD.MaximumQuantity == null)).FirstOrDefault();
                    return new ValidPriceWithOneDetailViewModel { PricesViewModel = price, PriceDetailViewModel = priceDetail };
                }

            }
            return null;

        }

        /// <summary>
        /// calcul le taux de remise
        /// </summary>
        /// <param name="getter"></param>
        /// <param name="validPriceWithOneDetailViewModel"></param>
        /// <returns></returns>
        public PricesViewModel GetPriceValues(PriceGetterViewModel getter, ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel, ItemPriceViewModel itemPriceViewModel = null)
        {
            if (validPriceWithOneDetailViewModel != null && validPriceWithOneDetailViewModel.PriceDetailViewModel != null)
            {
                switch (validPriceWithOneDetailViewModel.PriceDetailViewModel.TypeOfPriceDetail)
                {

                    case (int)DiscountType.Quantity:
                        return GetPriceValuesForQuantityPriceDetail(getter, validPriceWithOneDetailViewModel, itemPriceViewModel);

                    case (int)DiscountType.TotalPurchases:
                        return GetPriceValuesForTotalPurchasesPriceDetail(getter, validPriceWithOneDetailViewModel, itemPriceViewModel);

                    case (int)DiscountType.SpecialPrice:
                        return GetPriceValuesForSpecialPricePriceDetail(getter, validPriceWithOneDetailViewModel, itemPriceViewModel);

                    case (int)DiscountType.GiftedItems:
                        return GetPriceValuesForGiftedItemsPriceDetail(getter, validPriceWithOneDetailViewModel, itemPriceViewModel);

                }
            }
            return null;
        }
        public PricesViewModel GetPriceValuesForQuantityPriceDetail(PriceGetterViewModel getter, ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel, ItemPriceViewModel itemPriceViewModel = null)
        {

            if (itemPriceViewModel != null && itemPriceViewModel.Item != null && itemPriceViewModel.Item.UnitHtsalePrice != null)
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = (double)itemPriceViewModel.Item.UnitHtsalePrice;
            }
            else
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = _entityRepoItem.FindBy
                (x => x.Id == getter.IdItem).First().UnitHtsalePrice ?? 0;

            }

            if (getter.CurrentQuantity.BetweenQuantitiesLimitIncluded(
                validPriceWithOneDetailViewModel.PriceDetailViewModel.MinimumQuantity, validPriceWithOneDetailViewModel.PriceDetailViewModel.MaximumQuantity))
            {
                validPriceWithOneDetailViewModel.PricesViewModel.TotalDiscount = validPriceWithOneDetailViewModel.PriceDetailViewModel.Percentage.Value;
            }
            validPriceWithOneDetailViewModel.PricesViewModel.UsedDiscountType = validPriceWithOneDetailViewModel.PriceDetailViewModel.TypeOfPriceDetail;
            return validPriceWithOneDetailViewModel.PricesViewModel;
        }

        public PricesViewModel GetPriceValuesForTotalPurchasesPriceDetail(PriceGetterViewModel getter, ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel, ItemPriceViewModel itemPriceViewModel = null)
        {

            if (itemPriceViewModel != null && itemPriceViewModel.Item != null && itemPriceViewModel.Item.UnitHtsalePrice != null)
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = (double)itemPriceViewModel.Item.UnitHtsalePrice;
            }
            else
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = _entityRepoItem.FindBy
                (x => x.Id == getter.IdItem).First().UnitHtsalePrice ?? 0;

            }
            double totalSaledPrice = validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe * getter.CurrentQuantity;
            if (totalSaledPrice >= validPriceWithOneDetailViewModel.PriceDetailViewModel.TotalPrices)
            {
                if (validPriceWithOneDetailViewModel.PriceDetailViewModel.Percentage.Value > 0)
                {
                    validPriceWithOneDetailViewModel.PricesViewModel.TotalDiscount = validPriceWithOneDetailViewModel.PriceDetailViewModel.Percentage.Value;
                }
                else
                {
                    validPriceWithOneDetailViewModel.PricesViewModel.TotalDiscount = validPriceWithOneDetailViewModel.PriceDetailViewModel.ReducedValue.Value /
                         totalSaledPrice * 100;
                }
            }
            return validPriceWithOneDetailViewModel.PricesViewModel;
        }

        public PricesViewModel GetPriceValuesForSpecialPricePriceDetail(PriceGetterViewModel getter, ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel, ItemPriceViewModel itemPriceViewModel = null)
        {
            if (getter.CurrentQuantity.BetweenQuantitiesLimitIncluded(
                validPriceWithOneDetailViewModel.PriceDetailViewModel.MinimumQuantity, validPriceWithOneDetailViewModel.PriceDetailViewModel.MaximumQuantity))
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = validPriceWithOneDetailViewModel.PriceDetailViewModel.SpecialPrice.Value;
            }
            validPriceWithOneDetailViewModel.PricesViewModel.UsedDiscountType = validPriceWithOneDetailViewModel.PriceDetailViewModel.TypeOfPriceDetail;
            return validPriceWithOneDetailViewModel.PricesViewModel;
        }

        public PricesViewModel GetPriceValuesForGiftedItemsPriceDetail(PriceGetterViewModel getter, ValidPriceWithOneDetailViewModel validPriceWithOneDetailViewModel, ItemPriceViewModel itemPriceViewModel = null)
        {

            if (itemPriceViewModel != null && itemPriceViewModel.Item != null && itemPriceViewModel.Item.UnitHtsalePrice != null)
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = (double)itemPriceViewModel.Item.UnitHtsalePrice;
            }
            else
            {
                validPriceWithOneDetailViewModel.PricesViewModel.UnitPriceHTaxe = _entityRepoItem.FindBy
                (x => x.Id == getter.IdItem).First().UnitHtsalePrice ?? 0;

            }
            validPriceWithOneDetailViewModel.PricesViewModel.TotalDiscount = CalculatePercentage(getter.CurrentQuantity,
                validPriceWithOneDetailViewModel.PriceDetailViewModel.SaledItemsNumber.Value,
                validPriceWithOneDetailViewModel.PriceDetailViewModel.GiftedItemsNumber.Value);
            return validPriceWithOneDetailViewModel.PricesViewModel;
        }
        private double CalculatePercentage(double totalSales, double saledToGift, double giftedNumber)
        {
            double packItemsNumber = saledToGift + giftedNumber;
            int numberOfSaledPacks = (int)Math.Truncate(totalSales / packItemsNumber);
            double numberOfGiftedItems = giftedNumber * numberOfSaledPacks;
            return numberOfGiftedItems / totalSales * 100;
        }

        public CurrencyViewModel GetCurrencyByTiers(int idTiers)
        {
            return _currencyBuilder.BuildEntity(_entityRepoTiers.GetAllWithConditionsRelations(c => c.Id == idTiers, c => c.IdCurrencyNavigation).FirstOrDefault().IdCurrencyNavigation);
        }

        public CurrencyRateViewModel GetCurrencyRateByDate(dynamic model)
        {
            if (model != null)
            {
                DateTime date = DateTime.Parse(model.Date.ToString(), CultureInfo.CurrentCulture);
                int idCurrency = (model).IdCurrency;
                return _currencyRateBuilder
                    .BuildEntity(_entityRepoCurrencyRate
                    .GetAllWithConditionsRelations(c => c.IdCurrency == idCurrency
                   && date >= c.StartDate && date <= c.EndDate).FirstOrDefault());
            }
            throw new CustomException(CustomStatusCode.InternalServerError);
        }
        /// <summary>
        /// Get customer list affected to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public DataSourceResult<TiersViewModel> GetPriceCustomers(PriceAffectionViewModel priceAffectionViewModel)
        {
            IQueryable<TiersPricesViewModel> data = _serviceTiersPrices
                .GetAllModelsQueryableWithRelation(x => x.IdPrices == priceAffectionViewModel.IdPrice, x => x.IdTiersNavigation);

            List<TiersViewModel> model = data.Skip(priceAffectionViewModel.Skip).Take(priceAffectionViewModel.Take)
                .Select(x => x.IdTiersNavigation).ToList();

            foreach (var tier in model)
            {
                if (tier.UrlPicture != null)
                {
                    tier.PictureFileInfo = GetFiles(tier.UrlPicture).FirstOrDefault();
                }
            }
            return new DataSourceResult<TiersViewModel> { data = model, total = data.Count() };
        }
        /// <summary>
        /// Get item list affected to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public DataSourceResult<ItemViewModel> GetPriceItems(PriceAffectionViewModel priceAffectionViewModel)
        {
            IQueryable<ItemPricesViewModel> data = _serviceItemPrices
                .GetAllModelsQueryableWithRelation(x => x.IdPrices == priceAffectionViewModel.IdPrice, x => x.IdItemNavigation);

            List<ItemViewModel> model = data.Skip(priceAffectionViewModel.Skip).Take(priceAffectionViewModel.Take)
                .Select(x => x.IdItemNavigation).ToList();
            return new DataSourceResult<ItemViewModel> { data = model, total = data.Count() };
        }
        /// <summary>
        /// Affect customer to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public void AffectCustomerToPrice(TiersPricesViewModel model, string userMail)
        {
            IList<TiersPricesViewModel> modelToUnaffect = _serviceTiersPrices.FindByAsNoTracking(x => x.IdPrices == model.IdPrices
            && x.IdTiers == model.IdTiers);
            if (modelToUnaffect.Any())
            {
                throw new CustomException(CustomStatusCode.AlreadyAffectedElement);
            }
            CheckIfCustomerIsAffectedToOtherPrice(model);
            _serviceTiersPrices.AddModel(model, null, userMail);
        }
        public void CheckIfCustomerIsAffectedToOtherPrice(TiersPricesViewModel model)
        {
            IList<ItemPricesViewModel> itemOfCurrentPrice = _serviceItemPrices.FindModelsByNoTracked(x => x.IdPrices == model.IdPrices);

            // if no items
            if (!itemOfCurrentPrice.Any())
            {
                CheckIfTheCustomerIsRelatedToAnyPriceButTheCurrentPrice(model.IdTiers, model.IdPrices);
            }
            else // There are items
            {
                itemOfCurrentPrice.ToList().ForEach(item =>
                {
                    CheckIfACustomerItemCoupleDiscountIsRelatedToAnyPriceButTheCurrentPrice(model.IdTiers, item.IdItem, model.IdPrices);
                });
            }
        }

        void CheckIfTheCustomerIsRelatedToAnyPriceButTheCurrentPrice(int idTiers, int idCurrentPrice, IQueryable<Prices> otherPricesListFromDB = null)
        {
            IList<Prices> pricesRelatedToCusomer;
            if (otherPricesListFromDB != null)
            {
                otherPricesListFromDB = otherPricesListFromDB.Where(x => x.TiersPrices.Any(y => y.IdTiers == idTiers));
            }
            else
            {
                otherPricesListFromDB = GetAllModelsQueryable().Where(x => x.TiersPrices.Any(y => y.IdTiers == idTiers) && x.Id != idCurrentPrice &&
                (x.PriceDetail.Any(y => (DateTime.UtcNow.Date >= y.StartDateTime.Date && DateTime.UtcNow.Date <= y.EndDateTime.Date) ||
                   DateTime.UtcNow.Date < y.StartDateTime.Date)));
            }
            pricesRelatedToCusomer = otherPricesListFromDB.Include(x => x.TiersPrices).ThenInclude(x => x.IdTiersNavigation).ToList();
            if (pricesRelatedToCusomer.Any())
            {
                Tiers customer = pricesRelatedToCusomer.Select(x => x.TiersPrices).FirstOrDefault(x => x.Any(y => y.IdTiers == idTiers)).
                    FirstOrDefault(x => x.IdTiers == idTiers).IdTiersNavigation;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "THE_CUSTOMER", new StringBuilder().Append(customer.Name).Append(" ").Append(customer.CodeTiers).ToString() }
                };
                throw new CustomException(CustomStatusCode.OverlapTarif, paramtrs);

            }
        }

        private void CheckIfACustomerItemCoupleDiscountIsRelatedToAnyPriceButTheCurrentPrice(int idTiers, int idItem, int idCurrentPrice
            , IQueryable<Prices> otherPricesListFromDB = null)
        {
            IList<Prices> pricesRelatedToCusomerAndItem;
            if (otherPricesListFromDB != null)
            {
                otherPricesListFromDB = otherPricesListFromDB.Where(x => x.TiersPrices.Any(y => y.IdTiers == idTiers) &&
                    x.ItemPrices.Any(y => y.IdItem == idItem));
            }
            else
            {
                otherPricesListFromDB = GetAllModelsQueryable().Where(x => x.TiersPrices.Any(y => y.IdTiers == idTiers) &&
                    x.ItemPrices.Any(y => y.IdItem == idItem) && x.Id != idCurrentPrice);
            }

            pricesRelatedToCusomerAndItem = otherPricesListFromDB.Include(x => x.ItemPrices).ThenInclude(x => x.IdItemNavigation)
                .Include(x => x.TiersPrices).ThenInclude(x => x.IdTiersNavigation).ToList();
            if (pricesRelatedToCusomerAndItem.Any())
            {
                Tiers customer = pricesRelatedToCusomerAndItem.Select(x => x.TiersPrices).FirstOrDefault(x => x.Any(y => y.IdTiers == idTiers)).
                    FirstOrDefault(x => x.IdTiers == idTiers).IdTiersNavigation;
                Item item = pricesRelatedToCusomerAndItem.Select(x => x.ItemPrices).FirstOrDefault(x => x.Any(y => y.IdItem == idItem)).
                    FirstOrDefault(x => x.IdItem == idItem).IdItemNavigation;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "THE_CUSTOMER", new StringBuilder().Append(customer.Name).Append(" ").Append(customer.CodeTiers)},
                    { "THE_ITEM", new StringBuilder().Append(item.Description).Append(" ").Append(item.Code) }
                };
                throw new CustomException(CustomStatusCode.OverlapTarif, paramtrs);

            }
        }
        void CheckIfTheItemIsRelatedToAnyPriceButTheCurrentPrice(int idItem, int idCurrentPrice, IQueryable<Prices> otherPricesListFromDB = null)
        {
            IList<Prices> pricesRelatedToItem;
            if (otherPricesListFromDB != null)
            {
                otherPricesListFromDB = otherPricesListFromDB.Where(x => x.ItemPrices.Any(y => y.IdItem == idItem));

            }
            else
            {
                otherPricesListFromDB = GetAllModelsQueryable().Where(x => x.ItemPrices.Any(y => y.IdItem == idItem) && x.Id != idCurrentPrice);
            }

            pricesRelatedToItem = otherPricesListFromDB.Include(x => x.ItemPrices).ThenInclude(x => x.IdItemNavigation).ToList();
            if (pricesRelatedToItem.Any())
            {
                Item item = pricesRelatedToItem.Select(x => x.ItemPrices).FirstOrDefault(x => x.Any(y => y.IdItem == idItem)).FirstOrDefault(x => x.IdItem == idItem).IdItemNavigation;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "THE_ITEM",  new StringBuilder().Append(item.Description).Append(" ").Append(item.Code) }
                };
                throw new CustomException(CustomStatusCode.OverlapTarif, paramtrs);
            }
        }
        public void CheckIfItemIsAffectedToOtherPrice(ItemPricesViewModel model)
        {
            IList<TiersPricesViewModel> tiersOfCurrentPrice = _serviceTiersPrices.FindModelsByNoTracked(x => x.IdPrices == model.IdPrices);

            if (!tiersOfCurrentPrice.Any())// if no items
            {
                CheckIfTheItemIsRelatedToAnyPriceButTheCurrentPrice(model.IdItem, model.IdPrices);
            }
            else // There are items
            {
                IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != model.IdPrices);
                tiersOfCurrentPrice.ToList().ForEach(tier =>
                {
                    CheckIfACustomerItemCoupleDiscountIsRelatedToAnyPriceButTheCurrentPrice(tier.IdTiers, model.IdItem, model.IdPrices, pricesListFromDB);
                });
            }
        }
        /// <summary>
        /// Affect item to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public void AffectItemToPrice(ItemPricesViewModel model, string userMail)
        {
            IList<ItemPricesViewModel> modelToUnaffect = _serviceItemPrices.FindByAsNoTracking(x => x.IdPrices == model.IdPrices && x.IdItem == model.IdItem);
            if (modelToUnaffect.Any())
            {
                throw new CustomException(CustomStatusCode.AlreadyAffectedElement);
            }
            CheckIfItemIsAffectedToOtherPrice(model);
            _serviceItemPrices.AddModel(model, null, userMail);
        }
        /// <summary>
        /// Unaffect customer to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public void UnaffectCustomerFromPrice(TiersPricesViewModel model, string userMail)
        {
            if (!_entityRepoTiers.QuerableGetAll()
                .Where(x => x.TiersPrices.Any(y => y.IdPrices == model.IdPrices && y.IdTiers != model.IdTiers))
                .Select(x => x.Id).Any())
            {
                IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != model.IdPrices);
                _entityRepoItem.QuerableGetAll()
                .Where(x => x.ItemPrices.Any(y => y.IdPrices == model.IdPrices))
                .Select(x => x.Id)
                .ToList().ForEach(idItem =>
                {
                    CheckIfTheItemIsRelatedToAnyPriceButTheCurrentPrice(idItem, model.IdPrices, pricesListFromDB);
                });
            }
            IList<TiersPricesViewModel> modelToUnaffect = _serviceTiersPrices.FindByAsNoTracking(x => x.IdPrices == model.IdPrices && x.IdTiers == model.IdTiers);
            _serviceTiersPrices.BulkDeleteModelsPhysically(modelToUnaffect, userMail);
        }
        /// <summary>
        /// Unaffect item to price (discount)
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public void UnaffectItemFromPrice(ItemPricesViewModel model, string userMail)
        {
            if (!_entityRepoItem.QuerableGetAll()
                .Where(x => x.ItemPrices.Any(y => y.IdPrices == model.IdPrices && y.IdItem != model.IdItem))
                .Select(x => x.Id).Any())
            {
                IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != model.IdPrices);
                _entityRepoTiers.QuerableGetAll()
                .Where(x => x.TiersPrices.Any(y => y.IdPrices == model.IdPrices))
                .Select(x => x.Id)
                .ToList().ForEach(idTiers =>
                {
                    CheckIfTheCustomerIsRelatedToAnyPriceButTheCurrentPrice(idTiers, model.IdPrices, pricesListFromDB);
                });
            }
            IList<ItemPricesViewModel> modelToUnaffect = _serviceItemPrices.FindByAsNoTracking(x => x.IdPrices == model.IdPrices && x.IdItem == model.IdItem);
            _serviceItemPrices.BulkDeleteModelsPhysically(modelToUnaffect, userMail);
        }
        /// <summary>
        /// Prepare Tiers Predicate
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        PredicateFilterRelationViewModel<Tiers> PrepareTiersPredicate(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<Tiers, bool>> predicateWhere = PredicateUtility<Tiers>.PredicateFilter(predicateModel, key);
            Expression<Func<Tiers, object>>[] predicateRelations = PredicateUtility<Tiers>.PredicateRelation(predicateModel.Relation);
            return new PredicateFilterRelationViewModel<Tiers>(predicateWhere, predicateRelations);
        }
        PredicateFilterRelationViewModel<Item> PrepareItemPredicate(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<Item, bool>> predicateWhere = PredicateUtility<Item>.PredicateFilter(predicateModel, key);
            Expression<Func<Item, object>>[] predicateRelations = PredicateUtility<Item>.PredicateRelation(predicateModel.Relation);
            return new PredicateFilterRelationViewModel<Item>(predicateWhere, predicateRelations);
        }
        /// <summary>
        /// Affect all the cusomers to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public void AffectAllCustomersToPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail)
        {
            IList<TiersPricesViewModel> tiersPrices = new List<TiersPricesViewModel>();
            IList<int> affectedItemsIds = _entityRepoItem.QuerableGetAll()
                .Where(x => x.ItemPrices.Any(y => y.IdPrices == idPrice))
                .Select(x => x.Id)
                .ToList();

            IQueryable<Tiers> querybleResult = _entityRepoTiers.QuerableGetAll()
                .Where(x => x.IdTypeTiers == (int)TiersType.Customer && !x.TiersPrices.Any(y => y.IdPrices == idPrice)); // Affect only the not affected customers

            if (predicateModel != null)
            {
                PredicateFilterRelationViewModel<Tiers> filterPredicateFilterRelationModel = PrepareTiersPredicate(predicateModel);
                querybleResult = querybleResult.Where(filterPredicateFilterRelationModel.PredicateWhere);
            }

            IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != idPrice);
            querybleResult.Select(x => x.Id)
                .ToList().ForEach(idTiers =>
                {
                    if (!affectedItemsIds.Any())
                    {
                        CheckIfTheCustomerIsRelatedToAnyPriceButTheCurrentPrice(idTiers, idPrice, pricesListFromDB);
                    }
                    else
                    {
                        affectedItemsIds.ToList().ForEach(idItem =>
                        {
                            CheckIfACustomerItemCoupleDiscountIsRelatedToAnyPriceButTheCurrentPrice(idTiers, idItem, idPrice, pricesListFromDB);
                        });
                    }
                    tiersPrices.Add(new TiersPricesViewModel { IdPrices = idPrice, IdTiers = idTiers });
                });

            _serviceTiersPrices.BulkAdd(tiersPrices, userMail);
        }
        /// <summary>
        /// Affect all the items to the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public void AffectAllItemsToPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail)
        {
            IList<ItemPricesViewModel> itemPrices = new List<ItemPricesViewModel>();
            IList<int> affectedTiersIds = _entityRepoTiers.QuerableGetAll()
                .Where(x => x.TiersPrices.Any(y => y.IdPrices == idPrice))
                .Select(x => x.Id)
                .ToList();

            IQueryable<Item> querybleResult = _entityRepoItem.QuerableGetAll()
                .Where(x => !x.ItemPrices.Any(y => y.IdPrices == idPrice)); // Affect only the not affected items




            if (predicateModel != null && predicateModel.Filter != null && predicateModel.Filter.Any())
            {
                var tierFilter = predicateModel.Filter.Where(x => x.Prop == "IdTier").FirstOrDefault();
                var marqueFilter = predicateModel.Filter.Where(x => x.Prop == "IdProductItem").FirstOrDefault();
                var itemFilter = predicateModel.Filter.Where(x => x.Prop == "ItemName").FirstOrDefault();
                //Search item 
                querybleResult = querybleResult.Include(x => x.ItemTiers)
               .Where(x => (tierFilter != null ? (x.ItemTiers != null && x.ItemTiers.Any() && x.ItemTiers.Where(y => int.Parse(tierFilter.Value.ToString()) == y.IdTiers).Any()) : true) &&
                           (marqueFilter != null ? x.IdProductItem == int.Parse(marqueFilter.Value.ToString()) : true) &&
                           (itemFilter != null ? ((x.Code != null && x.Code.ToUpper().Contains(itemFilter.Value.ToString().ToUpper())) || (x.Description != null && x.Description.ToUpper().Contains(itemFilter.Value.ToString().ToUpper()))) : true))
                                     ;
            }





            IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != idPrice);
            List<int> listOfIdsItem = querybleResult.Select(x => x.Id).ToList();
            listOfIdsItem.ForEach(idItem =>
            {
                if (!affectedTiersIds.Any())
                {
                    CheckIfTheItemIsRelatedToAnyPriceButTheCurrentPrice(idItem, idPrice, pricesListFromDB);
                }
                else
                {
                    affectedTiersIds.ToList().ForEach(idTiers =>
                    {
                        CheckIfACustomerItemCoupleDiscountIsRelatedToAnyPriceButTheCurrentPrice(idTiers, idItem, idPrice, pricesListFromDB);
                    });
                }
                itemPrices.Add(new ItemPricesViewModel { IdPrices = idPrice, IdItem = idItem });
            });

            _serviceItemPrices.BulkAdd(itemPrices, userMail);
        }
        /// <summary>
        /// Unaffect all the cusomers from the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public void UnaffectAllCustomersFromPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail)
        {
            IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != idPrice);


            IQueryable<Tiers> querybleResult = _entityRepoTiers.QuerableGetAll()
                .Where(x => x.TiersPrices.Any(y => y.IdPrices == idPrice)); // Only the affected tiers

            if (predicateModel != null)
            {
                PredicateFilterRelationViewModel<Tiers> filterPredicateFilterRelationModel = PrepareTiersPredicate(predicateModel);
                querybleResult = querybleResult.Where(filterPredicateFilterRelationModel.PredicateWhere);
            }
            IList<int> allPriceTiersIdInPredicate = querybleResult.Select(x => x.Id).ToList();
            IList<int> allPriceTiersId = _entityRepoTiers.QuerableGetAll()
                .Where(x => x.TiersPrices.Any(y => y.IdPrices == idPrice)).Select(x => x.Id).ToList();

            if (allPriceTiersIdInPredicate.Count == allPriceTiersId.Count)
            {
                _entityRepoItem.QuerableGetAll()
                    .Where(x => x.ItemPrices.Any(y => y.IdPrices == idPrice))
                    .Select(x => x.Id)
                    .ToList().ForEach(idItem =>
                    {
                        CheckIfTheItemIsRelatedToAnyPriceButTheCurrentPrice(idItem, idPrice, pricesListFromDB);
                    });
            }


            IList<TiersPricesViewModel> modelsToUnaffect = _serviceTiersPrices
                .FindByAsNoTracking(x => x.IdPrices == idPrice && allPriceTiersIdInPredicate.Any(y => y == x.IdTiers)).ToList();
            _serviceTiersPrices.BulkDeleteModelsPhysically(modelsToUnaffect, userMail);
        }
        /// <summary>
        /// Unaffect all the items from the price (discount) by idPrice
        /// </summary>
        /// <param name="idPrice"></param>
        /// <returns></returns>
        public void UnaffectAllItemsFromPrice(PredicateFormatViewModel predicateModel, int idPrice, string userMail)
        {
            IQueryable<Prices> pricesListFromDB = GetAllModelsQueryable().Where(x => x.Id != idPrice);

            IQueryable<Item> querybleResult = _entityRepoItem.QuerableGetAll()
                .Where(x => x.ItemPrices.Any(y => y.IdPrices == idPrice)); // Only the affected items

            if (predicateModel != null)
            {
                PredicateFilterRelationViewModel<Item> filterPredicateFilterRelationModel = PrepareItemPredicate(predicateModel);
                querybleResult = querybleResult.Where(filterPredicateFilterRelationModel.PredicateWhere);
            }
            IList<int> allThePriceItemsIdInPredicate = querybleResult.Select(x => x.Id).ToList();
            IList<int> allThePriceItemsId = _entityRepoItem.QuerableGetAll()
                .Where(x => x.ItemPrices.Any(y => y.IdPrices == idPrice)).Select(x => x.Id).ToList();

            if (allThePriceItemsIdInPredicate.Count == allThePriceItemsId.Count) // The item list will be empty
            {
                _entityRepoTiers.QuerableGetAll()
                    .Where(x => x.TiersPrices.Any(y => y.IdPrices == idPrice))
                    .Select(x => x.Id)
                    .ToList().ForEach(idTiers =>
                    {
                        CheckIfTheCustomerIsRelatedToAnyPriceButTheCurrentPrice(idTiers, idPrice, pricesListFromDB);
                    });
            }

            IList<ItemPricesViewModel> modelsToUnaffect = _serviceItemPrices
                .FindByAsNoTracking(x => x.IdPrices == idPrice && allThePriceItemsIdInPredicate.Any(y => y == x.IdItem)).ToList();

            _serviceItemPrices.BulkDeleteModelsPhysically(modelsToUnaffect, userMail);
        }


        public List<DiscountForListViewModel> FindPriceDataSourceModelBy(List<PredicateFormatViewModel> predicateModel)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Prices> entities = null;
            PredicateFilterRelationViewModel<Prices> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
            }
            entities = entities.Include(x => x.ItemPrices.Take(10));
            entities = entities.Include(x => x.TiersPrices.Take(10));
            var total = entities.Count();
            if (predicateModelWithSpecificFilters.page > 0 && predicateModelWithSpecificFilters.pageSize > 0)
            {
                entities = entities.Skip((predicateModelWithSpecificFilters.page - 1) * predicateModelWithSpecificFilters.pageSize).Take(predicateModelWithSpecificFilters.pageSize);
            }


            List<Prices> pricesOfCurrentPage = entities.ToList();

            var iditems = pricesOfCurrentPage.SelectMany(x => x.ItemPrices).Select(x => x.IdItem).Distinct().ToList();
            var itemlist = _entityRepoItem.GetAllAsNoTracking().Where(x => iditems.Contains(x.Id));

            var idtiers = pricesOfCurrentPage.SelectMany(x => x.TiersPrices).Select(x => x.IdTiers).Distinct().ToList();
            var tierlist = _entityRepoTiers.GetAllAsNoTracking().Where(x => idtiers.Contains(x.Id));

            pricesOfCurrentPage.ForEach(
                x => x.ItemPrices.ToList().ForEach(z => z.IdItemNavigation = itemlist.FirstOrDefault(h => h.Id == z.IdItem)));

            pricesOfCurrentPage.ForEach(
               x => x.TiersPrices.ToList().ForEach(z => z.IdTiersNavigation = tierlist.FirstOrDefault(h => h.Id == z.IdTiers)));

            var predTiers = predicateModel[1].Filter.Where(x => x.Prop == "IdTiers").FirstOrDefault();
            bool isTiersFilter = predTiers != null ? true : false;
            if (isTiersFilter && predTiers.Value != null)
            {
                pricesOfCurrentPage = pricesOfCurrentPage.Where(x => x.TiersPrices != null && x.TiersPrices.Select(y => y.IdTiers).Contains(Convert.ToInt32(predTiers.Value))).ToList();
            }
            List<DiscountForListViewModel> pricesToList = new List<DiscountForListViewModel>();



            pricesOfCurrentPage.ForEach(element =>
            {
                List<string> typesLabels = GetPriceTypesLabels(element);

                pricesToList.Add(new DiscountForListViewModel
                {
                    Id = element.Id,
                    CodePrices = element.CodePrices,
                    TypesLabels = typesLabels,
                    IsActif = element.PriceDetail.Any(x => (DateTime.UtcNow.Date >= x.StartDateTime.Date && DateTime.UtcNow.Date <= x.EndDateTime.Date) ||
                    DateTime.UtcNow.Date < x.StartDateTime.Date),
                    State = element.PriceDetail.Any(x => (DateTime.UtcNow.Date >= x.StartDateTime.Date && DateTime.UtcNow.Date <= x.EndDateTime.Date) ||
                    DateTime.UtcNow.Date < x.StartDateTime.Date) ? "Actif" : "Inactif",
                    ListTypesLabels = typesLabels.Any() ? typesLabels.ToList().ConcatListElements(", ") : ""

                });
            });
            var predActif = predicateModel[1].Filter.Where(x => x.Prop == "IsActif").FirstOrDefault();
            bool isActifFilter = predActif != null ? true : false;
            if (isActifFilter && predActif.Value != null)
            {
                pricesToList = pricesToList.Where(x => x.IsActif != null && x.IsActif == Convert.ToBoolean(predActif.Value)).ToList();
            }
            var predType = predicateModel[1].Filter.Where(x => x.Prop == "ListTypesLabels").FirstOrDefault();
            bool isTypeFilter = predType != null ? true : false;
            if (isTypeFilter && predType.Value != null)
            {
                pricesToList = pricesToList.Where(x => x.ListTypesLabels != null && x.ListTypesLabels.Contains(Convert.ToString(predType.Value))).ToList();
            }
            return pricesToList;
        }

        private List<string> GetPriceTypesLabels(Prices price)
        {
            List<string> typesLabels = new List<string>();

            if (price.PriceDetail.Any(d => d.TypeOfPriceDetail == (int)DiscountType.Quantity))
            {
                typesLabels.Add(Constants.PURCHASED_QUANTITY);
            }
            if (price.PriceDetail.Any(d => d.TypeOfPriceDetail == (int)DiscountType.TotalPurchases))
            {
                typesLabels.Add(Constants.TOTAL_PURCHASES);
            }
            if (price.PriceDetail.Any(d => d.TypeOfPriceDetail == (int)DiscountType.SpecialPrice))
            {
                typesLabels.Add(Constants.SPECIAL_PRICE);
            }
            if (price.PriceDetail.Any(d => d.TypeOfPriceDetail == (int)DiscountType.GiftedItems))
            {
                typesLabels.Add(Constants.GIFTED_ITEMS);
            }

            return typesLabels;
        }
    }
}
