using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class CashRegisterBuilder : GenericBuilder<CashRegisterViewModel, CashRegister>, ICashRegisterBuilder
    {

        public override CashRegisterViewModel BuildEntity(CashRegister entity)
        {
            var cashRegister =  base.BuildEntity(entity);

            if(entity != null && entity.IdParentCashNavigation != null)
            {
                cashRegister.IdParentCashNavigation = BuildEntity(entity.IdParentCashNavigation);
            }
            return cashRegister;
        }
    }
}
