--- Donia change MaximumNumberOfDays in leavetype to not null and add default value 11/11/2020
ALTER TABLE [Payroll].[LeaveType] ALTER COLUMN [MaximumNumberOfDays] INT NOT NULL;
ALTER TABLE [Payroll].[LeaveType] ADD DEFAULT ((1)) FOR [MaximumNumberOfDays];


-- 12/11/2020 : Narcisse: DELETE CASCADE on [IdExitEmployeePayLine]
		
ALTER TABLE [Payroll].[LinesSalaryRule] DROP CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine];

GO
ALTER TABLE [Payroll].[LinesSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY ([IdExitEmployeePayLine]) REFERENCES [Payroll].[ExitEmployeePayLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Sales].[DocumentLineTaxe]
	ADD [TaxeBase] FLOAT (53) NULL;


ALTER TABLE [Payroll].[LeaveType] ALTER COLUMN [MaximumNumberOfDays] INT NOT NULL;
ALTER TABLE [Payroll].[LeaveType] ADD DEFAULT ((1)) FOR [MaximumNumberOfDays];

-- 12/11/2020 : Narcisse: DELETE CASCADE on [IdExitEmployeePayLine]
		
ALTER TABLE [Payroll].[LinesSalaryRule] DROP CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine];

GO
ALTER TABLE [Payroll].[LinesSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY ([IdExitEmployeePayLine]) REFERENCES [Payroll].[ExitEmployeePayLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

--Kossi
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Fax] NVARCHAR (255) NULL;

ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Telephone] NVARCHAR (255) NULL;
