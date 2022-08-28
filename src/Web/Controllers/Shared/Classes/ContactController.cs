using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/contact")]
    public class ContactController : BaseController
    {
        private readonly IServiceContact _serviceContact;
        public ContactController(IServiceContact serviceContact, IServiceProvider serviceProvider, ILogger<ContactController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceContact = serviceContact;
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES,ADD_DELIVERY_SALES," +
            "ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,LIST_ORDER_QUOTATION_PURCHASE,SHOW_ORDER_PRICE_REQUEST,SHOW_QUOTATION_PRICE_REQUEST,LIST_FINAL_ORDER_PURCHASE,LIST_RECEIPT_PURCHASE,LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE," +
            "ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,SHOW_ADMISSION_VOUCHERS,SHOW_EXIT_VOUCHERS,SHOW_DELIVERY_SALES,UPDATE_DELIVERY_SALES,SHOW_ORDER_QUOTATION_PURCHASE," +
            "UPDATE_ORDER_QUOTATION_PURCHASE,SHOW_FINAL_ORDER_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,SHOW_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,SHOW_RECEIPT_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,SHOW_ASSET_PURCHASE,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,SHOW_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,SHOW_FINANCIAL_ASSET_SALES," +
            "ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,ADD_ORDER_SALES,UPDATE_ORDER_SALES,SHOW_ORDER_SALES,UPDATE_VALID_ORDER_SALES," +
            "SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,ADD_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("VIEW_CONTACT_CLIENT,ADD_CONTACT,EDIT_CONTACT,VIEW_OPPORTUNITY,ADD_SHARED_CONTACT,VIEW_CONTACT_LEAD")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getUnicity"), Authorize("ADD_CONTACT,EDIT_CONTACT")]
        public override bool GetUnicity([FromBody] dynamic objectToCheck)
        {
            return base.GetUnicity((object)objectToCheck);
        }
        [HttpGet("getById/{id}"), Authorize("ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,PRINT_TIMESHEET,EDIT_CONTACT")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
        [HttpPost, Route("contactBulkAdd"), Authorize("ADD_OFFICE")]
        public ResponseData ContactBulkAdd([FromBody] IList<ContactViewModel> contact)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceContact.ContactBulkAdd(contact, null);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost, Route("getOfficeContact"), Authorize("LIST_OFFICE,UPDATE_OFFICE")]
        public ResponseData GetOfficeContact([FromBody] IList<int> contactIdslist)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _serviceContact.GetOfficeContact(contactIdslist)
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost, Route("contactBulkUpdate"), Authorize("UPDATE_OFFICE")]
        public ResponseData ContactBulkUpdate([FromBody] IList<ContactViewModel> contact)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceContact.ContactBulkUpdate(contact, null);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
                return result;
            }
        }
    }
}
