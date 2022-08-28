using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Helpdesk.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.SameClasse;
using Web.Controllers.GenericController;

namespace Web.Controllers.Helpdesk.Classes
{
    [Route("api/claim")]
    public class ClaimController : BaseController
    {
        const string roles = "roles";
        const string claimTypeCodeConst = "ClaimType";
        const string idConst = "Id";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceClaim _serviceClaim;

        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ClaimController(IServiceProvider serviceProvider, IServiceClaim serviceClaim, ILogger<ClaimController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceClaim = serviceClaim;
        }


        [HttpGet("getClaimById/{id}"), Authorize("SHOW_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE")]
        public ResponseData GetClaimById(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _serviceClaim.GetClaimById(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpPost("insertClaim"), Authorize("ADD_CLAIM_PURCHASE")]
        public ResponseData PostClaimDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {

            if (objectToSave == null || objectToSave.model == null)
            {
                throw new ArgumentNullException(nameof(objectToSave.model));
            }

            ClaimViewModel model = JsonConvert.DeserializeObject<ClaimViewModel>(objectToSave.model.ToString());
            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = _serviceClaim.AddClaim(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("updateClaim"), Authorize("UPDATE_CLAIM_PURCHASE,GENERATE_DOCUMENT_CLAIM")]
        public ResponseData PutClaimDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {

            if (objectToSave == null || objectToSave.model == null)
            {
                throw new ArgumentNullException(nameof(objectToSave.model));
            }

            ClaimViewModel model = JsonConvert.DeserializeObject<ClaimViewModel>(objectToSave.model.ToString());
            ClaimViewModel instanceType = _serviceClaim.FindByAsNoTracking(x => x.Id == model.Id && x.IdClaimStatus == model.IdClaimStatus
            && x.IdWarehouse == model.IdWarehouse).FirstOrDefault(c => c.DocumentDate.Value.Date == model.DocumentDate.Value.Date);
            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceClaim.UpdateClaim(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("addClaimTiersAsset"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public ResponseData AddClaimTiersAsset([FromBody] ObjectToSaveViewModel objectToSave)
        {

            if (objectToSave == null || objectToSave.model == null)
            {
                throw new ArgumentNullException(nameof(objectToSave.model));
            }

            ClaimViewModel model = JsonConvert.DeserializeObject<ClaimViewModel>(objectToSave.model.ToString());
            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceClaim.AddClaimTiersAsset(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("addClaimTiersMovement"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE,GENERATE_DOCUMENT_CLAIM")]
        public ClaimViewModel AddClaimTiersMovement([FromBody] ObjectToSaveViewModel objectToSave)
        {

            if (objectToSave == null || objectToSave.model == null)
            {
                throw new ArgumentNullException(nameof(objectToSave.model));
            }

            ClaimViewModel model = JsonConvert.DeserializeObject<ClaimViewModel>(objectToSave.model.ToString());
            ClaimViewModel instanceType = _serviceClaim.FindByAsNoTracking(x => x.Id == model.Id && x.IdClaimStatus == model.IdClaimStatus
            && x.IdWarehouse == model.IdWarehouse).FirstOrDefault(c => c.DocumentDate.Value.Date == model.DocumentDate.Value.Date);
            GetUserMail();
            ClaimViewModel result;
            result = _serviceClaim.AddClaimTiersMovement(model, null, userMail);
            return result;
        }

        //[HttpPost("addClaimStockMovement"), Authorize("UPDATE")]
        //public ResponseData AddClaimStockMovement([FromBody] ObjectToSaveViewModel objectToSave)
        //{

        //    if (objectToSave == null || objectToSave.model == null)
        //    {
        //        throw new ArgumentNullException(nameof(objectToSave.model));
        //    }

        //    ClaimViewModel model = JsonConvert.DeserializeObject<ClaimViewModel>(objectToSave.model.ToString());
        //    ClaimViewModel instanceType = _serviceClaim.FindByAsNoTracking(x => x.Id == model.Id && x.IdClaimStatus == model.IdClaimStatus
        //    && x.IdWarehouse == model.IdWarehouse).FirstOrDefault(c => c.DocumentDate.Value.Date == model.DocumentDate.Value.Date);
        //    if (instanceType != null)
        //    {
        //        bool hasRole = SpecificAuthorizationCheck.ClaimAuthorization(instanceType.ClaimType, AutorizationActionConstants.AuthorizationUpdate, Request.HttpContext);
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
        //        objectData = _serviceClaim.AddClaimStockMovement(model, null, userMail),
        //        flag = 1
        //    };

        //    return result;
        //}

        [HttpPost("getClaimList"), Authorize("LIST_CLAIM_PURCHASE")]
        public ResponseData GetClaimList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            string documentTypeCode = string.Empty;
            if (model.Filter.Count > 0)
            {
                documentTypeCode = model.Filter.FirstOrDefault(p => string.Compare(p.Prop, claimTypeCodeConst, stringComparison) == 0)?.Value.ToString();
            }

            if (string.IsNullOrWhiteSpace(documentTypeCode))
            {
                documentTypeCode = claimTypeCodeConst;
            }

            var dataSourceResult = _serviceClaim.GetClaimList(model);
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
                List<FilterViewModel> filtersItem = new List<FilterViewModel>();
                filtersItem.Add(new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = id, IsDynamicValue = true });
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

        [HttpPost("VerifyExistingPurchaseDocument"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public virtual ResponseData VerifyExistingPurchaseDocument([FromBody] ClaimQueryViewModel model)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceClaim.VerifyExistingPurchaseDocument(model);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }


        [HttpPost("GetBLFromClaimItem"), Authorize("ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE")]
        public virtual ResponseData GetBLFromClaimItem([FromBody] ClaimQueryViewModel model)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceClaim.GetBLFromClaimItem(model);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpPost("GetSIFromClaimItem"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public virtual ResponseData GetSIFromClaimItem([FromBody] ClaimQueryViewModel model)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceClaim.GetSIFromClaimItem(model);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpPost("GetBSFromClaimItem"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public virtual ResponseData GetBSFromClaimItem([FromBody] ClaimQueryViewModel model)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceClaim.GetBSFromClaimItem(model);
            result.flag = 1;
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
        [HttpPost("getItemsList"), Authorize("LIST_CLAIM_PURCHASE")]
        public virtual ResponseData GetItemsList([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceClaim.FindNoTrackedModelBy(model.Filter.ToList());
                result.listObject = new ListObject
                {
                    listData = dataSourceResult,
                    total = _serviceClaim.GetAllModels().Count()
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// delete entity
        /// </summary>
        /// <param name="model"> entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is deleted
        /// ResponseJson.Failed if The entity is not deleted
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpDelete("delete/{id}"), Authorize("DELETE_CLAIM_PURCHASE")]
        public override ResponseData Delete(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var obj = _serviceClaim.DeleteModel(id, modelName, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;
                result.objectData = obj;
            }
            return result;
        }

        [HttpPost("updateRelatedDocumentToClaim"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public ResponseData UpdateRelatedDocumentToClaim([FromBody] ItemPriceViewModel itemPriceViewModel)
        {

            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            _serviceClaim.UpdateRelatedDocumentToClaim(itemPriceViewModel);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.NoContent,   
                flag = 1
            };
            return result;
        }
        [HttpPost("updateRelatedBSToClaim"), Authorize("UPDATE_CLAIM_PURCHASE,ADD_CLAIM_PURCHASE")]
        public ResponseData updateRelatedBSToClaim([FromBody] ItemPriceViewModel itemPriceViewModel)
        {

            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            GetUserMail();
            _serviceClaim.UpdateRelatedBSToClaim(itemPriceViewModel, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = 1
            };

            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_CLAIM_PURCHASE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_CLAIM_PURCHASE")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            return base.GetDataWithSpecificFilter(model);
        }

    }
}
