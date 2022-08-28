using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class ReducedSettlementBuilder : GenericBuilder<ReducedSettlementViewModel, Settlement>, IReducedSettlementBuilder
    {
        public ReducedSettlementBuilder()
        {
        }

        #region Methodes
        public override ReducedSettlementViewModel BuildEntity(Settlement entity)
        {
            if (entity == null)
            {
                throw new Exception();
            }

            ReducedSettlementViewModel model = base.BuildEntity(entity);

            if (entity.IdTiersNavigation != null)
            {
                model.TiersName = entity.IdTiersNavigation.Name;
                model.IdTypeTiers = entity.IdTiersNavigation.IdTypeTiers;
            }
            if (entity.IdUsedCurrencyNavigation != null)
            {
                model.Precision = entity.IdUsedCurrencyNavigation.Precision;
                model.CurrencyCode = entity.IdUsedCurrencyNavigation.Code;
            }
            if (entity.IdPaymentSlipNavigation != null)
            {
                model.PaymentSlipReference = entity.IdPaymentSlipNavigation.Reference;
                model.PaymentSlipReconciliationDate = entity.IdPaymentSlipNavigation.Date;
            }
            return model;
        }
        #endregion
    }
}
