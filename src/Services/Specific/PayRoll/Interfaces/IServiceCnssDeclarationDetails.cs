using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceCnssDeclarationDetails : IService<CnssDeclarationDetailsViewModel, CnssDeclarationDetails>
    {
        IList<CnssDeclarationLinesViewModel> GetCnssDeclarationLines(int IdCnssDeclaration);
    }
}
