using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Helpdesk.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Helpdesk;
using Web.Controllers.GenericController;

namespace Web.Controllers.Helpdesk.Classes
{
    [Route("api/claimstatus")]
    public class ClaimStatusController : BaseController
    {
        const string roles = "roles";
        const string claimTypeCodeConst = "ClaimType";
        const string idConst = "Id";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceClaimStatus _serviceClaimStatus;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ClaimStatusController(IServiceProvider serviceProvider, IServiceClaimStatus serviceClaimStatus, ILogger<ClaimStatusController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceClaimStatus = serviceClaimStatus;
        }


        [HttpGet("getClaimStatusById/{id}")]
        public ResponseData GetClaimTypeById(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _serviceClaimStatus.GetClaimStatusById(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpPost("insertClaimStatus"), Authorize("ADD")]
        public ResponseData PostClaimStatus([FromBody] ClaimStatusViewModel model)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            ClaimStatusViewModel instanceType = _serviceClaimStatus.FindByAsNoTracking(x => x.Id == model.Id).FirstOrDefault();

            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = _serviceClaimStatus.AddClaimStatus(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("updateClaimStatus"), Authorize("UPDATE")]
        public ResponseData PutClaimStatus([FromBody] ClaimStatusViewModel model)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            ClaimStatusViewModel instanceType = _serviceClaimStatus.FindByAsNoTracking(x => x.Id == model.Id).FirstOrDefault();
            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceClaimStatus.UpdateClaimStatus(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("getClaimStatusList"), Authorize("LIST")]
        public ResponseData GetClaimStatusList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }


            var dataSourceResult = _serviceClaimStatus.GetClaimStatusList(model);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }


        [HttpGet("getById/{id}")]
        public override ResponseData GetById(int id)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                PredicateFormatViewModel model = new PredicateFormatViewModel();
                List<FilterViewModel> filtersItem = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = id, IsDynamicValue = true }
                };
                model.Filter = filtersItem;

                ResponseData result = base.GetPredicate(model);
                if (result.listObject != null && result.listObject.listData != null
                    && ((dynamic)result.listObject.listData).GetType().GetProperty("Count").GetValue(result.listObject.listData) > 0)
                {
                    result.objectData = ((dynamic)result.listObject.listData)[0];

                }
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
                return result;
            }
        }


        [HttpPost("getStatusDropdownForClaims"), Authorize(Roles = "DROPDOWNLIST")]
        public virtual ResponseData GetStatusDropdownForClaims([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceClaimStatus.GetStatusDropdownForClaims(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }



        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate containing also grid filters</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// It return object containing a collections of items in listObject.listData attribute and the number of items in the listObject.listData attribut</returns>
        [HttpPost("getItemsList"), Authorize(Roles = "LIST")]
        public virtual ResponseData GetItemsList([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceClaimStatus.FindNoTrackedModelBy(model.Filter.ToList());
                result.listObject = new ListObject
                {
                    listData = dataSourceResult,
                    total = _serviceClaimStatus.GetAllModels().Count()
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_CLAIM_PURCHASE")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }




        }
}
