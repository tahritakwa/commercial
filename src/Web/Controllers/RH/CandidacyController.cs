using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/candidacy")]
    public class CandidacyController : BaseController
    {
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceCandidacy"></param>
        /// <param name="serviceUser"></param>
        public CandidacyController(IServiceProvider serviceProvider, ILogger<CandidacyController> logger, IServiceCandidacy serviceCandidacy)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _service = serviceCandidacy;
        }

        [HttpPut("preSelectionnedOneCandidacy"), Authorize("UPDATE_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData PreSelectionnedOneCandidacy([FromBody] CandidacyViewModel model)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _service.PreSelectionnedOneCandidacy(model, null, userMail, null);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPut("unPreSelectionnedOneCandidacy"), Authorize("UPDATE_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData UnPreSelectionnedOneCandidacy([FromBody] CandidacyViewModel model)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _service.UnPreSelectionnedOneCandidacy(model, null, userMail, null);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("fromPreselectionToNextStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData PreselectionToNextStep([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _service.FromPreselectionToNextStep(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            if (dataSourceResult.total > 0)
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            else
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.PreselectionToNextStepViolation;
            }

            return result;
        }


        [HttpPost("fromCandidacyToNextStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData FromCandidacyToNextStep([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();

            var dataSourceResult = _service.FromCandidacyToNextStep(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            if (dataSourceResult.total > 0)
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            else
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.CandidacyEmptyList;
            }

            return result;
        }

        /// <summary>
        /// This method is call if selection step if we select one candidacy
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut("selectionnedOneCandidacy"), Authorize("UPDATE_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData SelectionnedOneCandidacy([FromBody] CandidacyViewModel model)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _service.SelectionnedOneCandidacy(model, null, userMail, null);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// This method is call if selection step if we unselect one candidacy
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut("unSelectionnedOneCandidacy"), Authorize("UPDATE_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData UnSelectionnedOneCandidacy([FromBody] CandidacyViewModel model)

        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _service.UnSelectionnedOneCandidacy(model, null, userMail, null);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// This method is call in selection step if we want to go to the next step
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        [HttpPost("fromSelectionToNextStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData SelectionToNextStep([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _service.FromSelectionToNextStep(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            if (dataSourceResult.total > 0)
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            else
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.SelectionToNextStepViolation;
            }

            return result;
        }

        /// <summary>
        /// This method is call in offer step if we want to go to the next step
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        [HttpPost("fromOfferToNextStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData FromOfferToNextStep([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _service.FromOfferToNextStep(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            if (dataSourceResult.total > 0)
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            else
            {
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.OfferToNextStepViolation;
            }
            return result;
        }

        [HttpPut("generateEmployeeFromCandidacy"), Authorize("UPDATE_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData GenerateEmployeeFromCandidacy([FromBody] CandidacyViewModel candidacy)
        {
            ResponseData result = new ResponseData
            {
                objectData = _service.GenerateEmployeeFromCandidacy(candidacy),
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
            return result;
        }

        /// <summary>
        /// GetCandidacyListInOfferStep
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getCandidacyListInOfferStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData GetCandidacyListInOfferStep([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();

            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _service.GetCandidacyListInOfferStepWithSpecificPredicat(predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("getCandidacyListInDoneStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData GetCandidacyListInDoneStep([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();

            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _service.GetCandidacyListInDoneStepWithSpecificPredicat(predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getCandidacyListInSelectionStep"), Authorize("LIST_CANDIDACY,FULL_RECRUITMENT")]
        public ResponseData GetCandidacyListInSelectionStep([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();

            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _service.GetCandidacyListInSelectionStepWithSpecificPredicat(predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost, Route("generateRejectedEmailByCandidacy/{lang}"), Authorize("UPDATE_CANDIDACY")]
        public ResponseData GenerateRejectedEmail([FromBody] CandidacyViewModel candidacy, string lang)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _service.generateRejectedEmailByCandidacy(candidacy, lang, userMail);
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("insert"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPut("update"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }

}
