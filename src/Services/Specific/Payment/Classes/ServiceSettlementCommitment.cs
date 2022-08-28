using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{

    public class ServiceSettlementCommitment : Service<SettlementCommitmentViewModel, SettlementCommitment>, IServiceSettlementCommitment
    {
        internal readonly IRepository<FinancialCommitment> _commitmentRepo;
        internal readonly ISettlementCommitmentBuilder _builderSettlementCommitment;

        internal readonly IRepository<User> _entityRepoUser;
        internal readonly IRepository<Settlement> _entityRepoSettlement;

        public ServiceSettlementCommitment(IRepository<SettlementCommitment> entityRepo, IUnitOfWork unitOfWork,
           IRepository<User> entityRepoUser,
           ISettlementCommitmentBuilder builder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification, IRepository<FinancialCommitment> commitmentRepo, IRepository<Settlement> entityRepoSettlement)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _builderSettlementCommitment = builder;
            _entityRepoUser = entityRepoUser;
            _commitmentRepo = commitmentRepo;
            _entityRepoSettlement = entityRepoSettlement;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IEnumerable<SettlementCommitmentViewModel> GetCommitmentForAddOperation(PredicateFormatViewModel predicateModel)
        {
            IList<SettlementCommitmentViewModel> settlementCommitment;
            try
            {
                Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
                Expression<Func<FinancialCommitment, bool>> predicateWhere = PredicateUtility<FinancialCommitment>.PredicateFilter(predicateModel, key);
                Expression<Func<FinancialCommitment, object>>[] predicateRelations = PredicateUtility<FinancialCommitment>.PredicateRelation(predicateModel.Relation);
                IList<FinancialCommitment> entities = _commitmentRepo.GetAllWithConditionsRelations(predicateWhere, predicateRelations).ToList();

                settlementCommitment = entities.Select(_builderSettlementCommitment.BuildFinancialEntity).ToList();
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
            return settlementCommitment;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IEnumerable<SettlementCommitmentViewModel> GetCommitmentForUpdateOperation(PredicateFormatViewModel predicateModel)
        {
            List<SettlementCommitmentViewModel> settlementCommitment;
            try
            {
                object settlementId = predicateModel.Filter.ToList().Where(p => p.Prop == Constants.SETTLEMENT_SETTLEMENTID).FirstOrDefault().Value;
                // get settlement
                Settlement settlement = _entityRepoSettlement.FindBy(p => p.Id == (int)settlementId).FirstOrDefault();
                //
                Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
                /*********************************get commitments of the current settlement*************************************/
                PredicateFormatViewModel settlementPredicate = new PredicateFormatViewModel();
                Expression<Func<SettlementCommitment, bool>> settlementPredicateWhere = PredicateUtility<SettlementCommitment>.PredicateFilter(predicateModel, key);
                settlementPredicate.Relation = new List<RelationViewModel> { new RelationViewModel { Prop = Constants.COMMITMENT } };
                settlementPredicate.Relation.Add(new RelationViewModel { Prop = Constants.COMMITMENT_RELATION_IDDOCUMENT });
                settlementPredicate.Relation.Add(new RelationViewModel { Prop = Constants.COMMITMENT_RELATION_IDSTATUS });
                Expression<Func<SettlementCommitment, object>>[] settlementPredicateRelations = PredicateUtility<SettlementCommitment>.PredicateRelation(settlementPredicate.Relation);
                settlementCommitment = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(settlementPredicateWhere, settlementPredicateRelations).Select(_builder.BuildEntity).ToList();
                settlementCommitment.ToList().ForEach(p => p.IsChecked = true);

                /*********************************get new commitments of the current user***************************************/
                PredicateFormatViewModel financialCommitmentPredicate = new PredicateFormatViewModel
                {

                    // tiers filter
                    Filter = new List<FilterViewModel> { new FilterViewModel { Prop = Constants.RELATION_IDDOCUMENT_IDTIERS, Value = settlement.IdTiers, Type = ((int)TypeCode.Int32) } }
                };
                // amount filter 
                financialCommitmentPredicate.Filter.Add(new FilterViewModel { Prop = Constants.REMAINING_AMOUNT_WITH_CURRENCY, Value = 0, Operation = Operation.GreaterThan });
                // status filter
                financialCommitmentPredicate.Filter.Add(new FilterViewModel { Prop = Constants.ID_STATUS, Value = (int)DocumentStatusEnumerator.Valid });

                //relation 
                financialCommitmentPredicate.Relation = predicateModel.Relation;

                // recuperate new commitments
                Expression<Func<FinancialCommitment, bool>> predicateWhere = PredicateUtility<FinancialCommitment>.PredicateFilter(financialCommitmentPredicate, key);
                Expression<Func<FinancialCommitment, object>>[] predicateRelations = PredicateUtility<FinancialCommitment>.PredicateRelation(financialCommitmentPredicate.Relation);
                List<FinancialCommitment> financialCommitments = _commitmentRepo.GetAllWithConditionsRelationsAsNoTracking(predicateWhere, predicateRelations).ToList();

                // add new commitments to the list
                List<int> settlementCommitmentId = settlementCommitment.Select(p => p.CommitmentId).ToList();
                List<SettlementCommitmentViewModel> newFinancialCommitment = financialCommitments.Where(p => !settlementCommitmentId.Contains(p.Id))
                    .Select(_builderSettlementCommitment.BuildFinancialEntity).ToList();

                settlementCommitment.AddRange(newFinancialCommitment);
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

            return settlementCommitment;
        }

    }
}
