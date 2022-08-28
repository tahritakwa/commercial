using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceContractType : Service<ContractTypeViewModel, ContractType>, IServiceContractType
    {

        public ServiceContractType(IRepository<ContractType> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IContractTypeBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        { }

        public override object AddModelWithoutTransaction(ContractTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckContractTypeValidity(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check contract type validity
        /// </summary>
        /// <param name="contractType"></param>
        private void CheckContractTypeValidity (ContractTypeViewModel contractType)
        {
            Regex r = new Regex(@"^[a-zA-Z]+$");
            if (!r.IsMatch(contractType.Code))
            {
                throw new CustomException(CustomStatusCode.ContractTypeCodeViolation);
            }
            if (contractType.MinNoticePeriod > contractType.MaxNoticePeriod)
            {
                throw new CustomException(CustomStatusCode.ContractTypeMinMaxViolation);
            }
        }

        public override object UpdateModelWithoutTransaction(ContractTypeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckContractTypeValidity(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
