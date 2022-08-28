using Infrastruture.Utility;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Common;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Shared.Classes
{
    public class ServiceUser : Service<UserViewModel, User>, IServiceUser
    {
        private readonly IRepository<UserInfo> _userInfoRepo;
        private readonly IRepository<Information> _informationRepo;
        private readonly IRepository<Phone> _phoneRepo;
        private readonly IRepository<Message> _messageRepo;
        private readonly IServiceMsgNotification _serviceMsgNotification;
        private readonly IUserBuilder _userbuilder;
        private readonly IMasterRoleUserBuilder _masterRoleUserBuilder;
        private readonly ICredentialsBuilder _credentialbuilder;
        private readonly ICompanyBuilder _builderCompany;
        private readonly IServiceEmployeeReduce _serviceEmployeeReduce;
        private readonly IEmployeeBuilder _builderEmployee;
        private readonly IRepository<PurchaseSettings> _entityPurchaseSettings;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceUserEmail _serviceUserEmail;
        private readonly IServiceMessage _serviceMessage;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceUserPrivilege _serviceUserPrivilege;
        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IServiceMasterUserCompany _serviceMasterUserCompany;
        private readonly IServiceMasterRoleUser _serviceMasterRoleUser;
        private readonly IRepository<TimeSheet> _timeSheetRepo;
        private readonly IServiceMasterCompany _serviceMasterCompany;
        private readonly IRepository<Company> _companyRepo;
        private readonly IRepository<Tiers> _tiersRepo;

        public ServiceUser(IServiceMasterUser serviceMasterUser,
            IRepository<User> entityRepo,
            IRepository<UserInfo> userInfoRepo,
            IRepository<Company> entityRepoCompany,
            IRepository<Phone> phoneRepo,
            IUnitOfWork unitOfWork,
            IUserBuilder userbuilder,
            IMasterRoleUserBuilder masterRoleUserBuilder,
            IServiceMsgNotification serviceMsgNotification,
            ICompanyBuilder builderCompany,
            IServiceEmployeeReduce serviceEmployeeReduce,
            IEmployeeBuilder builderEmployee,
            IServiceEmail serviceEmail,
            IServiceUserEmail serviceUserEmail,
            IServiceMessage serviceMessage,
            IServiceCompany serviceCompany,
            ICredentialsBuilder credentialbuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Information> informationRepo,
            IServiceUserPrivilege serviceUserPrivilege,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache,
            IServiceMasterUserCompany serviceMasterUserCompany,
            IServiceMasterRoleUser serviceMasterRoleUser,
            IRepository<TimeSheet> timeSheetRepo,
            IServiceMasterCompany serviceMasterCompany,
            IRepository<Company> companyRepo,
            IRepository<Tiers> tiersRepo)
            : base(entityRepo, unitOfWork, userbuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _userbuilder = userbuilder;
            _masterRoleUserBuilder = masterRoleUserBuilder;
            _builderCompany = builderCompany;
            _credentialbuilder = credentialbuilder;
            _userInfoRepo = userInfoRepo;
            _phoneRepo = phoneRepo;
            _informationRepo = informationRepo;
            _serviceMsgNotification = serviceMsgNotification;
            _builderEmployee = builderEmployee;
            _serviceEmployeeReduce = serviceEmployeeReduce;
            _serviceEmail = serviceEmail;
            _serviceUserEmail = serviceUserEmail;
            _serviceMessage = serviceMessage;
            _serviceCompany = serviceCompany;
            _serviceUserPrivilege = serviceUserPrivilege;
            _serviceMasterUser = serviceMasterUser;
            _serviceMasterUserCompany = serviceMasterUserCompany;
            _timeSheetRepo = timeSheetRepo;
            _serviceMasterCompany = serviceMasterCompany;
            _companyRepo = companyRepo;
            _serviceMasterRoleUser = serviceMasterRoleUser;
            _tiersRepo = tiersRepo;
        }


        public override UserViewModel GetModelById(int id)
        {
            UserViewModel user = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.IdPhoneNavigation)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();
            if (user == null)
            {
                MasterUser masterUser = _serviceMasterUser.getEntityById(id);
                user = _builder.BuildEntity(_entityRepo.GetSingleNotTracked(x => x.Email == masterUser.Email));
            }
            if (user.UrlPicture != null)
            {
                user.PictureFileInfo = GetFiles(user.UrlPicture).FirstOrDefault();
            }

            return user;
        }
        public  UserViewModel GetModelByEmail(string email)
        {
            UserViewModel user = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Email == email)
                .Include(x => x.IdPhoneNavigation)
                .Select(_builder.BuildEntity).ToList().FirstOrDefault();


            if (user != null && user.UrlPicture != null)
            {
                user.PictureFileInfo = GetFiles(user.UrlPicture).FirstOrDefault();
            }

            return user;
        }
        public override object AddModel(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
                if (model.PictureFileInfo != null)
                {
                    ManagePicture(model);
                }
                
                var addedEntity = AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                EndTransaction();
                _serviceMasterUser.EndTransaction();
                return addedEntity;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        public override object AddModelWithoutTransaction(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            model.Password = GetSHA512Hash(model.Password);
            if (model.IdEmployee != null)
            {
                VerifyUnicityOfEmployeeRelation(model);
            }
            VerifyUnicityOfEmail(model);
            _serviceMasterUser.AddUserToMasterBase(new List<MasterUserViewModel>
                { _userbuilder.BuildMasterSlaveModel(model, Activator.CreateInstance<MasterUserViewModel>()) });
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }


        public override void BulkAddWithoutTransaction(IList<UserViewModel> models, string userMail, string property = null)
        {
            if (FindModelBy(x => models.Any(m => x.IdEmployee.HasValue && m.IdEmployee.HasValue && x.IdEmployee == m.IdEmployee)).Any())
            {
                throw new CustomException(CustomStatusCode.UserEmployeeUnicity);
            }
            List<MasterUserViewModel> masterUserViewModels = new List<MasterUserViewModel>();
            models.ToList().ForEach(model =>
            {
                masterUserViewModels.Add(_userbuilder.BuildMasterSlaveModel(model, Activator.CreateInstance<MasterUserViewModel>()));
            });
            _serviceMasterUser.AddUserToMasterBase(masterUserViewModels);
            base.BulkAddWithoutTransaction(models, userMail, property);
        }

        /// <summary>
        /// Check the user's mail unicity
        /// </summary>
        /// <param name="model"></param>
        private void VerifyUnicityOfEmail(UserViewModel model)
        {
            UserViewModel user = FindModelsByNoTracked(x => x.Id != model.Id && x.Email == model.Email).FirstOrDefault();
            if (user != null)
                throw new CustomException(CustomStatusCode.UserEmailUnicity);
        }

        /// <summary>
        /// Checks if the employee associated with the user account does not already have an account
        /// </summary>
        /// <param name="model"></param>
        private void VerifyUnicityOfEmployeeRelation(UserViewModel model)
        {
            UserViewModel user = FindModelsByNoTracked(x => x.Id != model.Id && x.IdEmployee == model.IdEmployee).FirstOrDefault();
            if (user != null)
                throw new CustomException(CustomStatusCode.UserEmployeeUnicity);
        }

        /// <summary>
        /// Finds the model by Generic Predicate.
        /// The method receive a generic predicate
        /// and return the collection of model found according to the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public IEnumerable<UserViewModel> getListUsers(PredicateFormatViewModel predicateModel)
        {
            IEnumerable<UserViewModel> listOfUser = base.FindModelBy(predicateModel);
            if (listOfUser != null && listOfUser.Any())
                listOfUser.ToList().ForEach(x => x.Password = null);
            return listOfUser;
        }


        public override object UpdateModel(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                // begin transaction
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
               
                var addedEntity = UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                EndTransaction();
                _serviceMasterUser.EndTransaction();
                return addedEntity;

            }

            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                // throw exception
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }

        }
        public override object UpdateModelWithoutTransaction(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            UserViewModel user = GetModelAsNoTracked(m => m.Id == model.Id);
            // Reset password
            model.Password = user.Password;
            // conserve state
            model.IsActif = user.IsActif;
            VerifyUnicityOfEmail(model);
            if (model.IdEmployee != null)
            {
                VerifyUnicityOfEmployeeRelation(model);
            }
            model.UrlPicture = user.UrlPicture;
            //update with files pictures 
            if (model.PictureFileInfo != null)
            {
                ManagePicture(model);
            }
            //update collection entity
            User entity = _userbuilder.BuildModel(model);

            if (entity.IdPhoneNavigation != null)
            {
                if (entity.IdPhoneNavigation.Id == 0)
                {
                    _phoneRepo.Add(entity.IdPhoneNavigation);
                }
                else
                {
                    _phoneRepo.Update(entity.IdPhoneNavigation);
                }
                model.IdPhoneNavigation = null;
            }


            //Add or update user privileges
            if (model.Email.ToLower() != userMail.ToLower())
            {
                if (model.UserPrivilege != null && model.UserPrivilege.Any())
                {
                    if (RoleHelper.HasPermission(RHPermissionConstant.UPDATE_USERPRIVILEGE))
                    {

                        List<UserPrivilegeViewModel> userPrivileges = model.UserPrivilege.ToList();

                        foreach (UserPrivilegeViewModel userPrivilege in userPrivileges)
                        {
                            CheckUserPrivilegesWithHierarchyProperties(userPrivilege);
                            userPrivilege.IdPrivilegeNavigation = null;
                        }
                        _serviceUserPrivilege.BulkUpdateModelWithoutTransaction(userPrivileges, userMail);
                        model.UserPrivilege.Clear();
                    }
                }
            }
            int idCompany = _serviceMasterCompany.GetCompanyId(GetCurrentCompany().Code);
            MasterUserViewModel existingMasterUserviewmodel = _serviceMasterUser.GetModelAsNoTracked(x => x.Email == model.Email);
            List<MasterRoleUserViewModel> masterRoleUsersToUpdate = _serviceMasterRoleUser.FindModelsByNoTracked(x =>
                x.IdMasterUserNavigation.Email == model.Email && x.IdRoleNavigation.IdCompany == idCompany).ToList();

            if (existingMasterUserviewmodel != null && model.MasterRoleUser != null)
            {
                List<MasterRoleUserViewModel> masterRoleUsersToAdd = model.MasterRoleUser.Where(x => !masterRoleUsersToUpdate.Any(r => x.IdRole == r.IdRole))
                    .Select(x => { x.IdMasterUser = existingMasterUserviewmodel.Id; return x; }).ToList();
                masterRoleUsersToAdd.ToList().ForEach((x) =>
                {
                    x.IdMasterCompany = idCompany;
                });

                masterRoleUsersToUpdate.ToList().ForEach(x =>
                {
                    if (!model.MasterRoleUser.Any(r => r.IdRole == x.IdRole))
                    {
                        x.IsDeleted = true;
                    }
                });
                _serviceMasterRoleUser.BulkAddWithoutTransaction(masterRoleUsersToAdd, userMail);
                _serviceMasterRoleUser.BulkDeleteModelsPhysicallyWhithoutTransaction(masterRoleUsersToUpdate.Where(x => x.IsDeleted).ToList(), userMail);
            }
            else if (existingMasterUserviewmodel == null)
            {
                MasterUserViewModel masterUserViewModel = _userbuilder.BuildMasterSlaveModel(model, Activator.CreateInstance<MasterUserViewModel>());
                masterUserViewModel.Id = NumberConstant.Zero;
                _serviceMasterUser.AddUserToMasterBase(new List<MasterUserViewModel>
                    { masterUserViewModel });
            }
            if (existingMasterUserviewmodel != null && existingMasterUserviewmodel.Language != null && model != null && model.Language != null && model.Language.ToUpper() !=
               existingMasterUserviewmodel.Language.ToUpper())
            {
                existingMasterUserviewmodel.Language = model.Language;
                _serviceMasterUser.UpdateModelWithoutTransaction(existingMasterUserviewmodel, null, null);
            }
            var context = _unitOfWork.GetContext();
            var attachedItemwarehouse = context.ChangeTracker.Entries<User>().FirstOrDefault(e => e.Entity.Id == model.Id);
            if (attachedItemwarehouse != null)
            {
                context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);

        }


        public override UserViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            UserViewModel user = base.GetModelWithRelations(predicateModel);
            int idCompany = _serviceMasterCompany.GetCompanyId(GetCurrentCompany().Code);
            MasterUser masterUser = _serviceMasterUser.GetAllModelsQueryable()
                .Include(m => m.MasterRoleUser)
                .ThenInclude(m => m.IdRoleNavigation)
                .FirstOrDefault(x => x.Email == user.Email && x.MasterRoleUser.Any(r => r.IdRoleNavigation.IdCompany == idCompany));
            if (masterUser != null)
            {
                user.MasterRoleUser = masterUser.MasterRoleUser.Where(c => c.IdRoleNavigation.IdCompany == idCompany).Select(_masterRoleUserBuilder.BuildEntity).ToList();
            }
            return user;
        }


        /// <summary>
        /// Generated new password from upload excel file
        /// </summary>
        /// <returns></returns>
        private string GeneratePwd(int length)
        {
            string lower = ExcelConstants.LOWER;
            string upper = ExcelConstants.UPPER;
            string number = ExcelConstants.NUMBER;
            string special = ExcelConstants.SPECIAL;

            var middle = NumberConstant.Ten / NumberConstant.Two;
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (NumberConstant.Zero < length--)
            {
                if (middle == length)
                {
                    res.Append(number[rnd.Next(number.Length)]);
                }
                else if (middle - NumberConstant.One == length)
                {
                    res.Append(special[rnd.Next(special.Length)]);
                }
                else
                {
                    if (length % NumberConstant.Two == NumberConstant.Zero)
                    {
                        res.Append(lower[rnd.Next(lower.Length)]);
                    }
                    else
                    {
                        res.Append(upper[rnd.Next(upper.Length)]);
                    }
                }
            }
            return res.ToString();
        }

        /// <summary>
        /// add new users by upload excel file
        /// </summary>
        /// <param name="users"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void AddOrUpdateUserFromExcel(IEnumerable<UserViewModel> users, string userMail, SmtpSettings smtpSettings)
        {
            try
            {
                IList<UserViewModel> userModelAfterSHA512Hash = new List<UserViewModel>();
                List<UserViewModel> userModelBeforSHA512Hash = new List<UserViewModel>();
                IList<UserViewModel> entities = new List<UserViewModel>();
                StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
                IList<EmployeeViewModel> employeeViewModels = _serviceEmployeeReduce.FindModelsByNoTracked(x =>
                    users.Any(u => !string.IsNullOrEmpty(u.AssociateEmployeeEmail) && x.Email.ToLower() == u.AssociateEmployeeEmail.ToLower()));
                foreach (UserViewModel user in users)
                {
                    if (user.MasterRoleUser == null)
                    {
                        throw new CustomException(CustomStatusCode.EMPLOYEE_DID_NOT_HAVE_A_ROLE, new Dictionary<string, dynamic>
                        {
                            { nameof(Employee), new StringBuilder().Append(user.FirstName).Append(" ").Append(user.LastName)}
                        });
                    }
                    if (!string.IsNullOrEmpty(user.AssociateEmployeeEmail))
                    {
                        user.IdEmployee = employeeViewModels.FirstOrDefault(x => string.Compare(x.Email, user.AssociateEmployeeEmail, stringComparison) == NumberConstant.Zero).Id;
                    }
                    if (user.Id == NumberConstant.Zero)
                    {
                        string passwordBeforSHA512Hash = "";
                        user.Password = GeneratePwd(NumberConstant.Ten);
                        passwordBeforSHA512Hash = user.Password;
                        user.Password = GetSHA512Hash(user.Password);
                        userModelAfterSHA512Hash.Add(user);
                        userModelBeforSHA512Hash.Add(new UserViewModel
                        {
                            Password = passwordBeforSHA512Hash,
                            FirstName = user.FirstName,
                            LastName = user.LastName,
                            Email = user.Email
                        });
                    }
                    else
                    {
                        entities.Add(user);
                    }

                }
                // begin transaction
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
                BulkUpdateModelWithoutTransaction(entities, null);
                BulkAddWithoutTransaction(userModelAfterSHA512Hash, null);
                userModelBeforSHA512Hash.ForEach(x => PrepareAndSendMailToTheNewUser(userMail, x, x.Password, smtpSettings));
                _serviceMasterUser.EndTransaction();
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                // thorw the original exception
                throw;
            }
        }

        private void CheckUserPrivilegesWithHierarchyProperties(UserPrivilegeViewModel userPrivilege)
        {
            if (userPrivilege.SameLevelWithHierarchy.HasValue && userPrivilege.SameLevelWithoutHierarchy.HasValue
                            && userPrivilege.SameLevelWithHierarchy.Value && userPrivilege.SameLevelWithoutHierarchy.Value)
            {
                throw new CustomException(CustomStatusCode.PrivilegeSameLevel);
            }

            if (userPrivilege.SuperiorLevelWithHierarchy.HasValue && userPrivilege.SuperiorLevelWithoutHierarchy.HasValue
                && userPrivilege.SuperiorLevelWithHierarchy.Value && userPrivilege.SuperiorLevelWithoutHierarchy.Value)
            {
                throw new CustomException(CustomStatusCode.PrivilegSuperiorLevel);
            }
        }

        /// <summary>
        /// Log employee in corresonding database
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="model"></param>
        /// <param name="codeCompany"></param>
        /// <returns></returns>
        public CredentialsViewModel LoginEmployee(string connectionString, CredentialsViewModel model, string codeCompany)
        {
            try
            {
                BeginTransaction(connectionString);
                var user = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(
                    elt => elt.Email == model.Email,
                    x => x.IdEmployeeNavigation).FirstOrDefault();
                var company = _entityRepoCompany.GetSingleWithRelations(elt => elt.Code == codeCompany, elt => elt.IdCurrencyNavigation,
                    elt => elt.PurchaseSettings);
                if (user != null && company != null && user.IsBtoB != true && user.IsActif == true)
                {
                    AppHttpContext.Current.Session.SetString(Constants.CONNECTION_STRING, connectionString);
                    CredentialsViewModel credential = _credentialbuilder.BuildEntity(user);
                    credential.IdUser = user.Id;
                    credential.Password = model.Password;
                    credential.Company = _builderCompany.BuildEntity(company);
                    credential.Language = user.Lang;
                    credential.IdEmployee = user.IdEmployee;
                    credential.Token = model.Token;
                    credential.LastConnectedCompany = model.LastConnectedCompany;
                    credential.CompanyAssociatedCode = model.CompanyAssociatedCode;
                    credential.MasterUserCompany = model.MasterUserCompany;
                    return credential;
                }
                else
                    return null;
            }
            finally
            {
                EndTransaction();
            }
        }

        public void UpdateToken(string Email, string Token)
        {
            var user = _entityRepo.FindBy(c => c.Email == Email).FirstOrDefault();
            user.Token = Token;
            _entityRepo.Update(user);

            _unitOfWork.Commit();
        }
        
    /// <summary>
    /// Get list users to notify or to send mails
    /// </summary>
    /// <param name="idInfo"></param>
    /// <returns></returns>
    public IEnumerable<dynamic> GetTargetedUsers(TargetUserViewModel targetUserViewModel)
    {
        IList<User> listOfUserManger = new List<User>();
        if (targetUserViewModel.IsValidatePurchaseRequest)
        {
            User purchaseUser = _entityPurchaseSettings.GetSingleWithRelations(p => p.IdPurchasingManagerNavigation).IdPurchasingManagerNavigation;
            if (purchaseUser != null)
            {
                listOfUserManger.Add(purchaseUser);

            }
            return listOfUserManger.Select(x => new { x.Id, x.Email });
        }
        else
        {
            var information = _informationRepo.GetSingle(x => x.IdInfo == targetUserViewModel.IdInformation);
            if (information.IdInfoParent != null)
            {
                //get List of replay user 
                var message = _messageRepo.GetSingle(x => x.IdInformation == information.IdInfoParent && x.EntityReference == targetUserViewModel.EntityReference);
                if (message != null)
                {
                    IList<User> listOfUsers = _entityRepo.FindBy(user => user.Id == message.IdCreator).ToList();
                    return listOfUsers.Select(x => new { x.Id, x.Email });
                }
                return new List<dynamic>();
            }
            if (information.IsToManager == true)
            {
                return GetManagerUser(targetUserViewModel.IdUser).Select(x => new { x.Id, x.Email }).ToList();
            }
        }
        return GetTargetedUsersByInformation(targetUserViewModel.IdInformation, targetUserViewModel.IdUser).Select(x => new { x.Id, x.Email }).ToList();
    }


    public IEnumerable<User> GetTargetedUsersByInformation(int IdInformation, int? idUser = null)
        {
            UserViewModel userB2B;
            var listUsers = _userInfoRepo.FindBy(userInfo => userInfo.IdInformation == IdInformation).Select(x => x.IdUser).ToList();
            IEnumerable<User> listTargetedUsers;
            if (idUser != null)
            {
                userB2B = GetModel(x => x.IsBtoB == true && x.Id == idUser);
                if (userB2B != null)
                {
                    listUsers.Add(userB2B.Id);
                }
            }

            //var idRole = _RoleInfoRepo.FindBy(roleInfo => roleInfo.IdInformation == IdInformation).Select(roleInfo => roleInfo.IdRole).ToList();
            //var listRoleUsers = _userRoleRepo.GetAllWithConditionsRelationsAsNoTracking(userRole => idRole.Contains(userRole.IdRole)).Select(userRole => userRole.IdUser).ToList();
            listTargetedUsers = _entityRepo.FindBy(user => (listUsers).Any(id => user.Id == id)).AsEnumerable();


            return listTargetedUsers.Distinct();

        }

        public DataSourceResult<UserViewModel> GetListUser(PredicateFormatViewModel predicateModel, string userMail)
        {
            const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
            if(predicateModel.Filter == null)
            {
                predicateModel.Filter = new List<FilterViewModel>();
            }
            predicateModel.Filter.Add(new FilterViewModel { Prop = "Email", Operation = Operation.NotEquals, Value = null });
            var listModel = base.FindDataSourceModelBy(predicateModel);
            int idCompany = _serviceMasterCompany.GetCompanyId(GetCurrentCompany().Code);
            IList<MasterUser> masterUsers = _serviceMasterUser.GetAllModelsQueryable()
                .Include(m => m.MasterRoleUser)
                .ThenInclude(m => m.IdRoleNavigation)
                .Where(x => listModel.data.Select(u=>u.Email.ToLower()).Contains(x.Email.ToLower()))
                .Where(x => x.MasterRoleUser.Any(c => c.IdRoleNavigation.IdCompany == idCompany)).ToList();
            UserViewModel user = listModel.data.FirstOrDefault(p => p.Email.ToLower() == userMail.ToLower());
            if (user != null)
            {
                user.CanDelete = false;
            }
            listModel.data.ToList().ForEach(x =>
            {
                MasterUser masterUser = masterUsers.FirstOrDefault(m => string.Compare(m.Email, x.Email, stringComparison) == NumberConstant.Zero);
                if (masterUser != null)
                {
                    x.MasterRoleUser = masterUser.MasterRoleUser.Where(c => c.IdRoleNavigation.IdCompany == idCompany).Select(_masterRoleUserBuilder.BuildEntity).ToList();
                }
            });
            return listModel;
        }

        /// <summary>
        /// Get list users to notify or to send mails
        /// </summary>
        /// <param name="idInfo"></param>
        /// <returns></returns>
        public IEnumerable<User> GetManagerUser(int idUser)
        {
            User currentUser = _entityRepo.GetSingle(x => x.Id == idUser);
            IList<User> listTargetedUsers = _entityRepo.FindBy(p => p.Id == currentUser.IdUserParent).ToList();
            if (!listTargetedUsers.Any())
            {
                listTargetedUsers.Add(currentUser);
            }
            return listTargetedUsers;
        }

        public UserViewModel GetProfile(int Id, string userMail)
        {
            // get currentUser
            const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
            var currentUser = _entityRepo.FindBy(p => p.Email.ToLower() == userMail.ToLower()).FirstOrDefault();
            if (currentUser.Id != Id)
            {
                throw new CustomException(CustomStatusCode.ProfileSercurityError);
            }
            User user = _entityRepo.GetSingleWithRelations(p => p.Id == Id);
            return _userbuilder.BuildEntity(user);
        }
        /// <summary>
        /// Get list of parent by idCurrentUser
        /// </summary>
        /// <param name="idCurrentUser"></param>
        /// <param name="users"></param>
        public void GetListOfUsersParent(int? idCurrentUser, List<UserViewModel> users, string? EmailCreator = "")
        {
            UserViewModel user = new UserViewModel();
            if (EmailCreator != null)
            {
                user = GetModelWithRelations(x => x.Email == EmailCreator, x => x.InverseIdUserParentNavigation);
            }
            else if (idCurrentUser != null)
            {
                user = GetModelWithRelations(x => x.Id == idCurrentUser, x => x.InverseIdUserParentNavigation);
                users.Add(user);
                if (user != null && user.IdUserParent != null)
                {
                    GetListOfUsersParent(user.IdUserParent, users,null);
                }
            }
        }
        public void patchModel(UserViewModel model)
        {
            User user = _builder.BuildModel(model);
            _entityRepo.Update(user);
            // commit 
            _unitOfWork.Commit();
        }

        public CredentialsViewModel LoginB2b(UserViewModel model, string conxString)
        {
            BeginTransaction(conxString);
            var user = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(
                elt => elt.Email == model.Email && elt.Password == GetSHA512Hash(model.Password) && elt.IsBtoB == true).FirstOrDefault();
            EndTransaction();
            if (user != null)
            {
                CredentialsViewModel credential = _credentialbuilder.BuildEntity(user);
                credential.IdUser = user.Id;
                credential.Password = "";
                credential.Language = user.Lang != null ? user.Lang : "fr";
                credential.IdEmployee = user.IdEmployee;
                credential.Employee = user.IdEmployeeNavigation != null ? _builderEmployee.BuildEntity(user.IdEmployeeNavigation) : null;
                return credential;
            }
            else
                return null;
        }

        public void PrepareAndSendMailToTheNewUser(string userMail, UserViewModel newUser, string password, SmtpSettings smtpSettings)
        {
            User connectedUser = _entityRepo.GetAllWithConditionsRelations(x => x.Email == userMail, x => x.IdEmployeeNavigation).FirstOrDefault();
            EmailConstant emailConstant = new EmailConstant(newUser.Lang);
            // prepare emailSubject
            string emailSubject = emailConstant.NotifNewUser;
            string companyName = _entityRepoCompany.GetSingle(x => true).Name;
            string mailBody = PrepareMailBody(emailConstant, newUser, password, companyName);

            // generate the email
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = emailSubject,
                Body = mailBody,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = newUser.Email
            };
            // add the email in the db
            int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            generatedEmail.Id = generatedEmailId;
            // add the UserMail relation 
            NewUserEmailViewModel newUserEmail = new NewUserEmailViewModel
            {
                IdEmail = generatedEmailId,
                IdUser = connectedUser.Id
            };
            _serviceUserEmail.AddModelWithoutTransaction(newUserEmail, null, userMail);
            // send the email to the new user
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);

        }
        string PrepareMailBody(EmailConstant emailConstant, UserViewModel user, string password, string companyName)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.NotifNewUserEmailTemplate);
            body = body.Replace("{NEWUSER_FULLNAME}", user.FirstName + " " + user.LastName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEWUSER_EMAIL}", user.Email, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEWUSER_PASSWORD}", password, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{COMPANY}", companyName, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        public object UpdateB2BUser(UserViewModel model)
        {
            User user = _entityRepo.FindByAsNoTracking(elt => elt.Id == model.Id).FirstOrDefault();
            if (user.IsBtoB != true)
            {
                return new CreatedDataViewModel();
            }
            else
            {
                try
                {
                    // begin transaction
                    _unitOfWork.BeginTransaction();
                    VerifyUnicityOfEmail(model);
                    model.IdTiers = user.IdTiers;
                    // change password in dataBase
                    model.Password = model.Password == "" ? user.Password : GetSHA512Hash(model.Password);


                    //update collection entity
                    User entity = _userbuilder.BuildModel(model);


                    // update entity
                    _entityRepo.Update(entity);


                    _unitOfWork.Commit();
                    _unitOfWork.CommitTransaction();
                    if (GetPropertyName(entity) != null)
                    {
                        return new CreatedDataViewModel { Id = (int)user.Id, Code = getModelCode(user, GetPropertyName(user)), EntityName = user.GetType().Name.ToUpper() };
                    }

                    return new CreatedDataViewModel { Id = (int)user.Id, EntityName = user.GetType().Name.ToUpper() };
                }
                catch
                {
                    // rollback transaction
                    _unitOfWork.RollbackTransaction();
                    // thorw the original exception
                    throw;
                }
            }
        }
        /// <summary>
        /// Find Users with Role navigation  
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override DataSourceResult<UserViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicate)
        {
            DataSourceResult<UserViewModel> dataSourceResult = new DataSourceResult<UserViewModel>();
            predicate.Operator = Operator.And;
            PredicateFilterRelationViewModel<User> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<User> UserQuery = _entityRepo
                .GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere,
                                         predicateFilterRelationModel.PredicateRelations)
                                         .BuildOrderBysQue(predicate.OrderBy);
            dataSourceResult.total = UserQuery.Count();
            if (predicate.page > NumberConstant.Zero && predicate.pageSize > NumberConstant.Zero)
            {
                UserQuery = UserQuery.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize);
            }
            dataSourceResult.data = UserQuery.ToList().Select(_builder.BuildEntity).ToList();
            foreach (UserViewModel userViewModel in dataSourceResult.data)
            {
                if (userViewModel.IdEmployeeNavigation != null && (userViewModel.IdEmployeeNavigation.TimeSheetIdEmployeeNavigation.Any()
                    || userViewModel.IdEmployeeNavigation.LeaveIdEmployeeNavigation.Any()))
                {
                    userViewModel.HasLeaveOrTimesheet = true;
                }
                else
                {
                    userViewModel.HasLeaveOrTimesheet = false;
                }
            }
            return dataSourceResult;
        }
        string PrepareInterviewMailBody(AdministrativeDocumentConstant administrativeDocumentConstant, string msg, UserViewModel user, string culture, string password)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.NotifNewUserEmailTemplate);
            body = body.Replace("{NEWUSER_FULLNAME }", user.FirstName + " " + user.LastName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEWUSER_EMAIL }", user.Email, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEWUSER_PASSWORD}", password, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        public void PrepareAndSendMail(MailBrodcastConfigurationViewModel configMail, string userMail, string action,
           UserViewModel newUser, SmtpSettings smtpSettings, string password)
        {
            MessageViewModel msgVM = _serviceMessage.GetModelWithRelations(x => x.Id == configMail.IdMsg, x => x.IdInformationNavigation);
            newUser = FindModelsByNoTracked(x => x.Id == configMail.Model.Id, x => x.IdEmployeeNavigation).FirstOrDefault();
            EmployeeViewModel connectedEmployee = FindModelsByNoTracked(x => x.Email == userMail, x => x.IdEmployeeNavigation).FirstOrDefault()?.IdEmployeeNavigation;
            UserViewModel userToNotify;
            if (action == "DELETION")
            {
                userToNotify = newUser;
            }
            else
            {
                // we can not getModel after deletion
                userToNotify = GetModelById(configMail.Model.Id);
            }
            EmailViewModel generatedEmail;
            NewUserEmailViewModel newUserEmail;
            UserViewModel userViewModel;
            string mailBody = String.Empty;

            if (!configMail.users.Contains(newUser.Email))
            {
                configMail.users.Add(newUser.Email);
            }

            foreach (string email in configMail.users)
            {
                UserViewModel user = GetModel(x => x.Email == email);
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // prepare emailSubject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.NotifNewUser, user.Lang);
                // Prepare emailBody 
                string msg = AdministrativeDocumentInfosBuilder.PrepareMessage(user, connectedEmployee, msgVM, configMail);
                userViewModel = GetModel(x => x.Email == email);
                if (action == "UPDATING")
                {
                    //mailBody = PrepareInterviewMailBodyForUpdateCase(administrativeDocumentConstant, msg, oldLeave, leave, user.Lang);
                }
                else
                {
                    mailBody = PrepareInterviewMailBody(administrativeDocumentConstant, msg, userToNotify, user.Lang, password);
                }
                // generate the email
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = 1,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = email
                };
                // add the email in the db
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                newUserEmail = new NewUserEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdUser = configMail.Model.Id
                };
                _serviceUserEmail.AddModelWithoutTransaction(newUserEmail, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            }
        }



        /// <summary>
        /// To add the list of users in the master in units of ten
        /// </summary>
        /// <returns></returns>
        public bool SynchronizeWithMaster()
        {
            try
            {
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
                string currentCompanyCode = GetCurrentCompany().Code;
                IList<UserViewModel> userViewModels = GetAllModelsAsNoTracking();
                _serviceMasterUser.SynchronizeWithMaster(userViewModels, currentCompanyCode);
                EndTransaction();
                _serviceMasterUser.EndTransaction();
                return true;
            }
            catch
            {
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="excelDataStream"></param>
        /// <returns></returns>
        public IList<UserViewModel> GenerateUsersListFromExcel(Stream excelDataStream)
        {
            UserForImportExcelComparer comparer = new UserForImportExcelComparer();
            return GenerateListFromExcel(excelDataStream, "Email", comparer);

        }

        /// <summary>
        /// Get master Users according to predicate
        /// </summary>
        /// <param name="predicate"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public DataSourceResult<MasterUserViewModel> GetMasterUsers(dynamic objectToSave, string userMail)
        {
            CompanyViewModel currentCompany = GetCurrentCompany();
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.predicate.ToString());
            PredicateFilterRelationViewModel<User> predicateFilterRelationModelUser = PreparePredicate(predicate);
            DataSourceResult<MasterUserViewModel> dataSourceResult = _serviceMasterUser.GetMasterUserList(predicate, userMail, currentCompany, predicateFilterRelationModelUser);
            IEnumerable<MasterUserViewModel> masterUserViewModels = dataSourceResult.data;
            foreach (MasterUserViewModel user in masterUserViewModels)
            {
                User userModel = _entityRepo.QuerableGetAll().Where(x => x.Email == user.Email).FirstOrDefault();
                if (userModel != null)
                {
                    user.UrlPicture = userModel.UrlPicture;
                }
                if (user.Email == userMail)
                {
                    user.IsUserOnline = true;
                }
                foreach (MasterUserCompanyViewModel userCompany in user.MasterUserCompany)
                {
                    if (userCompany.IdMasterCompanyNavigation.Code == objectToSave.companyCode.ToString())
                    {
                        user.MasterUserInCompany = true;
                    }
                }
            }
            return new DataSourceResult<MasterUserViewModel> { data = masterUserViewModels.ToList(), total = _serviceMasterUser.GetMasterUserList(predicate, userMail, currentCompany, predicateFilterRelationModelUser).total };
        }
        public object ChangeStateOfUser(int userId)
        {
            UserViewModel userToUpdate = GetModelAsNoTracked(u => u.Id == userId);
            if (userToUpdate.IsActif.HasValue && userToUpdate.IsActif.Value)
            {
                userToUpdate.IsActif = false;
                if (!RoleHelper.HasPermission(RHPermissionConstant.DESACTIVATE_USER))
                {
                    throw new CustomException(CustomStatusCode.Unauthorized);
                }
            }
            else
            {
                userToUpdate.IsActif = true;
                if (!RoleHelper.HasPermission(RHPermissionConstant.REACTIVATE_USER))
                {
                    throw new CustomException(CustomStatusCode.Unauthorized);
                }
            }
            var obj = base.UpdateModelWithoutTransaction(userToUpdate, null, null);
            string currentCompany = GetCurrentCompany().Code;
            _serviceMasterUser.UpdateActifMasterUser(userToUpdate.Email, currentCompany);
            dynamic objectToReturn = new ExpandoObject();
            objectToReturn.obj = obj;
            objectToReturn.IsActif = userToUpdate.IsActif;
            return objectToReturn;
        }
        public UserDetail signOut(string email)
        {
            BaseHub hub = new BaseHub();
            var connectedUsers = hub.GetConnectedUsers();
            UserDetail user = connectedUsers.FirstOrDefault(x => x != null && x.UserMail.Equals(email));
            if (user != null)
            {
                connectedUsers.Remove(user);
            }
            return user != null ? user : new UserDetail();
        }
        /// <summary>
        /// get users from list of Id 
        /// </summary>
        /// <param name="listIdUsers"></param>
        /// <returns></returns>
        public List<UserViewModel> GetUsersFromListId(List<int> listIdUsers)
        {

            return _entityRepo.QuerableGetAll().Include(x => x.IdEmployeeNavigation)
                .Include(x => x.UserPrivilege).ThenInclude(x => x.IdPrivilegeNavigation).Where(x => listIdUsers.Contains(x.Id))
                    .Select(y => _builder.BuildEntity(y)).ToList();
        }
        /// <summary>
        /// desactivate massive users from list of users
        /// </summary>
        /// <param name="listOfUsers"></param>
        public object DesactivateMassiveUsers(List<UserViewModel> listOfUsers)
        {
            string currentCompany = GetCurrentCompany().Code;
            List<MasterUserCompanyViewModel> masterUserCompanyList = _serviceMasterUserCompany.FindByAsNoTracking(x =>
                                            listOfUsers.Select(s => s.Email).Contains(x.IdMasterUserNavigation.Email)
                                            && x.IdMasterCompanyNavigation.Code == currentCompany).ToList();

            masterUserCompanyList.ForEach((x) =>
            {
                x.IsActif = false;
            });
            listOfUsers.ForEach((x) =>
            {
                x.IsActif = false;
            });
            
            // bulk update list of user
            base.BulkUpdateModelWithoutTransaction(listOfUsers, null);
            // bulk update list of master user company
            _serviceMasterUserCompany.BulkUpdateModelWithoutTransaction(masterUserCompanyList, null);
            User entity = _userbuilder.BuildModel(listOfUsers.FirstOrDefault());
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        /// <summary>
        /// reactivate massive users from list of users
        /// </summary>
        /// <param name="listOfUsers"></param>
        public object ReactivateMassiveUsers(List<UserViewModel> listOfUsers)
        {
            string currentCompany = GetCurrentCompany().Code;
            List<MasterUserCompanyViewModel> masterUserCompanyList = _serviceMasterUserCompany.FindByAsNoTracking(x =>
                                            listOfUsers.Select(s => s.Email).Contains(x.IdMasterUserNavigation.Email)
                                           && x.IdMasterCompanyNavigation.Code == currentCompany).ToList();

            masterUserCompanyList.ForEach((x) =>
            {
                x.IsActif = true;
            });
            listOfUsers.ForEach((x) =>
            {
                x.IsActif = true;
            });

            // bulk update list of user
            base.BulkUpdateModelWithoutTransaction(listOfUsers, null);
            // bulk update list of master user company
            _serviceMasterUserCompany.BulkUpdateModelWithoutTransaction(masterUserCompanyList, null);
            User entity = _userbuilder.BuildModel(listOfUsers.FirstOrDefault());
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }
        public object InsertUserInThisCompany(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            User entity = _userbuilder.BuildModel(model);
            try
            {
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
                string codeCompany = ActiveAccountHelper.GetConnectedUserCredential().LastConnectedCompany;
                MasterCompanyViewModel company = _serviceMasterCompany.GetModel(x => x.Code == codeCompany);
                if (model.IdEmployee != null && _entityRepo.GetCountWithPredicate(x => x.IdEmployee == model.IdEmployee) > NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.UserEmployeeUnicity);
                }
                model.MasterRoleUser.ToList().ForEach((x) =>
                {
                    x.IdMasterCompany = company.Id;
                });
                MasterUserViewModel masterUserViewModel = _userbuilder.BuildMasterSlaveModel(model, Activator.CreateInstance<MasterUserViewModel>());
                _serviceMasterUser.UpdateOrInsertMasterUser(masterUserViewModel);
                UserViewModel userViewModel = FindModelsByNoTracked(result => result.Email.Equals(model.Email) && !result.IsDeleted).FirstOrDefault();
                if (userViewModel == null)
                {
                    model.Id = NumberConstant.Zero;
                    base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                }
                else
                {
                    userViewModel.MasterRoleUser = model.MasterRoleUser;
                    userViewModel.IdEmployee = model.IdEmployee;
                    base.UpdateModelWithoutTransaction(userViewModel, entityAxisValuesModelList, userMail, property);
                }
                _serviceMasterUser.EndTransaction();
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                throw;
            }
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }
        public void RemovePicture(int idUser)
        {
            try
            {
                UserViewModel user = GetModelAsNoTracked(x => x.Id == idUser);
                user.UrlPicture = null;

                // begin transaction
                _unitOfWork.BeginTransaction();
                User entity = _userbuilder.BuildModel(user);
                _entityRepo.Update(entity);

                _unitOfWork.Commit();
                _unitOfWork.CommitTransaction();
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }
        public void UpdatePicture(FileInfoViewModel fileInfo)
        {
            try
            {
                UserViewModel user = GetModelAsNoTracked(x => x.Id == fileInfo.IdOfCarrierModel);
                user.PictureFileInfo = fileInfo;
                ManagePicture(user);

                // begin transaction
                _unitOfWork.BeginTransaction();
                User entity = _userbuilder.BuildModel(user);
                _entityRepo.Update(entity);

                _unitOfWork.Commit();
                _unitOfWork.CommitTransaction();
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }
        public void ManagePicture(UserViewModel user)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(user.UrlPicture))
            {
                if (user.PictureFileInfo != null)
                {
                    user.UrlPicture = Path.Combine("Shared", "User", user.Id.ToString(), Guid.NewGuid().ToString());
                    CopyFiles(user.UrlPicture, user.PictureFileInfo);
                }

            }
            else
            {
                if (user.PictureFileInfo != null)
                {
                    List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                    fileInfo.Add(user.PictureFileInfo);
                    DeleteFiles(user.UrlPicture, fileInfo);
                    CopyFiles(user.UrlPicture, fileInfo);
                }
            }
            if (user.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        public object DeleteUserFromSlaveBase(string userMail)
        {
            string currentCompany = GetCurrentCompany().Code;
            UserViewModel userToDelete = GetModel(x => x.Email == userMail && !x.IsDeleted);
            var entity = _builder.BuildModel(userToDelete);
            if (userToDelete == null)
            {
                throw new CustomException(CustomStatusCode.userAlreadydeletedFromSlaveBase);
            }
            try
            {
                BeginTransaction();
                _serviceMasterUser.BeginTransaction();
                DeleteModelwithouTransaction(userToDelete.Id, nameof(User), null);
                _serviceMasterUser.DeleteMasterUserRelation(userMail, currentCompany);
                _serviceMasterUser.EndTransaction();
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                _serviceMasterUser.RollBackTransaction();
                throw new CustomException(CustomStatusCode.DeletionUsedUserFailed);
            }
            return new CreatedDataViewModel { Id = entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        /// <summary>
        /// Check if user with this mail is associate to one employee. If not throw an exception
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public UserViewModel GetUserIfAssociateToEmployee(string userMail)
        {
            // Get connected user account for get employee associated.
            UserViewModel userViewModel = GetModel(x => x.Email == userMail);
            if (userViewModel == null || userViewModel.IdEmployee == null)
            {
                // If the user is null or has not associate to employee, throw exception
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.FULL_NAME, userViewModel !=null ? new StringBuilder().Append(userViewModel.FirstName).Append(" ").Append(userViewModel.LastName ).ToString() : string.Empty}
                    };
                throw new CustomException(CustomStatusCode.RequiredEmployeeUserViolation, paramtrs);
            }
            return userViewModel;
        }

        public CredentialsViewModel SetDotNetSessionInformation(CredentialsViewModel userViewModel, string connectionString)
        {
            
            User user = _entityRepo.GetAllAsNoTracking().FirstOrDefault(x => x.Email == userViewModel.Email);
            if((user != null && user.IsActif == false) || user == null)
            {
                throw new CustomException(CustomStatusCode.disabledUser);
            }
            Company company = _companyRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.Code == userViewModel.LastConnectedCompany).FirstOrDefault();
            CredentialsViewModel CredentialsViewModel = new CredentialsViewModel
            {
                IdUser = user.Id,
                Email = user.Email,
                Password = user.Password,
                Company = _builderCompany.BuildEntity(company),
                Language = user.Lang,
                IdEmployee = user.IdEmployee,
                LastConnectedCompany = userViewModel.LastConnectedCompany,
                IdTiers = user.IdTiers,
                MasterUserCompany = new List<MasterUserCompanyViewModel> { new MasterUserCompanyViewModel { IdMasterUser = 61, IdMasterCompany = 2 } },
                ActivityArea = company.ActivityArea
            };
            
            return CredentialsViewModel;
        }
        public bool ChangeUserLanguage(string usermail, string lang)
        {
            User user = _entityRepo.FindByAsNoTracking(x => x.Email == usermail).FirstOrDefault();
            user.Lang = lang;
            _entityRepo.Update(user);
            _unitOfWork.Commit();
            return true;
        }

        /// <summary>
        /// Updates the last connection time and the user's connection Ip address
        /// </summary>
        /// <param name="email"></param>
        /// <param name="iPAddress"></param>
        public void UpdateUserLastConnectionInformations(string email, IPAddress iPAddress)
        {
            UserViewModel userViewModel = GetModelAsNoTracked(x => x.Email == email);
            userViewModel.LastConnection = DateTime.Now;
            userViewModel.LastConnectedIpAdress = iPAddress.ToString();
            base.UpdateModelWithoutTransaction(userViewModel, null, null);
        }
        public void SendNotifToTheConnectedUserAfterAddingNewUserAccount(string userMail, UserViewModel newUser)
        {
            User connectedUser = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Email == userMail, x => x.IdEmployeeNavigation);
            // prepare the notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters[Constants.NEW_USER] = newUser.FullName;
            // send notif to the connected user
            _serviceMsgNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.ADD_NEW_USER,
            newUser.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertSharingDocument,
            userMail, parameters, new List<User> { connectedUser }, GetCurrentCompany().Code);
        }
        public DataSourceResult<UserViewModel> GetListUserWithRole(List<string> users)
        {
            DataSourceResult<UserViewModel> dataSourceResult = new DataSourceResult<UserViewModel>();
            IQueryable<User> UserQuery = _entityRepo.QuerableGetAll().Where(z => users.Contains(z.Email)).OrderBy(g => g.FirstName).ThenBy(u => u.LastName);
            dataSourceResult.total = UserQuery.Count();
            dataSourceResult.data = UserQuery.ToList().Select(_builder.BuildEntity).ToList();
            return dataSourceResult;
        }

        public int GetUserIdByEmail(string email)
        {
            return _entityRepo.GetSingleNotTracked(x => x.Email == email).Id;
        }
        
       
    }
}
