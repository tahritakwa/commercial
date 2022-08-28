 using Microsoft.Extensions.DependencyInjection;
using ViewModels.Builders.Catalog.Classes;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Ecommerce.Classes;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Classes;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Immobilisation.Classes;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.Builders.Specific.Inventory.Classes;
using ViewModels.Builders.Specific.Inventory.Classes.TecDoc;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Payment.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Reporting.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.Builders.Specific.RH.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Sales.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Builders.Specific.Treasury.Classes;
using ViewModels.Builders.Specific.Treasury.Interfaces;

/// <summary>
/// The Web namespace.
/// </summary>
namespace Web.App_Start
{
    /// <summary>
    /// Class IocBuilders.
    /// </summary>
    public static class IocBuilders
    {
        /// <summary>
        /// Registerses the specified services.
        /// </summary>
        /// <param name="services">The services.</param>
        public static void RegisterBuilders(this IServiceCollection services)
        {
            RegisterMasterBuilders(services);
            RegisterSharedBuilders(services);
            RegisterPayRollBuilders(services);
            RegisterInventoryBuilders(services);
            RegisterAdministrationBuilders(services);
            RegisterSalesBuilders(services);
            RegisterPaymentBuilders(services);
            RegisterAccountingBuilders(services);
            RegisterErpSettingsBuilders(services);
            RegisterImmobilisation(services);
            RegisterRHBuilders(services);
            RegisterReportingBuilders(services);
            RegisterHelpdeskBuilders(services);
            RegisterEcommerceBuilders(services);
            RegisterTreasuryBuilders(services);
        }
        private static void RegisterEcommerceBuilders(IServiceCollection services)
        {
            services.AddSingleton<ITriggerItemLogBuilder, TriggerItemLogBuilder>();
            services.AddSingleton<IJobTableBuilder, JobTableBuilder>();
            services.AddSingleton<IDeliveryBuilder, DeliveryBuilder>();
        }


        private static void RegisterAdministrationBuilders(IServiceCollection services)
        {
            services.AddSingleton<ICurrencyBuilder, CurrencyBuilder>();
            services.AddSingleton<IReducedCurrencyBuilder, ReducedCurrencyBuilder>();
            services.AddSingleton<ICurrencyRateBuilder, CurrencyRateBuilder>();
            services.AddSingleton<IAxisBuilder, AxisBuilder>();
            services.AddSingleton<IAxisValueBuilder, AxisValueBuilder>();
            services.AddSingleton<IAxisEntityBuilder, AxisEntityBuilder>();
            services.AddSingleton<IEntityAxisValuesBuilder, EntityAxisValuesBuilder>();
            services.AddSingleton<IAxisRelationShipBuilder, AxisRelationShipBuilder>();
        }
        private static void RegisterSharedBuilders(IServiceCollection services)
        {
            services.AddSingleton<ICompanyBuilder, CompanyBuilder>();
            services.AddSingleton<ICityBuilder, CityBuilder>();
            services.AddSingleton<IReducedCityBuilder, ReducedCityBuilder>();
            services.AddSingleton<IUserBuilder, UserBuilder>();
            services.AddSingleton<ICountryBuilder, CountryBuilder>();
            services.AddSingleton<IReducedCountryBuilder, ReducedCountryBuilder>();
            services.AddSingleton<IContactBuilder, ContactBuilder>();
            services.AddSingleton<IZipCodeBuilder, ZipCodeBuilder>();
            services.AddSingleton<IContactTypeDocumentBuilder, ContactTypeDocumentBuilder>();
            services.AddSingleton<IBankAccountBuilder, BankAccountBuilder>();
            services.AddSingleton<IBankAgencyBuilder, BankAgencyBuilder>();
            services.AddSingleton<IEmailBuilder, EmailBuilder>();
            services.AddSingleton<IPeriodBuilder, PeriodBuilder>();
            services.AddSingleton<IHoursBuilder, HoursBuilder>();
            services.AddSingleton<IDayOffBuilder, DayOffBuilder>();
            services.AddSingleton<INewUserEmailBuilder, NewUserEmailBuilder>();
            services.AddSingleton<IOfficeBuilder, OfficeBuilder>();
            services.AddSingleton<IReducedOfficeBuilder, ReducedOfficeBuilder>();
            services.AddSingleton<IJobsParametersBuilder, JobsParametersBuilder>();
            services.AddSingleton<ILanguageBuilder, LanguageBuilder>();
            services.AddSingleton<IPhoneBuilder, PhoneBuilder>();

            services.AddSingleton<IPrivilegeBuilder, PrivilegeBuilder>();
            services.AddSingleton<IUserPrivilegeBuilder, UserPrivilegeBuilder>();
            services.AddSingleton<IGeneralSettingsBuilder, GeneralSettingsBuilder>();
            services.AddSingleton<IBankBuilder, BankBuilder>();
            services.AddSingleton<IAddressBuilder, AdressBuilder>();
            services.AddSingleton<IReducedBankBuilder, ReducedBankBuilder>();
            services.AddSingleton<IReducedBankAccountBuilder, ReducedBankAccountBuilder>();
            services.AddSingleton<IReducedBankAccountDataBuilder, ReducedBankAccountDataBuilder>();
        }
        private static void RegisterInventoryBuilders(IServiceCollection services)
        {
            //injection du inventory
            services.AddSingleton<IItemBuilder, ItemBuilder>();
            services.AddSingleton<IReducedItemBuilder, ReducedItemBuilder>();
            services.AddSingleton<IItemWarehouseBuilder, ItemWarehouseBuilder>();
            services.AddSingleton<IReducedItemWarehouseBuilder, ReducedItemWarehouseBuilder>();
            services.AddSingleton<IWarehouseBuilder, WarehouseBuilder>();
            services.AddSingleton<IReducedWarehouseBuilder, ReducedWarehouseBuilder>();
            services.AddSingleton<ITaxeItemBuilder, TaxeItemBuilder>();
            services.AddSingleton<ITaxeBuilder, TaxeBuilder>();
            services.AddSingleton<IReducedTaxeBuilder, ReducedTaxeBuilder>();
            services.AddSingleton<ITaxeTypeBuilder, TaxeTypeBuilder>();
            services.AddSingleton<IMeasureUnitBuilder, MeasureUnitBuilder>();
            services.AddSingleton<IReducedMeasureUnitBuilder, ReducedMeasureUnitBuilder>();
            services.AddSingleton<IStockMovementBuilder, StockMovementBuilder>();
            services.AddSingleton<IStockDocumentBuilder, StockDocumentBuilder>();
            services.AddSingleton<IStockDocumentLineBuilder, StockDocumentLineBuilder>();
            services.AddSingleton<IStockDocumentTypeBuilder, StockDocumentTypeBuilder>();
            services.AddSingleton<IReducedNatureBuilder, ReducedNatureBuilder>();
            services.AddSingleton<INatureBuilder, NatureBuilder>();
            services.AddSingleton<IShelfBuilder, ShelfBuilder>();
            services.AddSingleton<IItemTiersBuilder, ItemTiersBuilder>();
            services.AddSingleton<IStorageBuilder, StorageBuilder>();
            services.AddSingleton<IVehicleBrandBuilder, VehicleBrandBuilder>();
            services.AddSingleton<IItemVehicleBrandModelSubModelBuilder, ItemVehicleBrandModelSubModelBuilder>();
            services.AddSingleton<IModelOfItemBuilder, ModelOfItemBuilder>();
            services.AddSingleton<IReducedModelOfItemBuilder, ReducedModelOfItemBuilder>();
            services.AddSingleton<ISubModelBuilder, SubModelBuilder>();
            services.AddSingleton<IReducedSubModelBuilder, ReducedSubModelBuilder>();
            services.AddSingleton<IFamilyBuilder, FamilyBuilder>();
            services.AddSingleton<IReducedFamilyBuilder, ReducedFamilyBuilder>();
            services.AddSingleton<ISubFamilyBuilder, SubFamilyBuilder>();
            services.AddSingleton<IReducedSubFamilyBuilder, ReducedSubFamilyBuilder>();
            services.AddSingleton<IItemKitBuilder, ItemKitBuilder>();
            services.AddSingleton<IProductItemBuilder, ProductItemBuilder>();
            services.AddSingleton<IReducedItemViewModelBuilder, ReducedItemViewModelBuilder>();
            services.AddSingleton<IMovementHistoryBuilder, MovementHistoryBuilder>();
            services.AddSingleton<IOemBuilder, OemBuilder>();
            services.AddSingleton<IItemPricesBuilder, ItemPricesBuilder>();
            services.AddSingleton<IOemItemBuilder, OemItemBuilder>();
            services.AddSingleton<IItemSalesPriceBuilder, ItemSalesPriceBuilder>();
            services.AddSingleton<IUserWarehouseBuilder, UserWarehouseBuilder>();
        }

        /// <summary>
        /// Registers the sales builders.
        /// To inject any builder we should add a singleton instance from the interface and class builder
        /// </summary>
        /// <param name="services">The services.</param>
        private static void RegisterSalesBuilders(IServiceCollection services)
        {
            //injection du inventory
            services.AddSingleton<IDocumentBuilder, DocumentBuilder>();
            services.AddSingleton<IDocumentLineBuilder, DocumentLineBuilder>();
            services.AddSingleton<IDocumentLinePricesBuilder, DocumentLinePricesBuilder>();
            services.AddSingleton<IPurchaseOrderBuilder, PusrchaseOrderBuilder>();
            services.AddSingleton<ITypeDocumentBuilder, TypeDocumentBuilder>();
            services.AddSingleton<IDocumentTypeRelationBuilder, DocumentTypeRelationBuilder>();
            services.AddSingleton<ITiersBuilder, TiersBuilder>();
            services.AddSingleton<IReducedTiersBuilder, ReducedTiersBuilder>();
            services.AddSingleton<ITypePricesBuilder, TypePricesBuilder>();
            services.AddSingleton<IPricesBuilder, PricesBuilder>();
            services.AddSingleton<ITaxeGroupTiersBuilder, TaxeGroupTiersBuilder>();
            services.AddSingleton<ITaxeGroupTiersConfigBuilder, TaxeGroupTiersConfigBuilder>();
            services.AddSingleton<ISettlementBuilder, SettlementBuilder>();
            services.AddSingleton<IReducedSettlementBuilder, ReducedSettlementBuilder>();
            services.AddSingleton<IFinancialCommitmentBuilder, FinancialCommitmentBuilder>();
            services.AddSingleton<ISettlementCommitmentBuilder, SettlementCommitmentBuilder>();
            services.AddSingleton<IDetailsSettlementModeBuilder, DetailsSettlementModeBuilder>();
            services.AddSingleton<ISettlementModeBuilder, SettlementModeBuilder>();
            services.AddSingleton<ISettlementTypeBuilder, SettlementTypeBuilder>();
            services.AddSingleton<ISaleSettingsBuilder, SaleSettingsBuilder>();
            services.AddSingleton<IPurchaseSettingsBuilder, PurchaseSettingsBuilder>();
            services.AddSingleton<IDocumentLineTaxeBuilder, DocumentLineTaxeBuilder>();
            services.AddSingleton<IPriceRequestBuilder, PriceRequestBuilder>();
            services.AddSingleton<IPriceRequestDetailBuilder, PriceRequestDetailBuilder>();
            services.AddSingleton<IExpenseBuilder, ExpenseBuilder>();
            services.AddSingleton<IDocumentExpenseLineBuilder, DocumentExpenseLineBuilder>();
            services.AddSingleton<ISalesInvoiceLogBuilder, SalesInvoiceLogBuilder>();
            services.AddSingleton<IBillingSessionBuilder, BillingSessionBuilder>();
            services.AddSingleton<IProvisioningBuilder, ProvisioningBuilder>();
            services.AddSingleton<IProvisioningDetailsBuilder, ProvisioningDetailsBuilder>();
            services.AddSingleton<IProvisioningOptionBuilder, ProvisioningOptionBuilder>();
            services.AddSingleton<ITiersProvisioningBuilder, TiersProvisioningBuilder>();
            services.AddSingleton<IReducedDocumentBuilder, ReducedDocumentBuilder>();
            services.AddSingleton<IReducedDocumentLineBuilder, ReducedDocumentLineBuilder>();
            services.AddSingleton<ISearchItemBuilder, SearchItemBuilder>();
            services.AddSingleton<IBillingEmployeeBuilder, BillingEmployeeBuilder>();
            services.AddSingleton<IDeliveryTypeBuilder, DeliveryTypeBuilder>();
            services.AddSingleton<IReflectiveSettlementBuilder, ReflectiveSettlementBuilder>();
            services.AddSingleton<IDocumentLineNegotiationOptionsBuilder, DocumentLineNegotiationOptionsBuilder>();
            services.AddSingleton<IDocumentWithholdingTaxBuilder, DocumentWithholdingTaxBuilder>();
            services.AddSingleton<IPriceDetailBuilder, PriceDetailBuilder>();
            services.AddSingleton<ITiersPricesBuilder, TiersPricesBuilder>();
            services.AddSingleton<IDocumentTaxsResumeBuilder, DocumentTaxsResumeBuilder>();
            services.AddSingleton<IVehicleBuilder, VehicleBuilder>();
            services.AddSingleton<IVehicleEnergyBuilder, VehicleEnergyBuilder>();
            services.AddSingleton<ISalesPriceBuilder, SalesPriceBuilder>();
            services.AddSingleton<ITierCategoryBuilder, TierCategoryBuilder>();
            services.AddSingleton<IUsersBtobBuilder, UsersBtobBuilder>();
        }
        /// <summary>
        /// Registers the payment builders.
        /// To inject any builder we should add a singleton instance from the interface and class builder
        /// </summary>
        /// <param name="services">The services.</param>
        private static void RegisterPaymentBuilders(IServiceCollection services)
        {
            services.AddSingleton<IPaymentMethodBuilder, PaymentMethodBuilder>();
            services.AddSingleton<IPaymentTypeBuilder, PaymentTypeBuilder>();
            services.AddSingleton<IPaymentStatusBuilder, PaymentStatusBuilder>();
            services.AddSingleton<IPaymentSlipBuilder, PaymentSlipBuilder>();
            services.AddSingleton<IReducedPaymentSlipBuilder, ReducedPaymentSlipBuilder>();
            services.AddSingleton<IWithholdingTaxBuilder, WithholdingTaxBuilder>();
            services.AddSingleton<ISettlementDocumentWithholdingTaxBuilder, SettlementDocumentWithholdingTaxBuilder>();
            services.AddSingleton<ICashRegisterBuilder, CashRegisterBuilder>();
            services.AddSingleton<IFundsTransferBuilder, FundsTransferBuilder>();
            services.AddSingleton<ISessionCashBuilder, SessionCashBuilder>();

        }

        /// <summary>
        /// Registers the accounting builders.
        /// To inject any builder we should add a singleton instance from the interface and class builder
        /// </summary>
        /// <param name="services">The services.</param>
        private static void RegisterAccountingBuilders(IServiceCollection services)
        {

        }
        private static void RegisterErpSettingsBuilders(IServiceCollection services)
        {
            //injection du inventory
            services.AddSingleton<ICredentialsBuilder, CredentialsBuilder>();
            services.AddSingleton<IFunctionalityBuilder, FunctionalityBuilder>();

            services.AddSingleton<IRequestTypeBuilder, RequestTypeBuilder>();
            services.AddSingleton<INotificationBuilder, NotificationBuilder>();
            services.AddSingleton<ICredentialsBuilder, CredentialsBuilder>();

            services.AddSingleton<IFunctionalityBuilder, FunctionalityBuilder>();

            services.AddSingleton<IEntityBuilder, EntityBuilder>();
            services.AddSingleton<IEntityCodificationBuilder, EntityCodificationBuilder>();
            services.AddSingleton<ICodificationBuilder, CodificationBuilder>();
            services.AddSingleton<IInformationBuilder, InformationBuilder>();
            services.AddSingleton<IUserInfoBuilder, UserInfoBuilder>();
            services.AddSingleton<IMessageBuilder, MessageBuilder>();
            services.AddSingleton<IMsgNotificationBuilder, MsgNotificationBuilder>();
            services.AddSingleton<IFunctionalityBuilder, FunctionalityBuilder>();
            services.AddSingleton<ICommentBuilder, CommentBuilder>();
            services.AddSingleton<IReportTemplateBuilder, ReportTemplateBuilder>();
            // Chat
            services.AddSingleton<IMessageChatBuilder, MessageChatBuilder>();
            services.AddSingleton<IDiscussionChatBuilder, DiscussionChatBuilder>();
            services.AddSingleton<IUserDiscussionChatBuilder, UserDiscussionChatBuilder>();
        }

        /// <summary>
        /// Registers the payroll builders
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterPayRollBuilders(IServiceCollection services)
        {
            services.AddSingleton<IEmployeeBuilder, EmployeeBuilder>();
            services.AddSingleton<IReducedEmployeeBuilder, ReducedEmployeeBuilder>();
            services.AddSingleton<IQualificationTypeBuilder, QualificationTypeBuilder>();
            services.AddSingleton<ITeamTypeBuilder, TeamTypeBuilder>();

            services.AddSingleton<IJobBuilder, JobBuilder>();
            services.AddSingleton<IReducedJobBuilder, ReducedJobBuilder>();
            services.AddSingleton<IDepartmentBuilder, DepartmentBuilder>();

            services.AddSingleton<IContractBuilder, ContractBuilder>();
            services.AddSingleton<IContractTypeBuilder, ContractTypeBuilder>();

            services.AddSingleton<ILeaveBuilder, LeaveBuilder>();
            services.AddSingleton<ILeaveTypeBuilder, LeaveTypeBuilder>();
            services.AddSingleton<IReducedLeaveTypeBuilder, ReducedLeaveTypeBuilder>();
            services.AddSingleton<ILeaveRequestBuilder, LeaveRequestBuilder>();
            services.AddSingleton<ILeaveBalanceRemainingBuilder, LeaveBalanceRemainingBuilder>();

            services.AddSingleton<IVariableBuilder, VariableBuilder>();
            services.AddSingleton<IConstantRateBuilder, ConstantRateBuilder>();
            services.AddSingleton<IConstantValueBuilder, ConstantValueBuilder>();
            services.AddSingleton<IConstantRateValidityPeriodBuilder, ConstantRateValidityPeriodBuilder>();
            services.AddSingleton<IConstantValueValidityPeriodBuilder, ConstantValueValidityPeriodBuilder>();

            services.AddSingleton<ISalaryStructureBuilder, SalaryStructureBuilder>();
            services.AddSingleton<ISalaryRuleBuilder, SalaryRuleBuilder>();
            services.AddSingleton<IGradeBuilder, GradeBuilder>();
            services.AddSingleton<IReducedGradeBuilder, ReducedGradeBuilder>();
            services.AddSingleton<IContributionRegisterBuilder, ContributionRegisterBuilder>();

            services.AddSingleton<IPayslipBuilder, PayslipBuilder>();
            services.AddSingleton<IPayslipDetailsBuilder, PayslipDetailsBuilder>();
            services.AddSingleton<IRuleUniqueReferenceBuilder, RuleUniqueReferenceBuilder>();
            services.AddSingleton<IBonusBuilder, BonusBuilder>();
            services.AddSingleton<IReducedBonusBuilder, ReducedBonusBuilder>();
            services.AddSingleton<IContractBonusBuilder, ContractBonusBuilder>();
            services.AddSingleton<ISessionBonusBuilder, SessionBonusBuilder>();

            services.AddSingleton<ISessionBuilder, SessionBuilder>();
            services.AddSingleton<IAttendanceBuilder, AttendanceBuilder>();

            services.AddSingleton<IBaseSalaryBuilder, BaseSalaryBuilder>();
            services.AddSingleton<IBonusValidityPeriodBuilder, BonusValidityPeriodBuilder>();

            services.AddSingleton<IEmployeeDocumentBuilder, EmployeeDocumentBuilder>();
            services.AddSingleton<ICnssBuilder, CnssBuilder>();
            services.AddSingleton<IReducedCnssBuilder, ReducedCnssBuilder>();


            services.AddSingleton<ITeamBuilder, TeamBuilder>();
            services.AddSingleton<IQualificationBuilder, QualificationBuilder>();

            services.AddSingleton<ITransferOrderBuilder, TransferOrderBuilder>();
            services.AddSingleton<ITransferOrderDetailsBuilder, TransferOrderDetailsBuilder>();
            services.AddSingleton<IDocumentRequestBuilder, DocumentRequestBuilder>();
            services.AddSingleton<IDocumentRequestTypeBuilder, DocumentRequestTypeBuilder>();

            services.AddSingleton<IExpenseReportBuilder, ExpenseReportBuilder>();
            services.AddSingleton<IExpenseReportDetailsBuilder, ExpenseReportDetailsBuilder>();
            services.AddSingleton<IExpenseReportDetailsTypeBuilder, ExpenseReportDetailsTypeBuilder>();



            services.AddSingleton<ICnssDeclarationBuilder, CnssDeclarationBuilder>();
            services.AddSingleton<ICnssDeclarationDetailsBuilder, CnssDeclarationDetailsBuilder>();

            services.AddSingleton<ISkillsFamilyBuilder, SkillsFamilyBuilder>();
            services.AddSingleton<ISkillsBuilder, SkillsBuilder>();
            services.AddSingleton<IReducedSkillsBuilder, ReducedSkillsBuilder>();
            services.AddSingleton<IEmployeeSkillsBuilder, EmployeeSkillsBuilder>();
            services.AddSingleton<IJobEmployeeBuilder, JobEmployeeBuilder>();
            services.AddSingleton<IJobSkillsBuilder, JobSkillsBuilder>();

            services.AddSingleton<ILeaveEmailBuilder, LeaveEmailBuilder>();
            services.AddSingleton<IExpenseReportEmailBuilder, ExpenseReportEmailBuilder>();
            services.AddSingleton<IDocumentRequestEmailBuilder, DocumentRequestEmailBuilder>();

            services.AddSingleton<ISharedDocumentBuilder, SharedDocumentBuilder>();
            services.AddSingleton<INoteBuilder, NoteBuilder>();
            services.AddSingleton<IExitEmployeeBuilder, ExitEmployeeBuilder>();
            services.AddSingleton<IExitReasonBuilder, ExitReasonBuilder>();

            services.AddSingleton<IEmployeeTeamBuilder, EmployeeTeamBuilder>();
            services.AddSingleton<IBenefitInKindBuilder, BenefitInKindBuilder>();
            services.AddSingleton<IContractBenefitInKindBuilder, ContractBenefitInKindBuilder>();
            services.AddSingleton<ISalaryRuleValidityPeriodBuilder, SalaryRuleValidityPeriodBuilder>();
            services.AddSingleton<IVariableValidityPeriodBuilder, VariableValidityPeriodBuilder>();

            services.AddSingleton<ISourceDeductionBuilder, SourceDeductionBuilder>();
            services.AddSingleton<ISourceDeductionSessionBuilder, SourceDeductionSessionBuilder>();
            services.AddSingleton<ISourceDeductionSessionEmployeeBuilder, SourceDeductionSessionEmployeeBuilder>();
            services.AddSingleton<IExitEmailForEmployeeBuilder, ExitEmailForEmployeeBuilder>();
            services.AddSingleton<ILoanBuilder, LoanBuilder>();
            services.AddSingleton<ILoanInstallmentBuilder, LoanInstallmentBuilder>();
            services.AddSingleton<ISalaryStructureValidityPeriodBuilder, SalaryStructureValidityPeriodBuilder>();
            services.AddSingleton<ISalaryStructureValidityPeriodSalaryRuleBuilder, SalaryStructureValidityPeriodSalaryRuleBuilder>();
            services.AddSingleton<IExitActionBuilder, ExitActionBuilder>();
            services.AddSingleton<IExitActionEmployeeBuilder, ExitActionEmployeeBuilder>();
            services.AddSingleton<IExitEmployeePayLineBuilder, ExitEmployeePayLineBuilder>();
            services.AddSingleton<IExitEmployeePayLineSalaryRuleBuilder, ExitEmployeePayLineSalaryRuleBuilder>();
            services.AddSingleton<ISessionContractBuilder, SessionContractBuilder>();
            services.AddSingleton<IExitEmloyeeLeaveLineBuilder, ExitEmloyeeLeaveLineBuilder>();
            services.AddSingleton<ICnssDeclarationSessionBuilder, CnssDeclarationSessionBuilder>();
            services.AddSingleton<IContractAdvantageBuilder, ContractAdvantageBuilder>();
            services.AddSingleton<ISessionLoanInstallmentBuilder, SessionLoanInstallmentBuilder>();
            services.AddSingleton<IAdditionalHourBuilder, AdditionalHourBuilder>();
            services.AddSingleton<IAdditionalHourSlotBuilder, AdditionalHourSlotBuilder>();
            services.AddSingleton<ITransferOrderSessionBuilder, TransferOrderSessionBuilder>();

        }

        /// <summary>
        /// Immobilisation builders
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterImmobilisation(IServiceCollection services)
        {
            services.AddSingleton<IActiveBuilder, ActiveBuilder>();
            services.AddSingleton<IReducedActiveBuilder, ReducedActiveBuilder>();
            services.AddSingleton<ICategoryBuilder, CategoryBuilder>();
            services.AddSingleton<IReducedCategoryBuilder, ReducedCategoryBuilder>();
            services.AddSingleton<IHistoryBuilder, HistoryBuilder>();

        }

        /// <summary>
        /// RH builders
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterRHBuilders(IServiceCollection services)
        {
            services.AddSingleton<ICandidateBuilder, CandidateBuilder>();
            services.AddSingleton<ICandidateBuilder, CandidateBuilder>();
            services.AddSingleton<ICandidacyBuilder, CandidacyBuilder>();
            services.AddSingleton<IReducedCandidacyBuilder, ReducedCandidacyBuilder>();
            services.AddSingleton<IInterviewBuilder, InterviewBuilder>();
            services.AddSingleton<IInterviewEmailBuilder, InterviewEmailBuilder>();
            services.AddSingleton<IInterviewMarkBuilder, InterviewMarkBuilder>();
            services.AddSingleton<IInterviewQuestionBuilder, InterviewQuestionBuilder>();
            services.AddSingleton<IInterviewQuestionThemeBuilder, InterviewQuestionThemeBuilder>();
            services.AddSingleton<IInterviewTypeBuilder, InterviewTypeBuilder>();
            services.AddSingleton<IOfferBuilder, OfferBuilder>();
            services.AddSingleton<IRecruitmentBuilder, RecruitmentBuilder>();
            services.AddSingleton<IProjectBuilder, ProjectBuilder>();
            services.AddSingleton<ITimeSheetBuilder, TimeSheetBuilder>();
            services.AddSingleton<IReducedTimeSheetBuilder, ReducedTimeSheetBuilder>();
            services.AddSingleton<ITimeSheetLineBuilder, TimeSheetLineBuilder>();
            services.AddSingleton<IAdvantagesBuilder, AdvantagesBuilder>();
            services.AddSingleton<IEvaluationCriteriaThemeBuilder, EvaluationCriteriaThemeBuilder>();
            services.AddSingleton<IEvaluationCriteriaBuilder, EvaluationCriteriaBuilder>();
            services.AddSingleton<ICriteriaMarkBuilder, CriteriaMarkBuilder>();
            services.AddSingleton<IEmployeeProjectBuilder, EmployeeProjectBuilder>();
            services.AddSingleton<IReviewBuilder, ReviewBuilder>();
            services.AddSingleton<IReviewResumeBuilder, ReviewResumeBuilder>();
            services.AddSingleton<IReviewFormationBuilder, ReviewFormationBuilder>();
            services.AddSingleton<IFormationBuilder, FormationBuilder>();
            services.AddSingleton<IReviewSkillsBuilder, ReviewSkillsBuilder>();
            services.AddSingleton<IObjectiveBuilder, ObjectiveBuilder>();
            services.AddSingleton<IQuestionBuilder, QuestionBuilder>();
            services.AddSingleton<IFormationTypeBuilder, FormationTypeBuilder>();
            services.AddSingleton<IReducedCandidateBuilder, ReducedCandidateBuilder>();


            services.AddSingleton<ITrainingBuilder, TrainingBuilder>();
            services.AddSingleton<ITrainingByEmployeeBuilder, TrainingByEmployeeBuilder>();
            services.AddSingleton<ITrainingExpectedSkillsBuilder, TrainingExpectedSkillsBuilder>();
            services.AddSingleton<ITrainingRequestBuilder, TrainingRequestBuilder>();
            services.AddSingleton<ITrainingRequiredSkillsBuilder, TrainingRequiredSkillsBuilder>();
            services.AddSingleton<ITrainingSeanceBuilder, TrainingSeanceBuilder>();
            services.AddSingleton<ITrainingSessionBuilder, TrainingSessionBuilder>();
            services.AddSingleton<ITrainingCenterBuilder, TrainingCenterBuilder>();
            services.AddSingleton<ITrainingCenterManagerBuilder, TrainingCenterManagerBuilder>();
            services.AddSingleton<ITrainingCenterRoomBuilder, TrainingCenterRoomBuilder>();
            services.AddSingleton<IExternalTrainerBuilder, ExternalTrainerBuilder>();
            services.AddSingleton<IExternalTrainerSkillsBuilder, ExternalTrainerSkillsBuilder>();
            services.AddSingleton<IExternalTrainingBuilder, ExternalTrainingBuilder>();
            services.AddSingleton<IEmployeeTrainingSessionBuilder, EmployeeTrainingSessionBuilder>();

            services.AddSingleton<IMobilityRequestBuilder, MobilityRequestBuilder>();
            services.AddSingleton<IRecruitmentLanguageBuilder, RecruitmentLanguageBuilder>();
            services.AddSingleton<IRecruitmentSkillsBuilder, RecruitmentSkillsBuilder>();


            services.AddSingleton<IMobilityRequestBuilder, MobilityRequestBuilder>();
            services.AddSingleton<IOfferBenefitInKindBuilder, OfferBenefitInKindBuilder>();
            services.AddSingleton<IFileDriveBuilder, FileDriveBuilder>();
            services.AddSingleton<IUserFileAccessBuilder, UserFileAccessBuilder>();
            services.AddSingleton<IUserFileModificationBuilder, UserFileModificationBuilder>();
            services.AddSingleton<IFileDriveSharedDocumentBuilder, FileDriveSharedDocumentBuilder>();
            services.AddSingleton<IOfferBonusBuilder, OfferBonusBuilder>();



        }

        /// <summary>
        /// Registers the payroll builders
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterReportingBuilders(IServiceCollection services)
        {
            services.AddSingleton<IDocumentReportingBuilder, DocumentReportingBuilder>();
            services.AddSingleton<ICompanyReportingBuilder, CompanyReportingBuilder>();
            services.AddSingleton<IDocumentLineReportingBuilder, DocumentLineReportingBuilder>();
            services.AddSingleton<IDocumentLineCostReportingBuilder, DocumentLineCostReportingBuilder>();
            services.AddSingleton<IDocumentLineExpenseReportingBuilder, DocumentLineExpenseReportingBuilder>();

        }

        /// <summary>
        /// Registers the Helpdesk builders
        /// </summary>
        /// <param name="services"></param>
        private static void RegisterHelpdeskBuilders(IServiceCollection services)
        {
            services.AddSingleton<IClaimBuilder, ClaimBuilder>();
            services.AddSingleton<IReducedClaimBuilder, ReducedClaimBuilder>();
            services.AddSingleton<IClaimTypeBuilder, ClaimTypeBuilder>();
            services.AddSingleton<IClaimStatusBuilder, ClaimStatusBuilder>();
            services.AddSingleton<IClaimInteractionBuilder, ClaimInteractionBuilder>();

        }

        public static void RegisterMasterBuilders(this IServiceCollection services)
        {
            services.AddSingleton<ICompanyLicenceBuilder, CompanyLicenceBuilder>();
            services.AddSingleton<IMasterUserBuilder, MasterUserBuilder>();
            services.AddSingleton<IMasterCompanyBuilder, MasterCompanyBuilder>();
            services.AddSingleton<IMasterUserCompanyBuilder, MasterUserCompanyBuilder>();
            services.AddSingleton<IMasterDbSettingsBuilder, MasterDbSettingsBuilder>();
            services.AddSingleton<IMasterRoleBuilder, MasterRoleBuilder>();
            services.AddSingleton<IMasterRoleUserBuilder, MasterRoleUserBuilder>();
        }

        private static void RegisterTreasuryBuilders(IServiceCollection services)
        {
            services.AddSingleton<IDetailReconciliationBuilder, DetailReconciliationBuilder>();
            services.AddSingleton<IDetailTimetableBuilder, DetailTimetableBuilder>();
            services.AddSingleton<IReconciliationBuilder, ReconciliationBuilder>();
            services.AddSingleton<ITimetableBuilder, TimetableBuilder>();
            services.AddSingleton<ITicketBuilder, TicketBuilder>();
            services.AddSingleton<ITicketPaymentBuilder, TicketPaymentBuilder>();
            services.AddSingleton<IOperationCashBuilder, OperationCashBuilder>();
        }
    }
}
