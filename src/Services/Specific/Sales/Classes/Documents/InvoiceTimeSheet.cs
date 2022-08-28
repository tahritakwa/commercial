using Persistence;
using Persistence.Entities;
using Services.Specific.Hubs;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.RH;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        public ProjectViewModel EmployeeViewModel { get; private set; }

        /// <summary>
        /// Prepare documentLine
        /// </summary>
        /// <param name="item"></param>
        /// <param name="project"></param>
        /// <returns></returns>
        public List<DocumentLineViewModel> GenerateDocumentLine(ItemViewModel item, Project project, int idTimeSheet)
        {
            List<DocumentLineViewModel> listOfDocumentLine = new List<DocumentLineViewModel>();
            Dictionary<double, double> workedDaysByProject = _serviceTimeSheet.NumberOfDaysWorkedByProjectInTimeSheet(idTimeSheet, project.Id);
            workedDaysByProject.ToList().ForEach(x =>
            {
                var ValueRounded = Math.Round(x.Value, NumberConstant.Two);
                // Prepare document line
                DocumentLineViewModel documentLine = new DocumentLineViewModel()
                {
                    Designation = item.Description,
                    HtAmountWithCurrency = x.Key,
                    HtUnitAmountWithCurrency = x.Key,
                    HtTotalLineWithCurrency = x.Key * ValueRounded,
                    IdItem = item.Id,
                    TtcTotalLineWithCurrency = x.Key * ValueRounded,
                    VatTaxAmountWithCurrency = 0,
                    DiscountPercentage = 0,
                    MovementQty = ValueRounded,
                    IdItemNavigation = item,
                    IdMeasureUnit = item != null && item.IdUnitSales != null ? item.IdUnitSales : null,
                    IdMeasureUnitNavigation = item != null && item.IdUnitSalesNavigation != null ? item.IdUnitSalesNavigation : null 
                };
                if (project.IdTaxe != null)
                {
                    documentLine = PrepareFieldsReleatedToTaxes(documentLine, project, ValueRounded);
                }
                listOfDocumentLine.Add(documentLine);
            });
            return listOfDocumentLine;
        }


        /********************************** Generate invoices from Session Billing  *********************************/

        /// <summary>
        /// Generate Invoice from Billing session sync version
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public ICollection<DocumentViewModel> GenerateInvoiceFromBillingSessionAsync(int idBillingSession)
        {
            IList<BillingEmployee> billingEmployees = _entityRepoBillingEmployee.GetAllWithConditionsRelations(x => x.IdBillingSession == idBillingSession && x.IsChecked,
                x => x.IdTimeSheetNavigation,
                x => x.IdEmployeeNavigation,
                x => x.IdProjectNavigation,
                x => x.IdProjectNavigation.IdTiersNavigation).ToList();
            ICollection<DocumentViewModel> resultObjectData = new List<DocumentViewModel>();
            DocumentViewModel documentViewModel;
            foreach (Task<DocumentViewModel> task in GenerateInvoicesTasksAsync(billingEmployees))
            {
                if (task.Result != null)
                {
                    documentViewModel = GetModelWithRelations(x => x.Id == task.Result.Id, x => x.DocumentLine, x => x.IdUsedCurrencyNavigation);
                    BillingSessionProgessHub.SendProgress(idBillingSession, billingEmployees.Count, _billingSessionProgressHubContext, documentViewModel);
                }
                if (task.Result.Id != NumberConstant.Zero)
                {
                    resultObjectData.Add(task.Result);
                }
            }
            BillingSession billingSession = _entityBillingSessionRepo.GetSingleNotTracked(x => x.Id == idBillingSession);
            billingSession.NumberOfNotGeneratedDocuments = resultObjectData.Count != billingEmployees.Count ?
                 billingEmployees.Count - resultObjectData.Count : NumberConstant.Zero;
            _entityBillingSessionRepo.Update(billingSession);
            _unitOfWork.Commit();
            BillingSessionProgessHub.ClearProgress(_billingSessionProgressHubContext);
            return resultObjectData;
        }
        /// <summary>
        /// Generate list of tasks to Generate Invoices from Billing session Async version
        /// </summary>
        /// <param name="billingSessionProjectsList"></param>
        /// <returns></returns>
        public IEnumerable<Task<DocumentViewModel>> GenerateInvoicesTasksAsync(IList<BillingEmployee> billingEmployees)
        {
            List<Employee> employees = billingEmployees.Select(x => x.IdEmployeeNavigation).Distinct().ToList();
            List<Project> projects = billingEmployees.Select(x => x.IdProjectNavigation).Distinct().ToList();
            foreach (BillingEmployee billingEmployee in billingEmployees)
            {
                Project project = projects.FirstOrDefault(x => x.Id == billingEmployee.IdProject);
                Employee employee = employees.FirstOrDefault(x => x.Id == billingEmployee.IdEmployee);
                Task<DocumentViewModel> returnedTaskTResult = Task.Run(() => ReGenerateInvoice(employee, project, billingEmployee.IdTimeSheet, billingEmployee.IdTimeSheetNavigation.Status));
                returnedTaskTResult.Wait();
                yield return returnedTaskTResult;
            }
        }

        /// <summary>
        /// ReGenerate Invoice
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="project"></param>
        /// <param name="idTimeSheet"></param>
        /// <param name="generateAll"></param>
        /// <returns></returns>
        public DocumentViewModel ReGenerateInvoice(Employee employee, Project project, int idTimeSheet, int timesheetStatus)
        {
            DocumentViewModel documentViewModel = new DocumentViewModel();
            try
            {
                DocumentViewModel documentAlreadyGenerated = FindByAsNoTracking(x => x.IdTimeSheet == idTimeSheet && x.IdProject == project.Id && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice).FirstOrDefault();
                if (documentAlreadyGenerated != null)
                {
                    if (documentAlreadyGenerated.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || documentAlreadyGenerated.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                    {
                        // Delete the existing document and regenrate a new document
                        DeleteModelwithouTransaction(documentAlreadyGenerated.Id, nameof(Document), null);
                        documentViewModel = GenerateInvoiceWithLines(employee, project, idTimeSheet, timesheetStatus);
                    }
                    else
                    {
                        // Create Asset
                        documentViewModel = documentAlreadyGenerated;
                    }
                }
                else
                {
                    documentViewModel = GenerateInvoiceWithLines(employee, project, idTimeSheet, timesheetStatus);
                }
                return documentViewModel;
            }
            catch
            {
                RollBackTransaction();
                return documentViewModel;
            }
        }

        /// <summary>
        /// Generate Invoice With Lines
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="project"></param>
        /// <param name="idTimeSheet"></param>
        /// <returns></returns>
        public DocumentViewModel GenerateInvoiceWithLines(Employee employee, Project project, int idTimeSheet, int timesheetStatus)
        {
            DocumentViewModel document = new DocumentViewModel();
            if (timesheetStatus == (int)TimeSheetStatusEnumerator.Validated)
            {
                //ItemViewModel item = _serviceDocumentLine.GenerateItemFromEmployee(employee, project.LabelInInvoice);
                ItemViewModel item = new ItemViewModel();
                List<DocumentLineViewModel> documentLines = new List<DocumentLineViewModel>();
                documentLines.AddRange(GenerateDocumentLine(item, project, idTimeSheet));
                document = GenerateInvoice(documentLines, project, idTimeSheet);
            }
            return document;
        }

        /// <summary>
        /// Generate invoice document from project
        /// </summary>
        /// <param name="documentLinesViewModel"></param>
        /// <param name="project"></param>
        /// <param name="idTimeSheet"></param>
        /// <param name="documents"></param>
        /// <returns></returns>
        public DocumentViewModel GenerateInvoice(List<DocumentLineViewModel> documentLinesViewModel, Project project, int idTimeSheet)
        {
            int idCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == ActiveAccountHelper.GetConnectedUserEmail()).Id;
            DocumentViewModel createdDocument = new DocumentViewModel()
            {
                CreationDate = DateTime.Now,
                DocumentDate = DateTime.Now,
                DocumentLine = documentLinesViewModel,
                DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                IdSettlementMode = project.IdSettlementMode,
                IdTiers = project.IdTiers,
                IdContact = project.IdContact,
                IdUsedCurrency = (project.IdCurrency == null ? project.IdTiersNavigation.IdCurrency : project.IdCurrency),
                IdTimeSheet = idTimeSheet,
                DocumentOtherTaxesWithCurrency = 0,
                IdProject = project.Id,
                InoicingType = (int)InvoicingTypeEnumerator.Cash,
                IdCreator = idCreator
            };
            CreatedDataViewModel createdDataViewModel = (CreatedDataViewModel)AddDocument(null, createdDocument, null, null);
            return GetModelsWithConditionsRelations(x => x.Id == createdDataViewModel.Id).FirstOrDefault();
        }


        /// <summary>
        /// Prepare values of fields of documentLine releated to taxe
        /// </summary>
        /// <param name="documentLineViewModel"></param>
        /// <param name="project"></param>
        /// <returns></returns>
        private DocumentLineViewModel PrepareFieldsReleatedToTaxes(DocumentLineViewModel documentLineViewModel, Project project, double workedDays)
        {
            var taxconfigs = _entityRepoTaxeGroupTiersConfig.
                GetAllWithConditionsRelationsAsNoTracking(x => x.IdTaxeGroupTiers == project.IdTiersNavigation.IdTaxeGroupTiers, x => x.IdTaxeNavigation).ToList();
            documentLineViewModel.DocumentLineTaxe = new List<DocumentLineTaxeViewModel>();

            if (project.IdTaxe != null)
            {
                var taxValue = taxconfigs.FirstOrDefault(x => x.IdTaxe == project.IdTaxe);
                if (taxValue == null)
                {
                    throw new CustomException(CustomStatusCode.TaxItemValueError);
                }
                documentLineViewModel.IdItemNavigation.TaxeItem.Add(new TaxeItemViewModel
                {
                    IdItem = documentLineViewModel.IdItem,
                    IdTaxe = taxValue.IdTaxe
                });
                double? sumTaxes = taxValue.IdTaxeNavigation.TaxeValue / 100;
                documentLineViewModel.TtcTotalLineWithCurrency = (documentLineViewModel.HtUnitAmountWithCurrency + (documentLineViewModel.HtUnitAmountWithCurrency * sumTaxes)) * workedDays;
                documentLineViewModel.VatTaxAmountWithCurrency = (documentLineViewModel.HtUnitAmountWithCurrency * sumTaxes) * workedDays;
            }
            return documentLineViewModel;
        }
    }
}
