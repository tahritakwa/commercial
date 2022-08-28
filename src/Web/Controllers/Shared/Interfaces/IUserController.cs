using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Interfaces
{
    interface IUserController : IBaseController
    {
        void PartialUpdate(int id, [FromBody]JsonPatchDocument patches);
    }
}
