-- Change TransferOrder state column: Narcisse 27/01/2021

ALTER TABLE [Payroll].[TransferOrder] DROP CONSTRAINT [DF_TransferOrder_State];

ALTER TABLE [Payroll].[TransferOrder] ALTER COLUMN [State] INT NOT NULL;

ALTER TABLE [Payroll].[TransferOrder]
    ADD CONSTRAINT [DF_TransferOrder_State] DEFAULT ((0)) FOR [State];

-- Add Recrutment number candidate recruited column

ALTER TABLE [RH].[Recruitment]
    ADD [RecruitedCandidateNumber] INT CONSTRAINT [DF_Recruitment_RecruitedCandidateNumber] DEFAULT ((0)) NOT NULL;

-- Narcisse: Add idTransferOrderDetails in Payslip table

ALTER TABLE [Payroll].[Payslip] ADD [IdTransferOrder] INT NULL

ALTER TABLE [Payroll].[Payslip] ADD CONSTRAINT [FK_Payslip_TransferOrder] FOREIGN KEY ([IdTransferOrder]) REFERENCES [Payroll].[TransferOrder] ([Id])