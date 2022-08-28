using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceMobilityRequest : Service<MobilityRequestViewModel, MobilityRequest>, IServiceMobilityRequest
    {
        public readonly IRepository<User> _repoUser;
        public readonly IServiceEmployee _serviceEmployee;
        public readonly IServiceOffice _serviceOffice;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        public ServiceMobilityRequest(IRepository<MobilityRequest> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<User> repoUser, IServiceEmployee serviceEmployee,
           IUnitOfWork unitOfWork, IServiceOffice serviceOffice, IServiceMsgNotification serviceMessageNotification,
           IMobilityRequestBuilder builder,
           IMemoryCache memoryCache,
           ICompanyBuilder builderCompany,
           IEntityAxisValuesBuilder builderEntityAxisValues) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, builderCompany, memoryCache)
        {
            _repoUser = repoUser;
            _serviceEmployee = serviceEmployee;
            _serviceOffice = serviceOffice;
            _serviceMessageNotification = serviceMessageNotification;
        }

        public override object AddModelWithoutTransaction(MobilityRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            User connectedUser = _repoUser.GetSingleWithRelationsNotTracked(u => u.Email.ToUpper() == userMail.ToUpper());
            model.IdCreationUser = connectedUser.Id;

            OfficeViewModel currentOfficeViewModel = _serviceOffice.GetModelAsNoTracked(mR => mR.Id == model.IdCurrentOffice);
            model.Status = (int)MobilityRequestEnumerator.Draft;
            if (!PreventMobilityRequestAddModificationToNotAllowedUsers(userMail, model))
            {
                throw new CustomException(CustomStatusCode.PreventMobilityRequestAddModificationToNotAllowedUsers);
            }
            VerifyMobilityRequestControls(model);
            CreatedDataViewModel savedData = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);

            if (currentOfficeViewModel.IdOfficeManagerNavigation != null)
            {
                User officeManager = _repoUser.GetSingleWithRelationsNotTracked(u =>
                    u.Email.ToUpper() == currentOfficeViewModel.IdOfficeManagerNavigation.Email.ToUpper());

                if(officeManager != null)
                {
                    List<User> targetUsers = new List<User>
                    {
                        officeManager
                    };

                    OfficeViewModel destinationOfficeViewModel = _serviceOffice.GetModelAsNoTracked(mR => mR.Id == model.IdDestinationOffice);
                    EmployeeViewModel employee = _serviceEmployee.GetModelAsNoTracked(e => e.Id == model.IdEmployee);


                    IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                            {
                                { Constants.EMPLOYEE_FULLNAME, employee.FullName },
                                { Constants.CREATOR_FULLNAME, connectedUser.FirstName + " " +   connectedUser.LastName},
                                { Constants.CURRENT_OFFICE_NAME, currentOfficeViewModel.OfficeName },
                                { Constants.DESTINATION_OFFICE_NAME, destinationOfficeViewModel.OfficeName },
                                { Constants.REQUEST_TIME, DateTime.Now }

                            };
                    _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.ADD_MOBILITY_REQUEST_UPPER_CASE,
                    savedData.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertMobilityRequest,
                    userMail, parameters, targetUsers, GetCurrentCompany().Code);
                }
            }

            return savedData;
        }

        private void VerifyMobilityRequestControls(MobilityRequestViewModel model)
        {
            if (model.IdCurrentOffice == model.IdDestinationOffice)
            {
                throw new CustomException(CustomStatusCode.MobilityRequestSameOfficeViolation);
            }
        }

        public MobilityRequestViewModel GetModelById(int id, string userMail)
        {
            MobilityRequestViewModel mobilityRequestViewModel = GetModelAsNoTracked(mR => mR.Id == id, mR => mR.IdCurrentOfficeNavigation
                , mR => mR.IdDestinationOfficeNavigation, mR => mR.IdEmployeeNavigation);


            mobilityRequestViewModel.IdCurrentOfficeNavigation = _serviceOffice.GetModelAsNoTracked(mR => mR.Id == mobilityRequestViewModel.IdCurrentOffice);
            mobilityRequestViewModel.IdDestinationOfficeNavigation = _serviceOffice.GetModelAsNoTracked(mR => mR.Id == mobilityRequestViewModel.IdDestinationOffice);


            User connectedUser = _repoUser.GetSingleWithRelationsNotTracked(u => u.Email.ToUpper() == userMail.ToUpper());
            mobilityRequestViewModel.IsCurrentUserTheDepartureOfficeManager = mobilityRequestViewModel.IdCurrentOfficeNavigation.IdOfficeManagerNavigation.Id 
                == connectedUser.IdEmployee;
            mobilityRequestViewModel.IsCurrentUserTheDestinationOfficeManager = mobilityRequestViewModel.IdDestinationOfficeNavigation.IdOfficeManagerNavigation.Id 
                == connectedUser.IdEmployee;
            return mobilityRequestViewModel;
        }

        public override object UpdateModelWithoutTransaction(MobilityRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (!PreventMobilityRequestAddModificationToNotAllowedUsers(userMail, model))
            {
                throw new CustomException(CustomStatusCode.PreventMobilityRequestAddModificationToNotAllowedUsers);
            }
            VerifyMobilityRequestControls(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public void MobilityRequestValidation(MobilityRequestViewModel model)
        {
            if (!model.IsCurrentUserTheDepartureOfficeManager)
            {
                throw new CustomException(CustomStatusCode.OnlyOfficeManagerAccepteOrRefuseTheMobilityRequest);
            }
            base.UpdateModelWithoutTransaction(model, null, null, null);
        }
        public Boolean PreventMobilityRequestAddModificationToNotAllowedUsers(string userMail, MobilityRequestViewModel model)
        {
            EmployeeViewModel employee = _serviceEmployee.GetModelById(model.IdEmployee);
            if (userMail.Equals(employee.Email, StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }
            List<EmployeeViewModel> employees = new List<EmployeeViewModel>();
            _serviceEmployee.GetHierarchicalEmployeeList(employee.Email, employees);
            return _serviceEmployee.IsUserInSuperHierarchicalEmployeeList(userMail, employee);
        }
    }
}
