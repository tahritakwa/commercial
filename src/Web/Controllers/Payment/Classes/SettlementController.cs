using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ModelView.Payment;
using Newtonsoft.Json;
using Persistence;
using Services.Specific.Payment.Interfaces;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Payment.Interfaces;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/settlement")]
    public class SettlementController : BaseController, ISettlementController
    {
        const string roles = "roles";
        const string idConst = "Id";
        const string directionConst = "Direction";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        readonly IServiceSettlementCommitment _serviceSettlementCommitment;
        readonly IServiceSettlement _serviceSettlement;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public SettlementController(IServiceSettlementCommitment serviceSettlementCommitment, IServiceSettlement serviceSettlement
            , IServiceProvider serviceProvider, ILogger<SettlementController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceSettlementCommitment = serviceSettlementCommitment;
            _serviceSettlement = serviceSettlement;
        }
        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("getSettlement")]
        public new ResponseData Get([FromBody] PredicateFormatViewModel model)
        {
            if (model != null)
            {
                int idDirection = Convert.ToInt32(model.Filter.FirstOrDefault(p => string.Compare(p.Prop, directionConst, stringComparison) == 0).Value, CultureInfo.InvariantCulture);
                bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(idDirection, AutorizationActionConstants.AuthorizationList, Request.HttpContext);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                var dataSourceResult = _serviceSettlement.FindDataSourceModelBy(model);
                ResponseData result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = dataSourceResult.data,
                        total = dataSourceResult.total
                    },
                    flag = 2,
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };

                return result;
            }
            return new ResponseData();
        }
        [HttpGet("getSettlementById/{id}"), Authorize("ADD_SUPPLIER_SETTLEMENT,ADD_CUSTOMER_SETTLEMENT")]
        public new ResponseData GetById(int id)
        {
            ResponseData result = base.GetById(id);
            SettlementViewModel settlementViewModel = (SettlementViewModel)result.objectData;
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.GetByIdSuccessfull,
                objectData = settlementViewModel,
                flag = 1
            };
        }

        [HttpPost("insertSettlement")]
        public new ResponseData Post([FromBody] ObjectToSaveViewModel objectSaved)
        {
            if (objectSaved != null)
            {
                SettlementViewModel instanceType = JsonConvert.DeserializeObject<SettlementViewModel>(objectSaved.model.ToString());
                bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(instanceType.Direction, AutorizationActionConstants.AuthorizationAdd, Request.HttpContext);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                var data = _serviceSettlement.AddModel(instanceType, objectSaved.EntityAxisValues, userMail);
                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.AddSuccessfull,
                    objectData = data,
                    flag = 1
                };
                return result;

            }
            return new ResponseData();
        }
        [HttpPost("putSettlement")]
        public ResponseData UpdateSettlement([FromBody] ReducedSettlementList settlement)
        {
            if (settlement != null)
            {
                bool hasRole = true;
                if (settlement.IdTypeTiers == (int)TiersType.Customer)
                {
                    hasRole = RoleHelper.HasPermission("UPDATE_CUSTOMER_PAYMENT_HISTORY");
                }

                if (settlement.IdTypeTiers == (int)TiersType.Supplier)
                {
                    hasRole = RoleHelper.HasPermission("UPDATE_SUPPLIER_PAYMENT_HISTORY");
                }
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                _serviceSettlement.UpdateSettlement(settlement, null, userMail);
                ResponseData result = new ResponseData
                {
                    objectData = new CreatedDataViewModel { EntityName = "SETTLEMENT" },
                    customStatusCode = CustomStatusCode.UpdateSuccessfull,
                    flag = 1
                };
                return result;

            }
            return new ResponseData();
        }
        [HttpPut("updateSettlement")]
        public new ResponseData Put(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ObjectToSaveViewModel objectToSave = (objectJsonToSave != null) ?
                JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave) : objectSaved;
            if (objectToSave != null)
            {
                SettlementViewModel instanceType = JsonConvert.DeserializeObject<SettlementViewModel>(objectToSave.model.ToString());
                bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(instanceType.Direction, AutorizationActionConstants.AuthorizationUpdate, Request.HttpContext);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                if (files != null && files.Any())
                {
                    //Add list of files to document
                    instanceType.Files = files;
                }
                _serviceSettlement.UpdateModel(instanceType, objectToSave.EntityAxisValues, userMail);
                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.UpdateSuccessfull,
                    flag = 1
                };
                return result;

            }
            return new ResponseData();
        }

        [HttpDelete("deleteSettlement/{id}")]
        public new ResponseData Delete(int id)
        {
            int direction = GetSettlementDirection(id);
            bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(direction, AutorizationActionConstants.AuthorizationDelete, Request.HttpContext);
            return (hasRole) ? base.Delete(id) : new ResponseData
            {
                customStatusCode = CustomStatusCode.Unauthorized
            };
        }


        [HttpPost("getCommitmentForAddOperation"), Authorize("LIST")]
        public virtual ResponseData GetCommitmentForAddOperation([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceSettlementCommitment.GetCommitmentForAddOperation(model),
                },
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("getCommitmentForUpdateOperation"), Authorize("LIST")]
        public virtual ResponseData GetCommitmentForUpdateOperation([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceSettlementCommitment.GetCommitmentForUpdateOperation(model)
                },
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("validate")]
        public ResponseData ValidateSettlement([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave != null)
            {
                int direction = GetSettlementDirection(int.Parse(objectToSave.model, CultureInfo.InvariantCulture));
                bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(direction, AutorizationActionConstants.AuthorizationValidate, Request.HttpContext);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {
                    ResponseData result = new ResponseData
                    {
                        objectData = _serviceSettlement.ValidateSettlement(int.Parse(objectToSave.model, CultureInfo.InvariantCulture), userMail),
                        customStatusCode = CustomStatusCode.SuccessValidation,
                        flag = 1
                    };
                    return result;
                }
            }
            return new ResponseData();
        }

        [HttpGet("getDocumentSettlements/{id}")]
        public ResponseData GetDocumentSettlements(int id)
        {
            IList<SettlementViewModel> settlementViewModel = _serviceSettlement.GetDocumentSettlements(id);
            if (settlementViewModel.Any())
            {
                bool hasRole = SpecificAuthorizationCheck.SettlementAuthorization(settlementViewModel.FirstOrDefault().Direction,
                    AutorizationActionConstants.AuthorizationShow, Request.HttpContext);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = settlementViewModel,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet("getDocumentPaymentHistory/{idDocument}"), Authorize("UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,SHOW_INVOICE_PURCHASE,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES")]
        public ResponseData GetDocumentPaymentHisotry(int idDocument)
        {
            List<DocumentPaymentHistoryViewModel> documentPaymentHistoryViewModels = _serviceSettlement.GetDocumentPaymentHisotry(idDocument);
            List<DocumentPaymentHistoryViewModel> settlementList = new List<DocumentPaymentHistoryViewModel>(documentPaymentHistoryViewModels);
            //bool hasRole = false;
            //if (documentPaymentHistoryViewModels != null && documentPaymentHistoryViewModels.Any())
            //{
            //    if (documentPaymentHistoryViewModels.First().Settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer)
            //    {
            //        hasRole = RoleHelper.HasPermission("LIST_CUSTOMER_PAYMENT_HISTORY") || RoleHelper.HasPermission("READONLY_CUSTOMER_PAYMENT_HISTORY");
            //    }
            //    if (documentPaymentHistoryViewModels.First().Settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier)
            //    {
            //        hasRole = RoleHelper.HasPermission("LIST_SUPPLIER_PAYMENT_HISTORY") || RoleHelper.HasPermission("READONLY_SUPPLIER_PAYMENT_HISTORY");
            //    }

            //    if (!hasRole)
            //    {
            //        return new ResponseData
            //        {
            //            customStatusCode = CustomStatusCode.Unauthorized
            //        };
            //    }
            //}
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = documentPaymentHistoryViewModels,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet("getFinancialCommitmentPaymentHistory/{idFinancialCommitment}")]
        public ResponseData GetFinancialCommitmentPaymentHistory(int idFinancialCommitment)
        {
            List<SettlementCommitmentViewModel> settlementCommitmentViewModels = _serviceSettlement.GetFinancialCommitmentPaymentHistory(idFinancialCommitment);
            bool hasRole = false;
            if (settlementCommitmentViewModels != null && settlementCommitmentViewModels.Any())
            {
                if (settlementCommitmentViewModels.First().Settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer)
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_CUSTOMER_PAYMENT_HISTORY", "READONLY_CUSTOMER_PAYMENT_HISTORY" });
                }
                if (settlementCommitmentViewModels.First().Settlement.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier)
                {
                    hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_SUPPLIER_PAYMENT_HISTORY", "READONLY_SUPPLIER_PAYMENT_HISTORY" });
                }

                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = settlementCommitmentViewModels,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        private int GetSettlementDirection(int id)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel>()
            };
            predicateFormatViewModel.Filter.Add(
                new FilterViewModel
                {
                    Prop = idConst,
                    Value = id,
                    Operation = Operation.Equals
                });
            return _serviceSettlement.FindSingleModelBy(predicateFormatViewModel).Direction;
        }

        [HttpPost("getSettlements")]
        public ResponseData GetSettlements([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            List<int> idInvoices = new List<int>();
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int tiersType = objectToSave.model.tiersType;
            DateTime? startDate = objectToSave.model.StartDate != null ? Convert.ToDateTime(objectToSave.model.StartDate) : null;
            DateTime? endDate = objectToSave.model.EndDate != null ? Convert.ToDateTime(objectToSave.model.EndDate) : null;
            if (objectToSave.model.idInvoices.ToObject<List<int>>() != null)
            {
                idInvoices = objectToSave.model.idInvoices.ToObject<List<int>>();
            }
            bool hasRole = false;

            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_CUSTOMER_PAYMENT_HISTORY", "READONLY_CUSTOMER_PAYMENT_HISTORY" });
            }
            if (tiersType == (int)TiersType.Supplier)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_SUPPLIER_PAYMENT_HISTORY", "READONLY_SUPPLIER_PAYMENT_HISTORY" });
            }

            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            var dataSourceResult = _serviceSettlement.GetSettlements(tiersType, startDate, endDate, idInvoices, predicate);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.Settlements,
                total = dataSourceResult.Total,
                sum = dataSourceResult.TotalAmountOfSettlements
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }


        /// <summary>
        /// ReGenerate WithholdingTax Certificat Async
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpGet("reGenerateWithholdingTaxCertification/{id}"), Authorize("UPDATE_SUPPLIER_PAYMENT_HISTORY,UPDATE_CUSTOMER_PAYMENT_HISTORY")]
        public async Task<ResponseData> ReGenerateWithholdingTaxCertification(int id)
        {
            if (id == 0)
            {
                throw new ArgumentNullException();
            }
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = await _serviceSettlement.ReGenerateWithholdingTaxCertificatAsync(id, userMail);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpGet("replaceSettlement/{id}"), Authorize("CANCEL_SUPPLIER_SETTLEMENT,CANCEL_CUSTOMER_SETTLEMENT")]
        public ResponseData ReplaceSettlement(int id)
        {
            GetUserMail();
            _serviceSettlement.ReplaceSettlement(id, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("getAccountingSettlement")]
        public ResponseData GetSettlementNotAccounted([FromBody] PredicateFormatViewModel settlementAccountingModel)
        {

            ResponseData result = new ResponseData()
            {
                objectData = _serviceSettlement.GetAccountingSettlement(settlementAccountingModel),
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("changeSettlementAccountedStatus")]
        public ResponseData ChangeSettlementAccountedStatus([FromBody] int idSettlement)
        {
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceSettlement.ChangeSettlementAccountedStatus(idSettlement),
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }
        [HttpPost("getInvoicesBySettlement")]
        public ResponseData GetSettlementsByInvoices([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int tiersType = objectToSave.model.tiersType;
            bool hasRole = false;

            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_CUSTOMER_PAYMENT_HISTORY", "READONLY_CUSTOMER_PAYMENT_HISTORY" });
            }
            if (tiersType == (int)TiersType.Supplier)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_SUPPLIER_PAYMENT_HISTORY", "READONLY_SUPPLIER_PAYMENT_HISTORY" });
            }

            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.GetInvoivesBySettlement(tiersType, predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("calculateWithholdingTaxToBePaid"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public ResponseData CalculateWithholdingTaxToBePaid([FromBody] List<int> SelectedFinancialCommitments)
        {
            return new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.CalculateWithholdingTaxToBePaid(SelectedFinancialCommitments),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
        }

        /// <summary>
        /// Get bankAccount settlements that can be added in reconciliation  and all that settlement ids
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getBankAccountReconciliationSettlement"), Authorize("LIST_TREASURY_BANK_ACCOUNT,VALIDATION_TREASURY_BANK_ACCOUNT")]
        public ResponseData GetBankAccountReconciliationSettlement([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idBankAccount = objectToSave.model.idBankAccount;
            bool unreconciledRegulationsValue = objectToSave.model.unreconciledRegulations;
            bool reconciledRegulationsValue = objectToSave.model.reconciledRegulations;

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.GetBankAccountReconciliationSettlement(predicate, idBankAccount, unreconciledRegulationsValue, reconciledRegulationsValue),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get the bank account previsionnel sold
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        [HttpPost("getBankAccountPrevisionnelSold"), Authorize("LIST_TREASURY_BANK_ACCOUNT,VALIDATION_TREASURY_BANK_ACCOUNT")]
        public ResponseData GetBankAccountPrevisionnelSold([FromBody] int idBankAccount)
        {

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.GetBankAccountPrevisionnelSold(idBankAccount),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get the sttlement that can be added to new paymentSlip
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getSettlementListToAddInPaymentSlip"), Authorize("LIST_TREASURY_BANK_SLIP,ADD_TREASURY_BANK_SLIP,UPDATE_TREASURY_BANK_SLIP")]
        public ResponseData GetSettlementListToAddInPaymentSlip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            bool isPaymentSlipStateProvisional = Convert.ToBoolean(objectToSave.model.isPaymentSlipStateProvisional);
            int? idPaymentSlip = Convert.ToInt32(objectToSave.model.idPaymentSlip);

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.GetSettlementListToAddInPaymentSlip(predicate, isPaymentSlipStateProvisional, idPaymentSlip),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// GetSettlementNumberToAddPaymentSlip
        /// </summary>
        /// <param name="paymentMehtod"></param>
        /// <returns></returns>
        [HttpPost("getSettlementNumberToAddInPaymentSlip")]
        public ResponseData GetSettlementNumberToAddPaymentSlip([FromBody] string paymentMehtod)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSettlement.GetSettlementNumberToAddPaymentSlip(paymentMehtod),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [Route("uploadFile"), Authorize("UPDATE_CUSTOMER_PAYMENT_HISTORY,UPDATE_SUPPLIER_PAYMENT_HISTORY")]
        [HttpPost]
        public override FileInfoViewModel UploadFile([FromBody] FileInfoViewModel fileInfoViewModel)
        {
            return base.UploadFile(fileInfoViewModel);
        }

        [HttpPost("getDataWithSpecificFilter")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            int tiersType = Convert.ToInt32(model[0].Filter.First(x => x.Prop == "IdTiersNavigation.IdTypeTiers").Value);
            ResponseData result = new ResponseData();
            bool hasRole = false;

            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_CUSTOMER_PAYMENT_HISTORY", "READONLY_CUSTOMER_PAYMENT_HISTORY" });
            }
            if (tiersType == (int)TiersType.Supplier)
            {
                hasRole = RoleHelper.HasPermissions(new List<string> { "LIST_SUPPLIER_PAYMENT_HISTORY", "READONLY_SUPPLIER_PAYMENT_HISTORY" });
            }
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                var dataSourceResult = _serviceSettlement.GetDataWithSpecificFilter(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total,
                    sum = dataSourceResult.sum
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        [HttpPost("downloadJasperDocumentReport"), Authorize("ADD_SUPPLIER_SETTLEMENT,ADD_CUSTOMER_SETTLEMENT")]
        public override async Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return await base.DownloadJasperDocumentReport(data);
        }


        [HttpPost("validateDocumentAndGenerateSettlemnt")]
        public DocumentViewModel ValidateDocumentAndGenerateSettlemnt([FromBody] dynamic data)
        {
            SettlementViewModel settlement = JsonConvert.DeserializeObject<SettlementViewModel>(data.settlementToGenerate.ToString());
            int idDocument = (int)data.idDocument;
            int status = (int)data.documentStatus;
            GetUserMail();
            return _serviceSettlement.ValidateDocumentAndGenerateSettlemnt(settlement, idDocument, status, userMail);
        } 

        }
}
