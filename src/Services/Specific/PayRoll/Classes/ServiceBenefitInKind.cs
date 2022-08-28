using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceBenefitInKind : Service<BenefitInKindViewModel, BenefitInKind>, IServiceBenefitInKind
    {
        private readonly IRepository<ContractBenefitInKind> _repositoryContractBenefitInKind;
        private readonly IRepository<Payslip> _repoPayslip;

        public ServiceBenefitInKind(IRepository<BenefitInKind> entityRepo,
             IRepository<Payslip> repoPayslip,
             IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IBenefitInKindBuilder builder,
             IRepository<ContractBenefitInKind> repositoryContractBenefitInKind,
             IEntityAxisValuesBuilder builderEntityAxisValues)
         : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _repositoryContractBenefitInKind = repositoryContractBenefitInKind;
            _repoPayslip = repoPayslip;
        }

        public override object UpdateModelWithoutTransaction(BenefitInKindViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            UpdateBenefitInKindAssociateWithPayslip(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        private void UpdateBenefitInKindAssociateWithPayslip(BenefitInKindViewModel model)
        {
            IList<Payslip> payslips = CheckIfBenefitInKindIsAssociatedWithAnyPayslip(model);
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(BenefitInKind)}
                    };
                    throw new CustomException(CustomStatusCode.CantUpdateEntityBecauseAnyPayslipIsUsedInClosedSesion, errorParams);
                }
                payslips = payslips.Select(x => { x.Status = (int)PayslipStatus.Wrong; return x; }).ToList();
                _repoPayslip.BulkUpdate(payslips);
                _unitOfWork.Commit();
            }
        }

        public IList<Payslip> CheckIfBenefitInKindIsAssociatedWithAnyPayslip(BenefitInKindViewModel model)
        {
            List<Payslip> payslips = new List<Payslip>();
            BenefitInKindViewModel benefitInKindBeforeUpdate = GetModelAsNoTracked(x => x.Id == model.Id);
            if (!new BenefitInKindComparer().Equals(model, benefitInKindBeforeUpdate))
            {
                payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => x.PayslipDetails.Any(d => d.IdBenefitInKind == model.Id), x => x.IdSessionNavigation).ToList();
            }
            return payslips;
        }


        /// <summary>
        /// Return list of benefitInKind from idContract
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public IList<BenefitInKindViewModel> GetAvailableBenefitInKindOfContract(int idContract, DateTime month)
        {
            DateTime date = month.LastDateOfMonth();
            // Retrieve the association table list of ContractBenefitInKind that are associated with the current contract and validitydate is great than payslipStarDate
            IList<ContractBenefitInKind> contractBenefitInKind = _repositoryContractBenefitInKind.FindByAsNoTracking(cb => cb.IdContract == idContract 
                && cb.ValidityStartDate.BeforeDateLimitIncluded(date.LastDateOfMonth()) &&
                 (cb.ValidityEndDate.HasValue && cb.ValidityEndDate.Value.AfterDateLimitIncluded(month) || !cb.ValidityEndDate.HasValue)).ToList();
            // Define new List of bonus for contain the collection
            IList<BenefitInKindViewModel> benefitInKindViewModels = FindModelsByNoTracked(sr => contractBenefitInKind.Any(x => x.IdBenefitInKind == sr.Id), x => x.IdCnssNavigation).ToList();
            return benefitInKindViewModels;
        }
    }
}
