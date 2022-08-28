using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/recruitment")]
    public class RecruitmentController : BaseController
    {
        private readonly IServiceRecruitment _serviceRecruitment;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceEmployee _serviceEmployee;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceRecruitment"></param>
        public RecruitmentController(IServiceProvider serviceProvider,
            ILogger<RecruitmentController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceRecruitment serviceRecruitment,
            IServiceEmployee serviceEmployee)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceRecruitment = serviceRecruitment;
            _smtpSettings = smtpSettings.Value;
            _serviceEmployee = serviceEmployee;
        }

        [HttpPost, Route("doneRecruitment"), Authorize("CLOSE_RECRUITMENT,FULL_RECRUITMENT")]
        public ResponseData DoneRecruitment([FromBody] int recruitmentId)
        {
            ResponseData result = new ResponseData();
            _serviceRecruitment.DoneRecruitment(recruitmentId);

            result.flag = 2;
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;

            return result;
        }

        [HttpPost, Route("getRecruitmentsList"), Authorize("LIST_RECRUITMENT,LIST_RECRUITMENTREQUEST,LIST_RECRUITMENTOFFER")]
        public ResponseData getRecruitmentsList([FromBody] ObjectToSaveViewModel objectSaved)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            DateTime? startDate = null;
            DateTime? endDate = null;
            if (objectSaved.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectSaved.model.predicate.ToString());
            }
            int IdCandidate = 0;
            if (objectSaved.model.IdCandidate != null)
            {
                IdCandidate = objectSaved.model.IdCandidate;
            }
            if (objectSaved.model.StartDate != null)
            {
                startDate = objectSaved.model.StartDate;
            }
            if (objectSaved.model.EndDate != null)
            {
                endDate = objectSaved.model.EndDate;
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceRecruitment.GetRecruitmentsList(predicateFormatViewModel, IdCandidate, endDate, startDate),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        /// <summary>
        /// validate or cancel the recruitment request
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("validate"), Authorize("VALIDATE_RECRUITMENT,VALIDATE_RECRUITMENTOFFER,VALIDATE_RECRUITMENTREQUEST,REFUSE_RECRUITMENTREQUEST")]
        public ResponseData ValidateOrCancelRequest([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {

                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                RecruitmentViewModel recruitmentViewModel = JsonConvert.DeserializeObject<RecruitmentViewModel>(objectToSave.model.ToString());
                GetUserMail();
                _serviceRecruitment.ValidateRequest(recruitmentViewModel, objectToSave.EntityAxisValues, userMail, _smtpSettings);
                ResponseData result = new ResponseData
                {
                    objectData = _serviceEmployee.GetConnectedEmployee(),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = NumberConstant.One
                };
                return result;
            }
        }
        /// <summary>
        /// Open or close the job offer
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("publish"), Authorize("PUBLISH_RECRUITMENTOFFER,CLOSE_RECRUITMENTOFFER")]
        public ResponseData OpenOrCloseOffer([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                RecruitmentViewModel recruitmentViewModel = JsonConvert.DeserializeObject<RecruitmentViewModel>(objectToSave.model.ToString());
                GetUserMail();
                _serviceRecruitment.PublishJobOffer(recruitmentViewModel, objectToSave.EntityAxisValues, userMail, _smtpSettings);
                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = NumberConstant.One
                };
                return result;
            }
        }

        [HttpPost("insert"), Authorize("ADD_RECRUITMENT,ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpGet("getById/{id}"), Authorize("UPDATE_RECRUITMENT,LIST_RECRUITMENTREQUEST,LIST_RECRUITMENTOFFER")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }

        [HttpPut("update"), Authorize("UPDATE_RECRUITMENT,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,START_RECRUITMENT_PROCESS")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_RECRUITMENTREQUEST,DELETE_RECRUITMENTOFFER,DELETE_RECRUITMENT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_RECRUITMENT,LIST_RECRUITMENTOFFER,LIST_RECRUITMENTREQUEST")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
