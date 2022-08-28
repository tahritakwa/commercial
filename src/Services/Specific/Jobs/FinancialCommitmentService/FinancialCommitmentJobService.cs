using Persistence.Context;
using Persistence.Entities;
using Persistence.Repository.Classes;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Classes;
using Persistence.UnitOfWork.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;

namespace Services.Specific.Jobs.FinancialCommitmentService
{
    public class FinancialCommitmentJobService : IDisposable
    {
        #region Constants
        public const string TYPE_TIERS_1_GUID_INFO = "f40d9aec-9f39-4e4b-a73d-6fcec5f73c32";
        public const string TYPE_TIERS_2_GUID_INFO = "0233afff-931a-48cc-86d9-c8a83b415efa";
        #endregion
        #region fileds
        /// <summary>
        /// _repo FinancialCommitment
        /// </summary>
        private IRepository<FinancialCommitment> _repoFinancialCommitment;
        /// <summary>
        /// _repo Information
        /// </summary>
        private IRepository<Information> _repoInformation;
        /// <summary>
        /// _repo Message
        /// </summary>
        private IRepository<Message> _repoMessage;
        /// <summary>
        /// _repo MsgNotification
        /// </summary>
        private IRepository<MsgNotification> _repoMsgNotification;
        /// <summary>
        /// _repo UserInfo
        /// </summary>
        private IRepository<UserInfo> _repoUserInfo;
        /// <summary>
        /// _repo User
        /// </summary>
        private IRepository<User> _repoUser;
        private IUnitOfWork _unitOfWork;
        #endregion

        #region Methodes
        /// <summary>
        /// Get FinancialCommitments with status 1 or 2
        /// </summary>
        /// <returns></returns>
        private IEnumerable<FinancialCommitment> GetNotSaledFinancialCommitments()
        {
            var result = _repoFinancialCommitment.GetAllWithConditionsRelationsAsNoTracking(x => (x.IdStatus == (int?)DocumentStatusEnumerator.Provisional || x.IdStatus == (int?)DocumentStatusEnumerator.Valid) && x.CommitmentDate <= DateTime.Now, x => x.IdDocumentNavigation, x => x.IdDocumentNavigation.IdTiersNavigation);
            return result;
        }
        /// <summary>
        /// create new repos
        /// </summary>
        /// <param name="value"></param>
        public void SetDbContext(StarkContextFactory value)
        {
            UnitOfWork unitOfWork = new UnitOfWork(value);
            _unitOfWork = unitOfWork;
            _repoFinancialCommitment = new Repository<FinancialCommitment>(unitOfWork);
            _repoInformation = new Repository<Information>(unitOfWork);
            _repoMessage = new Repository<Message>(unitOfWork);
            _repoMsgNotification = new Repository<MsgNotification>(unitOfWork);
            _repoUser = new Repository<User>(unitOfWork);
            _repoUserInfo = new Repository<UserInfo>(unitOfWork);
        }
        /// <summary>
        /// check for notifications
        /// </summary>
        /// <returns></returns>
        public async Task<List<MsgNotification>> Check()
        {
            List<MsgNotification> result = new List<MsgNotification>();
            List<FinancialCommitment> list = GetNotSaledFinancialCommitments().ToList();
            if (list.Count > 0)
            {
                foreach (FinancialCommitment item in list)
                {
                    Tiers tiers = item.IdDocumentNavigation.IdTiersNavigation;
                    Information informationViewModel = null;
                    if (tiers.IdTypeTiers == 1)
                    {
                        informationViewModel = _repoInformation.GetSingleNotTracked(x => x.IdFunctionality == new Guid(TYPE_TIERS_1_GUID_INFO));
                    }
                    else
                    {
                        informationViewModel = _repoInformation.GetSingleNotTracked(x => x.IdFunctionality == new Guid(TYPE_TIERS_2_GUID_INFO));
                    }
                    Message message = _repoMessage.GetSingleWithRelations(x => x.EntityReference == item.Id && x.IdInformation == informationViewModel.IdInfo, x => x.IdInformationNavigation);
                    if (message == null)
                    {
                        message = new Message()
                        {
                            IdCreator = 1,
                            IdInformation = informationViewModel.IdInfo,
                            EntityReference = item.Id,
                            CodeEntity = tiers.Name,
                            TypeMessage = (int)MessageTypeEnumerator.AlertFinancialCommitment
                        };
                        Message addedMessage = await _repoMessage.AddAsync(message);

                        List<User> listTargetUsers = GetTargetedUsers(informationViewModel.IdInfo).ToList();
                        foreach (User user in listTargetUsers)
                        {
                            MsgNotification msgNotification = new MsgNotification()
                            {
                                IdMsg = addedMessage.Id,
                                Viewed = false,
                                CreationDate = DateTime.Now,
                                IdTargetedUser = user.Id,
                            };
                            MsgNotification addMsgNotification = await _repoMsgNotification.AddAsync(msgNotification);
                            addMsgNotification.IdMsgNavigation.IdInformationNavigation = _repoMessage.GetSingleWithRelations(x => x.Id == addedMessage.Id, x => x.IdInformationNavigation).IdInformationNavigation;
                            result.Add(addMsgNotification);
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Get list users to notify or to send mails
        /// </summary>
        /// <param name="idInfo"></param>
        /// <returns></returns>
        public IEnumerable<User> GetTargetedUsers(int idInfo)
        {
            var listUsers = _repoUserInfo.FindBy(userInfo => userInfo.IdInformation == idInfo).Select(x => x.IdUser).ToList();
            //var idRole = _repoRoleInfo.FindBy(roleInfo => roleInfo.IdInformation == idInfo).Select(roleInfo => roleInfo.IdRole).ToList();
            //var listRoleUsers = _repoUserRole.GetAllWithConditionsRelationsAsNoTracking(userRole => idRole.Contains(userRole.IdRole)).Select(userRole => userRole.IdUser).ToList();
            IEnumerable<User> listTargetedUsers = _repoUser.FindBy(user => (listUsers).Any(id => user.Id == id)).AsEnumerable();
            return listTargetedUsers;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool isdisposing)
        {
            if (isdisposing)
            {
                _repoFinancialCommitment.Dispose();
                _repoInformation.Dispose();
                _repoMessage.Dispose();
                _repoMsgNotification.Dispose();
                _repoUser.Dispose();
                _repoUserInfo.Dispose();
                _unitOfWork.Dispose();
            }
        }
        #endregion
    }
}
