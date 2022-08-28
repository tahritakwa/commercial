using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSourceDeductionSession : Service<SourceDeductionSessionViewModel, SourceDeductionSession>, IServiceSourceDeductionSession
    {
        private readonly IServiceSourceDeductionSessionEmployee _serviceSourceDeductionSessionEmployee;
        private readonly IRepository<Payslip> _payslipRepo;
        private readonly IRepository<SourceDeduction> _sourceDeductionRepo;
        public ServiceSourceDeductionSession(IRepository<SourceDeductionSession> entityRepo,
            IUnitOfWork unitOfWork, IServiceSourceDeductionSessionEmployee serviceSourceDeductionSessionEmployee,
            ISourceDeductionSessionBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
            IRepository<Payslip> payslipRepo,
            IRepository<SourceDeduction> sourceDeductionRepo)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceSourceDeductionSessionEmployee = serviceSourceDeductionSessionEmployee;
            _payslipRepo = payslipRepo;
            _sourceDeductionRepo = sourceDeductionRepo;
        }

        public override object AddModel(SourceDeductionSessionViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            model.CreationDate = DateTime.Now; 
            return base.AddModel(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check the unicity of Source Deduction Session number by year
        /// </summary>
        /// <param name="sourceDeductionSessionViewModel"></param>
        /// <returns></returns>
        public bool GetUnicitySessionNumberPerYear(SourceDeductionSessionViewModel sourceDeductionSessionViewModel)
        {
            if (sourceDeductionSessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            IList<SourceDeductionSessionViewModel> list = FindModelBy(x => (x.Code == sourceDeductionSessionViewModel.Code 
            && x.Year == sourceDeductionSessionViewModel.Year 
            && (sourceDeductionSessionViewModel.Id == NumberConstant.Zero || sourceDeductionSessionViewModel.Id != x.Id))).ToList();

            return list.Any() ? true : false;            
        }

        /// <summary>
        /// Get session details
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns>SessionViewModel</returns>
        public SourceDeductionSessionViewModel GetSessionDetails(int idSession)
        {
            SourceDeductionSessionViewModel sessionViewModel = GetModel(x => x.Id == idSession);
            if (sessionViewModel == null)
            {
                throw new ArgumentException("");
            }
            // Get sessionEmployee 
            sessionViewModel.SourceDeductionSessionEmployee = _serviceSourceDeductionSessionEmployee.GetModelsWithConditionsRelations(x => x.IdSourceDeductionSession == idSession, 
                                                                   x => x.IdEmployeeNavigation).ToList();
            return sessionViewModel;
        }
        /// <summary>
        /// Delete old source deductions and add new ones
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(SourceDeductionSessionViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.State != (int)SessionStateViewModel.Closed)
            {
                // Get old source deduction session
                SourceDeductionSessionViewModel sourceDeductionSessionBeforeUpdate = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.SourceDeductionSessionEmployee,
                    x => x.SourceDeduction);
                // Retrieve employees from old source deduction session
                List<SourceDeductionSessionEmployeeViewModel> beforeUpdateSessionEmployees = sourceDeductionSessionBeforeUpdate.SourceDeductionSessionEmployee.ToList();
                if (sourceDeductionSessionBeforeUpdate.SourceDeduction != null && sourceDeductionSessionBeforeUpdate.SourceDeduction.Count > NumberConstant.Zero)
                {
                    AddSourceDeductionsToSourceDeductionSession(model, sourceDeductionSessionBeforeUpdate);
                }
                _serviceSourceDeductionSessionEmployee.BulkDeleteModelsPhysicallyWhithoutTransaction(beforeUpdateSessionEmployees, userMail);
            }
            else
            {
                CheckSourceDeductionSessionBeforeClosing(model);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Add source deduction when there are existing ones and delete corresponding unselected ones
        /// </summary>
        /// <param name="model"></param>
        /// <param name="sourceDeductionSessionBeforeUpdate"></param>
        private void AddSourceDeductionsToSourceDeductionSession(SourceDeductionSessionViewModel model, SourceDeductionSessionViewModel sourceDeductionSessionBeforeUpdate)
        {
            List <SourceDeductionViewModel> sourceDeductions = new List<SourceDeductionViewModel>();
            List<int> existingSourceDeductionEmployeeIds = sourceDeductionSessionBeforeUpdate.SourceDeduction.Select(x => x.IdEmployee).ToList();
            // Get new source deduction session employees and corresponding source deductions
            List<SourceDeductionSessionEmployeeViewModel> notExistingSourceDeductionSessionEmployee =
                model.SourceDeductionSessionEmployee.Where(x => !existingSourceDeductionEmployeeIds.Contains(x.IdEmployee)).ToList();
            if (notExistingSourceDeductionSessionEmployee != null && notExistingSourceDeductionSessionEmployee.Count > NumberConstant.Zero)
            {
                notExistingSourceDeductionSessionEmployee.ForEach(sourceDeductionEmployee =>
                {
                    SourceDeductionViewModel sourceDeduction = new SourceDeductionViewModel
                    {
                        Id = NumberConstant.Zero,
                        Status = (int)PayslipStatus.NotCalculated,
                        CreationDate = DateTime.Now,
                        Year = model.Year,
                        IdEmployee = sourceDeductionEmployee.IdEmployee,
                        IdSourceDeductionSession = model.Id
                    };
                    sourceDeductions.Add(sourceDeduction);
                });
            }
            // Delete source deductions of unselected employees
            List<SourceDeductionViewModel> sourceDeductionsToDelete = sourceDeductionSessionBeforeUpdate.SourceDeduction
                .Where(x => !model.SourceDeductionSessionEmployee.Select(y => y.IdEmployee).Contains(x.IdEmployee)).ToList();
            sourceDeductions.AddRange(sourceDeductionsToDelete.Select(x => { x.IsDeleted = true; return x; }).ToList());
            model.SourceDeduction = sourceDeductions;
        }
        /// <summary>
        /// Check if source deduction session can be closed
        /// </summary>
        /// <param name="sourceDeductionSession"></param>
        public void CheckSourceDeductionSessionBeforeClosing (SourceDeductionSessionViewModel sourceDeductionSession)
        {
            List<SourceDeduction> sourceDeductions = _sourceDeductionRepo.FindByAsNoTracking(x => x.IdSourceDeductionSession == sourceDeductionSession.Id && x.Status != (int)PayslipStatus.Correct).ToList();
            if (sourceDeductions.Any())
            {
                throw new CustomException(CustomStatusCode.CannotCloseSourceDeductionSessionWithWrongOrNotCalculatedSourceDeduction);
            }
            List<int> employeesIds = sourceDeductionSession.SourceDeductionSessionEmployee.Select(x => x.IdEmployee).ToList();
            List<Payslip> payslips = _payslipRepo.GetAllWithConditionsRelationsAsNoTracking(x => employeesIds.Contains(x.IdEmployee)
                && x.Month.Year == sourceDeductionSession.Year, x => x.IdSessionNavigation).ToList();
            if (payslips.Select(x => x.IdSessionNavigation).Any(x => x.State != (int)SessionStateViewModel.Closed))
            {
                throw new CustomException(CustomStatusCode.CannotCloseSourceDeductionSessionWithoutClosedPayslipSession);
            }
        }
    }
}
