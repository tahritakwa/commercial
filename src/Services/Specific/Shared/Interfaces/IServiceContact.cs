using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceContact : IService<ContactViewModel, Contact>
    {
         void ManagePicture(ContactViewModel contact);
        IList<ContactViewModel> GetContactsPicture(IList<ContactViewModel> contactList);
        string ContactBulkAdd(IList<ContactViewModel> contact, string property);
        IList<ContactViewModel> GetOfficeContact(IList<int> contactIdslist);
        string ContactBulkUpdate(IList<ContactViewModel> contact, string property);
    }
}
