using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class SettlementCommitmentBuilder : GenericBuilder<SettlementCommitmentViewModel, SettlementCommitment>, ISettlementCommitmentBuilder
    {
        #region Fields
        private readonly IFinancialCommitmentBuilder _financialCommitmentBuilder;
        private readonly ITiersBuilder _tiersBuilder;
        private readonly IDocumentBuilder _documentBuilder;
        #endregion
        public SettlementCommitmentBuilder(IFinancialCommitmentBuilder financialCommitmentBuilder, ITiersBuilder tiersBuilder, IDocumentBuilder documentBuilder)
        {
            _financialCommitmentBuilder = financialCommitmentBuilder;
            _tiersBuilder = tiersBuilder;
            _documentBuilder = documentBuilder;
        }
        #region Methodes
        public SettlementCommitmentViewModel BuildFinancialEntity(FinancialCommitment entity)
        {
            SettlementCommitmentViewModel settlementCommitmentViewModel = new SettlementCommitmentViewModel();
            var model = _financialCommitmentBuilder.BuildEntity(entity);
            settlementCommitmentViewModel.Commitment = model;
            settlementCommitmentViewModel.CommitmentId = model.Id;
            return settlementCommitmentViewModel;
        }

        public override SettlementCommitmentViewModel BuildEntity(SettlementCommitment entity)
        {
            var model = base.BuildEntity(entity);
            if (entity.Commitment != null)
            {
                model.Commitment = _financialCommitmentBuilder.BuildEntity(entity.Commitment);
            }
            if(entity.Settlement.IdTiersNavigation != null)
            {
                model.Settlement.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.Settlement.IdTiersNavigation);
            }
            return model;
        }

        public override SettlementCommitment BuildModel(SettlementCommitmentViewModel model)
        {
            var entity = base.BuildModel(model);
            if(model.Commitment != null && model.Commitment.IdDocumentNavigation != null)
            {
                entity.Commitment.IdDocumentNavigation = _documentBuilder.BuildModel(model.Commitment.IdDocumentNavigation);
            }
            
            return entity;
        }
        #endregion
    }
}
