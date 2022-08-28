using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class TransferOrderBuilder: GenericBuilder<TransferOrderViewModel, TransferOrder>, ITransferOrderBuilder
    {
        private readonly IBankBuilder _bankBuilder;
        private readonly ITransferOrderDetailsBuilder _transferOrderDetailsBuilder;
        private readonly ITransferOrderSessionBuilder _transferOrderSessionBuilder;

        public TransferOrderBuilder(IBankBuilder bankBuilder, ITransferOrderDetailsBuilder transferOrderDetailsBuilder, ITransferOrderSessionBuilder transferOrderSessionBuilder)
        {
            _bankBuilder = bankBuilder;
            _transferOrderDetailsBuilder = transferOrderDetailsBuilder;
            _transferOrderSessionBuilder = transferOrderSessionBuilder;
        }

        public override TransferOrderViewModel BuildEntity(TransferOrder entity)
        {
            TransferOrderViewModel model = base.BuildEntity(entity);
            if (model.IdBankAccountNavigation != null && entity.IdBankAccountNavigation.IdBankNavigation != null)
            {
                model.IdBankAccountNavigation.IdBankNavigation = _bankBuilder.BuildEntity(entity.IdBankAccountNavigation.IdBankNavigation);
            }
            model.TransferOrderDetails = entity.TransferOrderDetails.Select(_transferOrderDetailsBuilder.BuildEntity).ToList();
            model.TransferOrderSession = entity.TransferOrderSession.Select(_transferOrderSessionBuilder.BuildEntity).ToList();
            return model;
        }
    }
}
