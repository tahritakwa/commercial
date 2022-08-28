-- 13/01/2021 Narcisse: Add IdAdditionalHour column to PayslipDetails

ALTER TABLE Payroll.PayslipDetails ADD IdAdditionalHour INT NULL

-- 21/01/2021 Narcisse: ADD DELETE AND UPDATE CASCADE ON Attendance , SessionContract, SessionBonus, Payslip, SessionLoanInstallement

ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Contract];

ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Contract];

ALTER TABLE [Payroll].[SessionBonus] DROP CONSTRAINT [FK_PaySlip_Premium_Contract];

ALTER TABLE [Payroll].[SessionContract] DROP CONSTRAINT [FK_SessionContract_Contract];

ALTER TABLE [Payroll].[SessionLoanInstallment] DROP CONSTRAINT [FK_SessionLoan_Contract];

ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SessionBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SessionContract] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionContract_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Donia: Add step before TransferOrder 21/01/2021

CREATE TABLE [Payroll].[TransferOrderSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdTransferOrder]   INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TransferOrderSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [Payroll].[TransferOrderSession] WITH NOCHECK
    ADD CONSTRAINT [FK_TransferOrderSession_TransferOrder] FOREIGN KEY ([IdTransferOrder]) REFERENCES [Payroll].[TransferOrder] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[TransferOrderSession] WITH NOCHECK
    ADD CONSTRAINT [FK_TransferOrderSession_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);

ALTER TABLE [Payroll].[TransferOrderSession] WITH CHECK CHECK CONSTRAINT [FK_TransferOrderSession_TransferOrder];

ALTER TABLE [Payroll].[TransferOrderSession] WITH CHECK CHECK CONSTRAINT [FK_TransferOrderSession_Session];

--Rahma : add TotalTakenPerYear, AcquiredPerYear, Year, BalancePerYear to ExitEmployeeLeaveLine  26/01/2021
GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ALTER COLUMN [DayTakenPerMonth] NVARCHAR (MAX) NULL;

GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine]
    ADD [TotalTakenPerYear] FLOAT (53) NOT NULL default(0),
        [AcquiredPerYear]   FLOAT (53) NOT NULL default(0),
        [Year]              INT        NOT NULL default(0),
        [BalancePerYear]    FLOAT (53) NOT NULL default(0)
GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine]
    ADD [DayTakenPerYear] NVARCHAR (MAX) NULL;


-- Amine: Add new table [RH].[InterviewEmail] 22/01/2021

CREATE TABLE [RH].[InterviewEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdInterview] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
    [CreationDate] DateTime null,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_InterviewEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [RH].[InterviewEmail]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEmail_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
GO

ALTER TABLE [RH].[InterviewEmail] CHECK CONSTRAINT [FK_InterviewEmail_Email]
GO

ALTER TABLE [RH].[InterviewEmail]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEmail_Interview] FOREIGN KEY([IdInterview])
REFERENCES [RH].[Interview] ([Id])
GO

ALTER TABLE [RH].[InterviewEmail] CHECK CONSTRAINT [FK_InterviewEmail_Interview]
GO
--- Amine : Add IdEmail column in [RH].[Candidacy] and add FK_Candidacy_Email 
ALTER TABLE [RH].[Candidacy]
ADD [IdEmail] int null;
ALTER TABLE [RH].[Candidacy]  WITH CHECK ADD  CONSTRAINT [FK_Candidacy_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
GO

ALTER TABLE [RH].[Candidacy] CHECK CONSTRAINT [FK_Candidacy_Email]
GO
