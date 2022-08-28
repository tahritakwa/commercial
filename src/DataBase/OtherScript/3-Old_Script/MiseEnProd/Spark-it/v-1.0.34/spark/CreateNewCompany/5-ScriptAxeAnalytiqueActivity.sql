BEGIN TRANSACTION
SET IDENTITY_INSERT [Administration].[Axis] ON
INSERT INTO [Administration].[Axis] ([Id], [Rank], [Code], [Label], [TransactionUserId], [IsDeleted], [FR], [AR], [EN], [DE], [CH], [ES], [Deleted_Token]) VALUES (100074, NULL, N'ACTIVITY', N'Activity', 0, 0, N'Activité', NULL, N'Activity', NULL, NULL, NULL, NULL)
INSERT INTO [Administration].[Axis] ([Id], [Rank], [Code], [Label], [TransactionUserId], [IsDeleted], [FR], [AR], [EN], [DE], [CH], [ES], [Deleted_Token]) VALUES (100075, NULL, N'TYPE_ACTIVITY', N'Type_Activity', 0, 0, N'Type d''activité', NULL, N'Activity type', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [Administration].[Axis] OFF
SET IDENTITY_INSERT [Administration].[AxisEntity] ON
INSERT INTO [Administration].[AxisEntity] ([Id], [IdAxis], [IdTableEntity], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (59, 100074, 87, 0, 0, NULL)
INSERT INTO [Administration].[AxisEntity] ([Id], [IdAxis], [IdTableEntity], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (60, 100075, 87, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[AxisEntity] OFF
SET IDENTITY_INSERT [Administration].[AxisValue] ON
INSERT INTO [Administration].[AxisValue] ([Id], [Code], [Label], [IdAxis], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (87, N'DETACH', N'Détachement', 100074, 0, 0, NULL)
INSERT INTO [Administration].[AxisValue] ([Id], [Code], [Label], [IdAxis], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (88, N'INTEG', N'Intégration', 100074, 0, 0, NULL)
INSERT INTO [Administration].[AxisValue] ([Id], [Code], [Label], [IdAxis], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (89, N'EXPL', N'Exploitation', 100074, 0, 0, NULL)
INSERT INTO [Administration].[AxisValue] ([Id], [Code], [Label], [IdAxis], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (90, N'LOY', N'Loyer', 100075, 0, 0, NULL)
INSERT INTO [Administration].[AxisValue] ([Id], [Code], [Label], [IdAxis], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (91, N'INT', N'Internet', 100075, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[AxisValue] OFF
SET IDENTITY_INSERT [Administration].[AxisValueRelationShip] ON
INSERT INTO [Administration].[AxisValueRelationShip] ([Id], [IdAxisValue], [IdAxisValueParent], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (49, 90, 89, 0, 0, NULL)
INSERT INTO [Administration].[AxisValueRelationShip] ([Id], [IdAxisValue], [IdAxisValueParent], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (50, 91, 89, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[AxisValueRelationShip] OFF
SET IDENTITY_INSERT [Administration].[AxisRelationShip] ON
INSERT INTO [Administration].[AxisRelationShip] ([Id], [IdAxis], [IdAxisParent], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (93, 100074, NULL, 0, 0, NULL)
INSERT INTO [Administration].[AxisRelationShip] ([Id], [IdAxis], [IdAxisParent], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (94, 100075, 100074, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[AxisRelationShip] OFF
COMMIT TRANSACTION