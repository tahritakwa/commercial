using ModelView.Payment;
using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class SettlementBuilder : GenericBuilder<SettlementViewModel, Settlement>, ISettlementBuilder
    {
        #region Fields
        private readonly ISettlementCommitmentBuilder _settlementCommitementBuilder;
        private readonly ISettlementDocumentWithholdingTaxBuilder _settlementDocumentWithholdingTax;
        private readonly IBankAccountBuilder _bankAccountBuilder;
        private readonly IPaymentMethodBuilder _paymentMethodBuilder;
        #endregion
        public SettlementBuilder(ISettlementCommitmentBuilder settlementCommitementBuilder,
            ISettlementDocumentWithholdingTaxBuilder settlementDocumentWithholdingTax,
            IPaymentMethodBuilder paymentMethodBuilder, IBankAccountBuilder bankAccountBuilder)
        {
            _settlementCommitementBuilder = settlementCommitementBuilder;
            _paymentMethodBuilder = paymentMethodBuilder;
            _bankAccountBuilder = bankAccountBuilder;
            _settlementDocumentWithholdingTax = settlementDocumentWithholdingTax;
        }
        #region Methodes
        public override Settlement BuildModel(SettlementViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.SettlementCommitment != null)
            {
                var a = model.SettlementCommitment
                     .Select(c => _settlementCommitementBuilder.BuildModel(c));
                var b = a.ToList();
                entity.SettlementCommitment = b;
            }

            return entity;
        }

        public override SettlementViewModel BuildEntity(Settlement entity)
        {
            SettlementViewModel model = base.BuildEntity(entity);
            if (entity.IdPaymentMethodNavigation != null)
            {
                model.IdPaymentMethodNavigation = _paymentMethodBuilder.BuildEntity(entity.IdPaymentMethodNavigation);
            }
            if (entity.IdBankAccountNavigation != null)
            {
                model.IdBankAccountNavigation = _bankAccountBuilder.BuildEntity(entity.IdBankAccountNavigation);
            }
            if (entity.SettlementCommitment != null)
            {
                model.SettlementCommitment = entity.SettlementCommitment
                     .Select(c => _settlementCommitementBuilder.BuildEntity(c))
                     .ToList();
            }
            if(entity.SettlementDocumentWithholdingTax != null)
            {
                model.SettlementDocumentWithholdingTax = entity.SettlementDocumentWithholdingTax
                     .Select(c => _settlementDocumentWithholdingTax.BuildEntity(c)).ToList();
            }
            return model;
        }
        public ReducedSettlementList BuildEntityToReducedList(Settlement entity)
        {
            SettlementViewModel model = BuildEntity(entity);
            ReducedSettlementList reducedSettlementList = new ReducedSettlementList()
            {
                Id = model.Id,
                TiersName = model.IdTiersNavigation != null ? model.IdTiersNavigation.Name : "",
                IdTypeTiers = model.IdTiersNavigation.IdTypeTiers,
                IdPaymentSlip = model.IdPaymentSlip != null ? model.IdPaymentSlip.Value : (int?)null,
                IdReconciliation = model.IdReconciliation != null ? model.IdReconciliation.Value : (int?)null,
                MethodName = model.IdPaymentMethodNavigation != null ? model.IdPaymentMethodNavigation.MethodName : "",
                Code = model.Code,
                Label = model.Label,
                SettlementReference = model.SettlementReference,
                WithholdingTax = model.WithholdingTax,
                IdPaymentStatus = model.IdPaymentStatus != null ? model.IdPaymentStatus.Value : (int?)null,
                Precision = model.IdUsedCurrencyNavigation.Precision,
                CurrencyCode = model.IdUsedCurrencyNavigation.Code,
                AmountWithCurrency = model.AmountWithCurrency,
                CommitmentDate = model.CommitmentDate != null ? model.CommitmentDate.Value : (DateTime?)null,
                SettlementDate = model.SettlementDate,
                IssuingBank = model.IssuingBank,
                PaymentMethodCode = model.IdPaymentMethodNavigation.Code,
                Holder = model.Holder,
                Rib = model.IdBankAccountNavigation != null ? model.IdBankAccountNavigation.Rib : "",
                Agency = model.IdBankAccountNavigation != null ? model.IdBankAccountNavigation.Agency : "",
                BankName = model.IdBankAccountNavigation != null ? model.IdBankAccountNavigation.IdBankNavigation.Name : "",
                WithholdingTaxObservationsFilesInfo = model.WithholdingTaxObservationsFilesInfo,
                HasBeenReplaced = model.HasBeenReplaced,
                IdBankAccount = model.IdBankAccount != null ? model.IdBankAccount.Value : (int?)null,
                IdTiers = model.IdTiers,
                FilesInfos = model.FilesInfos,
                WithholdingTaxAttachmentUrl = model.WithholdingTaxAttachmentUrl,
                ObservationsFilesInfo = model.ObservationsFilesInfo,
                Immediate = model.IdPaymentMethodNavigation.Immediate,
                AttachmentUrl = model.AttachmentUrl

            };
      
            return reducedSettlementList;
        }

        #endregion
    }
}
