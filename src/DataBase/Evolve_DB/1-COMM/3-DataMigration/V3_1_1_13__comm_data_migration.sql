---Rahma update candidate,user,employee tables 29/07/2021

UPDATE [Payroll].[Employee] SET [FullName]= [FirstName]+ ' ' + [LastName]
UPDATE [RH].[Candidate] SET [FullName]= [FirstName]+ ' ' + [LastName]
UPDATE [ERPSettings].[User] SET [FullName]= [FirstName]+ ' ' + [LastName]

--- Rahma add data to Table [Sales].[VehicleEnergy]  Script Date: 03/09/2021 16:58:58 
GO
SET IDENTITY_INSERT [Sales].[VehicleEnergy] ON 

INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1, N'Essence E10', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (2, N'Essence E5', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (3, N'Essence E85', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (4, N'Diesel B7', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (5, N'Diesel B10', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (6, N'Diesel XTL', 0, NULL, NULL)
INSERT [Sales].[VehicleEnergy] ([Id], [Name], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (7, N'Gazoil', 0, NULL, NULL)
SET IDENTITY_INSERT [Sales].[VehicleEnergy] OFF
GO
