using Microsoft.Extensions.DependencyInjection;
using Services.Catalog.Classes;
using Services.Catalog.Interfaces;
using Services.Reporting.Classes;
using Services.Reporting.Interfaces;
using Services.Specific.Administration.Classes;
using Services.Specific.Administration.Classes.ServicePeriod;
using Services.Specific.Administration.Interfaces;
using Services.Specific.BToB.Classes;
using Services.Specific.BToB.interfaces;
using Services.Specific.Dashboard.Classes;
using Services.Specific.Dashboard.Interfaces;
using Services.Specific.Ecommerce.Classes;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.ErpSettings.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Helpdesk.Classes;
using Services.Specific.Helpdesk.Interfaces;
using Services.Specific.Immobilisation.Classes;
using Services.Specific.Immobilisation.Interfaces;
using Services.Specific.Inventory.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Payment.Classes;
using Services.Specific.Payment.Interfaces;
using Services.Specific.PayRoll.Classes;
using Services.Specific.PayRoll.Classes.ServiceContract;
using Services.Specific.PayRoll.Classes.ServiceEmployee;
using Services.Specific.PayRoll.Classes.ServiceLeave;
using Services.Specific.PayRoll.Classes.SpecificLanguage;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Services.Specific.RH.Classes;
using Services.Specific.RH.Classes.ServiceInterview;
using Services.Specific.RH.Classes.ServiceReview;
using Services.Specific.RH.Classes.ServiceTimeSheet;
using Services.Specific.RH.Interfaces;
using Services.Specific.Sales.Classes;
using Services.Specific.Sales.Classes.Documents;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Classes;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Treasury.Classes;
using Services.Specific.Treasury.Interfaces;
using ViewModels.Comparers;
using Web.Interceptors.Proxy;
using ServiceStockDocument = Services.Specific.Inventory.Classes.StockDocuments.ServiceStockDocument;

/// <summary>
/// The Web namespace.
/// </summary>
namespace Web.App_Start
{
    /// <summary>
    /// Class IocServices.
    /// </summary>
    public static class IocServices
    {
        /// <summary>
        /// Registerses the specified services.
        /// </summary>
        /// <param name="services">The services.</param>
        public static void RegisterServices(this IServiceCollection services)
        {
            services.RegisterMasterServices();
            services.RegisterSharedServices();
            services.RegisterInventoryServices();
            services.RegisterPayRollServices();
            services.RegisterSalesServices();
            services.RegisterPayementServices();
            services.RegisterErpSettingsServices();
            services.RegisterAdministrationServices();
            services.RegisterImmobilisationServices();
            services.RegisterOtherServices();
            services.RegisterRHServices();
            services.RegisterHelpdeskServices();
            services.RegisterEcommerceServices();
            services.RegisterTreasuryServices();
        }


        private static void RegisterEcommerceServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceTriggerItemLog, ServiceTriggerItemLog>();
            services.AddScoped<IServiceEcommerce, ServiceEcommerce>();
            services.AddScoped<IServiceJobTable, ServiceJobTable>();
            services.AddScoped<IServiceDelivery, ServiceDelivery>();  
           services.AddScoped<IServiceSharedEcommerce, ServiceSharedEcommerce>();
        }


        ///// <summary>
        ///// Register Services by module : Invrntory
        ///// </summary>
        ///// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterInventoryServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceItem, ServiceItem>();
            services.AddScoped<IServiceTaxeItem, ServiceTaxeItem>();
            services.AddScoped<IServiceTaxe, ServiceTaxe>();
            services.AddScoped<IServiceTaxeType, ServiceTaxeType>();
            services.AddScoped<IServiceMeasureUnit, ServiceMeasureUnit>();
            services.AddScoped<IServiceWarehouse, ServiceWarehouse>();
            services.AddScoped<IServiceItemWarehouse, ServiceItemWarehouse>();
            services.AddScoped<IServiceStockMovement, ServiceStockMovement>();
            services.AddScoped<IServiceStockDocument, ServiceStockDocument>();
            services.AddScoped<IServiceStockDocumentLine, ServiceStockDocumentLine>();
            services.AddScoped<IServiceStockDocumentType, ServiceStockDocumentType>();
            services.AddScoped<IServiceNature, ServiceNature>();
            services.AddScoped<IServiceVehicleBrand, ServiceVehicleBrand>();
            services.AddScoped<IServiceFamily, ServiceFamily>();
            services.AddScoped<IServiceModelOfItem, ServiceModelOfItem>();
            services.AddScoped<IServiceSubFamily, ServiceSubFamily>();
            services.AddScoped<IServiceShelf, ServiceShelf>();
            services.AddScoped<IServiceStorage, ServiceStorage>();
            services.AddScoped<IServiceSubModel, ServiceSubModel>();
            services.AddScoped<IServiceItemKit, ServiceItemKit>();
            services.AddScoped<IServiceItemVehicleBrandModelSubModel, ServiceItemVehicleBrandModelSubModel>();
            services.AddScoped<IServiceProductItem, ServiceProductItem>();
            services.AddScoped<IServiceMovementHistory, ServiceMovementHistory>();
            services.AddScoped<IServiceOem, ServiceOem>();
            services.AddScoped<IServiceItemPrices, ServiceItemPrices>();
            services.AddScoped<IServiceItemTiers, ServiceItemTiers>();
            services.AddScoped<IServiceOemItem, ServiceOemItem>();
            services.AddScoped<IServiceItemSalesPrice, ServiceItemSalesPrice>();
            services.AddScoped<IServiceUserWarehouse, ServiceUserWarehouse>();



        }
        ///// <summary>
        ///// Register Services by module : Sales
        ///// </summary>
        ///// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterSalesServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceTiers, ServiceTiers>();
            services.AddScoped<IServiceDocument, ServiceDocument>();
            services.AddScoped<IServiceDocumentLine, ServiceDocumentLine>();
            services.AddScoped<IServiceDocumentType, ServiceDocumentType>();
            services.AddScoped<IServiceTypePrices, ServiceTypePrices>();
            services.AddScoped<IServicePrices, ServicePrices>();
            services.AddScoped<IServiceTaxeGroupTiers, ServiceTaxeGroupTiers>();
            services.AddScoped<IServiceTaxeGroupTiersConfig, ServiceTaxeGroupTiersConfig>();
            services.AddScoped<IServiceSettlement, ServiceSettlement>();
            services.AddScoped<IServiceSettlementCommitment, ServiceSettlementCommitment>();
            services.AddScoped<IServiceFinancialCommitment, ServiceFinancialCommitment>();
            services.AddScoped<IServiceSettlementMode, ServiceSettlementMode>();
            services.AddScoped<IServiceSettlementType, ServiceSettlementType>();
            services.AddScoped<IServiceDetailsSettlementMode, ServiceDetailsSettlementMode>();
            services.AddScoped<IServiceSaleSettings, ServiceSaleSettings>();
            services.AddScoped<IServicePurchaseSettings, ServicePurchaseSettings>();
            services.AddScoped<IServiceMessageDocument, ServiceMessageDocument>();
            services.AddScoped<IServiceDocumentLineTaxe, ServiceDocumentLineTaxe>();
            services.AddScoped<IServicePriceRequest, ServicePriceRequest>();
            services.AddScoped<IServicePriceRequestDetail, ServicePriceRequestDetail>();
            services.AddScoped<IServiceExpense, ServiceExpense>();
            services.AddScoped<IServiceDocumentExpenseLine, ServiceDocumentExpenseLine>();
            services.AddScoped<IServiceMessagePriceRequest, ServiceMessagePriceRequest>();
            services.AddScoped<IServiceBillingSession, ServiceBillingSession>();
            services.AddScoped<IServiceProvisioning, ServiceProvisioning>();
            services.AddScoped<IServiceProvisioningDetails, ServiceProvisioningDetails>();
            services.AddScoped<IServiceSearchItem, ServiceSearchItem>();
            services.AddScoped<IServiceDeliveryType, ServiceDeliveryType>();
            services.AddScoped<IServiceReflectiveSettlement, ServiceReflectiveSettlement>();
            services.AddScoped<IServiceDocumentLineNegotiationOptions, ServiceDocumentLineNegotiationOptions>();
            services.AddScoped<IServiceBillingEmployee, ServiceBillingEmployee>();
            services.AddScoped<IServiceDocumentWithholdingTax, ServiceDocumentWithholdingTax>();
            services.AddScoped<IServiceTiersProvisioning, ServiceTiersProvisioning>();
            services.AddScoped<IServicePriceDetail, ServicePriceDetail>();
            services.AddScoped<IServiceTiersPrices, ServiceTiersPrices>();
            services.AddScoped<IServiceDocumentTaxeResume, ServiceDocumentTaxeResume>();
            services.AddScoped<IServiceBToBShared, ServiceBToBShared>();
            services.AddScoped<IServiceVehicle, ServiceVehicle>();
            services.AddScoped<IServiceVehicleEnergy, ServiceVehicleEnergy>();

            services.AddScoped<IServiceSalesPrice, ServiceSalesPrice>();
            services.AddScoped<IServiceTierCategory, ServiceTierCategory>();
            services.AddScoped<IServiceUsersBtob, ServiceUsersBtob>();
        }
        /// <summary>
        /// Register Services by module : Payement
        /// </summary>
        /// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterPayementServices(this IServiceCollection services)
        {
            services.AddScoped<IServicePaymentMethod, ServicePaymentMethod>();
            services.AddScoped<IServicePaymentType, ServicePaymentType>();
            services.AddScoped<IServicePaymentStatus, ServicePaymentStatus>();
            services.AddScoped<IServicePaymentSlip, ServicePaymentSlip>();
            services.AddScoped<IServiceWithholdingTax, ServiceWithholdingTax>();
            services.AddScoped<IServiceSettlementDocumentWithholdingTax, ServiceSettlementDocumentWithholdingTax>();
            services.AddScoped<IServiceCashRegister, ServiceCashRegister>();
            services.AddScoped<IServiceFundsTransfer, ServiceFundsTransfer>();
            services.AddScoped<IServiceSessionCash, ServiceSessionCash>();
        }

        /// <summary>
        /// Register Services by module : Shared
        /// </summary>
        /// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterSharedServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceCompany, ServiceCompany>();
            services.AddScoped<IServiceCity, ServiceCity>();
            services.AddScoped<IServiceUser, ServiceUser>();
            services.AddScoped<IServiceUserReduce, ServiceUserReduce>();
            services.AddScoped<IServiceCountry, ServiceCountry>();
            services.AddScoped<IServiceContact, ServiceContact>();
            services.AddScoped<IServiceZipCode, ServiceZipCode>();
            services.AddScoped<IServiceTaxe, ServiceTaxe>();
            services.AddScoped<IServiceBankAccount, ServiceBankAccount>();
            services.AddScoped<IServiceBankAgency, ServiceBankAgency>();
            services.AddScoped<IServiceEmail, ServiceEmail>();
            services.AddScoped<IServicePeriod, ServicePeriod>();
            services.AddScoped<IServiceHours, ServiceHours>();
            services.AddScoped<IServiceDayOff, ServiceDayOff>();
            services.AddScoped<IServiceUserEmail, ServiceUserEmail>();
            services.AddScoped<IServiceOffice, ServiceOffice>();
            services.AddScoped<IServiceJobsParameters, ServiceJobsParameters>();
            services.AddScoped<IServicePrivilege, ServicePrivilege>();
            services.AddScoped<IServiceUserPrivilege, ServiceUserPrivilege>();
            services.AddScoped<IServiceLanguage, ServiceLanguage>();
            services.AddScoped<IServiceGeneralSettings, ServiceGeneralSettings>();
            services.AddScoped<IServicePhone, ServicePhone>();
            services.AddScoped<IServiceAddress, ServiceAddress>();



            services.AddScoped<IServiceBank, ServiceBank>();

        }

        /// <summary>
        /// Register Services by module : ErpSettings
        /// </summary>
        /// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterErpSettingsServices(this IServiceCollection services)
        {
            //services.AddScoped<ISettingsService, SettingsService>();
            services.AddScoped<IServiceTranslation, ServiceTranslation>();
            services.AddScoped<IServiceEntity, ServiceEntity>();
            services.AddScoped<IServiceCodification, ServiceCodification>();
            services.AddScoped<IServiceInformation, ServiceInformation>();
            services.AddScoped<IServiceUserInfo, ServiceUserInfo>();
            services.AddScoped<IServiceMessage, ServiceMessage>();
            services.AddScoped<IServiceMsgNotification, ServiceMsgNotification>();
            services.AddScoped<IServiceComment, ServiceComment>();
            services.AddScoped<IServiceReportTemplate, ServiceReportTemplate>();

            //chat
            services.AddScoped<IServiceMessageChat, ServiceMessageChat>();
            services.AddScoped<IServiceDiscussionChat, ServiceDiscussionChat>();
            services.AddScoped<IServiceUserDiscussionChat, ServiceUserDiscussionChat>();

        }
        private static void RegisterAdministrationServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceAxis, ServiceAxis>();
            services.AddScoped<IServiceAxisValue, ServiceAxisValue>();
            services.AddScoped<IServiceAxisEntity, ServiceAxisEntity>();
            services.AddScoped<IServiceAxisRelationShip, ServiceAxisRelationShip>();
            services.AddScoped<IServiceCurrency, ServiceCurrency>();
            services.AddScoped<IServiceCurrencyRate, ServiceCurrencyRate>();
            services.AddScoped<IServiceDashboard, ServiceDashboard>();
        }
        private static void RegisterPayRollServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceEmployee, ServiceEmployee>();
            services.AddScoped<IServiceQualificationType, ServiceQualificationType>();
            services.AddScoped<IServiceTeamType, ServiceTeamType>();

            services.AddScoped<IServiceGrade, ServiceGrade>();
            services.AddScoped<IServiceContract, ServiceContract>();
            services.AddScoped<IServiceContractType, ServiceContractType>();

            services.AddScoped<IServiceLeave, ServiceLeave>();
            services.AddScoped<IServiceLeaveType, ServiceLeaveType>();
            services.AddScoped<IServiceLeaveBalanceRemaining, ServiceLeaveBalanceRemaining>();

            services.AddScoped<IServiceJob, ServiceJob>();

            services.AddScoped<IServiceSalaryStructure, ServiceSalaryStructure>();
            services.AddScoped<IServiceSalaryRule, ServiceSalaryRule>();

            services.AddScoped<IServiceDepartment, ServiceDepartment>();
            services.AddScoped<IServiceConstantRate, ServiceConstantRate>();
            services.AddScoped<IServiceConstantRateValidityPeriod, ServiceConstantRateValidityPeriod>();
            services.AddScoped<IServiceConstantValue, ServiceConstantValue>();
            services.AddScoped<IServiceConstantValueValidityPeriod, ServiceConstantValueValidityPeriod>();
            services.AddScoped<IServiceContributionRegister, ServiceContributionRegister>();
            services.AddScoped<IServiceVariable, ServiceVariable>();

            services.AddScoped<IServicePayslip, ServicePayslip>();
            services.AddScoped<IServicePayslipDetails, ServicePayslipDetails>();
            services.AddScoped<IServiceRuleUniqueReference, ServiceRuleUniqueReference>();

            services.AddScoped<ILexicalAnalyzer, LexicalAnalyzer>();
            services.AddScoped<ISyntacticAnalyzer, SyntacticAnalyzer>();
            services.AddScoped<ISemanticAnalyzer, SemanticAnalyzer>();

            services.AddScoped<IServiceCalculator, ServiceCalculator>();
            services.AddScoped<IServiceBooleanExpression, ServiceBooleanExpression>();
            services.AddScoped<IRecuperateValueFromReference, RecuperateValueFromReference>();
            services.AddScoped<IServiceBonus, ServiceBonus>();
            services.AddScoped<IServiceContractBonus, ServiceContractBonus>();
            services.AddScoped<IServiceSessionBonus, ServiceSessionBonus>();

            services.AddScoped<IServiceSession, ServiceSession>();
            services.AddScoped<IServiceAttendance, ServiceAttendance>();

            services.AddScoped<IServiceBaseSalary, ServiceBaseSalary>();
            services.AddScoped<IServiceBonusValidityPeriod, ServiceBonusValidityPeriod>();

            services.AddScoped<IServiceEmployeeDocument, ServiceEmployeeDocument>();
            services.AddScoped<IServiceCnss, ServiceCnss>();

            services.AddScoped<IServiceTeam, ServiceTeam>();
            services.AddScoped<IServiceQualification, ServiceQualification>();

            services.AddScoped<IServiceTransferOrder, ServiceTransferOrder>();
            services.AddScoped<IServiceTransferOrderDetails, ServiceTransferOrderDetails>();
            services.AddScoped<IServiceExpenseReport, ServiceExpenseReport>();
            services.AddScoped<IServiceExpenseReportDetails, ServiceExpenseReportDetails>();
            services.AddScoped<IServiceExpenseReportDetailsType, ServiceExpenseReportDetailsType>();
            services.AddScoped<IServiceDocumentRequest, ServiceDocumentRequest>();
            services.AddScoped<IServiceDocumentRequestType, ServiceDocumentRequestType>();

            services.AddScoped<IServiceCnssDeclaration, ServiceCnssDeclaration>();
            services.AddScoped<IServiceCnssDeclarationDetails, ServiceCnssDeclarationDetails>();

            services.AddScoped<IServiceSkillsFamily, ServiceSkillsFamily>();
            services.AddScoped<IServiceSkills, ServiceSkills>();
            services.AddScoped<IServiceEmployeeSkills, ServiceEmployeeSkills>();
            services.AddScoped<IServiceJobEmployee, ServiceJobEmployee>();
            services.AddScoped<IServiceJobSkills, ServiceJobSkills>();

            services.AddScoped<IServiceLeaveEmail, ServiceLeaveEmail>();
            services.AddScoped<IServiceExpenseReportEmail, ServiceExpenseReportEmail>();
            services.AddScoped<IServiceDocumentRequestEmail, ServiceDocumentRequestEmail>();

            services.AddScoped<IServiceSharedDocument, ServiceSharedDocument>();
            services.AddScoped<IServiceEmployeeReduce, ServiceEmployeeReduce>();
            services.AddScoped<IServiceTeamReduce, ServiceTeamReduce>();
            services.AddScoped<IServiceEmployeeTeam, ServiceEmployeeTeam>();

            services.AddScoped<IServiceNote, ServiceNote>();
            services.AddScoped<IServiceExitReason, ServiceExitReason>();
            services.AddScoped<IServiceExitEmployee, ServiceExitEmployee>();
            services.AddScoped<IServiceBenefitInKind, ServiceBenefitInKind>();
            services.AddScoped<IServiceContractBenefitInKind, ServiceContractBenefitInKind>();
            services.AddScoped<IServiceSalaryRuleValidityPeriod, ServiceSalaryRuleValidityPeriod>();
            services.AddScoped<IServiceVariableValidityPeriod, ServiceVariableValidityPeriod>();

            services.AddScoped<IServiceSourceDeduction, ServiceSourceDeduction>();
            services.AddScoped<IServiceSourceDeductionSession, ServiceSourceDeductionSession>();
            services.AddScoped<IServiceSourceDeductionSessionEmployee, ServiceSourceDeductionSessionEmployee>();
            services.AddScoped<IServiceExitEmailForEmployee, ServiceExitEmailForEmployee>();

            services.AddScoped<IServiceJasperReporting, ServiceJasperReporting>();
            services.AddScoped<IServiceLoan, ServiceLoan>();
            services.AddScoped<IServiceLoanInstallment, ServiceLoanInstallment>();
            services.AddScoped<IServiceSalaryStructureValidityPeriod, ServiceSalaryStructureValidityPeriod>();
            services.AddScoped<IServiceSalaryStructureValidityPeriod, ServiceSalaryStructureValidityPeriod>();
            services.AddScoped<IServiceSalaryStructureValidityPeriodSalaryRule, ServiceSalaryStructureValidityPeriodSalaryRule>();
            services.AddScoped<IServiceExitAction, ServiceExitAction>();
            services.AddScoped<IServiceExitActionEmployee, ServiceActionsExitEmployee>();
            services.AddScoped<IServiceExitEmployeePayLine, ServiceExitEmployeePayLine>();
            services.AddScoped<IServiceExitEmployeePayLineSalaryRule, ServiceExitEmployeePayLineSalaryRule>();
            services.AddScoped<IServiceSessionContract, ServiceSessionContract>();
            services.AddScoped<IServiceExitEmployeeLeaveLine, ServiceExitEmployeeLeaveLine>();
            services.AddScoped<IServiceCnssDeclarationSession, ServiceCnssDeclarationSession>();
            services.AddScoped<IServiceContractAdvantage, ServiceContractAdvantage>();
            services.AddScoped<IServiceSessionLoanInstallment, ServiceSessionLoanInstallment>();
            services.AddScoped<IServiceAdditionalHour, ServiceAdditionalHour>();
            services.AddScoped<IServiceAdditionalHourSlot, ServiceAdditionalHourSlot>();
            services.AddScoped<IServiceTransferOrderSession, ServiceTransferOrderSession>();
        }

        /// <summary>
        /// Service immobilisation 
        /// </summary>
        /// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterImmobilisationServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceActive, ServiceActive>();
            services.AddScoped<IServiceCategory, ServiceCategory>();
            services.AddScoped<IServiceHistory, ServiceHistory>();
        }
        /// <summary>
        /// Register other type of services
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterOtherServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceReporting, ServiceReporting>();
            services.AddScoped<IDailySalesServiceReporting, DailySalesServiceReporting>();
            services.AddScoped<ProxyService>();
            services.AddScoped<ISalesPurchaseServiceReporting, SalesPurchaseServiceReporting>();
            services.AddScoped<IServiceTecDoc, ServiceTecDoc>();
            services.AddScoped<IRhServiceReporting, RhServiceReporting>();
            services.AddScoped<IPayRollServiceReporting, PayRollServiceReporting>();
            services.AddScoped<IServiceJasperReporting, ServiceJasperReporting>();
            services.AddScoped<ITreasuryServiceReporting, TreasuryServiceReporting>();
        }

        /// <summary>
        /// Register RH services
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterRHServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceCandidate, ServiceCandidate>();
            services.AddScoped<IServiceCandidacy, ServiceCandidacy>();
            services.AddScoped<IServiceInterview, ServiceInterview>();
            services.AddScoped<IServiceInterviewEmail, ServiceInterviewEmail>();
            services.AddScoped<IServiceInterviewMark, ServiceInterviewMark>();
            services.AddScoped<IServiceInterviewQuestion, ServiceInterviewQuestion>();
            services.AddScoped<IServiceInterviewQuestionTheme, ServiceInterviewQuestionTheme>();
            services.AddScoped<IServiceInterviewType, ServiceInterviewType>();

            services.AddScoped<IServiceOffer, ServiceOffer>();
            services.AddScoped<IServiceRecruitment, ServiceRecruitment>();
            services.AddScoped<IServiceProject, ServiceProject>();
            services.AddScoped<IServiceTimeSheet, ServiceTimeSheet>();
            services.AddScoped<IServiceTimeSheetCountDays, ServiceTimeSheetCountDays>();
            services.AddScoped<IServiceTimeSheetLine, ServiceTimeSheetLine>();
            services.AddScoped<IServiceAdvantages, ServiceAdvantages>();
            services.AddScoped<IServiceEvaluationCriteriaTheme, ServiceEvaluationCriteriaTheme>();
            services.AddScoped<IServiceEvaluationCriteria, ServiceEvaluationCriteria>();
            services.AddScoped<IServiceCriteriaMark, ServiceCriteriaMark>();
            services.AddScoped<IServiceEmployeeProject, ServiceEmployeeProject>();
            services.AddScoped<IServiceReview, ServiceReview>();
            services.AddScoped<IServiceReviewReporting, ServiceReviewReporting>();
            services.AddScoped<IServiceReviewResume, ServiceReviewResume>();
            services.AddScoped<IServiceReviewFormation, ServiceReviewFormation>();
            services.AddScoped<IServiceFormation, ServiceFormation>();
            services.AddScoped<IServiceReviewSkills, ServiceReviewSkills>();
            services.AddScoped<IServiceObjective, ServiceObjective>();
            services.AddScoped<IServiceQuestion, ServiceQuestion>();
            services.AddScoped<IServiceFormationType, ServiceFormationType>();
            services.AddScoped<IServiceTimeSheetReduce, ServiceTimeSheetReduce>();


            services.AddScoped<IServiceTraining, ServiceTraining>();
            services.AddScoped<IServiceTrainingByEmployee, ServiceTrainingByEmployee>();
            services.AddScoped<IServiceTrainingExpectedSkills, ServiceTrainingExpectedSkills>();
            services.AddScoped<IServiceTrainingRequest, ServiceTrainingRequest>();
            services.AddScoped<IServiceTrainingRequiredSkills, ServiceTrainingRequiredSkills>();
            services.AddScoped<IServiceTrainingSeance, ServiceTrainingSeance>();
            services.AddScoped<IServiceTrainingSession, ServiceTrainingSession>();
            services.AddScoped<IServiceMobilityRequest, ServiceMobilityRequest>();
            services.AddScoped<IServiceProjectReduce, ServiceProjectReduce>();
            services.AddScoped<IServiceTrainingCenter, ServiceTrainingCenter>();
            services.AddScoped<IServiceTrainingCenterManager, ServiceTrainingCenterManager>();
            services.AddScoped<IServiceTrainingCenterRoom, ServiceTrainingCenterRoom>();
            services.AddScoped<IServiceExternalTrainerSkills, ServiceExternalTrainerSkills>();
            services.AddScoped<IServiceExternalTrainer, ServiceExternalTrainer>();
            services.AddScoped<IServiceExternalTraining, ServiceExternalTraining>();
            services.AddScoped<IServiceEmployeeTrainingSession, ServiceEmployeeTrainingSession>();

            services.AddScoped<IServiceTimeSheetJobs, ServiceTimeSheetJobs>();
            services.AddScoped<IServiceRecruitmentLanguage, ServiceRecruitmentLanguage>();
            services.AddScoped<IServiceRecruitmentSkills, ServiceRecruitmentSkills>();
            services.AddScoped<IServiceOfferBenefitInKind, ServiceOfferBenefitInKind>();
            services.AddScoped<IServiceFileDrive, ServiceFileDrive>();
            services.AddScoped<IServiceUserFileAccess, ServiceUserFileAccess>();
            services.AddScoped<IServiceFileDriveSharedDocument, ServiceFileDriveSharedDocument>();
            services.AddScoped<IServiceOfferBonus, ServiceOfferBonus>();

        }

        /// <summary>
        /// Service HelpDesk
        /// </summary>
        /// <param name="services">Specifies the contract for a collection of service descriptors</param>
        private static void RegisterHelpdeskServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceClaim, ServiceClaim>();
            services.AddScoped<IServiceClaimType, ServiceClaimType>();
            services.AddScoped<IServiceClaimStatus, ServiceClaimStatus>();
            services.AddScoped<IServiceClaimInteraction, ServiceClaimInteraction>();
        }

        public static void RegisterMasterServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceMasterUser, ServiceMasterUser>();
            services.AddScoped<IServiceMasterCompany, ServiceMasterCompany>();
            services.AddScoped<IServiceCompanyLicence, ServiceCompanyLicence>();
            services.AddScoped<IServiceMasterUserCompany, ServiceMasterUserCompany>();
            services.AddScoped<IServiceMasterDbSettings, ServiceMasterDbSettings>();
            services.AddScoped<IServiceMasterRoleUser, ServiceMasterRoleUser>();
        }

        private static void RegisterTreasuryServices(this IServiceCollection services)
        {
            services.AddScoped<IServiceDetailReconciliation, ServiceDetailReconciliation>();
            services.AddScoped<IServiceDetailTimetable, ServiceDetailTimetable>();
            services.AddScoped<IServiceReconciliation, ServiceReconciliation>();
            services.AddScoped<IServiceTimetable, ServiceTimetable>();
            services.AddScoped<IServiceTicket, ServiceTicket>();
            services.AddScoped<IServiceTicketPayment, ServiceTicketPayment>();
            services.AddScoped<IServiceOperationCash, ServiceOperationCash>();
        }
    }
}
