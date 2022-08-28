using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class CompanyLicenceViewModel : GenericMasterViewModel
    {
        public int IdMasterCompany { get; set; }
        public int NombreErpuser { get; set; }
        public int NombreB2buser { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime IntialDate { get; set; }
        public string DeletedToken { get; set; }

        public virtual MasterCompanyViewModel IdMasterCompanyNavigation { get; set; }
    }
}
