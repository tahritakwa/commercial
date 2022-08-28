using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSharedDocument : IService<SharedDocumentViewModel, SharedDocument>
    {
        object AddSharedDocumentAndSendMail(string url, SharedDocumentViewModel model, string userMail);
        DataSourceResult<SharedDocumentViewModel> GenerateSharedDocumentList(string userMail, DateTime? endDate, DateTime? startDate, PredicateFormatViewModel predicateModel);
        DataSourceResult<SharedDocumentViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel);

    }
}
