using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class PaymentSlipBuilder : GenericBuilder<PaymentSlipViewModel, PaymentSlip>, IPaymentSlipBuilder
    {
        private readonly IBankAccountBuilder _bankAccountBuilder;

        public PaymentSlipBuilder(IBankAccountBuilder bankAccountBuilder)
        {
            _bankAccountBuilder = bankAccountBuilder;
        }
        public override PaymentSlipViewModel BuildEntity(PaymentSlip entity)
        {
            if (entity == null)
            {
                throw new Exception();
            }
            PaymentSlipViewModel model = base.BuildEntity(entity);
            if (entity.IdBankAccountNavigation != null)
            {
                model.IdBankAccountNavigation = _bankAccountBuilder.BuildEntity(entity.IdBankAccountNavigation);
            }
            return model;
        }
    }
}
