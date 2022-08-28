---- Nihe: add roles to brand, model, submodel, family, fubfamily
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', N'SubFamily', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 10, N'SubFamily', N'SubFamily', N'SubFamily', N'SubFamily', N'SubFamily', N'SubFamily', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'14110ae1-17a1-446a-a3db-f893a04f4794', N'ModelOfItem', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 8, N'Model', N'Model', N'Model', N'Model', N'Model', N'Model', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', N'SubModel', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 11, N'SubModel', N'SubModel', N'SubModel', N'SubModel', N'SubModel', N'SubModel', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'997d1f54-a483-4452-be25-3b9a9eab3884', N'Brand', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 7, N'Brand', N'Brand', N'Brand', N'Brand', N'Brand', N'Brand', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'b678b40a-e499-4961-862b-eae2ecf7baef', N'Family', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 9, N'Family', N'Family', N'Family', N'Family', N'Family', N'Family', N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'07b58507-e17e-472a-b40d-0afb8fdebb95', N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1065ee6f-d26f-42f1-b723-f9a74c45fca3', N'a0c35796-bc6a-452c-a8f2-865ae862cb82', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'13278fe1-af67-443a-94e7-137fd8f4b4c5', N'092d0e85-b9bc-4464-813c-f256ea284c7d', N'997d1f54-a483-4452-be25-3b9a9eab3884')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'14fbd4ee-6e69-4f87-ac10-9a39908075d3', N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', N'997d1f54-a483-4452-be25-3b9a9eab3884')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1b52ce1b-8178-444f-83ae-06d06f6b2f3e', N'86971979-71d1-47a5-9006-e4e4c74c6a65', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2b6fffc7-ee47-497e-a5b4-403ac6052645', N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2d1afe1d-e2fa-40b3-b7dc-a92bb6c0028f', N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'483a9fbc-3424-4c7b-bb49-46418e76b249', N'ad8575c0-72ca-40cc-bf54-135ac2026501', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4b08b473-5ca3-4bbc-b5d9-44e233049bbc', N'c4827784-0363-4114-9d98-2c7aad82fa02', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4c15f01b-a4d8-4c9d-a8ed-cabbf8a38a5a', N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', N'997d1f54-a483-4452-be25-3b9a9eab3884')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4ccf316d-cdfe-4c02-af94-03828cc97aef', N'419838f7-f353-4ee5-9e90-1acbc0e94db9', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5535fcaa-24cc-44ee-ad31-4f4199153a00', N'71faed82-43c3-41ce-a5a4-e77b6649d459', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'57ce80a7-7f36-44a9-a57d-9148ce712efa', N'bd804d71-4b02-4995-9cfe-d1ff82793a05', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'605913cf-e980-4318-9a31-356a88610fc0', N'da31dab8-5111-4a29-8fea-a8f893479229', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6c715f1b-7d44-4cab-a590-020dd5a1e030', N'cb97cb0d-d670-4d87-95d4-f85457d7170a', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'77fab2ea-b9e0-4ed5-93a4-d1aa2809bdb3', N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'791a1718-d1c1-4d40-a889-4991b04f0104', N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'801862d2-2af4-449a-8482-ff702a414c17', N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8e93015a-d0e4-4385-b420-89a539dc1981', N'6f08acda-f8d6-496a-920e-e440214aac79', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9df94cc1-f0b1-4f79-b5c7-692c1998898e', N'98d525b7-49f0-407f-953f-a2eab399ce43', N'997d1f54-a483-4452-be25-3b9a9eab3884')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b835cf6c-fce4-4086-98a9-b574c5e15a11', N'48c4b04c-59db-43d5-baba-9b750f1d3951', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ccca9a1c-b619-4d24-89fc-dfe04caa0dfd', N'eee4960b-0beb-4758-a5df-9488b9e90a1f', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e05edb2d-3108-47d6-b890-ad1fa64aeb89', N'e96efc5b-0b85-42c0-abf3-373ad2869879', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ef54fa9b-e933-4762-99ea-042482d8db41', N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f20b3888-3f88-41de-b862-fd61defa8966', N'd8559505-d792-4448-9389-11553df3a53b', N'997d1f54-a483-4452-be25-3b9a9eab3884')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'997d1f54-a483-4452-be25-3b9a9eab3884', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'14110ae1-17a1-446a-a3db-f893a04f4794', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'b678b40a-e499-4961-862b-eae2ecf7baef', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'092d0e85-b9bc-4464-813c-f256ea284c7d', N'Brand-LIST', 4, N'Brand-LIST', N'Brand-LIST', NULL, NULL, NULL, NULL, N'/stock/brand/list', 1, N'LIST-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', N'Family-Show', 15, N'Family-Show', N'Family-Show', NULL, NULL, NULL, NULL, N'/stock/family/show', 0, N'Show-Family')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'419838f7-f353-4ee5-9e90-1acbc0e94db9', N'SubModel-LIST', 4, N'SubModel-LIST', N'SubModel-LIST', NULL, NULL, NULL, NULL, N'/stock/submodel/list', 1, N'LIST-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'48c4b04c-59db-43d5-baba-9b750f1d3951', N'SubFamily-DELETE', 3, N'SubFamily-DELETE', N'SubFamily-DELETE', NULL, NULL, NULL, NULL, N'/stock/subfamily/delete', 0, N'DELETE-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', N'Brand-ADD', 1, N'Brand-ADD', N'Brand-ADD', NULL, NULL, NULL, NULL, N'/stock/brand/add', 0, N'ADD-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6f08acda-f8d6-496a-920e-e440214aac79', N'Family-UPDATE', 2, N'Family-UPDATE', N'Family-UPDATE', NULL, NULL, NULL, NULL, N'/stock/family/update', 0, N'UPDATE-Family')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'71faed82-43c3-41ce-a5a4-e77b6649d459', N'ModelOfItem-DELETE', 3, N'ModelOfItem-DELETE', N'ModelOfItem-DELETE', NULL, NULL, NULL, NULL, N'/stock/modelofitem/delete', 0, N'DELETE-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'86971979-71d1-47a5-9006-e4e4c74c6a65', N'ModelOfItem-UPDATE', 2, N'ModelOfItem-UPDATE', N'ModelOfItem-UPDATE', NULL, NULL, NULL, NULL, N'/stock/modelofitem/update', 0, N'UPDATE-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', N'SubFamily-SHOW', 15, N'SubFamily-SHOW', N'SubFamily-SHOW', NULL, NULL, NULL, NULL, N'/stock/subfamily/show', 0, N'SHOW-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'98d525b7-49f0-407f-953f-a2eab399ce43', N'Brand-Show', 15, N'Brand-Show', N'Brand-Show', NULL, NULL, NULL, NULL, N'/stock/brand/show', 0, N'SHOW-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a0c35796-bc6a-452c-a8f2-865ae862cb82', N'Family-ADD', 1, N'Family-ADD', N'Family-ADD', NULL, NULL, NULL, NULL, N'/stock/family/add', 0, N'ADD-Family')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', N'ModelOfItem-ADD', 1, N'ModelOfItem-ADD', N'ModelOfItem-ADD', NULL, NULL, NULL, NULL, N'/stock/modelofitem/add', 0, N'ADD-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ad8575c0-72ca-40cc-bf54-135ac2026501', N'SubFamily-ADD', 1, N'SubFamily-ADD', N'SubFamily-ADD', NULL, NULL, NULL, NULL, N'/stock/subfamily/add', 0, N'ADD-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', N'Brand-DELETE', 3, N'Brand-DELETE', N'Brand-DELETE', NULL, NULL, NULL, NULL, N'/stock/brand/delete', 0, N'DELETE-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', N'Family-LIST', 4, N'Family-LIST', N'Family-LIST', NULL, NULL, NULL, NULL, N'/stock/family/list', 1, N'LIST-Family')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bd804d71-4b02-4995-9cfe-d1ff82793a05', N'ModelOfItem-LIST', 4, N'ModelOfItem-LIST', N'ModelOfItem-LIST', NULL, NULL, NULL, NULL, N'/stock/modelofitem/list', 1, N'LIST-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c4827784-0363-4114-9d98-2c7aad82fa02', N'SubModel-Show', 15, N'SubModel-Show', N'SubModel-Show', NULL, NULL, NULL, NULL, N'/stock/submodel/show', 0, N'SHOW-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb97cb0d-d670-4d87-95d4-f85457d7170a', N'ModelOfItem-Show', 15, N'ModelOfItem-Show', N'ModelOfItem-Show', NULL, NULL, NULL, NULL, N'/stock/modelofitem/show', 0, N'SHOW-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', N'SubFamily-LIST', 4, N'SubFamily-LIST', N'SubFamily-LIST', NULL, NULL, NULL, NULL, N'/stock/subfamily/list', 1, N'LIST-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd8559505-d792-4448-9389-11553df3a53b', N'Brand-UPDATE', 2, N'Brand-UPDATE', N'Brand-UPDATE', NULL, NULL, NULL, NULL, N'/stock/brand/update', 0, N'UPDATE-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'da31dab8-5111-4a29-8fea-a8f893479229', N'SubModel-UPDATE', 2, N'SubModel-UPDATE', N'SubModel-UPDATE', NULL, NULL, NULL, NULL, N'/stock/submodel/update', 0, N'UPDATE-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', N'SubModel-DELETE', 3, N'SubModel-DELETE', N'SubModel-DELETE', NULL, NULL, NULL, NULL, N'/stock/submodel/delete', 0, N'DELETE-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e96efc5b-0b85-42c0-abf3-373ad2869879', N'SubFamily-UPDATE', 2, N'SubFamily-UPDATE', N'SubFamily-UPDATE', NULL, NULL, NULL, NULL, N'/stock/subfamily/update', 0, N'UPDATE-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', N'SubModel-ADD', 1, N'SubModel-ADD', N'SubModel-ADD', NULL, NULL, NULL, NULL, N'/stock/submodel/add', 0, N'ADD-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eee4960b-0beb-4758-a5df-9488b9e90a1f', N'Family-DELETE', 3, N'Family-DELETE', N'Family-DELETE', NULL, NULL, NULL, NULL, N'/stock/family/delete', 0, N'DELETE-Family')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd8559505-d792-4448-9389-11553df3a53b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'98d525b7-49f0-407f-953f-a2eab399ce43', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6f08acda-f8d6-496a-920e-e440214aac79', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'da31dab8-5111-4a29-8fea-a8f893479229', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c4827784-0363-4114-9d98-2c7aad82fa02', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION

-- Imen chaaben Add Expense and DocumentExpenseLine 

Begin Transaction
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', N'Expense-DELETE', 3, N'Expense-DELETE', N'Expense-DELETE', N'Expense-DELETE', N'Expense-DELETE', N'Expense-DELETE', N'Expense-DELETE', N'/sales/expense/delete', 1, N'DELETE-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', N'DocumentExpenseLine-LIST', 4, N'DocumentExpenseLine-LIST', N'DocumentExpenseLine-LIST', N'DocumentExpenseLine-LIST', N'DocumentExpenseLine-LIST', N'DocumentExpenseLine-LIST', N'DocumentExpenseLine-LIST', N'/sales/documentexpenseline/list', 1, N'LIST-DocumentExpenseLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'44842db2-256f-4f1b-a668-aedb9e561a16', N'Expense-SHOW', 15, N'Expense-SHOW', N'Expense-SHOW', N'Expense-SHOW', N'Expense-SHOW', N'Expense-SHOW', N'Expense-SHOW', N'/sales/expense/show', 1, N'SHOW-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', N'DocumentExpenseLine-UPDATE', 2, N'DocumentExpenseLine-UPDATE', N'DocumentExpenseLine-UPDATE', N'DocumentExpenseLine-UPDATE', N'DocumentExpenseLine-UPDATE', N'DocumentExpenseLine-UPDATE', N'DocumentExpenseLine-UPDATE', N'/sales/documentexpenseline/update', 1, N'UPDATE-DocumentExpenseLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', N'Expense-ADD', 1, N'Expense-ADD', N'Expense-ADD', N'Expense-ADD', N'Expense-ADD', N'Expense-ADD', N'Expense-ADD', N'/sales/expense/add', 1, N'ADD-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'72595857-9760-4836-b5be-11c965e065f2', N'Expense-LIST', 4, N'Expense-LIST', N'Expense-LIST', N'Expense-LIST', N'Expense-LIST', N'Expense-LIST', N'Expense-LIST', N'/sales/expense/list', 1, N'LIST-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'75c04415-a531-445e-a07d-289454bc7a18', N'Expense-UPDATE', 2, N'Expense-UPDATE', N'Expense-UPDATE', N'Expense-UPDATE', N'Expense-UPDATE', N'Expense-UPDATE', N'Expense-UPDATE', N'/sales/expense/update', 1, N'UPDATE-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', N'DocumentExpenseLine-DELETE', 3, N'DocumentExpenseLine-DELETE', N'DocumentExpenseLine-DELETE', N'DocumentExpenseLine-DELETE', N'DocumentExpenseLine-DELETE', N'DocumentExpenseLine-DELETE', N'DocumentExpenseLine-DELETE', N'/sales/documentexpenseline/delete', 1, N'DELETE-DocumentExpenseLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', N'DocumentExpenseLine-ADD', 1, N'DocumentExpenseLine-ADD', N'DocumentExpenseLine-ADD', N'DocumentExpenseLine-ADD', N'DocumentExpenseLine-ADD', N'DocumentExpenseLine-ADD', N'DocumentExpenseLine-ADD', N'/sales/documentexpenseline/add', 1, N'ADD-DocumentExpenseLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', N'DocumentExpenseLine-SHOW', 15, N'DocumentExpenseLine-SHOW', N'DocumentExpenseLine-SHOW', N'DocumentExpenseLine-SHOW', N'DocumentExpenseLine-SHOW', N'DocumentExpenseLine-SHOW', N'DocumentExpenseLine-SHOW', N'/sales/documentexpenseline/show', 1, N'SHOW-DocumentExpenseLine')

SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (375, N'Sales', N'Expense', N'Expense', NULL, 0, N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'72595857-9760-4836-b5be-11c965e065f2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'75c04415-a531-445e-a07d-289454bc7a18', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'44842db2-256f-4f1b-a668-aedb9e561a16', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'138fac1b-7921-4844-ae68-637a2aabb2c3', N'DocumentExpenseLine', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 13, N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', N'Expense', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 14, N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', N'icon-note', 0)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'21a6fd80-2e75-4386-b4b1-9f71b46f1560', N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', N'138fac1b-7921-4844-ae68-637a2aabb2c3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'24f1713c-05c6-4388-a25b-204a2787259f', N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'298ce6e3-bbb0-4011-93f0-5061cbc14982', N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', N'138fac1b-7921-4844-ae68-637a2aabb2c3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6da6f580-c3d8-447f-9b7c-7bcfc5371284', N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', N'138fac1b-7921-4844-ae68-637a2aabb2c3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'87c191b9-a712-4f09-8e63-8e9fde152c30', N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', N'138fac1b-7921-4844-ae68-637a2aabb2c3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9695117e-0bd1-411e-b472-649248c77787', N'72595857-9760-4836-b5be-11c965e065f2', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b98fe86d-1b87-435d-8f31-3a3682be0900', N'75c04415-a531-445e-a07d-289454bc7a18', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c504f740-a370-4513-bc54-91ea1772c109', N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', N'138fac1b-7921-4844-ae68-637a2aabb2c3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dc2a0f60-c079-49d4-850c-6e9f1a6d7f13', N'44842db2-256f-4f1b-a668-aedb9e561a16', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'de5c1201-7a93-4ddb-8055-9093ec2ce4e8', N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 1, 1)


SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (122, N'ExpenseCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (123, N'CaractereEXP', 1, NULL, NULL, N'EXP', 122, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (124, N'Caractere-', 3, NULL, NULL, N'-', 122, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (125, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 122, 1, 1, N'00000003', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (28, 375, NULL, NULL, 122)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
COMMIT TRANSACTION

-- Imen chaaben Add DocumentExpnseLine codification 
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (376, N'Sales', N'DocumentExpenseLine', N'DocumentExpenseLine', NULL, 0, N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (29, 376, N'CodeExpenseLine', NULL, 126)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (126, N'DocumentExpenseLineCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (127, N'CaractereEXPLine', 1, NULL, NULL, N'EXP-LINE', 126, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (128, N'Caractere-', 3, NULL, NULL, N'-', 126, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (129, N'compteurPurchaseDeliveryExpenseLine', 4, NULL, NULL, NULL, 126, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION


-- Mohamed BOUZIDI Add Stark User System Acount Deleted And Id 1
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[User] ON
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang]) VALUES (1, N'Stark', N'stark', N'Stark', N'', NULL, NULL, NULL, NULL, N'Stark@spark-it.fr', NULL, NULL, 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[User] OFF
COMMIT TRANSACTION

--- Marwa : change codification of warehouse ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0019' WHERE [Id]=40
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION

--- Marwa : change information message of price request ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [FR]=N'Merci de nous communiquer votre offre de prix pour le(s) article(s) suivant(s) :', [EN]=N'Please give us your price offer for the following item(s) :' WHERE [IdInfo]=1000500023
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION


--insert new Codification
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (130, N'CodeBLClient-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (131, N'CaractereBL', 1, NULL, NULL, N'BL', 130, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (132, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 130, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (133, N'compteurFactureClient', 3, NULL, NULL, NULL, 130, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (30, 87, N'DocumentTypeCode', N'A-D-SA', 130)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF


COMMIT TRANSACTION

-- Rabeb: Add ERp settings data for leave

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'24fb6bff-bf88-4367-a5be-7a9180304283', N'Leave-DELETE', 3, N'Supprimer congé', N'Delete leave', NULL, NULL, NULL, NULL, N'/payroll/leave/delete', 0, N'DELETE-Leave')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', N'Leave-ADD', 1, N'Ajouter congé', N'Add leave', NULL, NULL, NULL, NULL, N'/payroll/leave/add', 0, N'ADD-Leave')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a94a17a2-60ed-4bde-a307-22787ea95b96', N'Leave-LIST', 4, N'Lister congés', N'Leave list', NULL, NULL, NULL, NULL, N'/payroll/leave/list', 0, N'LIST-Leave')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'Leave-UPDATE', 2, N'Modifier congé', N'Update leave', NULL, NULL, NULL, NULL, N'/payroll/leave/update', 0, N'UPDATE-Leave')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', N'Leave', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 24, N'Congé', N'Leave', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'39033c38-aa94-441d-8b4b-3fd1e0df516b', N'24fb6bff-bf88-4367-a5be-7a9180304283', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'546a047e-382c-4409-9ed0-1788386c27be', N'a94a17a2-60ed-4bde-a307-22787ea95b96', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'700f3bd6-c117-4cec-8f31-76e3929bbfa9', N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'be31d62c-12ca-47d8-b68f-cc900715833f', N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')

SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] ON
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (468, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (472, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (476, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (480, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1, 1, 1, NULL)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] OFF


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 1, 1)


ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

--- Imen chaaben Add Erp settings for ExpenseReport, ExpenseReportDetails and ExpenseReportDetailsType

BEGIN TRANSACTION

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1e14b590-ffeb-436f-bc88-20585a055247', N'ExpenseReportDetailsType-UPDATE', 2, N'ExpenseReportDetailsType-UPDATE', N'ExpenseReportDetailsType-UPDATE', N'ExpenseReportDetailsType-UPDATE', N'ExpenseReportDetailsType-UPDATE', N'ExpenseReportDetailsType-UPDATE', N'ExpenseReportDetailsType-UPDATE', N'/payroll/expensereportdetailstype/update', 1, N'UPDATE-ExpenseReportDetailsType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'20e787cc-6bb6-4115-8177-1712dffa737a', N'ExpenseReport-DELETE', 3, N'ExpenseReport-DELETE', N'ExpenseReport-DELETE', N'ExpenseReport-DELETE', N'ExpenseReport-DELETE', N'ExpenseReport-DELETE', N'ExpenseReport-DELETE', N'/payroll/expensereport/delete', 1, N'DELETE-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', N'ExpenseReport-ADD', 1, N'ExpenseReport-ADD', N'ExpenseReport-ADD', N'ExpenseReport-ADD', N'ExpenseReport-ADD', N'ExpenseReport-ADD', N'ExpenseReport-ADD', N'/payroll/expensereport/add', 1, N'ADD-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', N'ExpenseReportDetails-UPDATE', 2, N'ExpenseReportDetails-UPDATE', N'ExpenseReportDetails-UPDATE', N'ExpenseReportDetails-UPDATE', N'ExpenseReportDetails-UPDATE', N'ExpenseReportDetails-UPDATE', N'ExpenseReportDetails-UPDATE', N'/payroll/expensereportdetails/update', 1, N'UPDATE-ExpenseReportDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', N'ExpenseReportDetailsType-DELETE', 3, N'ExpenseReportDetailsType-DELETE', N'ExpenseReportDetailsType-DELETE', N'ExpenseReportDetailsType-DELETE', N'ExpenseReportDetailsType-DELETE', N'ExpenseReportDetailsType-DELETE', N'ExpenseReportDetailsType-DELETE', N'/payroll/expensereportdetailstype/delete', 1, N'DELETE-ExpenseReportDetailsType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', N'ExpenseReportDetailsType-LIST', 4, N'ExpenseReportDetailsType-LIST', N'ExpenseReportDetailsType-LIST', N'ExpenseReportDetailsType-LIST', N'ExpenseReportDetailsType-LIST', N'ExpenseReportDetailsType-LIST', N'ExpenseReportDetailsType-LIST', N'/payroll/expensereportdetailstype/list', 1, N'LIST-ExpenseReportDetailsType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6645f540-88c9-478a-96ec-bee746bc67e4', N'ExpenseReportDetailsType-Show', 15, N'ExpenseReportDetailsType-Show', N'ExpenseReportDetailsType-Show', N'ExpenseReportDetailsType-Show', N'ExpenseReportDetailsType-Show', N'ExpenseReportDetailsType-Show', N'ExpenseReportDetailsType-Show', N'/payroll/expensereportdetailstype/show', 1, N'SHOW-ExpenseReportDetailsType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'ExpenseReport-UPDATE', 2, N'ExpenseReport-UPDATE', N'ExpenseReport-UPDATE', N'ExpenseReport-UPDATE', N'ExpenseReport-UPDATE', N'ExpenseReport-UPDATE', N'ExpenseReport-UPDATE', N'/payroll/expensereport/update', 1, N'UPDATE-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'83dc878d-7bba-4609-94c2-d01745a05fa3', N'ExpenseReportDetailsType-ADD', 1, N'ExpenseReportDetailsType-ADD', N'ExpenseReportDetailsType-ADD', N'ExpenseReportDetailsType-ADD', N'ExpenseReportDetailsType-ADD', N'ExpenseReportDetailsType-ADD', N'ExpenseReportDetailsType-ADD', N'/payroll/expensereportdetailstype/add', 1, N'ADD-ExpenseReportDetailsType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8a10f075-1614-4019-8d64-28a9a5d21ce8', N'ExpenseReportDetails-LIST', 4, N'ExpenseReportDetails-LIST', N'ExpenseReportDetails-LIST', N'ExpenseReportDetails-LIST', N'ExpenseReportDetails-LIST', N'ExpenseReportDetails-LIST', N'ExpenseReportDetails-LIST', N'/payroll/expensereportdetails/list', 1, N'LIST-ExpenseReportDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9c490860-14ee-44e1-8f5f-080587e317ce', N'ExpenseReport-Show', 15, N'ExpenseReport-Show', N'ExpenseReport-Show', N'ExpenseReport-Show', N'ExpenseReport-Show', N'ExpenseReport-Show', N'ExpenseReport-Show', N'/payroll/expensereport/show', 1, N'SHOW-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a3494b24-c859-499c-8125-831b7f159320', N'ExpenseReportDetails-ADD', 1, N'ExpenseReportDetails-ADD', N'ExpenseReportDetails-ADD', N'ExpenseReportDetails-ADD', N'ExpenseReportDetails-ADD', N'ExpenseReportDetails-ADD', N'ExpenseReportDetails-ADD', N'/payroll/expensereportdetails/add', 1, N'ADD-ExpenseReportDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', N'ExpenseReport-LIST', 4, N'ExpenseReport-LIST', N'ExpenseReport-LIST', N'ExpenseReport-LIST', N'ExpenseReport-LIST', N'ExpenseReport-LIST', N'ExpenseReport-LIST', N'/payroll/expensereport/list', 1, N'LIST-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', N'ExpenseReportDetails-Show', 15, N'ExpenseReportDetails-Show', N'ExpenseReportDetails-Show', N'ExpenseReportDetails-Show', N'ExpenseReportDetails-Show', N'ExpenseReportDetails-Show', N'ExpenseReportDetails-Show', N'/payroll/expensereportdetails/show', 1, N'SHOW-ExpenseReportDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', N'ExpenseReportDetails-DELETE', 3, N'ExpenseReportDetails-DELETE', N'ExpenseReportDetails-DELETE', N'ExpenseReportDetails-DELETE', N'ExpenseReportDetails-DELETE', N'ExpenseReportDetails-DELETE', N'ExpenseReportDetails-DELETE', N'/payroll/expensereportdetails/delete', 1, N'DELETE-ExpenseReportDetails')

SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] ON
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (481, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (485, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (489, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (493, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (497, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (501, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (505, N'a3494b24-c859-499c-8125-831b7f159320', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (509, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (513, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (517, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (521, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (525, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (529, N'1e14b590-ffeb-436f-bc88-20585a055247', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (533, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (537, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1, 1, 1, NULL)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] OFF

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', N'ExpenseReport', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 25, N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'60b695ae-b5bd-4257-bf76-1ad97af29c07', N'ExpenseReportDetailsType', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 27, N'ExpenseReportDetailsType', N'ExpenseReportDetailsType', N'ExpenseReportDetailsType', N'ExpenseReportDetailsType', N'ExpenseReportDetailsType', N'ExpenseReportDetailsType', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'8b43714c-d306-45b4-8d67-311a393e9133', N'ExpenseReportDetails', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 26, N'ExpenseReportDetails', N'ExpenseReportDetails', N'ExpenseReportDetails', N'ExpenseReportDetails', N'ExpenseReportDetails', N'ExpenseReportDetails', N'icon-note', 0)


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'8b43714c-d306-45b4-8d67-311a393e9133', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 1, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0296f87b-c9d6-4c08-8bc9-95c1f3a4d807', N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', N'8b43714c-d306-45b4-8d67-311a393e9133')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'08b36080-3cba-48cc-8e13-73262747c4c7', N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', N'60b695ae-b5bd-4257-bf76-1ad97af29c07')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'19607030-4a97-4e82-a7e0-478834fe9a25', N'1e14b590-ffeb-436f-bc88-20585a055247', N'60b695ae-b5bd-4257-bf76-1ad97af29c07')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3c058936-d239-4633-a44a-f877dc626a00', N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4e6b8139-423b-42e6-a35f-c0f84f214006', N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', N'8b43714c-d306-45b4-8d67-311a393e9133')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7ad795da-cfbc-4f12-8958-e038e0b66b0a', N'83dc878d-7bba-4609-94c2-d01745a05fa3', N'60b695ae-b5bd-4257-bf76-1ad97af29c07')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8e0309b7-db68-4af0-b359-543f38f4c2f7', N'6645f540-88c9-478a-96ec-bee746bc67e4', N'60b695ae-b5bd-4257-bf76-1ad97af29c07')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9f1703db-7014-4fb2-9ca2-ddd677c9b780', N'a3494b24-c859-499c-8125-831b7f159320', N'8b43714c-d306-45b4-8d67-311a393e9133')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a2b98b05-174f-4129-8367-500a7462eca3', N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'beb7edea-d888-4633-9a2b-013318b59a46', N'20e787cc-6bb6-4115-8177-1712dffa737a', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c2c2b5a1-c1c5-4ee6-8e22-1958dc024adc', N'8a10f075-1614-4019-8d64-28a9a5d21ce8', N'8b43714c-d306-45b4-8d67-311a393e9133')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c6517086-be1c-4bcd-8619-be43d4a60909', N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', N'60b695ae-b5bd-4257-bf76-1ad97af29c07')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd481e79a-73dd-41f2-8e2a-a82287fb247d', N'9c490860-14ee-44e1-8f5f-080587e317ce', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e6b3350a-4d94-4342-822b-99238c82dd42', N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', N'8b43714c-d306-45b4-8d67-311a393e9133')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fa169726-11cb-4731-8eb4-1c30ccea24c4', N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')

COMMIT TRANSACTION
-- Narcisse: Erp sessting document employee and CNSS declaration
BEGIN TRANSACTION

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0354f894-5ad4-4667-8c78-e85416e88313', N'DocumentRequestType-UPDATE', 2, N'Modifier type de requeste document', N'Update type de requeste document', NULL, NULL, NULL, NULL, N'/payroll/documentrequesttype/update', 0, N'UPDATE-DocumentRequestType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', N'CnssDeclaration-LIST', 4, N'Lister declaration CNSS', N'List CNSS declaration', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclaration/list', 0, N'LIST-CnssDeclaration')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'14096ba7-324e-4092-b933-a1b57c3ebb32', N'DocumentRequestType-LIST', 4, N'Lister type de requeste document', N'List document request type', NULL, NULL, NULL, NULL, N'/payroll/documentrequesttype/list', 0, N'LIST-DocumentRequestType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', N'CnssDeclaration-ADD', 1, N'Ajout declaration CNSS', N'Add CNSS declaration', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclaration/add', 0, N'ADD-CnssDeclaration')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1ba293b9-8bde-4a86-a6a9-efc5753af567', N'DocumentRequest-DELETE', 3, N'Supprimer demande document', N'Delete document request', NULL, NULL, NULL, NULL, N'/payroll/documentrequest/delete', 0, N'DELETE-DocumentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3eb1157c-852d-43ea-a65f-7073e3897613', N'CnssDeclarationDetails-ADD', 1, N'Ajout detail de declaration CNSS', N'Add details CNSS declarations', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclarationdetails/add', 1, N'ADD-CnssDeclarationDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', N'CnssDeclarationDetails-LIST', 4, N'Lister details declaration CNSS', N'List CNSS declaration details', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclarationdetails/list', 1, N'LIST-CnssDeclarationDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'788872dc-bdd0-4558-b3c8-37af3fda8a42', N'DocumentRequest-LIST', 4, N'Lister demande document', N'List document request', NULL, NULL, NULL, NULL, N'/payroll/documentrequest/list', 0, N'LIST-DocumentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', N'DocumentRequest-ADD', 1, N'Ajout demande document', N'Add document request', NULL, NULL, NULL, NULL, N'/payroll/documentrequest/add', 0, N'ADD-DocumentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'820ab0ac-6d35-4a42-a051-cd9f986d9c09', N'DocumentRequestType-ADD', 1, N'Ajouter type de requeste document', N'Add document request type', NULL, NULL, NULL, NULL, N'/payroll/documentrequesttype/add', 0, N'ADD-DocumentRequestType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'95adccad-66f9-47b3-a471-a6ee737b67a9', N'DocumentRequestType-DELETE', 3, N'Supprimer type de requeste document', N'Delete document request type', NULL, NULL, NULL, NULL, N'/payroll/documentrequesttype/delete', 0, N'DELETE-DocumentRequestType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', N'CnssDeclaration-DELETE', 3, N'Supprimer declaration CNSS', N'Delete CNSS declaration', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclaration/delete', 0, N'DELETE-CnssDeclaration')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'af6ec62f-06d0-4188-8022-5e0a64dc6186', N'DocumentRequest-UPDATE', 2, N'Modifier demande document', N'Update document request', NULL, NULL, NULL, NULL, N'/payroll/documentrequest/update', 0, N'UPDATE-DocumentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', N'CnssDeclarationDetails-DELETE', 3, N'Supprimer detail declaration CNSS', N'Delete CNSS declaration details', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclarationdetails/delete', 0, N'DELETE-CnssDeclarationDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bfeda042-0064-4e1f-867a-9cfcea27daaa', N'CnssDeclarationDetails-UPDATE', 2, N'Ajout details declaration CNSS', N'Add CNSS declaration details', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclarationdetails/update', 0, N'UPDATE-CnssDeclarationDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', N'CnssDeclaration-UPDATE', 2, N'Modifier declaration CNSS', N'Update CNSS declaration', NULL, NULL, NULL, NULL, N'/payroll/cnssdeclaration/update', 0, N'UPDATE-CnssDeclaration')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'21188e34-572b-4328-bf25-268df5eb2da0', N'CnssDeclarationDetails', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 27, N'Details declaration CNSS', N'CNSS declaration details', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'8cab7af9-78ef-4a95-88a6-ce059225323c', N'DocumentRequestType', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 25, N'Type de demande document', N'Document request type', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'949f1777-0d49-4e49-b776-34e801b9da85', N'DocumentRequest', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 24, N'Demande de document', N'Document request', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', N'CnssDeclaration', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 26, N'Declaration CNSS', N'CNSS Declaration', NULL, NULL, NULL, NULL, N'icon-note', 0)


INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'949f1777-0d49-4e49-b776-34e801b9da85', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'21188e34-572b-4328-bf25-268df5eb2da0', 1, 1)

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'820ab0ac-6d35-4a42-a051-cd9f986d9c09', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'0354f894-5ad4-4667-8c78-e85416e88313', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'95adccad-66f9-47b3-a471-a6ee737b67a9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'14096ba7-324e-4092-b933-a1b57c3ebb32', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'3eb1157c-852d-43ea-a65f-7073e3897613', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1227ac9e-21e6-4d29-b386-3d816b60b64c', N'14096ba7-324e-4092-b933-a1b57c3ebb32', N'8cab7af9-78ef-4a95-88a6-ce059225323c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1480cd65-c423-4381-a878-fba1da76f009', N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', N'21188e34-572b-4328-bf25-268df5eb2da0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'23e34df2-bb1a-4cfc-9ce0-e7d0bd68c409', N'0354f894-5ad4-4667-8c78-e85416e88313', N'8cab7af9-78ef-4a95-88a6-ce059225323c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'26f92589-5f07-4eef-8544-dde7c7a1efa4', N'1ba293b9-8bde-4a86-a6a9-efc5753af567', N'949f1777-0d49-4e49-b776-34e801b9da85')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'31bef293-ad53-458e-9006-a521b4d24f5d', N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'329cf8a5-007d-4035-b533-926b8222ebe9', N'3eb1157c-852d-43ea-a65f-7073e3897613', N'21188e34-572b-4328-bf25-268df5eb2da0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3b2f80a5-baeb-4c8c-aa1c-9bbc99fc5566', N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6e3614e3-a0d9-4d00-8a77-af58081390f5', N'95adccad-66f9-47b3-a471-a6ee737b67a9', N'8cab7af9-78ef-4a95-88a6-ce059225323c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8182f1b7-5764-4015-bfc6-adcf44c4ba2e', N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'82417b4a-9615-4970-be55-86f0daccf785', N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', N'21188e34-572b-4328-bf25-268df5eb2da0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9174510d-8e27-4b21-bf25-334b9fa4539f', N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', N'949f1777-0d49-4e49-b776-34e801b9da85')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9ea9b29e-5f86-4415-9946-e3c7b7b06e7f', N'820ab0ac-6d35-4a42-a051-cd9f986d9c09', N'8cab7af9-78ef-4a95-88a6-ce059225323c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b8c787d3-9823-40ee-b49d-46831b090dee', N'788872dc-bdd0-4558-b3c8-37af3fda8a42', N'949f1777-0d49-4e49-b776-34e801b9da85')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c07c9d45-3e99-4f58-9ea0-05e62cc671a5', N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e49c864d-d538-4666-9dfe-31374c9b565e', N'bfeda042-0064-4e1f-867a-9cfcea27daaa', N'21188e34-572b-4328-bf25-268df5eb2da0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e52c0546-6579-4f1a-b0e6-57d56f1f9c09', N'af6ec62f-06d0-4188-8022-5e0a64dc6186', N'949f1777-0d49-4e49-b776-34e801b9da85')

COMMIT TRANSACTION

--- Kossi Add LeaveType authorization 

BEGIN TRANSACTION

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'39887b12-6eee-4997-b509-b0bd643a727e', N'LeaveType-LIST', 4, N'LeaveType-LIST', N'LeaveType-LIST', N'LeaveType-LIST', N'LeaveType-LIST', N'LeaveType-LIST', N'LeaveType-LIST', N'/payroll/leavetype/list', 1, N'LIST-LeaveType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', N'LeaveType-UPDATE', 2, N'LeaveType-UPDATE', N'LeaveType-UPDATE', N'LeaveType-UPDATE', N'LeaveType-UPDATE', N'LeaveType-UPDATE', N'LeaveType-UPDATE', N'/payroll/leavetype/update', 1, N'UPDATE-LeaveType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', N'LeaveType-ADD', 1, N'LeaveType-ADD', N'LeaveType-ADD', N'LeaveType-ADD', N'LeaveType-ADD', N'LeaveType-ADD', N'LeaveType-ADD', N'/payroll/leavetype/add', 1, N'ADD-LeaveType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', N'LeaveType-Show', 15, N'LeaveType-Show', N'LeaveType-Show', N'LeaveType-Show', N'LeaveType-Show', N'LeaveType-Show', N'LeaveType-Show', N'/payroll/leavetype/show', 1, N'SHOW-LeaveType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f683600c-bd77-495b-8baf-a76fd1df0215', N'LeaveType-DELETE', 3, N'LeaveType-DELETE', N'LeaveType-DELETE', N'LeaveType-DELETE', N'LeaveType-DELETE', N'LeaveType-DELETE', N'LeaveType-DELETE', N'/payroll/leavetype/delete', 1, N'DELETE-LeaveType')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'ae298068-a632-40b3-b2d4-aa4636697160', N'LeaveType', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 25, N'LeaveType', N'LeaveType', N'LeaveType', N'LeaveType', N'LeaveType', N'LeaveType', N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'39887b12-6eee-4997-b509-b0bd643a727e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'f683600c-bd77-495b-8baf-a76fd1df0215', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'075fcf6d-e732-4b6c-b3e7-6b1c6a8a36dc', N'f683600c-bd77-495b-8baf-a76fd1df0215', N'ae298068-a632-40b3-b2d4-aa4636697160')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'15bf7c2f-35c5-41b1-925e-f530d7cd6c59', N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', N'ae298068-a632-40b3-b2d4-aa4636697160')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'90a88bd7-9f5f-4dc2-8f54-6011b9d34d50', N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', N'ae298068-a632-40b3-b2d4-aa4636697160')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ccf445d4-ea75-4f73-9a5d-f685d689ff06', N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', N'ae298068-a632-40b3-b2d4-aa4636697160')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f08a61f1-e03f-4d64-9804-5f7e628dcae0', N'39887b12-6eee-4997-b509-b0bd643a727e', N'ae298068-a632-40b3-b2d4-aa4636697160')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'ae298068-a632-40b3-b2d4-aa4636697160', 1, 1)

COMMIT TRANSACTION

--- Marwa Add information ----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501074, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'/payroll/employee/edit', N'Le contrat de {FullName} prendra fin le {DateEndContract}', N'{FullName}''s contract will end on {DateEndContract}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_END_CONTRACT', N'PAYROLL_END_CONTRACT')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] ON
INSERT INTO [ERPSettings].[RoleInfo] ([idRoleInfo], [IdRole], [IdInformation], [IsDeleted], [Deleted_Token]) VALUES (1059, 1, 1000501074, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] OFF
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

-- Mohamed BOUZIDI Add SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE [Information]
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]

SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo],[IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501075,N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', N'/sales/delivery/edit', N'L''article {CODE} est disponible', N'The product {CODE} is available', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE', N'SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] ON
INSERT INTO [ERPSettings].[RoleInfo] ([idRoleInfo], [IdRole], [IdInformation], [IsDeleted], [Deleted_Token]) VALUES (1060, 1, 1000501075, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] OFF

ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

-- Mohamed BOUZIDI Add SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE [Information]
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]

SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo],[IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501076,N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', N'/sales/delivery/edit', N'L''article {CODE} est disponible', N'The product {CODE} is available', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_AVAILABLE_PRODUCT_IN_WAREHOUCE', N'SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] ON
INSERT INTO [ERPSettings].[RoleInfo] ([idRoleInfo], [IdRole], [IdInformation], [IsDeleted], [Deleted_Token]) VALUES (1061, 1, 1000501076, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleInfo] OFF

ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

---
begin transaction
update ERPSettings.Information
set URL = '/purchase/delivery/show'
where IdInfo in(1000500016,1000500041)


update ERPSettings.Information
set URL = '/sales/delivery/show'
where IdInfo in(1000500018,1000500033)
Commit transaction

--- Imen Chaaben : Skills and EmployeeSkills authorization 

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'05d28c92-aa4b-459f-a306-ea45722c9e71', N'EmployeeSkills-DELETE', 3, N'EmployeeSkills-DELETE', N'EmployeeSkills-DELETE', N'EmployeeSkills-DELETE', N'EmployeeSkills-DELETE', N'EmployeeSkills-DELETE', N'EmployeeSkills-DELETE', N'/payroll/employeeskills/delete', 1, N'DELETE-EmployeeSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'076aa20b-5f04-4872-8093-40cef7ee2e1d', N'EmployeeSkills-UPDATE', 2, N'EmployeeSkills-UPDATE', N'EmployeeSkills-UPDATE', N'EmployeeSkills-UPDATE', N'EmployeeSkills-UPDATE', N'EmployeeSkills-UPDATE', N'EmployeeSkills-UPDATE', N'/payroll/employeeskills/update', 1, N'UPDATE-EmployeeSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1fa27253-d770-4f50-8cc8-75122eb1e68c', N'Skills-ADD', 1, N'Skills-ADD', N'Skills-ADD', N'Skills-ADD', N'Skills-ADD', N'Skills-ADD', N'Skills-ADD', N'/payroll/skills/add', 1, N'ADD-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'51c504b7-3fd2-4111-9652-05b295f0732f', N'Skills-UPDATE', 2, N'Skills-UPDATE', N'Skills-UPDATE', N'Skills-UPDATE', N'Skills-UPDATE', N'Skills-UPDATE', N'Skills-UPDATE', N'/payroll/skills/update', 1, N'UPDATE-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', N'EmployeeSkills-LIST', 4, N'EmployeeSkills-LIST', N'EmployeeSkills-LIST', N'EmployeeSkills-LIST', N'EmployeeSkills-LIST', N'EmployeeSkills-LIST', N'EmployeeSkills-LIST', N'/payroll/employeeskills/list', 1, N'LIST-EmployeeSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', N'Skills-DELETE', 3, N'Skills-DELETE', N'Skills-DELETE', N'Skills-DELETE', N'Skills-DELETE', N'Skills-DELETE', N'Skills-DELETE', N'/payroll/skills/delete', 1, N'DELETE-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'658015c0-d4d6-4aa6-b199-4bfa36c25654', N'Skills-SHOW', 15, N'Skills-SHOW', N'Skills-SHOW', N'Skills-SHOW', N'Skills-SHOW', N'Skills-SHOW', N'Skills-SHOW', N'/payroll/skills/show', 1, N'SHOW-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', N'Skills-LIST', 4, N'Skills-LIST', N'Skills-LIST', N'Skills-LIST', N'Skills-LIST', N'Skills-LIST', N'Skills-LIST', N'/payroll/skills/list', 1, N'LIST-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'da43d379-0954-42dd-9832-8890747a0929', N'EmployeeSkills-SHOW', 15, N'EmployeeSkills-SHOW', N'EmployeeSkills-SHOW', N'EmployeeSkills-SHOW', N'EmployeeSkills-SHOW', N'EmployeeSkills-SHOW', N'EmployeeSkills-SHOW', N'/payroll/employeeskills/show', 1, N'SHOW-EmployeeSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e217064d-adff-4afc-af38-7dede030d53f', N'EmployeeSkills-ADD', 1, N'EmployeeSkills-ADD', N'EmployeeSkills-ADD', N'EmployeeSkills-ADD', N'EmployeeSkills-ADD', N'EmployeeSkills-ADD', N'EmployeeSkills-ADD', N'/payroll/employeeskills/add', 1, N'ADD-EmployeeSkills')

SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (377, N'Payroll', N'Skills', N'Skills', NULL, 0, N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (31, 377, NULL, NULL, 137)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'05d28c92-aa4b-459f-a306-ea45722c9e71', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'076aa20b-5f04-4872-8093-40cef7ee2e1d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'51c504b7-3fd2-4111-9652-05b295f0732f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'da43d379-0954-42dd-9832-8890747a0929', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e217064d-adff-4afc-af38-7dede030d53f', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'bef67db7-625d-41e7-99ae-e116177d04a1', N'Skills', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 33, N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'de7d394d-0c2d-4819-8434-97acb048467f', N'EmployeeSkills', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 34, N'EmployeeSkills', N'EmployeeSkills', N'EmployeeSkills', N'EmployeeSkills', N'EmployeeSkills', N'EmployeeSkills', N'icon-note', 0)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0c380980-8c96-40a9-b91c-bde8341d412c', N'e217064d-adff-4afc-af38-7dede030d53f', N'de7d394d-0c2d-4819-8434-97acb048467f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'17c25a07-03f4-429c-8863-50ca7f0b572a', N'51c504b7-3fd2-4111-9652-05b295f0732f', N'bef67db7-625d-41e7-99ae-e116177d04a1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7de69c15-ccbe-46b5-942c-4c6bf271a140', N'1fa27253-d770-4f50-8cc8-75122eb1e68c', N'bef67db7-625d-41e7-99ae-e116177d04a1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'832fb9f0-3689-4564-8d20-d104799c7ee8', N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', N'de7d394d-0c2d-4819-8434-97acb048467f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a116fe97-972f-485a-aae2-a973b7103236', N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', N'bef67db7-625d-41e7-99ae-e116177d04a1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a1a8c84c-d2ec-4bc3-bcaf-c45411097ec2', N'da43d379-0954-42dd-9832-8890747a0929', N'de7d394d-0c2d-4819-8434-97acb048467f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b3992de9-b6bd-41ec-b8fa-fb0992fc5b83', N'076aa20b-5f04-4872-8093-40cef7ee2e1d', N'de7d394d-0c2d-4819-8434-97acb048467f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd6040e4f-4e55-4227-ad2e-2e105e21ce31', N'05d28c92-aa4b-459f-a306-ea45722c9e71', N'de7d394d-0c2d-4819-8434-97acb048467f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f6c2a20a-b8fb-4795-94ba-e40285d25b9e', N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', N'bef67db7-625d-41e7-99ae-e116177d04a1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fb33695e-b0c4-4987-95c5-2385bc146d9b', N'658015c0-d4d6-4aa6-b199-4bfa36c25654', N'bef67db7-625d-41e7-99ae-e116177d04a1')

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'bef67db7-625d-41e7-99ae-e116177d04a1', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'de7d394d-0c2d-4819-8434-97acb048467f', 1, 1)

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (137, N'SkillsCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (138, N'CaractereSK', 1, NULL, NULL, N'SK', 137, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (140, N'compteurSkills', 2, NULL, NULL, NULL, 137, 1, 1, N'00000013', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Narcisse : Show declaration CNSS functionnality and role

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9d395974-bec0-47e7-b32f-743afcc422de', N'CnssDeclaration-Show', 15, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/cnssdeclaration/show', 0, N'SHOW-CnssDeclaration')
SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] ON
INSERT INTO [ERPSettings].[FunctionalityByRole] ([Id], [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (569, N'9d395974-bec0-47e7-b32f-743afcc422de', 1, 1, 1, NULL)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityByRole] OFF
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'192e9cf7-dcff-4fcb-b04c-ef04d507f96f', N'9d395974-bec0-47e7-b32f-743afcc422de', N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


-- Mohamed BOUZIDI module and functionality

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]

INSERT INTO [ERPSettings].[Entity] ( [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES ( N'RH', N'Candidate', N'Candidate', NULL, 0, N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'Candidate', NULL, NULL, NULL)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', N'Candidate-LIST', 4, N'Candidat list', N'List Candidate', N'List Candidate', N'List Candidate', N'List Candidate', N'List Candidate', N'/rh/candidate/list', 1, N'LIST-Candidate')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8a5f8969-e778-43c9-b348-24c94a5b96b3', N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'1755151f-da27-40ad-b605-c51624e5779a', N'RH', NULL, 9, N'RH', N'HR', N'RH', N'RH', N'RH', N'RH', N'icon-note', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', N'Candidate', N'1755151f-da27-40ad-b605-c51624e5779a', 1, N'Candidat', N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'icon-note', 1)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'1755151f-da27-40ad-b605-c51624e5779a', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 1, 1)

ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

-- Kossi add [FunctionnalityModule]

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'eeeef661-f871-435a-badd-be1d6c96765b', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', N'InterviewMark-ADD', 1, N'NoteEntretien', N'InterviewMark', NULL, NULL, NULL, NULL, N'/rh/interviewmark/add', 1, N'ADD-InterviewMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'179b7471-6f14-44c3-8b65-9fcaacb1372a', N'Recruitment-DELETE', 3, N'Recrutement', N'Recruitment', NULL, NULL, NULL, NULL, N'/rh/recruitment/delete', 1, N'DELETE-Recruitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'17f7318a-98ec-4124-9b94-3d0413720163', N'Offer-UPDATE', 2, N'Offre', N'Offer', NULL, NULL, NULL, NULL, N'/rh/offer/update', 1, N'UPDATE-Offer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2eefeed5-3995-4dd4-83fa-603c440faba3', N'Candidacy-DELETE', 3, N'Candidature', N'Candidacy', NULL, NULL, NULL, NULL, N'/rh/candidacy/delete', 1, N'DELETE-Candidacy')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'Recruitment-UPDATE', 2, N'Recrutement', N'Recruitment', NULL, NULL, NULL, NULL, N'/rh/recruitment/update', 1, N'UPDATE-Recruitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4256493c-98b6-4a0e-9ba8-89ce04de832d', N'InterviewMark-UPDATE', 2, N'NoteEntretien', N'InterviewMark', NULL, NULL, NULL, NULL, N'/rh/interviewmark/update', 1, N'UPDATE-InterviewMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'55809876-8109-4bd2-a655-ab0996fb54c7', N'Offer-LIST', 4, N'Offre', N'Offer', NULL, NULL, NULL, NULL, N'/rh/offer/list', 1, N'LIST-Offer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'819b148d-a655-41e4-a030-6b0dfc006694', N'Candidacy-LIST', 4, N'Candidature', N'Candidacy', NULL, NULL, NULL, NULL, N'/rh/candidacy/list', 1, N'LIST-Candidacy')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', N'Offer-ADD', 1, N'Offre', N'Offer', NULL, NULL, NULL, NULL, N'/rh/offer/add', 1, N'ADD-Offer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', N'InterviewMark-LIST', 4, N'NoteEntretien', N'InterviewMark', NULL, NULL, NULL, NULL, N'/rh/interviewmark/list', 1, N'LIST-InterviewMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'97050a68-9699-4bda-bb74-bac15ac8ceef', N'Recruitment-LIST', 4, N'Recrutement', N'Recruitment', NULL, NULL, NULL, NULL, N'/rh/recruitment/list', 1, N'LIST-Recruitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', N'Interview-LIST', 4, N'Entretien', N'Interview', NULL, NULL, NULL, NULL, N'/rh/interview/list', 1, N'LIST-Interview')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', N'Interview-DELETE', 3, N'Entretien', N'Interview', NULL, NULL, NULL, NULL, N'/rh/interview/delete', 1, N'DELETE-Interview')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b365a596-61f0-4ada-bc56-f455b9d56c51', N'Candidacy-ADD', 1, N'Candidature', N'Candidacy', NULL, NULL, NULL, NULL, N'/rh/candidacy/add', 1, N'ADD-Candidacy')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', N'Recruitment-ADD', 1, N'Recrutement', N'Recruitment', NULL, NULL, NULL, NULL, N'/rh/recruitment/add', 1, N'ADD-Recruitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'be1a5270-9d9f-409d-988e-e573128abf8a', N'Interview-ADD', 1, N'Entretien', N'Interview', NULL, NULL, NULL, NULL, N'/rh/interview/add', 1, N'ADD-Interview')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cc619a78-e398-4032-9ccd-000cb48a4bf2', N'Offer-DELETE', 3, N'Offre', N'Offer', NULL, NULL, NULL, NULL, N'/rh/offer/delete', 1, N'DELETE-Offer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cdd7db9d-6929-4539-ae3f-2363bf449f73', N'Interview-UPDATE', 2, N'Entretien', N'Interview', NULL, NULL, NULL, NULL, N'/rh/interview/update', 1, N'UPDATE-Interview')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', N'InterviewMark-DELETE', 3, N'NoteEntretien', N'InterviewMark', NULL, NULL, NULL, NULL, N'/rh/interviewmark/delete', 1, N'DELETE-InterviewMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eb75b4cc-b859-40b2-b126-426faf885a6a', N'Candidacy-UPDATE', 2, N'Candidature', N'Candidacy', NULL, NULL, NULL, NULL, N'/rh/candidacy/update', 1, N'UPDATE-Candidacy')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'be1a5270-9d9f-409d-988e-e573128abf8a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'819b148d-a655-41e4-a030-6b0dfc006694', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'55809876-8109-4bd2-a655-ab0996fb54c7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'17f7318a-98ec-4124-9b94-3d0413720163', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1042c0c6-46dc-4e52-b305-9e15bb46f56b', N'cc619a78-e398-4032-9ccd-000cb48a4bf2', N'e6f0b965-7b14-48f9-8682-1e7cdc019386')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1077c101-70dd-4a11-9114-435efb59c079', N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1938feb3-06fe-496b-a5e1-3134ca27248a', N'2eefeed5-3995-4dd4-83fa-603c440faba3', N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1b496d0e-7f56-4d6d-9b97-976a1a4c9bde', N'17f7318a-98ec-4124-9b94-3d0413720163', N'e6f0b965-7b14-48f9-8682-1e7cdc019386')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1d3d562b-924f-4eea-8b20-0be39daef684', N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'251a9b1c-f877-425f-85d8-8550e5b38cde', N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'28254468-49d4-49a2-8a24-198b2bc3b36d', N'55809876-8109-4bd2-a655-ab0996fb54c7', N'e6f0b965-7b14-48f9-8682-1e7cdc019386')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3245e404-d054-4e79-89a4-6d51e2f73d14', N'819b148d-a655-41e4-a030-6b0dfc006694', N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'539567f8-a3c0-4683-b874-01c54b49889b', N'cdd7db9d-6929-4539-ae3f-2363bf449f73', N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'54306e78-a4e2-431d-93a3-27f3632b645f', N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'60e6a063-a5ae-41a4-89ea-9bd74dbe2ec3', N'97050a68-9699-4bda-bb74-bac15ac8ceef', N'eeeef661-f871-435a-badd-be1d6c96765b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6107078d-d09d-4acb-ae99-787918038a96', N'179b7471-6f14-44c3-8b65-9fcaacb1372a', N'eeeef661-f871-435a-badd-be1d6c96765b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'655ad6be-887f-4b31-b164-e20f363f1c4c', N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', N'eeeef661-f871-435a-badd-be1d6c96765b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'73254a33-a704-496c-ba82-fb2b4bec7c95', N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', N'e6f0b965-7b14-48f9-8682-1e7cdc019386')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'79755079-ebe1-43ed-b105-812a624eb7ad', N'be1a5270-9d9f-409d-988e-e573128abf8a', N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'aeec329e-2fb2-4ff2-a0d6-0fe82f72129f', N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'eeeef661-f871-435a-badd-be1d6c96765b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b2993797-7ac4-419b-8b59-93f566a73937', N'4256493c-98b6-4a0e-9ba8-89ce04de832d', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cae286ee-4e1c-4fed-9c88-adb255eb3928', N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e0bfa8d4-561e-442d-a815-b022dbaca17e', N'b365a596-61f0-4ada-bc56-f455b9d56c51', N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f1149dce-0fcd-4671-9d9d-9ef67631d083', N'eb75b4cc-b859-40b2-b126-426faf885a6a', N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', N'Candidacy', N'1755151f-da27-40ad-b605-c51624e5779a', 4, N'Candidature', N'Candidacy', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', N'InterviewMark', N'1755151f-da27-40ad-b605-c51624e5779a', 5, N'NoteEntretien', N'InterviewMark', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', N'Interview', N'1755151f-da27-40ad-b605-c51624e5779a', 3, N'Entretien', N'Interview', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'e6f0b965-7b14-48f9-8682-1e7cdc019386', N'Offer', N'1755151f-da27-40ad-b605-c51624e5779a', 6, N'Offre', N'Offer', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'eeeef661-f871-435a-badd-be1d6c96765b', N'Recruitment', N'1755151f-da27-40ad-b605-c51624e5779a', 2, N'Recruitment', N'Recrutement', NULL, NULL, NULL, NULL, N'icon-note', 0)
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

--- Imen Chaaben Add SkillsFamily Authorisation

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6d3a46a1-2588-4816-be63-5d2518dc6701', N'SkillsFamily-UPDATE', 2, N'SkillsFamily-UPDATE', N'SkillsFamily-UPDATE', N'SkillsFamily-UPDATE', N'SkillsFamily-UPDATE', N'SkillsFamily-UPDATE', N'SkillsFamily-UPDATE', N'/payroll/skillsfamily/update', 1, N'UPDATE-SkillsFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7e97bd9c-d247-4d24-97aa-cafc8535848d', N'SkillsFamily-Show', 15, N'SkillsFamily-Show', N'SkillsFamily-Show', N'SkillsFamily-Show', N'SkillsFamily-Show', N'SkillsFamily-Show', N'SkillsFamily-Show', N'/payroll/skillsfamily/show', 1, N'SHOW-SkillsFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'966e921f-2d1b-4475-a540-87edecfb27ab', N'SkillsFamily-DELETE', 3, N'SkillsFamily-DELETE', N'SkillsFamily-DELETE', N'SkillsFamily-DELETE', N'SkillsFamily-DELETE', N'SkillsFamily-DELETE', N'SkillsFamily-DELETE', N'/payroll/skillsfamily/delete', 1, N'DELETE-SkillsFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a761f852-3928-467b-9867-7dcf3f55d8a7', N'SkillsFamily-LIST', 4, N'SkillsFamily-LIST', N'SkillsFamily-LIST', N'SkillsFamily-LIST', N'SkillsFamily-LIST', N'SkillsFamily-LIST', N'SkillsFamily-LIST', N'/payroll/skillsfamily/list', 1, N'LIST-SkillsFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', N'SkillsFamily-ADD', 1, N'SkillsFamily-ADD', N'SkillsFamily-ADD', N'SkillsFamily-ADD', N'SkillsFamily-ADD', N'SkillsFamily-ADD', N'SkillsFamily-ADD', N'/payroll/skillsfamily/add', 1, N'ADD-SkillsFamily')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'966e921f-2d1b-4475-a540-87edecfb27ab', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7e97bd9c-d247-4d24-97aa-cafc8535848d', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'38a92b23-2180-4497-ba96-0fe49758074f', 1, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'01208f64-3d89-40b9-93fb-4c681550c0ca', N'6d3a46a1-2588-4816-be63-5d2518dc6701', N'38a92b23-2180-4497-ba96-0fe49758074f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'07ecfcb5-7001-42c3-adae-596210a1673b', N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', N'38a92b23-2180-4497-ba96-0fe49758074f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7649668d-bfa4-4be0-b358-3546ac70a4e9', N'7e97bd9c-d247-4d24-97aa-cafc8535848d', N'38a92b23-2180-4497-ba96-0fe49758074f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'de251f8c-e6db-4a2a-bad1-a6347db0f356', N'a761f852-3928-467b-9867-7dcf3f55d8a7', N'38a92b23-2180-4497-ba96-0fe49758074f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e7aa6910-6716-4a79-88ff-04d88a008e7b', N'966e921f-2d1b-4475-a540-87edecfb27ab', N'38a92b23-2180-4497-ba96-0fe49758074f')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'38a92b23-2180-4497-ba96-0fe49758074f', N'SkillsFamily', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 35, N'SkillsFamily', N'SkillsFamily', N'SkillsFamily', N'SkillsFamily', N'SkillsFamily', N'SkillsFamily', N'icon-note', 0)

ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Rabeb ADD Delete Update candidate functionality

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'245ecc4a-fa91-44af-a51b-25d312f09006', N'Candidate-UPDATE', 2, N'Modifier candidat', N'Update candidate', NULL, NULL, NULL, NULL, N'/rh/candidate/update', 1, N'UPDATE-Candidate')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', N'Candidate-DELETE', 3, N'Supprimer candidat', N'Delete candidate', NULL, NULL, NULL, NULL, N'/rh/candidate/delete', 1, N'DELETE-Candidate')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'97682275-a556-4232-9c34-a4b7ea15ed81', N'Candidate-ADD', 1, N'Ajouter candidat', N'Add candidate', NULL, NULL, NULL, NULL, N'/rh/candidate/add', 1, N'ADD-Candidate')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'97682275-a556-4232-9c34-a4b7ea15ed81', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'245ecc4a-fa91-44af-a51b-25d312f09006', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'709e9e51-7280-4916-b737-ef2005e548eb', N'245ecc4a-fa91-44af-a51b-25d312f09006', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cffc7394-0ef4-43b7-99f2-ced92f273359', N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'db2ef721-a882-40b2-bbe2-2200c3d31290', N'97682275-a556-4232-9c34-a4b7ea15ed81', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Kossi 

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a2aa875a-6bcd-46cd-9845-aa51274725d8', N'Recruitment-Show', 15, N'Recruitment-Show', N'Recruitment-Show', NULL, NULL, NULL, NULL, N'/rh/recruitment/show', 0, N'SHOW-Recruitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', N'InterviewMark-Show', 15, N'InterviewMark-Show', N'InterviewMark-Show', NULL, NULL, NULL, NULL, N'/rh/interviewmark/show', 0, N'SHOW-InterviewMark')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'51fbd16e-36be-474a-860a-b220f2a2325b', N'a2aa875a-6bcd-46cd-9845-aa51274725d8', N'eeeef661-f871-435a-badd-be1d6c96765b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7fa21f0e-c1a1-4567-81c3-e73c198933ae', N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


-- Narcisse : Add CRA Erpsettings fonctionnality role 

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', N'TimeSheet-LIST', 4, N'Lister TimeSheet', N'List TimeSheet', NULL, NULL, NULL, NULL, N'/rh/TimeSheet/list', 0, N'LIST-TimeSheet')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', N'TimeSheet-Show', 15, N'Visualiser TimeSheet', N'Show TimeSheet', NULL, NULL, NULL, NULL, N'/rh/TimeSheet/show', 0, N'SHOW-TimeSheet')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'TimeSheet-ADD', 1, N'Ajouter TimeSheet', N'Add TimeSheet', NULL, NULL, NULL, NULL, N'/rh/TimeSheet/add', 0, N'ADD-TimeSheet')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', N'TimeSheet-UPDATE', 2, N'Modifier TimeSheet', N'Update TimeSheet', NULL, NULL, NULL, NULL, N'/rh/TimeSheet/update', 0, N'UPDATE-TimeSheet')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ee642289-11eb-4bf4-96d7-d29cf86f8af5', N'TimeSheet-DELETE', 3, N'Supprimer TimeSheet', N'Delete TimeSheet', NULL, NULL, NULL, NULL, N'/rh/TimeSheet/delete', 0, N'DELETE-TimeSheet')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ee642289-11eb-4bf4-96d7-d29cf86f8af5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 1, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0e5d1c56-96e7-4a52-82d2-9ee9df618540', N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'12882780-0c85-4d93-aa8f-b0126f1dff57', N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ccb3874d-d248-47cd-9f58-ab6525a1fb6b', N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ee6508fa-4fc0-42d3-8a94-f8240cd26d42', N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f232a39c-c179-4172-ba3e-ba5ae49dbc1f', N'ee642289-11eb-4bf4-96d7-d29cf86f8af5', N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', N'TimeSheet', N'1755151f-da27-40ad-b605-c51624e5779a', 2, N'TimeSheet', N'TimeSheet', NULL, NULL, NULL, NULL, N'icon-note', 0)


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', N'Project-ADD', 1, N'Ajouter projet', N'Add project', NULL, NULL, NULL, NULL, N'/rh/project/add', 0, N'ADD-Project')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', N'Project-Show', 15, N'Visualiser projet', N'Show project', NULL, NULL, NULL, NULL, N'/rh/project/show', 0, N'SHOW-Project')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'81dfe010-14a0-48a7-aa0d-48023d967286', N'Project-UPDATE', 2, N'Modifier projet', N'Update project', NULL, NULL, NULL, NULL, N'/rh/project/update', 0, N'UPDATE-Project')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', N'Project-DELETE', 3, N'Supprimer projet', N'Delete project', NULL, NULL, NULL, NULL, N'/rh/project/delete', 0, N'DELETE-Project')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', N'Project-LIST', 4, N'Lister projet', N'List project', NULL, NULL, NULL, NULL, N'/rh/project/list', 0, N'LIST-Project')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'81dfe010-14a0-48a7-aa0d-48023d967286', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'209a79da-52e8-4f40-8095-1380738d12aa', N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', N'ba3b0e01-71c9-4513-9d3e-2e94d681b195')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'84a37cc1-4746-41c5-a569-ab79372ffe0c', N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', N'ba3b0e01-71c9-4513-9d3e-2e94d681b195')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8767d70d-b2fd-4bf0-82b3-356ed30ac7de', N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', N'ba3b0e01-71c9-4513-9d3e-2e94d681b195')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9a9c4082-7e6c-441a-bd40-e5303106df22', N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', N'ba3b0e01-71c9-4513-9d3e-2e94d681b195')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bceda09c-81a8-4d8a-9db1-96002e37bf55', N'81dfe010-14a0-48a7-aa0d-48023d967286', N'ba3b0e01-71c9-4513-9d3e-2e94d681b195')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', N'Project', N'1755151f-da27-40ad-b605-c51624e5779a', 8, N'Projet', N'Project', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1337d415-a395-4c6f-8e50-3353d2144358', N'TimeSheetLine-DELETE', 3, N'Supprimer ligne cra', N'Delete line cra', NULL, NULL, NULL, NULL, N'/rh/timesheetline/delete', 0, N'DELETE-TimeSheetLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', N'TimeSheetLine-LIST', 4, N'Lister ligne cra', N'List line cra', NULL, NULL, NULL, NULL, N'/rh/timesheetline/list', 0, N'LIST-TimeSheetLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', N'TimeSheetLine-UPDATE', 2, N'Modifier ligne cra', N'Update line cra', NULL, NULL, NULL, NULL, N'/rh/timesheetline/update', 0, N'UPDATE-TimeSheetLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'be5d4975-be9a-498f-865d-d07f06ff89cd', N'TimeSheetLine-ADD', 1, N'Ajouter ligne CRA', N'Add line cra', NULL, NULL, NULL, NULL, N'/rh/timesheetline/add', 0, N'ADD-TimeSheetLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'be9a0ee8-d035-454f-9fd8-981126b40901', N'TimeSheetLine-Show', 15, N'Visualiser ligne cra', N'Show line cra', NULL, NULL, NULL, NULL, N'/rh/timesheetline/show', 0, N'SHOW-TimeSheetLine')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1337d415-a395-4c6f-8e50-3353d2144358', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'be9a0ee8-d035-454f-9fd8-981126b40901', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'6c3de305-9178-4b15-82f1-be6e1f801cb7', N'TimeSheetLine', N'1755151f-da27-40ad-b605-c51624e5779a', 9, N'Line de cra', N'Cra line', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'99c9de3c-8dd5-44ea-a63b-5f291991b27f', N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', N'6c3de305-9178-4b15-82f1-be6e1f801cb7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b3afba37-fae0-4ebe-b216-031acda3e2d3', N'1337d415-a395-4c6f-8e50-3353d2144358', N'6c3de305-9178-4b15-82f1-be6e1f801cb7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cd9ff2f3-66d7-4443-870a-aec42c67bb99', N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', N'6c3de305-9178-4b15-82f1-be6e1f801cb7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e2b759f2-1cb9-4278-9881-9a84e5ad3db9', N'be5d4975-be9a-498f-865d-d07f06ff89cd', N'6c3de305-9178-4b15-82f1-be6e1f801cb7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e542220c-324c-43a6-97f2-a3f1fdb9fe47', N'be9a0ee8-d035-454f-9fd8-981126b40901', N'6c3de305-9178-4b15-82f1-be6e1f801cb7')

ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

--Kossi add jobSkills functionnality by role

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', N'JobSkills-LIST', 4, N'JobSkills-LIST', N'JobSkills-LIST', NULL, NULL, NULL, NULL, N'/payroll/jobskills/list', 1, N'LIST-JobSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'93b2b36c-fac6-48af-822c-9e1b69c0c889', N'JobSkills-UPDATE', 2, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/jobskills/update', 0, N'UPDATE-JobSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd8f89701-7006-48e9-b2ec-0679551a0418', N'JobSkills-Show', 15, N'JobSkills-Show', N'JobSkills-Show', NULL, NULL, NULL, NULL, N'/payroll/jobskills/show', 1, N'SHOW-JobSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', N'JobSkills-SAVE', 6, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/jobskills/save', 1, N'SAVE-JobSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', N'JobSkills-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/jobskills/delete', 0, N'DELETE-JobSkills')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'2a5e908b-e151-4ea8-939a-8271b74b8a13', N'JobSkills', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 36, N'JobSkills', N'JobSkills', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'd8f89701-7006-48e9-b2ec-0679551a0418', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'214ddb0a-a9b1-4b6c-8ec1-a1ebb3c5192c', N'd8f89701-7006-48e9-b2ec-0679551a0418', N'2a5e908b-e151-4ea8-939a-8271b74b8a13')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'47da3ffa-a79b-4e10-b36a-171914f1b165', N'93b2b36c-fac6-48af-822c-9e1b69c0c889', N'2a5e908b-e151-4ea8-939a-8271b74b8a13')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'54bff9b1-eae6-44f1-98b8-1dfe2a260e17', N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', N'2a5e908b-e151-4ea8-939a-8271b74b8a13')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'82d782e4-8efa-46ce-a636-33d5a7e5128b', N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', N'2a5e908b-e151-4ea8-939a-8271b74b8a13')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cf491c24-7038-49e7-8872-dc50068ba4d8', N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', N'2a5e908b-e151-4ea8-939a-8271b74b8a13')

ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

-- Mohamed BOUZIDI add Functionality InterviewMark-CONFIRM
BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

UPDATE [ERPSettings].[RequestType] SET [RequestName]=N'CONFIRM' WHERE [Id]=7

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd131e823-79fb-48ac-827f-bb105e830abe', N'InterviewMark-CONFIRM', 7, N'Confirmer interview mark', N'Confirmer interview mark', N'Confirmer interview mark', N'Confirmer interview mark', N'Confirmer interview mark', N'Confirmer interview mark', N'/rh/interviewmark/confirm', 0, N'CONFIRM-InterviewMark')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd131e823-79fb-48ac-827f-bb105e830abe', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ab70ea15-6272-43d6-923f-c60870088c3c', N'd131e823-79fb-48ac-827f-bb105e830abe', N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a')

ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])

COMMIT TRANSACTION

-- Rabeb BEN SALAH add candidate show functionnality

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bc03c3e4-f361-4150-9dc5-53b253af072c', N'Candidate-Show', 15, N'Candidate-Show', N'Candidate-Show', N'Candidate-Show', N'Candidate-Show', N'Candidate-Show', N'Candidate-Show', N'/rh/candidate/show', 1, N'SHOW-Candidate')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ca6e5aa7-31e7-4c0a-8eb8-0520e8712eb1', N'bc03c3e4-f361-4150-9dc5-53b253af072c', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
--------- Marwa add functionnality of report--------
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4956ffa4-3f8b-4993-bda1-5860eab524aa', N'LIST-ReportTemplate', 4, N'LIST-ReportTemplate', N'LIST-ReportTemplate', N'LIST-ReportTemplate', N'LIST-ReportTemplate', N'LIST-ReportTemplate', N'LIST-ReportTemplate', N'/divers/diversfunctionalities/list', 0, N'LIST-ReportTemplate')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'908d7271-ef5a-4e69-abff-a79de26a8136', N'4956ffa4-3f8b-4993-bda1-5860eab524aa', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

--Rabeb add functionalities of EvaluationCriteriaTheme, EvaluationCriteria, CriteriaMark tables

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', N'EvaluationCriteria-ADD', 1, N'Ajouter critére d''évaluation', N'Add evaluation criteria', N'Add evaluation criteria', N'Add evaluation criteria', N'Add evaluation criteria', N'Add evaluation criteria', N'/rh/evaluationcriteria/add', 1, N'ADD-EvaluationCriteria')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'246c4f30-4c7b-460b-aebb-5d713455b050', N'EvaluationCriteria-UPDATE', 2, N'Update critére d''évaluation', N'Update evaluation criteria', N'Update evaluation criteria', N'Update evaluation criteria', N'Update evaluation criteria', N'Update evaluation criteria', N'/rh/evaluationcriteria/update', 1, N'UPDATE-EvaluationCriteria')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', N'EvaluationCriteria-DELETE', 3, N'Supprimer critére d''évaluation', N'Delete evaluation criteria', N'Delete evaluation criteria', N'Delete evaluation criteria', N'Delete evaluation criteria', N'Delete evaluation criteria', N'/rh/evaluationcriteria/delete', 1, N'DELETE-EvaluationCriteria')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3eb50693-0eb2-4050-b399-60591a44e130', N'CriteriaMark-LIST', 4, N'Liste note de critére', N'List criteria mark', N'List criteria mark', N'List criteria mark', N'List criteria mark', N'List criteria mark', N'/rh/criteriamark/list', 1, N'LIST-CriteriaMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', N'CriteriaMark-DELETE', 3, N'Supprimer note du critére', N'Delete Criteria Mark', N'Delete Criteria Mark', N'Delete Criteria Mark', N'Delete Criteria Mark', N'Delete Criteria Mark', N'/rh/criteriamark/delete', 1, N'DELETE-CriteriaMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', N'EvaluationCriteriaTheme-ADD', 1, N'Ajouter théme d''évaluation', N'Add Evaluation theme criteria', N'Add Evaluation theme criteria', N'Add Evaluation theme criteria', N'Add Evaluation theme criteria', N'Add Evaluation theme criteria', N'/rh/evaluationcriteriatheme/add', 1, N'ADD-EvaluationCriteriaTheme')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5883e2f9-d14e-4b50-9652-7894bcc15590', N'EvaluationCriteriaTheme-UPDATE', 2, N'Update théme du critére d''évaluation', N'Update evaluation criteria theme', N'Update evaluation criteria theme', N'Update evaluation criteria theme', N'Update evaluation criteria theme', N'Update evaluation criteria theme', N'/rh/evaluationcriteriatheme/update', 1, N'UPDATE-EvaluationCriteriaTheme')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5935921f-8dea-4799-baf8-2a1520e50204', N'EvaluationCriteriaTheme-LIST', 4, N'Liste théme du critére d''évaluation', N'Liste evaluation criteria theme', N'Liste evaluation criteria theme', N'Liste evaluation criteria theme', N'Liste evaluation criteria theme', N'Liste evaluation criteria theme', N'/rh/evaluationcriteriatheme/list', 1, N'LIST-EvaluationCriteriaTheme')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'654e8915-5ec5-4c80-aea1-376390d10dd1', N'EvaluationCriteriaTheme-Show', 15, N'Show théme de critére d''évaluation', N'Show evaluation criteria name', N'Show evaluation criteria name', N'Show evaluation criteria name', N'Show evaluation criteria name', N'Show evaluation criteria name', N'/rh/evaluationcriteriatheme/show', 1, N'SHOW-EvaluationCriteriaTheme')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8c874f57-c8bf-4239-96b0-a220ae4937cc', N'CriteriaMark-ADD', 1, N'Ajouter note du critére', N'Add Criteria Mark', N'Add Criteria Mark', N'Add Criteria Mark', N'Add Criteria Mark', N'Add Criteria Mark', N'/rh/criteriamark/add', 1, N'ADD-CriteriaMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9ba6f025-144f-416a-9497-2f556c27e278', N'EvaluationCriteria-Show', 15, N'Show critére d''évaluation', N'Show evaluation criteria', N'Show evaluation criteria', N'Show evaluation criteria', N'Show evaluation criteria', N'Show evaluation criteria', N'/rh/evaluationcriteria/show', 1, N'SHOW-EvaluationCriteria')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c28598d5-f067-4f50-85fa-1f727fc56de8', N'EvaluationCriteria-LIST', 4, N'Liste critére d''évaluation', N'List evaluation criteria', N'List evaluation criteria', N'List evaluation criteria', N'List evaluation criteria', N'List evaluation criteria', N'/rh/evaluationcriteria/list', 1, N'LIST-EvaluationCriteria')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd6eff940-0b49-4710-8cf6-dae5e168744d', N'CriteriaMark-Show', 15, N'Show note de critére', N'Show criteria mark', N'Show criteria mark', N'Show criteria mark', N'Show criteria mark', N'Show criteria mark', N'/rh/criteriamark/show', 1, N'SHOW-CriteriaMark')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'de313b3e-a99d-409e-bc43-546d11247a8c', N'EvaluationCriteriaTheme-DELETE', 3, N'Supprimer théme critére d''évaluation', N'Delete evaluation criteria theme', N'Delete evaluation criteria theme', N'Delete evaluation criteria theme', N'Delete evaluation criteria theme', N'Delete evaluation criteria theme', N'/rh/evaluationcriteriatheme/delete', 1, N'DELETE-EvaluationCriteriaTheme')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f69539b5-5133-4052-83f1-789cf707be89', N'CriteriaMark-UPDATE', 2, N'Update note du critére', N'Update Criteria Mark', N'Update Criteria Mark', N'Update Criteria Mark', N'Update Criteria Mark', N'Update Criteria Mark', N'/rh/criteriamark/update', 1, N'UPDATE-CriteriaMark')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'de313b3e-a99d-409e-bc43-546d11247a8c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5935921f-8dea-4799-baf8-2a1520e50204', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'246c4f30-4c7b-460b-aebb-5d713455b050', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'9ba6f025-144f-416a-9497-2f556c27e278', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f69539b5-5133-4052-83f1-789cf707be89', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3eb50693-0eb2-4050-b399-60591a44e130', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'25200373-be95-4c8b-8f47-ca13ef03341e', N'EvaluationCriteria', N'1755151f-da27-40ad-b605-c51624e5779a', 11, N'Critère d''évaluation', N'Evaluation Criteria', N'Evaluation Criteria', N'Evaluation Criteria', N'Evaluation Criteria', N'Evaluation Criteria', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'8a648529-4f11-4df5-b569-85958ea994f6', N'EvaluationCriteriaTheme', N'1755151f-da27-40ad-b605-c51624e5779a', 10, N'Thème des critères d''évaluation', N'Evaluation Criteria Theme', N'Evaluation Criteria Theme', N'Evaluation Criteria Theme', N'Evaluation Criteria Theme', N'Evaluation Criteria Theme', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'd4708d75-55ff-447c-b816-9bf8e174c28d', N'CriteriaMark', N'1755151f-da27-40ad-b605-c51624e5779a', 12, N'Note du critère ', N'Criteria Mark', N'Criteria Mark', N'Criteria Mark', N'Criteria Mark', N'Criteria Mark', N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'8a648529-4f11-4df5-b569-85958ea994f6', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'25200373-be95-4c8b-8f47-ca13ef03341e', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 1, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0b1f63cb-6f6a-4534-afd4-e01e999fd4da', N'8c874f57-c8bf-4239-96b0-a220ae4937cc', N'd4708d75-55ff-447c-b816-9bf8e174c28d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2c56efaf-9346-4267-86cb-dc206387bf61', N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', N'8a648529-4f11-4df5-b569-85958ea994f6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'49240e4c-2301-4167-814a-01966faff468', N'c28598d5-f067-4f50-85fa-1f727fc56de8', N'25200373-be95-4c8b-8f47-ca13ef03341e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4e4a5285-9d1b-4641-87aa-c6bb6ba53398', N'de313b3e-a99d-409e-bc43-546d11247a8c', N'8a648529-4f11-4df5-b569-85958ea994f6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5d0263ca-4e6a-4dee-960b-168f5019aad3', N'5883e2f9-d14e-4b50-9652-7894bcc15590', N'8a648529-4f11-4df5-b569-85958ea994f6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6b317bde-bb05-408c-9fdf-d3f34491a3f3', N'5935921f-8dea-4799-baf8-2a1520e50204', N'8a648529-4f11-4df5-b569-85958ea994f6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'71e0a248-fced-4203-855d-36671f29d55c', N'654e8915-5ec5-4c80-aea1-376390d10dd1', N'8a648529-4f11-4df5-b569-85958ea994f6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7e381beb-aeec-46c2-a2eb-4787ba6e173b', N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', N'25200373-be95-4c8b-8f47-ca13ef03341e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'87659cbf-4d7f-4349-be75-c2bbf3d2d653', N'f69539b5-5133-4052-83f1-789cf707be89', N'd4708d75-55ff-447c-b816-9bf8e174c28d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'87b19185-e834-4eaf-93e5-6fe83fcc1aed', N'd6eff940-0b49-4710-8cf6-dae5e168744d', N'd4708d75-55ff-447c-b816-9bf8e174c28d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'87df0f6a-3fa3-485d-a6f3-6e296831632e', N'3eb50693-0eb2-4050-b399-60591a44e130', N'd4708d75-55ff-447c-b816-9bf8e174c28d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8acb3636-aa09-44f6-a4a3-e6e9e952533b', N'246c4f30-4c7b-460b-aebb-5d713455b050', N'25200373-be95-4c8b-8f47-ca13ef03341e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9882ef21-67d7-4402-b6e0-3c33a49b4b9d', N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', N'd4708d75-55ff-447c-b816-9bf8e174c28d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'99d24ae6-e0e7-427a-b80b-fe869cc426d5', N'9ba6f025-144f-416a-9497-2f556c27e278', N'25200373-be95-4c8b-8f47-ca13ef03341e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e9891fd3-339f-402e-a09a-f8c7d42ba238', N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', N'25200373-be95-4c8b-8f47-ca13ef03341e')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

------ Kossi add rôle to the table advantages

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', N'Advantages', N'1755151f-da27-40ad-b605-c51624e5779a', 10, N'Advantages', N'Advantages', N'Advantages', NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', N'Advantages-Show', 15, N'Advantages-Show', N'Advantages-Show', NULL, NULL, NULL, NULL, N'/rh/advantages/show', 1, N'SHOW-Advantages')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', N'Advantages-LIST', 4, N'Advantages-LIST', N'Advantages-LIST', NULL, NULL, NULL, NULL, N'/rh/advantages/list', 1, N'LIST-Advantages')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a7310087-e271-40ea-ae49-60d76ede699c', N'Advantages-DELETE', 3, N'Advantages-DELETE', N'Advantages-DELETE', NULL, NULL, NULL, NULL, N'/rh/advantages/delete', 1, N'DELETE-Advantages')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', N'Advantages-UPDATE', 2, N'Advantages-UPDATE', N'Advantages-UPDATE', NULL, NULL, NULL, NULL, N'/rh/advantages/update', 1, N'UPDATE-Advantages')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f12d6dde-f573-4a78-b960-91cfeeb56643', N'Advantages-ADD', 1, N'Advantages-ADD', N'Advantages-ADD', NULL, NULL, NULL, NULL, N'/rh/advantages/add', 1, N'ADD-Advantages')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a7310087-e271-40ea-ae49-60d76ede699c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1a3ddc93-de43-4ee3-ade4-01ba8745ca67', N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1b301497-f735-44a2-9628-f0344ba4e32d', N'f12d6dde-f573-4a78-b960-91cfeeb56643', N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'471581bc-c537-4125-aafc-96613d045993', N'a7310087-e271-40ea-ae49-60d76ede699c', N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'825e45b1-485e-478b-a46f-24510b1e12e3', N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a0fc139b-ffa2-4167-9e67-4f33409072e0', N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 1, 1)

ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION

--Mohamed	BOUZIDI

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5f376240-3764-4733-a269-aad8b2f2b886', N'Email-UPDATE', 2, N'Modifier email', N'Update email', N'Update email', N'Update email', N'Update email', N'Update email', N'/administration/email/update', 0, N'UPDATE-Email')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e38245ee-78ad-485c-8944-e3ea979ca9ce', N'Email-Show', 15, N'Afficher email', N'Show email', N'Show email', N'Show email', N'Show email', N'Show email', N'/administration/email/show', 1, N'SHOW-Email')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', N'Email-ADD', 1, N'Ajouter email', N'Add email', N'Add email', N'Add email', N'Add email', N'Add email', N'/administration/email/add', 0, N'ADD-Email')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0356eb50-3f15-4843-88ea-a130922a1ced', N'Email-DELETE', 3, N'Supprimer email', N'Delete email', N'Delete email', N'Delete email', N'Delete email', N'Delete email', N'/administration/email/delete', 0, N'DELETE-Email')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'41328f04-b725-4435-837b-082e169aea31', N'Email-LIST', 4, N'Liste des email', N'Email list', N'Email list', N'Email list', N'Email list', N'Email list', N'/administration/email/list', 0, N'LIST-Email')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5f376240-3764-4733-a269-aad8b2f2b886', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0356eb50-3f15-4843-88ea-a130922a1ced', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'41328f04-b725-4435-837b-082e169aea31', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'774797ca-2d8a-4896-b499-ed0b6c3cecc5', N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', N'e5947a1e-9db3-486a-b26c-b33be5e0a82e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b187194a-a858-41cd-a179-356a425fdab5', N'5f376240-3764-4733-a269-aad8b2f2b886', N'e5947a1e-9db3-486a-b26c-b33be5e0a82e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e920e269-3a48-40b2-92d3-883fe79cee18', N'e38245ee-78ad-485c-8944-e3ea979ca9ce', N'e5947a1e-9db3-486a-b26c-b33be5e0a82e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3af1edfc-dc2c-43f5-8d77-742d350d0f90', N'41328f04-b725-4435-837b-082e169aea31', N'e5947a1e-9db3-486a-b26c-b33be5e0a82e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9377a339-e5bb-4bcc-8a50-0c362ebcc600', N'0356eb50-3f15-4843-88ea-a130922a1ced', N'e5947a1e-9db3-486a-b26c-b33be5e0a82e')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', N'Email', N'efa1d60e-933b-4749-bac3-a15e8bba3415', 18, N'Email', N'Email', N'Email', N'Email', N'Email', N'Email', N'icon-note', 0)

ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

-- Imen chaaben : Add codification Leave, Document request and Expense report 

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]

UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0002' WHERE [Id]=90
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'00000001' WHERE [Id]=97
UPDATE [ERPSettings].[Codification] SET [Name]=N'LeaveCodification', [Rank]=NULL, [IdCodificationParent]=NULL, [IsCounter]=0, [Step]=NULL, [LastCounterValue]=NULL, [CounterLength]=NULL WHERE [Id]=140

SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501078, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a ajouté un commentaire pour la demande de note de frais {CODE}', N'{CREATOR} added a comment for the expense report request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_EXPENSE_REPORT_REQUEST', N'ADD_COMMENT_EXPENSE_REPORT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501079, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a ajouté un commentaire pour la demande de congés {CODE}', N'{CREATOR} added a comment for the leave request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_LEAVE_REQUEST', N'ADD_COMMENT_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501080, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a ajouté un commentaire pour la demande de document {CODE}', N'{CREATOR} added a comment for the document request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_DOCUMENT_REQUEST', N'ADD_COMMENT_DOCUMENT_REQUEST')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF

SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (379, N'Payroll', N'ExpenseReportRequest', N'ExpenseReportRequest', NULL, 0, N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (381, N'Payroll', N'LeaveRequest', N'LeaveRequest', NULL, 0, N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (382, N'Payroll', N'DocumentRequest', N'DocumentRequest', NULL, 0, N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (384, N'Payroll', N'ExpenseReport', N'ExpenseReport', NULL, 0, N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (390, N'Payroll', N'Leave', N'Leave', NULL, 0, N'Leave', N'Leave', N'Leave', N'Leave', N'Leave', N'Leave', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', N'Leave-SHOW', 15, N'Leave-SHOW', N'Leave-SHOW', N'Leave-SHOW', N'Leave-SHOW', N'Leave-SHOW', N'Leave-SHOW', N'/payroll/leave/show', 1, N'SHOW-Leave')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a682c7d3-6e4e-421b-815b-b55711c24a18', N'DocumentRequest-SHOW', 15, N'DocumentRequest-SHOW', N'DocumentRequest-SHOW', N'DocumentRequest-SHOW', N'DocumentRequest-SHOW', N'DocumentRequest-SHOW', N'DocumentRequest-SHOW', N'/payroll/documentrequest/show', 1, N'SHOW-DocumentRequest')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1, 1, 1, NULL)

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (32, 382, NULL, NULL, 159)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (33, 384, NULL, NULL, 155)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (34, 390, NULL, NULL, 140)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b3bb1ac4-7c70-434c-86e8-bb55c9ca285a', N'a682c7d3-6e4e-421b-815b-b55711c24a18', N'949f1777-0d49-4e49-b776-34e801b9da85')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e380231b-d38b-43c8-a318-275ba7a43cfe', N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (142, N'CaractereL', 1, NULL, NULL, N'L', 140, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (143, N'Caractere-', 2, NULL, NULL, N'-', 140, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (144, N'compteurLeave', 3, NULL, NULL, NULL, 140, 1, 1, N'00000001', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (155, N'ExpenseReportCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (156, N'CaractereER', 1, NULL, NULL, N'ER', 155, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (157, N'Caractere-', 2, NULL, NULL, N'-', 155, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (158, N'compteurExpenseReport', 3, NULL, NULL, NULL, 155, 1, 1, N'00000001', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (159, N'DocumentRequestCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (160, N'CaractereDR', 1, NULL, NULL, N'DR', 159, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (161, N'Caractere-', 2, NULL, NULL, N'-', 159, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (162, N'compteurDocumentRequest', 3, NULL, NULL, NULL, 159, 1, 1, N'00000001', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

--- Imen chaaben : give the role of admin to user houcem and marwa

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Employee]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_User]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
UPDATE [ERPSettings].[UserRole] SET [IdRole]=1 WHERE [Id]=3
UPDATE [ERPSettings].[UserRole] SET [IdRole]=1 WHERE [Id]=4
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

---- Imen chaaben : add information (add/update/delete/validate/cancel/refuse) to leave , expense report and document request

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a ajouté une demande de congé {PROFIL}', N'{CREATOR} added a new leave request  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_LEAVE_REQUEST', N'ADD_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a ajouté demande de note de frais {PROFIL}', N'{CREATOR} added a new expense report {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_EXPENSE_REPORT', N'ADD_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a ajouté une demande de document {PROFIL}', N'{CREATOR} added a new document request {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_DOCUMENT_REQUEST', N'ADD_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a modifié la demande de congé {CODE}  {PROFIL}', N'{CREATOR} updated the leave request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_LEAVE_REQUEST', N'UPDATE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a modifié la demande de note de frais {CODE} {PROFIL}', N'{CREATOR} updated the expense report {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_EXPENSE_REPORT', N'UPDATE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a modifié la demande de document {CODE} {PROFIL}', N'{CREATOR} updated the document request {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_DOCUMENT_REQUEST', N'UPDATE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a validé la demande de congé {CODE}  {PROFIL}', N'{CREATOR} validated the leave request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_LEAVE_REQUEST', N'VALIDATE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a validé la demande de note de frais {CODE} {PROFIL}', N'{CREATOR} validated the expense report {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_EXPENSE_REPORT', N'VALIDATE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a validé la demande de document {CODE} {PROFIL}', N'{CREATOR} validated the document request {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_DOCUMENT_REQUEST', N'VALIDATE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a refusé la demande de congé {CODE}  {PROFIL}', N'{CREATOR} refused the leave request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_LEAVE_REQUEST', N'REFUSE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a refusé la demande de note de frais {CODE} {PROFIL}', N'{CREATOR} refused the expense report {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_EXPENSE_REPORT', N'REFUSE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a refusé la demande de document {CODE} {PROFIL}', N'{CREATOR} refused the document request {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_DOCUMENT_REQUEST', N'REFUSE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a annulé la demande de congé {CODE}  {PROFIL}', N'{CREATOR} canceled the leave request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CANCEL_LEAVE_REQUEST', N'CANCEL_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'a94a17a2-60ed-4bde-a307-22787ea95b96', N'/payroll/leave', N'{CREATOR} a supprimé une demande de congé {CODE} {PROFIL}', N'{CREATOR} removed the leave request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_LEAVE_REQUEST', N'DELETE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', N'/payroll/expenseReport', N'{CREATOR} a supprimé une demande de note de frais {CODE} {PROFIL}', N'{CREATOR} removed the expense report {CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_EXPENSE_REPORT', N'DELETE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'788872dc-bdd0-4558-b3c8-37af3fda8a42', N'/payroll/document', N'{CREATOR} a supprimé une demande de document {CODE} {PROFIL}', N'{CREATOR} removed the document request {CODE}  {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_DOCUMENT_REQUEST', N'DELETE_DOCUMENT_REQUEST')



ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_PaymentType]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Citizenship]
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=32 WHERE [Id]=8
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=7 WHERE [Id]=32
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=32 WHERE [Id]=42
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Payroll].[Employee]
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id])
COMMIT TRANSACTION

---- Nihel: Add role delete for purchase budget/ delete role Document-DELETE
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'6d9bf8f8-23f9-476f-bf61-705f9a65882b'
DELETE FROM [ERPSettings].[FunctionalityByRole] WHERE [IdFunctionality]=N'038d55eb-5628-48f0-bc28-60e9b3a19a93'
DELETE FROM [ERPSettings].[Functionality] WHERE [IdFunctionality]=N'038d55eb-5628-48f0-bc28-60e9b3a19a93'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'288e8c5c-d015-4000-a5f8-2c2aac406922', N'DELETE-PurchaseBudget', 3, N'DELETE-PurchaseBudget', N'DELETE-PurchaseBudget', N'DELETE-PurchaseBudget', N'DELETE-PurchaseBudget', N'DELETE-PurchaseBudget', N'DELETE-PurchaseBudget', N'/purchase/purchasebudget/delete', 0, N'DELETE-PurchaseBudget')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a1f5890e-370d-48da-9754-e60e2b7ed2bf', N'288e8c5c-d015-4000-a5f8-2c2aac406922', N'1b8c288b-6fb4-4816-964b-ce7b89339db9')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dec4c280-cc66-4fbf-8317-4a3d70a234fa', N'PurchaseSettings-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/PurchaseSettings/list', 0, N'LIST-PurchaseSettings')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'dec4c280-cc66-4fbf-8317-4a3d70a234fa', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b9416109-bb0d-4633-9f80-fe774ece90fc', N'dec4c280-cc66-4fbf-8317-4a3d70a234fa', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


-- Mohamed BOUZIDI Add, Delete interviewer infos

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur requis pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a required interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_REQUIRED_INTERVIEWER', N'ADDED_AS_REQUIRED_INTERVIEWER')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_OPTIONAL_INTERVIEWER', N'ADDED_AS_OPTIONAL_INTERVIEWER')
INSERT INTO [ERPSettings].[Information] ([IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_DELETE_INTERVIEWER', N'DELETED_FROM_INTERVIEWER_LIST')
COMMIT TRANSACTION

-- Narcisse : Add Period, Hours and DayOff settings

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0233c973-c596-466d-8315-716d3f7d195c', N'DayOff-DELETE', 3, N'Supprimer jour férié', N'Delete day off', NULL, NULL, NULL, NULL, N'/administration/dayoff/delete', 0, N'DELETE-DayOff')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'042a7bfc-5033-4490-aa0a-89790832f895', N'DayOff-ADD', 1, N'Ajouter jours fériés', N'Add day off', NULL, NULL, NULL, NULL, N'/administration/dayoff/add', 0, N'ADD-DayOff')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'04564a71-cc75-4d65-934f-03d6598429df', N'Period-Show', 15, N'Visualiser période', N'Show period', NULL, NULL, NULL, NULL, N'/administration/period/show', 0, N'SHOW-Period')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', N'DayOff-Show', 15, N'Visualiser jour férié', N'Show day off', NULL, NULL, NULL, NULL, N'/administration/dayoff/show', 0, N'SHOW-DayOff')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0f288531-ba96-438f-b70d-5775de191ee2', N'Period-UPDATE', 2, N'Modifier période', N'Update period', NULL, NULL, NULL, NULL, N'/administration/period/update', 0, N'UPDATE-Period')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1d96dfb4-c37d-4662-9527-d71b4834dd98', N'Hours-ADD', 1, N'Ajouter horaires', N'Add hours', NULL, NULL, NULL, NULL, N'/administration/hours/add', 0, N'ADD-Hours')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4bdedc60-9873-481d-aeab-53422bfe8d00', N'Period-LIST', 4, N'Lister périod', N'List period', NULL, NULL, NULL, NULL, N'/administration/period/list', 0, N'LIST-Period')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7244e0a8-83d4-41d0-92ae-8315df470382', N'DayOff-LIST', 4, N'Lister jours fériés', N'List day off', NULL, NULL, NULL, NULL, N'/administration/dayoff/list', 0, N'LIST-DayOff')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', N'Hours-LIST', 4, N'Lister horaires', N'List hours', NULL, NULL, NULL, NULL, N'/administration/hours/list', 0, N'LIST-Hours')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', N'Hours-UPDATE', 2, N'Modifier horaires', N'Update hours', NULL, NULL, NULL, NULL, N'/administration/hours/update', 0, N'UPDATE-Hours')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb29c5d6-6493-402c-891b-21d6cffda4a0', N'Hours-DELETE', 3, N'Supprimer horaires', N'Delete hours', NULL, NULL, NULL, NULL, N'/administration/hours/delete', 0, N'DELETE-Hours')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', N'Hours-Show', 15, N'Visualiser horaires', N'Show hours', NULL, NULL, NULL, NULL, N'/administration/hours/show', 0, N'SHOW-Hours')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e0598603-65e3-413a-b375-df073ea07f6d', N'DayOff-UPDATE', 2, N'Modifier jour férié', N'Update day off', NULL, NULL, NULL, NULL, N'/administration/dayoff/update', 0, N'UPDATE-DayOff')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', N'Period-DELETE', 3, N'Suppriméer période', N'Delete period', NULL, NULL, NULL, NULL, N'/administration/period/delete', 0, N'DELETE-Period')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fb852cd7-b559-4a45-815a-46b71f80d49b', N'Period-ADD', 1, N'Ajouter période', N'Add period', NULL, NULL, NULL, NULL, N'/administration/period/add', 0, N'ADD-Period')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0aed73ee-5b23-4b9e-934d-d10d458e6d7f', N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', N'289338c0-09ad-46e1-a893-c1aa2ed79cf4')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1b7d01be-cfc1-484d-b300-fa706237fc55', N'0f288531-ba96-438f-b70d-5775de191ee2', N'afd3d290-ace7-4571-9444-4334f3171856')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'203ce4f7-1713-41e0-a618-0c779ec84164', N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', N'904decde-cef0-4150-9883-83e9839387c2')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'22a41e4f-451c-4fda-9299-8600207120b3', N'042a7bfc-5033-4490-aa0a-89790832f895', N'289338c0-09ad-46e1-a893-c1aa2ed79cf4')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'34c9d6bf-f1ee-4f6d-9e74-8eb453d640b8', N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', N'904decde-cef0-4150-9883-83e9839387c2')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'44f83c1c-5edc-4b67-879c-63e4bb28e722', N'4bdedc60-9873-481d-aeab-53422bfe8d00', N'afd3d290-ace7-4571-9444-4334f3171856')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4a0b133a-dac9-4b37-99a7-355a1c538e0d', N'cb29c5d6-6493-402c-891b-21d6cffda4a0', N'904decde-cef0-4150-9883-83e9839387c2')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8afd726b-583c-4081-9aa3-7d72e77bafad', N'fb852cd7-b559-4a45-815a-46b71f80d49b', N'afd3d290-ace7-4571-9444-4334f3171856')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'987c0674-63bd-4768-aaaf-0ecaa6135f84', N'7244e0a8-83d4-41d0-92ae-8315df470382', N'289338c0-09ad-46e1-a893-c1aa2ed79cf4')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a11d96b1-55fd-4a1c-8cd6-a8d7ac3e8b22', N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', N'904decde-cef0-4150-9883-83e9839387c2')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ba4d0a04-b217-4a94-8459-39354038393f', N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', N'afd3d290-ace7-4571-9444-4334f3171856')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c512be44-6762-4239-ad69-18ae784da664', N'e0598603-65e3-413a-b375-df073ea07f6d', N'289338c0-09ad-46e1-a893-c1aa2ed79cf4')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c66bedd6-1353-46d6-8300-0dc0b0a710f0', N'1d96dfb4-c37d-4662-9527-d71b4834dd98', N'904decde-cef0-4150-9883-83e9839387c2')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cdc01f24-b362-49d6-b111-347411adcdf2', N'04564a71-cc75-4d65-934f-03d6598429df', N'afd3d290-ace7-4571-9444-4334f3171856')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd88d3e7f-fa7d-4437-a354-81794b0f122f', N'0233c973-c596-466d-8315-716d3f7d195c', N'289338c0-09ad-46e1-a893-c1aa2ed79cf4')


INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0f288531-ba96-438f-b70d-5775de191ee2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'04564a71-cc75-4d65-934f-03d6598429df', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'042a7bfc-5033-4490-aa0a-89790832f895', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e0598603-65e3-413a-b375-df073ea07f6d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0233c973-c596-466d-8315-716d3f7d195c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7244e0a8-83d4-41d0-92ae-8315df470382', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', N'DayOff', N'efa1d60e-933b-4749-bac3-a15e8bba3415', 20, N'Jours fériés', N'Day off', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'904decde-cef0-4150-9883-83e9839387c2', N'Hours', N'efa1d60e-933b-4749-bac3-a15e8bba3415', 21, N'Heures', N'Hours', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'afd3d290-ace7-4571-9444-4334f3171856', N'Period', N'efa1d60e-933b-4749-bac3-a15e8bba3415', 19, N'Période', N'Period', NULL, NULL, NULL, NULL, N'icon-note', 0)


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'afd3d290-ace7-4571-9444-4334f3171856', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'904decde-cef0-4150-9883-83e9839387c2', 1, 1)


ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

--- Kossi add role SHOW to Offer
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3673f6cc-59f1-469e-b4ee-126df11d65bf', N'2676ade9-b20a-485d-be49-f5f839e90b7b', N'e6f0b965-7b14-48f9-8682-1e7cdc019386')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2676ade9-b20a-485d-be49-f5f839e90b7b', N'Offer-Show', 15, N'Offer-Show', N'Offer-Show', NULL, NULL, NULL, NULL, N'/rh/offer/show', 1, N'SHOW-Offer')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION


-- Mohamed BOUZIDI Interview type authorisation

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'927010d6-12da-45af-9a65-a453d766cfcf', N'InterviewType', N'1755151f-da27-40ad-b605-c51624e5779a', 14, N'Type d''entretien', N'Interview type', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1770f0f8-d67a-4966-9487-742d8a397019', N'44606826-3f05-44b7-a790-85527f1e8ac8', N'927010d6-12da-45af-9a65-a453d766cfcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'65943c8d-23da-4bb4-8272-61aef186f155', N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', N'927010d6-12da-45af-9a65-a453d766cfcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'93093902-53d2-46a6-b9d6-d3b3aa656926', N'e29d1e20-fb42-47a3-8315-0af62753b0ea', N'927010d6-12da-45af-9a65-a453d766cfcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'96e07ab3-c9b1-493c-8b65-63f32c5c3f7a', N'abfa596e-2286-4024-90dc-b8cb507a96f2', N'927010d6-12da-45af-9a65-a453d766cfcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9b6cad8e-4393-4f0a-9a88-7c3832a4c7fc', N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', N'927010d6-12da-45af-9a65-a453d766cfcf')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'927010d6-12da-45af-9a65-a453d766cfcf', 1, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'44606826-3f05-44b7-a790-85527f1e8ac8', N'InterviewType-UPDATE', 2, N'Mettre à jour type d''entretien', N'Interview Type UPDATE', NULL, NULL, NULL, NULL, N'/rh/interviewtype/update', 0, N'UPDATE-InterviewType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', N'InterviewType-Show', 15, N'Afficher type d''entretien', N'Show interview type', NULL, NULL, NULL, NULL, N'/rh/interviewtype/show', 0, N'SHOW-InterviewType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'abfa596e-2286-4024-90dc-b8cb507a96f2', N'InterviewType-DELETE', 3, N'Supprimer type d''entretien', N'Interview Type DELETE', NULL, NULL, NULL, NULL, N'/rh/interviewtype/delete', 0, N'DELETE-InterviewType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e29d1e20-fb42-47a3-8315-0af62753b0ea', N'InterviewType-ADD', 1, N'Ajouter type d''entretien', N'Add interview type', NULL, NULL, NULL, NULL, N'/rh/interviewtype/add', 0, N'ADD-InterviewType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', N'InterviewType-LIST', 4, N'Liste des types d''entretien', N'Interview Type LIST', NULL, NULL, NULL, NULL, N'/rh/interviewtype/list', 0, N'LIST-InterviewType')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'44606826-3f05-44b7-a790-85527f1e8ac8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION

--- Imen chaaben: change notification in leave, expense report and document request message 

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a ajouté un commentaire pour la demande du congés {CODE}' WHERE [IdInfo]=1000501079
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a ajouté un commentaire pour la demande du document {CODE}' WHERE [IdInfo]=1000501080
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a ajouté une demande de congé {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501081
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a ajouté demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a ajouté une demande de document {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501083
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a modifié la demande de congé {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501084
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a modifié la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a modifié la demande de document {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501086
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a validé la demande de congé {DOC_CODE}  {PROFIL}' WHERE [IdInfo]=1000501087
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a validé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a validé la demande de document {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501089
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a refusé la demande de congé {DOC_CODE}  {PROFIL}' WHERE [IdInfo]=1000501090
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a refusé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a refusé la demande de document {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501092
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a annulé la demande de congé {DOC_CODE}  {PROFIL}' WHERE [IdInfo]=1000501093
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a supprimé une demande de congé {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501094
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a supprimé une demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
UPDATE [ERPSettings].[Information] SET [FR]=N'{CREATOR} a supprimé une demande de document {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501096
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

-- Narcisse: Add Employee Project Erp settings data

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]


INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'49c4d264-53af-4038-8466-2ee31b3b915c', N'EmployeeProject', N'1755151f-da27-40ad-b605-c51624e5779a', 14, N'EmployeeProject', NULL, NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0766f4c8-bdeb-4aa7-a796-2a2afcbe9539', N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', N'49c4d264-53af-4038-8466-2ee31b3b915c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0be19505-a021-4725-b05d-1071a552720e', N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', N'49c4d264-53af-4038-8466-2ee31b3b915c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'438d83db-e398-4ecf-a3cc-9050fdf15c01', N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', N'49c4d264-53af-4038-8466-2ee31b3b915c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cd7812a3-e66f-43ef-b09e-af02fb31ae85', N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', N'49c4d264-53af-4038-8466-2ee31b3b915c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f3b57cc8-daee-41b7-9d5b-72f3ccb60a94', N'4902b1fc-d541-4288-85c4-5fec5a8840f6', N'49c4d264-53af-4038-8466-2ee31b3b915c')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', N'EmployeeProject-Show', 15, N'Visulaiser projet employe', N'Show employee project', NULL, NULL, NULL, NULL, N'/rh/employeeproject/show', 0, N'SHOW-EmployeeProject')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4902b1fc-d541-4288-85c4-5fec5a8840f6', N'EmployeeProject-ADD', 1, N'Ajouter projet employe', N'Add employee project', NULL, NULL, NULL, NULL, N'/rh/employeeproject/add', 0, N'ADD-EmployeeProject')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', N'EmployeeProject-LIST', 4, N'Lister projet employe', N'List employee project', NULL, NULL, NULL, NULL, N'/rh/employeeproject/list', 0, N'LIST-EmployeeProject')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', N'EmployeeProject-DELETE', 3, N'Supprimer projet employe', N'Delete employee project', NULL, NULL, NULL, NULL, N'/rh/employeeproject/delete', 0, N'DELETE-EmployeeProject')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', N'EmployeeProject-UPDATE', 2, N'Modifier projet employe', N'Update employee project', NULL, NULL, NULL, NULL, N'/rh/employeeproject/update', 0, N'UPDATE-EmployeeProject')


INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'49c4d264-53af-4038-8466-2ee31b3b915c', 1, 1)

ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION


--- Imen chaaben: notification msg in leave request, document request and expense report
BEGIN TRANSACTION
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} added a new leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501081
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} added a new expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} added a new document request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501083
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} updated the leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501084
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} updated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} updated the document request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501086
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} validated the leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501087
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} validated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} validated the document request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501089
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} refused the leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501090
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} refused the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} refused the document request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501092
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} canceled the leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501093
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} removed the leave request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501094
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} removed the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
UPDATE [ERPSettings].[Information] SET [EN]=N'{CREATOR} removed the document request {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501096
COMMIT TRANSACTION

--- Imen chaaben: add VALIDATE-ExpenseReport AND VALIDATE-DocumentRequest features
BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', N'ExpenseReport-VALIDATE', 8, N'ExpenseReport-VALIDATE', N'ExpenseReport-VALIDATE', N'ExpenseReport-VALIDATE', N'ExpenseReport-VALIDATE', N'ExpenseReport-VALIDATE', N'ExpenseReport-VALIDATE', N'/payroll/expensereport/validate', 1, N'VALIDATE-ExpenseReport')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'23d69255-7c68-459f-8f3e-b19bdf4e1498', N'DocumentRequest-VALIDATE', 8, N'DocumentRequest-VALIDATE', N'DocumentRequest-VALIDATE', N'DocumentRequest-VALIDATE', N'DocumentRequest-VALIDATE', N'DocumentRequest-VALIDATE', N'DocumentRequest-VALIDATE', N'/payroll/documentrequest/validate', 1, N'VALIDATE-DocumentRequest')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'54e83ada-7a21-4823-8895-7b7798b04d30', N'23d69255-7c68-459f-8f3e-b19bdf4e1498', N'949f1777-0d49-4e49-b776-34e801b9da85')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dcde5f97-70d4-4edc-80d7-137d80797dbf', N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', N'5dcb7310-a80e-40fa-8e09-dc64537a2e10')
COMMIT TRANSACTION

--fatma 

BEGIN TRANSACTION 
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', N'Contact-Show', 15, N'Contact-Show', N'Contact-Show', N'Contact-Show', N'Contact-Show', N'Contact-Show', N'Contact-Show', N'/divers/diversfunctionalities/show', 0, N'SHOW-Contact')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', N'Tiers-SHOW', 15, N'Show-Tiers', N'Show-Tiers', N'Show-Tiers', N'Show-Tiers', N'Show-Tiers', N'Show-Tiers', N'/divers/diversfunctionalities/show', 0, N'SHOW-Tiers')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0e41f9e8-9dd6-4343-a46a-ae6469e7f358', N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c83547b8-b13f-4b87-ae51-57755d6f831d', N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', N'f40650cb-aa58-48a8-a4df-9744e6b81698')

ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION