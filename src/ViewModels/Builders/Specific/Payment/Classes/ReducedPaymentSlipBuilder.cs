using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class ReducedPaymentSlipBuilder : GenericBuilder<ReducedPaymentSlipViewModel, PaymentSlip>, IReducedPaymentSlipBuilder
    {
        public ReducedPaymentSlipBuilder()
        {
        }
        public override ReducedPaymentSlipViewModel BuildEntity(PaymentSlip entity)
        {
            if (entity == null)
            {
                throw new Exception();
            }
            ReducedPaymentSlipViewModel model = base.BuildEntity(entity);
            if (entity.IdBankAccountNavigation != null && entity.IdBankAccountNavigation.IdBankNavigation != null)
            {
                model.BankName = entity.IdBankAccountNavigation.IdBankNavigation.Name;
            }
            return model;
        }
    }
}
