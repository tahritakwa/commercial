﻿using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServicePaymentMethod : IService<PaymentMethodViewModel, PaymentMethod>
    {
    }
}
