﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Interfaces
{
    public interface IWithholdingTaxBuilder : IBuilder<WithholdingTaxViewModel, WithholdingTax>
    {
    }
}
