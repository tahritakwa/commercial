using Persistence.CatalogEntities;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Generic.Classes;
using ViewModels.DTO.MasterViewModels;

namespace ViewModels.Builders.Catalog.Classes
{
    public class MasterUserBuilder : GenericBuilderMaster<MasterUserViewModel, MasterUser>, IMasterUserBuilder
    {
        private readonly IMasterUserCompanyBuilder _userCompanyBuilder;
        private readonly IMasterRoleUserBuilder _masterRoleBuilder;
        public MasterUserBuilder(IMasterUserCompanyBuilder userCompanyBuilder,
            IMasterRoleUserBuilder masterRoleBuilder)
        {
            _userCompanyBuilder = userCompanyBuilder;
            _masterRoleBuilder = masterRoleBuilder;
        }

        public override MasterUserViewModel BuildEntity(MasterUser entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            MasterUserViewModel model = base.BuildEntity(entity);
            if (entity.MasterUserCompany != null)
            {
                IList<MasterUserCompanyViewModel> userCompanyList = new List<MasterUserCompanyViewModel>();
                foreach (MasterUserCompany userCompany in entity.MasterUserCompany)
                {
                    userCompanyList.Add(_userCompanyBuilder.BuildEntity(userCompany));
                }
                model.MasterUserCompany = userCompanyList;
            }
            if (entity.MasterRoleUser != null)
            {
                model.MasterRoleUser = entity.MasterRoleUser.Select(_masterRoleBuilder.BuildEntity).ToList();
            }
            return model;
        }
    }
}
