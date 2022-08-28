using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceCnssDeclaration : Service<CnssDeclarationViewModel, CnssDeclaration>, IServiceCnssDeclaration
    {
        private readonly IServicePayslipDetails _servicePayslipDetails;
        private readonly IServiceCnssDeclarationDetails _serviceCnssDeclarationDetails;
        private readonly IServiceEmployeeDocument _serviceEmployeeDocument;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceCnss _serviceCnss;
        private readonly IServiceSessionContract _serviceSessionContract;
        private readonly IServicePayslip _servicePayslip;
        private readonly IServiceCnssDeclarationSession _serviceCnssDeclarationSession;
        private readonly IRepository<Address> _entityRepoAddress;
        public ServiceCnssDeclaration(IServiceCnssDeclarationDetails serviceCnssDeclarationDetails, IServicePayslipDetails servicePayslipDetails,
            IServiceEmployeeDocument serviceEmployeeDocument, IServiceSessionContract serviceSessionContract, IServiceEmployee serviceEmployee,
            IServiceCnss serviceCnss, IRepository<CnssDeclaration> entityRepo, IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            ICnssDeclarationBuilder builder, IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification, IEntityAxisValuesBuilder builderEntityAxisValues, IServicePayslip servicePayslip,
           IServiceCnssDeclarationSession serviceCnssDeclarationSession, IRepository<Address> entityRepoAddress)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                    entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _servicePayslipDetails = servicePayslipDetails;
            _serviceSessionContract = serviceSessionContract;
            _serviceCnssDeclarationDetails = serviceCnssDeclarationDetails;
            _serviceEmployeeDocument = serviceEmployeeDocument;
            _serviceEmployee = serviceEmployee;
            _serviceCnss = serviceCnss;
            _servicePayslip = servicePayslip;
            _serviceCnssDeclarationSession = serviceCnssDeclarationSession;
            _entityRepoAddress = entityRepoAddress;
        }

        public object GenerateCnssDeclaration(CnssDeclarationViewModel model, string userMail)
        {
            CnssDeclarationViewModel cnssDeclarationBeforeUpdate = GetModelById(model.Id);
            if (cnssDeclarationBeforeUpdate != null)
            {
                _serviceCnssDeclarationSession.BulkDeleteModelsPhysicallyWhithoutTransaction(cnssDeclarationBeforeUpdate.CnssDeclarationSession.ToList());
                IList<CnssDeclarationDetailsViewModel> oldCnssDeclarationDetails = _serviceCnssDeclarationDetails.FindModelsByNoTracked(x => x.IdCnssDeclaration == model.Id).ToList();
                _serviceCnssDeclarationDetails.BulkDeleteModelsPhysicallyWhithoutTransaction(oldCnssDeclarationDetails);
            }
            GenerateCnssDeclarationDetails(model);
            return model.Id == default ? base.AddModelWithoutTransaction(model, null, userMail) : base.UpdateModelWithoutTransaction(model, null, userMail);
        }

        /// <summary>
        /// Generate cnss declaration details
        /// </summary>
        /// <param name="model"></param>
        private void GenerateCnssDeclarationDetails(CnssDeclarationViewModel model)
        {
            model.CnssDeclarationDetails = new List<CnssDeclarationDetailsViewModel>();
            // Set the creation date with current date
            model.CreationDate = DateTime.Now;
            // Get the first month of select trimester
            int firstMonth = NumberConstant.Three * model.Trimester - NumberConstant.Two;
            // Get employees associated with closed sessions of the trimester
            List<SessionContractViewModel> sessionContractViewModels = _serviceSessionContract.FindModelsByNoTracked(x =>
                model.CnssDeclarationSession.Any(c => c.IdSession == x.IdSession) &&
                x.IdSessionNavigation.Month.Year.Equals(model.Year) &&
                (x.IdSessionNavigation.Month.Month.Equals(firstMonth) ||
                    x.IdSessionNavigation.Month.Month.Equals(firstMonth + NumberConstant.One) ||
                    x.IdSessionNavigation.Month.Month.Equals(firstMonth + NumberConstant.Two)) &&
                    !x.IdContractNavigation.IdContractTypeNavigation.Code.Equals(PayRollConstant.Sivp)
                    && x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed,
                x => x.IdContractNavigation,
                x => x.IdContractNavigation.IdEmployeeNavigation,
                x => x.IdSessionNavigation).ToList();
            // Eliminate duplicate data in quarter's sessionEmployee
            var sessionContractViewModelsGroupByidEmployee = sessionContractViewModels
                   .Distinct(new SessionContractIdComparer()).OrderBy(x => x.IdContractNavigation.IdEmployeeNavigation.FullName)
                   .GroupBy(x => x.IdContractNavigation.IdEmployee).ToList();
            // Declare a counter to know details line index
            int numberOrder = NumberConstant.One;
            int pageNumber = NumberConstant.One;
            // Foreach employee, calculate Cnssdeclaration line
            foreach (var sessionContracts in sessionContractViewModelsGroupByidEmployee)
            {
                CnssDeclarationDetailsViewModel cnssDeclarationDetailsByEmployee = new CnssDeclarationDetailsViewModel
                {
                    IdEmployee = sessionContracts.Key,
                    NumberOrder = numberOrder,
                    PageNumber = pageNumber
                };
                sessionContracts.ToList().ForEach(x =>
                {
                    // Calculate and return the line of current employee
                    CnssDeclarationDetailsViewModel CnssDeclarationDetailsViewModel = CalculateCnssDeclarationDetails(model.IdCnss,
                        firstMonth, model.Year, pageNumber, numberOrder, x.IdContract,
                        x.IdSessionNavigation.Month.Month, x.IdSessionNavigation.Id);
                    cnssDeclarationDetailsByEmployee.FirstMonthValue += CnssDeclarationDetailsViewModel.FirstMonthValue;
                    cnssDeclarationDetailsByEmployee.SecondMonthValue += CnssDeclarationDetailsViewModel.SecondMonthValue;
                    cnssDeclarationDetailsByEmployee.ThirdMonthValue += CnssDeclarationDetailsViewModel.ThirdMonthValue;
                    cnssDeclarationDetailsByEmployee.Total += CnssDeclarationDetailsViewModel.Total;
                });
                cnssDeclarationDetailsByEmployee.FirstMonthValue = _servicePayslip.PayrollRound(cnssDeclarationDetailsByEmployee.FirstMonthValue);
                cnssDeclarationDetailsByEmployee.SecondMonthValue = _servicePayslip.PayrollRound(cnssDeclarationDetailsByEmployee.SecondMonthValue);
                cnssDeclarationDetailsByEmployee.ThirdMonthValue = _servicePayslip.PayrollRound(cnssDeclarationDetailsByEmployee.ThirdMonthValue);
                cnssDeclarationDetailsByEmployee.Total = _servicePayslip.PayrollRound(cnssDeclarationDetailsByEmployee.Total);
                // Add the CnssDeclarationDetails to list of details
                model.CnssDeclarationDetails.Add(cnssDeclarationDetailsByEmployee);
                // Increment the counter
                numberOrder++;
                if (numberOrder == NumberConstant.Thirteen)
                {
                    pageNumber++;
                    numberOrder = NumberConstant.One;
                }
            }
            if (model.CnssDeclarationDetails.Count == NumberConstant.Zero)
            {
                CnssViewModel cnss = _serviceCnss.GetModelById(model.IdCnss);
                throw new CustomException(CustomStatusCode.CnssDeclarationDetailsException, new Dictionary<string, dynamic>
                {
                    { PayRollConstant.Cnss, cnss.Label }
                });
            }
            model.TotalAmount = _servicePayslip.PayrollRound(model.CnssDeclarationDetails.Sum(x => x.Total));
        }


        /// <summary>
        /// Calculate Cnss declaration lines
        /// </summary>
        /// <param name="idCnss"></param>
        /// <param name="firstMonth"></param>
        /// <param name="year"></param>
        /// <param name="pageNumber"></param>
        /// <param name="NumberOrder"></param>
        /// <param name="idContract"></param>
        /// <param name="sessionMonth"></param>
        /// <param name="idSession"></param>
        /// <returns></returns>
        private CnssDeclarationDetailsViewModel CalculateCnssDeclarationDetails(int idCnss, int firstMonth, int year, int pageNumber, int NumberOrder, int idContract, int sessionMonth, int idSession)
        {
            int month = (firstMonth == sessionMonth) ? NumberConstant.One : (firstMonth + NumberConstant.One == sessionMonth) ? NumberConstant.Two : NumberConstant.Three;
            double amont = GetEmployeeTaxableSalaryByMonth(idCnss, idContract, sessionMonth, year, idSession);
            CnssDeclarationDetailsViewModel cnssDeclarationDetailsViewModel = new CnssDeclarationDetailsViewModel
            {
                // Page number
                PageNumber = pageNumber,
                // Set NumberOrder
                NumberOrder = NumberOrder,
                // Calculate the amount paid by the employer firstMonth
                FirstMonthValue = month == NumberConstant.One ? amont : NumberConstant.Zero,
                // Calculate the amount paid by the employer secondMonth
                SecondMonthValue = month == NumberConstant.Two ? amont : NumberConstant.Zero,
                // Calculate the amount paid by the employer thirdMonth
                ThirdMonthValue = month == NumberConstant.Three ? amont : NumberConstant.Zero
            };
            // Calculate the total amount paid by the employer for current employee
            cnssDeclarationDetailsViewModel.Total = cnssDeclarationDetailsViewModel.FirstMonthValue +
                cnssDeclarationDetailsViewModel.SecondMonthValue +
                cnssDeclarationDetailsViewModel.ThirdMonthValue;
            // return the detail
            return cnssDeclarationDetailsViewModel;
        }

        /// <summary>
        /// Get the employee taxable salary for specific month
        /// </summary>
        /// <param name="cnssViewModel"></param>
        /// <param name="IdEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        private double GetEmployeeTaxableSalaryByMonth(int idCnss, int idContract, int month, int year, int idSession)
        {
            try
            {
                double result = default;
                // Get base salary if employee contract cnss is equals to idCnss in parameter
                IList<PayslipDetailsViewModel> baseSalary = _servicePayslipDetails.FindModelBy(detail =>
                   detail.IdPayslipNavigation.IdContract.Equals(idContract)
                   && detail.IdPayslipNavigation.IdContractNavigation.IdCnssNavigation.Id.Equals(idCnss)
                   && detail.IdPayslipNavigation.Month.Month.Equals(month)
                   && detail.IdPayslipNavigation.Month.Year.Equals(year)
                   && detail.IdPayslipNavigation.IdSession.Equals(idSession)
                   && !detail.IdPayslipNavigation.IdContractNavigation.IdContractTypeNavigation.Code.Equals(PayRollConstant.Sivp)
                   && detail.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference.Equals(PayRollConstant.Base)).ToList();
                // Calculate sum of base salary, maybe employee have more than one contract
                baseSalary.ToList().ForEach(model =>
                {
                    result += model.Gain;
                });
                // Get bonuses associated with this cnss for specified employee
                IList<PayslipDetailsViewModel> detailsBonus = _servicePayslipDetails.FindModelBy(detail =>
                   detail.IdPayslipNavigation.IdContract.Equals(idContract)
                   && (detail.IdBonusNavigation.IdCnssNavigation.Id.Equals(idCnss) || detail.IdBenefitInKindNavigation.IdCnssNavigation.Id.Equals(idCnss))
                   && detail.IdPayslipNavigation.Month.Month.Equals(month)
                   && detail.IdPayslipNavigation.Month.Year.Equals(year)
                   && detail.IdPayslipNavigation.IdSession.Equals(idSession)
                   && !detail.IdPayslipNavigation.IdContractNavigation.IdContractTypeNavigation.Code.Equals(PayRollConstant.Sivp)).ToList();
                // Get the bonus
                detailsBonus.ToList().ForEach(detail =>
                {
                    result += detail.Gain;
                });
                return result;
            }
            catch (Exception)
            {
                throw new CustomException(CustomStatusCode.CNSS_DECLARATION_ERROR);
            }
        }

        /// <summary>
        /// Generate the teledeclaration file of the type Cnss in parameter
        /// </summary>
        /// <param name="idCnssDeclaration"></param>
        public FileInfoViewModel GetTeleDeclaration(int idCnssDeclaration)
        {
            string fileName = string.Empty;
            FileInfoViewModel fileInfoViewModel = new FileInfoViewModel();
            if (idCnssDeclaration.Equals(NumberConstant.Zero))
            {
                throw new ArgumentException("");
            }
            // Get the Cnss declaration informations
            CnssDeclarationInformationsViewModel cnssDeclarationInformationsViewModel = GetCnssDeclaration(idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel);

            StringBuilder fileNameBuilder = new StringBuilder();
            fileNameBuilder.Append(PayRollConstant.Ds);
            if (string.IsNullOrEmpty(cnssDeclarationInformationsViewModel.CnssAffiliation) ||
                cnssDeclarationInformationsViewModel.CnssAffiliation.Length != NumberConstant.Ten)
            {
                throw new CustomException(CustomStatusCode.COMPANY_CNSS_AFFILIATION_INCORRECT, new Dictionary<string, dynamic>
                {
                    { PayRollConstant.Length, Convert.ToString(NumberConstant.Ten) }
                });
            }
            fileNameBuilder.Append(cnssDeclarationInformationsViewModel.CnssAffiliation);
            if (string.IsNullOrEmpty(cnssDeclarationInformationsViewModel.ExploitationCode) ||
                cnssDeclarationInformationsViewModel.ExploitationCode.Length != NumberConstant.Four)
            {
                throw new CustomException(CustomStatusCode.CNSS_EXPLOITATION_CODE_INCORRECT, new Dictionary<string, dynamic>
                {
                    { PayRollConstant.Length, Convert.ToString(NumberConstant.Four) }
                });
            }
            fileNameBuilder.Append(cnssDeclarationInformationsViewModel.ExploitationCode);
            fileNameBuilder.Append(PayRollConstant.Point);
            fileNameBuilder.Append(CompleteString(cnssDeclarationInformationsViewModel.Trimester, NumberConstant.One));
            fileNameBuilder.Append(CompleteString(cnssDeclarationInformationsViewModel.Year.ToString(), NumberConstant.Four));
            StringBuilder lineBegining = new StringBuilder();
            lineBegining.Append(CompleteString(cnssDeclarationInformationsViewModel.CnssAffiliation, NumberConstant.Ten));
            lineBegining.Append(CompleteString(cnssDeclarationInformationsViewModel.ExploitationCode, NumberConstant.Four));
            lineBegining.Append(CompleteString(cnssDeclarationInformationsViewModel.Trimester, NumberConstant.One));
            lineBegining.Append(CompleteString(cnssDeclarationInformationsViewModel.Year.ToString(), NumberConstant.Four));
            IList<CnssDeclarationLinesViewModel> cnssDeclarationLinesViewModels = _serviceCnssDeclarationDetails.GetCnssDeclarationLines(idCnssDeclaration);
            try
            {
                // Build temporarly folder path
                string path = Path.Combine(_appSettings.UploadFilePath, _entityRepoCompany.GetSingleNotTracked(x => true).Name);
                // If folder does not exist create it
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                // Build file name
                fileInfoViewModel.Name = fileNameBuilder.ToString();
                fileName = Path.Combine(path, fileInfoViewModel.Name);
                // Using streamwriter for wrinte in temp file
                using (StreamWriter writer = new StreamWriter(fileName, false, new UTF8Encoding(false)))
                {
                    // Number of page
                    int numberPage = NumberConstant.One;
                    int temp = numberPage;
                    foreach (CnssDeclarationLinesViewModel cnssDeclarationLinesViewModel in cnssDeclarationLinesViewModels)
                    {
                        StringBuilder line = new StringBuilder(lineBegining.ToString());
                        line.Append(CompleteString(numberPage.ToString(), NumberConstant.Three, reverse: false));
                        line.Append(CompleteString(cnssDeclarationLinesViewModel.NumberOrder.ToString(), NumberConstant.Two, reverse: false));
                        if (string.IsNullOrEmpty(cnssDeclarationLinesViewModel.EmployeeCnssNumber) ||
                            cnssDeclarationLinesViewModel.EmployeeCnssNumber.Length != NumberConstant.Ten)
                        {
                            throw new CustomException(CustomStatusCode.EMPLOYEE_CNSS_NUMBER_INCORRECT, new Dictionary<string, dynamic>
                            {
                                { nameof(Employee), cnssDeclarationLinesViewModel.EmployeeFullName },
                                { PayRollConstant.Length, Convert.ToString(NumberConstant.Ten) }
                            });
                        }
                        line.Append(cnssDeclarationLinesViewModel.EmployeeCnssNumber);
                        line.Append(CompleteString(cnssDeclarationLinesViewModel.EmployeeFullName, NumberConstant.Sixty, gap: PayRollConstant.CharSpace));
                        if (string.IsNullOrEmpty(cnssDeclarationLinesViewModel.IdentityPiece) ||
                            cnssDeclarationLinesViewModel.IdentityPiece.Length > NumberConstant.Eight)
                        {
                            throw new CustomException(CustomStatusCode.EMPLOYEE_IDENTITY_PIECE_INCORRECT, new Dictionary<string, dynamic>
                            {
                                { nameof(Employee), cnssDeclarationLinesViewModel.EmployeeFullName },
                                { PayRollConstant.Length, Convert.ToString(NumberConstant.Eight) }
                            });
                        }
                        line.Append(CompleteString(cnssDeclarationLinesViewModel.IdentityPiece, NumberConstant.Eight));
                        line.Append(CompleteString((cnssDeclarationLinesViewModel.Total * NumberConstant.Thousand).ToString(), NumberConstant.Ten, reverse: false));
                        line.Append(CompleteString(string.Empty, NumberConstant.Ten));
                        writer.WriteLine(line.ToString());
                        temp++;
                        if (temp == NumberConstant.Thirteen)
                        {
                            temp = NumberConstant.One;
                            numberPage++;
                        }
                    }
                }
                // Convert file contain in byte and send it to front
                fileInfoViewModel.Data = File.ReadAllBytes(fileName);
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                // Delete temp file
                File.Delete(fileName);
            }
            // return the file info view model
            return fileInfoViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="element"></param>
        /// <param name="sizeRequired"></param>
        /// <returns></returns>
        private string CompleteString(string element, int sizeRequired, char gap = '0', bool reverse = true)
        {
            string value = element;
            if (sizeRequired.Equals(NumberConstant.Zero))
            {
                throw new ArgumentException("");
            }
            if (string.IsNullOrEmpty(element))
            {
                value = string.Empty;
            }
            if (value.Length > sizeRequired)
            {
                throw new CustomException(CustomStatusCode.PARAMETER_LENGTH_EXCEED);
            }
            string serie = string.Empty;
            int length = value.Length;
            int rest = sizeRequired - length;
            if (rest > NumberConstant.Zero)
            {
                serie = new String(gap, rest);
            }
            string result = reverse ? String.Concat(value, serie) : String.Concat(serie, value);
            return result;
        }

        /// <summary>
        /// Get the Cnss declaration informations mainly for reporting
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        public CnssDeclarationInformationsViewModel GetCnssDeclaration(int idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel)
        {
            CnssDeclarationInformationsViewModel model = new CnssDeclarationInformationsViewModel();
            // Get the society
            var company = _entityRepoCompany.GetSingleWithRelationsNotTracked(x => true, x => x.IdCurrencyNavigation);
            var address = _entityRepoAddress.GetSingleNotTracked(x => x.IdCompany == company.Id);
            // Get the appropriate Cnss declaration with CNSS navigation
            cnssDeclarationViewModel = GetModelWithRelations(cnssDeclaration =>
                cnssDeclaration.Id.Equals(idCnssDeclaration),
                cnssDeclaration => cnssDeclaration.IdCnssNavigation);
            if (cnssDeclarationViewModel == null || company == null)
            {
                throw new ArgumentException("");
            }
            model.EmployerName = company.Name.ToUpperInvariant();
            model.EmployerAdress = address != null ? address.PrincipalAddress : string.Empty;
            model.EmployerNumber = company.MatriculeFisc;
            model.Currency = company.IdCurrencyNavigation.Symbole;
            model.CnssAffiliation = company.CnssAffiliation;
            model.BR = string.Empty;
            model.Trimester = cnssDeclarationViewModel.Trimester.ToString();
            model.Year = cnssDeclarationViewModel.Year;
            model.ElaborationDate = cnssDeclarationViewModel.CreationDate.ToString();
            model.ExploitationCode = cnssDeclarationViewModel.IdCnssNavigation.OperatingCode;
            model.TotalAmount = cnssDeclarationViewModel.TotalAmount;
            model.MatriculeFisc = company.MatriculeFisc;
            return model;
        }

        public override CnssDeclarationViewModel GetModelById(int id)
        {
            return GetModelAsNoTracked(x => x.Id == id, x => x.CnssDeclarationSession);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void CloseCnssDeclaration(CnssDeclarationViewModel model, string userMail)
        {
            UpdateModel(model, null, userMail);
        }
    }
}
