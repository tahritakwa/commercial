using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceConstantRate : IService<ConstantRateViewModel, ConstantRate>
    {
        Dictionary<string, double> ReplaceConstantRate(int IdForeignReference, DateTime month);
    }
}
