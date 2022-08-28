using Persistence.CatalogEntities;
using Persistence.Entities;
using Settings.Config;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Catalog.Interfaces
{
    public interface IServiceMasterUser : IServiceMaster<MasterUserViewModel, MasterUser>
    {
        CredentialsViewModel Authenticate(CredentialsViewModel masterUser);
        DataSourceResult<MasterUserViewModel> GetMasterUserList(PredicateFormatViewModel predicateModel, string userMail, CompanyViewModel currentCompany, PredicateFilterRelationViewModel<User> predicateFilterRelationModelUser);
        void DeleteMasterUserRelation(string email, string currentCompanyCode);
        void SynchronizeWithMaster(IList<UserViewModel> masterUserViewModel, string currentCompanyCode);
        void AddUserToMasterBase(IList<MasterUserViewModel> masterUserViewModels);
        void ChangeLastConnectedCompany(string email, string codeCompany);
        void UpdateOrInsertMasterUser(MasterUserViewModel model);
        bool DeleteUserFromMasterBase(string Email);
        void UpdateActifMasterUser(string email, string codeCompany);
        void ValidateLicense(int usersToAddNumber, CredentialsViewModel login);
        void CheckExpiredDate(string codeCompany);
        void UpdatePassword(dynamic objectToSave, bool hasPermission);
        List<ReducedCompany> GetCompanyList();
        MasterUser getEntityById(int id);
        int GetMasterUserId(string email);
        string GetLastConnectedCompany(string email);
        void UpdateCurrentUserCompanyInMemoryCach(string companyCode);
    }
}
