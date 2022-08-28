-- Amine delete codification data team 17/12/2020

DELETE FROM [ERPSettings].[EntityCodification]
WHERE [IdCodification] = 375;
DELETE FROM [ERPSettings].[Codification]
WHERE [Id] in (377, 378, 375);
-- Nesrin : add AdditionalHour and AdditionalHourSlot data 23/12/2020
BEGIN TRANSACTION
ALTER TABLE [Payroll].[AdditionalHourSlot] DROP CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour]
GO
SET IDENTITY_INSERT [Payroll].[AdditionalHour] ON
INSERT INTO [Payroll].[AdditionalHour] ([Id], [Code], [Name], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Worked], [IncreasePercentage]) VALUES (14, N'HSUP4', N'HSUP4', N'', 0, 0, NULL, 0, 200)
INSERT INTO [Payroll].[AdditionalHour] ([Id], [Code], [Name], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Worked], [IncreasePercentage]) VALUES (15, N'HSUP3', N'HSUP3', N'', 0, 0, NULL, 1, 175)
INSERT INTO [Payroll].[AdditionalHour] ([Id], [Code], [Name], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Worked], [IncreasePercentage]) VALUES (16, N'HSUP2', N'HSUP2', N'', 0, 0, NULL, 1, 150)
INSERT INTO [Payroll].[AdditionalHour] ([Id], [Code], [Name], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Worked], [IncreasePercentage]) VALUES (17, N'HSUP1', N'HSUP1', N'', 0, 0, NULL, 1, 125)
SET IDENTITY_INSERT [Payroll].[AdditionalHour] OFF
GO
SET IDENTITY_INSERT [Payroll].[AdditionalHourSlot] ON
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (11, '00:00:00.0000000', '00:00:00.0000000', 0, 0, NULL, 14)
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (12, '22:00:00.0000000', '04:00:00.0000000', 0, 0, NULL, 15)
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (13, '20:00:00.0000000', '22:00:00.0000000', 0, 0, NULL, 16)
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (14, '04:00:00.0000000', '06:00:00.0000000', 0, 0, NULL, 16)
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (15, '18:00:00.0000000', '20:00:00.0000000', 0, 0, NULL, 17)
INSERT INTO [Payroll].[AdditionalHourSlot] ([Id], [StartTime], [EndTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdAdditionalHour]) VALUES (16, '06:00:00.0000000', '08:00:00.0000000', 0, 0, NULL, 17)
SET IDENTITY_INSERT [Payroll].[AdditionalHourSlot] OFF
ALTER TABLE [Payroll].[AdditionalHourSlot]
    ADD CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour] FOREIGN KEY ([IdAdditionalHour]) REFERENCES [Payroll].[AdditionalHour] ([Id])
COMMIT TRANSACTION
-- Amine update AssignmentPercentage data in EmployeeTeam 17/12/2020

Update [Payroll].[EmployeeTeam] set [AssignmentPercentage] = 20 where [Id] = 4
Update [Payroll].[EmployeeTeam] set [AssignmentPercentage] = 25 where [Id] = 5

--- Donia : fix resignation date 17/12/2020
BEGIN TRANSACTION
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Citizenship]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_PaymentType]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Office]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Bank]
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=50
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=51
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=52
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=53
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=54
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=55
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=56
UPDATE [Payroll].[Employee] SET [ResignationDate]=NULL WHERE [Id]=57
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id])
COMMIT TRANSACTION