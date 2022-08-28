using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Helpdesk.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Helpdesk.Classes
{
    [Route("api/claimtype")]
    public class ClaimTypeController : BaseController
    {
        const string roles = "roles";
        const string claimTypeCodeConst = "ClaimType";
        const string idConst = "Id";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceClaimType _serviceClaimType;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ClaimTypeController(IServiceProvider serviceProvider, IServiceClaimType serviceClaimType, ILogger<ClaimController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceClaimType = serviceClaimType;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE,SHOW_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        //[HttpGet("getClaimTypeById/{id}")]
        //public ResponseData GetClaimTypeById(string id)
        //{
        //    ResponseData result = new ResponseData();
        //    if (!GetServiceName())
        //    {
        //        throw new CustomException(CustomStatusCode.InternalServerError);
        //    }
        //    else
        //    {
        //        result.flag = 1;
        //        result.objectData = _serviceClaimType.GetClaimTypeByCode(id);
        //        result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
        //    }
        //    return result;
        //}

        //[HttpPost("insertClaimType"), Authorize(Roles = "ADD")]
        //public ResponseData PostClaimType([FromBody] ClaimTypeViewModel model)
        //{

        //    if (model == null)
        //    {
        //        throw new ArgumentNullException(nameof(model));
        //    }

        //    ClaimTypeViewModel instanceType = _serviceClaimType.FindByAsNoTracking(x => x.CodeType == model.CodeType).FirstOrDefault();
        //    if (instanceType != null)
        //    {
        //        bool hasRole = SpecificAuthorizationCheck.ClaimTypeAuthorization(instanceType.Type, AutorizationActionConstants.AuthorizationAdd, Request.HttpContext);
        //        if (!hasRole)
        //        {
        //            return new ResponseData
        //            {
        //                customStatusCode = CustomStatusCode.Unauthorized
        //            };
        //        }
        //    }

        //    GetUserMail();

        //    ResponseData result;

        //    result = new ResponseData
        //    {
        //        customStatusCode = CustomStatusCode.AddSuccessfull,
        //        objectData = _serviceClaimType.AddClaimType(model, null, userMail),
        //        flag = 1
        //    };

        //    return result;
        //}

        //[HttpPost("updateClaimType"), Authorize(Roles = "UPDATE")]
        //public ResponseData PutClaimType([FromBody] ClaimTypeViewModel model)
        //{

        //    if (model == null)
        //    {
        //        throw new ArgumentNullException(nameof(model));
        //    }

        //    ClaimTypeViewModel instanceType = _serviceClaimType.FindByAsNoTracking(x => x.CodeType == model.CodeType).FirstOrDefault();
        //    if (instanceType != null)
        //    {
        //        bool hasRole = SpecificAuthorizationCheck.ClaimTypeAuthorization(instanceType.Type, AutorizationActionConstants.AuthorizationAdd, Request.HttpContext);
        //        if (!hasRole)
        //        {
        //            return new ResponseData
        //            {
        //                customStatusCode = CustomStatusCode.Unauthorized
        //            };
        //        }
        //    }

        //    GetUserMail();

        //    ResponseData result;

        //    result = new ResponseData
        //    {
        //        customStatusCode = CustomStatusCode.UpdateSuccessfull,
        //        objectData = _serviceClaimType.UpdateClaimType(model, null, userMail),
        //        flag = 1
        //    };

        //    return result;
        //}

        //[HttpPost("getClaimType"), Authorize(Roles = "LIST")]
        //public ResponseData GetClaimType()
        //{
        //    var dataSourceResult = _serviceClaimType.GetClaimType();
        //    ResponseData result = new ResponseData
        //    {
        //        listObject = new ListObject
        //        {
        //            listData = dataSourceResult.data,
        //            total = dataSourceResult.total
        //        },
        //        flag = 2,
        //        customStatusCode = CustomStatusCode.GetPredicateSuccessfull
        //    };
        //    return result;
        //}

        //[HttpPost("getClaimTypeList"), Authorize(Roles = "LIST")]
        //public ResponseData GetClaimTypeList([FromBody] PredicateFormatViewModel model)
        //{
        //    if (model == null)
        //    {
        //        throw new ArgumentNullException(nameof(model));
        //    }

        //    var dataSourceResult = _serviceClaimType.GetClaimTypeList(model);
        //    ResponseData result = new ResponseData
        //    {
        //        listObject = new ListObject
        //        {
        //            listData = dataSourceResult.data,
        //            total = dataSourceResult.total
        //        },
        //        flag = 2,
        //        customStatusCode = CustomStatusCode.GetPredicateSuccessfull
        //    };
        //    return result;
        //}


        //[HttpGet("getById/{id}")]
        //public override ResponseData GetById(int id)
        //{
        //    if (!GetServiceName())
        //    {
        //        throw new CustomException(CustomStatusCode.InternalServerError);
        //    }
        //    else
        //    {
        //        PredicateFormatViewModel model = new PredicateFormatViewModel();
        //        List<FilterViewModel> filtersItem = new List<FilterViewModel>
        //        {
        //            new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = id, IsDynamicValue = true }
        //        };
        //        model.Filter = filtersItem;

        //        ResponseData result = base.GetPredicate(model);
        //        if (result.listObject != null && result.listObject.listData != null
        //            && ((dynamic)result.listObject.listData).GetType().GetProperty("Count").GetValue(result.listObject.listData) > 0)
        //        {
        //            result.objectData = ((dynamic)result.listObject.listData)[0];

        //        }
        //        result.flag = 1;
        //        result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
        //        return result;
        //    }
        //}


        //[HttpPost("getTypeDropdownForClaims"), Authorize(Roles = "DROPDOWNLIST")]
        //public virtual ResponseData GetTypeDropdownForClaims([FromBody] PredicateFormatViewModel model)
        //{
        //    ResponseData result = new ResponseData();
        //    var dataSourceResult = _serviceClaimType.GetTypeDropdownForClaims(model);
        //    result.listObject = new ListObject
        //    {
        //        listData = dataSourceResult.data,
        //        total = dataSourceResult.total
        //    };
        //    result.flag = 2;
        //    result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

        //    return result;
        //}



        ///// <summary>
        ///// Gets this instance.
        ///// </summary>
        ///// <param name="model">The model: a json format that contains the where predicate,
        ///// orderBy predicate and the getWithRelations predicate containing also grid filters</param>
        ///// <returns>
        ///// ResponseData format that contains a message If an error occurs
        ///// or the specific data if it's a successful process
        ///// It return object containing a collections of items in listObject.listData attribute and the number of items in the listObject.listData attribut</returns>
        //[HttpPost("getItemsList"), Authorize(Roles = "LIST")]
        //public virtual ResponseData GetItemsList([FromBody] PredicateFormatViewModel model)
        //{
        //    ResponseData result = new ResponseData();
        //    if (!GetServiceName())
        //    {
        //        throw new CustomException(CustomStatusCode.InternalServerError);
        //    }
        //    else
        //    {
        //        var dataSourceResult = _serviceClaimType.FindNoTrackedModelBy(model.Filter.ToList());
        //        result.listObject = new ListObject
        //        {
        //            listData = dataSourceResult,
        //            total = _serviceClaimType.GetAllModels().Count()
        //        };
        //        result.flag = 2;
        //        result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
        //    }
        //    return result;
        //}



    }
}
