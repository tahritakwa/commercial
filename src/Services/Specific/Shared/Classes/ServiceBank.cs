using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceBank : Service<BankViewModel, Bank>, IServiceBank
    {
        private readonly IRepository<BankAccount> _repoBankAccount;
        private readonly IRepository<BankAgency> _repoBankAgency;
        private readonly IRepository<Contact> _repoContact;
        private readonly IServiceBankAgency _serviceBankAgency;
        private readonly IServiceContact _serviceContact;
        private readonly IReducedBankBuilder _reducedBankBuilder;
        public ServiceBank(
               IRepository<Bank> entityRepo,
               IUnitOfWork unitOfWork,
               IBankBuilder builder,
               IRepository<EntityAxisValues> entityRepoEntityAxisValues,
               IEntityAxisValuesBuilder builderEntityAxisValues,
               IOptions<AppSettings> appSettings,
               IRepository<Company> entityRepoCompany,
               IRepository<BankAccount> repoBankAccount,
               IReducedBankBuilder reducedBankBuilder,
               IServiceBankAgency serviceBankAgency,
               IRepository<BankAgency> repoBankAgency,
               IServiceContact serviceContact,
               IRepository<Contact> repoContact)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _repoBankAccount = repoBankAccount;
            _reducedBankBuilder = reducedBankBuilder;
            _serviceBankAgency = serviceBankAgency;
            _repoContact = repoContact;
            _serviceContact = serviceContact;
            _repoBankAgency = repoBankAgency;
        }

        public override BankViewModel GetModelById(int id)
        {
            BankViewModel bank = _entityRepo.GetAllWithConditionsRelationsQueryable(x => x.Id == id)
                                            .Include(x => x.BankAgency).ThenInclude(x => x.Contact).ThenInclude(x => x.Phone)
                                            .Select(_builder.BuildEntity).FirstOrDefault();
            if (bank != null)
            {
                if (bank.BankAgency != null)
                {
                    bank.BankAgency.ToList().ForEach(bA =>
                    {
                        if (bA.Contact != null)
                        {
                            bA.Contact = _serviceContact.GetContactsPicture(bA.Contact.ToList());
                        }
                    });
                }
            }
            return bank;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBankBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        public object updateBankWithFiles(BankViewModel bank, string userMail)
        {

            try
            {
                BeginTransaction();
                managePicture(bank);
                ManageBankAgencysContactsPicture(bank.BankAgency);
                List<ContactViewModel> contacts = new List<ContactViewModel>();
                foreach (BankAgencyViewModel bankAgency in bank.BankAgency.Where(x => x.Id != 0))
                {
                    foreach (ContactViewModel contact in bankAgency.Contact)
                    {
                        contact.IdAgency = bankAgency.Id;
                    }
                    contacts.AddRange(bankAgency.Contact);

                    bankAgency.Contact = null;
                }
                _serviceContact.BulkUpdateModelWithoutTransaction(contacts, userMail);
                var result = base.UpdateModelWithoutTransaction(bank, null, userMail);
                EndTransaction();
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public object addBankWithFiles(BankViewModel bank, string userMail)
        {
            BeginTransaction();
            managePicture(bank);
            ManageBankAgencysContactsPicture(bank.BankAgency);
            var result = base.AddModelWithoutTransaction(bank, null, userMail);
            EndTransaction();
            return result;
        }
        /// <summary>
        /// Manage Bank Agency list Contacts lists Pictures
        /// </summary>
        /// <param name="bankAgencyList"></param>
        private void ManageBankAgencysContactsPicture(ICollection<BankAgencyViewModel> bankAgencyList)
        {
            if (bankAgencyList != null)
            {
                bankAgencyList.ToList().ForEach(bA =>
                {
                    if (bA.Contact != null)
                    {
                        foreach (ContactViewModel contact in bA.Contact)
                        {
                            _serviceContact.ManagePicture(contact);
                        }
                    }
                });
            }
        }

        public void managePicture(BankViewModel bank)
        {
            if (bank == null)
            {
                throw new Exception();
            }
            if (string.IsNullOrEmpty(bank.AttachmentUrl))
            {
                if (bank.LogoFileInfo != null)
                {
                    bank.AttachmentUrl = Path.Combine("Shared", "Bank", bank.Name, Guid.NewGuid().ToString());
                    CopyFiles(bank.AttachmentUrl, bank.LogoFileInfo);
                }
            }
            else
            {
                if (bank.LogoFileInfo != null)
                {
                    DeleteFiles(bank.AttachmentUrl, new List<FileInfoViewModel> { bank.LogoFileInfo });
                    CopyFiles(bank.AttachmentUrl, bank.LogoFileInfo);
                }
            }
        }

        public List<BankAgencyViewModel> getAgeniesfromBank(int id)
        {
            return _serviceBankAgency.GetAllModelsQueryable(x => x.IdBank == id).ToList();
        }
    }
}
