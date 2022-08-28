using Microsoft.Extensions.DependencyInjection;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Classes;
using Persistence.Repository.Interfaces;
using ViewModels.DTO.Treasury;

namespace Web.App_Start
{
    public static class IocRepositories
    {
        public static void RegisterRepositories(this IServiceCollection services)
        {
            RegisterMasterRepositories(services);
            RegisterSharedRepositories(services);
            RegisterInventoriesRepositories(services);
            RegisterSalesRepositories(services);
            RegisterPaymentRepositories(services);
            RegisterAccountingRepositories(services);
            RegisterErpSettingsRepositories(services);
            RegisterAdministrationRepositories(services);
            RegisterPayRollRepositories(services);
            RegisterEcommerceRepositories(services);
            RegisteImmobilisationRepositories(services);
            RegisterRHRepositories(services);
            RegisterHelpdeskRepositories(services);
            RegisterTreasuryRepositories(services);
        }

        private static void RegisterEcommerceRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<TriggerItemLog>, Repository<TriggerItemLog>>();
            services.AddScoped<IRepository<JobTable>, Repository<JobTable>>();
            services.AddScoped<IRepository<Delivery>, Repository<Delivery>>();
        }

        private static void RegisterSharedRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<City>, Repository<City>>();
            services.AddScoped<IRepository<Company>, Repository<Company>>();
            services.AddScoped<IRepository<Contact>, Repository<Contact>>();
            services.AddScoped<IRepository<Country>, Repository<Country>>();
            services.AddScoped<IRepository<User>, Repository<User>>();
            services.AddScoped<IRepository<ZipCode>, Repository<ZipCode>>();
            services.AddScoped<IRepository<ContactTypeDocument>, Repository<ContactTypeDocument>>();
            services.AddScoped<IRepository<BankAccount>, Repository<BankAccount>>();
            services.AddScoped<IRepository<BankAgency>, Repository<BankAgency>>();
            services.AddScoped<IRepository<Email>, Repository<Email>>();
            services.AddScoped<IRepository<Period>, Repository<Period>>();
            services.AddScoped<IRepository<Hours>, Repository<Hours>>();
            services.AddScoped<IRepository<DayOff>, Repository<DayOff>>();
            services.AddScoped<IRepository<NewUserEmail>, Repository<NewUserEmail>>();
            services.AddScoped<IRepository<Office>, Repository<Office>>();
            services.AddScoped<IRepository<JobsParameter>, Repository<JobsParameter>>();
            services.AddScoped<IRepository<Privilege>, Repository<Privilege>>();
            services.AddScoped<IRepository<UserPrivilege>, Repository<UserPrivilege>>();
            services.AddScoped<IRepository<Language>, Repository<Language>>();
            services.AddScoped<IRepository<GeneralSettings>, Repository<GeneralSettings>>();
            services.AddScoped<IRepository<Phone>, Repository<Phone>>();
            services.AddScoped<IRepository<Bank>, Repository<Bank>>();
        }

        private static void RegisterAdministrationRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Currency>, Repository<Currency>>();
            services.AddScoped<IRepository<CurrencyRate>, Repository<CurrencyRate>>();
        }

        private static void RegisterInventoriesRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Item>, Repository<Item>>();
            services.AddScoped<IRepository<ItemTiers>, Repository<ItemTiers>>();
            services.AddScoped<IRepository<ItemWarehouse>, Repository<ItemWarehouse>>();
            services.AddScoped<IRepository<MeasureUnit>, Repository<MeasureUnit>>();
            services.AddScoped<IRepository<Taxe>, Repository<Taxe>>();
            services.AddScoped<IRepository<TaxeType>, Repository<TaxeType>>();
            services.AddScoped<IRepository<Warehouse>, Repository<Warehouse>>();
            services.AddScoped<IRepository<StockMovement>, Repository<StockMovement>>();
            services.AddScoped<IRepository<TaxeItem>, Repository<TaxeItem>>();
            services.AddScoped<IRepository<StockDocument>, Repository<StockDocument>>();
            services.AddScoped<IRepository<StockDocumentType>, Repository<StockDocumentType>>();
            services.AddScoped<IRepository<StockDocumentLine>, Repository<StockDocumentLine>>();
            services.AddScoped<IRepository<Nature>, Repository<Nature>>();
            services.AddScoped<IRepository<VehicleBrand>, Repository<VehicleBrand>>();
            services.AddScoped<IRepository<ModelOfItem>, Repository<ModelOfItem>>();
            services.AddScoped<IRepository<SubModel>, Repository<SubModel>>();
            services.AddScoped<IRepository<Family>, Repository<Family>>();
            services.AddScoped<IRepository<Shelf>, Repository<Shelf>>();
            services.AddScoped<IRepository<Storage>, Repository<Storage>>();
            services.AddScoped<IRepository<SubFamily>, Repository<SubFamily>>();
            services.AddScoped<IRepository<ItemKit>, Repository<ItemKit>>();
            services.AddScoped<IRepository<ItemVehicleBrandModelSubModel>, Repository<ItemVehicleBrandModelSubModel>>();
            services.AddScoped<IRepository<ProductItem>, Repository<ProductItem>>();
            services.AddScoped<IRepository<MovementHistory>, Repository<MovementHistory>>();
            services.AddScoped<IRepository<Oem>, Repository<Oem>>();
            services.AddScoped<IRepository<ItemPrices>, Repository<ItemPrices>>();
            services.AddScoped<IRepository<OemItem>, Repository<OemItem>>();
            services.AddScoped<IRepository<ItemSalesPrice>, Repository<ItemSalesPrice>>();
            services.AddScoped<IRepository<UserWarehouse>, Repository<UserWarehouse>>();

        }
        private static void RegisterSalesRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Document>, Repository<Document>>();
            services.AddScoped<IRepository<DocumentLine>, Repository<DocumentLine>>();
            services.AddScoped<IRepository<Prices>, Repository<Prices>>();
            services.AddScoped<IRepository<TypePrices>, Repository<TypePrices>>();
            services.AddScoped<IRepository<Tiers>, Repository<Tiers>>();
            services.AddScoped<IRepository<DocumentType>, Repository<DocumentType>>();
            services.AddScoped<IRepository<DocumentTypeRelation>, Repository<DocumentTypeRelation>>();
            services.AddScoped<IRepository<Tiers>, Repository<Tiers>>();
            services.AddScoped<IRepository<Contact>, Repository<Contact>>();
            services.AddScoped<IRepository<DocumentLineTaxe>, Repository<DocumentLineTaxe>>();
            services.AddScoped<IRepository<DocumentLinePrices>, Repository<DocumentLinePrices>>();
            services.AddScoped<IRepository<TaxeGroupTiers>, Repository<TaxeGroupTiers>>();
            services.AddScoped<IRepository<TaxeGroupTiersConfig>, Repository<TaxeGroupTiersConfig>>();
            services.AddScoped<IRepository<Settlement>, Repository<Settlement>>();
            services.AddScoped<IRepository<SettlementCommitment>, Repository<SettlementCommitment>>();
            services.AddScoped<IRepository<FinancialCommitment>, Repository<FinancialCommitment>>();
            services.AddScoped<IRepository<DetailsSettlementMode>, Repository<DetailsSettlementMode>>();
            services.AddScoped<IRepository<SettlementMode>, Repository<SettlementMode>>();
            services.AddScoped<IRepository<SettlementType>, Repository<SettlementType>>();
            services.AddScoped<IRepository<TypeTiers>, Repository<TypeTiers>>();
            services.AddScoped<IRepository<SaleSettings>, Repository<SaleSettings>>();
            services.AddScoped<IRepository<PurchaseSettings>, Repository<PurchaseSettings>>();
            services.AddScoped<IRepository<PriceRequest>, Repository<PriceRequest>>();
            services.AddScoped<IRepository<PriceRequestDetail>, Repository<PriceRequestDetail>>();
            services.AddScoped<IRepository<Expense>, Repository<Expense>>();
            services.AddScoped<IRepository<DocumentExpenseLine>, Repository<DocumentExpenseLine>>();
            services.AddScoped<IRepository<SalesInvoiceLog>, Repository<SalesInvoiceLog>>();
            services.AddScoped<IRepository<BillingSession>, Repository<BillingSession>>();
            services.AddScoped<IRepository<Provisioning>, Repository<Provisioning>>();
            services.AddScoped<IRepository<ProvisioningDetails>, Repository<ProvisioningDetails>>();
            services.AddScoped<IRepository<ProvisioningOption>, Repository<ProvisioningOption>>();
            services.AddScoped<IRepository<TiersProvisioning>, Repository<TiersProvisioning>>();
            services.AddScoped<IRepository<SearchItem>, Repository<SearchItem>>();
            services.AddScoped<IRepository<DeliveryType>, Repository<DeliveryType>>();
            services.AddScoped<IRepository<ReflectiveSettlement>, Repository<ReflectiveSettlement>>();
            services.AddScoped<IRepository<DocumentLineNegotiationOptions>, Repository<DocumentLineNegotiationOptions>>();
            services.AddScoped<IRepository<BillingEmployee>, Repository<BillingEmployee>>();
            services.AddScoped<IRepository<DocumentWithholdingTax>, Repository<DocumentWithholdingTax>>();
            services.AddScoped<IRepository<Address>, Repository<Address>>();
            services.AddScoped<IRepository<PriceDetail>, Repository<PriceDetail>>();
            services.AddScoped<IRepository<TiersPrices>, Repository<TiersPrices>>();
            services.AddScoped<IRepository<DocumentTaxsResume>, Repository<DocumentTaxsResume>>();
            services.AddScoped<IRepository<Vehicle>, Repository<Vehicle>>();
            services.AddScoped<IRepository<VehicleEnergy>, Repository<VehicleEnergy>>();
            services.AddScoped<IRepository<SalesPrice>, Repository<SalesPrice>>();
            services.AddScoped<IRepository<TierCategory>, Repository<TierCategory>>();
            services.AddScoped<IRepository<UsersBtob>, Repository<UsersBtob>>();
        }
        private static void RegisterPaymentRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<PaymentMethod>, Repository<PaymentMethod>>();
            services.AddScoped<IRepository<PaymentType>, Repository<PaymentType>>();
            services.AddScoped<IRepository<PaymentStatus>, Repository<PaymentStatus>>();
            services.AddScoped<IRepository<PaymentSlip>, Repository<PaymentSlip>>();
            services.AddScoped<IRepository<WithholdingTax>, Repository<WithholdingTax>>();
            services.AddScoped<IRepository<SettlementDocumentWithholdingTax>, Repository<SettlementDocumentWithholdingTax>>();
            services.AddScoped<IRepository<CashRegister>, Repository<CashRegister>>();
            services.AddScoped<IRepository<FundsTransfer>, Repository<FundsTransfer>>();
            services.AddScoped<IRepository<SessionCash>, Repository<SessionCash>>();
        }
        private static void RegisterAccountingRepositories(IServiceCollection services)
        {

        }
        private static void RegisterErpSettingsRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Functionality>, Repository<Functionality>>();
            services.AddScoped<IRepository<RequestType>, Repository<RequestType>>();
            services.AddScoped<IRepository<Notification>, Repository<Notification>>();


            services.AddScoped<IRepository<Axis>, Repository<Axis>>();
            services.AddScoped<IRepository<Entity>, Repository<Entity>>();
            services.AddScoped<IRepository<AxisEntity>, Repository<AxisEntity>>();
            services.AddScoped<IRepository<AxisValue>, Repository<AxisValue>>();
            services.AddScoped<IRepository<AxisRelationShip>, Repository<AxisRelationShip>>();
            services.AddScoped<IRepository<AxisValueRelationShip>, Repository<AxisValueRelationShip>>();
            services.AddScoped<IRepository<EntityAxisValues>, Repository<EntityAxisValues>>();
            services.AddScoped<IRepository<Codification>, Repository<Codification>>();
            services.AddScoped<IRepository<EntityCodification>, Repository<EntityCodification>>();

            services.AddScoped<IRepository<Information>, Repository<Information>>();
            services.AddScoped<IRepository<UserInfo>, Repository<UserInfo>>();
            services.AddScoped<IRepository<Message>, Repository<Message>>();
            services.AddScoped<IRepository<MsgNotification>, Repository<MsgNotification>>();
            services.AddScoped<IRepository<Comment>, Repository<Comment>>();
            services.AddScoped<IRepository<ReportTemplate>, Repository<ReportTemplate>>();

            /* Chat */
            services.AddScoped<IRepository<UserDiscussionChat>, Repository<UserDiscussionChat>>();
            services.AddScoped<IRepository<Discussion>, Repository<Discussion>>();
            services.AddScoped<IRepository<MessageChat>, Repository<MessageChat>>();

        }

        /// <summary>
        /// Inject payroll repositories here
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterPayRollRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Employee>, Repository<Employee>>();
            services.AddScoped<IRepository<QualificationType>, Repository<QualificationType>>();
            services.AddScoped<IRepository<TeamType>, Repository<TeamType>>();

            services.AddScoped<IRepository<Contract>, Repository<Contract>>();
            services.AddScoped<IRepository<ContractType>, Repository<ContractType>>();
            services.AddScoped<IRepository<Leave>, Repository<Leave>>();
            services.AddScoped<IRepository<LeaveType>, Repository<LeaveType>>();
            services.AddScoped<IRepository<LeaveBalanceRemaining>, Repository<LeaveBalanceRemaining>>();

            services.AddScoped<IRepository<Job>, Repository<Job>>();
            services.AddScoped<IRepository<Department>, Repository<Department>>();

            services.AddScoped<IRepository<ConstantRate>, Repository<ConstantRate>>();
            services.AddScoped<IRepository<ConstantRateValidityPeriod>, Repository<ConstantRateValidityPeriod>>();
            services.AddScoped<IRepository<ConstantValue>, Repository<ConstantValue>>();
            services.AddScoped<IRepository<ConstantValueValidityPeriod>, Repository<ConstantValueValidityPeriod>>();

            services.AddScoped<IRepository<ContributionRegister>, Repository<ContributionRegister>>();
            services.AddScoped<IRepository<Variable>, Repository<Variable>>();
            services.AddScoped<IRepository<Payslip>, Repository<Payslip>>();
            services.AddScoped<IRepository<PayslipDetails>, Repository<PayslipDetails>>();
            services.AddScoped<IRepository<SalaryStructure>, Repository<SalaryStructure>>();
            services.AddScoped<IRepository<SalaryRule>, Repository<SalaryRule>>();
            services.AddScoped<IRepository<RuleUniqueReference>, Repository<RuleUniqueReference>>();
            services.AddScoped<IRepository<Grade>, Repository<Grade>>();
            services.AddScoped<IRepository<Bonus>, Repository<Bonus>>();
            services.AddScoped<IRepository<ContractBonus>, Repository<ContractBonus>>();
            services.AddScoped<IRepository<SessionBonus>, Repository<SessionBonus>>();
            services.AddScoped<IRepository<Session>, Repository<Session>>();
            services.AddScoped<IRepository<Attendance>, Repository<Attendance>>();
            services.AddScoped<IRepository<BaseSalary>, Repository<BaseSalary>>();
            services.AddScoped<IRepository<BonusValidityPeriod>, Repository<BonusValidityPeriod>>();
            services.AddScoped<IRepository<Cnss>, Repository<Cnss>>();

            services.AddScoped<IRepository<EmployeeDocument>, Repository<EmployeeDocument>>();


            services.AddScoped<IRepository<Team>, Repository<Team>>();
            services.AddScoped<IRepository<Qualification>, Repository<Qualification>>();

            services.AddScoped<IRepository<TransferOrder>, Repository<TransferOrder>>();
            services.AddScoped<IRepository<TransferOrderDetails>, Repository<TransferOrderDetails>>();

            services.AddScoped<IRepository<ExpenseReport>, Repository<ExpenseReport>>();
            services.AddScoped<IRepository<ExpenseReportDetails>, Repository<ExpenseReportDetails>>();
            services.AddScoped<IRepository<ExpenseReportDetailsType>, Repository<ExpenseReportDetailsType>>();
            services.AddScoped<IRepository<DocumentRequest>, Repository<DocumentRequest>>();
            services.AddScoped<IRepository<DocumentRequestType>, Repository<DocumentRequestType>>();

            services.AddScoped<IRepository<CnssDeclaration>, Repository<CnssDeclaration>>();
            services.AddScoped<IRepository<CnssDeclarationDetails>, Repository<CnssDeclarationDetails>>();

            services.AddScoped<IRepository<SkillsFamily>, Repository<SkillsFamily>>();
            services.AddScoped<IRepository<Skills>, Repository<Skills>>();
            services.AddScoped<IRepository<EmployeeSkills>, Repository<EmployeeSkills>>();
            services.AddScoped<IRepository<JobEmployee>, Repository<JobEmployee>>();
            services.AddScoped<IRepository<JobSkills>, Repository<JobSkills>>();

            services.AddScoped<IRepository<LeaveEmail>, Repository<LeaveEmail>>();
            services.AddScoped<IRepository<ExpenseReportEmail>, Repository<ExpenseReportEmail>>();
            services.AddScoped<IRepository<DocumentRequestEmail>, Repository<DocumentRequestEmail>>();

            services.AddScoped<IRepository<SharedDocument>, Repository<SharedDocument>>();
            services.AddScoped<IRepository<Note>, Repository<Note>>();
            services.AddScoped<IRepository<ExitReason>, Repository<ExitReason>>();
            services.AddScoped<IRepository<ExitEmployee>, Repository<ExitEmployee>>();
            services.AddScoped<IRepository<EmployeeTeam>, Repository<EmployeeTeam>>();
            services.AddScoped<IRepository<BenefitInKind>, Repository<BenefitInKind>>();
            services.AddScoped<IRepository<ContractBenefitInKind>, Repository<ContractBenefitInKind>>();
            services.AddScoped<IRepository<SalaryRuleValidityPeriod>, Repository<SalaryRuleValidityPeriod>>();
            services.AddScoped<IRepository<VariableValidityPeriod>, Repository<VariableValidityPeriod>>();

            services.AddScoped<IRepository<SourceDeduction>, Repository<SourceDeduction>>();
            services.AddScoped<IRepository<SourceDeductionSession>, Repository<SourceDeductionSession>>();
            services.AddScoped<IRepository<SourceDeductionSessionEmployee>, Repository<SourceDeductionSessionEmployee>>();
            services.AddScoped<IRepository<ExitEmailForEmployee>, Repository<ExitEmailForEmployee>>();
            services.AddScoped<IRepository<Loan>, Repository<Loan>>();
            services.AddScoped<IRepository<LoanInstallment>, Repository<LoanInstallment>>();
            services.AddScoped<IRepository<SalaryStructureValidityPeriod>, Repository<SalaryStructureValidityPeriod>>();
            services.AddScoped<IRepository<SalaryStructureValidityPeriodSalaryRule>, Repository<SalaryStructureValidityPeriodSalaryRule>>();
            services.AddScoped<IRepository<ExitAction>, Repository<ExitAction>>();
            services.AddScoped<IRepository<ExitActionEmployee>, Repository<ExitActionEmployee>>();
            services.AddScoped<IRepository<ExitEmployeePayLine>, Repository<ExitEmployeePayLine>>();
            services.AddScoped<IRepository<ExitEmployeePayLineSalaryRule>, Repository<ExitEmployeePayLineSalaryRule>>();
            services.AddScoped<IRepository<SessionContract>, Repository<SessionContract>>();
            services.AddScoped<IRepository<ExitEmployeeLeaveLine>, Repository<ExitEmployeeLeaveLine>>();
            services.AddScoped<IRepository<CnssDeclarationSession>, Repository<CnssDeclarationSession>>();
            services.AddScoped<IRepository<ContractAdvantage>, Repository<ContractAdvantage>>();
            services.AddScoped<IRepository<SessionLoanInstallment>, Repository<SessionLoanInstallment>>();
            services.AddScoped<IRepository<AdditionalHour>, Repository<AdditionalHour>>();
            services.AddScoped<IRepository<AdditionalHourSlot>, Repository<AdditionalHourSlot>>();
            services.AddScoped<IRepository<TransferOrderSession>, Repository<TransferOrderSession>>();

        }

        /// <summary>
        /// Inject Immobilisation repositories here
        /// </summary>
        /// <param name="services"></param>
        private static void RegisteImmobilisationRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Active>, Repository<Active>>();
            services.AddScoped<IRepository<Category>, Repository<Category>>();
            services.AddScoped<IRepository<History>, Repository<History>>();
        }
        /// <summary>
        /// Inject RH repositories here
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterRHRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Candidate>, Repository<Candidate>>();
            services.AddScoped<IRepository<Candidacy>, Repository<Candidacy>>();
            services.AddScoped<IRepository<Interview>, Repository<Interview>>();
            services.AddScoped<IRepository<InterviewEmail>, Repository<InterviewEmail>>();
            services.AddScoped<IRepository<InterviewMark>, Repository<InterviewMark>>();
            services.AddScoped<IRepository<InterviewQuestion>, Repository<InterviewQuestion>>();
            services.AddScoped<IRepository<InterviewQuestionTheme>, Repository<InterviewQuestionTheme>>();
            services.AddScoped<IRepository<InterviewType>, Repository<InterviewType>>();
            services.AddScoped<IRepository<Offer>, Repository<Offer>>();
            services.AddScoped<IRepository<Recruitment>, Repository<Recruitment>>();
            services.AddScoped<IRepository<Project>, Repository<Project>>();
            services.AddScoped<IRepository<TimeSheet>, Repository<TimeSheet>>();
            services.AddScoped<IRepository<TimeSheetLine>, Repository<TimeSheetLine>>();
            services.AddScoped<IRepository<Advantages>, Repository<Advantages>>();
            services.AddScoped<IRepository<EvaluationCriteria>, Repository<EvaluationCriteria>>();
            services.AddScoped<IRepository<EvaluationCriteriaTheme>, Repository<EvaluationCriteriaTheme>>();
            services.AddScoped<IRepository<CriteriaMark>, Repository<CriteriaMark>>();
            services.AddScoped<IRepository<EmployeeProject>, Repository<EmployeeProject>>();
            services.AddScoped<IRepository<Review>, Repository<Review>>();
            services.AddScoped<IRepository<ReviewResume>, Repository<ReviewResume>>();
            services.AddScoped<IRepository<ReviewFormation>, Repository<ReviewFormation>>();
            services.AddScoped<IRepository<Formation>, Repository<Formation>>();
            services.AddScoped<IRepository<ReviewSkills>, Repository<ReviewSkills>>();
            services.AddScoped<IRepository<Objective>, Repository<Objective>>();
            services.AddScoped<IRepository<Question>, Repository<Question>>();
            services.AddScoped<IRepository<FormationType>, Repository<FormationType>>();

            services.AddScoped<IRepository<Training>, Repository<Training>>();
            services.AddScoped<IRepository<TrainingByEmployee>, Repository<TrainingByEmployee>>();
            services.AddScoped<IRepository<TrainingSession>, Repository<TrainingSession>>();
            services.AddScoped<IRepository<TrainingSeance>, Repository<TrainingSeance>>();
            services.AddScoped<IRepository<TrainingRequest>, Repository<TrainingRequest>>();
            services.AddScoped<IRepository<TrainingExpectedSkills>, Repository<TrainingExpectedSkills>>();
            services.AddScoped<IRepository<TrainingRequiredSkills>, Repository<TrainingRequiredSkills>>();
            services.AddScoped<IRepository<MobilityRequest>, Repository<MobilityRequest>>();
            services.AddScoped<IRepository<TrainingCenter>, Repository<TrainingCenter>>();
            services.AddScoped<IRepository<TrainingCenterManager>, Repository<TrainingCenterManager>>();
            services.AddScoped<IRepository<TrainingCenterRoom>, Repository<TrainingCenterRoom>>();
            services.AddScoped<IRepository<ExternalTrainerSkills>, Repository<ExternalTrainerSkills>>();
            services.AddScoped<IRepository<ExternalTrainer>, Repository<ExternalTrainer>>();
            services.AddScoped<IRepository<ExternalTraining>, Repository<ExternalTraining>>();
            services.AddScoped<IRepository<EmployeeTrainingSession>, Repository<EmployeeTrainingSession>>();
            services.AddScoped<IRepository<RecruitmentLanguage>, Repository<RecruitmentLanguage>>();
            services.AddScoped<IRepository<RecruitmentSkills>, Repository<RecruitmentSkills>>();
            services.AddScoped<IRepository<OfferBenefitInKind>, Repository<OfferBenefitInKind>>();
            services.AddScoped<IRepository<FileDrive>, Repository<FileDrive>>();
            services.AddScoped<IRepository<UserFileAccess>, Repository<UserFileAccess>>();
            services.AddScoped<IRepository<UserFileModification>, Repository<UserFileModification>>();
            services.AddScoped<IRepository<FileDriveSharedDocument>, Repository<FileDriveSharedDocument>>();
            services.AddScoped<IRepository<OfferBonus>, Repository<OfferBonus>>();



        }

        private static void RegisterHelpdeskRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<Claim>, Repository<Claim>>();
            services.AddScoped<IRepository<ClaimStatus>, Repository<ClaimStatus>>();
            services.AddScoped<IRepository<ClaimType>, Repository<ClaimType>>();
            services.AddScoped<IRepository<ClaimInteraction>, Repository<ClaimInteraction>>();
        }

        public static void RegisterMasterRepositories(this IServiceCollection services)
        {
            services.AddScoped<IMasterRepository<CompanyLicence>, MasterRepository<CompanyLicence>>();
            services.AddScoped<IMasterRepository<MasterUser>, MasterRepository<MasterUser>>();
            services.AddScoped<IMasterRepository<MasterCompany>, MasterRepository<MasterCompany>>();
            services.AddScoped<IMasterRepository<MasterUserCompany>, MasterRepository<MasterUserCompany>>();
            services.AddScoped<IMasterRepository<MasterDbSettings>, MasterRepository<MasterDbSettings>>();
            services.AddScoped<IMasterRepository<MasterRoleUser>, MasterRepository<MasterRoleUser>>();
        }

        private static void RegisterTreasuryRepositories(IServiceCollection services)
        {
            services.AddScoped<IRepository<DetailReconciliation>, Repository<DetailReconciliation>>();
            services.AddScoped<IRepository<DetailTimetable>, Repository<DetailTimetable>>();
            services.AddScoped<IRepository<Reconciliation>, Repository<Reconciliation>>();
            services.AddScoped<IRepository<Timetable>, Repository<Timetable>>();
            services.AddScoped<IRepository<Ticket>, Repository<Ticket>>();
            services.AddScoped<IRepository<TicketPayment>, Repository<TicketPayment>>();
            services.AddScoped<IRepository<OperationCash>, Repository<OperationCash>>();
        }
    }
}
