using Persistence.CatalogEntities;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class DocumentBuilder : GenericBuilder<DocumentViewModel, Document>, IDocumentBuilder
    {
        #region Fields
        private readonly IDocumentLineBuilder _documentLineBuilder;
        private readonly IClaimBuilder _claimBuilder;
        private readonly ITiersBuilder _tiersBuilder;
        private readonly ICurrencyBuilder _currencyBuilder;
        private readonly IFinancialCommitmentBuilder _financialCommitmentBuilder;
        private readonly IDocumentWithholdingTaxBuilder _documentWithholdingTaxBuilder;
        private readonly IDocumentTaxsResumeBuilder _documentTaxsResumeBuilder;

        #endregion
        public DocumentBuilder(IDocumentLineBuilder documentLineBuilder, IClaimBuilder claimBuilder, ITiersBuilder tiersBuilder, ICurrencyBuilder currencyBuilder,
            IFinancialCommitmentBuilder financialCommitmentBuilder, IDocumentWithholdingTaxBuilder documentWithholdingTaxBuilder,
            IDocumentTaxsResumeBuilder documentTaxsResumeBuilder)
        {
            _documentLineBuilder = documentLineBuilder;
            _claimBuilder = claimBuilder;
            _tiersBuilder = tiersBuilder;
            _currencyBuilder = currencyBuilder;
            _financialCommitmentBuilder = financialCommitmentBuilder;
            _documentWithholdingTaxBuilder = documentWithholdingTaxBuilder;
            _documentTaxsResumeBuilder = documentTaxsResumeBuilder;

        }
        #region Methodes
        public override Document BuildModel(DocumentViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model != null && model.DocumentLine != null)
            {
                entity.DocumentLine = model.DocumentLine.Select(c => _documentLineBuilder.BuildModel(c)).ToList();
            }
            if (model != null && model.DocumentTaxsResume != null)
            {
                entity.DocumentTaxsResume = model.DocumentTaxsResume.Select(c => _documentTaxsResumeBuilder.BuildModel(c)).ToList();
            }
            if (model != null && model.CreationDate is null)
            {
                entity.CreationDate = DateTime.Now;
            }
            return entity;
        }

        public override DocumentViewModel BuildEntity(Document entity)
        {
            var document = base.BuildEntity(entity);
            if (document != null)
            {
                if (entity != null && entity.DocumentLine != null)
                {
                    document.DocumentLine = entity.DocumentLine.Select(c => _documentLineBuilder.BuildEntity(c)).ToList();
                }

                if (entity != null && entity.ClaimIdSalesAssetDocumentNavigation != null && entity.ClaimIdSalesAssetDocumentNavigation.Count > 0)
                {
                    document.ClaimIdAssetDocumentNavigation = entity.ClaimIdSalesAssetDocumentNavigation.Select(c => _claimBuilder.BuildEntity(c)).ToList();
                }

                if (entity != null && entity.ClaimIdPurchaseAssetDocumentNavigation != null && entity.ClaimIdPurchaseAssetDocumentNavigation.Count > 0)
                {
                    document.ClaimIdAssetDocumentNavigation = entity.ClaimIdPurchaseAssetDocumentNavigation.Select(c => _claimBuilder.BuildEntity(c)).ToList();
                }
                if (entity != null && entity.IdTiersNavigation != null)
                {
                    document.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.IdTiersNavigation);
                }
                if (entity != null && entity.IdUsedCurrencyNavigation != null)
                {
                    document.FormatOption = new NumberFormatOptionsViewModel
                    {
                        style = Constants.STYLE_CURRENCY,
                        currency = document.IdUsedCurrencyNavigation.Code,
                        currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                        minimumFractionDigits = document.IdUsedCurrencyNavigation.Precision
                    };
                }
                if (entity != null && entity.FinancialCommitment != null && entity.FinancialCommitment.Count > 0)
                {
                    document.FinancialCommitment = entity.FinancialCommitment.Select(c => _financialCommitmentBuilder.BuildEntity(c)).ToList();
                }
                if (entity != null && entity.DocumentWithholdingTax != null)
                {
                    document.DocumentWithholdingTax = entity.DocumentWithholdingTax.Select(c => _documentWithholdingTaxBuilder.BuildEntity(c)).ToList();
                }
                if (entity != null && entity.DocumentTaxsResume != null)
                {
                    document.DocumentTaxsResume = entity.DocumentTaxsResume.Select(c => _documentTaxsResumeBuilder.BuildEntity(c)).ToList();
                }
            }
            return document;
        }

        public DocumentListViewModel BuildDocument(Document x)
        {
            return new DocumentListViewModel
            {
                Id = x.Id,
                IdUsedCurrency = x.IdUsedCurrency,
                DocumentDate = x.DocumentDate,
                Code = x.Code,
                DocumentHtpriceWithCurrency = x.DocumentHtpriceWithCurrency,
                DocumentTtcpriceWithCurrency = x.DocumentTtcpriceWithCurrency,
                InoicingType = x.InoicingType,
                IdDocumentStatus = x.IdDocumentStatus,
                IsDeliverySuccess = x.IsDeliverySuccess,
                DocumentTypeCode = x.DocumentTypeCode,
                IsBToB = x.IsBtoB,
                ProvisionalCode = x.ProvisionalCode,
                IdInvoiceEcommerce = x.IdInvoiceEcommerce,
                FormatOption = x.IdUsedCurrencyNavigation != null ? new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = x.IdUsedCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = x.IdUsedCurrencyNavigation.Precision
                } : null,



                IdTiersNavigation = x.IdTiersNavigation != null ? new IdTiersNavigation
                {
                    Name = x.IdTiersNavigation.Name,
                    Region = x.IdTiersNavigation.Region
                } : null,
                IdCreatorNavigation = new IdCreatorNavigation
                {
                    FullName = x.IdCreatorNavigation != null ? x.IdCreatorNavigation.FullName : "",
                },
                IdDocumentStatusNavigation = x.IdDocumentStatusNavigation != null ? new IdDocumentStatusNavigation
                {
                    Label = x.IdDocumentStatusNavigation.Label,
                } : null


            };
        }


        public DocumentAssociatedGeneratedViewModel BuildDocumentAssociatedGenerated(Document x)
        {
            return new DocumentAssociatedGeneratedViewModel
            {
                Id = x.Id,
                Code = x.Code,
                IdDocumentStatus = x.IdDocumentStatus,
                DocumentTypeCode = x.DocumentTypeCode,
                DocumentDate = x.DocumentDate,
                DocumentHtpriceWithCurrency = x.DocumentHtpriceWithCurrency,
                DocumentTtcpriceWithCurrency = x.DocumentTtcpriceWithCurrency,
                IsRestaurn = x.IsRestaurn,
                TierRegion = x.IdTiersNavigation != null ? x.IdTiersNavigation.Region : "",
                TierName = x.IdTiersNavigation != null ? x.IdTiersNavigation.Name : "",
                StatusLabel = x.IdDocumentStatusNavigation != null ? x.IdDocumentStatusNavigation.Label : "",
                FormatOption = x.IdUsedCurrencyNavigation != null ? new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = x.IdUsedCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = x.IdUsedCurrencyNavigation.Precision
                } : (x.IdTiersNavigation.IdCurrencyNavigation != null ? new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = x.IdTiersNavigation.IdCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = x.IdTiersNavigation.IdCurrencyNavigation.Precision
                } : null),
                IsDeliverySuccess = x.IsDeliverySuccess,

            };
        }

        public ReducedDocumentList BuildEntityToReducedList(Document entity, List<StockMovement> listStockMovement, List<MasterUserViewModel> users = null, List<UsersBtob> usersBtob = null)
        {
            List<StockMovement> currentListStockMvt = listStockMovement.Where(x => x.IdDocumentLineNavigation.IdDocument == entity.Id).ToList();
            return new ReducedDocumentList()
            {
                Id = entity.Id,
                NameTiers = entity.IdTiersNavigation != null ? entity.IdTiersNavigation.Name : "",
                IdTiers = entity.IdTiers,
                DocumentDate = entity.DocumentDate,
                Code = entity.Code,
                DocumentHtpriceWithCurrency = entity.DocumentHtpriceWithCurrency,
                DocumentTtcpriceWithCurrency = entity.DocumentTtcpriceWithCurrency,
                InoicingType = entity.InoicingType,
                DocumentStatus = entity.IdDocumentStatusNavigation != null ? entity.IdDocumentStatusNavigation.Label : "",
                CreatorName = (usersBtob != null && usersBtob.Any(x => x.Id == entity.IdCreatorBtob)) ? usersBtob.Where(x => x.Id == entity.IdCreatorBtob).FirstOrDefault().FullName
                : (entity.IdCreatorNavigation != null ? entity.IdCreatorNavigation.FullName : ""),
                Region = entity.IdTiersNavigation != null ? entity.IdTiersNavigation.Region : "",
                PictureUrlTiers = entity.IdTiersNavigation != null ? entity.IdTiersNavigation.UrlPicture : null,
                IdDocumentStatus = entity.IdDocumentStatus,
                //ColorDocumentStatus= entity.IdDocumentStatusNavigation != null ? entity.IdDocumentStatusNavigation.col : "",
                ProvisionalCode = entity.ProvisionalCode,
                DocumentTypeCode = entity.DocumentTypeCode,
                IsDeliverySuccess = entity.IsDeliverySuccess,
                IsFromGarage = entity.IsFromGarage,
                haveClaim = (entity.ClaimIdSalesAssetDocumentNavigation != null && entity.ClaimIdSalesAssetDocumentNavigation.Any() ||
                 entity.ClaimIdPurchaseAssetDocumentNavigation != null && entity.ClaimIdPurchaseAssetDocumentNavigation.Any()) ?
                 true : false,
                CodeCurrency = entity.IdUsedCurrencyNavigation != null ? entity.IdUsedCurrencyNavigation.Code : "",
                PrecisionCurrency = entity.IdUsedCurrencyNavigation != null ? entity.IdUsedCurrencyNavigation.Precision : 0,
                IsBToB = entity.IsBtoB,
                IsSynchronizedBToB = entity.IsSynchronizedBtoB,
                IsForPos = entity.IsForPos,
                haveReservedLines = currentListStockMvt != null && currentListStockMvt.Any() ? true : false,
                IdInvoiceEcommerce = entity.IdInvoiceEcommerce,
                ValidatorName = entity.IdValidatorNavigation != null ? entity.IdValidatorNavigation.FullName : "",
                ItemName = entity.DocumentLine != null && entity.DocumentLine.Any() && entity.DocumentLine.First().IdItemNavigation != null ?
                            entity.DocumentLine.First().IdItemNavigation.Code + "-" + entity.DocumentLine.First().IdItemNavigation.Description : "",
                IdCreator = (entity.IdCreatorNavigation != null && users != null && users.Any(x => x.Email == entity.IdCreatorNavigation.Email)) ? users.Where(x => x.Email == entity.IdCreatorNavigation.Email).FirstOrDefault().Id :
                (entity.IdCreatorNavigation != null ? entity.IdCreatorNavigation.Id : null),
                IdSalesDepositInvoice = entity != null && entity.IdSalesDepositInvoice != null ? entity.IdSalesDepositInvoice : null,
                IdSessionCounterSalesState = entity.IdSessionCounterSalesNavigation != null? entity.IdSessionCounterSalesNavigation.State : null
            };
        }

        public DocumentViewModel BuildDocumentEntity(Document entity)
        {
            return base.BuildEntity(entity);
        }

        #endregion
    }

}
