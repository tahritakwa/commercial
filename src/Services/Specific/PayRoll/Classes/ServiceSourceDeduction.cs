using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Reporting.Payroll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{

    public class ServiceSourceDeduction : Service<SourceDeductionViewModel, SourceDeduction>, IServiceSourceDeduction
    {
        #region constants
        public const string SESSION_TITLE = "{SESSION_TITLE}";
        #endregion
        private readonly IRepository<SourceDeductionSession> _repoSourceDeductionSession;
        private readonly IRepository<Payslip> _repoPayslip;
        private readonly IServicePayslip _servicePayslip;
        private readonly IRepository<SourceDeductionSessionEmployee> _repoSourceDeductionSessionEmployee;
        private readonly IServiceJobEmployee _serviceJobEmployee;
        private readonly IRepository<EmployeeDocument> _entityRepoEmployeeDocument;
        internal readonly IRepository<Session> _repoSession;
        internal readonly IRepository<User> _entityRepoUser;
        internal readonly IServiceInformation _serviceInformation;
        private readonly IServiceSharedDocument _serviceSharedDocument;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceEmail _serviceEmail;
        private readonly IRepository<Address> _repoEntityAddress;
        private readonly IServiceCompany _serviceCompany;
        private readonly IHubContext<SourceDeductionSessionProgressHub> _progressHubContext;
        public ServiceSourceDeduction(IRepository<EmployeeDocument> entityRepoEmployeeDocument,
            IRepository<SourceDeduction> entityRepo,
            IRepository<Payslip> repoPayslip,
            IUnitOfWork unitOfWork,
            ISourceDeductionBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<SourceDeductionSession> repoSourceDeductionSession,
            IRepository<Address> repoEntityAddress,
            IServicePayslip servicePayslip, IRepository<SourceDeductionSessionEmployee> repoSourceDeductionSessionEmployee,
            IServiceJobEmployee serviceJobEmployee, IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
            ICompanyBuilder companyBuilder, IMemoryCache memoryCache,
            IHubContext<SourceDeductionSessionProgressHub> progressHubContext,
            IServiceCompany serviceCompany,
        IRepository<Session> repoSession, IRepository<User> entityRepoUser, IServiceInformation serviceInformation, IServiceSharedDocument serviceSharedDocument,
            IServiceMsgNotification serviceMessageNotification, IServiceEmail serviceEmail)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {

            _repoSourceDeductionSession = repoSourceDeductionSession;
            _repoPayslip = repoPayslip;
            _servicePayslip = servicePayslip;
            _repoSourceDeductionSessionEmployee = repoSourceDeductionSessionEmployee;
            _serviceJobEmployee = serviceJobEmployee;
            _entityRepoEmployeeDocument = entityRepoEmployeeDocument;
            _repoSession = repoSession;
            _entityRepoUser = entityRepoUser;
            _serviceInformation = serviceInformation;
            _serviceSharedDocument = serviceSharedDocument;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceEmail = serviceEmail;
            _repoEntityAddress = repoEntityAddress;
            _progressHubContext = progressHubContext;
            _serviceCompany = serviceCompany;

        }

        /// <summary>
        /// Update model
        /// </summary>
        /// <param name="sourceDeduction"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        public override object UpdateModel(SourceDeductionViewModel sourceDeduction, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            DeleteModelPhysicallyWhithoutTransaction(sourceDeduction.Id, userMail);
            SourceDeductionSession sourceDeductionSession = _repoSourceDeductionSession.GetSingle(x => x.Id == sourceDeduction.IdSourceDeductionSession);
            SourceDeductionViewModel sourceDeductionViewModel = new SourceDeductionViewModel(sourceDeduction.IdEmployee, sourceDeduction.IdSourceDeductionSession, sourceDeductionSession.Year);
            CalculateDetails(sourceDeductionViewModel, userMail);
            sourceDeductionViewModel.Status = (int)PayslipStatus.Correct;
            sourceDeductionViewModel.ErrorMessage = null;
            return sourceDeductionViewModel;
        }


        /// <summary>
        /// Calculate source deduction details
        /// </summary>
        /// <param name="sourceDeduction"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private SourceDeductionViewModel CalculateDetails(SourceDeductionViewModel sourceDeduction, string userMail)
        {
            IList<Payslip> payslips = _repoPayslip.GetAllAsNoTracking()
                .Include(x => x.PayslipDetails)
                .ThenInclude(x => x.IdSalaryRuleNavigation)
                .ThenInclude(x => x.IdRuleUniqueReferenceNavigation)
                .Where(x => x.IdEmployee == sourceDeduction.IdEmployee && x.Month.Year == sourceDeduction.Year).ToList();
            try
            {
                payslips.ToList().ForEach(payslip =>
                {
                    double taxableWage = payslip.PayslipDetails.Any(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Net)) ?
                                         payslip.PayslipDetails.FirstOrDefault(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Net)).Gain : NumberConstant.Zero;

                    double naturalAdvantage = payslip.PayslipDetails.Where(x => x.IdBenefitInKind.HasValue).Sum(x => x.Gain);
                    sourceDeduction.TaxableWages += taxableWage - naturalAdvantage;
                    sourceDeduction.NaturalAdvantage += naturalAdvantage;
                    sourceDeduction.GrossTaxable += taxableWage;
                    sourceDeduction.RetainedReinvested += NumberConstant.Zero;

                    sourceDeduction.SumIrpp += payslip.PayslipDetails.Any(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Irpp)) ?
                           payslip.PayslipDetails.FirstOrDefault(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Irpp)).Deduction : NumberConstant.Zero;

                    sourceDeduction.Css += payslip.PayslipDetails.Any(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Css)) ?
                                           payslip.PayslipDetails.FirstOrDefault(m => m.IdSalaryRuleNavigation != null &&
                                           m.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Css)).Deduction
                                           : NumberConstant.Zero;
                });
                sourceDeduction.NetToPay = _servicePayslip.PayrollRound(sourceDeduction.GrossTaxable - sourceDeduction.SumIrpp - sourceDeduction.Css);
                sourceDeduction.TaxableWages = _servicePayslip.PayrollRound(sourceDeduction.TaxableWages);
                sourceDeduction.NaturalAdvantage = _servicePayslip.PayrollRound(sourceDeduction.NaturalAdvantage);
                sourceDeduction.GrossTaxable = _servicePayslip.PayrollRound(sourceDeduction.GrossTaxable);
                sourceDeduction.RetainedReinvested = _servicePayslip.PayrollRound(sourceDeduction.RetainedReinvested);
                sourceDeduction.SumIrpp = _servicePayslip.PayrollRound(sourceDeduction.SumIrpp);
                sourceDeduction.Css = _servicePayslip.PayrollRound(sourceDeduction.Css);
            }
            catch (Exception e)
            {
                sourceDeduction.Status = (int)PayslipStatus.Wrong;
            }
            finally
            {
                AddModel(sourceDeduction, null, userMail);
            }
            return sourceDeduction;
        }
        /// <summary>
        /// Generate source deduction for a specific session
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        ///<param name="userMail"></param>
        /// <returns></returns>
        public ICollection<SourceDeductionViewModel> GenerateSourceDeduction(int id, int max, string userMail)
        {
            ICollection<SourceDeductionViewModel> resultObjectData = new List<SourceDeductionViewModel>();
            foreach (var sourceDeduction in GenerateSourceDeductionSession(id, userMail))
            {
                SourceDeductionSessionProgressHub.SendProgress(id, max, _progressHubContext);
                resultObjectData.Add(sourceDeduction.Result);
            }
            SourceDeductionSessionProgressHub.ClearProgress(id, _progressHubContext);
            return resultObjectData;
        }

        /// <summary>
        /// Calculate source deduction for all employees
        /// And regerate the payslips
        /// </summary>
        /// <param name="idSourceDeductionSession"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public IEnumerable<Task<SourceDeductionViewModel>> GenerateSourceDeductionSession(int idSourceDeductionSession, string userMail)
        {
            ICollection<SourceDeductionViewModel> resultObjectData = new List<SourceDeductionViewModel>();
            // Get session details
            SourceDeductionSession sourceDeductionSession = _repoSourceDeductionSession.GetSingle(x => x.Id == idSourceDeductionSession);
            // Get already generated source Deductions 
            IList<SourceDeductionViewModel> sourceDeductionViewModels = FindModelBy(s => s.IdSourceDeductionSession == idSourceDeductionSession).ToList();
            // Delete physically these source Deductions 
            if (sourceDeductionViewModels.Any())
            {
                BulkDeleteModelsPhysicallyWhithoutTransaction(sourceDeductionViewModels.ToList(), userMail);
            }
            IList<int> employeesId = _repoSourceDeductionSessionEmployee.FindBy(x => x.IdSourceDeductionSession == idSourceDeductionSession).Select(x => x.IdEmployee).ToList();
            foreach (int idEmployee in employeesId)
            {
                SourceDeductionViewModel sourceDeductionViewModel = new SourceDeductionViewModel(idEmployee, idSourceDeductionSession, sourceDeductionSession.Year);            
                Task<SourceDeductionViewModel> returnedTaskTResult = Task.Run(() => CalculateDetails(sourceDeductionViewModel, userMail));
                returnedTaskTResult.Wait();
                yield return returnedTaskTResult;
            }
        }


        /// <summary>
        /// Get source deduction informations for the report
        /// </summary>
        /// <param name="idSourceDeduction"></param>
        /// <returns></returns>
        public SourceDeductionReportInformationsViewModel GetSourceDeductionInformations(int idSourceDeduction)
        {
            // Get current company
            CompanyViewModel company = GetCurrentCompany();
            var address = _repoEntityAddress.GetSingleNotTracked(x => x.IdCompany == company.Id);
            if (company == null)
            {
                throw new ArgumentException("");
            }
            SourceDeductionReportInformationsViewModel sourceDeductionReportInformation = new SourceDeductionReportInformationsViewModel
            {
                CompanyMatriculeFisc = company.MatriculeFisc ?? string.Empty,
                CompanyTaxIdentNumber = company.TaxIdentNumber ?? string.Empty,
                CompanyCategory = company.Category ?? string.Empty,
                CompanyName = company.Name ?? string.Empty,
                CompanyAdress = address != null ? address.PrincipalAddress : string.Empty,
                CompanyEmail = company.Email ?? string.Empty,
                CompanyWebSite = company.WebSite ?? string.Empty,
                CompanyTel = company.Tel1 ?? string.Empty,
                CompanySecondaryEstablishment = company.SecondaryEstablishment ?? string.Empty,
                CompanyCountry = address != null && address.IdCountryNavigation != null && !string.IsNullOrEmpty(address.IdCountryNavigation.NameFr) ? address.IdCountryNavigation.NameFr : string.Empty,
                CompanyCity = address != null && address.IdCityNavigation != null && !string.IsNullOrEmpty(address.IdCityNavigation.Label) ? address.IdCityNavigation.Label : string.Empty,
                CompanyZipCode = address != null && address.IdZipCodeNavigation != null && !string.IsNullOrEmpty(address.IdZipCodeNavigation.Code) ? address.IdZipCodeNavigation.Code : string.Empty,
                CompanyCommercialRegister = company.CommercialRegister ?? string.Empty,
                CompanySiret = company.Siret ?? string.Empty,
                StarkWebSiteUrl = GetStarkWebSiteUrl(),
                StarkLogo = GetStarkLogo(),
                CompanyLogo = _serviceCompany.GetReportCompanyInformation().CompanyLogo
            };
            //Get source deduction
            SourceDeduction sourceDeduction = _entityRepo.GetAllWithConditionsQueryable(x => x.Id == idSourceDeduction)
                .Include(x => x.IdEmployeeNavigation).FirstOrDefault();
            if (sourceDeduction != null)
            {
                sourceDeductionReportInformation.EmployeeMatricule = sourceDeduction.IdEmployeeNavigation != null && !string.IsNullOrEmpty(sourceDeduction.IdEmployeeNavigation.Matricule) ? sourceDeduction.IdEmployeeNavigation.Matricule : string.Empty;
                sourceDeductionReportInformation.EmployeeFullName = sourceDeduction.IdEmployeeNavigation != null && !string.IsNullOrEmpty(sourceDeduction.IdEmployeeNavigation.FullName) ? sourceDeduction.IdEmployeeNavigation.FullName : string.Empty;
                sourceDeductionReportInformation.EmployeeMaritalStatus = GetEmployeeMaritalStatus(sourceDeduction.IdEmployeeNavigation.MaritalStatus, sourceDeduction.IdEmployeeNavigation.Sex);
                sourceDeductionReportInformation.EmployeeAdress = sourceDeduction.IdEmployeeNavigation.AddressLine1 + PayRollConstant.BlankSpace +
                                                                  sourceDeduction.IdEmployeeNavigation.AddressLine2 + PayRollConstant.BlankSpace +
                                                                  sourceDeduction.IdEmployeeNavigation.AddressLine3 + PayRollConstant.BlankSpace +
                                                                  sourceDeduction.IdEmployeeNavigation.AddressLine4 + PayRollConstant.BlankSpace +
                                                                  sourceDeduction.IdEmployeeNavigation.AddressLine5;
                sourceDeductionReportInformation.EmployeeJob = _serviceJobEmployee.GetEmployeeJobAsString(sourceDeduction.IdEmployee);
                sourceDeductionReportInformation.EmployeeCIN = sourceDeduction.IdEmployeeNavigation.Cin ?? string.Empty;
                sourceDeductionReportInformation.EmployeeMatriculeCNSS = sourceDeduction.IdEmployeeNavigation.SocialSecurityNumber ?? string.Empty;
                // Calculate Employee Period Worked
                sourceDeductionReportInformation.EmployeePeriodWorked = _servicePayslip.GetModelsWithConditionsRelations(x => x.IdEmployee == sourceDeduction.IdEmployee
                                                                       && x.Month.Year == sourceDeduction.Year, x => x.PayslipDetails).GroupBy(x => x.Month)
                                                                       .Count();
                sourceDeductionReportInformation.EmployeeChildrenNumber = sourceDeduction.IdEmployeeNavigation.ChildrenNumber ?? NumberConstant.Zero;
                sourceDeductionReportInformation.Year = sourceDeduction.Year;
                sourceDeductionReportInformation.Taxableages = sourceDeduction.TaxableWages;
                sourceDeductionReportInformation.NaturalAdvantage = sourceDeduction.NaturalAdvantage;
                sourceDeductionReportInformation.GrossTaxable = sourceDeduction.GrossTaxable;
                sourceDeductionReportInformation.RetainedReinvested = sourceDeduction.RetainedReinvested;
                sourceDeductionReportInformation.SumIrpp = sourceDeduction.SumIrpp;
                sourceDeductionReportInformation.CSS = sourceDeduction.Css;
                sourceDeductionReportInformation.NetToPay = sourceDeduction.NetToPay;
                sourceDeductionReportInformation.GenerationDate = DateTime.Now.Format(DateFormat.ShortDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language);
            }
            return sourceDeductionReportInformation;
        }

        /// <summary>
        /// Prepare session's souce deduction for massive download
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public DownloadReportDataViewModel GetAllSourceDeductionReportSettings(int idSession, string userMail, out IList<SourceDeduction> sourceDeductions)
        {
            SourceDeductionSession sourceDeductionSession = _repoSourceDeductionSession.GetSingleNotTracked(p => p.Id == idSession);
            sourceDeductions = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(m => m.IdSourceDeductionSession == idSession,
                m => m.IdEmployeeNavigation,
                m => m.IdSourceDeductionSessionNavigation).ToList();
            string zipFolderName = string.Concat(nameof(SourceDeduction), GenericConstants.Underscore, sourceDeductionSession.Code, GenericConstants.Underscore,
                    sourceDeductionSession.Year);
            return BuildReportsName(sourceDeductions, zipFolderName);
        }
        public DownloadReportDataViewModel GetSourceDeductionReportSettings(SourceDeduction sourceDeduction)
        {
            SourceDeductionSession sourceDeductionSession = _repoSourceDeductionSession.GetSingleNotTracked(p => p.Id == sourceDeduction.IdSourceDeductionSession);
            sourceDeduction.IdSourceDeductionSessionNavigation = sourceDeductionSession;
            string zipFolderName = string.Concat(nameof(SourceDeduction), GenericConstants.Underscore, sourceDeductionSession.Code, GenericConstants.Underscore,
                    sourceDeductionSession.Year);
            return BuildOneReportsName(sourceDeduction, zipFolderName);
        }

        /// <summary>
        /// Buil reports name and zip folder name
        /// </summary>
        /// <param name="sourceDeductions"></param>
        /// <param name="zipFolderName"></param>
        /// <returns></returns>
        private DownloadReportDataViewModel BuildReportsName(IList<SourceDeduction> sourceDeductions, string zipFolderName)
        {
            dynamic[] dynamicListIds = new dynamic[sourceDeductions.Count];
            int counter = NumberConstant.Zero;
            sourceDeductions.ToList().ForEach(sourceDeduction =>
            {
                dynamic report = new JObject();
                report.idSourceDeduction = sourceDeduction.Id;
                StringBuilder reportName = new StringBuilder();
                report.documentName = reportName.Append(nameof(SourceDeduction)).Append(GenericConstants.Underscore)
                                                .Append(sourceDeduction.IdEmployeeNavigation.LastName).Append(GenericConstants.Underscore)
                                                .Append(sourceDeduction.IdEmployeeNavigation.FirstName).Append(GenericConstants.Underscore)
                                                .Append(sourceDeduction.Year).Append(GenericConstants.Underscore)
                                                .Append(nameof(Session)).Append(GenericConstants.Underscore)
                                                .Append(sourceDeduction.IdSourceDeductionSessionNavigation.Code).ToString();
                dynamicListIds[counter] = report;
                counter++;
            });
            DownloadReportDataViewModel downloadReportDataViewModel = new DownloadReportDataViewModel
            {
                ReportName = nameof(SourceDeduction),
                ReportFormatName = "pdf",
                ZipFolderName = zipFolderName,
                DynamicListIds = dynamicListIds
            };
            UpdateReportSettings(downloadReportDataViewModel);
            return downloadReportDataViewModel;
        }
        private DownloadReportDataViewModel BuildOneReportsName(SourceDeduction sourceDeduction, string zipFolderName)
        {
            dynamic[] dynamicListIds = new dynamic[NumberConstant.One];
            dynamic report = new JObject();
            report.idSourceDeduction = sourceDeduction.Id;
            StringBuilder reportName = new StringBuilder();
            report.documentName = reportName.Append(nameof(SourceDeduction)).Append(GenericConstants.Underscore)
                                            .Append(sourceDeduction.IdEmployeeNavigation.LastName).Append(GenericConstants.Underscore)
                                            .Append(sourceDeduction.IdEmployeeNavigation.FirstName).Append(GenericConstants.Underscore)
                                            .Append(sourceDeduction.Year).Append(GenericConstants.Underscore)
                                            .Append(nameof(Session)).Append(GenericConstants.Underscore)
                                            .Append(sourceDeduction.IdSourceDeductionSessionNavigation.Code).ToString();
            dynamicListIds[NumberConstant.Zero] = report;
            DownloadReportDataViewModel downloadReportDataViewModel = new DownloadReportDataViewModel
            {
                ReportName = nameof(SourceDeduction),
                ReportFormatName = "pdf",
                ZipFolderName = zipFolderName,
                DynamicListIds = dynamicListIds
            };
            UpdateReportSettings(downloadReportDataViewModel);
            return downloadReportDataViewModel;
        }
        /// <summary>
        /// Generate employer declaration annexe II
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public EmployerDeclarationViewModel GetEmployerDeclarationHeader(int year)
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            EmployerDeclarationViewModel employerDeclarationViewModel = new EmployerDeclarationViewModel
            {
                CompanyName = companyViewModel.Name,
                ItemCode = string.Empty,
                Code = string.Empty,
                CompanyTaxRegistrationNumber = companyViewModel.TaxIdentNumber
            };
            DataSourceResult<EmployerDeclarationLinesViewModel> declarationLines = GetEmployerDeclarationBody(year: year);
            employerDeclarationViewModel.EmployerDeclarationLinesViewModels = declarationLines.data;
            employerDeclarationViewModel.NumberOfRecipient = declarationLines.total;
            employerDeclarationViewModel.NumberOfPage = default;
            return employerDeclarationViewModel;
        }

        /// <summary>
        /// Generate annexe II body of the employer declaration
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public DataSourceResult<EmployerDeclarationLinesViewModel> GetEmployerDeclarationBody(PredicateFormatViewModel predicateFormatViewModel = null, int year = default)
        {
            DataSourceResult<EmployerDeclarationLinesViewModel> dataSourceResult = new DataSourceResult<EmployerDeclarationLinesViewModel>
            {
                data = new List<EmployerDeclarationLinesViewModel>()
            };
            IList<SourceDeductionViewModel> sourceDeductions = new List<SourceDeductionViewModel>();
            if (predicateFormatViewModel == null)
            {
                sourceDeductions = GetModelsWithConditionsRelations(x => x.Year == year, x => x.IdEmployeeNavigation).ToList();
                if (sourceDeductions.Any())
                {
                    throw new CustomException(CustomStatusCode.ANY_SOURCE_DEDUCTION);
                }
                dataSourceResult.total = sourceDeductions.Count;
            }
            else
            {
                PredicateFilterRelationViewModel<SourceDeduction> predicateFilterRelationModel = PreparePredicate(predicateFormatViewModel);
                IQueryable<SourceDeduction> sourceDectionQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
                                .BuildOrderBysQue(predicateFormatViewModel.OrderBy);
                dataSourceResult.total = sourceDectionQuery.Count();
                if (dataSourceResult.total == NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.ANY_SOURCE_DEDUCTION);
                }
                sourceDectionQuery = sourceDectionQuery.Skip((predicateFormatViewModel.page - NumberConstant.One) * predicateFormatViewModel.pageSize).Take(predicateFormatViewModel.pageSize);
                sourceDeductions = sourceDectionQuery.Select(_builder.BuildEntity).ToList();
            }
            foreach (SourceDeductionViewModel sourceDeductionViewModel in sourceDeductions)
            {
                EmployerDeclarationLinesViewModel employerDeclarationLinesViewModel = new EmployerDeclarationLinesViewModel
                {
                    WorkTime = DateTime.Now, // mustfix
                    ChildrenNumber = sourceDeductionViewModel.IdEmployeeNavigation.ChildrenNumber,
                    MaritalStatus = sourceDeductionViewModel.IdEmployeeNavigation.MaritalStatus,
                    LastAddress = sourceDeductionViewModel.IdEmployeeNavigation.AddressLine1 + PayRollConstant.BlankSpace +
                                                                  sourceDeductionViewModel.IdEmployeeNavigation.AddressLine2 + PayRollConstant.BlankSpace +
                                                                  sourceDeductionViewModel.IdEmployeeNavigation.AddressLine3 + PayRollConstant.BlankSpace +
                                                                  sourceDeductionViewModel.IdEmployeeNavigation.AddressLine4 + PayRollConstant.BlankSpace +
                                                                  sourceDeductionViewModel.IdEmployeeNavigation.AddressLine5,
                    FullName = sourceDeductionViewModel.IdEmployeeNavigation.FullName,
                    Matricule = sourceDeductionViewModel.IdEmployeeNavigation.Matricule,
                    NetToPay = sourceDeductionViewModel.NetToPay,
                    Css = sourceDeductionViewModel.Css,
                    RetainedReinvested = sourceDeductionViewModel.RetainedReinvested,
                    GrossTaxable = sourceDeductionViewModel.GrossTaxable,
                    NaturalAdvantage = sourceDeductionViewModel.NaturalAdvantage,
                    TaxableWages = sourceDeductionViewModel.TaxableWages
                };
                employerDeclarationLinesViewModel.Job = _serviceJobEmployee.GetEmployeeJobAsString(sourceDeductionViewModel.IdEmployee);
                if (!string.IsNullOrEmpty(sourceDeductionViewModel.IdEmployeeNavigation.Cin))
                {
                    employerDeclarationLinesViewModel.IdentifierOfIdentityPiece = NumberConstant.Two.ToString();
                    employerDeclarationLinesViewModel.IdentityPieceNumber = sourceDeductionViewModel.IdEmployeeNavigation.Cin;
                }
                else
                {
                    var employeeDocument = _entityRepoEmployeeDocument.FindBy(x => x.IdEmployee == sourceDeductionViewModel.IdEmployee
                        && x.Label == "PASSPORT_NUMBER");
                    if (employeeDocument.Any())
                    {
                        employerDeclarationLinesViewModel.IdentityPieceNumber = employeeDocument.FirstOrDefault().Value;
                        employerDeclarationLinesViewModel.IdentifierOfIdentityPiece = NumberConstant.Three.ToString();
                    }
                    else
                    {
                        employerDeclarationLinesViewModel.IdentityPieceNumber = string.Empty;
                        employerDeclarationLinesViewModel.IdentifierOfIdentityPiece = string.Empty;
                    }
                }
                employerDeclarationLinesViewModel.ReducedAmountTwentyPerCent = default;
                employerDeclarationLinesViewModel.ReducedAmount = default;
                dataSourceResult.data.Add(employerDeclarationLinesViewModel);
            }
            return dataSourceResult;
        }

        /// <summary>
        /// Returns the employee's sex as a character string
        /// </summary>
        /// <param name="maritalStatusEnumerator"></param>
        /// <returns></returns>
        private string GetEmployeeMaritalStatus(int? maritalStatusEnumerator, int? gender)
        {
            switch (maritalStatusEnumerator)
            {
                case (int)MaritalStatusEnumerator.Single:
                    return PayRollConstant.Single;
                case (int)MaritalStatusEnumerator.Married:
                    return PayRollConstant.Married;
                case (int)MaritalStatusEnumerator.Divorced:
                    return PayRollConstant.Divorced;
                case (int)MaritalStatusEnumerator.Widow:
                    return gender != null && gender == NumberConstant.Two ? PayRollConstant.Widow : PayRollConstant.Widower;
                default:
                    return string.Empty;
            }
        }

        public void BrodcastSourceDeduction(string userMail, int idsession, string link, IDictionary<Employee, FileInfoViewModel> dictionary, SmtpSettings smtpSettings)
        {
            User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
            SourceDeductionSession session = _repoSourceDeductionSession.FindSingleBy(x => x.Id == idsession);

            // prepare the notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters[Constants.SESSION_TITLE] = "\"" + session.Title + "\"";
            InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_PAYSLIP)
                      .FirstOrDefault();

            // Get all Users from employees
            IList<User> users = _entityRepoUser.FindByAsNoTracking(x => x.IdEmployee.HasValue && dictionary.Keys.Select(m => m.Id).Contains(x.IdEmployee.Value)).ToList();

            // save all payslips in disk and send mails
            foreach (var employee in dictionary.Keys)
            {
                // Save the file in the disk && Save sharedDocument Line
                int generatedId = SaveSharedDocument(connectedUser, employee, dictionary[employee], userMail);

                // send mail 
                User user = users.Where(x => x.IdEmployee == employee.Id).FirstOrDefault();
                if (user != null)
                {
                    // send mail 
                    SendEmail(information, user, session, userMail, link, parameters, smtpSettings);
                }
            }
            // send notif
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SHARING_PAYSLIP,
            idsession, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertSharingDocument,
            userMail, parameters, users.ToList(), GetCurrentCompany().Code);
        }
        public void BrodcastOneSourceDeduction(string userMail, int idsession, string link, IDictionary<Employee, FileInfoViewModel> dictionary, SourceDeduction sourceDeduction, SmtpSettings smtpSettings)
        {
            User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
            SourceDeductionSession session = _repoSourceDeductionSession.FindSingleBy(x => x.Id == idsession);

            // prepare the notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters[Constants.SESSION_TITLE] = "\"" + session.Title + "\"";
            InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_PAYSLIP)
                      .FirstOrDefault();
            if (sourceDeduction != null && dictionary != null)
            {
                // Get User from employe 
                IList<User> users = _entityRepoUser.FindByAsNoTracking(x => x.IdEmployee.HasValue && x.IdEmployee.Value == sourceDeduction.IdEmployee).ToList();
                // Save the file in the disk && Save sharedDocument Line
                int generatedId = SaveSharedDocument(connectedUser, sourceDeduction.IdEmployeeNavigation, dictionary[sourceDeduction.IdEmployeeNavigation], userMail);
                if (users != null && users.Count > NumberConstant.Zero)
                {
                    // send mail 
                    SendEmail(information, users.FirstOrDefault(), session, userMail, link, parameters, smtpSettings);
                }
                // send notif
                _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SHARING_PAYSLIP,
                idsession, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertSharingDocument,
                userMail, parameters, users.ToList(), GetCurrentCompany().Code);
            }
        }

        int SaveSharedDocument(User connectedUser, Employee employee, FileInfoViewModel fileInfo, string userMail)
        {
            // connctedUser is the person who has the action to distribute payslips
            // while Id employee is the person concerned by the payslip
            if (connectedUser == null)
            {
                throw new CustomException(CustomStatusCode.NotFound);
            }

            SharedDocumentViewModel sharedDocument = new SharedDocumentViewModel
            {
                Id = 0,
                IdEmployee = employee.Id,
                SubmissionDate = DateTime.Now,
                IdType = (int)DocumentRequestTypeEnumerator.Payslip,
                FilesInfos = new List<FileInfoViewModel> { fileInfo },
                TransactionUserId = connectedUser.Id,
                EncryptFile = true
            };
            return ((CreatedDataViewModel)_serviceSharedDocument.AddModel(sharedDocument, null, connectedUser.Email, null)).Id;

        }

        public void SendEmail(InformationViewModel information, User user, SourceDeductionSession session, string userMail, string link, IDictionary<string, dynamic> parameters, SmtpSettings smtpSettings)
        {

            EmailConstant emailConstant = new EmailConstant(user.Lang);
            string subject = PrepareMailSubject(emailConstant, session.Title);
            string message = PrepareMessage(user, information, parameters);
            StringBuilder path = new StringBuilder();
            path.Append(link); path.Append(information.Url);
            string mailUrl = PrepareUrl(emailConstant, path.ToString());
            string body = PrepareMailBody(emailConstant, message, mailUrl);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = user.Email
            };
            // add the email in the db
            _serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail);
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
        }

        string PrepareMailSubject(EmailConstant emailConstant, string sessionTitle)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.SourceDeductionEmailSubject);
            subject.Append("\"");
            subject.Append(sessionTitle);
            subject.Append("\"");
            return subject.ToString();
        }
        public string PrepareMessage(User user, InformationViewModel information, IDictionary<string, dynamic> parameters)
        {
            StringBuilder msgBuilder = new StringBuilder();
            switch (user.Lang)
            {
                case "fr":
                    msgBuilder.Append(information.Fr);
                    break;
                case "en":
                    msgBuilder.Append(information.En);
                    break;
            }
            string msg = msgBuilder.ToString();

            if (msg.IndexOf(SESSION_TITLE) > -1)
            {
                msg = msg.Replace(SESSION_TITLE, parameters[Constants.SESSION_TITLE].ToString(), StringComparison.OrdinalIgnoreCase);
            }
            return msg;
        }
        string PrepareUrl(EmailConstant emailConstant, string url)
        {
            StringBuilder Url = new StringBuilder();
            Url.Append("<a href='");
            Url.Append(@url);
            Url.Append("'>");
            Url.Append(emailConstant.AccessToYourSpace);
            Url.Append("</a>");
            return Url.ToString();
        }
        string PrepareMailBody(EmailConstant emailConstant, string msg, string link)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.SharingDocumentEmailTemplate);
            body = body.Replace("{MESSAGE}", msg, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LINK}", link, StringComparison.OrdinalIgnoreCase);
            return body;
        }
    }
}
