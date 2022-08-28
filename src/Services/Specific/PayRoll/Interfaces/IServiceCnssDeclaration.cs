using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceCnssDeclaration : IService<CnssDeclarationViewModel, CnssDeclaration>
    {
        object GenerateCnssDeclaration(CnssDeclarationViewModel model, string userMail);
        CnssDeclarationInformationsViewModel GetCnssDeclaration(int idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel);
        FileInfoViewModel GetTeleDeclaration(int idCnssDeclaration);
        void CloseCnssDeclaration(CnssDeclarationViewModel model, string userMail);
    }
}
