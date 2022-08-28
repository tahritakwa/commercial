﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class PaymentTypeBuilder : GenericBuilder<PaymentTypeViewModel, PaymentType>, IPaymentTypeBuilder
    {
    }
}
