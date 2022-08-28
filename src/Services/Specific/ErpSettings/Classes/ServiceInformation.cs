using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="Infrastruture.Service.Service{ModelView.ErpSettings.ModuleViewModel, DataMapping.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceInformation : Service<InformationViewModel, Information>, IServiceInformation
    {      
        internal readonly IRepository<User> _entityRepoUser;
        private readonly IRepository<UserInfo> _entityRepoUserInfo;
        private readonly IRepository<PurchaseSettings> _entityPurchaseSettings;
        private readonly IRepository<Message> _messageRepo;

        public ServiceInformation(IRepository<Information> entityRepo, IUnitOfWork unitOfWork,
          IInformationBuilder entityBuilder,
          IRepository<User> entityRepoUser,
          IRepository<Message> messageRepo,
          IRepository<PurchaseSettings> entityPurchaseSettings, IRepository<UserInfo> entityRepoUserInfo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
            _entityRepoUserInfo = entityRepoUserInfo;
            _entityPurchaseSettings = entityPurchaseSettings;
            _messageRepo = messageRepo;
        }



        public override object UpdateModelWithoutTransaction(InformationViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // save entity traceability
            Information entity = _builder.BuildModel(model);

            // update collection entity                
            UpdateCollections(entity, userMail);
            // update entity
            _entityRepo.Update(entity);
            // update entityAxesValues
            if (entityAxisValuesModelList != null)
            {
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.IdInfo, userMail);
            }
            // commit 
            _unitOfWork.Commit();
            return new CreatedDataViewModel { Id = (int)entity.IdInfo, EntityName = entity.GetType().Name.ToUpper() };
        }

        /// <summary>
        /// Get list users to notify or to send mails
        /// </summary>
        /// <param name="idInfo"></param>
        /// <returns></returns>
        public IList<dynamic> GetTargetedUsers(TargetUserViewModel targetUserViewModel)
        {
            IList<User> listOfUserManger = new List<User>();
            if (targetUserViewModel.IsValidatePurchaseRequest)
            {
                User purchaseUser = _entityPurchaseSettings.GetSingleWithRelations(p => p.IdPurchasingManagerNavigation).IdPurchasingManagerNavigation;
                if (purchaseUser != null)
                {
                    listOfUserManger.Add(purchaseUser);

                }
                return listOfUserManger.Select(x => new { x.Id, x.Email }).ToList<dynamic>();
            }
            else
            {
                var information = _entityRepo.GetSingle(x => x.IdInfo == targetUserViewModel.IdInformation);
                if (information.IdInfoParent != null)
                {
                    //get List of replay user 
                    Message message = _messageRepo.GetSingle(x => x.IdInformation == information.IdInfoParent && x.EntityReference == targetUserViewModel.EntityReference);
                    if (message != null)
                    {
                        IList<User> listOfUsers = _entityRepoUser.FindBy(user => user.Id == message.IdCreator).ToList();
                        return listOfUsers.Select(x => new { x.Id, x.Email }).ToList<dynamic>();
                    }
                    return new List<dynamic>();
                }
                if (information.IsToManager == true)
                {
                    return GetManagerUser(targetUserViewModel.IdUser).Select(x => new { x.Id, x.Email }).ToList<dynamic>();
                }
            }
            return GetTargetedUsersByInformation(targetUserViewModel.IdInformation, targetUserViewModel.IdUser).Select(x => new { x.Id, x.Email }).ToList<dynamic>();
        }

        public IList<User> GetManagerUser(int idUser)
        {
            User currentUser = _entityRepoUser.GetSingle(x => x.Id == idUser);
            IList<User> listTargetedUsers = _entityRepoUser.FindBy(p => p.Id == currentUser.IdUserParent).ToList();
            if (!listTargetedUsers.Any())
            {
                listTargetedUsers.Add(currentUser);
            }
            return listTargetedUsers;
        }

        public IList<User> GetTargetedUsersByInformation(int IdInformation, int? idUser = null)
        {
            User userB2B;
            var listUsers = _entityRepoUserInfo.FindBy(userInfo => userInfo.IdInformation == IdInformation).Select(x => x.IdUser).ToList();
            IList<User> listTargetedUsers=new List<User>();
            if (idUser != null)
            {
                userB2B = _entityRepoUser.GetSingleNotTracked(x => x.IsBtoB == true && x.Id == idUser);
                if (userB2B != null)
                {
                    listUsers.Add(userB2B.Id);
                }
            }
            if (listUsers != null && listUsers.Any())
            {
                listTargetedUsers = _entityRepoUser.FindBy(user => listUsers.Any(id => user.Id == id)).Distinct().ToList();
            }

            return listTargetedUsers;

        }



        public override void UpdateCollections(dynamic entity, string userMail)
        {
            Information information = (Information)entity;
            /***********************Update user info********************************/
            //recuperate collection before update
            IList<UserInfo> oldUserInfo = _entityRepoUserInfo.FindByAsNoTracking(p => p.IdInformation == information.IdInfo).ToList();
            IList<UserInfo> newUserInfo = (information.UserInfo.Count > 0) ? information.UserInfo.ToList() : new List<UserInfo>();
            foreach (UserInfo entityUserInfo in newUserInfo)
            {
                // verify UserInfo existence ==> 
                // add element if not exist 
                // update element if exist and isDeleted == true
                UserInfo entityOldUserInfo = oldUserInfo.FirstOrDefault(c => c.IdUser == entityUserInfo.IdUser);
                if (entityOldUserInfo == null) //add element if not exist 
                {
                    entityUserInfo.IdInformation = information.IdInfo;
                    _entityRepoUserInfo.Add(entityUserInfo);
                }
                else //update element if exist and isDeleted == true
                {
                    if (entityOldUserInfo.IsDeleted)
                    {
                        UserInfo oldObject = entityOldUserInfo;
                        entityOldUserInfo.IsDeleted = false;
                        _entityRepoUserInfo.Update(entityOldUserInfo);

                    }
                    oldUserInfo.Remove(entityOldUserInfo);
                }
                information.UserInfo.Remove(entityUserInfo);
            }
            // delete old UserInfo
            foreach (UserInfo entityUserInfo in oldUserInfo)
            {
                UserInfo entityNewUserInfo = newUserInfo.FirstOrDefault(c => c.IdUser == entityUserInfo.IdUser);
                if (entityNewUserInfo == null) //add element if not exist 
                {
                    entityUserInfo.IsDeleted = true;
                    entityUserInfo.DeletedToken = Guid.NewGuid().ToString();
                    _entityRepoUserInfo.Update(entityUserInfo);
                }
            }
        }
    }
}
