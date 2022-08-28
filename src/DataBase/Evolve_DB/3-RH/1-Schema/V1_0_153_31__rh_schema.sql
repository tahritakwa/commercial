--- Donia add NumberOfNotGeneratedDocuments to billing session and update calendar in LeaveType 11/02/2021
ALTER TABLE [Sales].[BillingSession] ADD [NumberOfNotGeneratedDocuments] INT CONSTRAINT [DF_BillingSession_NumberOfNotGeneratedDocuments] DEFAULT ((0)) NULL;

ALTER TABLE [Payroll].[LeaveType] ALTER COLUMN [Calendar] BIT NOT NULL;
ALTER TABLE [Payroll].[LeaveType] ADD CONSTRAINT [DF_LeaveType_Calendar] DEFAULT ((0)) FOR [Calendar];

--- Donia : Make IdEmployeeAuthor null 16/02/2021
ALTER TABLE [RH].[Recruitment] ALTER COLUMN [IdEmployeeAuthor] INT NULL;