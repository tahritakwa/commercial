using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceConstantValue : IService<ConstantValueViewModel, ConstantValue>
    {
        double ReplaceConstantValue(int idForeignReference, DateTime month);
    }
}
