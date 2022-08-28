using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.Controllers.CommonControllers
{
    [Route("api/log")]
    public class LogController : Controller
    {
        private ILogger<LogController> logger;

        public ILogger<LogController> Logger { get => logger; set => logger = value; }

        public LogController(ILogger<LogController> logger)
        {
            Logger = logger;
        }
        // GET: api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("getsingle/{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost("insert")]
        public void Post([FromBody]Error exception)
        {
            string message = exception.message;
            Logger.LogError(message);
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
            Logger.LogError(value);
        }


    }
}
