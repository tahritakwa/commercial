using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class CompanyBuilder : GenericBuilder<CompanyViewModel, Company>, ICompanyBuilder
    {
        private readonly IAddressBuilder _addressBuilder;
        private readonly IContactBuilder _contactBuilder;

        public CompanyBuilder(IAddressBuilder addressBuilder, IContactBuilder contactBuilder)
        {
            _addressBuilder = addressBuilder;
            _contactBuilder = contactBuilder;
        }
        public override Company BuildModel(CompanyViewModel model)
        {
            var company = base.BuildModel(model);
            
            if (model.DaysOfWeekWorked != null && model.DaysOfWeekWorked.Any())
            {
                model.DaysOfWeekWorked.OrderBy(x => x).ToList().ForEach(m => {
                    company.DaysWorkedInTheWeek += (int)m + ",";
                });
                company.DaysWorkedInTheWeek = company.DaysWorkedInTheWeek.Remove(company.DaysWorkedInTheWeek.Length - NumberConstant.One);
            }
            if (model.Contact.Any())
            {
                List<Contact> contacts = model.Contact.Select(c => _contactBuilder.BuildModel(c)).ToList();
                company.Contact = contacts;
            }
            return company;
        }

        public override CompanyViewModel BuildEntity(Company entity)
        {
            CompanyViewModel companyViewModel = base.BuildEntity(entity);
            IList<AddressViewModel> listaddress = new List<AddressViewModel>();
            if (!string.IsNullOrEmpty(entity.DaysWorkedInTheWeek))
            {
                companyViewModel.DaysOfWeekWorked = entity.DaysWorkedInTheWeek.Split(",").Select(x =>(DayOfWeek)Enum.Parse(typeof(DayOfWeek), x)).ToList();
            }
            if (entity.Address != null)
            {
                foreach (Address address in entity.Address)
                {
                   AddressViewModel addresviewmodel = _addressBuilder.BuildEntity(address);
                    listaddress.Add(addresviewmodel);
                }
                companyViewModel.Address = listaddress;
            }
            if (entity.Contact.Any())
            {
                List<ContactViewModel> contacts = entity.Contact.Select(c => _contactBuilder.BuildEntity(c)).ToList();
                companyViewModel.Contact = contacts;
            }
            return companyViewModel;
        }
    }
}
