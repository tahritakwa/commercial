using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;
using Web.Controllers.Sales.Interfaces;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/Provisioning")]
    public class ProvisioningController : BaseController, IProvisioningController
    {

        private readonly IServiceProvisioning _serviceProvisioning;

        public ProvisioningController(IServiceProvider serviceProvider,
            ILogger<BaseController> logger,
            IServiceProvisioning serviceProvisioning) : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceProvisioning = serviceProvisioning;
        }


        [HttpPost("SelectedMethods"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData GenerateProvisioning([FromBody] ProvisioningViewModel models)
        {
            ResponseData result = new ResponseData();
            if (models != null)
            {
                result.objectData = _serviceProvisioning.GenerateProvisioning(models);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpPost("GetItemsWithPaging/{idProvision}"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING,SHOW_PROVISIONING")]
        public virtual ResponseData GetItemsWithPaging(int idProvision, [FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();
            if (idProvision > 0)
            {
                int total = 0;

                result.listObject = new ListObject
                {
                    listData = _serviceProvisioning.GetItemsWithPaging(idProvision, predicate, out total),
                    total = total
                };
                result.flag = 2;
            }
            return result;
        }

        [HttpPost("ProvisioningList"), Authorize("LIST_PROVISIONING")]
        public virtual ResponseData ProvisioningList([FromBody] ProvisionPredicateViewModel provisionPredicate)
        {
            var provisioningList = _serviceProvisioning.ProvisioningList(provisionPredicate);
            ResponseData result = new ResponseData
            {
                flag = 2,
                listObject = new ListObject()
            };
            result.listObject.listData = provisioningList.data;
            result.listObject.total = provisioningList.total;
            return result;
        }

        [HttpPost("ItemDetails"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData ItemDetails([FromBody] ProvisioningDetailsViewModel provision)
        {
            ResponseData result = new ResponseData();
            if (provision != null)
            {
                result.objectData = _serviceProvisioning.GetItemDetails(provision);
            }
            return result;
        }

        [HttpPost("AddItemFromModal"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData AddItemFromModal([FromBody] ProvisioningDetailsViewModel provision)
        {
            ResponseData result = new ResponseData();
            if (provision != null)
            {
                result.objectData = _serviceProvisioning.GetItemDetails(provision);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpPost("GenereateOrderProject/{idProvision}"), Authorize("GENERATE_ORDER_PROVISIONING")]
        public ResponseData GenereateOrderProject(int idProvision)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            if (idProvision > 0)
            {
                result.objectData = _serviceProvisioning.CreateDocument(idProvision, userMail);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpGet("SupplierTotlRecap/{idProvision}/{idProvisionDetail}"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public IList<TiersProvisioningViewModel> SupplierTotlRecap(int idProvision, int idProvisionDetail)
        {
            return _serviceProvisioning.SupplierTotalRecap(idProvision, idProvisionDetail);

        }

        [HttpGet("GetProvision/{idProvision}"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING,SHOW_PROVISIONING")]
        public ProvisioningViewModel GetProvision( int idProvision)
        {
            return _serviceProvisioning.GetProvision(idProvision);

        }

        [HttpPost("GetEquivalentList"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,SHOW_ORDER_QUOTATION_PURCHASE")]
        public virtual ResponseData GetEquivalentList([FromBody] EquivalentItemViewModel equivalentItemViewModel)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject()
            };
            if (equivalentItemViewModel != null)
            {
                result.listObject.listData = _serviceProvisioning.GetEquivalentList(equivalentItemViewModel, out int total);
                result.listObject.total = total;
            }
            return result;
        }

        [HttpPost("addEquivalentItemToProvisioningGrid/{idProvision}/{MvtQty}"), Authorize("ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public ResponseData AddEquivalentItemToProvisioningGrid([FromBody] List<int> idEquivalentItem,  int idProvision,  int MvtQty)
        {
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            _serviceProvisioning.AddEquivalentItemToProvisioningGrid(idEquivalentItem, idProvision, MvtQty);
            result.customStatusCode = CustomStatusCode.LineAddedsuccessfully;
            return result;
        }
        [HttpPost("importOrderProject/{idProvision}"), Authorize("IMPORT_PROVISIONING")]
        public ResponseData importOrderProject([FromBody] List<int> idEquivalentItem,  int idProvision)
        {
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            _serviceProvisioning.importOrderProject(idEquivalentItem, idProvision);
            return result;
        }
        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_PROVISIONING")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {

            return base.GetDataWithSpecificFilter(model);
        }
    }
}
