using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceCnssDeclarationDetails : Service<CnssDeclarationDetailsViewModel, CnssDeclarationDetails>, IServiceCnssDeclarationDetails
    {
        private readonly IServiceEmployeeDocument _serviceEmployeeDocument;

        public ServiceCnssDeclarationDetails(IServiceEmployeeDocument serviceEmployeeDocument, IRepository<CnssDeclarationDetails> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ICnssDeclarationDetailsBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceEmployeeDocument = serviceEmployeeDocument;
        }

        /// <summary>
        /// Get the specific Cnss declaration lines for reporting purposes mainly
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        public IList<CnssDeclarationLinesViewModel> GetCnssDeclarationLines(int IdCnssDeclaration)
        {
            IList<CnssDeclarationLinesViewModel> cnssDeclarationLinesViewModels = new List<CnssDeclarationLinesViewModel>();
            // Get Cnss declaration lines order by NUmberOrder with their employee navigation
            var cnssDeclarationDetailsViewModel = GetModelsWithConditionsRelations(model =>
                model.IdCnssDeclaration.Equals(IdCnssDeclaration),
                model => model.IdEmployeeNavigation).ToList();
            // If this Cnss declaration haven't any details, throw argument exception
            if (cnssDeclarationDetailsViewModel == null || !cnssDeclarationDetailsViewModel.Any())
            {
                throw new ArgumentException("");
            }
            // For each details, create reporting line with appropriate informations
            foreach (CnssDeclarationDetailsViewModel detail in cnssDeclarationDetailsViewModel)
            {
                string identityPiece = detail.IdEmployeeNavigation.Cin;
                if (string.IsNullOrEmpty(identityPiece))
                {
                    var value = _serviceEmployeeDocument.FindModelBy(model => model.IdEmployee.Equals(detail.IdEmployeeNavigation.Id)
                        && model.Type.Equals(NumberConstant.One)).ToList();
                    identityPiece = value.Any() ? value.FirstOrDefault().Value : string.Empty;
                }
                cnssDeclarationLinesViewModels.Add(new CnssDeclarationLinesViewModel
                {
                    PageNumber = detail.PageNumber,
                    NumberOrder = detail.NumberOrder,
                    Category = detail.IdEmployeeNavigation.Category,
                    EmployeeCnssNumber = detail.IdEmployeeNavigation.SocialSecurityNumber,
                    EmployeeFullName = detail.IdEmployeeNavigation.FullName,
                    IdentityPiece = identityPiece,
                    EmployeeResignationNumber = detail.IdEmployeeNavigation.Matricule,
                    FirstMonthValue = detail.FirstMonthValue,
                    SecondMonthValue = detail.SecondMonthValue,
                    ThirdMonthValue = detail.ThirdMonthValue,
                    Total = detail.Total
                });
            }
            return cnssDeclarationLinesViewModels.OrderBy(model => model.PageNumber).ThenBy(model => model.NumberOrder).ToList();
        }
    }
}
