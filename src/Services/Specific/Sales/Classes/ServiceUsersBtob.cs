using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceUsersBtob : Service<UsersBtobViewModel, UsersBtob>, IServiceUsersBtob
    {
        private readonly IRepository<Tiers> _entityRepoTiers;
        public ServiceUsersBtob(IRepository<UsersBtob> entityRepo,
           IUnitOfWork unitOfWork,
           IUsersBtobBuilder usersBtobBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IRepository<Tiers> entityRepoTiers)
          : base(entityRepo, unitOfWork, usersBtobBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _entityRepoTiers = entityRepoTiers;
        }

        private SynchronizeUsersBtobResponseViewModel VerifyUnicityOfEmailForBtoB(UsersBtobViewModel model, SynchronizeUsersBtobResponseViewModel synchronizeUsersBtobResponse)
        {
            UsersBtobViewModel user = new UsersBtobViewModel();
            Tiers tier = new Tiers();
            ResponseMailOfUserBtob responseMailOfUser = new ResponseMailOfUserBtob();
            responseMailOfUser.Email = model.Email;
            user = FindModelsByNoTracked(x => x.Id != model.Id && x.Email == model.Email).FirstOrDefault();
            tier = _entityRepoTiers.FindByAsNoTracking(x => x.Id == model.IdClient).FirstOrDefault();
            if (tier == null || user != null || (!IsValidEmail(model.Email)))
            {
                synchronizeUsersBtobResponse.listOfEchec.Add(responseMailOfUser);
            }
            else
            {
                synchronizeUsersBtobResponse.listOfSuccess.Add(responseMailOfUser);
            }
            return synchronizeUsersBtobResponse;
        }
        bool IsValidEmail(string email)
        {
            if (email.Trim().EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        public SynchronizeUsersBtobResponseViewModel SynchronizeUserBtoB(List<UsersBtobViewModel> listOfUsers)
        {
            BeginTransaction();
            SynchronizeUsersBtobResponseViewModel synchronizeUsersBtobResponse = new SynchronizeUsersBtobResponseViewModel();
            synchronizeUsersBtobResponse.listOfEchec = new List<ResponseMailOfUserBtob>();
            synchronizeUsersBtobResponse.listOfSuccess = new List<ResponseMailOfUserBtob>();
            foreach (UsersBtobViewModel user in listOfUsers)
            {
                synchronizeUsersBtobResponse = VerifyUnicityOfEmailForBtoB(user, synchronizeUsersBtobResponse);
                user.FullName = new StringBuilder().Append(user.FirstName).Append(" ").Append(user.LastName).ToString();
            }
            List<string> emails = synchronizeUsersBtobResponse.listOfSuccess.Select(x => x.Email).ToList();
            List<UsersBtobViewModel> listOfSuccessUser = listOfUsers.Where(x => emails.Contains(x.Email)).ToList();
            List<UsersBtob> usersEntity = listOfSuccessUser.ToList().Select(_builder.BuildModel).ToList();
            _entityRepo.BulkAdd(usersEntity);
            _unitOfWork.Commit();
            EndTransaction();
            return synchronizeUsersBtobResponse;
        }
        public void UpdateUserBtoB(List<UsersBtobViewModel> listOfUsers)
        {
            BeginTransaction();
            List<string> emailsUsers = listOfUsers.Select(x => x.Email).ToList();
            List<UsersBtob> listOfOldUsers = _entityRepo.FindByAsNoTracking(x => emailsUsers.Contains(x.Email)).ToList();
            foreach (UsersBtobViewModel user in listOfUsers)
            {
                user.Id = listOfOldUsers.Where(x => x.Email == user.Email).Select(x => x.Id).FirstOrDefault();
            }
            // bulk update list of user
            base.BulkUpdateModelWithoutTransaction(listOfUsers, null);
            _unitOfWork.Commit();
            EndTransaction();
        }

    }
}
