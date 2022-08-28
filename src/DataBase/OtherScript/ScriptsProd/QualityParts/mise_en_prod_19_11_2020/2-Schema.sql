-- houssem 03-06-2020 Addd Script ESN

GO
CREATE TABLE [ERPSettings].[DiscussionChat] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (250) NOT NULL,
    [nbMember]      INT           NOT NULL,
    [DateLastNotif] DATETIME      NOT NULL,
    CONSTRAINT [PK_DiscussionChat] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [ERPSettings].[MessageChat]...';


GO
CREATE TABLE [ERPSettings].[MessageChat] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [text]              TEXT          NOT NULL,
    [date]              DATETIME      NOT NULL,
    [attachedFilesLink] VARCHAR (250) NULL,
    [IdUserDiscussion]  INT           NOT NULL,
    CONSTRAINT [PK_MessageChat] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [ERPSettings].[Privilege]...';


GO
CREATE TABLE [ERPSettings].[Privilege] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Reference]         NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_Privilege] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [ERPSettings].[UserDiscussionChat]...';


GO
CREATE TABLE [ERPSettings].[UserDiscussionChat] (
    [Id]           INT IDENTITY (1, 1) NOT NULL,
    [IdUser]       INT NOT NULL,
    [IdDiscussion] INT NOT NULL,
    [HasNotif]     BIT NOT NULL,
    CONSTRAINT [PK_UserDiscussionChat] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [ERPSettings].[UserPrivilege]...';


GO
CREATE TABLE [ERPSettings].[UserPrivilege] (
    [Id]                            INT            IDENTITY (1, 1) NOT NULL,
    [IdUser]                        INT            NOT NULL,
    [IdPrivilege]                   INT            NOT NULL,
    [IsDeleted]                     BIT            NOT NULL,
    [TransactionUserId]             INT            NOT NULL,
    [Deleted_Token]                 NVARCHAR (255) NULL,
    [SameLevelWithHierarchy]        BIT            NULL,
    [SameLevelWithoutHierarchy]     BIT            NULL,
    [SubLevel]                      BIT            NULL,
    [SuperiorLevelWithHierarchy]    BIT            NULL,
    [SuperiorLevelWithoutHierarchy] BIT            NULL,
    [Management]                    BIT            NULL,
    CONSTRAINT [PK_UserPrivilege] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[BenefitInKind]...';


GO
CREATE TABLE [Payroll].[BenefitInKind] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [IdCnss]            INT            NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Type]              INT            NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_BenefitInKind] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[ContractBenefitInKind]...';


GO
CREATE TABLE [Payroll].[ContractBenefitInKind] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IdBenefitInKind]   INT            NOT NULL,
    [ValidityStartDate] DATE           NOT NULL,
    [ValidityEndDate]   DATE           NULL,
    [Value]             FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ContractBenefitInKind] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[EmployeeExit]...';


GO
CREATE TABLE [Payroll].[EmployeeExit] (
    [Id]                          INT            IDENTITY (1, 1) NOT NULL,
    [IdExitReason]                INT            NOT NULL,
    [IdEmployee]                  INT            NOT NULL,
    [IsDeleted]                   BIT            NOT NULL,
    [TransactionUserId]           INT            NULL,
    [Deleted_Token]               NVARCHAR (255) NULL,
    [ReleaseDate]                 DATE           NOT NULL,
    [ExitEmployeeAttachementFile] NVARCHAR (500) NULL,
    [CommentRh]                   NVARCHAR (255) NULL,
    [Status]                      INT            NULL,
    [TreatmentDate]               DATE           NULL,
    [TreatedBy]                   INT            NULL,
    [LegalExitDate]               DATE           NULL,
    [DamagingDeparture]           BIT            NULL,
    [ExitDepositDate]             DATE           NULL,
    [MinNoticePeriodDate]         DATE           NULL,
    [MaxNoticePeriodDate]         DATE           NULL,
    [ExitPhysicalDate]            DATE           NULL,
    CONSTRAINT [PK_EmployeeExit] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[EmployeeTeam]...';


GO
CREATE TABLE [Payroll].[EmployeeTeam] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [AssignmentDate]       DATE           NOT NULL,
    [UnassignmentDate]     DATE           NULL,
    [IdEmployee]           INT            NOT NULL,
    [IdTeam]               INT            NOT NULL,
    [IsDeleted]            BIT            NOT NULL,
    [TransactionUserId]    INT            NULL,
    [Deleted_Token]        NVARCHAR (MAX) NULL,
    [AssignmentPercentage] FLOAT (53)     NULL,
    CONSTRAINT [PK_EmployeeTeam] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[ExitEmailForEmployee]...';


GO
CREATE TABLE [Payroll].[ExitEmailForEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEmployeeExit]    INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExitEmailForEmployee_1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[ExitReason]...';


GO
CREATE TABLE [Payroll].[ExitReason] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    [Label]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExitReason] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[LeaveBalanceRemaining]...';


GO
CREATE TABLE [Payroll].[LeaveBalanceRemaining] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdLeaveType]       INT            NOT NULL,
    [RemainingBalance]  INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [DeletedToken]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_LeaveBalanceRemaining] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Loan]...';


GO
CREATE TABLE [Payroll].[Loan] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [State]             INT            NULL,
    [Code]              NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Loan] PRIMARY KEY CLUSTERED ([Id] ASC)
);




GO
CREATE TABLE [Payroll].[Note] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NOT NULL,
    [Mark]              NVARCHAR (MAX) NOT NULL,
    [idEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [idCreator]         INT            NOT NULL,
    CONSTRAINT [PK_Note] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[SalaryRuleValidityPeriod]...';


GO
CREATE TABLE [Payroll].[SalaryRuleValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [rule]              NVARCHAR (MAX) NULL,
    [IdSalaryRule]      INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [TransactionUserId] INT            NULL,
    CONSTRAINT [PK_SalaryRuleValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[SourceDeduction]...';


GO
CREATE TABLE [Payroll].[SourceDeduction] (
    [Id]                       INT            IDENTITY (1, 1) NOT NULL,
    [CreationDate]             DATE           NOT NULL,
    [Year]                     INT            NOT NULL,
    [StartDate]                DATE           NOT NULL,
    [EndDate]                  DATE           NOT NULL,
    [Status]                   INT            NOT NULL,
    [TaxableWages]             FLOAT (53)     NOT NULL,
    [NaturalAdvantage]         FLOAT (53)     NOT NULL,
    [GrossTaxable]             FLOAT (53)     NOT NULL,
    [RetainedReinvested]       FLOAT (53)     NOT NULL,
    [SumIRPP]                  FLOAT (53)     NOT NULL,
    [CSS]                      FLOAT (53)     NOT NULL,
    [NetToPay]                 FLOAT (53)     NOT NULL,
    [IdSourceDeductionSession] INT            NOT NULL,
    [IdEmployee]               INT            NOT NULL,
    [IsDeleted]                BIT            NOT NULL,
    [TransactionUserId]        INT            NULL,
    [Deleted_Token]            NVARCHAR (255) NULL,
    CONSTRAINT [PK_DetentionSource] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[SourceDeductionSession]...';


GO
CREATE TABLE [Payroll].[SourceDeductionSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Number]            INT            NOT NULL,
    [Title]             NVARCHAR (125) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [Year]              INT            NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NOT NULL,
    [State]             INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_DetentionSourceSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[SourceDeductionSessionEmployee]...';


GO
CREATE TABLE [Payroll].[SourceDeductionSessionEmployee] (
    [Id]                       INT            IDENTITY (1, 1) NOT NULL,
    [IdSourceDeductionSession] INT            NOT NULL,
    [IdEmployee]               INT            NOT NULL,
    [IsDeleted]                BIT            NOT NULL,
    [TransactionUserId]        INT            NULL,
    [Deleted_Token]            NVARCHAR (255) NULL,
    CONSTRAINT [PK_SourceDeductionSessionEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[TeamType]...';


GO
CREATE TABLE [Payroll].[TeamType] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NULL,
    [Label]             NVARCHAR (50)  NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_TeamType] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[VariableValidityPeriod]...';


GO
CREATE TABLE [Payroll].[VariableValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [Formule]           NVARCHAR (MAX) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdVariable]        INT            NOT NULL,
    CONSTRAINT [PK_VariableValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[EmployeeTrainingSession]...';


GO
CREATE TABLE [RH].[EmployeeTrainingSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdTrainingSession] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_EmployeeTrainingSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[ExternalTrainer]...';


GO
CREATE TABLE [RH].[ExternalTrainer] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]         NVARCHAR (255) NULL,
    [LastName]          NVARCHAR (255) NULL,
    [Email]             NVARCHAR (255) NULL,
    [PhoneNumber]       NVARCHAR (255) NULL,
    [YearsOfExperience] INT            NULL,
    [HourCost]          FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExternalTrainer] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[ExternalTrainerSkills]...';


GO
CREATE TABLE [RH].[ExternalTrainerSkills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdExternalTrainer] INT            NULL,
    [IdSkills]          INT            NULL,
    [IsRecognized]      BIT            NULL,
    [IsCertified]       BIT            NULL,
    [Rate]              INT            NULL,
    CONSTRAINT [PK_ExternalTrainerSkills] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[ExternalTraining]...';


GO
CREATE TABLE [RH].[ExternalTraining] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [IdExternalTrainer]    INT            NOT NULL,
    [IdTrainingCenterRoom] INT            NOT NULL,
    [IsDeleted]            BIT            NOT NULL,
    [TransactionUserId]    INT            NULL,
    [Deleted_Token]        NVARCHAR (255) NULL,
    [IdTrainingSession]    INT            NULL,
    CONSTRAINT [PK_ExternalTraining] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[FileDrive]...';


GO
CREATE TABLE [RH].[FileDrive] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [CreatedBy]         INT            NOT NULL,
    [CreationDate]      DATETIME       NOT NULL,
    [Type]              NVARCHAR (255) NULL,
    [IdParent]          INT            NULL,
    [Size]              INT            NOT NULL,
    [Path]              NVARCHAR (255) NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_FileDrive] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[FileDriveSharedDocument]...';


GO
CREATE TABLE [RH].[FileDriveSharedDocument] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [SharingDate]       DATETIME       NULL,
    [AttachmentUrl]     VARCHAR (250)  NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_FileDriveSharedDocument] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[MobilityRequest]...';


GO
CREATE TABLE [RH].[MobilityRequest] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [Status]               INT            NULL,
    [IdEmployee]           INT            NOT NULL,
    [IdCurrentOffice]      INT            NOT NULL,
    [IdDestinationOffice]  INT            NOT NULL,
    [DesiredMobilityDate]  DATETIME       NOT NULL,
    [EffectifMobilityDate] DATETIME       NULL,
    [Description]          NVARCHAR (MAX) NULL,
    [CreationDate]         DATETIME       NOT NULL,
    [IdCreationUser]       INT            NULL,
    [IsDeleted]            BIT            NOT NULL,
    [TransactionUserId]    INT            NOT NULL,
    [Deleted_Token]        NVARCHAR (255) NULL,
    CONSTRAINT [PK_MobilityRequest] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[OfferBenefitInKind]...';


GO
CREATE TABLE [RH].[OfferBenefitInKind] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdOffer]           INT            NOT NULL,
    [IdBenefitInKind]   INT            NOT NULL,
    [ValidityStartDate] DATE           NOT NULL,
    [ValidityEndDate]   DATE           NULL,
    [Value]             FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_OfferBenefitInKind] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[RecruitmentLanguage]...';


GO
CREATE TABLE [RH].[RecruitmentLanguage] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdRecruitment]     INT            NOT NULL,
    [IdLanguage]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Rate]              INT            NOT NULL,
    CONSTRAINT [PK_RequestLanguage] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[RecruitmentSkills]...';


GO
CREATE TABLE [RH].[RecruitmentSkills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSkills]          INT            NOT NULL,
    [IdRecruitment]     INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Rate]              INT            NOT NULL,
    CONSTRAINT [PK_RequestSkills] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[Training]...';


GO
CREATE TABLE [RH].[Training] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Name]               NVARCHAR (225) NOT NULL,
    [Description]        TEXT           NOT NULL,
    [Duration]           FLOAT (53)     NULL,
    [IsCertified]        BIT            NOT NULL,
    [IsInternal]         BIT            NOT NULL,
    [IdSupplier]         INT            NULL,
    [IsDeleted]          BIT            NOT NULL,
    [TransactionUserId]  INT            NULL,
    [Deleted_Token]      NVARCHAR (255) NULL,
    [TrainingPictureUrl] NVARCHAR (255) NULL,
    CONSTRAINT [PK_Training] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingByEmployee]...';


GO
CREATE TABLE [RH].[TrainingByEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdTraining]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TrainingByEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingCenter]...';


GO
CREATE TABLE [RH].[TrainingCenter] (
    [Id]                      INT            IDENTITY (1, 1) NOT NULL,
    [Name]                    NVARCHAR (255) NULL,
    [Place]                   NVARCHAR (255) NULL,
    [OpeningTime]             TIME (7)       NULL,
    [ClosingTime]             TIME (7)       NULL,
    [ModeOfPayment]           INT            NULL,
    [CenterPhoneNumber]       NVARCHAR (50)  NULL,
    [IsDeleted]               BIT            NOT NULL,
    [TransactionUserId]       INT            NULL,
    [Deleted_Token]           NVARCHAR (255) NULL,
    [IdTrainingCenterManager] INT            NULL,
    CONSTRAINT [PK_TrainingCenter] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingCenterManager]...';


GO
CREATE TABLE [RH].[TrainingCenterManager] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]         NVARCHAR (255) NULL,
    [LastName]          NVARCHAR (255) NULL,
    [PhoneNumber]       NVARCHAR (50)  NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TrainingCenterManager] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingCenterRoom]...';


GO
CREATE TABLE [RH].[TrainingCenterRoom] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NULL,
    [Capacity]          INT            NULL,
    [Availability]      INT            NULL,
    [RoomType]          INT            NULL,
    [RentPerHour]       FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdTrainingCenter]  INT            NOT NULL,
    CONSTRAINT [PK_TrainingCenterRoom] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingExpectedSkills]...';


GO
CREATE TABLE [RH].[TrainingExpectedSkills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTraining]        INT            NOT NULL,
    [IdSkills]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TrainingExpectedSkills] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingRequest]...';


GO
CREATE TABLE [RH].[TrainingRequest] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [ExpectedDate]           DATE           NULL,
    [Status]                 INT            NOT NULL,
    [CreationDate]           DATE           NOT NULL,
    [TreatmentDate]          DATE           NULL,
    [IdTraining]             INT            NOT NULL,
    [IdEmployeeAuthor]       INT            NOT NULL,
    [IdEmployeeCollaborator] INT            NOT NULL,
    [IsDeleted]              BIT            NOT NULL,
    [TransactionUserId]      INT            NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    [Description]            NVARCHAR (250) NULL,
    [IdTrainingSession]      INT            NULL,
    CONSTRAINT [PK_TrainingRequest] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingRequiredSkills]...';


GO
CREATE TABLE [RH].[TrainingRequiredSkills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTraining]        INT            NOT NULL,
    [IdSkills]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TrainingRequiredSkills] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingSeance]...';


GO
CREATE TABLE [RH].[TrainingSeance] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NULL,
    [StartHour]         TIME (7)       NOT NULL,
    [EndHour]           TIME (7)       NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdTrainingSession] INT            NOT NULL,
    [Details]           NVARCHAR (MAX) NULL,
    [DayOfWeek]         INT            NULL,
    CONSTRAINT [PK_TrainingSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[TrainingSession]...';


GO
CREATE TABLE [RH].[TrainingSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Status]            INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdTraining]        INT            NOT NULL,
    [Name]              NVARCHAR (255) NULL,
    [StartDate]         DATE           NULL,
    [EndDate]           DATE           NULL,
    [Description]       NVARCHAR (255) NULL,
    [SessionPlan]       NVARCHAR (255) NULL,
    [Duration]          FLOAT (53)     NULL,
    [SessionPlanUrl]    NVARCHAR (255) NULL,
    [IdExternalTrainer] INT            NULL,
    [IdEmployee]        INT            NULL,
    CONSTRAINT [PK_TrainingPlanification] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[UserFileAccess]...';


GO
CREATE TABLE [RH].[UserFileAccess] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdUser]            INT            NOT NULL,
    [IdFile]            INT            NOT NULL,
    [ReadFile]          BIT            NOT NULL,
    [WriteFile]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_UserFileAccess] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[UserFileModification]...';


GO
CREATE TABLE [RH].[UserFileModification] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdUser]            INT            NOT NULL,
    [IdFile]            INT            NOT NULL,
    [ModificationDate]  DATETIME       NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_UserFileModification] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[BillingEmployee]...';


GO
CREATE TABLE [Sales].[BillingEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdBillingSession]  INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdTimeSheet]       INT            NULL,
    [IdProject]         INT            NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_BillingEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[Address]...';


GO
CREATE TABLE [Shared].[Address] (
    [Id]                INT            IDENTITY (100000, 1) NOT NULL,
    [Country]           NVARCHAR (255) NULL,
    [City]              NVARCHAR (255) NULL,
    [ZipCode]           NVARCHAR (255) NULL,
    [ExtraAdress]       NVARCHAR (255) NULL,
    [IdTiers]           INT            NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [DeletedToken]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_Adress] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[DateToRemember]...';


GO
CREATE TABLE [Shared].[DateToRemember] (
    [Id]                INT            IDENTITY (100000, 1) NOT NULL,
    [EventName]         NVARCHAR (255) NULL,
    [Date]              DATETIME2 (7)  NULL,
    [IdTiers]           INT            NULL,
    [IdContact]         INT            NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [DeletedToken]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_DateToRemember] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[GeneralSettings]...';


GO
CREATE TABLE [Shared].[GeneralSettings] (
    [Id]            INT            NOT NULL,
    [Keys]          NVARCHAR (255) NULL,
    [Field]         NVARCHAR (255) NULL,
    [Value]         NVARCHAR (255) NULL,
    [Description]   NVARCHAR (255) NULL,
    [IsDeleted]     BIT            NOT NULL,
    [Deleted_Token] NVARCHAR (255) NULL,
    CONSTRAINT [PK_GeneralSettings] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[JobsParameter]...';


GO
CREATE TABLE [Shared].[JobsParameter] (
    [Id]            INT            NOT NULL,
    [Keys]          NVARCHAR (255) NULL,
    [Field]         NVARCHAR (255) NULL,
    [Value]         NVARCHAR (255) NULL,
    [Description]   NVARCHAR (255) NULL,
    [IsDeleted]     BIT            NOT NULL,
    [Deleted_Token] NVARCHAR (255) NULL,
    CONSTRAINT [PK_JobsParameter] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[Language]...';


GO
CREATE TABLE [Shared].[Language] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (100) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Shared].[Office]...';


GO
CREATE TABLE [Shared].[Office] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [OfficeName]        NVARCHAR (255) NOT NULL,
    [AddressLine1]      NVARCHAR (255) NULL,
    [AddressLine2]      NVARCHAR (255) NULL,
    [AddressLine3]      NVARCHAR (255) NULL,
    [AddressLine4]      NVARCHAR (255) NULL,
    [AddressLine5]      NVARCHAR (255) NULL,
    [PhoneNumber]       NVARCHAR (50)  NULL,
    [Facebook]          NVARCHAR (255) NULL,
    [LinkedIn]          NVARCHAR (MAX) NULL,
    [IdCountry]         INT            NOT NULL,
    [IdCity]            INT            NOT NULL,
    [IdOfficeManager]   INT            NULL,
    [CreationDate]      DATETIME       NOT NULL,
    [IdCreationUser]    INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[DF_Project_Default]...';



GO
ALTER TABLE [Payroll].[Contract]
    ADD [IdContractType] INT NOT NULL,
        [State]          INT NULL;


GO
PRINT N'Altering [Payroll].[ContractBonus]...';


GO
ALTER TABLE [Payroll].[ContractBonus]
    ADD [ValidityEndDate] DATE NULL;


GO
PRINT N'Altering [Payroll].[ContractType]...';


GO
ALTER TABLE [Payroll].[ContractType] DROP COLUMN [ContractTypeReference], COLUMN [En], COLUMN [Fr];


GO
ALTER TABLE [Payroll].[ContractType] ALTER COLUMN [Description] NVARCHAR (255) NULL;


GO
ALTER TABLE [Payroll].[ContractType]
    ADD [Code]               NVARCHAR (255) NOT NULL default '',
        [MinNoticePeriod]    INT            NULL,
        [MaxNoticePeriod]    INT            NULL,
        [Label]              NVARCHAR (255) NULL,
        [CalendarNoticeDays] BIT            DEFAULT ('false') NOT NULL;


GO
PRINT N'Altering [Payroll].[DocumentRequest]...';


GO
ALTER TABLE [Payroll].[DocumentRequest] ALTER COLUMN [TreatmentDate] DATE NULL;


GO
PRINT N'Starting rebuilding table [Payroll].[Employee]...';


GO
ALTER TABLE [Payroll].[ExpenseReport] ALTER COLUMN [SubmissionDate] DATE NOT NULL;

ALTER TABLE [Payroll].[ExpenseReport] ALTER COLUMN [TreatmentDate] DATE NULL;


GO
PRINT N'Altering [Payroll].[ExpenseReportDetails]...';


GO
ALTER TABLE [Payroll].[ExpenseReportDetails] ALTER COLUMN [AttachmentUrl] NVARCHAR (255) NOT NULL;


GO
PRINT N'Altering [Payroll].[Job]...';


GO
ALTER TABLE [Payroll].[Job]
    ADD [HierarchyLevel] NVARCHAR (MAX) NULL;


GO
PRINT N'Altering [Payroll].[Leave]...';


GO
ALTER TABLE [Payroll].[Leave] DROP COLUMN [SubmissionDate];


GO
ALTER TABLE [Payroll].[Leave] ALTER COLUMN [TreatmentDate] DATE NULL;


GO
ALTER TABLE [Payroll].[Leave]
    ADD [Period] DATETIME NOT NULL;


GO
PRINT N'Altering [Payroll].[LeaveType]...';


GO
ALTER TABLE [Payroll].[LeaveType]
    ADD [ExpiryDate]           DATE NULL,
        [Calendar]             BIT  NULL,
        [Cumulable]            BIT  NULL,
        [AuthorizedOvertaking] BIT  DEFAULT ((0)) NOT NULL,
        [Period]               INT  DEFAULT ((1)) NOT NULL;


GO
PRINT N'Altering [Payroll].[Qualification]...';


GO
ALTER TABLE [Payroll].[Qualification] ALTER COLUMN [IdEmployee] INT NULL;


GO
ALTER TABLE [Payroll].[Qualification]
    ADD [IdCandidate] INT NULL;


GO
PRINT N'Altering [Payroll].[QualificationType]...';


GO
ALTER TABLE [Payroll].[QualificationType]
    ADD [Description] NVARCHAR (255) NULL;


GO
PRINT N'Altering [Payroll].[SalaryRule]...';


GO
ALTER TABLE [Payroll].[SalaryRule] DROP COLUMN [rule];




GO
ALTER TABLE [Payroll].[SharedDocument] ALTER COLUMN [AttachmentUrl] NVARCHAR (255) NOT NULL;


GO
PRINT N'Altering [Payroll].[Team]...';


GO
ALTER TABLE [Payroll].[Team]
    ADD [State]            BIT DEFAULT ((0)) NOT NULL,
        [NumberOfAffected] INT NULL,
        [IdTeamType]       INT NULL;


GO
PRINT N'Starting rebuilding table [Payroll].[TransferOrder]...';


GO
PRINT N'Altering [Payroll].[TransferOrderDetails]...';


GO
ALTER TABLE [Payroll].[TransferOrderDetails] DROP COLUMN [Label];


GO
PRINT N'Altering [Payroll].[Variable]...';


GO
ALTER TABLE [Payroll].[Variable] DROP COLUMN [Formule];


GO
ALTER TABLE [Payroll].[Variable]
    ADD [Name] NVARCHAR (255) NULL;


GO
PRINT N'Altering [RH].[Candidate]...';


GO
ALTER TABLE [RH].[Candidate] ALTER COLUMN [LinkedIn] NVARCHAR (MAX) NULL;


GO
ALTER TABLE [RH].[Candidate]
    ADD [CreationDate]      DATE           CONSTRAINT [DF_Candidate_CreationDate] DEFAULT (getdate()) NOT NULL,
        [IdCreationUser]    INT            NULL,
        [IdOffice]          INT            NULL,
        [BirthDate]         DATE           NULL,
        [AddressLine1]      NVARCHAR (255) NULL,
        [AddressLine2]      NVARCHAR (255) NULL,
        [AddressLine3]      NVARCHAR (255) NULL,
        [AddressLine4]      NVARCHAR (255) NULL,
        [AddressLine5]      NVARCHAR (255) NULL,
        [Facebook]          NVARCHAR (255) NULL,
        [PersonalPhone]     NVARCHAR (50)  NULL,
        [ProfessionalPhone] NVARCHAR (50)  NULL;


GO
PRINT N'Altering [RH].[EmployeeProject]...';


GO


ALTER TABLE [RH].[EmployeeProject] ALTER COLUMN [UnassignmentDate] DATE NULL;


GO
ALTER TABLE [RH].[EmployeeProject]
    ADD [IsBillable]           BIT        CONSTRAINT [DF_EmployeeProject_Billable] DEFAULT ((0)) NOT NULL,
        [AssignmentPercentage] FLOAT (53) NULL;


GO
PRINT N'Altering [RH].[EvaluationCriteria]...';


GO
ALTER TABLE [RH].[EvaluationCriteria] DROP COLUMN [Code];


GO
ALTER TABLE [RH].[EvaluationCriteria]
    ADD [Description] NVARCHAR (250) NULL;


GO
PRINT N'Altering [RH].[EvaluationCriteriaTheme]...';


GO
ALTER TABLE [RH].[EvaluationCriteriaTheme]
    ADD [Description] NVARCHAR (250) NULL;


GO
PRINT N'Starting rebuilding table [RH].[Interview]...';


GO
ALTER TABLE [RH].[Offer] DROP COLUMN [AvailableCar], COLUMN [AvailableHouse], COLUMN [CommissionType], COLUMN [CommissionValue], COLUMN [MealVoucher];


GO
ALTER TABLE [RH].[Offer]
    ADD [IdContractType] INT NOT NULL;


GO
PRINT N'Altering [RH].[Project]...';


GO
ALTER TABLE [RH].[Project] ALTER COLUMN [Default] BIT NOT NULL;


GO
ALTER TABLE [RH].[Project]
    ADD [IsBillable]       BIT            CONSTRAINT [DF_Project_IsForeign] DEFAULT ((0)) NOT NULL,
        [ReferenceProject] NVARCHAR (255) NULL,
        [ReferenceBc]      NVARCHAR (255) NULL,
        [LabelInInvoice]   NVARCHAR (255) NULL,
        [IdBankAccount]    INT            NULL,
        [ProjectLabel]     NVARCHAR (255) NULL,
        [AttachementFile]  NVARCHAR (255) NULL,
        [CreationDate]     DATETIME       CONSTRAINT [DF_Project_CreationDate] DEFAULT (getdate()) NOT NULL;


GO
PRINT N'Altering [RH].[Recruitment]...';


GO
ALTER TABLE [RH].[Recruitment]
    ADD [IdOffice]                INT            NULL,
        [RequestReason]           NVARCHAR (500) NULL,
        [ExpectedCandidateNumber] INT            NULL,
        [StartDate]               DATE           NULL,
        [IdContractType]          INT            NULL,
        [Type]                    INT            NULL,
        [RequestStatus]           INT            NULL,
        [Sex]                     INT            NOT NULL,
        [Code]                    NVARCHAR (50)  NULL,
        [OfferStatus]             INT            NULL,
        [TreatmentDate]           DATE           NULL,
        [EndDate]                 DATE           NULL,
        [OfferPicture]            NVARCHAR (500) NULL,
        [RecruitmentTypeCode]     NVARCHAR (255) NULL;


GO
PRINT N'Altering [RH].[Review]...';


GO
ALTER TABLE [RH].[Review]
    ADD [IdManager] INT NULL;


GO
PRINT N'Altering [RH].[TimeSheet]...';


GO
ALTER TABLE [RH].[TimeSheet] ALTER COLUMN [TreatmentDate] DATE NULL;


GO
PRINT N'Altering [RH].[TimeSheetLine]...';


GO
ALTER TABLE [RH].[TimeSheetLine] DROP COLUMN [LineTotalTime];


GO
PRINT N'Starting rebuilding table [Sales].[Tiers]...';


ALTER TABLE [Payroll].[SourceDeduction]
    ADD DEFAULT ((0)) FOR [Status];


GO

PRINT N'Creating [Payroll].[DF_TeamType_TransactionUserId]...';


GO
ALTER TABLE [Payroll].[TeamType]
    ADD CONSTRAINT [DF_TeamType_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO

PRINT N'Creating [RH].[DF_FileDriveSharedDocument_TransactionUserId]...';


GO
ALTER TABLE [RH].[FileDriveSharedDocument]
    ADD CONSTRAINT [DF_FileDriveSharedDocument_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO

PRINT N'Creating [RH].[DF_MobilityOffice_CreationDate]...';


GO
ALTER TABLE [RH].[MobilityRequest]
    ADD CONSTRAINT [DF_MobilityOffice_CreationDate] DEFAULT (getdate()) FOR [CreationDate];


GO

PRINT N'Creating [RH].[DF_MobilityOffice_TransactionUserId]...';


GO
ALTER TABLE [RH].[MobilityRequest]
    ADD CONSTRAINT [DF_MobilityOffice_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO



GO
ALTER TABLE [Immobilisation].[Active]
    ADD [IPAddress]   NVARCHAR (500) NULL,
        [MACAddress]  NVARCHAR (500) NULL,
        [HostName]    NVARCHAR (500) NULL,
        [PhoneNumber] NVARCHAR (500) NULL;


GO
PRINT N'Creating [ERPSettings].[DF_DiscussionChat_isPair]...';


GO
ALTER TABLE [ERPSettings].[DiscussionChat]
    ADD CONSTRAINT [DF_DiscussionChat_isPair] DEFAULT ((0)) FOR [nbMember];


GO
PRINT N'Creating [ERPSettings].[DF_UserDiscussionChat_isNotif]...';


GO
ALTER TABLE [ERPSettings].[UserDiscussionChat]
    ADD CONSTRAINT [DF_UserDiscussionChat_isNotif] DEFAULT ((0)) FOR [HasNotif];


GO
PRINT N'Creating [ERPSettings].[FK_MessageChat_UserDiscussionChat]...';


GO
ALTER TABLE [ERPSettings].[MessageChat] WITH NOCHECK
    ADD CONSTRAINT [FK_MessageChat_UserDiscussionChat] FOREIGN KEY ([IdUserDiscussion]) REFERENCES [ERPSettings].[UserDiscussionChat] ([Id]);


GO
PRINT N'Creating [ERPSettings].[FK_UserDiscussionChat_DiscussionChat]...';


GO
ALTER TABLE [ERPSettings].[UserDiscussionChat] WITH NOCHECK
    ADD CONSTRAINT [FK_UserDiscussionChat_DiscussionChat] FOREIGN KEY ([IdDiscussion]) REFERENCES [ERPSettings].[DiscussionChat] ([Id]);


GO
PRINT N'Creating [ERPSettings].[FK_UserDiscussionChat_User]...';


GO
ALTER TABLE [ERPSettings].[UserDiscussionChat] WITH NOCHECK
    ADD CONSTRAINT [FK_UserDiscussionChat_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [ERPSettings].[FK_UserPrivilege_Privilege]...';


GO
ALTER TABLE [ERPSettings].[UserPrivilege] WITH NOCHECK
    ADD CONSTRAINT [FK_UserPrivilege_Privilege] FOREIGN KEY ([IdPrivilege]) REFERENCES [ERPSettings].[Privilege] ([Id]);


GO
PRINT N'Creating [ERPSettings].[FK_UserPrivilege_User]...';


GO
ALTER TABLE [ERPSettings].[UserPrivilege] WITH NOCHECK
    ADD CONSTRAINT [FK_UserPrivilege_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';

alter table [Payroll].[BenefitInKind]
add  CONSTRAINT [FK_BenefitInKind_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id])


alter table [Payroll].[Contract] 
add   CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id])

alter table  [Payroll].[ContractBenefitInKind]
add   CONSTRAINT [FK_ContractBenefitInKind_BenefitInKind] FOREIGN KEY ([IdBenefitInKind]) REFERENCES [Payroll].[BenefitInKind] ([Id]),
    CONSTRAINT [FK_ContractBenefitInKind_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id])

alter table [Payroll].[EmployeeExit]
add    CONSTRAINT [FK_EmployeeExit_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_EmployeeExit_ExitReason] FOREIGN KEY ([IdExitReason]) REFERENCES [Payroll].[ExitReason] ([Id])

alter table[Payroll].[EmployeeTeam] 
add CONSTRAINT [FK_EmployeeTeam_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_EmployeeTeam_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id]) ON DELETE CASCADE

alter table [Payroll].[ExitEmailForEmployee]
add  CONSTRAINT [FK_ExitEmailForEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id])


alter table [Payroll].[LeaveBalanceRemaining]

add  CONSTRAINT [FK_LeaveBalanceRemaining_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_LeaveBalanceRemaining_LeaveType] FOREIGN KEY ([IdLeaveType]) REFERENCES [Payroll].[LeaveType] ([Id])

alter table [Payroll].[Note]
add  CONSTRAINT [FK_Note_IdCreator] FOREIGN KEY ([idCreator]) REFERENCES [ERPSettings].[User] ([Id]),
    CONSTRAINT [FK_Note_idEmployee] FOREIGN KEY ([idEmployee]) REFERENCES [Payroll].[Employee] ([Id])

alter table [Payroll].[Qualification]
add CONSTRAINT [FK_Qualification_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id]) ON DELETE CASCADE
  

  alter table [Payroll].[SalaryRuleValidityPeriod]

  add CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id])


  alter table [Payroll].[SharedDocument]
  add  CONSTRAINT [FK_SharedDocument_User] FOREIGN KEY ([TransactionUserId]) REFERENCES [ERPSettings].[User] ([Id])


  alter table [Payroll].[SourceDeduction] 
     add CONSTRAINT [FK_SourceDeduction_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_SourceDeduction_SourceDeductionSession] FOREIGN KEY ([IdSourceDeductionSession]) REFERENCES [Payroll].[SourceDeductionSession] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

alter table [Payroll].[SourceDeductionSessionEmployee]
add CONSTRAINT [FK_SourceDeductionSessionEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_SourceDeductionSessionEmployee_SourceDeductionSession] FOREIGN KEY ([IdSourceDeductionSession]) REFERENCES [Payroll].[SourceDeductionSession] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

alter table  [Payroll].[Team]
add    CONSTRAINT [FK_Team_TeamType] FOREIGN KEY ([IdTeamType]) REFERENCES [Payroll].[TeamType] ([Id]) ON DELETE CASCADE

alter table [Payroll].[VariableValidityPeriod]
add CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY ([IdVariable]) REFERENCES [Payroll].[Variable] ([Id])

 alter table [Payroll].[Employee] add 
 [PersonalEmail]           NVARCHAR (255) NULL,
  [IdOffice]                INT            NULL,
  [Status]                  BIT            NULL,
  [HierarchyLevel]          NVARCHAR (MAX) NULL,
    [MaritalStatus]           INT            NULL,
	  CONSTRAINT [FK_Employee_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id])

 
 alter table [Payroll].[Employee]

 drop column [Notes]

 alter table [Payroll].[SalaryStructureSalaryRule]
 drop  CONSTRAINT [FK_SalaryStructureRule_Rule] ,
    CONSTRAINT [FK_SalaryStructureRule_Structure] 

 alter table [Payroll].[SalaryStructureSalaryRule]
  drop column [IdStructure],[IdRule]

   alter table [Payroll].[SalaryStructureSalaryRule]
   add [IdSalaryStructure] INT             NULL ,
    [IdSalaryRule]      INT             NULL
	 CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]),
    CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])


	alter table [Payroll].[Session] 
	drop column [SessionNumber],
	 [StartDate],
	 [EndDate]

	 alter table [Payroll].[Session] 
	 add [Number]            INT            NOT NULL

	 alter table [Payroll].[TransferOrder]
	 add [Number]            INT            NOT NULL


	 alter table [Payroll].[TransferOrder]
	 drop  column [TransferNumber]


alter table [RH].[Candidate] 
  add CONSTRAINT [FK_Candidate_User] FOREIGN KEY ([IdCreationUser]) REFERENCES [ERPSettings].[User] ([Id]),
    CONSTRAINT [UniqueKeyEmail] UNIQUE NONCLUSTERED ([Email] ASC, [Deleted_Token] ASC)

	alter table [RH].[CurriculumVitae] 
	drop  CONSTRAINT [FK_CV_Candidate] 

	alter table [RH].[CurriculumVitae] 
	 add  CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id]) ON DELETE CASCADE

alter table [RH].[EmployeeProject]
  drop    CONSTRAINT [FK_EmployeeProject_Project] 

  alter table [RH].[EmployeeProject]
  add       CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]) ON DELETE CASCADE

  alter table [RH].[EmployeeTrainingSession]
  add    CONSTRAINT [FK_EmployeeTrainingSession_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_EmployeeTrainingSession_TrainingSession] FOREIGN KEY ([IdTrainingSession]) REFERENCES [RH].[TrainingSession] ([Id])

	alter  table [RH].[EvaluationCriteria] 
	drop CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme]

	alter  table [RH].[EvaluationCriteria] 
	add CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id]) ON DELETE CASCADE

	alter table [RH].[ExternalTrainerSkills]
	add   CONSTRAINT [FK_ExternalTrainerSkills_ExternalTrainer] FOREIGN KEY ([IdExternalTrainer]) REFERENCES [RH].[ExternalTrainer] ([Id]),
    CONSTRAINT [FK_ExternalTrainerSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])

	alter TABLE [RH].[ExternalTraining]
	add 
	  CONSTRAINT [FK_ExternalTraining_ExternalTrainer] FOREIGN KEY ([IdExternalTrainer]) REFERENCES [RH].[ExternalTrainer] ([Id]),
    CONSTRAINT [FK_ExternalTraining_TrainingCenterRoom] FOREIGN KEY ([IdTrainingCenterRoom]) REFERENCES [RH].[TrainingCenterRoom] ([Id]),
    CONSTRAINT [FK_ExternalTraining_TrainingSession] FOREIGN KEY ([IdTrainingSession]) REFERENCES [RH].[TrainingSession] ([Id])

	alter table [RH].[FileDrive]
	add CONSTRAINT [FK_FileDrive_FileDrive] FOREIGN KEY ([IdParent]) REFERENCES [RH].[FileDrive] ([Id]),
    CONSTRAINT [FK_FileDrive_User] FOREIGN KEY ([CreatedBy]) REFERENCES [ERPSettings].[User] ([Id])

	alter table  [RH].[FileDriveSharedDocument]
	add  CONSTRAINT [FK_FileDriveSharedDocument_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_FileDriveSharedDocument_User] FOREIGN KEY ([TransactionUserId]) REFERENCES [ERPSettings].[User] ([Id])

	alter table  [RH].[MobilityRequest] 

	add    CONSTRAINT [FK_MobilityOffice_CurrentOffice] FOREIGN KEY ([IdCurrentOffice]) REFERENCES [Shared].[Office] ([Id]),
    CONSTRAINT [FK_MobilityOffice_DestinationOffice] FOREIGN KEY ([IdDestinationOffice]) REFERENCES [Shared].[Office] ([Id]),
    CONSTRAINT [FK_MobilityOffice_User] FOREIGN KEY ([IdCreationUser]) REFERENCES [ERPSettings].[User] ([Id]),
    CONSTRAINT [FK_MobilityRequest_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])


	alter table [RH].[Offer]
	add  CONSTRAINT [FK_Offer_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id])


	alter table [RH].[OfferBenefitInKind] add 
	   CONSTRAINT [FK_OfferBenefitInKind_BenefitInKind] FOREIGN KEY ([IdBenefitInKind]) REFERENCES [Payroll].[BenefitInKind] ([Id]),
    CONSTRAINT [FK_OfferBenefitInKind_Offer] FOREIGN KEY ([IdOffer]) REFERENCES [RH].[Offer] ([Id])


	alter table  [RH].[Project] 
	   add CONSTRAINT [FK_Project_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])

alter table [RH].[Recruitment]
 add CONSTRAINT [FK_Recruitment_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id]),
  CONSTRAINT [FK_Recruitment_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id])
  
alter table [RH].[RecruitmentLanguage]
   add CONSTRAINT [FK_RecruitmentLanguage_Language] FOREIGN KEY ([IdLanguage]) REFERENCES [Shared].[Language] ([Id]),
    CONSTRAINT [FK_RecruitmentLanguage_Recruitment] FOREIGN KEY ([IdRecruitment]) REFERENCES [RH].[Recruitment] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

	alter table [RH].[RecruitmentSkills]
   add CONSTRAINT [FK_RecruitmentSkills_Recruitment] FOREIGN KEY ([IdRecruitment]) REFERENCES [RH].[Recruitment] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_RecruitmentSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])


alter table [RH].[Review]
add CONSTRAINT [FK_Review_Manager] FOREIGN KEY ([IdManager]) REFERENCES [Payroll].[Employee] ([Id])

alter table [RH].[Training]
  add CONSTRAINT [FK_Training_Supplier] FOREIGN KEY ([IdSupplier]) REFERENCES [Sales].[Tiers] ([Id])

alter table [RH].[TrainingByEmployee]

 add CONSTRAINT [FK_TrainngByEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_TrainngByEmployee_Training] FOREIGN KEY ([IdTraining]) REFERENCES [RH].[Training] ([Id]) ON DELETE CASCADE

alter TABLE [RH].[TrainingCenter]
  add  CONSTRAINT [FK_TrainingCenter_TrainingCenterManager] FOREIGN KEY ([IdTrainingCenterManager]) REFERENCES [RH].[TrainingCenterManager] ([Id])

  alter table [RH].[TrainingCenterRoom]
  add  CONSTRAINT [FK_TrainingCenterRoom_TrainingCenter] FOREIGN KEY ([IdTrainingCenter]) REFERENCES [RH].[TrainingCenter] ([Id])

  alter TABLE [RH].[TrainingExpectedSkills]
  add  CONSTRAINT [FK_TrainingExcpectedSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id]),
    CONSTRAINT [FK_TrainingExpectedSkills_Training] FOREIGN KEY ([IdTraining]) REFERENCES [RH].[Training] ([Id]) ON DELETE CASCADE

alter table [RH].[TrainingRequest]
 add CONSTRAINT [FK_TrainingRequest_Author] FOREIGN KEY ([IdEmployeeAuthor]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_TrainingRequest_Collaborator] FOREIGN KEY ([IdEmployeeCollaborator]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_TrainingRequest_Training] FOREIGN KEY ([IdTraining]) REFERENCES [RH].[Training] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_TrainingRequest_TrainingSession] FOREIGN KEY ([IdTrainingSession]) REFERENCES [RH].[TrainingSession] ([Id])

alter table[RH].[TrainingRequiredSkills] 
add CONSTRAINT [FK_TrainingRequiredSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id]),
    CONSTRAINT [FK_TrainingRequiredSkills_Training] FOREIGN KEY ([IdTraining]) REFERENCES [RH].[Training] ([Id]) ON DELETE CASCADE

alter table [RH].[TrainingSeance]
add CONSTRAINT [FK_TrainingSeance_TrainingSession] FOREIGN KEY ([IdTrainingSession]) REFERENCES [RH].[TrainingSession] ([Id]) ON DELETE CASCADE

alter table [RH].[TrainingSession]
  add CONSTRAINT [FK_TrainingSession_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_TrainingSession_ExternalTrainer] FOREIGN KEY ([IdExternalTrainer]) REFERENCES [RH].[ExternalTrainer] ([Id]),
    CONSTRAINT [FK_TrainingSession_Training] FOREIGN KEY ([IdTraining]) REFERENCES [RH].[Training] ([Id])

alter table [RH].[UserFileAccess]
	add  CONSTRAINT [FK_UserFileAccess_FileDrive] FOREIGN KEY ([IdFile]) REFERENCES [RH].[FileDrive] ([Id]),
    CONSTRAINT [FK_UserFileAccess_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])

	alter table[RH].[UserFileModification]
	 add CONSTRAINT [FK_UserFileModification_FileDrive] FOREIGN KEY ([IdFile]) REFERENCES [RH].[FileDrive] ([Id]),
    CONSTRAINT [FK_UserFileModification_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])

	alter table [Sales].[BillingEmployee]
	add   CONSTRAINT [FK_BillingEmployee_BillingSession] FOREIGN KEY ([IdBillingSession]) REFERENCES [Sales].[BillingSession] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_BillingEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_BillingEmployee_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]),
    CONSTRAINT [FK_BillingEmployee_TimeSheet] FOREIGN KEY ([IdTimeSheet]) REFERENCES [RH].[TimeSheet] ([Id])



	alter table [Sales].[BillingSession]
	add   [Number]            INT            NOT NULL

	alter table [Sales].[Tiers]
	add
	[Email]                    NVARCHAR (255) NULL,
    [Phone]                    NVARCHAR (255) NULL,
    [Fax]                      NVARCHAR (255) NULL,
    [Linkedin]                 NVARCHAR (255) NULL,
    [Facebook]                 NVARCHAR (255) NULL,
    [Twitter]                  NVARCHAR (255) NULL,
    [Description]              NVARCHAR (255) NULL,
    [MapLocalisation]          NVARCHAR (255) NULL,
    [UrlPicture]               NVARCHAR (255) NULL

	alter table [Sales].[Tiers] 
	add CONSTRAINT [FK_Tiers_Address] FOREIGN KEY ([Id]) REFERENCES [Sales].[Tiers] ([Id])


	alter table[Shared].[Contact]
	add   [HomePhone]          NVARCHAR (255) NULL,
    [OtherPhone]         NVARCHAR (255) NULL,
    [AssistantPhone]     NVARCHAR (255) NULL,
    [AssistantName]      NVARCHAR (255) NULL,
    [Linkedin]           NVARCHAR (255) NULL,
    [Facebook]           NVARCHAR (255) NULL,
    [Twitter]            NVARCHAR (255) NULL,
    [UrlPicture]         NVARCHAR (255) NULL,
    [ContactType]        NVARCHAR (255) NULL,
    [Prefix]             NVARCHAR (255) NULL,
    [Classification]     NVARCHAR (255) NULL,
    [MapLocation]        NVARCHAR (255) NULL,
    [DateOfBirth]        DATETIME2 (7)  NULL,
    [Description]        NVARCHAR (255) NULL,
    [IdAddress]          INT            NULL,
	   CONSTRAINT [FK_Contact_Address] FOREIGN KEY ([IdAddress]) REFERENCES [Shared].[Address] ([Id])


alter table [Shared].[DateToRemember]
add   CONSTRAINT [FK_DateToRemember_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]),
    CONSTRAINT [FK_DateToRemember_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])


alter table [Shared].[Office]
add  CONSTRAINT [FK_Office_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]),
    CONSTRAINT [FK_Office_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]),
    CONSTRAINT [FK_Office_Employee] FOREIGN KEY ([IdOfficeManager]) REFERENCES [Payroll].[Employee] ([Id])

	
alter table  [Shared].[Address]

add CONSTRAINT [FK_Adress_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])

alter table [RH].[Objective] 
alter Column [Label] NVARCHAR (MAX) NOT NULL

alter table [RH].[Objective] 
alter Column [DescriptionCollaborator]     NVARCHAR (MAX) NULL

alter table [RH].[Objective] 
alter Column [DescriptionManager]          NVARCHAR (MAX) NULL

alter table  [RH].[InterviewType] 
alter Column  [Label]             NVARCHAR (50)  NOT NULL

alter table [RH].[InterviewType] 
add [Description]       NVARCHAR (250)  NULL

alter table [RH].[Interview]
alter Column [IdCandidacy]       INT            NULL

alter table [RH].[Interview]
add   [IdReview]          INT            NULL,
 [IdSupervisor]      INT            NULL,
    [IdEmployeeExit]    INT            NULL,
	CONSTRAINT [FK_Interview_Employee] FOREIGN KEY ([IdSupervisor]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_Interview_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]),
	CONSTRAINT [FK_Interview_Review] FOREIGN KEY ([IdReview]) REFERENCES [RH].[Review] ([Id])

alter table [RH].[InterviewType]
drop column [Code]

alter table [ERPSettings].[Traceability] 
drop [FK_Traceability_User]


alter table [ERPSettings].[Traceability] 
   add CONSTRAINT [FK_Traceability_User] FOREIGN KEY ([TransactionUserId]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE


 alter table  [Shared].[Company]

 add [TimeSheetPerHalfDay]    BIT            CONSTRAINT [DF_Company_TimeSheetPerHalfDay] DEFAULT ((1)) NOT NULL,
    [Category]               NVARCHAR (255) NULL,
    [SecondaryEstablishment] NVARCHAR (255) NULL,
    [PayDependOnTimesheet]   BIT            CONSTRAINT [DF_Company_PayDependOnPeriod] DEFAULT ((0)) NOT NULL,
    [DaysOfWork]             FLOAT (53)     NULL

	 alter table  [Shared].[Company] 
	 drop column [IdDaysOfWork]

	 alter table [Shared].[Company] 
	 drop column [AmputationPerHour]

	  alter table [Shared].[Company] 
	 drop column [TimeInterval]

	 alter table [Shared].[Office] 
	 drop column [CreationDate]

	 alter table [Shared].[Office]
	  drop column [TransactionUserId]

	  alter table  [Shared].[Office]
	  add [CreationDate]      DATETIME       CONSTRAINT [DF_Office_CreationDate] DEFAULT (getdate()) NOT NULL

	  alter table  [Shared].[Office]
	  add [TransactionUserId] INT            CONSTRAINT [DF_Office_TransactionUserId] DEFAULT ((0)) NOT NULL


	  alter table [Payroll].[ContractType]
	  alter column [Code]               NVARCHAR (255) NOT NULL

	  delete from [Payroll].[SalaryStructureSalaryRule]

	  alter table [Payroll].[SalaryStructureSalaryRule] alter column [IdSalaryStructure] INT            NOT NULL
	  alter table [Payroll].[SalaryStructureSalaryRule] alter column [IdSalaryRule]      INT            NOT NULL
	  
    alter table [RH].[EmployeeProject]
drop DF_EmployeeProject_AssignmentDate

alter table [RH].[EmployeeProject]
drop column  [AssignmentDate]        

alter table [RH].[EmployeeProject]
add  [AssignmentDate]       DATE           CONSTRAINT [DF_EmployeeProject_AssignmentDate] DEFAULT (getdate()) NOT NULL
  
delete from [RH].[InterviewType]

 alter table [RH].[InterviewType]
alter column  [Description]       NVARCHAR (250) NOT NULL



DROP TABLE [Payroll].[IdentityPieces]

DROP TABLE [Payroll].[TypeIdentityPieces]

DROP TABLE Payroll.CommercialsCustomerContract

DROP TABLE Payroll.ConsultantsCustomerContract

Drop Table RH.ReviewInterviewer

Drop table Payroll.MaritalStatus

ALTER TABLE [RH].[Question] DROP CONSTRAINT [FK_Question_Review];

ALTER TABLE  [RH].[Question] Drop column [IdReview];

ALTER TABLE  [RH].[Question] add [IdInterview] int not null;

ALTER TABLE [RH].[Question] WITH NOCHECK
    ADD CONSTRAINT [FK_Question_Interview] FOREIGN KEY ([IdInterview]) REFERENCES [RH].[Interview] ([Id]);


GO
ALTER TABLE [ERPSettings].[User]
    ADD [IsActif] BIT NOT NULL  DEFAULT ('true');

GO
ALTER TABLE [Payroll].[ContractType]
    ADD [HasEndDate] BIT NOT NULL  DEFAULT ('false');


ALTER TABLE [RH].[Candidate]
    ADD [Code] NVARCHAR (50) NULL;


CREATE TABLE [Payroll].[LoanInstallment] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (255) NULL,
    [RepaymentDate]     DATE           NOT NULL,
    [State]             INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_LoanInstallment] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

ALTER TABLE [Payroll].[Loan] ADD  [DisbursementDate]  DATE           NULL, 
								  [ApprouvementDate]  DATE           NULL,
								  [Amount]            FLOAT (53)     NOT NULL,
								  [ObtainingDate]     DATE           NOT NULL,
								  [IdEmployee]        INT            NOT NULL,
								  [Reason]            NVARCHAR (500) NULL

	ALTER TABLE [Payroll].[Loan] WITH NOCHECK
    ADD CONSTRAINT [FK_Loan_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


ALTER TABLE [Payroll].[Leave] DROP COLUMN [Period]

ALTER TABLE [Payroll].[Leave] ADD [CreationDate] datetime NOT NULL 

ALTER TABLE [Payroll].[LeaveBalanceRemaining] DROP COLUMN [RemainingBalance]

ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [RemainingBalanceDay] float NULL 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [RemainingBalanceHour] float NULL 


GO
ALTER TABLE [Payroll].[BenefitInKind]
    ADD [IsTaxable] BIT CONSTRAINT [DF_BenefitInKind_IsTaxable] DEFAULT ((0)) NOT NULL;


ALTER TABLE [Payroll].[Loan] ALTER COLUMN [Code] NVARCHAR (255) NULL;


ALTER TABLE Payroll.Payslip ADD ErrorMessage nvarchar(MAX) NULL



ALTER TABLE [RH].[Review]
    ADD [FormManager]  INT NULL,
        [FormEmployee] INT NULL;

Alter table [Sales].[SaleSettings]
ADD [AllowEditionItemDesignation] BIT NOT NULL DEFAULT ((0));


ALTER TABLE Payroll.Attendance ADD MaxNumberOfDaysAllowed FLOAT NOT NULL

ALTER TABLE Payroll.Payslip DROP COLUMN NumberDaysWorked
ALTER TABLE Payroll.Payslip DROP COLUMN NumberDaysLeaveTaken
ALTER TABLE Payroll.Payslip DROP COLUMN NumberDaysNonPaidLeaveTaken


ALTER TABLE Payroll.Session ADD DependOnTimesheet bit NOT NULL Default(0)

ALTER TABLE Payroll.Session ADD DaysOfWork float NOT NULL Default(26)

		

EXEC sp_rename 'ERPSettings.DiscussionChat.nbMember', 'NumberOfDiscussionMember', 'COLUMN';

EXEC sp_rename 'ERPSettings.DiscussionChat', 'Discussion';


ALTER TABLE [ERPSettings].[ReportTemplate] ADD  [ReportCode] [nvarchar](255) NULL,
												[ReportName] [nvarchar](255) NULL

ALTER TABLE [Payroll].[Attendance] ADD [StartDate] DATETIME NULL,
									   [EndDate]   DATETIME NULL;

												

GO
ALTER TABLE [RH].[Interview]
    ADD [IdCreator] INT NULL;

GO
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_Creator] FOREIGN KEY ([IdCreator]) REFERENCES [Payroll].[Employee] ([Id]);

GO
ALTER TABLE [Inventory].[StockDocument]
    ADD [isDefaultValue]          BIT NULL,
        [isOnlyAvailableQuantity] BIT NULL;

ALTER TABLE [RH].[EmployeeProject] ADD CompanyCode NVARCHAR(50);


ALTER TABLE [Payroll].[ContractBenefitInKind] ALTER COLUMN [Value] FLOAT (53) NOT NULL;

ALTER TABLE [Payroll].[PayslipDetails]
    ADD [IdBenefitInKind] INT NULL;

ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_BenefitInKind] FOREIGN KEY ([IdBenefitInKind]) REFERENCES [Payroll].[BenefitInKind] ([Id]);


GO
ALTER TABLE [Payroll].[SalaryStructure]
    ADD [Description] NVARCHAR (255) NULL;


GO
PRINT N'Création de [Payroll].[SalaryStructureValidityPeriod]...';


GO
CREATE TABLE [Payroll].[SalaryStructureValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [IdSalaryStructure] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [TransactionUserId] INT            NULL,
    CONSTRAINT [PK_SalaryStructureValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[SalaryStructureValidityPeriodSalaryRule]...';


GO
CREATE TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] (
    [Id]                              INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]                       BIT            NOT NULL,
    [TransactionUserId]               INT            NULL,
    [Deleted_Token]                   NVARCHAR (255) NULL,
    [IdSalaryRule]                    INT            NOT NULL,
    [IdSalaryStructureValidityPeriod] INT            NOT NULL,
    CONSTRAINT [PK_SalaryStructureValidityPeriodSalaryRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[FK_SalaryStructureValidityPeriod_SalaryStructure]...';


GO
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_SalaryStructureValidityPeriodSalaryRule_SalaryRule]...';


GO
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod]...';


GO
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod] FOREIGN KEY ([IdSalaryStructureValidityPeriod]) REFERENCES [Payroll].[SalaryStructureValidityPeriod] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';



GO
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure];

ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryRule];

ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod];


GO
PRINT N'Mise à jour terminée.';


	alter table [RH].[CurriculumVitae] 
	drop  CONSTRAINT [FK_CV_Candidate] 

	alter table [RH].[CurriculumVitae] 
	 add  CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id]) ON DELETE CASCADE


	 alter  table [RH].[EvaluationCriteria] 
	drop CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme]

	alter  table [RH].[EvaluationCriteria] 
	add CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id]) ON DELETE CASCADE

	alter table [RH].[CurriculumVitae] 
	drop  CONSTRAINT [FK_CV_Candidate] 

	alter table [RH].[CurriculumVitae] 
	 add  CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id]) ON DELETE CASCADE

	 alter table [RH].[EmployeeProject]
  drop    CONSTRAINT [FK_EmployeeProject_Project] 

  alter table [RH].[EmployeeProject]
  add       CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]) ON DELETE CASCADE

	alter  table [RH].[EvaluationCriteria] 
	drop CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme]

	alter  table [RH].[EvaluationCriteria] 
	add CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id]) ON DELETE CASCADE


	ALTER TABLE [Payroll].[Loan]
    ADD [LoanAttachementFile] NVARCHAR (500) NULL;


	drop table Payroll.[SalaryStructureSalaryRule]
GO
ALTER TABLE [RH].[Interview]
    ADD [Token] NVARCHAR (255) NULL;


ALTER TABLE [Payroll].[Loan] ADD  [MonthsNumber]        INT            NOT NULL, 
								  [RefundStartDate]     DATE           NULL


ALTER TABLE [Payroll].[LoanInstallment] DROP COLUMN [Code];
ALTER TABLE [Payroll].[LoanInstallment] DROP COLUMN [RepaymentDate];

ALTER TABLE [Payroll].[LoanInstallment] ADD  [Date]              DATE           NOT NULL,
											 [Amount]            FLOAT (53)     NOT NULL,
											 [IdLoan]            INT            NOT NULL,
											 CONSTRAINT [FK_LoanInstallment_Loan] FOREIGN KEY ([IdLoan]) REFERENCES [Payroll].[Loan] ([Id]) ON DELETE CASCADE


ALTER TABLE [Payroll].[PayslipDetails] ADD   [IdLoan]            INT            NULL,
											 CONSTRAINT [FK_PayslipDetails_Loan] FOREIGN KEY ([IdLoan]) REFERENCES [Payroll].[Loan] ([Id])

GO
ALTER TABLE [RH].[Offer]
    ADD [Token] NVARCHAR (255) NULL;

ALTER TABLE Payroll.Payslip Drop Column StartDate

ALTER TABLE Payroll.Payslip Drop Column EndDate

ALTER TABLE Payroll.Payslip ADD Month DATE NOT NULL



ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] DROP CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule];

ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference];

ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] DROP CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule];

ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] DROP CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure];

ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] DROP CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod];

ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique];

ALTER TABLE [Payroll].[VariableValidityPeriod] DROP CONSTRAINT [FK_VariableValidityPeriod_Variable];

ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);

ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod] FOREIGN KEY ([IdSalaryStructureValidityPeriod]) REFERENCES [Payroll].[SalaryStructureValidityPeriod] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[Variable] WITH NOCHECK
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[VariableValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY ([IdVariable]) REFERENCES [Payroll].[Variable] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_Company];
ALTER TABLE [Shared].[BankAccount] DROP COLUMN [IdCompany];


CREATE TABLE [Payroll].[SessionContract] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SessionContract] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [Payroll].[SessionContract] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionContract_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[SessionContract] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionContract_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);

ALTER TABLE [Payroll].[SessionContract] WITH CHECK CHECK CONSTRAINT [FK_SessionContract_Session];

ALTER TABLE [Payroll].[SessionContract] WITH CHECK CHECK CONSTRAINT [FK_SessionContract_Contract];


ALTER TABLE [Payroll].[SessionEmployee] DROP CONSTRAINT [FK_SessionEmployee_Session];

ALTER TABLE [Payroll].[SessionEmployee] DROP CONSTRAINT [FK_SessionEmployee_Employee];

DROP TABLE [Payroll].[SessionEmployee];


ALTER TABLE Payroll.SourceDeduction DROP COLUMN StartDate, EndDate

ALTER TABLE Payroll.SourceDeductionSession DROP COLUMN StartDate, EndDate

ALTER TABLE [Payroll].[Loan] ADD  [CreditType] INT NULL

ALTER TABLE [Payroll].[BenefitInKind] DROP COLUMN [Type];


ALTER TABLE Administration.Currency DROP COLUMN [PurchasePrecision]


GO  
EXEC sp_rename 'Administration.Currency.SalePrecision', 'Precision', 'COLUMN';
GO
CREATE TABLE [Payroll].[ExitEmployeeLeaveLine] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Details]            NVARCHAR (MAX) NULL,
    [Month]              DATE           NULL,
    [IdEmployeeExit]     INT            NULL,
    [DayTakenPerMonth]   NVARCHAR (MAX) NULL,
    [TotalTakenPerMonth] FLOAT (53)     NULL,
    [AcquiredParMonth]   INT            NULL,
    [IdLeaveType]        INT            NULL,
    CONSTRAINT [PK_ExitEmployeeLeaveLine] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]);
GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmployeeLeaveLine_LeaveType] FOREIGN KEY ([IdLeaveType]) REFERENCES [Payroll].[LeaveType] ([Id]);

GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] WITH CHECK CHECK CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit];

ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] WITH CHECK CHECK CONSTRAINT [FK_ExitEmployeeLeaveLine_LeaveType];

GO
ALTER TABLE [Payroll].[EmployeeExit]
    ADD [StateLeave] INT NULL;



	-- Imen chaaben: Add [Sales].[DocumentWithholdingTax]
GO
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [FK_WithholdingTax_Tiers];	
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [DF_WithholdingTax_StateFlag];	

Go 
ALTER TABLE [Payment].[WithholdingTax]
DROP    COLUMN  [CodeWithHolding],
	    COLUMN  [Description],
		COLUMN	[Rate],
		COLUMN	[TotalHoldingPrice],
		COLUMN  [TotalTTCPrice],
		COLUMN	[TotalNetAmount],
		COLUMN	[Date],
		COLUMN	[IdTiers],
		COLUMN	[StateFlag],
		COLUMN	[WithholdingTax_int_1],
		COLUMN	[WithholdingTax_int_2],
		COLUMN	[WithholdingTax_int_3],
		COLUMN 	[WithholdingTax_int_4],
		COLUMN 	[WithholdingTax_int_5],
		COLUMN 	[WithholdingTax_int_6],
		COLUMN 	[WithholdingTax_int_7],
		COLUMN 	[WithholdingTax_int_8],
		COLUMN 	[WithholdingTax_int_9],
		COLUMN 	[WithholdingTax_int_10],
		COLUMN 	[WithholdingTax_bit_1],
		COLUMN 	[WithholdingTax_bit_2],
		COLUMN 	[WithholdingTax_bit_3],
		COLUMN 	[WithholdingTax_bit_4],
		COLUMN 	[WithholdingTax_bit_5],
		COLUMN 	[WithholdingTax_bit_6],
		COLUMN 	[WithholdingTax_bit_7],
		COLUMN 	[WithholdingTax_bit_8],
		COLUMN 	[WithholdingTax_bit_9],
		COLUMN 	[WithholdingTax_bit_10],
		COLUMN 	[WithholdingTax_float_1],
		COLUMN 	[WithholdingTax_float_2],
		COLUMN 	[WithholdingTax_float_3],
		COLUMN 	[WithholdingTax_float_4],
		COLUMN 	[WithholdingTax_float_5],
		COLUMN 	[WithholdingTax_float_6],
		COLUMN 	[WithholdingTax_float_7],
		COLUMN 	[WithholdingTax_float_8],
		COLUMN 	[WithholdingTax_float_9],
		COLUMN 	[WithholdingTax_float_10],
		COLUMN 	[WithholdingTax_varchar_1],
		COLUMN 	[WithholdingTax_varchar_2],
		COLUMN 	[WithholdingTax_varchar_3],
		COLUMN 	[WithholdingTax_varchar_4],
		COLUMN 	[WithholdingTax_varchar_5],
		COLUMN 	[WithholdingTax_varchar_6],
		COLUMN 	[WithholdingTax_varchar_7],
		COLUMN 	[WithholdingTax_varchar_8],
		COLUMN 	[WithholdingTax_varchar_9],
		COLUMN 	[WithholdingTax_varchar_10],
		COLUMN 	[WithholdingTax_date_1],
		COLUMN 	[WithholdingTax_date_2],
		COLUMN 	[WithholdingTax_date_3],
		COLUMN 	[WithholdingTax_date_4],
		COLUMN 	[WithholdingTax_date_5],
		COLUMN 	[WithholdingTax_date_6],
		COLUMN 	[WithholdingTax_date_7],
		COLUMN 	[WithholdingTax_date_8],
		COLUMN 	[WithholdingTax_date_9],
		COLUMN 	[WithholdingTax_date_10];
GO
ALTER TABLE [Payment].[WithholdingTax]
ADD  [Code]              NVARCHAR (50)  NULL,
     [Designation]       NVARCHAR (50)  NULL,
     [Percentage]        FLOAT (53)     NOT NULL;
	
GO
PRINT N'Création de [Sales].[DocumentWithholdingTax]...';

GO
CREATE TABLE [Sales].[DocumentWithholdingTax] (
    [Id]                         INT            IDENTITY (1, 1) NOT NULL,
    [IdDocument]                 INT            NOT NULL,
    [IdWithholdingTax]           INT            NOT NULL,
    [AmountWithCurrency]         FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_AmountWithCurrency] DEFAULT ((0)) NOT NULL,
    [Amount]                     FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_Amount] DEFAULT ((0)) NOT NULL,
    [WithholdingTaxWithCurrency] FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_WithholdingTaxWithCurrency] DEFAULT ((0)) NOT NULL,
    [WithholdingTax]             FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_withholdingTax] DEFAULT ((0)) NOT NULL,
    [IsDeleted]                  BIT            NOT NULL,
    [TransactionUserId]          INT            NULL,
    [Deleted_Token]              NVARCHAR (255) NULL,
    CONSTRAINT [PK_DocumentWithholdingTax] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Sales].[DocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentWithholdingTax_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]);
GO
ALTER TABLE [Sales].[DocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentWithholdingTax_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id]);

--- kossi add colum label WithholdingTaxAttachmentUrl to settlement table
ALTER TABLE [Payment].[Settlement] 
    ADD [WithholdingTaxAttachmentUrl] NVARCHAR (MAX) NULL

GO
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Agence] NVARCHAR (250) NOT NULL;

 


GO
ALTER TABLE [Shared].[BankAccount]
    ADD [Entitled]    NVARCHAR (50) NOT NULL DEFAULT(' '),
        [Email]       NVARCHAR (50) NULL,
        [Telephone]   INT           NULL,
        [Fax]         INT           NULL,
        [Pic]         VARCHAR (50)  NULL,
        [TypeAccount] INT           NULL,
        [IdCountry]   INT           NULL,
        [IdCity]      INT           NULL,
        [ZipCode]     NVARCHAR (50) NULL,
        [IdCurrency]  INT           NOT NULL DEFAULT(2);

GO

ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]);


GO
ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

 

GO
ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]);

--- Imen chaaben: change Financial commtment properties for withholding Tax
GO
ALTER TABLE [Sales].[FinancialCommitment]
ADD  [WithholdingTaxWithCurrency]   float   NULL,
     [WithholdingTax]   float   NULL,
     [RemainingWithholdingTax]   float   NULL,
     [RemainingWithholdingTaxWithCurrency]   float   NULL,
     [AmountWithoutWithholdingTax]   float   NULL,
     [AmountWithoutWithholdingTaxWithCurrency]   float   NULL;


alter table  [Sales].[FinancialCommitment] drop CONSTRAINT [DF_FinancialCommitment_WithholdingTaxHasBeenToken]
ALTER TABLE [Sales].[FinancialCommitment] DROP COLUMN [WithholdingTaxHasBeenToken];


--- Youssef maaloul : delete and change reflectiveSettlement properties
GO
ALTER TABLE [Payment].[ReflectiveSettlement]
drop column  [AssignedAmount],[AssignedAmountWithCurrency],[ExchangeRate];
	 
GO
sp_rename 'Payment.ReflectiveSettlement.IdSettlementReplaced', 'IdGapSettlement', 'COLUMN';

--- Imen Chaaben: [SettlementCommitment] --
GO
ALTER TABLE [Payment].[Settlement] DROP COLUMN [Note];

GO
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [DF_SettlementCommitment_RemplacedBy];
ALTER TABLE [Payment].[SettlementCommitment] DROP COLUMN [RemplacedBy];

ALTER TABLE [Payment].[SettlementCommitment]
        ADD [AssignedWithholdingTax]   float    NULL,
		    [AssignedWithholdingTaxWithCurrency]   float  NULL;



--- Imen Chaaben: Add [SettlementDocumentWithholdingTax] table and [RemainingWithholdingTax] column to [DocumentWithholdingTax]
GO
CREATE TABLE [Payment].[SettlementDocumentWithholdingTax] (
    [Id]                                 INT            IDENTITY (1, 1) NOT NULL,
    [IdSettlement]                       INT            NOT NULL,
    [IdDocumentWithholdingTax]           INT            NOT NULL,
    [AssignedWithholdingTax]             FLOAT (53)     NULL,
    [AssignedWithholdingTaxWithCurrency] FLOAT (53)     NOT NULL,
    [IsDeleted]                          BIT            NOT NULL,
    [Deleted_Token]                      NVARCHAR (255) NULL,
    CONSTRAINT [PK_SettlementDocumentWithholdingTax] PRIMARY KEY CLUSTERED ([Id] ASC)
);

Go 
ALTER TABLE [Sales].[DocumentWithholdingTax]
    Add [RemainingWithholdingTaxWithCurrency] FLOAT (53)     NULL,
        [RemainingWithholdingTax]             FLOAT (53)     NULL;

--- Imen Chaaben: Add totalAmount to SettlementDocumentWithholdingTax
Go 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax]
    Add     [TotalAmount]    FLOAT (53)  NULL,
            [TotalAmountWithCurrency]    FLOAT (53) NOT NULL;
	
	
GO
ALTER TABLE [Shared].[BankAccount]
	DROP COLUMN [BankAccount_bit_1], 
	COLUMN [BankAccount_bit_10], COLUMN [BankAccount_bit_2], 
	COLUMN [BankAccount_bit_3], COLUMN [BankAccount_bit_4], 
	COLUMN [BankAccount_bit_5], COLUMN [BankAccount_bit_6], 
	COLUMN [BankAccount_bit_7], COLUMN [BankAccount_bit_8], 
	COLUMN [BankAccount_bit_9], COLUMN [BankAccount_date_1], 
	COLUMN [BankAccount_date_10], COLUMN [BankAccount_date_2], 
	COLUMN [BankAccount_date_3], COLUMN [BankAccount_date_4], 
	COLUMN [BankAccount_date_5], COLUMN [BankAccount_date_6], 
	COLUMN [BankAccount_date_7], COLUMN [BankAccount_date_8], 
	COLUMN [BankAccount_date_9], COLUMN [BankAccount_float_1], 
	COLUMN [BankAccount_float_10], COLUMN [BankAccount_float_2], 
	COLUMN [BankAccount_float_3], COLUMN [BankAccount_float_4], 
	COLUMN [BankAccount_float_5], COLUMN [BankAccount_float_6], 
	COLUMN [BankAccount_float_7], COLUMN [BankAccount_float_8], 
	COLUMN [BankAccount_float_9], COLUMN [BankAccount_int_1], 
	COLUMN [BankAccount_int_10], COLUMN [BankAccount_int_2], 
	COLUMN [BankAccount_int_3], COLUMN [BankAccount_int_4], 
	COLUMN [BankAccount_int_5], COLUMN [BankAccount_int_6], 
	COLUMN [BankAccount_int_7], COLUMN [BankAccount_int_8], 
	COLUMN [BankAccount_int_9], COLUMN [BankAccount_varchar_1], 
	COLUMN [BankAccount_varchar_10], COLUMN [BankAccount_varchar_2], 
	COLUMN [BankAccount_varchar_3], COLUMN [BankAccount_varchar_4], 
	COLUMN [BankAccount_varchar_5], COLUMN [BankAccount_varchar_6], 
	COLUMN [BankAccount_varchar_7], COLUMN [BankAccount_varchar_8], 
	COLUMN [BankAccount_varchar_9];

GO
ALTER TABLE [Treasury].[Reconciliation]
	DROP COLUMN [IdReconciliationAxis_1], COLUMN [IdReconciliationAxis_10], 
	COLUMN [IdReconciliationAxis_11], COLUMN [IdReconciliationAxis_12], 
	COLUMN [IdReconciliationAxis_13], COLUMN [IdReconciliationAxis_14], 
	COLUMN [IdReconciliationAxis_15], COLUMN [IdReconciliationAxis_16], 
	COLUMN [IdReconciliationAxis_17], COLUMN [IdReconciliationAxis_18], 
	COLUMN [IdReconciliationAxis_19], COLUMN [IdReconciliationAxis_2], 
	COLUMN [IdReconciliationAxis_20], COLUMN [IdReconciliationAxis_21], 
	COLUMN [IdReconciliationAxis_22], COLUMN [IdReconciliationAxis_23],
	COLUMN [IdReconciliationAxis_24], COLUMN [IdReconciliationAxis_25], 
	COLUMN [IdReconciliationAxis_26], COLUMN [IdReconciliationAxis_27], 
	COLUMN [IdReconciliationAxis_28], COLUMN [IdReconciliationAxis_29], 
	COLUMN [IdReconciliationAxis_3], COLUMN [IdReconciliationAxis_30], 
	COLUMN [IdReconciliationAxis_4], COLUMN [IdReconciliationAxis_5],
	COLUMN [IdReconciliationAxis_6], COLUMN [IdReconciliationAxis_7], 
	COLUMN [IdReconciliationAxis_8], COLUMN [IdReconciliationAxis_9];

GO
ALTER TABLE [Treasury].[Reconciliation]
    ADD [AttachmentUrl] NVARCHAR (MAX) NULL;

	ALTER TABLE [Treasury].[DetailReconciliation] 
	DROP COLUMN [IdDetailReconciliationAxis_1], COLUMN [IdDetailReconciliationAxis_10],
	COLUMN [IdDetailReconciliationAxis_11], COLUMN [IdDetailReconciliationAxis_12], 
	COLUMN [IdDetailReconciliationAxis_13], COLUMN [IdDetailReconciliationAxis_14], 
	COLUMN [IdDetailReconciliationAxis_15], COLUMN [IdDetailReconciliationAxis_16], 
	COLUMN [IdDetailReconciliationAxis_17], COLUMN [IdDetailReconciliationAxis_18], 
	COLUMN [IdDetailReconciliationAxis_19], COLUMN [IdDetailReconciliationAxis_2], 
	COLUMN [IdDetailReconciliationAxis_20], COLUMN [IdDetailReconciliationAxis_21], 
	COLUMN [IdDetailReconciliationAxis_22], COLUMN [IdDetailReconciliationAxis_23], 
	COLUMN [IdDetailReconciliationAxis_24], COLUMN [IdDetailReconciliationAxis_25],
	COLUMN [IdDetailReconciliationAxis_26], COLUMN [IdDetailReconciliationAxis_27], 
	COLUMN [IdDetailReconciliationAxis_28], COLUMN [IdDetailReconciliationAxis_29], 
	COLUMN [IdDetailReconciliationAxis_3], COLUMN [IdDetailReconciliationAxis_30], 
	COLUMN [IdDetailReconciliationAxis_4], COLUMN [IdDetailReconciliationAxis_5], 
	COLUMN [IdDetailReconciliationAxis_6], COLUMN [IdDetailReconciliationAxis_7], 
	COLUMN [IdDetailReconciliationAxis_8], COLUMN [IdDetailReconciliationAxis_9];

--- kossi alter table [Treasury].[Reconciliation] 14/07/2020
ALTER TABLE [Treasury].[Reconciliation]
    ADD CONSTRAINT [FK_Reconciliation_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);


--- Ghazoua add action table 08/07/2020
GO
CREATE TABLE [Payroll].[ActionExitEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (MAX) NULL,
    [IdEmployeeExit]    INT            NULL,
    [IdActions]         INT            NULL,
    [Verify_Action]     BIT            NULL,
    CONSTRAINT [PK_ActionExitEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
CREATE TABLE [Payroll].[Actions] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Label]             NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [Payroll].[ActionExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]);

GO
ALTER TABLE [Payroll].[ActionExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_Actions] FOREIGN KEY ([IdActions]) REFERENCES [Payroll].[Actions] ([Id]);
GO
ALTER TABLE [Payroll].[ActionExitEmployee] WITH CHECK CHECK CONSTRAINT [FK_ActionExitEmployee_EmployeeExit];

ALTER TABLE [Payroll].[ActionExitEmployee] WITH CHECK CHECK CONSTRAINT [FK_ActionExitEmployee_Actions];

GO
CREATE TABLE [Payroll].[ExitEmployeePayLine] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Details]           NVARCHAR (MAX) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Month]             INT            NULL,
    [NumberDayWorked]   FLOAT (53)     NULL,
    [IdEmployeeExit]    INT            NOT NULL,
    [Year]              INT            NULL,
    CONSTRAINT [PK_ExitEmployeePayLine] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
CREATE TABLE [Payroll].[LinesSalaryRule] (
    [Id]                    INT        IDENTITY (1, 1) NOT NULL,
    [IdSalaryRule]          INT        NULL,
    [IdExitEmployeePayLine] INT        NULL,
    [Value]                 FLOAT (53) NULL,
    CONSTRAINT [PK_LinesSalaryRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [Payroll].[ExitEmployeePayLine] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]);
GO
ALTER TABLE [Payroll].[LinesSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY ([IdExitEmployeePayLine]) REFERENCES [Payroll].[ExitEmployeePayLine] ([Id]);

GO
ALTER TABLE [Payroll].[LinesSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);
GO
ALTER TABLE [Payroll].[ExitEmployeePayLine] WITH CHECK CHECK CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit];

ALTER TABLE [Payroll].[LinesSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine];

ALTER TABLE [Payroll].[LinesSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_LinesSalaryRule_SalaryRule];


ALTER TABLE [Payroll].[Employee] ALTER COLUMN [Status] INT NULL;
ALTER TABLE [Payroll].[TransferOrder] DROP COLUMN [Number];
ALTER TABLE [Payroll].[TransferOrder]
    ADD [Code] NVARCHAR (50) NULL;

ALTER TABLE [Payroll].[Session] ADD Code NVARCHAR (50) NOT NULL DEFAULT (('0'));
ALTER TABLE [Payroll].[Session] DROP COLUMN Number;



ALTER TABLE [ERPSettings].[User]
DROP CONSTRAINT FK_User_Employee;

ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE [Payroll].[JobEmployee]
DROP CONSTRAINT FK_JobEmployee_Employee;

ALTER TABLE [Payroll].[JobEmployee] WITH NOCHECK ADD CONSTRAINT [FK_JobEmployee_Employee] FOREIGN KEY ([IdEmployee]) 
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE  [Payroll].[EmployeeExit]
DROP CONSTRAINT FK_EmployeeExit_Employee;

alter table [Payroll].[EmployeeExit]
WITH NOCHECK ADD CONSTRAINT [FK_EmployeeExit_Employee] FOREIGN KEY ([IdEmployee]) 
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE  [Payroll].[ActionExitEmployee]
DROP CONSTRAINT FK_ActionExitEmployee_EmployeeExit;
ALTER TABLE [Payroll].[ActionExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE  [Payroll].[EmployeeTeam] 
DROP CONSTRAINT FK_EmployeeTeam_Employee;
alter table [Payroll].[EmployeeTeam] 
add CONSTRAINT [FK_EmployeeTeam_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE [Payroll].[CnssDeclaration] ADD Code NVARCHAR (50) NOT NULL DEFAULT (('0'));
ALTER TABLE [Payroll].[CnssDeclaration] DROP COLUMN DeclarationNumber;

ALTER TABLE [Sales].[BillingSession] DROP COLUMN [Number], COLUMN [SessionNumber];
ALTER TABLE [Sales].[BillingSession] ADD [Code] NVARCHAR (50) NOT NULL DEFAULT (('0'));
CREATE TABLE [Payroll].[CnssDeclarationSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdCnssDeclaration] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_CnssDeclarationSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration] FOREIGN KEY ([IdCnssDeclaration]) REFERENCES [Payroll].[CnssDeclaration] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationSession_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration];
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationSession_Session];


EXEC sp_rename 'Shared.BankAccount.Agence', 'Agency', 'COLUMN';

ALTER TABLE [Shared].[Company]
    ADD [ActivityArea] [int] NOT NULL DEFAULT ((1));

	
GO
ALTER TABLE [Sales].[Tiers]
    ADD [ActivitySector] NVARCHAR (50) NULL,
        [LeadSource]     NVARCHAR (50) NULL;


GO
ALTER TABLE [Shared].[Address]
    ADD [PrincipalAddress] NVARCHAR (255) NULL,
        [Region]           NVARCHAR (50)  NULL;

	GO
ALTER TABLE [Payroll].[SourceDeductionSession]
    ADD [Code] NVARCHAR (50) NOT NULL;

	ALTER TABLE [Payroll].[SourceDeductionSession] DROP COLUMN [Number]


GO
ALTER TABLE [Shared].[Address]
    ADD [Label] NVARCHAR (50) NULL;

GO
ALTER TABLE [Shared].[Contact]
    ADD [Label] NVARCHAR (50) NULL;

CREATE TABLE [Shared].[Phone] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Number]            INT            NULL,
    [DialCode]          NCHAR (5)      NULL,
    [CountryCode]       NCHAR (10)     NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdContact]         INT            NULL,
    CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Phone_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])
);
GO

GO
ALTER TABLE [Shared].[Contact] DROP 
COLUMN [Contact_bit_1], COLUMN [Contact_bit_10], COLUMN [Contact_bit_2],
COLUMN [Contact_bit_3], COLUMN [Contact_bit_4], COLUMN [Contact_bit_5],
COLUMN [Contact_bit_6], COLUMN [Contact_bit_7], COLUMN [Contact_bit_8],
COLUMN [Contact_bit_9], COLUMN [Contact_date_1], COLUMN [Contact_date_10],
COLUMN [Contact_date_2], COLUMN [Contact_date_3], COLUMN [Contact_date_4],
COLUMN [Contact_date_5], COLUMN [Contact_date_6], COLUMN [Contact_date_7],
COLUMN [Contact_date_8], COLUMN [Contact_date_9], COLUMN [Contact_float_1],
COLUMN [Contact_float_10], COLUMN [Contact_float_2], COLUMN [Contact_float_3],
COLUMN [Contact_float_4], COLUMN [Contact_float_5], COLUMN [Contact_float_6],
COLUMN [Contact_float_7], COLUMN [Contact_float_8], COLUMN [Contact_float_9],
COLUMN [Contact_int_1], COLUMN [Contact_int_10], COLUMN [Contact_int_2],
COLUMN [Contact_int_3], COLUMN [Contact_int_4], COLUMN [Contact_int_5],
COLUMN [Contact_int_6], COLUMN [Contact_int_7], COLUMN [Contact_int_8],
COLUMN [Contact_int_9], COLUMN [Contact_varchar_1], COLUMN [Contact_varchar_10],
COLUMN [Contact_varchar_2], COLUMN [Contact_varchar_3], COLUMN [Contact_varchar_4],
COLUMN [Contact_varchar_5], COLUMN [Contact_varchar_6], COLUMN [Contact_varchar_7],
COLUMN [Contact_varchar_8], COLUMN [Contact_varchar_9];




ALTER TABLE [Sales].[Document] 
ALTER COLUMN Reference NVARCHAR (MAX) NULL;

ALTER TABLE [ERPSettings].[UserPrivilege] DROP CONSTRAINT [FK_UserPrivilege_User];

ALTER TABLE [ERPSettings].[UserPrivilege] WITH NOCHECK
    ADD CONSTRAINT [FK_UserPrivilege_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE;
ALTER TABLE [ERPSettings].[UserPrivilege] WITH CHECK CHECK CONSTRAINT [FK_UserPrivilege_User];

GO
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [DF__Item__HaveClaims__1DD065E0];
ALTER TABLE [Inventory].[Item]
    ADD DEFAULT ((0)) FOR [HaveClaims];


	ALTER TABLE [Inventory].[Item]
ADD [UrlPicture] NVARCHAR (255) NULL


ALTER TABLE [Payment].[PaymentSlip] DROP COLUMN [NumberOfSettlement];
ALTER TABLE [Payment].[PaymentSlip] ALTER COLUMN [Date] DATE NOT NULL;

ALTER TABLE [Payment].[Settlement] 
	ADD [IdReconciliation] INT NULL;

ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Reconciliation] FOREIGN KEY ([IdReconciliation]) REFERENCES [Treasury].[Reconciliation] ([Id]);

ALTER TABLE [Payroll].[ContractBenefitInKind] DROP CONSTRAINT [FK_ContractBenefitInKind_Contract];

ALTER TABLE [Payroll].[ContractBenefitInKind] WITH NOCHECK
    ADD CONSTRAINT [FK_ContractBenefitInKind_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[ContractBenefitInKind] WITH CHECK CHECK CONSTRAINT [FK_ContractBenefitInKind_Contract];

ALTER TABLE [Payroll].[EmployeeExit]
    ADD [StatePay] INT NULL;
GO
ALTER TABLE [Payroll].[ExitEmployeePayLine]
    ADD [State] INT NULL;

	ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference];
	ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]);

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_RuleUniqueReference];


GO
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique];
ALTER TABLE [Payroll].[Variable] WITH NOCHECK
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]);

ALTER TABLE [Payroll].[Variable] WITH CHECK CHECK CONSTRAINT [FK_Variable_RuleUnique];




ALTER TABLE [RH].[CurriculumVitae] DROP CONSTRAINT [FK_CV_Candidate];
ALTER TABLE [RH].[EvaluationCriteria] DROP CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme];
ALTER TABLE [RH].[CurriculumVitae] WITH NOCHECK
    ADD CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id]);

ALTER TABLE [RH].[EvaluationCriteria] WITH NOCHECK
    ADD CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id]);
ALTER TABLE [RH].[CurriculumVitae] WITH CHECK CHECK CONSTRAINT [FK_CV_Candidate];

ALTER TABLE [RH].[EvaluationCriteria] WITH CHECK CHECK CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme];

ALTER TABLE [Treasury].[Reconciliation]
    ADD [TotalDebit]  FLOAT (53) NULL,
        [TotalCredit] FLOAT (53) NULL;

ALTER TABLE [RH].[EmployeeProject] DROP CONSTRAINT [DF_EmployeeProject_AssignmentDate];

ALTER TABLE [RH].[EmployeeProject] 
ALTER COLUMN [AssignmentDate] DATETIME NOT NULL;

ALTER TABLE [RH].[EmployeeProject]
    ADD CONSTRAINT [DF_EmployeeProject_AssignmentDate] DEFAULT (getdate()) FOR [AssignmentDate] ;

	
alter table [RH].[EmployeeProject]
  drop    CONSTRAINT [FK_EmployeeProject_Project] 

  alter table [RH].[EmployeeProject]
  add       CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]) 

















ALTER TABLE [RH].[InterviewType] DROP CONSTRAINT [DF_InterviewType_TransactionUserId];

GO
ALTER TABLE [RH].[Interview] DROP CONSTRAINT [FK_Interview_InterviewType];


GO
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_InterviewType] FOREIGN KEY ([IdInterviewType]) REFERENCES [RH].[InterviewType] ([Id]);


ALTER TABLE [RH].[Interview] WITH CHECK CHECK CONSTRAINT [FK_Interview_InterviewType];



GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax] FOREIGN KEY ([IdDocumentWithholdingTax]) REFERENCES [Sales].[DocumentWithholdingTax] ([Id]);

GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement] FOREIGN KEY ([IdSettlement]) REFERENCES [Payment].[Settlement] ([Id]);

GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH CHECK CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax];

ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH CHECK CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement];


-- chedi add id country forign key to address 10:30 19/08/2020

GO
PRINT N'Altering [Shared].[Address]...';


GO
ALTER TABLE [Shared].[Address]
    ADD [IdCountry] INT NULL;


GO
PRINT N'Creating [Shared].[FK_Address_Address]...';


GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_Address] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

-- narcisse: drop old column IdTeam in Employee 21/08/2020

ALTER TABLE [Payroll].[Employee] Drop Constraint FK_Employee_Team

ALTER TABLE [Payroll].[Employee] Drop Column IdTeam



-- chedi :add tier-phone relation 13:15 24/08/2020
GO
ALTER TABLE [Shared].[Phone]
    ADD [IdTier] INT NULL;


GO
PRINT N'Creating [Shared].[FK_Phone_Tiers]...';


GO
ALTER TABLE [Shared].[Phone] WITH NOCHECK
    ADD CONSTRAINT [FK_Phone_Tiers] FOREIGN KEY ([IdTier]) REFERENCES [Sales].[Tiers] ([Id]);

-- chedi add address country relation 26/03/2020 9h
GO
ALTER TABLE [Shared].[Address] DROP CONSTRAINT [FK_Address_Address];

GO
ALTER TABLE [Shared].[Address]
    ADD [IdCompany] INT NULL;


GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_Company] FOREIGN KEY ([IdCompany]) REFERENCES [Shared].[Company] ([Id]);

GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Country_Address] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

--  chedi fix phone tiers relation 26/03/2020 9h
	GO
ALTER TABLE [Shared].[Phone] DROP CONSTRAINT [FK_Phone_Tiers];

GO
ALTER TABLE [Shared].[Phone] DROP COLUMN [IdTier];

GO
ALTER TABLE [Sales].[Tiers]
    ADD [IdPhone] INT NULL;
	
GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]);


--- Donia add type to exit reason 31/08/2020
ALTER TABLE [Payroll].[ExitReason] ALTER COLUMN [Label] NVARCHAR (255) NOT NULL;
ALTER TABLE [Payroll].[ExitReason] ADD [Type] INT NOT NULL;


	-- chedi: add city - address relation : 15.00 31-08-2020
	GO
ALTER TABLE [Shared].[Address]
    ADD [IdCity] INT NULL;

GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]);


	-- chedi : change activity area with activity sector in company table 10:25 01-09-2020
GO
ALTER TABLE [Shared].[Company]
    ADD [ActivitySector] NVARCHAR (50) NULL;

-- Narcisse : Update LoanInstllment table 02/09/2020


ALTER TABLE [Payroll].[LoanInstallment] ALTER COLUMN [State] INT NOT NULL

ALTER TABLE [Payroll].[LoanInstallment] ADD [Month] DATE NOT NULL

ALTER TABLE [Payroll].[LoanInstallment] DROP COLUMN [Date]

-- Narcisse : Merge Month and Year int columns in Month Date Column 04/09/2020

ALTER TABLE [Payroll].[ExitEmployeePayLine] DROP COLUMN [Month], [Year]

ALTER TABLE [Payroll].[ExitEmployeePayLine] ADD [Month] DATE NOT NULL

	-- Amine : Add IdBank Foreign Key in Employee 01-09-2020

ALTER TABLE [Payroll].[Employee] DROP COLUMN Bank
ALTER TABLE [Payroll].[Employee]
ADD IdBank int null

ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Bank] FOREIGN KEY([IdBank])
REFERENCES [Shared].[Bank] ([Id])
GO
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Bank]
Go

-- Molka : Add IdBank  in Nature 09-09-2020

ALTER TABLE [Inventory].[Nature]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

-- chedi : add tier creationDate 11-09-2020
ALTER TABLE [Sales].[Tiers]
    ADD [CreationDate] DATE CONSTRAINT [DF_Tiers_CreationDate] DEFAULT (getdate()) NULL;

--- Donia Update description column length and add contract advantages 11/09/2020
ALTER TABLE [Payroll].[Contract]
    ADD [ThirteenthMonthBonus] BIT        NULL,
        [MealVoucher]          FLOAT (53) NULL,
        [AvailableCar]         BIT        NULL,
        [AvailableHouse]       BIT        NULL,
        [CommissionType]       INT        NULL,
        [CommissionValue]      FLOAT (53) NULL;
ALTER TABLE [RH].[Advantages] ALTER COLUMN [Description] NVARCHAR (MAX) NULL;
ALTER TABLE [RH].[Offer]
    ADD [MealVoucher]     FLOAT (53) NULL,
        [AvailableCar]    BIT        NULL,
        [AvailableHouse]  BIT        NULL,
        [CommissionType]  INT        NULL,
        [CommissionValue] FLOAT (53) NULL;
CREATE TABLE [Payroll].[ContractAdvantage] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Description]       NVARCHAR (MAX) NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ContractAdvantage] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[ContractAdvantage] WITH NOCHECK
    ADD CONSTRAINT [FK_ContractAdvantage_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Payroll].[ContractAdvantage] WITH CHECK CHECK CONSTRAINT [FK_ContractAdvantage_Contract];

-- Narcisse : Add status column defaut value in employee 15-09-2020

ALTER TABLE [Payroll].[Employee] DROP COLUMN [Status]

ALTER TABLE [Payroll].[Employee] ADD [Status] INT CONSTRAINT [DF_Employee_Status] DEFAULT ((1)) NOT NULL
Go

-- Imen chaaben: changing company WithholdingTax
ALTER TABLE Shared.Company DROP CONSTRAINT DF_Company_WithholingTaxPercentage;
ALTER TABLE Shared.Company DROP COLUMN WithholingTaxPercentage;
ALTER TABLE Shared.Company ADD WithholdingTax BIT NOT NULL DEFAULT 1;

-- Molka : Add [UrlPicture]  in Family and ProductItem 16-09-2020

ALTER TABLE [Inventory].[Family]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

ALTER TABLE [Inventory].[ProductItem]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

-- Molka : Add [UrlPicture]  in VehicleBrand 17-09-2020
ALTER TABLE [Inventory].[VehicleBrand]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

--18/09/2020 : Ahmed ==> add column ProvInventory to Item Table
Alter Table [Inventory].[Item] 
	ADD [ProvInventory] BIT NOT NULL DEFAULT 0;

-- Molka : Add [UrlPicture]  in SubFamily , ModelOfItem and submodel 21-09-2020
ALTER TABLE [Inventory].[SubFamily]
ADD [UrlPicture] NVARCHAR (255) NULL
Go
ALTER TABLE [Inventory].[ModelOfItem]
ADD [UrlPicture] NVARCHAR (255) NULL
Go
ALTER TABLE [Inventory].[SubModel]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

--- Donia add offer bonuses to offer 28/09/2020
CREATE TABLE [RH].[OfferBonus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdOffer]           INT            NOT NULL,
    [IdBonus]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Value]             FLOAT (53)     NULL,
    [ValidityStartDate] DATE           NOT NULL,
    [ValidityEndDate]   DATE           NULL,
    CONSTRAINT [PK_OfferBonus] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [RH].[OfferBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_OfferBonus_Offer] FOREIGN KEY ([IdOffer]) REFERENCES [RH].[Offer] ([Id]) ON DELETE CASCADE;
ALTER TABLE [RH].[OfferBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_OfferBonus_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]);
ALTER TABLE [RH].[OfferBonus] WITH CHECK CHECK CONSTRAINT [FK_OfferBonus_Offer];
ALTER TABLE [RH].[OfferBonus] WITH CHECK CHECK CONSTRAINT [FK_OfferBonus_Bonus];
--- 25/09/2020 : Amine ==> Add status column defaut value in base salary
ALTER TABLE [Payroll].[BaseSalary]
ADD [State] int null
--- 25/09/2020 : Amine ==> Add status column defaut value in contract bonus
ALTER TABLE [Payroll].[ContractBonus]
ADD [State] int null
--- 25/09/2020 : Amine ==> Add status column defaut value in contract BenefitInKind
ALTER TABLE [Payroll].[ContractBenefitInKind]
ADD [State] int null



-- chedi : add bank agencies, contacts and phones 01/10/2020 17:30
CREATE TABLE [Shared].[BankAgency] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_BankAgency_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Label]             NVARCHAR (50)  NULL,
    [IdBank]            INT            NULL,
    CONSTRAINT [PK_BankAgency] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_BankAgency_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id])
);
GO


GO
ALTER TABLE [Shared].[Bank]
    ADD [IdPhone] INT NULL;


GO
ALTER TABLE [Shared].[Contact] DROP COLUMN [IdBank];

GO
ALTER TABLE [Shared].[Contact]
    ADD [IdAgency] INT NULL;

	
GO
ALTER TABLE [Shared].[Bank] WITH NOCHECK
    ADD CONSTRAINT [FK_Bank_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]);


GO
ALTER TABLE [Shared].[Contact] WITH NOCHECK
    ADD CONSTRAINT [FK_Contact_BankAgency] FOREIGN KEY ([IdAgency]) REFERENCES [Shared].[BankAgency] ([Id]);


--- Donia add SessionLoanInstallment 02/10/2020
CREATE TABLE [Payroll].[SessionLoanInstallment] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdLoanInstallment] INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SessionLoanInstallment] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_LoanInstallment] FOREIGN KEY ([IdLoanInstallment]) REFERENCES [Payroll].[LoanInstallment] ([Id]);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_Session];
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_Contract];
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_LoanInstallment];

ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Loan];
ALTER TABLE [Payroll].[PayslipDetails] DROP COLUMN [IdLoan];
ALTER TABLE [Payroll].[PayslipDetails] ADD [IdLoanInstallment] INT NULL;
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_LoanInstallment] FOREIGN KEY ([IdLoanInstallment]) REFERENCES [Payroll].[LoanInstallment] ([Id]);
ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_LoanInstallment];

ALTER TABLE [Payment].[PaymentSlip] ALTER COLUMN [Reference] NVARCHAR (255) NOT NULL;

ALTER TABLE [Payment].[PaymentSlip]
    ADD CONSTRAINT [Unique_Reference_PaymentSlip] UNIQUE NONCLUSTERED ([Reference] ASC);

	
ALTER TABLE [Sales].[BillingSession] DROP COLUMN [EndDate], COLUMN [StartDate];

ALTER TABLE [RH].[Interview] ADD [EndTime]  TIME (7) DEFAULT '00:00:00' NOT NULL;

ALTER TABLE [Shared].[Company] ADD [AutomaticCandidateMailSending] BIT DEFAULT 0 NOT NULL;