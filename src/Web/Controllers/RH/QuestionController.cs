using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/question")]
    public class QuestionController : BaseController
    {
        private readonly IServiceQuestion _serviceQuestion;
        public QuestionController(IServiceProvider serviceProvider, ILogger<ObjectiveController> logger,
            IServiceQuestion serviceQuestion)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceQuestion = serviceQuestion;
        }


        /// <summary>
        /// DeleteQuestionModel
        /// </summary>
        /// <param name="id"></param>
        /// <param name="hasQuestionRight"></param>
        /// <returns></returns>
        [HttpDelete("deleteQuestionModel/{hasQuestionRight}/{id}"), Authorize("DELETE_QUESTION")]
        public ResponseData DeleteQuestionModel(int id, bool hasQuestionRight)
        {
            GetUserMail();
            ResponseData result = new ResponseData();

            _serviceQuestion.DeleteQuestionModelwithouTransaction(id, modelName, userMail, hasQuestionRight);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.DeleteSuccessfull;

            return result;
        }
    }
}
