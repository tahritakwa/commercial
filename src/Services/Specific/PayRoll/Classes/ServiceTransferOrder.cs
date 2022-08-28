using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceTransferOrder : Service<TransferOrderViewModel, TransferOrder>, IServiceTransferOrder
    {
        private readonly IServicePayslip _servicePayslip;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServicePayslipDetails _servicePayslipDetails;
        private readonly IServiceTransferOrderDetails _serviceTransferOrderDetails;
        private readonly IRepository<Payslip> _payslipRepo;

        public ServiceTransferOrder(IRepository<TransferOrder> entityRepo, IUnitOfWork unitOfWork, ITransferOrderBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Codification> entityRepoCodification, IServicePayslip servicePayslip,
            IServicePayslipDetails servicePayslipDetails, IServiceTransferOrderDetails serviceTransferOrderDetails,
            IServiceEmployee serviceEmployee, IOptions<AppSettings> appSettings, IRepository<Entity> entityRepoEntity, IRepository<Company> entityRepoCompany,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Payslip> payslipRepo)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {

            _servicePayslip = servicePayslip;
            _serviceEmployee = serviceEmployee;
            _servicePayslipDetails = servicePayslipDetails;
            _serviceTransferOrderDetails = serviceTransferOrderDetails;
            _payslipRepo = payslipRepo;
        }

        /// <summary>
        /// Add transfer order 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(TransferOrderViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            model.Month = model.Month.FirstDateOfMonth();
            // Build transfer order entity from trnasfer order view model
            TransferOrder entity = _builder.BuildModel(model);
            // Generate Codification
            GenerateCodification(entity, property, false);
            _entityRepo.Add(entity);
            // Commit trnasaction
            _unitOfWork.Commit();
            // Get created entity id
            CreatedDataViewModel createdData = new CreatedDataViewModel { Id = entity.Id };
            model.Id = createdData.Id;
            return model;
        }

        /// <summary>
        /// Update transfer order 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(TransferOrderViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            model.Month = model.Month.FirstDateOfMonth();
            TransferOrderViewModel oldtransferOrder = GetModelWithRelationsAsNoTracked(m => m.Id == model.Id, m => m.TransferOrderSession);
            List<TransferOrderSessionViewModel> deletedSession = oldtransferOrder.TransferOrderSession.Except(model.TransferOrderSession, new TransferOrderSessionIdComparer()).ToList();
            List<TransferOrderSessionViewModel> newSelectedSessions = model.TransferOrderSession.Where(x => !x.IsDeleted).Except(oldtransferOrder.TransferOrderSession, new TransferOrderSessionIdComparer()).ToList();
            // If a new session has been selected, the transfer order changes to the wrong state
            List<PayslipViewModel> selectPayslip = _servicePayslip.FindByAsNoTracking(m =>
                newSelectedSessions.Any(x => x.IdSession == m.IdSession) &&
                m.Month.EqualsDate(model.Month) && m.IdEmployeeNavigation.Rib.NotNullOrEmpty() &&
                m.IdEmployeeNavigation.TransferOrderDetails.Any(x => x.IdTransferOrder == model.Id) &&
                m.IdTransferOrder == null).ToList();
            if (selectPayslip.Any())
            {
                model.State = (int)TransferOrderStatus.Wrong;
            }
            if (deletedSession.Any())
            {
                // The records of the employees deselected from the transfer order must return to the correct state
                List<PayslipViewModel> deselectSessionPayslips = _servicePayslip.FindByAsNoTracking(m => m.IdTransferOrder == model.Id)
                    .Select(x => { x.IdTransferOrder = null; return x; }).ToList();
                _servicePayslip.BulkUpdateModelWithoutTransaction(deselectSessionPayslips, userMail);
                // Delete the detail lines that are no longer affected by the transfer order
                model.TransferOrderDetails.Select(x => { x.IsDeleted = true; return x; }).ToList();
                model.State = (int)TransferOrderStatus.InProgress;
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Calculate transfer order details
        /// </summary>
        /// <param name="transferOrderViewModel"></param>
        /// <returns></returns>
        public object GenerateTransferDetails(TransferOrderViewModel transferOrderViewModel, string userMail)
        {
            // Get existing details of this transfer order for deleting
            IList<TransferOrderDetailsViewModel> transferOrderDetailsViewModels = _serviceTransferOrderDetails.FindModelBy(x => x.IdTransferOrder == transferOrderViewModel.Id).ToList();
            _serviceTransferOrderDetails.BulkDeleteModelsPhysicallyWhithoutTransaction(transferOrderDetailsViewModels, userMail);
            // The records of the employees selected from the transfer order must return to the correct state
            List<PayslipViewModel> oldSelectedPayslips = _servicePayslip.FindByAsNoTracking(model =>
                /*transferOrderViewModel.TransferOrderSession.Any(x => x.IdSession == model.IdSession) &&*/
                model.IdTransferOrder == transferOrderViewModel.Id &&
                transferOrderDetailsViewModels.Select(x => x.IdEmployee).Except(transferOrderViewModel.IdEmployeeSelected).Contains(model.IdEmployee)).ToList()
                .Select(x => { x.IdTransferOrder = null; return x; }).ToList();
            // Contain transfer order total
            transferOrderViewModel.TotalAmount = default;
            // Get payslip associate with idContract, paied by Transfer
            List<PayslipViewModel> payslipViewModels = _servicePayslip.FindModelsByNoTracked(model =>
                transferOrderViewModel.TransferOrderSession.Any(x => x.IdSession == model.IdSession) &&
                transferOrderViewModel.IdEmployeeSelected.Any(x => x == model.IdEmployee) && (model.IdTransferOrder == null || model.IdTransferOrder == transferOrderViewModel.Id)
               && model.Month.EqualsDate(transferOrderViewModel.Month) && model.IdEmployeeNavigation.Rib.NotNullOrEmpty(),
                model => model.IdEmployeeNavigation, x => x.PayslipDetails).ToList();
            if (!payslipViewModels.Any())
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), _serviceEmployee.GetModelById(transferOrderViewModel.IdEmployeeSelected.First()).FullName }
                    };
                throw new CustomException(CustomStatusCode.EMPLOYEE_HAVENOT_PAYSLIP, errorParams);
            }
            payslipViewModels.GroupBy(x => x.IdEmployee).ToList().ForEach(model =>
            {
                double amount = default;
                List<PayslipViewModel> payslips = model.ToList();
                payslips.ForEach(x =>
                {
                    amount += x.PayslipDetails.Any() ? x.PayslipDetails.OrderBy(m => m.Order).LastOrDefault().Gain : NumberConstant.Zero;
                });
                // Add new Transfer order details
                transferOrderViewModel.TransferOrderDetails.Add(new TransferOrderDetailsViewModel
                {
                    // Employee contract
                    IdEmployee = model.Key,
                    // Rib of employee bank account
                    Rib = payslips.FirstOrDefault().IdEmployeeNavigation.Rib,
                    // The amount
                    Amount = _servicePayslip.PayrollRound(amount)
                });
                // Increment the total of trasfer order with the current amount
                transferOrderViewModel.TotalAmount += amount;
            });
            if (transferOrderViewModel.TransferOrderDetails.Count == NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.TransferOrderWithNoTransferOrderDetails);
            }
            transferOrderViewModel.State = (int)TransferOrderStatus.Correct;
            transferOrderViewModel.TotalAmount = _servicePayslip.PayrollRound(transferOrderViewModel.TotalAmount);
            payslipViewModels.Select(x => { x.IdTransferOrder = transferOrderViewModel.Id; return x; }).ToList();
            payslipViewModels.AddRange(oldSelectedPayslips);
            _servicePayslip.BulkUpdateModelWithoutTransaction(payslipViewModels, userMail);
            return base.UpdateModelWithoutTransaction(transferOrderViewModel, null, userMail);
        }


        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            TransferOrderViewModel transferOrderToDelate = GetModelWithRelationsAsNoTracked(m => m.Id == id, m => m.TransferOrderSession);
            if (transferOrderToDelate.State == (int)TransferOrderStatus.Closed)
                throw new CustomException(CustomStatusCode.CANNOT_DELETE_CLOSED_SESSION);
            // The records of the employees selected from the transfer order must return to the correct state
            List<PayslipViewModel> deselectSessionPayslips = _servicePayslip.FindByAsNoTracking(m => m.IdTransferOrder == id)
                .Select(x => { x.IdTransferOrder = null; return x; }).ToList();
            if (deselectSessionPayslips.Any())
            {
                _servicePayslip.BulkUpdateModelWithoutTransaction(deselectSessionPayslips, userMail);
            }
            return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }


        /// <summary>
        /// Get generated transfer order details plus new line of transferorder not generated yet
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <returns></returns>
        public IList<TransferOrderDetailsViewModel> GetTransferOrderDetails(int idTransferOrder)
        {
            TransferOrderViewModel transferOrderViewModel = _builder.BuildEntity(_entityRepo.GetAllAsNoTracking()
                .Include(x => x.TransferOrderDetails)
                    .ThenInclude(x => x.IdEmployeeNavigation)
                .Include(x => x.TransferOrderSession)
                    .FirstOrDefault(x => x.Id == idTransferOrder));
            List<TransferOrderDetailsViewModel> transferOrderDetailsViewModels = transferOrderViewModel.TransferOrderDetails.ToList();
            IList<PayslipViewModel> payslipViewModels = _servicePayslip.GetModelsWithConditionsRelations(model =>
                transferOrderViewModel.TransferOrderSession.Any(x => x.IdSession == model.IdSession) && model.IdTransferOrder == null &&
                model.IdEmployeeNavigation.IdPaymentTypeNavigation.Code.Equals(PayRollConstant.Transfer, StringComparison.OrdinalIgnoreCase), m => m.IdEmployeeNavigation);
            payslipViewModels.ToList().ForEach(model =>
            {
                if (!transferOrderDetailsViewModels.Any(x => x.IdEmployee == model.IdEmployee && x.IdTransferOrder == idTransferOrder))
                {
                    transferOrderDetailsViewModels.Add(new TransferOrderDetailsViewModel
                    {
                        Id = NumberConstant.Zero,
                        IdTransferOrder = idTransferOrder,
                        IdEmployee = model.IdEmployee,
                        IdEmployeeNavigation = model.IdEmployeeNavigation
                    });
                }
            });
            return transferOrderDetailsViewModels;
        }

        /// <summary>
        /// Get transfer order with its details for reporting
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <returns></returns>
        public override TransferOrderViewModel GetModelById(int id)
        {
            TransferOrderViewModel transferOrderViewModel = GetModelWithRelations(model => model.Id == id,
                model => model.TransferOrderDetails, model => model.TransferOrderSession);
            if (transferOrderViewModel.TransferOrderDetails != null)
            {
                transferOrderViewModel.TransferOrderDetails.ToList().ForEach(details =>
                      details.IdEmployeeNavigation = _serviceEmployee.GetModelById(details.IdEmployee));
            }
            return transferOrderViewModel;
        }

        /// <summary>
        /// Prevents a contract from being part of two transfer orders for the same session
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private bool CheckUnicityContractBySessionTransfer(TransferOrderViewModel model)
        {
            return _serviceTransferOrderDetails.FindModelBy(details => DateTime.Compare(details.IdTransferOrderNavigation.Month.Date, model.Month) == NumberConstant.Zero
                && details.IdTransferOrder != model.Id
                && model.IdEmployeeSelected.Contains(details.IdEmployee)).ToList().Count > 0;
        }

        /// <summary>
        /// Return true if one transfer exists with this number for this month false if else
        /// </summary>
        /// <param name="transferOrderViewModel"></param>
        /// <returns></returns>
        public bool CheckUnicityTransferNumber(TransferOrderViewModel transferOrderViewModel)
        {
            if (transferOrderViewModel == null)
            {
                throw new ArgumentException("");
            }
            transferOrderViewModel.Month = new DateTime(transferOrderViewModel.Month.Year, transferOrderViewModel.Month.Month, 1);
            return FindModelBy(x => (x.Month == transferOrderViewModel.Month &&
                                 (transferOrderViewModel.Id == 0 || transferOrderViewModel.Id != x.Id))).Any();
        }

        /// <summary>
        /// Close transfer order
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public void CloseTransferOrder(int idTransferOrder)
        {
            TransferOrderViewModel model = _builder.BuildEntity(_entityRepo.GetAllAsNoTracking()
                .Include(x => x.TransferOrderSession)
                    .ThenInclude(x => x.IdSessionNavigation)
                    .FirstOrDefault(x => x.Id == idTransferOrder));
            if (model.TransferOrderSession.Any(x => x.IdSessionNavigation.State != (int)SessionStateViewModel.Closed))
            {
                throw new CustomException(CustomStatusCode.CannotCloseTransferOrderWithoutClosedPayslipSession);
            }
            if (model.State != (int)TransferOrderStatus.Correct)
            {
                throw new CustomException(CustomStatusCode.CannotCloseNotCorrectTransferOrder);
            }
            model.State = (int)TransferOrderStatus.Closed;
            _entityRepo.Update(_builder.BuildModel(model));
            _unitOfWork.Commit();
        }
    }
}
