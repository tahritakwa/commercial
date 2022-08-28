using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;

namespace Web.Controllers.GenericController
{
    interface IBaseController
    {
        ResponseData Get([FromBody] PredicateFormatViewModel model);
        ResponseData Get();
        ResponseData Post(IList<IFormFile> files, [FromBody]ObjectToSaveViewModel objectSaved, string objectJsonToSave);
        ResponseData Put(IList<IFormFile> files, [FromBody]ObjectToSaveViewModel objectSaved, string objectJsonToSave);
        ResponseData Delete(int id);
        ResponseData GetPredicate([FromBody] PredicateFormatViewModel model);
        ResponseData GetSinglePredicate([FromBody] PredicateFormatViewModel model);
        ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate);
        bool GetUnicity([FromBody] dynamic objectToCheck);
    }
}
