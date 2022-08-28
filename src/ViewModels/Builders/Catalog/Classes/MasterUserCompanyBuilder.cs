using Persistence.CatalogEntities;
using System;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Generic.Classes;
using ViewModels.DTO.MasterViewModels;

namespace ViewModels.Builders.Catalog.Classes
{
    public class MasterUserCompanyBuilder : GenericBuilderMaster<MasterUserCompanyViewModel, MasterUserCompany>, IMasterUserCompanyBuilder
    {
        private readonly IMasterCompanyBuilder _companyBuilder;
        public MasterUserCompanyBuilder(IMasterCompanyBuilder companyBuilder)
        {
            _companyBuilder = companyBuilder;
        }
        public override MasterUserCompanyViewModel BuildEntity(MasterUserCompany entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            MasterUserCompanyViewModel userCompany = base.BuildEntity(entity);
            if (entity.IdMasterCompanyNavigation != null)
            {
                userCompany.IdMasterCompanyNavigation = _companyBuilder.BuildEntity(entity.IdMasterCompanyNavigation);
                userCompany.CodeCompany = entity.IdMasterCompanyNavigation.Code;
            }
            return userCompany;
        }
    }
}
