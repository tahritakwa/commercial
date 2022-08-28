using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;
using Standard.Licensing;
using Standard.Licensing.Validation;
using Persistence;

namespace Services.Catalog.Classes
{
    public class ServiceMasterUser : ServiceMaster<MasterUserViewModel, MasterUser>, IServiceMasterUser
    {
        private readonly IServiceMasterCompany _serviceMasterCompany;
        private readonly IUserBuilder _userBuilder;
        private readonly IServiceMasterUserCompany _serviceMasterUserCompany;
        private readonly IServiceCompanyLicence _serviceCompanyLicence;
        private readonly IServiceMasterRoleUser _serviceMasterRoleUser;
        private readonly IMasterRoleUserBuilder _masterRoleUserBuilder;
        private readonly IRepository<User> _entityRepoUser;
        private readonly IMemoryCache _memoryCache;
        public ServiceMasterUser(IMasterRepository<MasterUser> entityRepo,
            IMasterUnitOfWork unitOfWork,
            IMasterUserBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IServiceMasterCompany serviceCompany, IUserBuilder userBuilder,
            IServiceMasterUserCompany serviceMasterUserCompany,
            IServiceCompanyLicence serviceCompanyLicence,
            IServiceMasterRoleUser serviceMasterRoleUser,
            IMasterRoleUserBuilder masterRoleUserBuilder, IRepository<User> entityRepoUser, IMemoryCache memoryCache) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceMasterCompany = serviceCompany;
            _userBuilder = userBuilder;
            _serviceMasterUserCompany = serviceMasterUserCompany;
            _serviceCompanyLicence = serviceCompanyLicence;
            _serviceMasterRoleUser = serviceMasterRoleUser;
            _masterRoleUserBuilder = masterRoleUserBuilder;
            _entityRepoUser = entityRepoUser;
            _memoryCache = memoryCache;
        }


        /// <summary>
        /// Manages user authentication
        /// </summary>
        /// <param name="masterUser"></param>
        /// <returns></returns>
        public CredentialsViewModel Authenticate(CredentialsViewModel masterUser)
        {
            MasterUser user = _entityRepo.GetAllAsNoTracking()
                .Include(x => x.MasterUserCompany)
                    .ThenInclude(x => x.IdMasterCompanyNavigation)
                        .ThenInclude(x => x.IdMasterDbSettingsNavigation)
                 .Include(x => x.MasterUserCompany)
                    .ThenInclude(x => x.IdMasterCompanyNavigation)
                        .ThenInclude(x => x.CompanyLicence)
                .Where(m => m.Email.ToLower() == masterUser.Email.ToLower()
                    && m.Password == GetSHA512Hash(masterUser.Password) && !m.IsDeleted).FirstOrDefault();
            if (user is null)
                return null;
            user.MasterUserCompany = user.MasterUserCompany.Where(x => !x.IsDeleted && x.IsActif == true).ToList();
            MasterUserViewModel masterUserViewModel = _builder.BuildEntity(user);
            masterUserViewModel.CompanyAssociatedCode = new List<ReducedCompany>();
            masterUserViewModel.MasterUserCompany.ToList().ForEach(userCompany =>
            {
                masterUserViewModel.CompanyAssociatedCode.Add(new ReducedCompany
                {
                    Code = userCompany.IdMasterCompanyNavigation.Code,
                    Name = userCompany.IdMasterCompanyNavigation.Name
                });
            });
            masterUserViewModel.LastConnectedCompany = masterUserViewModel.LastConnectedCompany ?? masterUserViewModel.CompanyAssociatedCode.FirstOrDefault().Code;
            masterUserViewModel.Password = masterUser.Password;
            return _builder.BuildMasterSlaveModel(masterUserViewModel, Activator.CreateInstance<CredentialsViewModel>());
        }

        /// <summary>
        /// Add the list of users to the master database
        /// It takes as a parameter to support the case of massive addition and unit addition
        /// </summary>
        /// <param name="masterUserViewModels"></param>
        public void AddUserToMasterBase(IList<MasterUserViewModel> masterUserViewModels)
        {
            string userEmail = ActiveAccountHelper.GetConnectedUserEmail();
            string codeCompany = _memoryCache.Get(userEmail).ToString();
            IList<MasterUserViewModel> masterUsersToUpdate = FindModelsByNoTracked(x => masterUserViewModels.Select(u => u.Email.ToLower()).Contains(x.Email.ToLower()) && !x.IsDeleted);
            MasterCompanyViewModel company = _serviceMasterCompany.GetModel(x => x.Code == codeCompany);
            masterUsersToUpdate.ToList().ForEach(userMaster =>
            {
                MasterUserViewModel model = masterUserViewModels.First(x => x.Email.ToLower()== userMaster.Email.ToLower());
                // if user exist and it's not b2b throw exception
                if (userMaster.IsBtoB != true && !model.IsBtoB)
                {
                    throw new CustomException(CustomStatusCode.userExitsInMasterBase);
                }
                else
                {
                    // if b2b user already exist add new relation
                    userMaster.MasterUserCompany.Add(new MasterUserCompanyViewModel
                    {
                        IdMasterCompany = company.Id
                    });
                }
            });
            masterUserViewModels = masterUserViewModels.Where(x => !masterUsersToUpdate.Any(u => string.Compare(x.Email, u.Email, true, CultureInfo.InvariantCulture) == NumberConstant.Zero)).ToList();
            if (!FindModelsByNoTracked(x => masterUserViewModels.Select(u => u.Id).Contains(x.Id) == false && masterUserViewModels.Select(u => u.Email.ToLower()).Contains(x.Email.ToLower()) && !x.IsDeleted).Any())
            {
                // Check if adding this number of users will not exceed the maximum authorized by the license
                CheckNomberOfUserAlloawed(company.Id, false, numberOfUserToAdd: masterUserViewModels.Count);
                masterUserViewModels.ToList().ForEach(userMaster =>
                {
                    userMaster.AccountNonExpired = true;
                    userMaster.AccountNonLocked = true;
                    userMaster.Enabled = true;
                    userMaster.CredentialsNonExpired = true;
                    userMaster.MasterUserCompany = new List<MasterUserCompanyViewModel>
                    {
                        new MasterUserCompanyViewModel
                        {
                            IdMasterCompany = company.Id
                        }
                    };
                    if (userMaster.MasterRoleUser != null && userMaster.MasterRoleUser.Any())
                    {

                        userMaster.MasterRoleUser.ToList().ForEach(x =>
                        {
                            x.IdMasterCompany = company.Id;

                        });
                    }
                });
            }
            else
            {
                throw new CustomException(CustomStatusCode.UserEmailUnicity);
            }
            base.BulkUpdateModelWithoutTransaction(masterUsersToUpdate, null);
            base.BulkAddWithoutTransaction(masterUserViewModels, null);
        }


        public void CheckExpiredDate(string codeCompany)
        {
            var companyLicence = _serviceCompanyLicence.GetModel(x => x.IdMasterCompanyNavigation.Code.Equals(codeCompany));
            if (companyLicence != null)
            {
                if (companyLicence.ExpirationDate != null && companyLicence.ExpirationDate.Value < DateTime.Now.Date)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.EXPIRATION_DATE, companyLicence.ExpirationDate},
                    };
                    throw new CustomException(CustomStatusCode.InvalidLicense, paramtrs);
                }
            }
        }

        /// <summary>
        /// Check if the number of users allowed by the license allows the addition of numberOfUserToAdd users
        /// </summary>
        /// <param name="idCompany"></param>
        /// <param name="isBtoB"></param>
        /// <param name="numberOfUserToAdd"></param>
        private void CheckNomberOfUserAlloawed(int idCompany, bool isBtoB, int numberOfUserToAdd = 1)
        {
            int nomberOfUser = 0;
            int nomberofLicence = 0;
            var masterCompanyLicence = _serviceCompanyLicence.GetModelsWithConditionsRelations(x => x.IdMasterCompany == idCompany).FirstOrDefault();
            if (masterCompanyLicence != null)
            {
                if (isBtoB == true)
                {
                    nomberofLicence = masterCompanyLicence.NombreB2buser;
                    nomberOfUser = _serviceMasterUserCompany.GetAllModelsQueryable(x => x.IdMasterUserNavigation).Count(x => x.IdMasterCompany == idCompany && x.IdMasterUserNavigation.IsBtoB == true);
                }
                else
                {
                    nomberofLicence = masterCompanyLicence.NombreErpuser;
                    nomberOfUser = _serviceMasterUserCompany.GetAllModelsQueryable(x => x.IdMasterUserNavigation).Count(x => x.IdMasterCompany == idCompany && x.IdMasterUserNavigation.IsBtoB == false && x.IsActif == true);
                }
            }
            if (nomberofLicence < nomberOfUser + numberOfUserToAdd)
            {
                throw new CustomException(CustomStatusCode.LicenseMaximumUsersNumberViolation);
            }
        }

        public void UpdateOrInsertMasterUser(MasterUserViewModel model)
        {
            MasterUserViewModel masterUserViewModel = FindModelsByNoTracked(x => x.Email == model.Email && !x.IsDeleted).FirstOrDefault();
            if (masterUserViewModel is null)
            {
                throw new CustomException(CustomStatusCode.NotModified);
            }
            MasterCompanyViewModel company = _serviceMasterCompany.GetModelAsNoTracked(x => x.Code == model.LastConnectedCompany);
            MasterUserCompanyViewModel userCompanyExists = _serviceMasterUserCompany.FindModelsByNoTracked(x => x.IdMasterUser == masterUserViewModel.Id && x.IdMasterCompany == company.Id && !x.IsDeleted).FirstOrDefault();
            CheckNomberOfUserAlloawed(company.Id, false);
            if (userCompanyExists == null)
            {
                masterUserViewModel.MasterUserCompany.Add(new MasterUserCompanyViewModel
                {
                    CodeCompany = company.Code,
                    IdMasterCompany = company.Id,
                    IdMasterUser = masterUserViewModel.Id
                });
                masterUserViewModel.MasterRoleUser = model.MasterRoleUser;
                base.UpdateModelWithoutTransaction(masterUserViewModel, null, null);
            }
        }

        private bool CheckUnicityOfUsersMail(MasterUserViewModel masterUserViewModel)
        {
            MasterUserViewModel user = FindModelsByNoTracked(x => x.Id != masterUserViewModel.Id && x.Email == masterUserViewModel.Email && !x.IsDeleted).FirstOrDefault();
            if (user == null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// à revoir
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<MasterUserViewModel> GetMasterUserList(PredicateFormatViewModel predicateModel, string userMail, CompanyViewModel currentCompany, PredicateFilterRelationViewModel<User> predicateFilterRelationModelUser)
        {
            List<int> connectedUser = GetModelWithRelationsAsNoTracked(x => x.Email == userMail, x => x.MasterUserCompany).MasterUserCompany.Select(x => x.IdMasterCompany).ToList();
            PredicateFilterRelationViewModel<MasterUser> predicateFilterRelationModel = PreparePredicate(predicateModel);
            var notDeletedMasterUsers = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere,
                 predicateFilterRelationModel.PredicateRelations)
                .Where(x => !x.IsDeleted)
                .Include(x => x.MasterUserCompany)
                .ThenInclude(x => x.IdMasterCompanyNavigation)
                .Where(x => x.MasterUserCompany.Any(z => connectedUser.Contains(z.IdMasterCompany) && !z.IsDeleted))
                .OrderByRelation(predicateModel.OrderBy);

            List<string> usersEmails = _entityRepoUser
                .GetAllWithConditionsRelationsQueryable(predicateFilterRelationModelUser.PredicateWhere,
                                         predicateFilterRelationModelUser.PredicateRelations).Select(x => x.Email).ToList();
            var usersOfCurrentCompany = notDeletedMasterUsers.Where(x => x.MasterUserCompany.FirstOrDefault(z => z.IdMasterCompanyNavigation.Code == currentCompany.Code) != null);
            var usersEmailsToRemove = usersOfCurrentCompany.Where(x => !usersEmails.Contains(x.Email)).Select(m => m.Email).ToList();
            IList<MasterUser> masterUser = notDeletedMasterUsers.Where(x => !usersEmailsToRemove.Contains(x.Email)).Skip((predicateModel.page - NumberConstant.One) * predicateModel.pageSize)
                .Take(predicateModel.pageSize).ToList();
            IList<MasterUserViewModel> masterUserViewModels = new List<MasterUserViewModel>();
            foreach (MasterUser user in masterUser)
            {
                user.MasterUserCompany = user.MasterUserCompany.Where(x => !x.IsDeleted).ToList();
                MasterUserViewModel userViewModel = _builderMaster.BuildEntity(user);
                userViewModel.CompanyAssociatedCode = new List<ReducedCompany>();
                userViewModel.MasterUserCompany.ToList().ForEach(userCompany =>
                {
                    if (!userViewModel.CompanyAssociatedCode.Any(m => m.Code == userCompany.IdMasterCompanyNavigation.Code))
                    {
                        userViewModel.CompanyAssociatedCode.Add(new ReducedCompany
                        {
                            Code = userCompany.IdMasterCompanyNavigation.Code,
                            Name = userCompany.IdMasterCompanyNavigation.Name
                        });
                    }
                });
                masterUserViewModels.Add(userViewModel);
            }
            return new DataSourceResult<MasterUserViewModel> { data = masterUserViewModels, total = notDeletedMasterUsers.Count() };
        }

        public void DeleteMasterUserRelation(string email, string currentCompanyCode)
        {
            MasterUserViewModel masterUser = FindModelBy(result => result.Email.Equals(email)).FirstOrDefault();
            if (masterUser != null)
            {
                MasterUserViewModel masterUserViewModel = FindModelsByNoTracked(x => x.Email == email, x => x.MasterUserCompany).FirstOrDefault();
                MasterCompanyViewModel MasterCompanyViewModel = _serviceMasterCompany.FindModelsByNoTracked(x => x.Code == currentCompanyCode).FirstOrDefault();
                MasterUserCompanyViewModel userCompany = _serviceMasterUserCompany.FindModelsByNoTracked(x => x.IdMasterUser == masterUserViewModel.Id && x.IdMasterCompany == MasterCompanyViewModel.Id && !x.IsDeleted).FirstOrDefault();
                List<MasterRoleUserViewModel> masterRoleUser = _serviceMasterRoleUser.GetAllModelsQueryableWithRelation(x => x.IdMasterUser == masterUser.Id && x.IdMasterCompanyNavigation.Code == currentCompanyCode).ToList();
                if (userCompany != null)
                {
                    IList<MasterUserCompanyViewModel> userCompanyList = _serviceMasterUserCompany.FindModelsByNoTracked(x => x.IdMasterUser == masterUserViewModel.Id && x.Id != userCompany.Id && !x.IsDeleted).ToList();
                    _serviceMasterUserCompany.DeleteModelwithouTransaction(userCompany.Id, nameof(MasterUserCompany), null);
                    _serviceMasterRoleUser.BulkDeleteWithoutTransaction(masterRoleUser.Select(x => _masterRoleUserBuilder.BuildModel(x)).ToList());
                    if (!userCompanyList.Any())
                    {
                        DeleteModelwithouTransaction(masterUserViewModel.Id, nameof(MasterUser), null);
                    }
                }
            }
        }

        /// <summary>
        ///  
        /// </summary>
        /// <param name="masterUserViewModel"></param>
        public void SynchronizeWithMaster(IList<UserViewModel> userViewModels, string currentCompanyCode)
        {
            MasterCompanyViewModel company = _serviceMasterCompany.GetModelAsNoTracked(x => x.Code == currentCompanyCode);
            IList<MasterUserViewModel> masterUserList = new List<MasterUserViewModel>();
            IList<MasterUserCompanyViewModel> masterUserCompanyList = new List<MasterUserCompanyViewModel>();
            foreach (UserViewModel user in userViewModels)
            {
                MasterUserViewModel masterUser = FindModelsByNoTracked(result => result.Email.Equals(user.Email) && !result.IsDeleted, x => x.MasterUserCompany).FirstOrDefault();
                if (masterUser is null)
                {
                    user.Id = NumberConstant.Zero;
                    user.MasterUserCompany = new List<MasterUserCompanyViewModel>
                    {
                        new MasterUserCompanyViewModel
                        {
                            CodeCompany = company.Code,
                            IdMasterCompany = company.Id,
                        }
                    };
                    user.AccountNonExpired = true;
                    user.AccountNonLocked = true;
                    user.Enabled = true;
                    user.CredentialsNonExpired = true;
                    masterUserList.Add(_builder.BuildMasterSlaveModel(user, Activator.CreateInstance<MasterUserViewModel>()));
                }
                else if (!masterUser.MasterUserCompany.Any(x => x.IdMasterCompany == company.Id))
                {
                    masterUserCompanyList.Add(new MasterUserCompanyViewModel
                    {
                        CodeCompany = company.Code,
                        IdMasterCompany = company.Id,
                        IdMasterUser = masterUser.Id
                    });
                }
            }
            BulkAddWithoutTransaction(masterUserList);
            _serviceMasterUserCompany.BulkAddWithoutTransaction(masterUserCompanyList);
        }

        public void ChangeLastConnectedCompany(string email, string codeCompany)
        {
            MasterUserViewModel userLastConnectedCompanyChange = FindModelsByNoTracked(x => x.Email == email).FirstOrDefault();
            userLastConnectedCompanyChange.LastConnectedCompany = codeCompany;
            UpdateModelWithoutTransaction(userLastConnectedCompanyChange, null, null);
        }

        /// <summary>
        /// Update the user password
        /// </summary>
        /// <param name="model"></param>
        public void UpdatePassword(dynamic objectToSave, bool hasPermission)
        {
            try
            {
                BeginTransaction();
                // User send by the password changement modal
                MasterUserViewModel userWithNewPassword = JsonConvert.DeserializeObject<MasterUserViewModel>(objectToSave.ToString());
                // GetUser before password Updating
                MasterUser masterUser = _entityRepo.FindSingleBy(x => x.Email.ToLower() == userWithNewPassword.Email.ToLower() && !x.IsDeleted);
                string currentUserEmail = ActiveAccountHelper.GetConnectedUserEmail();
                if (!hasPermission && currentUserEmail != masterUser.Email)
                {
                    throw new CustomException(CustomStatusCode.CannotChangePassword);

                }
                if (masterUser is null)
                {
                    throw new CustomException(CustomStatusCode.UsersNotSynchronized);
                }
                if (userWithNewPassword.Password != null && !VerifySHA512Hash(userWithNewPassword.Password, masterUser.Password))
                {
                    // Check if the password entered conforms to which exists in DB
                    throw new CustomException(CustomStatusCode.CheckOldPassword);
                }
                string confirmNewPassword = JsonConvert.DeserializeObject<dynamic>(objectToSave.ToString()).ConfirmNewPassword;
                // check if the two passwords are coform
                if (string.Compare(userWithNewPassword.NewPassword, confirmNewPassword, StringComparison.InvariantCultureIgnoreCase) != NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.PasswordConfirmityError);
                }
                // check if the new password is different from the old one
                if (VerifySHA512Hash(userWithNewPassword.NewPassword, masterUser.Password))
                {
                    throw new CustomException(CustomStatusCode.SameOldPassword);
                }
                // change password in dataBase
                masterUser.Password = GetSHA512Hash(userWithNewPassword.NewPassword);
                _entityRepo.Update(masterUser);
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch
            {
                RollBackTransaction();
                throw;
            }
        }

        public bool DeleteUserFromMasterBase(string Email)
        {
            MasterUserViewModel userToDelete = FindModelsByNoTracked(x => x.Email == Email, x => x.MasterUserCompany).FirstOrDefault();
            if (userToDelete != null && !userToDelete.MasterUserCompany.Any())
            {
                DeleteModel(userToDelete.Id, nameof(MasterUser), null);
                return true;
            }
            return false;
        }
        /// <summary>
        /// deactivate user with change of isActif attribute
        /// </summary>
        /// <param name="model"></param>
        /// <param name="currentCompany"></param>
        /// <returns></returns>
        public void UpdateActifMasterUser(string email, string codeCompany)
        {
            MasterUserViewModel masterUserViewModel = FindModelsByNoTracked(x => x.Email == email && !x.IsDeleted).FirstOrDefault();
            if (masterUserViewModel != null)
            {


                if (masterUserViewModel != null)
                {
                    MasterUserCompanyViewModel userCompanyExists = _serviceMasterUserCompany.FindModelsByNoTracked(x => x.IdMasterUser == masterUserViewModel.Id
                    && x.IdMasterCompanyNavigation.Code == codeCompany && !x.IsDeleted).FirstOrDefault();
                    userCompanyExists.IsActif = !userCompanyExists.IsActif;
                    _serviceMasterUserCompany.UpdateModelWithoutTransaction(userCompanyExists, null, null);
                    CheckNomberOfUserAlloawed(userCompanyExists.IdMasterCompany, false);
                }
            }
        }

        /// <summary>
        /// Validates the license of the database to which the user is connecting
        /// </summary>
        /// <param name="usersToAddNumber"></param>
        /// <param name="login"></param>
        public void ValidateLicense(int usersToAddNumber, CredentialsViewModel login)
        {
            ReadAndValidateLicenseFile(usersToAddNumber);
            try
            {
                CheckExpiredDate(login.LastConnectedCompany);
            }
            catch
            {
                // If the license of the lastConnectedCompany is not valid, switch to the other databases to which the user has access
                login.MasterUserCompany = login.MasterUserCompany.Where(x => x.CodeCompany != login.LastConnectedCompany).ToList();
                // If the user has access to an unlicensed database, switch directly to this database
                MasterUserCompanyViewModel companyWithoutLicence = login.MasterUserCompany.FirstOrDefault(x => x.IdMasterCompanyNavigation.CompanyLicence is null ||
                    !x.IdMasterCompanyNavigation.CompanyLicence.Any());
                if (companyWithoutLicence != null)
                {
                    login.LastConnectedCompany = companyWithoutLicence.CodeCompany;
                }
                else
                {
                    // If all the licenses of the databases to which the user has access have expired, throw the original exception, otherwise choose a company among those available
                    IList<MasterUserCompanyViewModel> validLicences = login.MasterUserCompany.Where(x => x.IdMasterCompanyNavigation.CompanyLicence.Any(cl => cl.ExpirationDate != null
                        && cl.ExpirationDate.Value.AfterDate(DateTime.Now))).ToList();
                    if (validLicences.Count > 0)
                    {
                        login.LastConnectedCompany = validLicences.First().CodeCompany;
                    }
                    else
                    {
                        throw;
                    }
                }
            }
        }

        /// <summary>
        /// Read and validate licence config file
        /// </summary>
        /// <param name="usersToAddNumber"></param>
        private void ReadAndValidateLicenseFile(int usersToAddNumber)
        {
            var masterUsers = GetModelsWithConditionsRelations(x => !x.IsDeleted);
            string licensePath = Path.Combine(".", "Env", "license");
            if (!File.Exists(licensePath))
            {
                throw new CustomException(CustomStatusCode.InvalidLicense);
            }
            using (StreamReader r = new StreamReader(licensePath))
            {
                string licenseString = r.ReadToEnd();
                License license;
                try
                {
                    license = License.Load(licenseString.DecodeLicense());
                }
                catch
                {
                    throw new CustomException(CustomStatusCode.InvalidLicense);
                }
                if (!IsValidLicense(license))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.EXPIRATION_DATE, license.Expiration},
                    };

                    throw new CustomException(CustomStatusCode.InvalidLicense, paramtrs);
                }
                if (license.Quantity < masterUsers.Count + usersToAddNumber)
                {
                    throw new CustomException(CustomStatusCode.LicenseMaximumUsersNumberViolation);
                }
            }
        }

        internal bool IsValidLicense(License license)
        {
            string keyPath = Path.Combine(".", "Env", "key.enc");
            if (!File.Exists(keyPath))
            {
                throw new CustomException(CustomStatusCode.InvalidLicense);
            }
            using (StreamReader r = new StreamReader(keyPath))
            {
                string key = r.ReadToEnd();
                var validationFailures = license.Validate()
                                    .ExpirationDate()
                                    .When(lic => lic.Type == LicenseType.Standard)
                                    .And()
                                    .Signature(key)
                                    .AssertValidLicense();
                try
                {
                    return !validationFailures.Any();
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// Get user associates companies as List of ReducedCompany
        /// </summary>
        /// <param name="credentials"></param>
        /// <returns></returns>
        public List<ReducedCompany> GetCompanyList()
        {
            MasterUserViewModel user = JsonConvert.DeserializeObject<MasterUserViewModel>(DecryptToken()["user"].ToString());
            if (user != null)
            {
                MasterUser masterUser = _entityRepo.GetAllAsNoTracking()
                   .Include(x => x.MasterUserCompany)
                   .ThenInclude(x => x.IdMasterCompanyNavigation)
                   .FirstOrDefault(m => m.Email.ToLower() == user.Email.ToLower());
                if (masterUser is null ||
                    masterUser.MasterUserCompany.All(x => x.IsActif == false) ||
                    !masterUser.MasterUserCompany.Any(x => x.IsActif == true && !x.IsDeleted && x.IdMasterCompanyNavigation.Code == user.LastConnectedCompany))
                {
                    throw new CustomException(CustomStatusCode.SessionExpired);
                }
                masterUser.MasterUserCompany = masterUser.MasterUserCompany.Where(x => x.IsActif == true && !x.IsDeleted).ToList();
                return masterUser.MasterUserCompany.Select(x => new ReducedCompany { Code = x.IdMasterCompanyNavigation.Code, Name = x.IdMasterCompanyNavigation.Name }).ToList();
            }
            return null;
        }

        /// <summary>
        /// get entity by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public MasterUser getEntityById(int id)
        {
            MasterUser masterUser = _entityRepo.GetSingleNotTracked(x => x.Id == id);
            return masterUser;
        }

        public int GetMasterUserId(string email)
        {
            MasterUser masterUser = _entityRepo.GetSingleNotTracked(x => x.Email == email);
            return masterUser != null ? masterUser.Id : NumberConstant.Zero;
        }

        public string GetLastConnectedCompany(string email)
        {
            return _entityRepo.GetSingleNotTracked(x => x.Email == email).LastConnectedCompany;
        }

        public void UpdateCurrentUserCompanyInMemoryCach(string companyCode)
        {
            string userEmail = DecryptToken()["user"].Email;
            _memoryCache.Remove(userEmail);
            _memoryCache.Set(userEmail, companyCode);
        }
    }
}
