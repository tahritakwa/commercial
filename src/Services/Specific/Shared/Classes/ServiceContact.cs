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
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceContact : Service<ContactViewModel, Contact>, IServiceContact
    {
        public ServiceContact(IRepository<Contact> entityRepo,
            IUnitOfWork unitOfWork,
            IContactBuilder contactBuilder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany)
             : base(entityRepo, unitOfWork, contactBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)

        {
        }
        public override IList<ContactViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IList<ContactViewModel> model = base.FindModelBy(predicateModel);
            foreach (ContactViewModel contact in model)
            {
                if (contact.ContactTypeDocument != null)
                {
                    List<ContactTypeDocumentViewModel> contactTypeDocument = (List<ContactTypeDocumentViewModel>)contact.ContactTypeDocument;
                    contact.ContactTypeDocument = contactTypeDocument.FindAll(p => p.IsDeleted == false);
                }
            }
            return model;
        }
        /// <summary>
        /// ManagePicture
        /// </summary>
        /// <param name="contact"></param>
        public void ManagePicture(ContactViewModel contact)
        {  
            if (string.IsNullOrEmpty(contact.UrlPicture))
            {
                if (contact.PictureFileInfo != null)
                {
                    contact.UrlPicture = Path.Combine("Shared", "Contact", contact.Label, Guid.NewGuid().ToString());
                    CopyFiles(contact.UrlPicture, contact.PictureFileInfo);
                }
            }
            else
            {
                CopyFiles(contact.UrlPicture, contact.PictureFileInfo);
            }
            if (contact.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        /// <summary>
        /// GetModelsWithConditionsRelations
        /// </summary>
        /// <param name="conditions"></param>
        /// <param name="relations"></param>
        /// <returns></returns>
        public override IList<ContactViewModel> GetModelsWithConditionsRelations(Expression<Func<Contact, bool>> conditions, params Expression<Func<Contact, object>>[] relations)
        {
            IList<ContactViewModel> contactList = base.GetModelsWithConditionsRelations(conditions, relations);

            foreach (ContactViewModel contact in contactList)
            {
                if (contact.UrlPicture != null)
                {
                    contact.PictureFileInfo = GetFiles(contact.UrlPicture).FirstOrDefault();
                }
            }
            return contactList;
        }

        public IList<ContactViewModel> GetContactsPicture(IList<ContactViewModel> contactList)
        {
            foreach (ContactViewModel contact in contactList)
            {
                if (contact.UrlPicture != null)
                {
                    contact.PictureFileInfo = GetFiles(contact.UrlPicture).FirstOrDefault();
                }
            }
            return contactList;
        }
        public string ContactBulkAdd(IList<ContactViewModel> contact, string property = null)
        {
            IList<Contact> ContactList = new List<Contact>();
            contact.ToList().ForEach(model =>
            {
                ContactList.Add(_builder.BuildModel(model));
            });
            // add entity
            string ContactIds = string.Empty;
            _entityRepo.BulkAdd(ContactList);
            // commit
            _unitOfWork.Commit();
            ContactList.ToList().ForEach(entity =>
            {
                ContactIds = ContactIds + entity.Id.ToString() + GenericConstants.Point;
            });
            return ContactIds;
        }
        public IList<ContactViewModel> GetOfficeContact(IList<int> contactIdslist)
        {
            return FindModelsByNoTracked(x => contactIdslist.Contains(x.Id), x => x.Phone);
        }
        public string ContactBulkUpdate(IList<ContactViewModel> contact, string property = null)
        {
            List<Contact> ContactList = new List<Contact>();
            contact.ToList().ForEach(model =>
            {
                ContactList.Add(_builder.BuildModel(model));
            });
            string ContactIds = string.Empty;
            // add entity
            _entityRepo.BulkUpdate(ContactList);
            // commit
            _unitOfWork.Commit();
            ContactList = ContactList.Where(x => !x.IsDeleted).ToList();
            ContactList.ToList().ForEach(entity =>
            {
                ContactIds = ContactIds + entity.Id.ToString() + GenericConstants.Point;
            });
            return ContactIds;
        }
        public override ContactViewModel GetModelById(int id)
        {
            ContactViewModel contactViewModel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.DateToRemember).Include(x => x.Phone)
                .Select(_builder.BuildEntity).FirstOrDefault();
            return contactViewModel;
        }
    }
}
