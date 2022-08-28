using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using System.IO;
using System.Net;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Common;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceUser : IService<UserViewModel, User>
    {
        void UpdateToken(string Email, string Token);
        IEnumerable<UserViewModel> getListUsers(PredicateFormatViewModel predicateModel);
        DataSourceResult<UserViewModel> GetListUser(PredicateFormatViewModel predicateModel, string userMail);
        UserViewModel GetProfile(int Id, string userMail);
        void GetListOfUsersParent(int? idCurrentUser, List<UserViewModel> users,string? EmailCreator);
        void patchModel(UserViewModel mode);
        CredentialsViewModel LoginB2b(UserViewModel model, string conxString);
        void PrepareAndSendMail(MailBrodcastConfigurationViewModel configModel, string userMail, string action, UserViewModel newUser, SmtpSettings smtpSettings, string password);
        object UpdateB2BUser(UserViewModel userB2b);
        void PrepareAndSendMailToTheNewUser(string userMail, UserViewModel newUser, string password, SmtpSettings smtpSettings);
        object InsertUserInThisCompany(UserViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        bool SynchronizeWithMaster();
        IList<UserViewModel> GenerateUsersListFromExcel(Stream excelDataStream);
        void AddOrUpdateUserFromExcel(IEnumerable<UserViewModel> models, string userMail, SmtpSettings smtpSettings);
        CredentialsViewModel LoginEmployee(string connectionString, CredentialsViewModel model, string codeCompany);
        DataSourceResult<MasterUserViewModel> GetMasterUsers(dynamic objectToSave, string userMail);
        void UpdatePicture(FileInfoViewModel fileInfo);
        void RemovePicture(int idUser);
        object DeleteUserFromSlaveBase(string userMail);
        UserDetail signOut(string email);
        object ChangeStateOfUser(int userId);
        List<UserViewModel> GetUsersFromListId(List<int> listIdUsers);
        object DesactivateMassiveUsers(List<UserViewModel> listOfUsers);
        object ReactivateMassiveUsers(List<UserViewModel> listOfUsers);
        UserViewModel GetUserIfAssociateToEmployee(string userMail);
        CredentialsViewModel SetDotNetSessionInformation(CredentialsViewModel user, string connectionString);
        void UpdateUserLastConnectionInformations(string email, IPAddress iPAddress);
        void SendNotifToTheConnectedUserAfterAddingNewUserAccount(string userMail, UserViewModel newUser);
        DataSourceResult<UserViewModel> GetListUserWithRole(List<string> users);
        UserViewModel GetModelByEmail(string email);
        int GetUserIdByEmail( string email);
        bool ChangeUserLanguage(string usermail, string lang);
    }
}
