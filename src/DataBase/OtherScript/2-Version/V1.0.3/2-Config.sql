
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
GO
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'05b91908-5bf4-4bdd-a308-0e265b1a3eb1', N'TrainingByEmployee-Show', 15, N'TrainingByEmployee-Show', N'TrainingByEmployee-Show', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/show', 0, N'SHOW-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0723db00-80a1-4125-855d-499d87c4ac90', N'TrainingSession-ADD', 1, N'TrainingSession-ADD', N'TrainingSession-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingsession/add', 1, N'ADD-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'091cdee7-2d1d-4ce7-a78c-259f714f4fbe', N'Training-ADD', 1, N'Training-ADD', N'Training-ADD', NULL, NULL, NULL, NULL, N'/rh/training/add', 1, N'ADD-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0b100835-2d9f-4822-988d-8398825d890c', N'TrainingByEmployee-LIST', 4, N'TrainingByEmployee-LIST', N'TrainingByEmployee-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/list', 0, N'LIST-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'12900316-455b-457e-9608-99bd7784b5b4', N'TrainingByEmployee-DELETE', 3, N'TrainingByEmployee-DELETE', N'TrainingByEmployee-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/delete', 1, N'DELETE-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'146bfe6d-dfbf-4a94-8466-1b11563e23ad', N'RecruitmentRequest-DELETE', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'DELETE-RecruitmentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'176d82de-4723-4ed2-bc44-2775f36965c3', N'SourceDeductionSession-UPDATE', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'UPDATE-SourceDeductionSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1a363e4d-7b0a-4068-b3f3-9e18156d8f02', N'RecruitmentOffer-SHOW', 15, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/show', 0, N'SHOW-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1aebf541-0e2c-4bc5-b831-7e279c18e07f', N'TrainingExpectedSkills-ADD', 1, N'TrainingExpectedSkills-ADD', N'TrainingExpectedSkills-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/add', 1, N'ADD-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1be65a49-42aa-4b69-ae86-3e338a534397', N'TrainingRequest-DELETE', 3, N'TrainingRequest-DELETE', N'TrainingRequest-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/delete', 0, N'DELETE-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1c185dc5-ffc3-4c5a-8b57-999f0ec1b8d2', N'TrainingRequiredSkills-UPDATE', 2, N'TrainingRequiredSkills-UPDATE', N'TrainingRequiredSkills-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/update', 0, N'UPDATE-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'20de167f-fde4-4fa3-a154-edb87e97bf73', N'Leave-VALIDATE', 8, N'Valider Congé', N'Validate Leave', NULL, NULL, NULL, NULL, N'/payroll/leave/validate', 0, N'VALIDATE-Leave')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'23c296a6-c18d-476a-9a90-dfee961b3e91', N'TrainingRequiredSkills-LIST', 4, N'TrainingRequiredSkills-LIST', N'TrainingRequiredSkills-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/list', 0, N'LIST-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2e273d46-f310-4045-b71c-b3d030366786', N'Training-DROPDOWNLIST', 1021, N'Training-DROPDOWNLIST', N'Training-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/training/dropdownlist', 0, N'DROPDOWNLIST-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'30dc4505-5cd6-4e6a-ba7d-796492a23eb2', N'RecruitmentRequest-SHOW', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'SHOW-RecruitmentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'338293ba-7779-49e3-84b9-5129e4595976', N'TrainingByEmployee-DROPDOWNLIST', 1021, N'TrainingByEmployee-DROPDOWNLIST', N'TrainingByEmployee-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/dropdownlist', 0, N'DROPDOWNLIST-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', N'BillingSession-UPDATE', 2, N'BillingSession-UPDATE', N'BillingSession-UPDATE', N'BillingSession-UPDATE', N'BillingSession-UPDATE', N'BillingSession-UPDATE', N'BillingSession-UPDATE', N'/sales/billingSession/update', 0, N'UPDATE-BillingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4ab8a098-0fd4-49d1-b3b4-257cc77e6bde', N'TrainingRequest-DROPDOWNLIST', 1021, N'TrainingRequest-DROPDOWNLIST', N'TrainingRequest-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/dropdownlist', 0, N'DROPDOWNLIST-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4c4456b1-e25a-450b-b8ed-f1754b052cf2', N'TrainingRequiredSkills-DELETE', 3, N'TrainingRequiredSkills-DELETE', N'TrainingRequiredSkills-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/delete', 0, N'DELETE-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'58383b7d-21a0-408b-9a20-227754aed94a', N'TrainingSeance-DELETE', 3, N'TrainingSeance-DELETE', N'TrainingSeance-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingseance/delete', 0, N'DELETE-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'59e39e77-7e34-402b-9cb7-1e5979851a45', N'TrainingRequiredSkills-ADD', 1, N'TrainingRequiredSkills-ADD', N'TrainingRequiredSkills-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/add', 1, N'ADD-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5ff51996-2f10-48b2-9926-3b066ba424ea', N'RecruitmentOffer-UPDATE', 2, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/update', 0, N'UPDATE-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'64e34732-59a8-4c08-b57f-70439fd8c32f', N'RecruitmentRequest-LIST', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'LIST-RecruitmentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6904af6a-266d-4422-9e50-bac6b512cb6f', N'Office-LIST', 4, N'Office-LIST', N'Office-LIST', N'Office-LIST', N'Office-LIST', N'Office-LIST', N'Office-LIST', N'/administration/office/list', 1, N'LIST-Office')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6ec0e7ba-4728-4b79-8ecd-c74c3f0e196f', N'RecruitmentOffer-VALIDATE', 8, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/validate', 0, N'VALIDATE-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7112ab0c-75f0-4237-8b59-1e6a1ea54a97', N'Office-ADD', 1, N'Office-ADD', N'Office-ADD', N'Office-ADD', N'Office-ADD', N'Office-ADD', N'Office-ADD', N'/administration/office/add', 0, N'ADD-Office')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', N'SourceDeductionSession-DELETE', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'DELETE-SourceDeductionSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7768e6b6-f89a-479d-8d78-37d17a7337a0', N'TrainingExpectedSkills-UPDATE', 2, N'TrainingExpectedSkills-UPDATE', N'TrainingExpectedSkills-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/update', 0, N'UPDATE-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'77ecfd18-7fc5-43fa-b4d1-41e00441716d', N'TrainingByEmployee-UPDATE', 2, N'TrainingByEmployee-UPDATE', N'TrainingByEmployee-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/update', 0, N'UPDATE-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7ab868d2-7df9-43f4-ad8c-7db411841503', N'TrainingSession-DROPDOWNLIST', 1021, N'TrainingSession-DROPDOWNLIST', N'TrainingSession-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingsession/dropdownlist', 0, N'DROPDOWNLIST-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7c0f7cd0-65b7-4c4a-a6b7-95fe64d35522', N'REVALIDATE-SalesInvoice', 8, N'REVALIDATE-SalesInvoice', N'REVALIDATE-SalesInvoice', N'REVALIDATE-SalesInvoice', N'REVALIDATE-SalesInvoice', N'REVALIDATE-SalesInvoice', N'REVALIDATE-SalesInvoice', N'/stock/warehouse/show', 0, N'REVALIDATE-SalesInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7cdb9b56-0bfb-4c75-b87d-a777709c203f', N'MobilityRequest-Show', 15, N'MobilityRequest-Show', N'MobilityRequest-Show', N'MobilityRequest-Show', N'MobilityRequest-Show', N'MobilityRequest-Show', N'MobilityRequest-Show', N'/rh/mobilityrequest/show', 0, N'SHOW-MobilityRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7d64bd68-b90c-413c-a3e6-981183d49bdc', N'MobilityRequest-ADD', 1, N'MobilityRequest-ADD', N'MobilityRequest-ADD', N'MobilityRequest-ADD', N'MobilityRequest-ADD', N'MobilityRequest-ADD', N'MobilityRequest-ADD', N'/rh/mobilityrequest/add', 0, N'ADD-MobilityRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'81be47a9-267e-46db-b29f-176d78feb76c', N'Training-DELETE', 3, N'Training-DELETE', N'Training-DELETE', NULL, NULL, NULL, NULL, N'/rh/training/delete', 0, N'DELETE-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'84cb4ba1-c6b6-4bfe-a3be-8b13ca958607', N'TrainingRequest-ADD', 1, N'TrainingRequest-ADD', N'TrainingRequest-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/add', 1, N'ADD-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8604a88c-4e5b-4f8b-80f6-80d2e64a1173', N'TrainingRequiredSkills-DROPDOWNLIST', 1021, N'TrainingRequiredSkills-DROPDOWNLIST', N'TrainingRequiredSkills-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/dropdownlist', 0, N'DROPDOWNLIST-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'87d5550c-243f-464e-b840-538984cdbcd3', N'TrainingRequest-LIST', 4, N'TrainingRequest-LIST', N'TrainingRequest-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/list', 0, N'LIST-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8ae23626-4c5f-4cfb-abe9-d33c2150991b', N'Training-Show', 15, N'Training-Show', N'Training-Show', NULL, NULL, NULL, NULL, N'/rh/training/show', 0, N'SHOW-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', N'MobilityRequest-UPDATE', 2, N'MobilityRequest-UPDATE', N'MobilityRequest-UPDATE', N'MobilityRequest-UPDATE', N'MobilityRequest-UPDATE', N'MobilityRequest-UPDATE', N'MobilityRequest-UPDATE', N'/rh/mobilityrequest/update', 0, N'UPDATE-MobilityRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8f1efa25-37cd-46b1-9f19-ca227c793d8b', N'TrainingSession-LIST', 4, N'TrainingSession-LIST', N'TrainingSession-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingsession/list', 0, N'LIST-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9019037e-b18e-4b83-98dd-d9590a10670c', N'MobilityRequest-DELETE', 3, N'MobilityRequest-DELETE', N'MobilityRequest-DELETE', N'MobilityRequest-DELETE', N'MobilityRequest-DELETE', N'MobilityRequest-DELETE', N'MobilityRequest-DELETE', N'/rh/mobilityrequest/delete', 0, N'DELETE-MobilityRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'94381ea1-15ea-4559-a9c7-cf6ddb53ec40', N'MobilityRequest-LIST', 4, N'MobilityRequest-LIST', N'MobilityRequest-LIST', N'MobilityRequest-LIST', N'MobilityRequest-LIST', N'MobilityRequest-LIST', N'MobilityRequest-LIST', N'/rh/mobilityrequest/list', 1, N'LIST-MobilityRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'96764174-5f40-462c-a27d-33da5e1370b3', N'TrainingSeance-UPDATE', 2, N'TrainingSeance-UPDATE', N'TrainingSeance-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingseance/update', 0, N'UPDATE-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'97ebe4a1-869b-4dc5-a45e-d6793aecac4a', N'RecruitmentRequest-ADD', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'ADD-RecruitmentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9ab63ad6-398c-433e-8bde-bea519eccb9b', N'TrainingRequiredSkills-Show', 15, N'TrainingRequiredSkills-Show', N'TrainingRequiredSkills-Show', NULL, NULL, NULL, NULL, N'/rh/trainingrequiredskills/show', 0, N'SHOW-TrainingRequiredSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', N'SourceDeductionSession-ADD', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'ADD-SourceDeductionSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a0df3ec7-881e-47d4-bb76-7f1750945bb4', N'TrainingSeance-ADD', 1, N'TrainingSeance-ADD', N'TrainingSeance-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingseance/add', 1, N'ADD-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a28ae2c3-0181-4479-b146-56b951870f0e', N'RecruitmentOffer-ADD', 1, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/add', 0, N'ADD-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a41ac9d1-7da0-42da-b965-67b848291b00', N'BillingSession-DELETE', 3, N'BillingSession-DELETE', N'BillingSession-DELETE', N'BillingSession-DELETE', N'BillingSession-DELETE', N'BillingSession-DELETE', N'BillingSession-DELETE', N'/sales/billingSession/delete', 0, N'DELETE-BillingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a869f004-0ee9-4bfd-9986-7248355c6052', N'Training-UPDATE', 2, N'Training-UPDATE', N'Training-UPDATE', NULL, NULL, NULL, NULL, N'/rh/training/update', 0, N'UPDATE-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a929572d-d410-4af3-bef6-54cabf950006', N'BillingSession-LIST', 4, N'BillingSession-LIST', N'BillingSession-LIST', N'BillingSession-LIST', N'BillingSession-LIST', N'BillingSession-LIST', N'BillingSession-LIST', N'/sales/billingSession/list', 1, N'LIST-BillingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ab0d83dd-e6be-45a5-9f20-014500cbc3f8', N'Office-UPDATE', 2, N'Office-UPDATE', N'Office-UPDATE', N'Office-UPDATE', N'Office-UPDATE', N'Office-UPDATE', N'Office-UPDATE', N'/administration/office/update', 0, N'UPDATE-Office')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd', N'TrainingSession-UPDATE', 2, N'TrainingSession-UPDATE', N'TrainingSession-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingsession/update', 0, N'UPDATE-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b1872538-a731-457c-b014-c9724c5f400a', N'TrainingExpectedSkills-DELETE', 3, N'TrainingExpectedSkills-DELETE', N'TrainingExpectedSkills-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/delete', 0, N'DELETE-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b1b04e81-9891-4d43-b0ea-1082b1946c1c', N'TrainingExpectedSkills-DROPDOWNLIST', 1021, N'TrainingExpectedSkills-DROPDOWNLIST', N'TrainingExpectedSkills-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/dropdownlist', 0, N'DROPDOWNLIST-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b2ada670-254e-4184-adcb-1040530e07b4', N'SourceDeductionSession-LIST', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'LIST-SourceDeductionSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b46bf40d-dd79-4cb7-9109-606b26d7f2a9', N'TrainingSession-DELETE', 3, N'TrainingSession-DELETE', N'TrainingSession-DELETE', NULL, NULL, NULL, NULL, N'/rh/trainingsession/delete', 0, N'DELETE-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b5216afc-d33d-46f3-b7db-a4170912d7c6', N'Office-Show', 15, N'Office-Show', N'Office-Show', N'Office-Show', N'Office-Show', N'Office-Show', N'Office-Show', N'/administration/office/show', 0, N'SHOW-Office')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c008d163-29c2-4426-aac1-cdd45c9c0d66', N'RecruitmentOffer-CANCEL', 12, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/cancel', 0, N'CANCEL-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c4c58629-cb0f-4677-92c4-0b996bc3e9d4', N'TrainingExpectedSkills-LIST', 4, N'TrainingExpectedSkills-LIST', N'TrainingExpectedSkills-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/list', 0, N'LIST-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c86f9b2d-4850-40c9-95b2-38034df243f7', N'RecruitmentRequest-UPDATE', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'UPDATE-RecruitmentRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c8a6739e-bf26-4f95-b5ec-39910ab21619', N'TrainingSeance-Show', 15, N'TrainingSeance-Show', N'TrainingSeance-Show', NULL, NULL, NULL, NULL, N'/rh/trainingseance/show', 0, N'SHOW-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb3a9724-145a-4cbb-9c7a-314477295422', N'RecruitmentOffer-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/list', 0, N'LIST-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd166dfdd-0289-40ad-af71-bf2ef8d92de7', N'TrainingRequest-UPDATE', 2, N'TrainingRequest-UPDATE', N'TrainingRequest-UPDATE', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/update', 0, N'UPDATE-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'db45eee0-9d96-4482-ba46-a082b2090cd5', N'Office-DELETE', 3, N'Office-DELETE', N'Office-DELETE', N'Office-DELETE', N'Office-DELETE', N'Office-DELETE', N'Office-DELETE', N'/administration/office/delete', 0, N'DELETE-Office')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'df35e021-6ac4-47ef-ae79-622eee46118a', N'Training-LIST', 4, N'Training-LIST', N'Training-LIST', NULL, NULL, NULL, NULL, N'/rh/training/list', 0, N'LIST-Training')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e7503523-4b3e-4562-9a4f-b7ed827b9a29', N'TrainingSession-Show', 15, N'TrainingSession-Show', N'TrainingSession-Show', NULL, NULL, NULL, NULL, N'/rh/trainingsession/show', 0, N'SHOW-TrainingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e7e18cc9-29ef-499d-a303-20c78c9c612d', N'TrainingSeance-LIST', 4, N'TrainingSeance-LIST', N'TrainingSeance-LIST', NULL, NULL, NULL, NULL, N'/rh/trainingseance/list', 0, N'LIST-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e7f1b097-aa16-4324-876e-9fa2346c4c1d', N'TrainingExpectedSkills-Show', 15, N'TrainingExpectedSkills-Show', N'TrainingExpectedSkills-Show', NULL, NULL, NULL, NULL, N'/rh/trainingexpectedskills/show', 0, N'SHOW-TrainingExpectedSkills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e9853c97-1317-4cd0-a65a-80d46b3e6f0e', N'TrainingSeance-DROPDOWNLIST', 1021, N'TrainingSeance-DROPDOWNLIST', N'TrainingSeance-DROPDOWNLIST', NULL, NULL, NULL, NULL, N'/rh/trainingseance/dropdownlist', 0, N'DROPDOWNLIST-TrainingSeance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ea8dd2bf-d37e-4a9d-96e9-fc5a712c9916', N'TrainingRequest-Show', 15, N'TrainingRequest-Show', N'TrainingRequest-Show', NULL, NULL, NULL, NULL, N'/rh/trainingrequest/show', 1, N'SHOW-TrainingRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eb9493fd-c2ce-46f4-9c5f-0ec347035ffd', N'RecruitmentOffer-PRINT', 9, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/print', 0, N'PRINT-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ed815f54-f12c-4a06-90a0-883367d6ae5e', N'TrainingByEmployee-ADD', 1, N'TrainingByEmployee-ADD', N'TrainingByEmployee-ADD', NULL, NULL, NULL, NULL, N'/rh/trainingbyemployee/add', 1, N'ADD-TrainingByEmployee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', N'BillingSession-ADD', 1, N'BillingSession-ADD', N'BillingSession-ADD', N'BillingSession-ADD', N'BillingSession-ADD', N'BillingSession-ADD', N'BillingSession-ADD', N'/sales/billingSession/add', 0, N'ADD-BillingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fbac5977-0b88-4c15-a43f-cf78ee74b1b7', N'RecruitmentOffer-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/recruitment/recruitmentoffer/delete', 0, N'DELETE-RecruitmentOffer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fec2953f-8d6a-486e-be75-da22ce474769', N'BillingSession-SHOW', 15, N'BillingSession-SHOW', N'BillingSession-SHOW', N'BillingSession-SHOW', N'BillingSession-SHOW', N'BillingSession-SHOW', N'BillingSession-SHOW', N'/sales/billingSession/show', 0, N'SHOW-BillingSession')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', N'SourceDeductionSession-SHOW', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'SHOW-SourceDeductionSession')
GO
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1, 11111, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2, 11111, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3, 11111, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4, 11111, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5, 11111, N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6, 11111, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7, 11111, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8, 11111, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (9, 11111, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (10, 11111, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (11, 11111, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (12, 11111, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (13, 11111, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (14, 11111, N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (15, 11111, N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (16, 11111, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (17, 11111, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (18, 11111, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (19, 11111, N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (20, 11111, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (21, 11111, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (22, 11111, N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (23, 11111, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (24, 11111, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (25, 11111, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (26, 11111, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (27, 11111, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (28, 11111, N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (29, 11111, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (30, 11111, N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (31, 11111, N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (32, 11111, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (33, 11111, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (34, 11111, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (35, 11111, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (36, 11111, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (37, 11111, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (38, 11111, N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (39, 11111, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (40, 11111, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (41, 11111, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (42, 11111, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (43, 11111, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (44, 11111, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (45, 11111, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (46, 11111, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (47, 11111, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (48, 11111, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (49, 11111, N'888c5233-b854-478e-b3e6-860eb288a09c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (50, 11111, N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (51, 11111, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (52, 11111, N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (53, 11111, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (54, 11111, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (55, 11111, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (56, 11111, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (57, 11111, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (58, 11111, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (59, 11111, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (60, 11111, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (61, 11111, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (62, 11111, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (63, 11111, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (64, 11111, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (65, 11111, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (66, 11111, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (67, 11111, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (68, 11111, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (69, 11111, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (70, 11111, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (71, 11111, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (72, 11111, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (73, 11111, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (74, 11111, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (75, 11111, N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (76, 11111, N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (77, 11111, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (78, 11111, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (79, 11111, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (80, 11111, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (81, 11111, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (82, 11111, N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (83, 11111, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (84, 11111, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (85, 11111, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (86, 11111, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (87, 11111, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (88, 11111, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (89, 11111, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (90, 11111, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (91, 11111, N'b8afa156-3522-420c-9118-c7fce2208fcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (92, 11111, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (93, 11111, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (94, 11111, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (95, 11111, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (96, 22222, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (97, 22222, N'504b7c8a-379b-45c7-9b44-6d825c30478b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (98, 22222, N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (99, 22222, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100, 22222, N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (101, 22222, N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (102, 22222, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (103, 22222, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (104, 22222, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (105, 22222, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (106, 22222, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (107, 22222, N'2913a29a-35b4-4f14-9b4f-34c13879ef63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (108, 22222, N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (109, 22222, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (110, 22222, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (111, 22222, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (112, 22222, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (113, 22222, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (114, 22222, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (115, 22222, N'6079b54a-948a-4241-99a4-4af59b1a82c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (116, 22222, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (117, 22222, N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (118, 22222, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (119, 22222, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (120, 22222, N'bfc987ff-e9e0-4786-8bcf-557424b597b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (121, 22222, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (122, 22222, N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (123, 22222, N'a4eb7107-2ee3-421e-9271-816939a454d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (124, 22222, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (125, 22222, N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (126, 22222, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (127, 22222, N'98d525b7-49f0-407f-953f-a2eab399ce43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (128, 22222, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (129, 22222, N'da31dab8-5111-4a29-8fea-a8f893479229', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (130, 22222, N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (131, 22222, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (132, 22222, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (133, 22222, N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (134, 22222, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (135, 22222, N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (136, 22222, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (137, 22222, N'9fcc79e1-fe21-4415-ad86-c35fcd318638', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (138, 22222, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (139, 22222, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (140, 22222, N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (141, 22222, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (142, 22222, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (143, 22222, N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (144, 22222, N'46f3f410-4514-49a9-87fa-c79e653d17bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (145, 22222, N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (146, 22222, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (147, 22222, N'430759b9-c9c2-4d57-8812-94b07d8271c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (148, 22222, N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (149, 22222, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (150, 22222, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (151, 22222, N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (152, 22222, N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (153, 22222, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (154, 22222, N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (155, 22222, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (156, 22222, N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (157, 22222, N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (158, 22222, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (159, 22222, N'ac4698dc-57d6-4952-a284-e7120e4d7eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (160, 22222, N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (161, 22222, N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (162, 22222, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (163, 22222, N'6f08acda-f8d6-496a-920e-e440214aac79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (164, 22222, N'c4827784-0363-4114-9d98-2c7aad82fa02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (165, 22222, N'0b681d01-ff60-45e3-877b-f3b6e2e06553', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (166, 22222, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (167, 22222, N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (168, 22222, N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (169, 22222, N'c62e61c1-16ae-463c-8de8-fcc0516df031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (170, 22222, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (171, 22222, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (172, 22222, N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (173, 22222, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (174, 22222, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (175, 22222, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (176, 22222, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (177, 22222, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (178, 22222, N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (179, 22222, N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (180, 22222, N'299729a5-d7ed-4f30-a13c-1960d7374507', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (181, 22222, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (182, 22222, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (183, 22222, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (184, 22222, N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (185, 22222, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (186, 22222, N'd8559505-d792-4448-9389-11553df3a53b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (187, 22222, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (188, 22222, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (189, 22222, N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (190, 22222, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (191, 22222, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (192, 22222, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (193, 33333, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (194, 33333, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (195, 33333, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (196, 33333, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (197, 33333, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (198, 33333, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (199, 33333, N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (200, 33333, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (201, 33333, N'2e00c99b-cd88-41aa-8751-68402a23b014', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (202, 33333, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (203, 33333, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (204, 33333, N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (205, 33333, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (206, 33333, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (207, 33333, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (208, 33333, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (209, 33333, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (210, 33333, N'75c04415-a531-445e-a07d-289454bc7a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (211, 33333, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (212, 33333, N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (213, 33333, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (214, 33333, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (215, 33333, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (216, 33333, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (217, 33333, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (218, 33333, N'b0a20ad6-7b71-4d09-a25e-3e843f847335', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (219, 33333, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (220, 33333, N'cc05f689-5a26-4084-957f-468ffa646d39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (221, 33333, N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (222, 33333, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (223, 33333, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (224, 33333, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (225, 33333, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (226, 33333, N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (227, 33333, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (228, 33333, N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (229, 33333, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (230, 33333, N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (231, 33333, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (232, 33333, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (233, 33333, N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (234, 33333, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (235, 33333, N'f2715a17-ba0e-437b-a939-94382f648337', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (236, 33333, N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (237, 33333, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (238, 33333, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (239, 33333, N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (240, 33333, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (241, 33333, N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (242, 33333, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (243, 33333, N'44842db2-256f-4f1b-a668-aedb9e561a16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (244, 33333, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (245, 33333, N'71570f9c-c72a-4608-bf35-bb9adf44ef36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (246, 33333, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (247, 33333, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (248, 33333, N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (249, 33333, N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (250, 33333, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (251, 33333, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (252, 33333, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (253, 33333, N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (254, 33333, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (255, 33333, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (256, 33333, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (257, 33333, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (258, 33333, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (259, 33333, N'946982d0-e0c4-4c58-8959-c1731f793163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (260, 33333, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (261, 33333, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (262, 33333, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (263, 33333, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (264, 33333, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (265, 33333, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (266, 33333, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (267, 33333, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (268, 33333, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (269, 33333, N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (270, 33333, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (271, 33333, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (272, 33333, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (273, 33333, N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (274, 33333, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (275, 33333, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (276, 33333, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (277, 33333, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (278, 33333, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (279, 33333, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (280, 33333, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (281, 33333, N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (282, 33333, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (283, 33333, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (284, 33333, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (285, 33333, N'72595857-9760-4836-b5be-11c965e065f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (286, 33333, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (287, 33333, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (288, 33333, N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (289, 33333, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (290, 33333, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (291, 33333, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (292, 33333, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (293, 33333, N'd617ff97-654e-4788-add5-c28e90abe680', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (294, 33333, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (295, 33333, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (296, 33333, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (297, 33333, N'a6192524-3d69-4a52-a92c-c564fc1baec5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (298, 33333, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (299, 33333, N'2755658f-cb5e-41e9-8298-c97721bdba77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (300, 33333, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (301, 33333, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (302, 33333, N'603beed9-c3c3-46e1-8560-19706553c33c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (303, 33333, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (304, 33333, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (305, 44444, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (306, 44444, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (307, 44444, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (308, 44444, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (309, 44444, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (310, 44444, N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (311, 44444, N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (312, 44444, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (313, 44444, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (314, 44444, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (315, 44444, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (316, 44444, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (317, 44444, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (318, 44444, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (319, 44444, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (320, 44444, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (321, 44444, N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (322, 44444, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (323, 44444, N'26f81117-51f9-4638-aec4-801a6a296945', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (324, 44444, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (325, 44444, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (326, 44444, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (327, 44444, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (328, 77777, N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (329, 77777, N'0f288531-ba96-438f-b70d-5775de191ee2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (330, 77777, N'fb782972-bcd1-4f36-ba23-577b5e83363d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (331, 77777, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (332, 77777, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (333, 77777, N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (334, 77777, N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (335, 77777, N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (336, 77777, N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (337, 77777, N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (338, 77777, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (339, 77777, N'a17f6c5f-71a4-4086-af06-43926cf30080', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (340, 77777, N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (341, 77777, N'9ebcf470-1da4-4448-b8f5-41d5442849ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (342, 77777, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (343, 77777, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (344, 77777, N'376cbf30-280f-4ae0-af13-129d1cd02aca', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (345, 77777, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (346, 77777, N'6c104837-0a04-43d6-b200-177b98588522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (347, 77777, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (348, 77777, N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (349, 77777, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (350, 77777, N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (351, 77777, N'4653a3cf-5480-49a3-af52-1ede7d7a5432', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (352, 77777, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (353, 77777, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (354, 77777, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (355, 77777, N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (356, 77777, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (357, 77777, N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (358, 77777, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (359, 77777, N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (360, 77777, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (361, 77777, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (362, 77777, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (363, 77777, N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (364, 77777, N'7d159002-e21e-4829-87de-346273d5eccb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (365, 77777, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (366, 77777, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (367, 77777, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (368, 77777, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (369, 77777, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (370, 77777, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (371, 77777, N'8abd5fc1-be98-4340-bc15-25b76115782f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (372, 77777, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (373, 77777, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (374, 77777, N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (375, 77777, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (376, 77777, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (377, 77777, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (378, 77777, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (379, 77777, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (380, 77777, N'5fa827e8-96a8-4020-9153-8755f3c3de93', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (381, 77777, N'4248ba0b-646b-4525-a0a0-8713a10a608e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (382, 77777, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (383, 77777, N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (384, 77777, N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (385, 77777, N'1c753625-4561-4abf-aef9-7a92b01e481e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (386, 77777, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (387, 77777, N'418d053d-d730-4577-8e25-77584384703e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (388, 77777, N'183e2cc9-2522-4463-9366-775781dcb127', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (389, 77777, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (390, 77777, N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (391, 77777, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (392, 77777, N'cd30e343-60c3-4f7d-a566-72fe0718a90b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (393, 77777, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (394, 77777, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (395, 77777, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (396, 77777, N'66b8d9f8-6043-4d79-b960-9265da657a3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (397, 77777, N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (398, 77777, N'28e36f79-bac9-4340-a942-95dc9888c9d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (399, 77777, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (400, 77777, N'7bb9080b-247e-4a3d-b459-619677e19263', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (401, 77777, N'fc2da022-f055-48a0-9f91-643710950d43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (402, 77777, N'bb3c8465-744e-4995-b231-6714a5d25df9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (403, 77777, N'97795e35-e1f6-4d05-afe3-6773afb2d254', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (404, 77777, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (405, 77777, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (406, 77777, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (407, 77777, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (408, 77777, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (409, 77777, N'86894159-c1f3-44ab-bddc-a578289077a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (410, 77777, N'e7b3084b-711a-43e3-8ab6-a37af089281e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (411, 77777, N'0356eb50-3f15-4843-88ea-a130922a1ced', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (412, 77777, N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (413, 77777, N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (414, 77777, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (415, 77777, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (416, 77777, N'1fc23099-0aff-4d52-be49-9cbcba9405ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (417, 77777, N'e5a6ccba-20d6-47db-b131-9c564f67a361', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (418, 77777, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (419, 77777, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (420, 77777, N'5fb337a9-70ec-46e2-a53e-9824ae05fd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (421, 77777, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (422, 77777, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (423, 77777, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (424, 77777, N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (425, 77777, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (426, 77777, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (427, 77777, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (428, 77777, N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (429, 77777, N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (430, 77777, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (431, 77777, N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (432, 77777, N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (433, 77777, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (434, 77777, N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (435, 77777, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (436, 77777, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (437, 77777, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (438, 77777, N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (439, 77777, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (440, 77777, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (441, 77777, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (442, 77777, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (443, 77777, N'776d3e4e-c68b-43c3-a5a3-f91385bd6296', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (444, 77777, N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (445, 77777, N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (446, 77777, N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (447, 77777, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (448, 77777, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (449, 77777, N'5f376240-3764-4733-a269-aad8b2f2b886', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (450, 77777, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (451, 77777, N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (452, 77777, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (453, 77777, N'72ab7a79-351b-4893-8b79-d4d03fa39b4b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (454, 77777, N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (455, 77777, N'41328f04-b725-4435-837b-082e169aea31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (456, 77777, N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (457, 77777, N'd8f89701-7006-48e9-b2ec-0679551a0418', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (458, 77777, N'51c504b7-3fd2-4111-9652-05b295f0732f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (459, 77777, N'04564a71-cc75-4d65-934f-03d6598429df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (460, 77777, N'af5d4af2-8810-4ba1-a628-003796357bfb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (461, 77777, N'249ba7d6-26bc-43df-b75d-b568252cc2c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (462, 77777, N'd604fb47-2f09-4a36-8ccc-b697fcbf3205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (463, 77777, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (464, 77777, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (465, 77777, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (466, 77777, N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (467, 77777, N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (468, 77777, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (469, 77777, N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (470, 77777, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (471, 77777, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (472, 77777, N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (473, 77777, N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (474, 77777, N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (475, 77777, N'1370af42-416b-4af5-8416-d274643cc31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (476, 77777, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (477, 77777, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (478, 77777, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (479, 77777, N'7541f25b-34db-4ad5-a8ae-09d1dd558706', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (480, 77777, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (481, 88888, N'104d522c-cab9-4916-be40-62e7c00de59c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (482, 88888, N'4d7fa507-2170-425e-96f0-f42822ff6311', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (483, 88888, N'4c5b37fd-34d7-4148-9c84-1ab08be35e14', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (484, 88888, N'49bc61be-8c43-4854-9d06-b61ae3118a92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (485, 88888, N'57302d72-6ffb-4f7c-a191-11e00c17b4ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (486, 88888, N'3bdfce52-fe6a-4886-a070-ce2b9445927f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (487, 88888, N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (488, 88888, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (489, 88888, N'd87ce1b0-b82f-4927-8ef4-cee2b7d54d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (490, 88888, N'd32b919b-6b19-4548-af32-5854f6d795fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (491, 88888, N'413143f0-12c1-4787-85e3-683d02a3fbd0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (492, 88888, N'16353f67-23c3-4cf9-9a88-16eaa18f10d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (493, 88888, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (494, 88888, N'f4ae521c-e52a-4e36-a13d-7d238dab1469', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (495, 88888, N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (496, 88888, N'195f5149-f23f-468b-8cf6-c85390bb28f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (497, 88888, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (498, 88888, N'8bd4017e-1b0e-432c-97cb-8b13bf6274fd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (499, 88888, N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (500, 88888, N'94329f27-c3bd-45ab-8e06-60e4a0199878', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (501, 88888, N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (502, 100000, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (503, 100000, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (504, 100000, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (505, 100000, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (506, 100000, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (507, 100000, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (508, 100000, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (509, 100000, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (510, 100000, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (511, 100000, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (512, 100000, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (513, 100000, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (514, 100000, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (515, 100000, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (516, 100000, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (517, 100000, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (518, 100000, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (519, 100000, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (520, 100000, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (521, 100000, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (522, 100000, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (523, 100000, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (524, 100000, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (525, 100000, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (526, 100000, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (527, 100000, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (528, 100000, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (529, 100000, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (530, 100000, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (531, 100000, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (532, 100000, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (533, 100000, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (534, 100000, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (535, 100000, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (536, 100000, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (537, 100000, N'14096ba7-324e-4092-b933-a1b57c3ebb32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (538, 100000, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (539, 100000, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (540, 100000, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (541, 100000, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (542, 100000, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (543, 100000, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (544, 100000, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (545, 100000, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (546, 100000, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (547, 100000, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (548, 100000, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (549, 100000, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (550, 100000, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (551, 100000, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (552, 100000, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (553, 100000, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (554, 100000, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (555, 100000, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (556, 100000, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (557, 100000, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (558, 100000, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (559, 100000, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (560, 100000, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (561, 100000, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (562, 100000, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (563, 100000, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (564, 100000, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (565, 100000, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (566, 100000, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (567, 100000, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (568, 100000, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (569, 100000, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (570, 100001, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (571, 100001, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (572, 100001, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (573, 100001, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (574, 100001, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (575, 100001, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (576, 100001, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (577, 100001, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (578, 100001, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (579, 100001, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (580, 100001, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (581, 100001, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (582, 100001, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (583, 100001, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (584, 100001, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (585, 100001, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (586, 100001, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (587, 100001, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (588, 100001, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (589, 100001, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (590, 100001, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (591, 100001, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (592, 100001, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (593, 100001, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (594, 100001, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (595, 100001, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (596, 100001, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (597, 100001, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (598, 100001, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (599, 100001, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (600, 100001, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (601, 100001, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (602, 100001, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (603, 100001, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (604, 100001, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (605, 100001, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (606, 100001, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (607, 100001, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (608, 100001, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (609, 100001, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (610, 100001, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (611, 100001, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (612, 100001, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (613, 100001, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (614, 100001, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (615, 100001, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (616, 100001, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (617, 100001, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (618, 100001, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (619, 100001, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (620, 100001, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (621, 100001, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (622, 100001, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (623, 100001, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (624, 100001, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (625, 100001, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (626, 100001, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (627, 100001, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (628, 100001, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (629, 100001, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (630, 100001, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (631, 100001, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (632, 100001, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (633, 100001, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (634, 100001, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (635, 100001, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (636, 100001, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (637, 100001, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (638, 100001, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (639, 100001, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (640, 100001, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (641, 100001, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (642, 100001, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (643, 100001, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (644, 100001, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (645, 100001, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (646, 100001, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (647, 100001, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (648, 100001, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (649, 100001, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (650, 100001, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (651, 100001, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (652, 100001, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (653, 100001, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (654, 100001, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (655, 100001, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (656, 100001, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (657, 100001, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (658, 100001, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (659, 100001, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (660, 100001, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (661, 100001, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (662, 100001, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (663, 100001, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (664, 100001, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (665, 100001, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (666, 100001, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (667, 100001, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (668, 100001, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (669, 100001, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (670, 100001, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (671, 100001, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (672, 100001, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (673, 100001, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (674, 100001, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (675, 100001, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (676, 100001, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (677, 100001, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (678, 100001, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (679, 100001, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (680, 100001, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (681, 100001, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (682, 100001, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (683, 100001, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (684, 100001, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (685, 100001, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (686, 100001, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (687, 100001, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (688, 100001, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (689, 100001, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (690, 100001, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (691, 100001, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (692, 100001, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (693, 100001, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (694, 100001, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (695, 100001, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (696, 100001, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (697, 100001, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (698, 100001, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (699, 100001, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (700, 100001, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (701, 100001, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (702, 100001, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (703, 100001, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (704, 100001, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (705, 100001, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (706, 100001, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (707, 100001, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (708, 100001, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (709, 100001, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (710, 100001, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (711, 100001, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (712, 100001, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (713, 100001, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (714, 100001, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (715, 100001, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (716, 100001, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (717, 100001, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (718, 100001, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (719, 100001, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (720, 100001, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (721, 100001, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (722, 100001, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (723, 100001, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (724, 100001, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (725, 100001, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (726, 100001, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (727, 100001, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (728, 100001, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (729, 100001, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (730, 100001, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (731, 100001, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (732, 100001, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (733, 100001, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (734, 100002, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (735, 100002, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (736, 100002, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (737, 100002, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (738, 100002, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (739, 100002, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (740, 100002, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (741, 100002, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (742, 100002, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (743, 100002, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (744, 100002, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (745, 100002, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (746, 100002, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (747, 100002, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (748, 100002, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (749, 100002, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (750, 100002, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (751, 100002, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (752, 100002, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (753, 100002, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (754, 100002, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (755, 100002, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (756, 100002, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (757, 100002, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (758, 100002, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (759, 100002, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (760, 100002, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (761, 100002, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (762, 100002, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (763, 100002, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (764, 100002, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (765, 100002, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (766, 100002, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (767, 100002, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (768, 100002, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (769, 100002, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (770, 100002, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (771, 100002, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (772, 100002, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (773, 100002, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (774, 100002, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (775, 100002, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (776, 100002, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (777, 100002, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (778, 100002, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (779, 100002, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (780, 100002, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (781, 100002, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (782, 100002, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (783, 100002, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (784, 100002, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (785, 100002, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (786, 100002, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (787, 100002, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (788, 100002, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (789, 100002, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (790, 100002, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (791, 100002, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (792, 100002, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (793, 100002, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (794, 100002, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (795, 100002, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (796, 100002, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (797, 100002, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (798, 100002, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (799, 100002, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (800, 100002, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (801, 100002, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (802, 100002, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (803, 100002, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (804, 100002, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (805, 100002, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (806, 100002, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (807, 100002, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (808, 100002, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (809, 100002, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (810, 100002, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (811, 100002, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (812, 100002, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (813, 100002, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (814, 100002, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (815, 100002, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (816, 100002, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (817, 100002, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (818, 100002, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (819, 100002, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (820, 100002, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (821, 100002, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (822, 100002, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (823, 100002, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (824, 100002, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (825, 100002, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (826, 100002, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (827, 100002, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (828, 100002, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (829, 100002, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (830, 100002, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (831, 100002, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (832, 100002, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (833, 100002, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (834, 100002, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (835, 100002, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (836, 100002, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (837, 100002, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (838, 100002, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (839, 100002, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (840, 100002, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (841, 100002, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (842, 100002, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (843, 100002, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (844, 100002, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (845, 100002, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (846, 100002, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (847, 100002, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (848, 100002, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (849, 100002, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (850, 100002, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (851, 100002, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (852, 100002, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (853, 100002, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (854, 100002, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (855, 100002, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (856, 100002, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (857, 100002, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (858, 100002, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (859, 100002, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (860, 100002, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (861, 100002, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (862, 100002, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (863, 100002, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (864, 100002, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (865, 100002, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (866, 100002, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (867, 100002, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (868, 100002, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (869, 100002, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (870, 100002, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (871, 100002, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (872, 100002, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (873, 100002, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (874, 100002, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (875, 100002, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (876, 100002, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (877, 100002, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (878, 100002, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (879, 100002, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (880, 100002, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (881, 100002, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (882, 100002, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (883, 100002, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (884, 100002, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (885, 100002, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (886, 100002, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (887, 100002, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (888, 100002, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (889, 100002, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (890, 100002, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (891, 100002, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (892, 100002, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (893, 100002, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (894, 100002, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (895, 100002, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (896, 100002, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (897, 100002, N'5472cf06-def0-4062-95df-6c6abb535288', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (898, 100002, N'33fc3fb8-f12b-40af-acfa-be21fddbd790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (899, 100002, N'41eabde8-52de-4c93-895e-afdd95ada7dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (900, 100002, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (901, 100003, N'3eb1157c-852d-43ea-a65f-7073e3897613', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (902, 100003, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (903, 100003, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (904, 100003, N'a6c247bc-d584-43a3-b995-f303e3b13c77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (905, 100003, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (906, 100003, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (907, 100003, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (908, 100003, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (909, 100003, N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (910, 100003, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (911, 100003, N'712d6299-495e-45ce-9010-20e4ad36834a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (912, 100003, N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (913, 100003, N'322d8fea-9553-46c1-a83b-24276d046f53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (914, 100003, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (915, 100003, N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (916, 100003, N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (917, 100003, N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (918, 100003, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (919, 100003, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (920, 100003, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (921, 100003, N'831becf0-0744-4fe4-b79c-dec135cee846', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (922, 100003, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (923, 100003, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (924, 100003, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (925, 100003, N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (926, 100003, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (927, 100003, N'd7c9f718-49fb-41e3-88a5-0197b286cd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (928, 100003, N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (929, 100003, N'06eb3687-d016-4597-9538-c1eaed785b50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (930, 100003, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (931, 100003, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (932, 100003, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (933, 100003, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (934, 100003, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (935, 100003, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (936, 100003, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (937, 100003, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (938, 100003, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (939, 100003, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (940, 100003, N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (941, 100003, N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (942, 100003, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (943, 100003, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (944, 100003, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (945, 100003, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (946, 100003, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (947, 100003, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (948, 100003, N'a1ca4007-d64e-4765-af61-42e753a61222', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (949, 100003, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (950, 100003, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (951, 100003, N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (952, 100003, N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (953, 100003, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (954, 100003, N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (955, 100003, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (956, 100003, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (957, 100003, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (958, 100003, N'422f1608-e641-4ec1-9163-636bb3c6962b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (959, 100003, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (960, 100003, N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (961, 100003, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (962, 100003, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (963, 100003, N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (964, 100003, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (965, 100003, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (966, 100003, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (967, 100003, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (968, 100003, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (969, 100003, N'11ab7a69-a705-4f46-8821-9bb3b7815a98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (970, 100003, N'5d854334-c1b7-48c8-8811-7a37ca16dc7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (971, 100003, N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (972, 100003, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (973, 100003, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (974, 100003, N'12e2ecc5-d861-4680-9310-92422a3e2593', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (975, 100003, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (976, 100003, N'336fdb14-6186-41c2-b2ff-98c99ea25c5f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (977, 100003, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (978, 100003, N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (979, 100003, N'e83a0045-89c6-459f-8d99-89c25077f4ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (980, 100003, N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (981, 100003, N'05d45e13-6184-4085-b9b2-86015af49e11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (982, 100003, N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (983, 100003, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (984, 100003, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (985, 100003, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (986, 100004, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (987, 100004, N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (988, 101008, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (989, 101008, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (990, 101008, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (991, 101008, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (992, 101008, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (993, 100010, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (994, 100010, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (995, 100010, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (996, 100010, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (997, 100010, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (998, 100010, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (999, 101009, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1000, 101009, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1001, 101009, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1002, 101011, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1003, 101011, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1004, 101011, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1005, 101011, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1006, 101011, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1007, 101012, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1008, 101012, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1009, 101012, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1010, 101012, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1011, 101012, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1012, 101012, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1013, 101013, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1014, 101013, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1015, 101013, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1016, 101013, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1017, 101013, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1018, 101016, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1019, 101016, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1020, 101016, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1021, 101016, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1022, 101016, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1023, 101014, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1024, 101014, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1025, 101014, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1026, 101014, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1027, 101014, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1028, 101015, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1029, 101015, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1030, 101015, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1031, 100005, N'e21a8021-5299-4845-b534-fd1f3c46ab69', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1032, 11111, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1033, 11111, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1034, 11111, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1035, 11111, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1036, 11111, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1037, 11111, N'1d587003-8abd-4e4c-a096-5fa386feb25e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1038, 101017, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1039, 101017, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1040, 101017, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1041, 101017, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1042, 101017, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1043, 101018, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1044, 101018, N'81dfe010-14a0-48a7-aa0d-48023d967286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1045, 101018, N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1046, 101018, N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1047, 101018, N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1048, 90000, N'826ce05a-530f-4174-803c-a16f47ce3582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1049, 90000, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1050, 90000, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1051, 90000, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1052, 90000, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1053, 90000, N'3bdfce52-fe6a-4886-a070-ce2b9445927f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1054, 90000, N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1055, 90000, N'413143f0-12c1-4787-85e3-683d02a3fbd0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1056, 90000, N'1fc23099-0aff-4d52-be49-9cbcba9405ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1057, 90000, N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1058, 90000, N'1370af42-416b-4af5-8416-d274643cc31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1059, 90000, N'6079b54a-948a-4241-99a4-4af59b1a82c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1060, 90000, N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1061, 90000, N'183e2cc9-2522-4463-9366-775781dcb127', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1062, 90000, N'af5d4af2-8810-4ba1-a628-003796357bfb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1063, 90000, N'be0964a9-1fe6-4049-9fdc-254c8094b267', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1064, 90000, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1065, 90000, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1066, 90000, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1067, 90000, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1068, 90000, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1069, 90000, N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1070, 90000, N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1071, 90000, N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1072, 90000, N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1073, 90000, N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1074, 90000, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1075, 90000, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1076, 90000, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1077, 90000, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1078, 90000, N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1079, 90000, N'e7b3084b-711a-43e3-8ab6-a37af089281e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1080, 90000, N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1081, 90000, N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1082, 90000, N'1c753625-4561-4abf-aef9-7a92b01e481e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1083, 90000, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1084, 90000, N'4248ba0b-646b-4525-a0a0-8713a10a608e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1085, 90000, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1086, 90000, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1087, 90000, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1088, 90000, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1089, 90000, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1090, 90000, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1091, 90000, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1092, 90000, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1093, 90000, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1094, 90000, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1095, 90000, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1096, 90000, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1097, 90000, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1098, 90000, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1099, 90000, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1100, 90000, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1101, 90000, N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1102, 90000, N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1103, 90000, N'2913a29a-35b4-4f14-9b4f-34c13879ef63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1104, 90000, N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1105, 90000, N'98d525b7-49f0-407f-953f-a2eab399ce43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1106, 90000, N'd8559505-d792-4448-9389-11553df3a53b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1107, 90000, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1108, 90000, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1109, 90000, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1110, 90000, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1111, 90000, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1112, 90000, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1113, 90000, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1114, 90000, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1115, 90000, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1116, 90000, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1117, 90000, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1118, 90000, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1119, 90000, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1120, 90000, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1121, 90000, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1122, 90000, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1123, 90000, N'7bb9080b-247e-4a3d-b459-619677e19263', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1124, 90000, N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1125, 90000, N'104d522c-cab9-4916-be40-62e7c00de59c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1126, 90000, N'4c5b37fd-34d7-4148-9c84-1ab08be35e14', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1127, 90000, N'49bc61be-8c43-4854-9d06-b61ae3118a92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1128, 90000, N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1129, 90000, N'4d7fa507-2170-425e-96f0-f42822ff6311', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1130, 90000, N'57302d72-6ffb-4f7c-a191-11e00c17b4ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1131, 90000, N'94329f27-c3bd-45ab-8e06-60e4a0199878', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1132, 90000, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1133, 90000, N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1134, 90000, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1135, 90000, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1136, 90000, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1137, 90000, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1138, 90000, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1139, 90000, N'3eb1157c-852d-43ea-a65f-7073e3897613', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1140, 90000, N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1141, 90000, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1142, 90000, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1143, 90000, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1144, 90000, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1145, 90000, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1146, 90000, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1147, 90000, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1148, 90000, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1149, 90000, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1150, 90000, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1151, 90000, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1152, 90000, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1153, 90000, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1154, 90000, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1155, 90000, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1156, 90000, N'a1ca4007-d64e-4765-af61-42e753a61222', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1157, 90000, N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1158, 90000, N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1159, 90000, N'd7c9f718-49fb-41e3-88a5-0197b286cd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1160, 90000, N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1161, 90000, N'12e2ecc5-d861-4680-9310-92422a3e2593', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1162, 90000, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1163, 90000, N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1164, 90000, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1165, 90000, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1166, 90000, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1167, 90000, N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1168, 90000, N'5fb337a9-70ec-46e2-a53e-9824ae05fd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1169, 90000, N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1170, 90000, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1171, 90000, N'bb3c8465-744e-4995-b231-6714a5d25df9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1172, 90000, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1173, 90000, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1174, 90000, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1175, 90000, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1176, 90000, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1177, 90000, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1178, 90000, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1179, 90000, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1180, 90000, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1181, 90000, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1182, 90000, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1183, 90000, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1184, 90000, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1185, 90000, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1186, 90000, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1187, 90000, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1188, 90000, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1189, 90000, N'ee347789-32ce-492c-a380-99eef0467543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1190, 90000, N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1191, 90000, N'324079a9-3676-4d46-9704-b6a7a707101e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1192, 90000, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1193, 90000, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1194, 90000, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1195, 90000, N'54aac154-2c0a-471c-adfd-0469a65737cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1196, 90000, N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1197, 90000, N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1198, 90000, N'4b7535a4-dd2e-4071-9080-09a340e427f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1199, 90000, N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1200, 90000, N'c71757fa-088e-4b46-9359-455061d6b753', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1201, 90000, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1202, 90000, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1203, 90000, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1204, 90000, N'34492beb-def2-4437-97a8-7afa138e17c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1205, 90000, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1206, 90000, N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1207, 90000, N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1208, 90000, N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1209, 90000, N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1210, 90000, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1211, 90000, N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1212, 90000, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1213, 90000, N'c196270b-56d8-4eaa-8c52-69773420797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1214, 90000, N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1215, 90000, N'1c4dd748-6f03-430a-9d07-9b84e6a0902e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1216, 90000, N'41adc77a-62e3-4a81-8a90-c565ea54fcce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1217, 90000, N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1218, 90000, N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1219, 90000, N'a97affbe-b4da-40f6-8055-f493cef4d9e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1220, 90000, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1221, 90000, N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1222, 90000, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1223, 90000, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1224, 90000, N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1225, 90000, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1226, 90000, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1227, 90000, N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1228, 90000, N'a291e34e-5db0-4835-bad7-f88cc7d5d3aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1229, 90000, N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1230, 90000, N'605f60cb-09e8-41c6-9ba4-829679b00c84', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1231, 90000, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1232, 90000, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1233, 90000, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1234, 90000, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1235, 90000, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1236, 90000, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1237, 90000, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1238, 90000, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1239, 90000, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1240, 90000, N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1241, 90000, N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1242, 90000, N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1243, 90000, N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1244, 90000, N'07d35985-0229-40c3-aaed-0fce364b33c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1245, 90000, N'b8cfb588-5071-4035-9e0f-f7f14f2856e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1246, 90000, N'9a7e6cfe-cd60-4ccd-8c14-af283303e936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1247, 90000, N'a3ea8642-aa44-45f4-9b53-060b114819e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1248, 90000, N'7eac8530-e743-4028-9434-48f8ba9a09ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1249, 90000, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1250, 90000, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1251, 90000, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1252, 90000, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1253, 90000, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1254, 90000, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1255, 90000, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1256, 90000, N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1257, 90000, N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1258, 90000, N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1259, 90000, N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1260, 90000, N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1261, 90000, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1262, 90000, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1263, 90000, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1264, 90000, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1265, 90000, N'820ab0ac-6d35-4a42-a051-cd9f986d9c09', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1266, 90000, N'95adccad-66f9-47b3-a471-a6ee737b67a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1267, 90000, N'14096ba7-324e-4092-b933-a1b57c3ebb32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1268, 90000, N'0354f894-5ad4-4667-8c78-e85416e88313', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1269, 90000, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1270, 90000, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1271, 90000, N'cb4545fb-c741-428f-87eb-afee3bf38e7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1272, 90000, N'fd671f2f-5b90-4de3-9a07-19ab4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1273, 90000, N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1274, 90000, N'0356eb50-3f15-4843-88ea-a130922a1ced', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1275, 90000, N'41328f04-b725-4435-837b-082e169aea31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1276, 90000, N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1277, 90000, N'5f376240-3764-4733-a269-aad8b2f2b886', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1278, 90000, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1279, 90000, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1280, 90000, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1281, 90000, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1282, 90000, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1283, 90000, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1284, 90000, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1285, 90000, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1286, 90000, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1287, 90000, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1288, 90000, N'e217064d-adff-4afc-af38-7dede030d53f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1289, 90000, N'05d28c92-aa4b-459f-a306-ea45722c9e71', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1290, 90000, N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1291, 90000, N'da43d379-0954-42dd-9832-8890747a0929', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1292, 90000, N'076aa20b-5f04-4872-8093-40cef7ee2e1d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1293, 90000, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1294, 90000, N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1295, 90000, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1296, 90000, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1297, 90000, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1298, 90000, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1299, 90000, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1300, 90000, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1301, 90000, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1302, 90000, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1303, 90000, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1304, 90000, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1305, 90000, N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1306, 90000, N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1307, 90000, N'71570f9c-c72a-4608-bf35-bb9adf44ef36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1308, 90000, N'72595857-9760-4836-b5be-11c965e065f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1309, 90000, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1310, 90000, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1311, 90000, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1312, 90000, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1313, 90000, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1314, 90000, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1315, 90000, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1316, 90000, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1317, 90000, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1318, 90000, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1319, 90000, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1320, 90000, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1321, 90000, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1322, 90000, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1323, 90000, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1324, 90000, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1325, 90000, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1326, 90000, N'44842db2-256f-4f1b-a668-aedb9e561a16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1327, 90000, N'75c04415-a531-445e-a07d-289454bc7a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1328, 90000, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1329, 90000, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1330, 90000, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1331, 90000, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1332, 90000, N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1333, 90000, N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1334, 90000, N'ac4698dc-57d6-4952-a284-e7120e4d7eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1335, 90000, N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1336, 90000, N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1337, 90000, N'6f08acda-f8d6-496a-920e-e440214aac79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1338, 90000, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1339, 90000, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1340, 90000, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1341, 90000, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1342, 90000, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1343, 90000, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1344, 90000, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1345, 90000, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1346, 90000, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1347, 90000, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1348, 90000, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1349, 90000, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1350, 90000, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1351, 90000, N'5fa827e8-96a8-4020-9153-8755f3c3de93', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1352, 90000, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1353, 90000, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1354, 90000, N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1355, 90000, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1356, 90000, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1357, 90000, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1358, 90000, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1359, 90000, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1360, 90000, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1361, 90000, N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1362, 90000, N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1363, 90000, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1364, 90000, N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1365, 90000, N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1366, 90000, N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1367, 90000, N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1368, 90000, N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1369, 90000, N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1370, 90000, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1371, 90000, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1372, 90000, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1373, 90000, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1374, 90000, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1375, 90000, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1376, 90000, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1377, 90000, N'9fcc79e1-fe21-4415-ad86-c35fcd318638', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1378, 90000, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1379, 90000, N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1380, 90000, N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1381, 90000, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1382, 90000, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1383, 90000, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1384, 90000, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1385, 90000, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1386, 90000, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1387, 90000, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1388, 90000, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1389, 90000, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1390, 90000, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1391, 90000, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1392, 90000, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1393, 90000, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1394, 90000, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1395, 90000, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1396, 90000, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1397, 90000, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1398, 90000, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1399, 90000, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1400, 90000, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1401, 90000, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1402, 90000, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1403, 90000, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1404, 90000, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1405, 90000, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1406, 90000, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1407, 90000, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1408, 90000, N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1409, 90000, N'418d053d-d730-4577-8e25-77584384703e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1410, 90000, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1411, 90000, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1412, 90000, N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1413, 90000, N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1414, 90000, N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1415, 90000, N'd8f89701-7006-48e9-b2ec-0679551a0418', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1416, 90000, N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1417, 90000, N'cd30e343-60c3-4f7d-a566-72fe0718a90b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1418, 90000, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1419, 90000, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1420, 90000, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1421, 90000, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1422, 90000, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1423, 90000, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1424, 90000, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1425, 90000, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1426, 90000, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1427, 90000, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1428, 90000, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1429, 90000, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1430, 90000, N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1431, 90000, N'195f5149-f23f-468b-8cf6-c85390bb28f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1432, 90000, N'16353f67-23c3-4cf9-9a88-16eaa18f10d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1433, 90000, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1434, 90000, N'66b8d9f8-6043-4d79-b960-9265da657a3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1435, 90000, N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1436, 90000, N'7541f25b-34db-4ad5-a8ae-09d1dd558706', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1437, 90000, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1438, 90000, N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1439, 90000, N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1440, 90000, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1441, 90000, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1442, 90000, N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1443, 90000, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1444, 90000, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1445, 90000, N'7d64bd68-b90c-413c-a3e6-981183d49bdc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1446, 90000, N'9019037e-b18e-4b83-98dd-d9590a10670c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1447, 90000, N'94381ea1-15ea-4559-a9c7-cf6ddb53ec40', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1448, 90000, N'7cdb9b56-0bfb-4c75-b87d-a777709c203f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1449, 90000, N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1450, 90000, N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1451, 90000, N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1452, 90000, N'bfc987ff-e9e0-4786-8bcf-557424b597b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1453, 90000, N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1454, 90000, N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1455, 90000, N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1456, 90000, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1457, 90000, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1458, 90000, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1459, 90000, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1460, 90000, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1461, 90000, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1462, 90000, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1463, 90000, N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1464, 90000, N'fb782972-bcd1-4f36-ba23-577b5e83363d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1465, 90000, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1466, 90000, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1467, 90000, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1468, 90000, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1469, 90000, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1470, 90000, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1471, 90000, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1472, 90000, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1473, 90000, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1474, 90000, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1475, 90000, N'7112ab0c-75f0-4237-8b59-1e6a1ea54a97', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1476, 90000, N'db45eee0-9d96-4482-ba46-a082b2090cd5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1477, 90000, N'6904af6a-266d-4422-9e50-bac6b512cb6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1478, 90000, N'b5216afc-d33d-46f3-b7db-a4170912d7c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1479, 90000, N'ab0d83dd-e6be-45a5-9f20-014500cbc3f8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1480, 90000, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1481, 90000, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1482, 90000, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1483, 90000, N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1484, 90000, N'c62e61c1-16ae-463c-8de8-fcc0516df031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1485, 90000, N'504b7c8a-379b-45c7-9b44-6d825c30478b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1486, 90000, N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1487, 90000, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1488, 90000, N'c1d44620-a496-4de0-895f-56066017a16f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1489, 90000, N'bf56f348-0a33-4ac2-ae63-5822a62a2123', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1490, 90000, N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1491, 90000, N'a6192524-3d69-4a52-a92c-c564fc1baec5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1492, 90000, N'560c0361-0321-4690-a9b9-1391cb9d6451', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1493, 90000, N'8403df7d-3348-400b-9946-f9f86614a4dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1494, 90000, N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1495, 90000, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1496, 90000, N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1497, 90000, N'422f1608-e641-4ec1-9163-636bb3c6962b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1498, 90000, N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1499, 90000, N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1500, 90000, N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1501, 90000, N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1502, 90000, N'06eb3687-d016-4597-9538-c1eaed785b50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1503, 90000, N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1504, 90000, N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1505, 90000, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1506, 90000, N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1507, 90000, N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1508, 90000, N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1509, 90000, N'04564a71-cc75-4d65-934f-03d6598429df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1510, 90000, N'0f288531-ba96-438f-b70d-5775de191ee2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1511, 90000, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1512, 90000, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1513, 90000, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1514, 90000, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1515, 90000, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1516, 90000, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1517, 90000, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1518, 90000, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1519, 90000, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1520, 90000, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1521, 90000, N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1522, 90000, N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1523, 90000, N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1524, 90000, N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1525, 90000, N'25803ebb-f8d0-4058-ae1d-29e742224932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1526, 90000, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1527, 90000, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1528, 90000, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1529, 90000, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1530, 90000, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1531, 90000, N'6d1006f2-51ab-4aba-abc6-b597f28b1603', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1532, 90000, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1533, 90000, N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1534, 90000, N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1535, 90000, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1536, 90000, N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1537, 90000, N'81dfe010-14a0-48a7-aa0d-48023d967286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1538, 90000, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1539, 90000, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1540, 90000, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1541, 90000, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1542, 90000, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1543, 90000, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1544, 90000, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1545, 90000, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1546, 90000, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1547, 90000, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1548, 90000, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1549, 90000, N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1550, 90000, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1551, 90000, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1552, 90000, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1553, 90000, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1554, 90000, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1555, 90000, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1556, 90000, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1557, 90000, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1558, 90000, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1559, 90000, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1560, 90000, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1561, 90000, N'e21a8021-5299-4845-b534-fd1f3c46ab69', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1562, 90000, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1563, 90000, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1564, 90000, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1565, 90000, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1566, 90000, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1567, 90000, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1568, 90000, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1569, 90000, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1570, 90000, N'dec4c280-cc66-4fbf-8317-4a3d70a234fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1571, 90000, N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1572, 90000, N'3e160c8e-b2f6-45f1-8ab2-8f4c036573e1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1573, 90000, N'273b5a2d-455f-47f9-8bc9-913953c3a161', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1574, 90000, N'afc3feb8-7935-4901-817b-9ae97bfd2744', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1575, 90000, N'ceeacfe2-8f90-47e9-845f-63a34e3de4bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1576, 90000, N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1577, 90000, N'a69984ec-f11f-46aa-9b32-9d22d815fd4c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1578, 90000, N'3683ddae-8093-4d4e-ab44-ce435c7a4eef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1579, 90000, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1580, 90000, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1581, 90000, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1582, 90000, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1583, 90000, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1584, 90000, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1585, 90000, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1586, 90000, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1587, 90000, N'a28ae2c3-0181-4479-b146-56b951870f0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1588, 90000, N'c008d163-29c2-4426-aac1-cdd45c9c0d66', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1589, 90000, N'fbac5977-0b88-4c15-a43f-cf78ee74b1b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1590, 90000, N'cb3a9724-145a-4cbb-9c7a-314477295422', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1591, 90000, N'eb9493fd-c2ce-46f4-9c5f-0ec347035ffd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1592, 90000, N'1a363e4d-7b0a-4068-b3f3-9e18156d8f02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1593, 90000, N'5ff51996-2f10-48b2-9926-3b066ba424ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1594, 90000, N'6ec0e7ba-4728-4b79-8ecd-c74c3f0e196f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1595, 90000, N'97ebe4a1-869b-4dc5-a45e-d6793aecac4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1596, 90000, N'146bfe6d-dfbf-4a94-8466-1b11563e23ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1597, 90000, N'64e34732-59a8-4c08-b57f-70439fd8c32f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1598, 90000, N'30dc4505-5cd6-4e6a-ba7d-796492a23eb2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1599, 90000, N'c86f9b2d-4850-40c9-95b2-38034df243f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1600, 90000, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1601, 90000, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1602, 90000, N'7c0f7cd0-65b7-4c4a-a6b7-95fe64d35522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1603, 90000, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1604, 90000, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1605, 90000, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1606, 90000, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1607, 90000, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1608, 90000, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1609, 90000, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1610, 90000, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1611, 90000, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1612, 90000, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1613, 90000, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1614, 90000, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1615, 90000, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1616, 90000, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1617, 90000, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1618, 90000, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1619, 90000, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1620, 90000, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1621, 90000, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1622, 90000, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1623, 90000, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1624, 90000, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1625, 90000, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1626, 90000, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1627, 90000, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1628, 90000, N'ae99aa0c-146f-4b4f-81d2-a95fb077a367', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1629, 90000, N'7b1e7ccb-fd1e-4271-b7b3-5f8d5efb5cec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1630, 90000, N'a6204969-3848-412d-80e1-c596eb740f36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1631, 90000, N'249ba7d6-26bc-43df-b75d-b568252cc2c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1632, 90000, N'a17f6c5f-71a4-4086-af06-43926cf30080', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1633, 90000, N'336fdb14-6186-41c2-b2ff-98c99ea25c5f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1634, 90000, N'05d45e13-6184-4085-b9b2-86015af49e11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1635, 90000, N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1636, 90000, N'712d6299-495e-45ce-9010-20e4ad36834a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1637, 90000, N'11ab7a69-a705-4f46-8821-9bb3b7815a98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1638, 90000, N'831becf0-0744-4fe4-b79c-dec135cee846', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1639, 90000, N'a6c247bc-d584-43a3-b995-f303e3b13c77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1640, 90000, N'be512744-b639-4f8a-ab84-e7f568ff5289', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1641, 90000, N'f2715a17-ba0e-437b-a939-94382f648337', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1642, 90000, N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1643, 90000, N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1644, 90000, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1645, 90000, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1646, 90000, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1647, 90000, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1648, 90000, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1649, 90000, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1650, 90000, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1651, 90000, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1652, 90000, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1653, 90000, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1654, 90000, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1655, 90000, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1656, 90000, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1657, 90000, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1658, 90000, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1659, 90000, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1660, 90000, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1661, 90000, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1662, 90000, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1663, 90000, N'26f81117-51f9-4638-aec4-801a6a296945', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1664, 90000, N'114535ed-507b-48dd-8a35-bbdc252a82a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1665, 90000, N'a36dadb4-a0e3-4a10-a52d-24273c131af1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1666, 90000, N'273e5d24-26ed-4c78-9de1-6ac406b3529a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1667, 90000, N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1668, 90000, N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1669, 90000, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1670, 90000, N'de36105a-564c-478d-ad54-a9c6e64db410', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1671, 90000, N'df7e2b4d-01f0-44d6-a7d6-8337225897c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1672, 90000, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1673, 90000, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1674, 90000, N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1675, 90000, N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1676, 90000, N'e31fdfff-824c-4a7d-a640-8f43a6c4f824', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1677, 90000, N'6c104837-0a04-43d6-b200-177b98588522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1678, 90000, N'cc715473-7abd-4b07-8458-a07daaca6e15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1679, 90000, N'a66523be-f0b3-4420-aea5-ecba26c130be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1680, 90000, N'dc736454-3856-4968-9662-4c1800a85f4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1681, 90000, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1682, 90000, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1683, 90000, N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1684, 90000, N'17100aba-2fde-4a45-9e1c-4cf93f3b2248', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1685, 90000, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1686, 90000, N'26236d58-2ef6-493d-a936-3bb2a1efc1a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1687, 90000, N'fb07746a-f1b1-43f6-823f-643fb9100df1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1688, 90000, N'aa016aeb-2fda-4e56-83ce-6286ab21c128', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1689, 90000, N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1690, 90000, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1691, 90000, N'946982d0-e0c4-4c58-8959-c1731f793163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1692, 90000, N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1693, 90000, N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1694, 90000, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1695, 90000, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1696, 90000, N'86de038f-e73a-4cf8-9d0c-3c488130396e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1697, 90000, N'fdc96a50-12cd-46db-9007-16ae4d4342e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1698, 90000, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1699, 90000, N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1700, 90000, N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1701, 90000, N'd482c274-39ec-4dad-a850-fc692fb38c62', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1702, 90000, N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1703, 90000, N'234ca81d-87b9-43a3-a215-2908500fb7c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1704, 90000, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1705, 90000, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1706, 90000, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1707, 90000, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1708, 90000, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1709, 90000, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1710, 90000, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1711, 90000, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1712, 90000, N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1713, 90000, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1714, 90000, N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1715, 90000, N'd617ff97-654e-4788-add5-c28e90abe680', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1716, 90000, N'48ae5050-184c-44e4-861e-d256272b207d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1717, 90000, N'aee4bc17-1442-48b2-a95b-3ec265c58cd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1718, 90000, N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1719, 90000, N'5069d2f1-0dbe-4d29-ae69-130d560901c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1720, 90000, N'faff4451-6454-4dff-b4a9-6168f1edf526', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1721, 90000, N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1722, 90000, N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1723, 90000, N'376cbf30-280f-4ae0-af13-129d1cd02aca', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1724, 90000, N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1725, 90000, N'966e921f-2d1b-4475-a540-87edecfb27ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1726, 90000, N'7d159002-e21e-4829-87de-346273d5eccb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1727, 90000, N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1728, 90000, N'7e97bd9c-d247-4d24-97aa-cafc8535848d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1729, 90000, N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1730, 90000, N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1731, 90000, N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1732, 90000, N'51c504b7-3fd2-4111-9652-05b295f0732f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1733, 90000, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1734, 90000, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1735, 90000, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1736, 90000, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1737, 90000, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1738, 90000, N'299729a5-d7ed-4f30-a13c-1960d7374507', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1739, 90000, N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1740, 90000, N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1741, 90000, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1742, 90000, N'0b681d01-ff60-45e3-877b-f3b6e2e06553', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1743, 90000, N'a4eb7107-2ee3-421e-9271-816939a454d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1744, 90000, N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1745, 90000, N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1746, 90000, N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1747, 90000, N'430759b9-c9c2-4d57-8812-94b07d8271c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1748, 90000, N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1749, 90000, N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1750, 90000, N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1751, 90000, N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1752, 90000, N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1753, 90000, N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1754, 90000, N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1755, 90000, N'c4827784-0363-4114-9d98-2c7aad82fa02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1756, 90000, N'da31dab8-5111-4a29-8fea-a8f893479229', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1757, 90000, N'0233afff-931a-48cc-86d9-c8a83b415efa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1758, 90000, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1759, 90000, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1760, 90000, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1761, 90000, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1762, 90000, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1763, 90000, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1764, 90000, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1765, 90000, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1766, 90000, N'2e00c99b-cd88-41aa-8751-68402a23b014', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1767, 90000, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1768, 90000, N'b0a20ad6-7b71-4d09-a25e-3e843f847335', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1769, 90000, N'4653a3cf-5480-49a3-af52-1ede7d7a5432', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1770, 90000, N'9ebcf470-1da4-4448-b8f5-41d5442849ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1771, 90000, N'fc2da022-f055-48a0-9f91-643710950d43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1772, 90000, N'72ab7a79-351b-4893-8b79-d4d03fa39b4b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1773, 90000, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1774, 90000, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1775, 90000, N'28e36f79-bac9-4340-a942-95dc9888c9d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1776, 90000, N'33fc3fb8-f12b-40af-acfa-be21fddbd790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1777, 90000, N'41eabde8-52de-4c93-895e-afdd95ada7dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1778, 90000, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1779, 90000, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1780, 90000, N'5472cf06-def0-4062-95df-6c6abb535288', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1781, 90000, N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1782, 90000, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1783, 90000, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1784, 90000, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1785, 90000, N'ee642289-11eb-4bf4-96d7-d29cf86f8af5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1786, 90000, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1787, 90000, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1788, 90000, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1789, 90000, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1790, 90000, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1791, 90000, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1792, 90000, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1794, 90000, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1795, 90000, N'091cdee7-2d1d-4ce7-a78c-259f714f4fbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1796, 90000, N'ed815f54-f12c-4a06-90a0-883367d6ae5e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1797, 90000, N'12900316-455b-457e-9608-99bd7784b5b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1798, 90000, N'338293ba-7779-49e3-84b9-5129e4595976', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1799, 90000, N'0b100835-2d9f-4822-988d-8398825d890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1800, 90000, N'05b91908-5bf4-4bdd-a308-0e265b1a3eb1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1801, 90000, N'77ecfd18-7fc5-43fa-b4d1-41e00441716d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1802, 90000, N'81be47a9-267e-46db-b29f-176d78feb76c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1803, 90000, N'2e273d46-f310-4045-b71c-b3d030366786', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1804, 90000, N'1aebf541-0e2c-4bc5-b831-7e279c18e07f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1805, 90000, N'b1872538-a731-457c-b014-c9724c5f400a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1806, 90000, N'b1b04e81-9891-4d43-b0ea-1082b1946c1c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1807, 90000, N'c4c58629-cb0f-4677-92c4-0b996bc3e9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1808, 90000, N'e7f1b097-aa16-4324-876e-9fa2346c4c1d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1809, 90000, N'7768e6b6-f89a-479d-8d78-37d17a7337a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1810, 90000, N'df35e021-6ac4-47ef-ae79-622eee46118a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1811, 90000, N'84cb4ba1-c6b6-4bfe-a3be-8b13ca958607', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1812, 90000, N'1be65a49-42aa-4b69-ae86-3e338a534397', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1813, 90000, N'4ab8a098-0fd4-49d1-b3b4-257cc77e6bde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1814, 90000, N'87d5550c-243f-464e-b840-538984cdbcd3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1815, 90000, N'ea8dd2bf-d37e-4a9d-96e9-fc5a712c9916', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1816, 90000, N'd166dfdd-0289-40ad-af71-bf2ef8d92de7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1817, 90000, N'59e39e77-7e34-402b-9cb7-1e5979851a45', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1818, 90000, N'4c4456b1-e25a-450b-b8ed-f1754b052cf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1819, 90000, N'8604a88c-4e5b-4f8b-80f6-80d2e64a1173', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1820, 90000, N'23c296a6-c18d-476a-9a90-dfee961b3e91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1821, 90000, N'9ab63ad6-398c-433e-8bde-bea519eccb9b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1822, 90000, N'1c185dc5-ffc3-4c5a-8b57-999f0ec1b8d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1823, 90000, N'a0df3ec7-881e-47d4-bb76-7f1750945bb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1824, 90000, N'58383b7d-21a0-408b-9a20-227754aed94a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1825, 90000, N'e9853c97-1317-4cd0-a65a-80d46b3e6f0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1826, 90000, N'e7e18cc9-29ef-499d-a303-20c78c9c612d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1827, 90000, N'c8a6739e-bf26-4f95-b5ec-39910ab21619', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1828, 90000, N'96764174-5f40-462c-a27d-33da5e1370b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1829, 90000, N'0723db00-80a1-4125-855d-499d87c4ac90', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1830, 90000, N'b46bf40d-dd79-4cb7-9109-606b26d7f2a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1831, 90000, N'7ab868d2-7df9-43f4-ad8c-7db411841503', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1832, 90000, N'8f1efa25-37cd-46b1-9f19-ca227c793d8b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1833, 90000, N'e7503523-4b3e-4562-9a4f-b7ed827b9a29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1834, 90000, N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1835, 90000, N'8ae23626-4c5f-4cfb-abe9-d33c2150991b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1836, 90000, N'a869f004-0ee9-4bfd-9986-7248355c6052', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1837, 90000, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1838, 90000, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1839, 90000, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1840, 90000, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1841, 90000, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1842, 90000, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1843, 90000, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1844, 90000, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1845, 90000, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1846, 90000, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1847, 90000, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1848, 90000, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1849, 90000, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1850, 90000, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1851, 90000, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1852, 90000, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1853, 90000, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1854, 90000, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1855, 90000, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1856, 90000, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1857, 90000, N'776d3e4e-c68b-43c3-a5a3-f91385bd6296', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1858, 90000, N'd87ce1b0-b82f-4927-8ef4-cee2b7d54d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1859, 90000, N'8bd4017e-1b0e-432c-97cb-8b13bf6274fd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1860, 90000, N'f4ae521c-e52a-4e36-a13d-7d238dab1469', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1861, 90000, N'e5a6ccba-20d6-47db-b131-9c564f67a361', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1862, 90000, N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1863, 90000, N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1864, 90000, N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1865, 90000, N'8abd5fc1-be98-4340-bc15-25b76115782f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1866, 90000, N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1867, 90000, N'97795e35-e1f6-4d05-afe3-6773afb2d254', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1868, 90000, N'd32b919b-6b19-4548-af32-5854f6d795fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1869, 90000, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1870, 90000, N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1871, 90000, N'1d587003-8abd-4e4c-a096-5fa386feb25e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1872, 90000, N'b8afa156-3522-420c-9118-c7fce2208fcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1873, 90000, N'888c5233-b854-478e-b3e6-860eb288a09c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1874, 90000, N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1875, 90000, N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1876, 90000, N'4c727392-f0f3-4ea7-893d-123648e831cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1877, 90000, N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1878, 90000, N'2755658f-cb5e-41e9-8298-c97721bdba77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1879, 90000, N'603beed9-c3c3-46e1-8560-19706553c33c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1880, 90000, N'cc05f689-5a26-4084-957f-468ffa646d39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1881, 90000, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1882, 90000, N'46f3f410-4514-49a9-87fa-c79e653d17bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1883, 90000, N'e83a0045-89c6-459f-8d99-89c25077f4ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1884, 90000, N'322d8fea-9553-46c1-a83b-24276d046f53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1885, 90000, N'5d854334-c1b7-48c8-8811-7a37ca16dc7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1886, 90000, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1887, 90000, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1888, 90000, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1889, 90000, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1890, 90000, N'86894159-c1f3-44ab-bddc-a578289077a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1891, 90000, N'd604fb47-2f09-4a36-8ccc-b697fcbf3205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1892, 90000, N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100200, N'CONTRAT', N'Contrat', N'Contrat', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100300, N'PAIE', N'Paie', N'Paie', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100302, N'Recrutement', N'Recrutement', N'Recrutement', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100303, N'EMPLOYEES', N'Employés', N'EMPLOYEES', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100000, N'Consultant                                        ', N'Consultant                                        ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100001, N'Manager                                           ', N'Manager                                           ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100002, N'Responsable RH                                    ', N'Responsable RH                                    ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100003, N'Responsable PAY                                   ', N'Responsable PAY                                   ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100010, N'Contrat-Full                                      ', N'Contrat Full                                      ', 0, NULL, 100200)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101008, N'Contract-Disabled-All-Data                        ', N'Contrat Full sans modif                           ', 0, NULL, 100200)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101009, N'Contract-Disabled-Without-BaseSalary-Bonus        ', N'Contrat ss SB/Prime                               ', 0, NULL, 100200)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101011, N'Session de Paie                                   ', N'Session de Paie                                   ', 0, NULL, 100300)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101012, N'Ordre de Virement                                 ', N'Ordre de Virement                                 ', 0, NULL, 100300)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101013, N'Déclaration CNSS                                  ', N'Déclaration CNSS                                  ', 0, NULL, 100300)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101014, N'Employé avec Modification                         ', N'Employé/Read/Write                                ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101015, N'Employé sans Modification                         ', N'Employé/Read                                      ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101016, N'Retenue à la Source                               ', N'Retenue à la Source                               ', 0, NULL, 100300)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101017, N'Session de facturation                            ', N'Historique Achat                                  ', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101018, N'Contrat de prestation                             ', N'Session de facturation                            ', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1, N'a710d793-9662-486c-8b3b-01d2a592111b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (2, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (3, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (4, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (5, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (6, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (7, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (8, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (9, N'11503286-9245-41ee-a502-caa5ea9cf776', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (10, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (11, N'4191141d-e747-40bd-a448-733d5c23f083', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (12, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (13, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (14, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (15, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (16, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (17, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (18, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (19, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (20, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (21, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (22, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (23, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (24, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (25, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (26, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (27, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (28, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (29, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (30, N'a710d793-9662-486c-8b3b-01d2a592111b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (31, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (32, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (33, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (34, N'11503286-9245-41ee-a502-caa5ea9cf776', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (35, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (36, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (37, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (38, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (39, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (40, N'461500a8-a604-46ab-ab77-8517783aea0d', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (41, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (42, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (43, N'997d1f54-a483-4452-be25-3b9a9eab3884', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (44, N'14110ae1-17a1-446a-a3db-f893a04f4794', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (45, N'b678b40a-e499-4961-862b-eae2ecf7baef', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (46, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (47, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (48, N'ba44579d-71ad-404e-9a65-2e380b698b19', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (49, N'3545d556-108a-4d68-9c99-afc572ba34df', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (50, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (51, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (52, N'a710d793-9662-486c-8b3b-01d2a592111b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (53, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (54, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (55, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (56, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (57, N'4191141d-e747-40bd-a448-733d5c23f083', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (58, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (59, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (60, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (61, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (62, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (63, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (64, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (65, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (66, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (68, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (69, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (70, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (71, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (72, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (73, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (74, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (75, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (76, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (77, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (78, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (79, N'1755151f-da27-40ad-b605-c51624e5779a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (80, N'49c4d264-53af-4038-8466-2ee31b3b915c', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (81, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (82, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (83, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (84, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (85, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (86, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (87, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (88, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (89, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (90, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (91, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (92, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (93, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (94, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (95, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (96, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (97, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (98, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (99, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (100, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (101, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (102, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (103, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (104, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (105, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (106, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (107, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (108, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (109, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (110, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (111, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (112, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (113, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (114, N'de7d394d-0c2d-4819-8434-97acb048467f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (115, N'bef67db7-625d-41e7-99ae-e116177d04a1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (116, N'21188e34-572b-4328-bf25-268df5eb2da0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (117, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (118, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (119, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (120, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (121, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (122, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (123, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (124, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (125, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (126, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (127, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (128, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (129, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (130, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (131, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (132, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (133, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (134, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (135, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (136, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (137, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (138, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (139, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (140, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (141, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (142, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (143, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (144, N'bef67db7-625d-41e7-99ae-e116177d04a1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (145, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (146, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (147, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (148, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (149, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (150, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (151, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (152, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (153, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (154, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (155, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (156, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (157, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (158, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (159, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (160, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (161, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (162, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (163, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (164, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (165, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (166, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (167, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (168, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (169, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (170, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (171, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (172, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (173, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (174, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (175, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (176, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (177, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (178, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (179, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (180, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (181, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (182, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (183, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (184, N'949f1777-0d49-4e49-b776-34e801b9da85', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (185, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (186, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (187, N'8b43714c-d306-45b4-8d67-311a393e9133', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (188, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (189, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (190, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (191, N'1755151f-da27-40ad-b605-c51624e5779a', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (192, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (193, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (194, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (195, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (196, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (197, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (198, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (199, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (200, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (201, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (202, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (203, N'eeeef661-f871-435a-badd-be1d6c96765b', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (204, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (205, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (206, N'1755151f-da27-40ad-b605-c51624e5779a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (207, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (208, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (209, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (210, N'8b43714c-d306-45b4-8d67-311a393e9133', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (211, N'ae298068-a632-40b3-b2d4-aa4636697160', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (212, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (213, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (214, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (215, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (216, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (217, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (218, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (219, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (220, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (221, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (222, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (223, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (224, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (225, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (226, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (227, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (228, N'927010d6-12da-45af-9a65-a453d766cfcf', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (229, N'49c4d264-53af-4038-8466-2ee31b3b915c', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (230, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (231, N'25200373-be95-4c8b-8f47-ca13ef03341e', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (232, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (233, N'8a648529-4f11-4df5-b569-85958ea994f6', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (234, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (235, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (236, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (237, N'927010d6-12da-45af-9a65-a453d766cfcf', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (238, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (239, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (240, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (241, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (242, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (243, N'49c4d264-53af-4038-8466-2ee31b3b915c', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (244, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (245, N'8b43714c-d306-45b4-8d67-311a393e9133', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (246, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (247, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (248, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (249, N'8a648529-4f11-4df5-b569-85958ea994f6', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (250, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (251, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (252, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (253, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (254, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (255, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (256, N'ae298068-a632-40b3-b2d4-aa4636697160', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (257, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (258, N'eeeef661-f871-435a-badd-be1d6c96765b', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (259, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (260, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (261, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (262, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (263, N'25200373-be95-4c8b-8f47-ca13ef03341e', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (264, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (265, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (266, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (267, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (268, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (269, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (270, N'1755151f-da27-40ad-b605-c51624e5779a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (271, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (272, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (273, N'949f1777-0d49-4e49-b776-34e801b9da85', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (274, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (275, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (276, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (277, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (278, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (279, N'5b998e60-fe89-4578-83bf-9471bdec317d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (280, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (281, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (282, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (283, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (284, N'51bf3865-133e-4e97-9f81-13564644742d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (285, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (286, N'a49cd432-de82-40d6-8994-ce2f102039cc', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (287, N'5c56d444-523c-4cb3-8554-1a88b3af0779', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (288, N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (289, N'd2343785-b0e5-4d87-8f03-78d62c876d43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (290, N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (291, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (292, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (293, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (294, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (295, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (296, N'21188e34-572b-4328-bf25-268df5eb2da0', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (297, N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (298, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (299, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (300, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (301, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (302, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (303, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (304, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (305, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (306, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (307, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (308, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (309, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (310, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (311, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (312, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (313, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (314, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (315, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (316, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (317, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (318, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (319, N'5b998e60-fe89-4578-83bf-9471bdec317d', 101012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (320, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (321, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (322, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (323, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 101016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (324, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (325, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 101014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (326, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (327, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 101015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (328, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100005, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (329, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (330, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (331, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (332, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (333, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 101018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (334, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (335, N'a710d793-9662-486c-8b3b-01d2a592111b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (336, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (337, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (338, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (339, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (340, N'156c4296-861c-4633-ac28-08eac1d8a49e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (341, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (342, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (343, N'38a92b23-2180-4497-ba96-0fe49758074f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (344, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (345, N'51bf3865-133e-4e97-9f81-13564644742d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (346, N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (347, N'5c56d444-523c-4cb3-8554-1a88b3af0779', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (348, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (349, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (350, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (351, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (352, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (353, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (354, N'21188e34-572b-4328-bf25-268df5eb2da0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (355, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (356, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (357, N'd0ed74ae-f0a9-4be7-89df-28c2d239f69d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (358, N'22367de5-32f0-4fd7-9340-296c7879c03f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (359, N'ba44579d-71ad-404e-9a65-2e380b698b19', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (360, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (361, N'49c4d264-53af-4038-8466-2ee31b3b915c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (362, N'8b43714c-d306-45b4-8d67-311a393e9133', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (363, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (364, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (365, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (366, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (367, N'949f1777-0d49-4e49-b776-34e801b9da85', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (368, N'997d1f54-a483-4452-be25-3b9a9eab3884', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (369, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (370, N'101da8f5-e467-4af1-9b19-3d01ca21cf7c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (371, N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (372, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (373, N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (374, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (375, N'afd3d290-ace7-4571-9444-4334f3171856', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (376, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (377, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (378, N'a9f72604-b294-4035-a890-479a2d17ce10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (379, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (380, N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (381, N'cc4b6a10-a842-4a65-a673-4acea9fb9cac', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (382, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (383, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (384, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (385, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (386, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (387, N'353d9847-1d65-4ba3-8582-57883d8f0267', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (388, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (389, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (390, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (391, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (392, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (393, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (394, N'4191141d-e747-40bd-a448-733d5c23f083', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (395, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (396, N'd2343785-b0e5-4d87-8f03-78d62c876d43', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (397, N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (398, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (399, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (400, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (401, N'904decde-cef0-4150-9883-83e9839387c2', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (402, N'461500a8-a604-46ab-ab77-8517783aea0d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (403, N'8a648529-4f11-4df5-b569-85958ea994f6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (404, N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (405, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (406, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (407, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (408, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (409, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (410, N'5b998e60-fe89-4578-83bf-9471bdec317d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (411, N'd1f0441a-a83f-414a-a106-9539a26a58ef', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (412, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (413, N'703af1ef-fe51-4186-adeb-9663d164b2a0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (414, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (415, N'de7d394d-0c2d-4819-8434-97acb048467f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (416, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (417, N'bea10b66-d2ee-49fe-be89-98b7fb911ff6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (418, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (419, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (420, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (421, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (422, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (423, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (424, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (425, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (426, N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (427, N'927010d6-12da-45af-9a65-a453d766cfcf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (428, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (429, N'ab566211-44ce-44a8-a843-a6764f816249', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (430, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (431, N'ae298068-a632-40b3-b2d4-aa4636697160', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (432, N'deb534e2-0848-48d3-8074-acd7e2805b58', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (433, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (434, N'3545d556-108a-4d68-9c99-afc572ba34df', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (435, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (436, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (437, N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (438, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (439, N'3bceb952-b852-4d24-9f76-b472b3570486', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (440, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (441, N'214c0463-7e29-4740-acf7-bccec1adfa43', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (442, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (443, N'eeeef661-f871-435a-badd-be1d6c96765b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (444, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (445, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (446, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (447, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (448, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (449, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (450, N'1755151f-da27-40ad-b605-c51624e5779a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (451, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (452, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (453, N'25200373-be95-4c8b-8f47-ca13ef03341e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (454, N'11503286-9245-41ee-a502-caa5ea9cf776', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (455, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (456, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (457, N'a49cd432-de82-40d6-8994-ce2f102039cc', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (458, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (459, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (460, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (461, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (462, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (463, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (464, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (465, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (466, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (467, N'bef67db7-625d-41e7-99ae-e116177d04a1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (468, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (469, N'4ab9f044-39b3-4ba2-8830-e86ab9971d49', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (470, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (471, N'081ef980-e302-4386-89fa-ea31857b1c2d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (472, N'b678b40a-e499-4961-862b-eae2ecf7baef', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (473, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (474, N'659f9dfd-ad67-4129-8d2d-ebc28cc54334', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (475, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (476, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (477, N'3f092f7b-64cf-4ec9-b571-ee69defc3310', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (478, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (479, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (480, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (481, N'a1c1288e-6557-4a5d-b12d-f32e8d48629a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (482, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (483, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (484, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (485, N'14110ae1-17a1-446a-a3db-f893a04f4794', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (486, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 90000, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF

GO
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'101da8f5-e467-4af1-9b19-3d01ca21cf7c', N'TrainingSeance', N'1755151f-da27-40ad-b605-c51624e5779a', 31, N'TrainingSeance', N'TrainingSeance', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'156c4296-861c-4633-ac28-08eac1d8a49e', N'TrainingRequiredSkills', N'1755151f-da27-40ad-b605-c51624e5779a', 30, N'TrainingRequiredSkills', N'TrainingRequiredSkills', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'353d9847-1d65-4ba3-8582-57883d8f0267', N'TrainingRequest', N'1755151f-da27-40ad-b605-c51624e5779a', 29, N'TrainingRequest', N'TrainingRequest', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'3f092f7b-64cf-4ec9-b571-ee69defc3310', N'Office', N'efa1d60e-933b-4749-bac3-a15e8bba3415', 22, N'Office', N'Office', N'Office', NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'4ab9f044-39b3-4ba2-8830-e86ab9971d49', N'TrainingExpectedSkills', N'1755151f-da27-40ad-b605-c51624e5779a', 28, N'TrainingExpectedSkills', N'TrainingExpectedSkills', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'659f9dfd-ad67-4129-8d2d-ebc28cc54334', N'MobilityRequest', N'1755151f-da27-40ad-b605-c51624e5779a', 25, N'MobilityRequest', N'MobilityRequest', N'MobilityRequest', N'MobilityRequest', N'MobilityRequest', N'MobilityRequest', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'703af1ef-fe51-4186-adeb-9663d164b2a0', N'RecruitmentRequest', N'1755151f-da27-40ad-b605-c51624e5779a', 2, N'RecruitmentRequest', N'RecruitmentRequest', N'RecruitmentRequest', N'RecruitmentRequest', N'RecruitmentRequest', N'RecruitmentRequest', N'icon-note', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96', N'RecruitmentOffer', N'1755151f-da27-40ad-b605-c51624e5779a', 2, N'RecruitmentOffer', N'RecruitmentOffer', N'RecruitmentOffer', N'RecruitmentOffer', N'RecruitmentOffer', N'RecruitmentOffer', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'a1c1288e-6557-4a5d-b12d-f32e8d48629a', N'Training', N'1755151f-da27-40ad-b605-c51624e5779a', 26, N'Formation', N'Training', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'ac1db73f-5b3c-475b-b404-3495d78c499a', N'SourceDeductionSession', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 12, N'SourceDeductionSession', NULL, NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'bea10b66-d2ee-49fe-be89-98b7fb911ff6', N'TrainingSession', N'1755151f-da27-40ad-b605-c51624e5779a', 32, N'TrainingSession', N'TrainingSession', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', N'BillingSession', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 15, N'Session de facturation', N'Billing Session', N'Billing Session', N'Billing Session', N'Billing Session', N'Billing Session', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a', N'TrainingByEmployee', N'1755151f-da27-40ad-b605-c51624e5779a', 27, N'TrainingByEmployee', N'TrainingByEmployee', NULL, NULL, NULL, NULL, N'icon-note', 0)
GO
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0a79cac9-439d-4585-8b0c-0f6dc974567e', N'fec2953f-8d6a-486e-be75-da22ce474769', N'bf043378-ebc1-4c83-ba68-f78da6ef36ec')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0b58f14e-6592-454c-85e5-4d9fcf7b501d', N'b2ada670-254e-4184-adcb-1040530e07b4', N'ac1db73f-5b3c-475b-b404-3495d78c499a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0ebb9f26-b8b2-4780-a264-4f3fdeb26386', N'97ebe4a1-869b-4dc5-a45e-d6793aecac4a', N'703af1ef-fe51-4186-adeb-9663d164b2a0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0f7c63a8-0bac-4d93-a07a-6d95cc78fe37', N'1a363e4d-7b0a-4068-b3f3-9e18156d8f02', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'102f4760-243d-42fe-aa09-1fcbfde3a8e3', N'5ff51996-2f10-48b2-9926-3b066ba424ea', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'15aaa79a-1b27-477b-965a-f6298d5c3238', N'a41ac9d1-7da0-42da-b965-67b848291b00', N'bf043378-ebc1-4c83-ba68-f78da6ef36ec')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'18446e52-6025-4565-aada-aa5d782052ea', N'146bfe6d-dfbf-4a94-8466-1b11563e23ad', N'703af1ef-fe51-4186-adeb-9663d164b2a0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'18f6e8e3-c88f-41d3-b506-445fdde6a048', N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'19279385-60f3-42a7-8f16-c49e3a680caf', N'1c185dc5-ffc3-4c5a-8b57-999f0ec1b8d2', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1b36e242-4207-4b4d-9bbf-4a501c71cc44', N'df35e021-6ac4-47ef-ae79-622eee46118a', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1f2d3215-b1d6-4a1b-b1a7-ca44a3da17ea', N'e7e18cc9-29ef-499d-a303-20c78c9c612d', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1fd1a3ef-d024-4fcf-b8ae-6e875638e6d4', N'8604a88c-4e5b-4f8b-80f6-80d2e64a1173', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2126a97a-f0e0-4dec-9893-e79a3872dcda', N'20de167f-fde4-4fa3-a154-edb87e97bf73', N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'22706b31-38e8-4b27-a766-94cf933cb09b', N'1be65a49-42aa-4b69-ae86-3e338a534397', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2286471e-e10b-4eff-a128-e7203558659c', N'0b100835-2d9f-4822-988d-8398825d890c', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'23628129-ac65-408f-a6c6-d59e82e582a1', N'7768e6b6-f89a-479d-8d78-37d17a7337a0', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'249d3b2c-8887-4bf9-ab9c-152fff8af578', N'9ab63ad6-398c-433e-8bde-bea519eccb9b', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'28670b6e-83e9-4603-89a9-94bd89b32c11', N'8ae23626-4c5f-4cfb-abe9-d33c2150991b', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2a9d9cde-3bf4-4f87-8314-08cc716ed0d4', N'091cdee7-2d1d-4ce7-a78c-259f714f4fbe', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2e104806-d655-491f-808b-6e38ebc230d8', N'a929572d-d410-4af3-bef6-54cabf950006', N'bf043378-ebc1-4c83-ba68-f78da6ef36ec')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2ff085a0-3e91-40e6-a2e5-fb253c851406', N'6ec0e7ba-4728-4b79-8ecd-c74c3f0e196f', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'31081c5e-3bcd-4241-b5ec-1d3953572ac7', N'c008d163-29c2-4426-aac1-cdd45c9c0d66', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'36dcce68-a2f6-4d6a-906a-612d07b725c8', N'176d82de-4723-4ed2-bc44-2775f36965c3', N'ac1db73f-5b3c-475b-b404-3495d78c499a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'37737730-f693-40af-886c-c4c300d7ff64', N'94381ea1-15ea-4559-a9c7-cf6ddb53ec40', N'659f9dfd-ad67-4129-8d2d-ebc28cc54334')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'389c67aa-c3b0-48f7-a27a-4dcf7f9e6279', N'96764174-5f40-462c-a27d-33da5e1370b3', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3bc9e8d8-7327-4d8a-8974-76cb4c38e68d', N'7ab868d2-7df9-43f4-ad8c-7db411841503', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3d15a0e6-8acb-45d5-8301-2250faf26259', N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', N'ac1db73f-5b3c-475b-b404-3495d78c499a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'45992591-d6b1-4f32-b266-05eb6d0bb5f0', N'cb3a9724-145a-4cbb-9c7a-314477295422', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'465c5906-67c6-4fb5-b29b-96892142b091', N'c8a6739e-bf26-4f95-b5ec-39910ab21619', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4fa634d7-0407-42c9-85dc-13638953a57a', N'9019037e-b18e-4b83-98dd-d9590a10670c', N'659f9dfd-ad67-4129-8d2d-ebc28cc54334')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5145601d-347d-4ea9-bb2b-bb2b2710c10a', N'b5216afc-d33d-46f3-b7db-a4170912d7c6', N'3f092f7b-64cf-4ec9-b571-ee69defc3310')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'51d58a9c-020a-413f-a945-54f7e9c06f27', N'ab0d83dd-e6be-45a5-9f20-014500cbc3f8', N'3f092f7b-64cf-4ec9-b571-ee69defc3310')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5cba07f9-3600-413c-82a3-ce89077d13f8', N'ea8dd2bf-d37e-4a9d-96e9-fc5a712c9916', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5cd5fac2-3a87-4342-b7fe-cc74ad7b81ad', N'eb9493fd-c2ce-46f4-9c5f-0ec347035ffd', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5fd568c1-8a18-405c-a4dc-35483a7295a9', N'8f1efa25-37cd-46b1-9f19-ca227c793d8b', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'68f5286b-cd3c-4e67-ad47-8b6588df2af1', N'a28ae2c3-0181-4479-b146-56b951870f0e', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6b754048-701e-494a-b43f-4ba882967616', N'b1b04e81-9891-4d43-b0ea-1082b1946c1c', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'70047a62-bf4b-40e8-92e7-1fc161e17dab', N'58383b7d-21a0-408b-9a20-227754aed94a', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'71545b71-d6e5-4ca6-8f4d-f31ea0d8d3f0', N'23c296a6-c18d-476a-9a90-dfee961b3e91', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'71afc8f8-2de8-4ec9-b19f-83aa61dd5de4', N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', N'659f9dfd-ad67-4129-8d2d-ebc28cc54334')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'73f556bb-1708-4327-9782-da8ae104fb7a', N'c86f9b2d-4850-40c9-95b2-38034df243f7', N'703af1ef-fe51-4186-adeb-9663d164b2a0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'75e0b9d6-eca6-422d-9df1-6058d314626d', N'2e273d46-f310-4045-b71c-b3d030366786', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'77f6c723-a326-431b-a89e-3dc52aebf1c9', N'81be47a9-267e-46db-b29f-176d78feb76c', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'84a0a7c8-86c8-4d21-a6fb-2ed525adc461', N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', N'bf043378-ebc1-4c83-ba68-f78da6ef36ec')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'867db27a-51c8-4210-901d-953a4c4daaf3', N'59e39e77-7e34-402b-9cb7-1e5979851a45', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8875476b-47a6-4bcc-8a11-b61e5511332d', N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', N'ac1db73f-5b3c-475b-b404-3495d78c499a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'89a821c7-885e-452d-8838-7b3769e4d1e4', N'c4c58629-cb0f-4677-92c4-0b996bc3e9d4', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8d3a9cad-5219-4019-9cc2-b1a89e3cb5b9', N'12900316-455b-457e-9608-99bd7784b5b4', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8e29e3e6-65f8-4416-92e4-366e0a4daa98', N'e7f1b097-aa16-4324-876e-9fa2346c4c1d', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9207d23b-cd07-4cf8-9674-7f70be96fbda', N'e7503523-4b3e-4562-9a4f-b7ed827b9a29', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9bb3504e-d3eb-4497-8a48-4031a96d7865', N'1aebf541-0e2c-4bc5-b831-7e279c18e07f', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9c5b3c7f-0d0f-49d9-84c9-81e4fea4f934', N'05b91908-5bf4-4bdd-a308-0e265b1a3eb1', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9dffdd51-b783-4558-a643-068eaa0588d5', N'0723db00-80a1-4125-855d-499d87c4ac90', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a06da65b-effd-4b2f-8ec5-a5daccca4a30', N'4ab8a098-0fd4-49d1-b3b4-257cc77e6bde', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a0c8c6ce-edff-4ea9-a8f3-ef45ecc86954', N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', N'ac1db73f-5b3c-475b-b404-3495d78c499a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a1699af7-4a1f-466e-8a9c-1c7dcf77c85e', N'87d5550c-243f-464e-b840-538984cdbcd3', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a3898492-2b71-439c-955c-1f228adb56d8', N'd166dfdd-0289-40ad-af71-bf2ef8d92de7', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a7a355e7-3c4d-433e-8de1-9260eca15ae3', N'7c0f7cd0-65b7-4c4a-a6b7-95fe64d35522', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'af3a648e-dfb3-4953-b2ec-a5f16579ebdb', N'338293ba-7779-49e3-84b9-5129e4595976', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b07270ab-2602-4c2d-9461-afdef1bdb02c', N'77ecfd18-7fc5-43fa-b4d1-41e00441716d', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b6f42698-833e-4bb2-b97f-8f507c712717', N'6904af6a-266d-4422-9e50-bac6b512cb6f', N'3f092f7b-64cf-4ec9-b571-ee69defc3310')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bbf588af-9d7b-4f89-9c58-5651ce51132e', N'e9853c97-1317-4cd0-a65a-80d46b3e6f0e', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'be196156-ae20-467c-b8ce-e91cc95d279c', N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', N'bf043378-ebc1-4c83-ba68-f78da6ef36ec')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c246e582-ffd1-4ace-b106-9d018a715af1', N'64e34732-59a8-4c08-b57f-70439fd8c32f', N'703af1ef-fe51-4186-adeb-9663d164b2a0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c42ee343-09d2-4ade-acbd-2d9cb0bef159', N'b46bf40d-dd79-4cb7-9109-606b26d7f2a9', N'bea10b66-d2ee-49fe-be89-98b7fb911ff6')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c9bae91a-abd2-4653-b476-c1dba3ba88f2', N'4c4456b1-e25a-450b-b8ed-f1754b052cf2', N'156c4296-861c-4633-ac28-08eac1d8a49e')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cc9a67b2-ad06-4c3d-8beb-509d00d0e151', N'7d64bd68-b90c-413c-a3e6-981183d49bdc', N'659f9dfd-ad67-4129-8d2d-ebc28cc54334')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd64f74f4-1186-42da-8b3a-0ba3bd07dfb3', N'b1872538-a731-457c-b014-c9724c5f400a', N'4ab9f044-39b3-4ba2-8830-e86ab9971d49')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd96cb505-7b3e-452c-b0cf-987d82d01e28', N'7112ab0c-75f0-4237-8b59-1e6a1ea54a97', N'3f092f7b-64cf-4ec9-b571-ee69defc3310')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'da5d7cc5-34ed-4e22-8a49-1533cdc52279', N'84cb4ba1-c6b6-4bfe-a3be-8b13ca958607', N'353d9847-1d65-4ba3-8582-57883d8f0267')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e8690fe1-46f0-4845-b178-b60b40578095', N'30dc4505-5cd6-4e6a-ba7d-796492a23eb2', N'703af1ef-fe51-4186-adeb-9663d164b2a0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e90b76a3-5803-4989-971e-cf79abf9ff4d', N'db45eee0-9d96-4482-ba46-a082b2090cd5', N'3f092f7b-64cf-4ec9-b571-ee69defc3310')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e9155919-983a-42bb-a556-ba060d7ab156', N'7cdb9b56-0bfb-4c75-b87d-a777709c203f', N'659f9dfd-ad67-4129-8d2d-ebc28cc54334')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ec548343-ab1b-4a98-86f5-23923f9bd6f7', N'fbac5977-0b88-4c15-a43f-cf78ee74b1b7', N'955cdcb2-ea9a-4ca4-9080-b22cdb620f96')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f28b514b-54bc-48f2-bed1-9b20e9f2c665', N'a0df3ec7-881e-47d4-bb76-7f1750945bb4', N'101da8f5-e467-4af1-9b19-3d01ca21cf7c')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fe03dde8-9c48-47b5-af54-11cc14988e1c', N'a869f004-0ee9-4bfd-9986-7248355c6052', N'a1c1288e-6557-4a5d-b12d-f32e8d48629a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ff3c0864-271a-4770-851c-53dbbf261eb5', N'ed815f54-f12c-4a06-90a0-883367d6ae5e', N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[RoleConfig]
    ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501202, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501204, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a validé le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} validated the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATION_TIMESHEET', N'VALIDATION_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501207, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/review', N' votre entretien annuel sera dans {REVIEW_DAYS_NUMBER} le  {REVIEW_DATE}', N' your annual review will be in {REVIEW_DAYS_NUMBER} days time on {REVIEW_DATE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP-Notification', 0, 0, NULL, N'NOTIFICATION_REVIEW', N'ANNUAL_REVIEW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501209, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a validé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} validated the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_VALIDATE_RECRUITMENT_REQUEST', N'VALIDATE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501213, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a refusé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} refused the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_REFUSE_RECRUITMENT_REQUEST', N'REFUSE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501214, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a annulé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_CANCEL_RECRUITMENT_REQUEST', N'CANCEL_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501215, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a ajouté un commentaire pour la demande de recrutement{CODE}', N'{CREATOR} added a comment for the recruitment request {CODE}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_RECRUITMENT_REQUEST', N'ADD_COMMENT_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501226, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employee {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_EXIT_EMPLOYEE_REQUEST', N'VALIDATE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501227, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_EXIT_EMPLOYEE_REQUEST', N'REFUSE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501230, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a annulé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CANCEL_EXIT_EMPLOYEE_REQUEST', N'CANCEL_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501231, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee/show', N'{CREATOR} a ajouté  une demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} added a new exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_EXIT_EMPLOYEE_REQUEST', N'ADD_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501232, N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', N'/rh/mobility-request/edit', N'Une demande de mobilité a été ajouté pour {EMPLOYEE_FULLNAME} (depuis son bureau actuel {CURRENT_OFFICE_NAME} vers le bureau {DESTINATION_OFFICE_NAME})', N'A mobility request has been added for{EMPLOYEE_FULLNAME} (from his current office {CURRENT_OFFICE_NAME} to the office {DESTINATION_OFFICE_NAME})', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_MOBILITY_REQUEST', N'ADD_MOBILITY_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501233, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a partiellement validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has partially validated the timesheet of {MONTH} {PROFILE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_PARTTIALLY_VALIDATED_TIMESHEET', N'PARTTIALLY_VALIDATED_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501234, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a soumis le CRA de {MONTH} {PROFIL}', N'{CREATOR} has submited the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMIT_TIMESHEET', N'SUBMIT_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501235, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has validated the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_TIMESHEET', N'VALIDATE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501236, N'ebe5d62c-129d-42a3-8097-809cd113944f', N'/purchase/purchasefinalorder/show', N'Un bon de commande définitif {CODE} a été validé', N'A final order form {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501200, N'NOTIFICATION_VALIDATE_FINAL_ORDER_FORM', N'PURCHASE_FINAL_ORDER_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501237, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', N'/purchase/purchasefinalorder/add', N'Un bon de commande définitif {CODE} a été ajouté', N'A final order form {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_FINAL_ORDER_FORM', N'PURCHASE_FINAL_ORDER_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501238, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a fait une correction du CRA de {MONTH} {PROFIL}', N'{CREATOR} made a correction of the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTE_TIMESHEET', N'CORRECTE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501239, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501240, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a soumis le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} a submitted the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMISSION_TIMESHEET', N'SUBMISSION_TIMESHEET')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (300, N'CodeRecruitmentRequest', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (301, N'CaractereRR', 1, NULL, NULL, N'RR-', 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (302, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (303, N'Caractere-', 3, NULL, NULL, N'-', 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (304, N'compteurRecruitmentRequest', 4, NULL, NULL, NULL, 300, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (305, N'CodeRecruitmentRequest-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (306, N'CaractereRA', 1, NULL, NULL, N'RA', 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (307, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (308, N'Caractere-', 3, NULL, NULL, N'-', 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (309, N'compteurRecruitmentRequest', 4, NULL, NULL, NULL, 305, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (310, N'CodeRecruitmentOffer', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (311, N'CaractereRO', 1, NULL, NULL, N'RO-', 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (312, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (313, N'Caractere-', 3, NULL, NULL, N'-', 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (314, N'compteurRecruitmentOffer', 4, NULL, NULL, NULL, 310, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (315, N'CodeRecruitmentOffer-Published', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (316, N'CaractereOA', 1, NULL, NULL, N'OA', 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (317, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (318, N'Caractere-', 3, NULL, NULL, N'-', 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (319, N'compteurRecruitmentOffer', 4, NULL, NULL, NULL, 315, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (320, N'CodeRecruitment', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (321, N'CaractereRE', 1, NULL, NULL, N'RE-', 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (322, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (323, N'Caractere-', 3, NULL, NULL, N'-', 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (324, N'compteurRecruitment', 4, NULL, NULL, NULL, 320, 1, 1, N'0005', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (61, 397, N'RecruitmentTypeCode', N'RR', 300)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (62, 397, N'RecruitmentTypeCode', N'A-RR', 305)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (63, 397, N'RecruitmentTypeCode', N'RO', 310)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (64, 397, N'RecruitmentTypeCode', N'A-RO', 315)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (65, 397, N'RecruitmentTypeCode', N'RE', 320)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (396, N'RH', N'TimesheetRequest', N'TimesheetRequest', NULL, 0, N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (397, N'RH', N'Recruitment', N'Recruitment', NULL, 0, N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (400, N'Payroll', N'EmployeeExit', N'EmployeeExit', NULL, 0, N'EmployeeExit', N'EmployeeExit', N'EmployeeExit', N'EmployeeExitt', N'EmployeeExit', N'EmployeeExit', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION


-- narcisse: Update Admin role 04-06-2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=397
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=398
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=399
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=400
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=401
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=402
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=403
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=404
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=405
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=406
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=407
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=408
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=409
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=410
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=411
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=412
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=413
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=414
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=415
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=416
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=417
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=418
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=419
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=420
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=421
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=422
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=423
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=424
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=425
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=426
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=427
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=428
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=429
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=430
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=431
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=432
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=433
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=434
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=435
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=436
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=437
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=438
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=439
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=440
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=441
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=442
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=443
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=444
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=445
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=446
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=447
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=448
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=449
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=450
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=451
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=452
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=453
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=454
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=455
DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [Id]=456
GO
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
COMMIT TRANSACTION



-- Nesrin : Functionality loan 08/06/2020

BEGIN TRANSACTION

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f4998435-c780-487c-85e0-12be94259f0b', N'Advance-ADD', 1, N'Advance-ADD', N'Advance-ADD', NULL, NULL, NULL, NULL,NULL, 1, N'Advance-ADD')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'edadff77-79d0-4bae-8e34-98d0d54328f9', N'Advance-UPDATE', 1, N'Advance-UPDATE', N'Advance-UPDATE', NULL, NULL, NULL, NULL, NULL, 1, N'Advance-UPDATE')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9b2e2e81-ff67-4267-9515-bb4f84bb7f08', N'Advance-DELETE', 1, N'Advance-DELETE', N'Advance-DELETE', NULL, NULL, NULL, NULL, NULL, 1, N'Advance-DELETE')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b74bccd4-d55e-489f-b5b5-96550020c7c4', N'Advance-SHOW', 1, N'Advance-SHOW', N'Advance-SHOW', NULL, NULL, NULL, NULL, NULL, 1, N'Advance-SHOW')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'66383dbc-585c-4a3d-9fc5-a57196252b8f', N'Advance-LIST', 1, N'Advance-LIST', N'Advance-LIST', NULL, NULL, NULL, NULL, NULL, 1, N'Advance-LIST')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'08afeb24-76a5-450a-9485-76c2aec4cbfe', N'Loan-ADD', 1, N'Loan-ADD', N'Loan-ADD', NULL, NULL, NULL, NULL,NULL, 1, N'Loan-ADD')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8037d453-1697-4ca9-8484-bf873067e84d', N'Loan-UPDATE', 1, N'Loan-UPDATE', N'Loan-UPDATE', NULL, NULL, NULL, NULL, NULL, 1, N'Loan-UPDATE')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f8645b27-1055-4ea9-9745-2fefc7985078', N'Loan-DELETE', 1, N'Loan-DELETE', N'Loan-DELETE', NULL, NULL, NULL, NULL, NULL, 1, N'Loan-DELETE')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9cfcb133-208a-4fbc-9beb-2db11f65b7cf', N'Loan-SHOW', 1, N'Loan-SHOW', N'Loan-SHOW', NULL, NULL, NULL, NULL, NULL, 1, N'Loan-SHOW')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a40e1f05-fdb5-4af0-bfb9-d45ff0f13de5', N'Loan-LIST', 1, N'Loan-LIST', N'Loan-LIST', NULL, NULL, NULL, NULL, NULL, 1, N'Loan-LIST')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8', N'Loan', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 1, N'Loan', N'Loan', N'Loan', N'Loan', N'Loan', N'Loan', N'icon-note', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'963fc33f-4604-4df2-b4c9-91877757ae28', N'Advance', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 1, N'Advance', N'Advance', N'Advance', N'Advance', N'Advance', N'Advance', N'icon-note', 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b484c304-e395-4c84-ba13-ec2d4cfd1ce4', N'08afeb24-76a5-450a-9485-76c2aec4cbfe', N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'14b9f015-5068-4a0d-985b-ef21972f0320', N'8037d453-1697-4ca9-8484-bf873067e84d', N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'50e7f6b9-a2cc-48eb-8966-23086d12cd75', N'f8645b27-1055-4ea9-9745-2fefc7985078', N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5dac789b-e4cc-4a65-89f5-36d4257a2359', N'9cfcb133-208a-4fbc-9beb-2db11f65b7cf', N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2b29316d-b83b-4194-b7b9-4831d44e511f', N'a40e1f05-fdb5-4af0-bfb9-d45ff0f13de5', N'f76f23a7-2c06-4afa-9c3f-a03c602d73e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8649f637-4f5e-430f-823a-c5a90289f264', N'f4998435-c780-487c-85e0-12be94259f0b', N'963fc33f-4604-4df2-b4c9-91877757ae28')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e7b190ff-d226-4ebd-8ac0-8e11ecd3498b', N'edadff77-79d0-4bae-8e34-98d0d54328f9', N'963fc33f-4604-4df2-b4c9-91877757ae28')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ae674a8b-033c-4593-9c55-823d1fde8221', N'9b2e2e81-ff67-4267-9515-bb4f84bb7f08', N'963fc33f-4604-4df2-b4c9-91877757ae28')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9985dc31-6a8d-47d8-86ea-4d96f3284bd1', N'b74bccd4-d55e-489f-b5b5-96550020c7c4', N'963fc33f-4604-4df2-b4c9-91877757ae28')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bfda2d88-09b2-4ad4-bff4-256ae6f27380', N'66383dbc-585c-4a3d-9fc5-a57196252b8f', N'963fc33f-4604-4df2-b4c9-91877757ae28')

SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100400, N'LoanAdvance', N'LoanAdvance', N'LoanAdvance', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
COMMIT TRANSACTION

-- Narcisse: Fix script role 09/06/2020


BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (2, N'Manager', N'Manager', 0, NULL)
--INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (11111, N'Achats', N' Achats', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (22222, N'Stock', N'Stock', 0, NULL)
--INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (33333, N'Ventes', N'Ventes', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (44444, N'Immobilisation', N'Immobilisation', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (77777, N'Reglages', N'Reglages', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (88888, N'Assistance', N'Assistance', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (90000, N'SuperAdmin', N'SuperAdmin', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100000, N'Consultant', N'Consultant', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100001, N'Responsable RH', N'Responsable RH', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100002, N'Responsable Pay', N'Responsable Pay', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100004, N'Historique Achat', N'Historique Achat', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100005, N'Session de facturation', N'Session de facturation', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100006, N'Contrat de prestation', N'Contrat de prestation', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100007, N'CRM-Test', N'CRM-Test', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF
COMMIT TRANSACTION

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a5adefe0-da79-4d63-b90a-7aead7d7ed32', N'CRM-List', 1, N'CRM', N'CRM', NULL, NULL, NULL, NULL, N'/crm/', 1, N'List-CRM')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-217b4a3c8466', N'CRM settings', 15, N'Paramétres CRM', N'CRM settings', NULL, NULL, NULL, NULL, N'/CRM', 0, N'CRM settings')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-227b4a3c8466', N'HR settings', 15, N'Paramétres RH', N'HR settings', NULL, NULL, NULL, NULL, N'/HR', 0, N'HR settings')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-237b4a3c8466', N'User management', 15, N'Gestion des utilisateurs', N'User management', NULL, NULL, NULL, NULL, N'/User_Management', 0, N'User management')
COMMIT TRANSACTION


BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] ON
--INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (2, 22222, 1, 1, 0, NULL)
--INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (3, 33333, 1, 1, 0, NULL)
--INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (15, 11111, 11111, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (16, 22222, 22222, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (17, 33333, 33333, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (18, 44444, 44444, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (19, 77777, 77777, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (20, 88888, 88888, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (21, 100000, 100000, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (22, 100002, 100001, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (23, 100003, 100002, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (25, 100006, 100005, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (26, 100005, 100004, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (27, 101018, 100006, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (28, 90000, 90000, 1, 0, NULL)
--INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (33, 101016, 101018, 1, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] OFF
COMMIT TRANSACTION


BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100301, N'CRM', N'CRM', N'CRM', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
COMMIT TRANSACTION


BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70008, N'CRM_Settings                                      ', N'Paramétrage de CRM                                ', 0, NULL, 77777)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70009, N'HR_Settings                                       ', N'Paramétrage RH                                    ', 0, NULL, 77777)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70010, N'User_Management                                   ', N'Gestion des utilisateurs                          ', 0, NULL, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
COMMIT TRANSACTION

UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100005, [IdFunctionality]=N'e21a8021-5299-4845-b534-fd1f3c46ab69' WHERE [Id]=988
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'b8d98f19-8e6b-4ad2-be55-09496026a374' WHERE [Id]=989
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'2373a969-c468-4c48-b26b-371641253486' WHERE [Id]=990
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'ebe5d62c-129d-42a3-8097-809cd113944f' WHERE [Id]=991
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3' WHERE [Id]=992
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'cc9e11cb-ce75-4b13-9453-87de0759b42a' WHERE [Id]=993
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=11111, [IdFunctionality]=N'1d587003-8abd-4e4c-a096-5fa386feb25e' WHERE [Id]=994
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100006, [IdFunctionality]=N'a41ac9d1-7da0-42da-b965-67b848291b00' WHERE [Id]=995
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100006, [IdFunctionality]=N'4489d5f4-17dd-4ec8-8f29-152cb9af1629' WHERE [Id]=996
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100006, [IdFunctionality]=N'f306de2f-2d2b-4234-8bea-01e0d3ec977d' WHERE [Id]=997
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100006, [IdFunctionality]=N'a929572d-d410-4af3-bef6-54cabf950006' WHERE [Id]=998
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100006, [IdFunctionality]=N'fec2953f-8d6a-486e-be75-da22ce474769' WHERE [Id]=999
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101018, [IdFunctionality]=N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2' WHERE [Id]=1000
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101018, [IdFunctionality]=N'81dfe010-14a0-48a7-aa0d-48023d967286' WHERE [Id]=1001
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101018, [IdFunctionality]=N'c66c33e2-d3b8-44f7-acfb-4d56498f3627' WHERE [Id]=1002
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101018, [IdFunctionality]=N'46c3a05b-eb2d-4b5d-8602-797059bc2e37' WHERE [Id]=1003
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101018, [IdFunctionality]=N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58' WHERE [Id]=1004
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'826ce05a-530f-4174-803c-a16f47ce3582' WHERE [Id]=1005
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32' WHERE [Id]=1006
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'c6ccb699-182c-4ec6-8f40-4a61032b78a8' WHERE [Id]=1007
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35' WHERE [Id]=1008
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7' WHERE [Id]=1009
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'3bdfce52-fe6a-4886-a070-ce2b9445927f' WHERE [Id]=1010
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53' WHERE [Id]=1011
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'413143f0-12c1-4787-85e3-683d02a3fbd0' WHERE [Id]=1012
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'1fc23099-0aff-4d52-be49-9cbcba9405ab' WHERE [Id]=1013
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'6c341a75-8c0d-4b12-94a2-a524b09f83bb' WHERE [Id]=1014
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'1370af42-416b-4af5-8416-d274643cc31b' WHERE [Id]=1015
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'6079b54a-948a-4241-99a4-4af59b1a82c7' WHERE [Id]=1016
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'1a5ad493-2aa3-4b33-9f27-810da7376dbe' WHERE [Id]=1017
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'183e2cc9-2522-4463-9366-775781dcb127' WHERE [Id]=1018
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'af5d4af2-8810-4ba1-a628-003796357bfb' WHERE [Id]=1019
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'be0964a9-1fe6-4049-9fdc-254c8094b267' WHERE [Id]=1020
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'f12d6dde-f573-4a78-b960-91cfeeb56643' WHERE [Id]=1021
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'a7310087-e271-40ea-ae49-60d76ede699c' WHERE [Id]=1022
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a' WHERE [Id]=1023
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb' WHERE [Id]=1024
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4' WHERE [Id]=1025
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'cf9f36ce-6028-47da-9f59-da543c45ebde' WHERE [Id]=1026
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'a6618e04-9b2b-40c2-a947-c17f54da29de' WHERE [Id]=1027
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'd7382274-1bf0-4fc5-abcc-b8e725198bd8' WHERE [Id]=1028
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'33b77acb-f6ad-4cfa-b919-99d5f5932851' WHERE [Id]=1029
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3' WHERE [Id]=1030
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'0cca5b44-467a-4807-a0e0-d583c693d776' WHERE [Id]=1031
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'017a0e7d-7829-4326-bdb7-e285e7aae9bc' WHERE [Id]=1032
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3' WHERE [Id]=1033
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'1428c6ec-25d9-477d-ab4e-efae61b2377d' WHERE [Id]=1034
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6' WHERE [Id]=1035
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'e7b3084b-711a-43e3-8ab6-a37af089281e' WHERE [Id]=1036
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4' WHERE [Id]=1037
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b' WHERE [Id]=1038
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'1c753625-4561-4abf-aef9-7a92b01e481e' WHERE [Id]=1039
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad' WHERE [Id]=1040
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'4248ba0b-646b-4525-a0a0-8713a10a608e' WHERE [Id]=1041
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'6d02633e-d8ed-4965-ad93-125f7607ee31' WHERE [Id]=1042
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'f306de2f-2d2b-4234-8bea-01e0d3ec977d' WHERE [Id]=1043
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'a41ac9d1-7da0-42da-b965-67b848291b00' WHERE [Id]=1044
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'a929572d-d410-4af3-bef6-54cabf950006' WHERE [Id]=1045
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'fec2953f-8d6a-486e-be75-da22ce474769' WHERE [Id]=1046
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'4489d5f4-17dd-4ec8-8f29-152cb9af1629' WHERE [Id]=1047
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc' WHERE [Id]=1048
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1' WHERE [Id]=1049
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8e3189a1-c37a-4004-86bd-6c8189a9b764' WHERE [Id]=1050
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f' WHERE [Id]=1051
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ef03d792-249e-4b31-b131-58f247fd399a' WHERE [Id]=1052
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'558d9955-927c-4078-91f0-d7ed9277877e' WHERE [Id]=1053
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9a9c9328-c381-48e9-9670-347caeea1761' WHERE [Id]=1054
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'78f5ae83-52fb-4229-ad38-8df8570ce7f2' WHERE [Id]=1055
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8d6a9277-682f-4f30-ba42-44a4692fd69a' WHERE [Id]=1056
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d' WHERE [Id]=1057
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7' WHERE [Id]=1058
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5' WHERE [Id]=1059
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2913a29a-35b4-4f14-9b4f-34c13879ef63' WHERE [Id]=1060
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'092d0e85-b9bc-4464-813c-f256ea284c7d' WHERE [Id]=1061
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'98d525b7-49f0-407f-953f-a2eab399ce43' WHERE [Id]=1062
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd8559505-d792-4448-9389-11553df3a53b' WHERE [Id]=1063
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b365a596-61f0-4ada-bc56-f455b9d56c51' WHERE [Id]=1064
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2eefeed5-3995-4dd4-83fa-603c440faba3' WHERE [Id]=1065
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3820fb92-f9bb-4c15-9a7f-279f97c68184' WHERE [Id]=1066
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'819b148d-a655-41e4-a030-6b0dfc006694' WHERE [Id]=1067
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eb75b4cc-b859-40b2-b126-426faf885a6a' WHERE [Id]=1068
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'97682275-a556-4232-9c34-a4b7ea15ed81' WHERE [Id]=1069
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7614e74e-e5d1-4ed0-b9b1-42676b17930a' WHERE [Id]=1070
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'128ce50b-5f62-443f-96b1-3b4351542998' WHERE [Id]=1071
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c' WHERE [Id]=1072
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bc03c3e4-f361-4150-9dc5-53b253af072c' WHERE [Id]=1073
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'245ecc4a-fa91-44af-a51b-25d312f09006' WHERE [Id]=1074
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dcf849b9-583f-4a23-b2c0-d3298ea74865' WHERE [Id]=1075
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1' WHERE [Id]=1076
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eca3ffb8-c1fb-4212-a543-a04e9e396784' WHERE [Id]=1077
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2f7a31cf-6236-4eb4-b1d1-ee065980741a' WHERE [Id]=1078
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50' WHERE [Id]=1079
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7bb9080b-247e-4a3d-b459-619677e19263' WHERE [Id]=1080
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'92ce95e7-533d-4dc3-84c2-7e8725545ca1' WHERE [Id]=1081
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'104d522c-cab9-4916-be40-62e7c00de59c' WHERE [Id]=1082
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4c5b37fd-34d7-4148-9c84-1ab08be35e14' WHERE [Id]=1083
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'49bc61be-8c43-4854-9d06-b61ae3118a92' WHERE [Id]=1084
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'128f7feb-b9e3-468d-b66d-12a555b4f9c5' WHERE [Id]=1085
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4d7fa507-2170-425e-96f0-f42822ff6311' WHERE [Id]=1086
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'57302d72-6ffb-4f7c-a191-11e00c17b4ea' WHERE [Id]=1087
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'94329f27-c3bd-45ab-8e06-60e4a0199878' WHERE [Id]=1088
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'441c0141-35ff-4233-9945-e797233f4fa4' WHERE [Id]=1089
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32' WHERE [Id]=1090
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7efd7fbb-8ab1-4046-8267-753db514c23b' WHERE [Id]=1091
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'090a15ef-8766-435c-89a4-78aa54fda44d' WHERE [Id]=1092
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2' WHERE [Id]=1093
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5' WHERE [Id]=1094
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd' WHERE [Id]=1095
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3eb1157c-852d-43ea-a65f-7073e3897613' WHERE [Id]=1096
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bbcd8435-f677-4dac-ac8a-cffce96bcd11' WHERE [Id]=1097
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7' WHERE [Id]=1098
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bfeda042-0064-4e1f-867a-9cfcea27daaa' WHERE [Id]=1099
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'11bd72fb-de7a-4aca-ac33-d600df3edb7c' WHERE [Id]=1100
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9d395974-bec0-47e7-b32f-743afcc422de' WHERE [Id]=1101
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3' WHERE [Id]=1102
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cb1c069e-5af0-4e65-b77c-97e1fb15779c' WHERE [Id]=1103
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'928fb421-b72d-42d3-abf1-d310cdd8e790' WHERE [Id]=1104
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'055e9281-29db-478a-8d91-eda76013a1b2' WHERE [Id]=1105
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'195ff984-63bb-42ff-a9af-963e7661ec63' WHERE [Id]=1106
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'16cc4069-dc25-49d7-b272-dcfc28549301' WHERE [Id]=1107
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'97dc1c97-a947-4171-95be-59fa23ac90dc' WHERE [Id]=1108
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd473bcce-1332-47fb-95a0-1bf7b479b5ae' WHERE [Id]=1109
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147' WHERE [Id]=1110
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb' WHERE [Id]=1111
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'da8aecae-09e6-4f74-bfab-314673238ac1' WHERE [Id]=1112
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a1ca4007-d64e-4765-af61-42e753a61222' WHERE [Id]=1113
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695' WHERE [Id]=1114
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e' WHERE [Id]=1115
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd7c9f718-49fb-41e3-88a5-0197b286cd25' WHERE [Id]=1116
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f' WHERE [Id]=1117
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'12e2ecc5-d861-4680-9310-92422a3e2593' WHERE [Id]=1118
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7cd7b0b7-e644-417e-87b9-cc0281e90027' WHERE [Id]=1119
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd0c98e91-0f98-4c94-ae86-1ef2e128f975' WHERE [Id]=1120
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80' WHERE [Id]=1121
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'68fec29f-1c31-4860-8e21-47e345398528' WHERE [Id]=1122
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'99916b67-3c87-4342-8eb1-8640d0d9efd1' WHERE [Id]=1123
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1' WHERE [Id]=1124
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5fb337a9-70ec-46e2-a53e-9824ae05fd25' WHERE [Id]=1125
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1' WHERE [Id]=1126
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f2630114-6cf4-431d-99f4-a3c79dadd2af' WHERE [Id]=1127
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bb3c8465-744e-4995-b231-6714a5d25df9' WHERE [Id]=1128
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8c874f57-c8bf-4239-96b0-a220ae4937cc' WHERE [Id]=1129
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7' WHERE [Id]=1130
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3eb50693-0eb2-4050-b399-60591a44e130' WHERE [Id]=1131
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd6eff940-0b49-4710-8cf6-dae5e168744d' WHERE [Id]=1132
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f69539b5-5133-4052-83f1-789cf707be89' WHERE [Id]=1133
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd779a487-38cd-4942-b8ea-bb16dc14c07e' WHERE [Id]=1134
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6088d17b-f162-42a5-9818-f41ee5e0d16a' WHERE [Id]=1135
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2589ba88-616e-4aff-b14f-ed468eed0549' WHERE [Id]=1136
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef' WHERE [Id]=1137
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64' WHERE [Id]=1138
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29' WHERE [Id]=1139
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'042a7bfc-5033-4490-aa0a-89790832f895' WHERE [Id]=1140
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0233c973-c596-466d-8315-716d3f7d195c' WHERE [Id]=1141
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7244e0a8-83d4-41d0-92ae-8315df470382' WHERE [Id]=1142
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5' WHERE [Id]=1143
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e0598603-65e3-413a-b375-df073ea07f6d' WHERE [Id]=1144
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'04351640-3e1d-4810-a0f5-3147f12031a4' WHERE [Id]=1145
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ee347789-32ce-492c-a380-99eef0467543' WHERE [Id]=1146
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551' WHERE [Id]=1147
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'324079a9-3676-4d46-9704-b6a7a707101e' WHERE [Id]=1148
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fce10d8f-864c-4f58-b616-17a13b848f70' WHERE [Id]=1149
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f' WHERE [Id]=1150
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8' WHERE [Id]=1151
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'54aac154-2c0a-471c-adfd-0469a65737cf' WHERE [Id]=1152
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529' WHERE [Id]=1153
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789' WHERE [Id]=1154
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4b7535a4-dd2e-4071-9080-09a340e427f6' WHERE [Id]=1155
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'29132ca2-1891-40bd-96d3-7dcf4a2bb816' WHERE [Id]=1156
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c71757fa-088e-4b46-9359-455061d6b753' WHERE [Id]=1157
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'89e4f583-900b-43ec-ab63-34e838f35a81' WHERE [Id]=1158
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5afe23dd-03a4-4857-b96d-55b011b9af72' WHERE [Id]=1159
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e' WHERE [Id]=1160
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'34492beb-def2-4437-97a8-7afa138e17c1' WHERE [Id]=1161
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ee79c5f-71ac-40e4-90d2-913e2671666b' WHERE [Id]=1162
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f6b1ec86-245f-425d-a557-18c8fbc38f9f' WHERE [Id]=1163
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6' WHERE [Id]=1164
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6ff78f47-541e-4bab-a71c-f0350adb3543' WHERE [Id]=1165
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4d5682dc-047a-4c47-8de1-b57cdd620cb4' WHERE [Id]=1166
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7f0aac88-e922-4d37-923f-125c9cd8d5f2' WHERE [Id]=1167
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f' WHERE [Id]=1168
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c5a223f3-5d06-455a-8c50-65ad56f7059b' WHERE [Id]=1169
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c196270b-56d8-4eaa-8c52-69773420797a' WHERE [Id]=1170
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5' WHERE [Id]=1171
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a5adefe0-da79-4d63-b90a-7aead7d7ed32' WHERE [Id]=1172
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd779a487-38cd-4942-b8ea-bb16dc14c07e' WHERE [Id]=1173
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6088d17b-f162-42a5-9818-f41ee5e0d16a' WHERE [Id]=1174
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2589ba88-616e-4aff-b14f-ed468eed0549' WHERE [Id]=1175
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef' WHERE [Id]=1176
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64' WHERE [Id]=1177
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29' WHERE [Id]=1178
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'042a7bfc-5033-4490-aa0a-89790832f895' WHERE [Id]=1179
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0233c973-c596-466d-8315-716d3f7d195c' WHERE [Id]=1180
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7244e0a8-83d4-41d0-92ae-8315df470382' WHERE [Id]=1181
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5' WHERE [Id]=1182
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e0598603-65e3-413a-b375-df073ea07f6d' WHERE [Id]=1183
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'04351640-3e1d-4810-a0f5-3147f12031a4' WHERE [Id]=1184
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ee347789-32ce-492c-a380-99eef0467543' WHERE [Id]=1185
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551' WHERE [Id]=1186
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'324079a9-3676-4d46-9704-b6a7a707101e' WHERE [Id]=1187
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fce10d8f-864c-4f58-b616-17a13b848f70' WHERE [Id]=1188
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f' WHERE [Id]=1189
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8' WHERE [Id]=1190
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'54aac154-2c0a-471c-adfd-0469a65737cf' WHERE [Id]=1191
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529' WHERE [Id]=1192
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789' WHERE [Id]=1193
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4b7535a4-dd2e-4071-9080-09a340e427f6' WHERE [Id]=1194
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'29132ca2-1891-40bd-96d3-7dcf4a2bb816' WHERE [Id]=1195
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c71757fa-088e-4b46-9359-455061d6b753' WHERE [Id]=1196
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'89e4f583-900b-43ec-ab63-34e838f35a81' WHERE [Id]=1197
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5afe23dd-03a4-4857-b96d-55b011b9af72' WHERE [Id]=1198
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e' WHERE [Id]=1199
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'34492beb-def2-4437-97a8-7afa138e17c1' WHERE [Id]=1200
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ee79c5f-71ac-40e4-90d2-913e2671666b' WHERE [Id]=1201
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f6b1ec86-245f-425d-a557-18c8fbc38f9f' WHERE [Id]=1202
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6' WHERE [Id]=1203
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6ff78f47-541e-4bab-a71c-f0350adb3543' WHERE [Id]=1204
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4d5682dc-047a-4c47-8de1-b57cdd620cb4' WHERE [Id]=1205
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7f0aac88-e922-4d37-923f-125c9cd8d5f2' WHERE [Id]=1206
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f' WHERE [Id]=1207
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c5a223f3-5d06-455a-8c50-65ad56f7059b' WHERE [Id]=1208
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c196270b-56d8-4eaa-8c52-69773420797a' WHERE [Id]=1209
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5' WHERE [Id]=1210
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1c4dd748-6f03-430a-9d07-9b84e6a0902e' WHERE [Id]=1211
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'41adc77a-62e3-4a81-8a90-c565ea54fcce' WHERE [Id]=1212
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b2faf601-15d4-4282-bac4-7214dc4a23f9' WHERE [Id]=1213
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c64cde5d-5fe9-4545-830d-4f967fdef70a' WHERE [Id]=1214
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a97affbe-b4da-40f6-8055-f493cef4d9e5' WHERE [Id]=1215
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'288e8c5c-d015-4000-a5f8-2c2aac406922' WHERE [Id]=1216
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3' WHERE [Id]=1217
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b8d98f19-8e6b-4ad2-be55-09496026a374' WHERE [Id]=1218
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3761b8fd-6b23-4d86-81de-eb6de7891a5a' WHERE [Id]=1219
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8172fa8f-9ff5-475e-8d92-93fc731091eb' WHERE [Id]=1220
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1dc84c88-352f-488c-a927-58032f88a3f4' WHERE [Id]=1221
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c' WHERE [Id]=1222
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4' WHERE [Id]=1223
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a291e34e-5db0-4835-bad7-f88cc7d5d3aa' WHERE [Id]=1224
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1' WHERE [Id]=1225
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'605f60cb-09e8-41c6-9ba4-829679b00c84' WHERE [Id]=1226
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'80f4e203-94e3-400b-a7e7-6c08a7e132e9' WHERE [Id]=1227
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'520af6c2-5f31-488a-8970-0a390b7c9c34' WHERE [Id]=1228
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c' WHERE [Id]=1229
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2' WHERE [Id]=1230
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4095f424-c8be-4707-9e22-5cdcb62a3eba' WHERE [Id]=1231
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'18facde4-8d07-47db-b7be-ec800b01751b' WHERE [Id]=1232
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'44142e0e-7505-4961-9402-9a89fbb12ca7' WHERE [Id]=1233
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac' WHERE [Id]=1234
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02' WHERE [Id]=1235
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66' WHERE [Id]=1236
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e0490245-3f54-4720-b7c0-d36591f5ffed' WHERE [Id]=1237
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46' WHERE [Id]=1238
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6e178c65-ab35-4fce-aa3f-0e148987dab9' WHERE [Id]=1239
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'07d35985-0229-40c3-aaed-0fce364b33c1' WHERE [Id]=1240
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b8cfb588-5071-4035-9e0f-f7f14f2856e5' WHERE [Id]=1241
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9a7e6cfe-cd60-4ccd-8c14-af283303e936' WHERE [Id]=1242
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a3ea8642-aa44-45f4-9b53-060b114819e5' WHERE [Id]=1243
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7eac8530-e743-4028-9434-48f8ba9a09ef' WHERE [Id]=1244
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'49dcd5da-3149-42b7-9861-cab2aa575b63' WHERE [Id]=1245
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5f410902-9c3b-47db-b648-e154b97b09d6' WHERE [Id]=1246
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'baaaea28-f16e-43d5-a4b5-a816cbcb1262' WHERE [Id]=1247
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5281d288-b1b4-4e3e-9a00-5d5ab4437019' WHERE [Id]=1248
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0' WHERE [Id]=1249
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'45071ef7-21bd-483b-9b88-9711dcab397f' WHERE [Id]=1250
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1a33a525-bc0d-4974-a271-9779ba13b699' WHERE [Id]=1251
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908' WHERE [Id]=1252
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a37f20d2-67a0-49d2-81d5-5fefad6f7882' WHERE [Id]=1253
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc' WHERE [Id]=1254
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691' WHERE [Id]=1255
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5d22f62a-7da4-457f-874d-d8f0d11cb13f' WHERE [Id]=1256
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7de70953-05e2-4e44-85dd-5853dd4d2cb8' WHERE [Id]=1257
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1ba293b9-8bde-4a86-a6a9-efc5753af567' WHERE [Id]=1258
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'788872dc-bdd0-4558-b3c8-37af3fda8a42' WHERE [Id]=1259
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a682c7d3-6e4e-421b-815b-b55711c24a18' WHERE [Id]=1260
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'820ab0ac-6d35-4a42-a051-cd9f986d9c09' WHERE [Id]=1261
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'95adccad-66f9-47b3-a471-a6ee737b67a9' WHERE [Id]=1262
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'14096ba7-324e-4092-b933-a1b57c3ebb32' WHERE [Id]=1263
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0354f894-5ad4-4667-8c78-e85416e88313' WHERE [Id]=1264
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'af6ec62f-06d0-4188-8022-5e0a64dc6186' WHERE [Id]=1265
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'23d69255-7c68-459f-8f3e-b19bdf4e1498' WHERE [Id]=1266
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cb4545fb-c741-428f-87eb-afee3bf38e7a' WHERE [Id]=1267
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-19ab4a3c8466' WHERE [Id]=1268
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d' WHERE [Id]=1269
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0356eb50-3f15-4843-88ea-a130922a1ced' WHERE [Id]=1270
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'41328f04-b725-4435-837b-082e169aea31' WHERE [Id]=1271
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e38245ee-78ad-485c-8944-e3ea979ca9ce' WHERE [Id]=1272
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5f376240-3764-4733-a269-aad8b2f2b886' WHERE [Id]=1273
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f' WHERE [Id]=1274
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'138aaaf8-73c6-489d-91e3-55d5724cfbd2' WHERE [Id]=1275
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'03ce07cd-f814-499f-82b7-1f0404328b63' WHERE [Id]=1276
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd2ddd080-9cb4-41ce-866e-d3ed43d02936' WHERE [Id]=1277
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fd418060-07ec-4e8a-8c50-705c2c224506' WHERE [Id]=1278
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4902b1fc-d541-4288-85c4-5fec5a8840f6' WHERE [Id]=1279
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e987f370-b8d6-4dbd-9836-8b0dbeba8542' WHERE [Id]=1280
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8bc76bc4-072a-4fa1-a74f-ed681854dc63' WHERE [Id]=1281
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'21804bc7-8dbb-4558-ad03-83640ef3aa7b' WHERE [Id]=1282
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4' WHERE [Id]=1283
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e217064d-adff-4afc-af38-7dede030d53f' WHERE [Id]=1284
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'05d28c92-aa4b-459f-a306-ea45722c9e71' WHERE [Id]=1285
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5aae40c8-3c86-4f3c-8607-224f64ff8c12' WHERE [Id]=1286
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'da43d379-0954-42dd-9832-8890747a0929' WHERE [Id]=1287
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'076aa20b-5f04-4872-8093-40cef7ee2e1d' WHERE [Id]=1288
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4915c87a-4c0a-4635-beb4-6626d46415c2' WHERE [Id]=1289
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1' WHERE [Id]=1290
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21' WHERE [Id]=1291
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3cb5935b-0589-4634-9eeb-3cd416bf67e4' WHERE [Id]=1292
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c28598d5-f067-4f50-85fa-1f727fc56de8' WHERE [Id]=1293
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9ba6f025-144f-416a-9497-2f556c27e278' WHERE [Id]=1294
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279' WHERE [Id]=1295
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'de313b3e-a99d-409e-bc43-546d11247a8c' WHERE [Id]=1296
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5935921f-8dea-4799-baf8-2a1520e50204' WHERE [Id]=1297
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'654e8915-5ec5-4c80-aea1-376390d10dd1' WHERE [Id]=1298
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5883e2f9-d14e-4b50-9652-7894bcc15590' WHERE [Id]=1299
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'246c4f30-4c7b-460b-aebb-5d713455b050' WHERE [Id]=1300
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7' WHERE [Id]=1301
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a' WHERE [Id]=1302
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'71570f9c-c72a-4608-bf35-bb9adf44ef36' WHERE [Id]=1303
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'72595857-9760-4836-b5be-11c965e065f2' WHERE [Id]=1304
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94' WHERE [Id]=1305
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'20e787cc-6bb6-4115-8177-1712dffa737a' WHERE [Id]=1306
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a3494b24-c859-499c-8125-831b7f159320' WHERE [Id]=1307
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2' WHERE [Id]=1308
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8a10f075-1614-4019-8d64-28a9a5d21ce8' WHERE [Id]=1309
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd7786c13-ea07-4f22-9046-f2a04f1e03e2' WHERE [Id]=1310
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'83dc878d-7bba-4609-94c2-d01745a05fa3' WHERE [Id]=1311
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547' WHERE [Id]=1312
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257' WHERE [Id]=1313
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc' WHERE [Id]=1314
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6645f540-88c9-478a-96ec-bee746bc67e4' WHERE [Id]=1315
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1e14b590-ffeb-436f-bc88-20585a055247' WHERE [Id]=1316
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207' WHERE [Id]=1317
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c7035a5e-7d19-4041-93e6-11dec3d4ae79' WHERE [Id]=1318
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9c490860-14ee-44e1-8f5f-080587e317ce' WHERE [Id]=1319
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae' WHERE [Id]=1320
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1cb5efa9-81fb-4ed7-a330-a14322057cf3' WHERE [Id]=1321
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'44842db2-256f-4f1b-a668-aedb9e561a16' WHERE [Id]=1322
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'75c04415-a531-445e-a07d-289454bc7a18' WHERE [Id]=1323
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e' WHERE [Id]=1324
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5d007fd4-976f-4f44-b580-50a2afe0815f' WHERE [Id]=1325
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a35adf1d-f4f6-494f-975a-0492fffa70db' WHERE [Id]=1326
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c6e0724d-fc34-4235-b0fd-f5098312de8d' WHERE [Id]=1327
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a0c35796-bc6a-452c-a8f2-865ae862cb82' WHERE [Id]=1328
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eee4960b-0beb-4758-a5df-9488b9e90a1f' WHERE [Id]=1329
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ac4698dc-57d6-4952-a284-e7120e4d7eba' WHERE [Id]=1330
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3' WHERE [Id]=1331
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee' WHERE [Id]=1332
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6f08acda-f8d6-496a-920e-e440214aac79' WHERE [Id]=1333
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'47725902-0b42-4a59-b6c5-dd30fd303c2a' WHERE [Id]=1334
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f72cabe4-9301-4aa0-b7db-3a926095f2b6' WHERE [Id]=1335
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8f7756c1-64d5-4328-accb-1f683d92ccf0' WHERE [Id]=1336
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'47ffe987-86af-4fe5-9d13-9ace5ac76e87' WHERE [Id]=1337
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'063b1ba2-64c0-440f-bb1e-7068355531fa' WHERE [Id]=1338
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc' WHERE [Id]=1339
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'45e921f2-079a-457c-aeea-6e8a96dd153d' WHERE [Id]=1340
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e4765a60-289d-4a38-bcff-fffb5b0e2c17' WHERE [Id]=1341
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'881ebe14-f1e1-4b80-96a6-5bde2824eca3' WHERE [Id]=1342
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'56cc7835-fb1d-4107-8d13-5d28ca0dd104' WHERE [Id]=1343
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c' WHERE [Id]=1344
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'06048d73-4dd8-42e1-b095-806c636ff9f0' WHERE [Id]=1345
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e' WHERE [Id]=1346
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5fa827e8-96a8-4020-9153-8755f3c3de93' WHERE [Id]=1347
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bffe0f32-acf5-4f54-94be-fe54d946ea0a' WHERE [Id]=1348
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bb6ab79b-3279-487e-a321-d3deb8cba545' WHERE [Id]=1349
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1' WHERE [Id]=1350
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4e1a462a-70fd-4454-96f8-fe543bce337a' WHERE [Id]=1351
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f' WHERE [Id]=1352
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'da6eb397-3885-493a-8a79-a63a8257b246' WHERE [Id]=1353
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c80e6713-32ce-4c9d-ad80-704b460d0d55' WHERE [Id]=1354
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2719c551-cb62-45f0-8091-c595fccf11aa' WHERE [Id]=1355
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ed3a4a01-b363-4d81-9dd6-b736a3431293' WHERE [Id]=1356
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ab8d023-1fed-4230-98f7-e8ee50028f30' WHERE [Id]=1357
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4f788f04-93df-47f5-a308-cf110df2f2f0' WHERE [Id]=1358
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c571afdf-1f39-4715-9f4e-4f59043571b7' WHERE [Id]=1359
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f8309664-1867-43b7-adb8-7bd34ba687d6' WHERE [Id]=1360
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1d96dfb4-c37d-4662-9527-d71b4834dd98' WHERE [Id]=1361
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cb29c5d6-6493-402c-891b-21d6cffda4a0' WHERE [Id]=1362
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f' WHERE [Id]=1363
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1' WHERE [Id]=1364
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c' WHERE [Id]=1365
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e59dbc98-5393-4fc4-8996-c05fe4852558' WHERE [Id]=1366
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6755075e-2096-45d5-9b09-48c50d51660f' WHERE [Id]=1367
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9454ba64-87ca-4ffd-b497-bb8e5eea8639' WHERE [Id]=1368
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8b5e351f-1067-4eeb-ac41-9151079de165' WHERE [Id]=1369
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f259ce28-7dad-46f1-adf2-24e6436d79fa' WHERE [Id]=1370
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1480a708-a100-4f72-9792-15232a0895c3' WHERE [Id]=1371
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f' WHERE [Id]=1372
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9fcc79e1-fe21-4415-ad86-c35fcd318638' WHERE [Id]=1373
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a0fa8cb4-a958-4237-87c0-194c59f15a0c' WHERE [Id]=1374
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3' WHERE [Id]=1375
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b5662ca1-736e-421c-b228-8b6dd972fdec' WHERE [Id]=1376
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'be1a5270-9d9f-409d-988e-e573128abf8a' WHERE [Id]=1377
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de' WHERE [Id]=1378
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'996c01cf-3f6a-4c7c-a5a0-fa862548e351' WHERE [Id]=1379
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0927c339-ed6b-482f-ab49-15e3ef8e57a9' WHERE [Id]=1380
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd131e823-79fb-48ac-827f-bb105e830abe' WHERE [Id]=1381
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed' WHERE [Id]=1382
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3' WHERE [Id]=1383
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e' WHERE [Id]=1384
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4256493c-98b6-4a0e-9ba8-89ce04de832d' WHERE [Id]=1385
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e29d1e20-fb42-47a3-8315-0af62753b0ea' WHERE [Id]=1386
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'abfa596e-2286-4024-90dc-b8cb507a96f2' WHERE [Id]=1387
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b31317ba-1511-4be8-8778-e741d2803d16' WHERE [Id]=1388
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0' WHERE [Id]=1389
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b' WHERE [Id]=1390
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'44606826-3f05-44b7-a790-85527f1e8ac8' WHERE [Id]=1391
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cdd7db9d-6929-4539-ae3f-2363bf449f73' WHERE [Id]=1392
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92' WHERE [Id]=1393
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8' WHERE [Id]=1394
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'63a7471e-ccea-4422-bc2b-c1acbf9066b3' WHERE [Id]=1395
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e' WHERE [Id]=1396
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'30fd5982-45d0-485c-a969-c672f21b7358' WHERE [Id]=1397
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e' WHERE [Id]=1398
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dbf5545e-ab61-438b-8a50-606995d1f30b' WHERE [Id]=1399
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3' WHERE [Id]=1400
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'edb77114-1960-4772-88a3-e32307dcf0a9' WHERE [Id]=1401
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2806f1cd-9742-4811-aff4-1ba3268ca6e2' WHERE [Id]=1402
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd006adea-6c46-421a-96d6-2c90fc2b5679' WHERE [Id]=1403
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'693dfee7-b819-450c-941c-2d2951c1ae6c' WHERE [Id]=1404
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'418d053d-d730-4577-8e25-77584384703e' WHERE [Id]=1405
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5084a806-f1f9-4753-a856-5a82c1f8a54a' WHERE [Id]=1406
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd6b0b228-646a-47c9-a361-8efd57b2bd06' WHERE [Id]=1407
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe' WHERE [Id]=1408
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad' WHERE [Id]=1409
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e058ee51-e99c-4d5b-8060-df2944d1b9d4' WHERE [Id]=1410
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd8f89701-7006-48e9-b2ec-0679551a0418' WHERE [Id]=1411
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'93b2b36c-fac6-48af-822c-9e1b69c0c889' WHERE [Id]=1412
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cd30e343-60c3-4f7d-a566-72fe0718a90b' WHERE [Id]=1413
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3bf5cebc-d59d-4938-895d-3ec5bf19361c' WHERE [Id]=1414
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'24fb6bff-bf88-4367-a5be-7a9180304283' WHERE [Id]=1415
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a94a17a2-60ed-4bde-a307-22787ea95b96' WHERE [Id]=1416
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5bcce21a-e711-4fb9-abf6-a199cf8b1774' WHERE [Id]=1417
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab' WHERE [Id]=1418
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f683600c-bd77-495b-8baf-a76fd1df0215' WHERE [Id]=1419
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf' WHERE [Id]=1420
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'39887b12-6eee-4997-b509-b0bd643a727e' WHERE [Id]=1421
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a5993180-1136-4ee0-91d0-6cb0ed1113b4' WHERE [Id]=1422
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d' WHERE [Id]=1423
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1' WHERE [Id]=1424
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'20de167f-fde4-4fa3-a154-edb87e97bf73' WHERE [Id]=1425
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2' WHERE [Id]=1426
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'195f5149-f23f-468b-8cf6-c85390bb28f2' WHERE [Id]=1427
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'16353f67-23c3-4cf9-9a88-16eaa18f10d6' WHERE [Id]=1428
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341' WHERE [Id]=1429
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'66b8d9f8-6043-4d79-b960-9265da657a3b' WHERE [Id]=1430
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15' WHERE [Id]=1431
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7541f25b-34db-4ad5-a8ae-09d1dd558706' WHERE [Id]=1432
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6' WHERE [Id]=1433
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe' WHERE [Id]=1434
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ca1e2ec0-efe1-4605-afe5-fda2721325b4' WHERE [Id]=1435
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4956ffa4-3f8b-4993-bda1-5860eab524aa' WHERE [Id]=1436
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5b42320e-6062-4383-b8f6-e3100ab201bd' WHERE [Id]=1437
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'22286879-b923-4b86-b2e3-8e9d973c9f6f' WHERE [Id]=1438
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02' WHERE [Id]=1439
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f0ebe1d6-1a11-41eb-8e26-a8641f180609' WHERE [Id]=1440
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7d64bd68-b90c-413c-a3e6-981183d49bdc' WHERE [Id]=1441
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9019037e-b18e-4b83-98dd-d9590a10670c' WHERE [Id]=1442
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'94381ea1-15ea-4559-a9c7-cf6ddb53ec40' WHERE [Id]=1443
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7cdb9b56-0bfb-4c75-b87d-a777709c203f' WHERE [Id]=1444
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d' WHERE [Id]=1445
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4' WHERE [Id]=1446
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'71faed82-43c3-41ce-a5a4-e77b6649d459' WHERE [Id]=1447
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bfc987ff-e9e0-4786-8bcf-557424b597b2' WHERE [Id]=1448
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bd804d71-4b02-4995-9cfe-d1ff82793a05' WHERE [Id]=1449
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cb97cb0d-d670-4d87-95d4-f85457d7170a' WHERE [Id]=1450
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'86971979-71d1-47a5-9006-e4e4c74c6a65' WHERE [Id]=1451
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3' WHERE [Id]=1452
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4513ed01-2341-4581-b9b9-db7e81fe50c8' WHERE [Id]=1453
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c99db12f-b24e-4957-be1d-dd0193a23a3a' WHERE [Id]=1454
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5e347146-ca72-41be-afdd-2d18472ff62f' WHERE [Id]=1455
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f' WHERE [Id]=1456
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'986a1121-10ba-40d0-8629-79768f5b4e89' WHERE [Id]=1457
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a' WHERE [Id]=1458
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1' WHERE [Id]=1459
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fb782972-bcd1-4f36-ba23-577b5e83363d' WHERE [Id]=1460
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'72ae0c99-4cb9-4d56-809a-041e55579963' WHERE [Id]=1461
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6cb718c8-8069-4549-95e2-fec340984b81' WHERE [Id]=1462
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'aab63718-55f6-4c84-9d96-40b74f4ae92b' WHERE [Id]=1463
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'129bda36-163a-4c8f-8e65-2a3fdf2e862d' WHERE [Id]=1464
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'78154c09-d1eb-4ae7-b395-bc67e79adf6e' WHERE [Id]=1465
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8f9f3349-5c0d-4569-b561-0b67dd1dff01' WHERE [Id]=1466
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cc619a78-e398-4032-9ccd-000cb48a4bf2' WHERE [Id]=1467
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'55809876-8109-4bd2-a655-ab0996fb54c7' WHERE [Id]=1468
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2676ade9-b20a-485d-be49-f5f839e90b7b' WHERE [Id]=1469
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'17f7318a-98ec-4124-9b94-3d0413720163' WHERE [Id]=1470
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7112ab0c-75f0-4237-8b59-1e6a1ea54a97' WHERE [Id]=1471
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'db45eee0-9d96-4482-ba46-a082b2090cd5' WHERE [Id]=1472
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6904af6a-266d-4422-9e50-bac6b512cb6f' WHERE [Id]=1473
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b5216afc-d33d-46f3-b7db-a4170912d7c6' WHERE [Id]=1474
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ab0d83dd-e6be-45a5-9f20-014500cbc3f8' WHERE [Id]=1475
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3b3af5f0-6e91-4cde-a99f-427a96b8db60' WHERE [Id]=1476
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7' WHERE [Id]=1477
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'01bdc9eb-8f37-4b28-96f5-e661259e9291' WHERE [Id]=1478
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e' WHERE [Id]=1479
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c62e61c1-16ae-463c-8de8-fcc0516df031' WHERE [Id]=1480
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'504b7c8a-379b-45c7-9b44-6d825c30478b' WHERE [Id]=1481
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ca492c4c-42b2-4493-9f5a-b58b96cac09f' WHERE [Id]=1482
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6' WHERE [Id]=1483
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c1d44620-a496-4de0-895f-56066017a16f' WHERE [Id]=1484
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'bf56f348-0a33-4ac2-ae63-5822a62a2123' WHERE [Id]=1485
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6' WHERE [Id]=1486
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a6192524-3d69-4a52-a92c-c564fc1baec5' WHERE [Id]=1487
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'560c0361-0321-4690-a9b9-1391cb9d6451' WHERE [Id]=1488
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8403df7d-3348-400b-9946-f9f86614a4dc' WHERE [Id]=1489
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c' WHERE [Id]=1490
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'71a1d18f-85e1-4c77-ac51-fd731dcd925f' WHERE [Id]=1491
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4b1d6f27-d878-4d1c-9b9e-6d7291251198' WHERE [Id]=1492
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'422f1608-e641-4ec1-9163-636bb3c6962b' WHERE [Id]=1493
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c1df5586-1d4d-477a-85bf-32a344c726ee' WHERE [Id]=1494
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf' WHERE [Id]=1495
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2' WHERE [Id]=1496
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8724f683-d67a-46a8-8fd2-86f3f9586735' WHERE [Id]=1497
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'06eb3687-d016-4597-9538-c1eaed785b50' WHERE [Id]=1498
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f' WHERE [Id]=1499
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e5d585cd-594e-4546-baaf-885c9dca91b0' WHERE [Id]=1500
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0acce7c4-1da6-4276-a199-a4db6270bfd7' WHERE [Id]=1501
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fb852cd7-b559-4a45-815a-46b71f80d49b' WHERE [Id]=1502
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ee2f083b-d33e-4c47-8f9d-9edc32732c28' WHERE [Id]=1503
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4bdedc60-9873-481d-aeab-53422bfe8d00' WHERE [Id]=1504
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'04564a71-cc75-4d65-934f-03d6598429df' WHERE [Id]=1505
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0f288531-ba96-438f-b70d-5775de191ee2' WHERE [Id]=1506
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b19af782-0c9f-40b1-8228-6f6a603a0ca7' WHERE [Id]=1507
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e456ef1c-a28d-42a7-8324-ab5448f9139b' WHERE [Id]=1508
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'78d5d270-ecd3-4013-a306-d881b94b0bdf' WHERE [Id]=1509
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205' WHERE [Id]=1510
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fc8a73be-4987-4cd7-b980-39e5b658f2aa' WHERE [Id]=1511
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1db4fb60-19a8-410d-9b19-f8448d480dc7' WHERE [Id]=1512
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702' WHERE [Id]=1513
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2024b4f0-2771-4431-a8af-d7264b28d962' WHERE [Id]=1514
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ecf86452-0e62-445c-b370-0e7ca708212b' WHERE [Id]=1515
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f' WHERE [Id]=1516
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e836ff6b-6648-40f2-a2dc-1c160027ef4d' WHERE [Id]=1517
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e' WHERE [Id]=1518
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba' WHERE [Id]=1519
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ecd91131-4e0f-4db6-9bcf-85c887427136' WHERE [Id]=1520
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'25803ebb-f8d0-4058-ae1d-29e742224932' WHERE [Id]=1521
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e7481cae-21d5-4239-ba7a-60ead03573c3' WHERE [Id]=1522
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c8ae1043-e193-410f-a0ce-51a673b812e0' WHERE [Id]=1523
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2' WHERE [Id]=1524
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e' WHERE [Id]=1525
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'18fbb831-3560-4576-a594-6f16ddd1df05' WHERE [Id]=1526
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6d1006f2-51ab-4aba-abc6-b597f28b1603' WHERE [Id]=1527
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4ad09cf5-9247-4970-9616-6e36bb2a40a5' WHERE [Id]=1528
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58' WHERE [Id]=1529
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c66c33e2-d3b8-44f7-acfb-4d56498f3627' WHERE [Id]=1530
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2' WHERE [Id]=1531
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'46c3a05b-eb2d-4b5d-8602-797059bc2e37' WHERE [Id]=1532
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'81dfe010-14a0-48a7-aa0d-48023d967286' WHERE [Id]=1533
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'88888a3e-9ecb-43d6-9fce-099336b2a534' WHERE [Id]=1534
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'860db2d3-2007-4fe3-a622-96efaea97956' WHERE [Id]=1535
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b7e30a6e-02bb-4b23-8762-a0121459bf94' WHERE [Id]=1536
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30' WHERE [Id]=1537
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5' WHERE [Id]=1538
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2619edd7-d221-43d7-832b-c1c761df8ac8' WHERE [Id]=1539
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b0503a12-05ee-4c0b-aeff-a90cbd09962c' WHERE [Id]=1540
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c2413e5-e633-4d8f-94f8-56574ed1cc05' WHERE [Id]=1541
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182' WHERE [Id]=1542
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a4b6168d-3589-4dfa-8a92-523ac1d03d99' WHERE [Id]=1543
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'896b337d-445b-453a-b6ce-5a64bf11b65d' WHERE [Id]=1544
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f' WHERE [Id]=1545
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cc9e11cb-ce75-4b13-9453-87de0759b42a' WHERE [Id]=1546
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2373a969-c468-4c48-b26b-371641253486' WHERE [Id]=1547
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3' WHERE [Id]=1548
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'02268ec7-c879-47b8-b174-de3c359eff7a' WHERE [Id]=1549
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'df22e2e1-73df-459b-826b-630bf62e8394' WHERE [Id]=1550
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ae52d61-2e8f-40c1-9b16-55a1b016a286' WHERE [Id]=1551
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'85e9bab0-c315-45b8-8922-51faeb4a7a9c' WHERE [Id]=1552
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dd748a92-303d-45fa-82c5-cb6697329f29' WHERE [Id]=1553
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15' WHERE [Id]=1554
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'30ed6b09-268f-4e07-9bdf-d003d7d32502' WHERE [Id]=1555
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'46e960cd-92c8-4657-b8f1-e066ed8005ff' WHERE [Id]=1556
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e21a8021-5299-4845-b534-fd1f3c46ab69' WHERE [Id]=1557
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'646a1da2-f25a-4782-8430-a7c7e8762da3' WHERE [Id]=1558
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'aeb6253e-2532-4873-b8df-9ac559908658' WHERE [Id]=1559
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2' WHERE [Id]=1560
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9' WHERE [Id]=1561
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'66754c61-6ecd-44cf-9ae4-543635e0d460' WHERE [Id]=1562
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82' WHERE [Id]=1563
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68' WHERE [Id]=1564
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9e222535-8111-4ded-b5c0-2de91ae52e92' WHERE [Id]=1565
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dec4c280-cc66-4fbf-8317-4a3d70a234fa' WHERE [Id]=1566
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c' WHERE [Id]=1567
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3e160c8e-b2f6-45f1-8ab2-8f4c036573e1' WHERE [Id]=1568
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'273b5a2d-455f-47f9-8bc9-913953c3a161' WHERE [Id]=1569
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'afc3feb8-7935-4901-817b-9ae97bfd2744' WHERE [Id]=1570
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ceeacfe2-8f90-47e9-845f-63a34e3de4bc' WHERE [Id]=1571
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0' WHERE [Id]=1572
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a69984ec-f11f-46aa-9b32-9d22d815fd4c' WHERE [Id]=1573
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3683ddae-8093-4d4e-ab44-ce435c7a4eef' WHERE [Id]=1574
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'31e012f0-2bdf-4a15-a3c5-6daa98927d21' WHERE [Id]=1575
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79' WHERE [Id]=1576
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b4f8506d-ae3f-452e-807f-bf1be20f362d' WHERE [Id]=1577
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'01df57f4-8853-47c1-812b-6837444c4971' WHERE [Id]=1578
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cce5f23e-1760-4144-9637-2522ea80d1d2' WHERE [Id]=1579
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b43a16a1-05d0-4bc6-b62a-3149be561b7e' WHERE [Id]=1580
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'179b7471-6f14-44c3-8b65-9fcaacb1372a' WHERE [Id]=1581
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'97050a68-9699-4bda-bb74-bac15ac8ceef' WHERE [Id]=1582
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a2aa875a-6bcd-46cd-9845-aa51274725d8' WHERE [Id]=1583
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3a396a34-e1f0-4c47-93db-394bc5f4c557' WHERE [Id]=1584
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7c0f7cd0-65b7-4c4a-a6b7-95fe64d35522' WHERE [Id]=1585
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5ac44e48-a3ec-4540-881b-4a664c551900' WHERE [Id]=1586
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c77023f5-3d29-4643-90b1-ede9b9a56ca4' WHERE [Id]=1587
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'101453c8-09ce-417c-8951-6a91dca67f26' WHERE [Id]=1588
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'719f8bd7-f502-4e43-b184-88cc17302d07' WHERE [Id]=1589
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0a677b95-72a2-4192-8c44-a3a4127a32bc' WHERE [Id]=1590
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'df89bf72-79fe-434b-8245-bd50b2aee9f5' WHERE [Id]=1591
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'20813979-2589-4e31-8357-96b066fd0c56' WHERE [Id]=1592
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'356798c9-66ab-43aa-8a18-31f9927dfc87' WHERE [Id]=1593
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'31b38c08-2611-4142-a024-87fdcc8d3eea' WHERE [Id]=1594
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fdd09e03-8cfe-4c43-85ae-4b96e406b075' WHERE [Id]=1595
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe' WHERE [Id]=1596
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'796c9178-0921-4ed9-84e3-bacd804cc649' WHERE [Id]=1597
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'050cbe2c-f0af-4b59-ac45-557a0e8594cf' WHERE [Id]=1598
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c525df86-f303-4e6d-9344-8f1424aad695' WHERE [Id]=1599
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1f1cc7de-14bd-4929-ae91-f1fe6573a428' WHERE [Id]=1600
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7fd50f16-1e45-491a-b1c7-daa5f72e3366' WHERE [Id]=1601
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd782bfa7-8bbc-452f-a908-e8c84710524e' WHERE [Id]=1602
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9e3275da-93b7-465f-baa8-732e630e5038' WHERE [Id]=1603
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b' WHERE [Id]=1604
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'912d2d30-2f02-4620-9dc0-31c06f3d0c16' WHERE [Id]=1605
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eb46cbd9-8754-422b-84e0-b9347db7cce5' WHERE [Id]=1606
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7b24e760-fa91-4bc3-acf2-cd2140f8b938' WHERE [Id]=1607
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4499f362-059e-4a4a-8e99-f1bef76afffc' WHERE [Id]=1608
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'70736180-c459-451b-aa23-3e119ba56137' WHERE [Id]=1609
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8dc53087-5dcb-4027-b092-8e257280e75a' WHERE [Id]=1610
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ae99aa0c-146f-4b4f-81d2-a95fb077a367' WHERE [Id]=1611
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7b1e7ccb-fd1e-4271-b7b3-5f8d5efb5cec' WHERE [Id]=1612
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a6204969-3848-412d-80e1-c596eb740f36' WHERE [Id]=1613
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'249ba7d6-26bc-43df-b75d-b568252cc2c9' WHERE [Id]=1614
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a17f6c5f-71a4-4086-af06-43926cf30080' WHERE [Id]=1615
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'336fdb14-6186-41c2-b2ff-98c99ea25c5f' WHERE [Id]=1616
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'05d45e13-6184-4085-b9b2-86015af49e11' WHERE [Id]=1617
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc' WHERE [Id]=1618
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'712d6299-495e-45ce-9010-20e4ad36834a' WHERE [Id]=1619
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'11ab7a69-a705-4f46-8821-9bb3b7815a98' WHERE [Id]=1620
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'831becf0-0744-4fe4-b79c-dec135cee846' WHERE [Id]=1621
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a6c247bc-d584-43a3-b995-f303e3b13c77' WHERE [Id]=1622
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'be512744-b639-4f8a-ab84-e7f568ff5289' WHERE [Id]=1623
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f2715a17-ba0e-437b-a939-94382f648337' WHERE [Id]=1624
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de' WHERE [Id]=1625
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e' WHERE [Id]=1626
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582' WHERE [Id]=1627
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e0488c12-4dee-4420-98b1-25d91aa840f7' WHERE [Id]=1628
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'72fff920-bbac-437e-866b-05fc4a6b5ea0' WHERE [Id]=1629
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1cfd0212-4eef-4656-a703-f40f737708ab' WHERE [Id]=1630
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1c969e3f-5fb9-42c1-8a39-8c84122aded1' WHERE [Id]=1631
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b9875a52-3204-4d50-8c95-08b7018586ea' WHERE [Id]=1632
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc' WHERE [Id]=1633
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b22348a4-a36e-4d01-b2e7-578697d4a8e9' WHERE [Id]=1634
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'65e27bce-38e0-4497-b95a-39024db06652' WHERE [Id]=1635
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9ff9f2d1-8af0-4fac-a111-9acf84207453' WHERE [Id]=1636
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'42da2ebe-fb35-439a-92c5-f404c3e0a12d' WHERE [Id]=1637
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'93481abc-8bc8-4b26-b02b-d2eb935903d6' WHERE [Id]=1638
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'207733d4-37a4-4b04-a973-27fcde23cc61' WHERE [Id]=1639
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'45b5e4ac-25c1-42a7-963d-2491b4d13ece' WHERE [Id]=1640
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996' WHERE [Id]=1641
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1d300971-3288-4683-808f-a24867cf8ff1' WHERE [Id]=1642
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'65f51079-a03f-4d49-879a-d14fdfd94f7f' WHERE [Id]=1643
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'68e42e81-caa8-4bae-a742-847aecef1d34' WHERE [Id]=1644
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f' WHERE [Id]=1645
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'26f81117-51f9-4638-aec4-801a6a296945' WHERE [Id]=1646
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'114535ed-507b-48dd-8a35-bbdc252a82a8' WHERE [Id]=1647
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a36dadb4-a0e3-4a10-a52d-24273c131af1' WHERE [Id]=1648
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'273e5d24-26ed-4c78-9de1-6ac406b3529a' WHERE [Id]=1649
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310' WHERE [Id]=1650
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7' WHERE [Id]=1651
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0156ec76-73ef-44c2-aa58-fc8e380e9683' WHERE [Id]=1652
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'de36105a-564c-478d-ad54-a9c6e64db410' WHERE [Id]=1653
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'df7e2b4d-01f0-44d6-a7d6-8337225897c3' WHERE [Id]=1654
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4' WHERE [Id]=1655
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4046572a-ab91-4548-bcfc-7747eb7df41c' WHERE [Id]=1656
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5' WHERE [Id]=1657
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3' WHERE [Id]=1658
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e31fdfff-824c-4a7d-a640-8f43a6c4f824' WHERE [Id]=1659
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6c104837-0a04-43d6-b200-177b98588522' WHERE [Id]=1660
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cc715473-7abd-4b07-8458-a07daaca6e15' WHERE [Id]=1661
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a66523be-f0b3-4420-aea5-ecba26c130be' WHERE [Id]=1662
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dc736454-3856-4968-9662-4c1800a85f4a' WHERE [Id]=1663
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'26106a36-d4fa-4b25-8437-9355039afbd2' WHERE [Id]=1664
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219' WHERE [Id]=1665
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6' WHERE [Id]=1666
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'17100aba-2fde-4a45-9e1c-4cf93f3b2248' WHERE [Id]=1667
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3' WHERE [Id]=1668
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'26236d58-2ef6-493d-a936-3bb2a1efc1a3' WHERE [Id]=1669
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fb07746a-f1b1-43f6-823f-643fb9100df1' WHERE [Id]=1670
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'aa016aeb-2fda-4e56-83ce-6286ab21c128' WHERE [Id]=1671
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b' WHERE [Id]=1672
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a8158cb8-7a34-4267-9e33-1b138b6fea2f' WHERE [Id]=1673
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'946982d0-e0c4-4c58-8959-c1731f793163' WHERE [Id]=1674
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'722fdfcc-02ee-4680-b684-fcc7230714cc' WHERE [Id]=1675
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3' WHERE [Id]=1676
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'30d722ce-e903-4fbb-a047-b3e6f50a5d60' WHERE [Id]=1677
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ebe5d62c-129d-42a3-8097-809cd113944f' WHERE [Id]=1678
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'86de038f-e73a-4cf8-9d0c-3c488130396e' WHERE [Id]=1679
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fdc96a50-12cd-46db-9007-16ae4d4342e5' WHERE [Id]=1680
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f' WHERE [Id]=1681
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2' WHERE [Id]=1682
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f' WHERE [Id]=1683
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd482c274-39ec-4dad-a850-fc692fb38c62' WHERE [Id]=1684
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73' WHERE [Id]=1685
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'234ca81d-87b9-43a3-a215-2908500fb7c2' WHERE [Id]=1686
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a' WHERE [Id]=1687
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'21c8a894-f7d6-4747-bbc4-c2b21e733568' WHERE [Id]=1688
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'51897e01-9b8a-473a-b20b-4d1b5f572d87' WHERE [Id]=1689
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'14435987-a010-4981-aa0f-80d1e4498d4f' WHERE [Id]=1690
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3e152b0f-dc4c-4416-8352-8569e8343fe9' WHERE [Id]=1691
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6a74f264-0c50-4201-8772-f71229bbf01c' WHERE [Id]=1692
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'db71cf78-8417-4fc0-aabf-4b955796d9a2' WHERE [Id]=1693
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'eb8e51f1-2239-43c2-b606-3547a0f96ee7' WHERE [Id]=1694
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'3a77dfc3-7392-411c-aa42-078753a10e7b' WHERE [Id]=1695
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f41f13d6-190d-4f8b-9432-f6423811314a' WHERE [Id]=1696
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'49c9ef74-ab94-4204-8b9a-e935540468cf' WHERE [Id]=1697
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd617ff97-654e-4788-add5-c28e90abe680' WHERE [Id]=1698
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'48ae5050-184c-44e4-861e-d256272b207d' WHERE [Id]=1699
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'aee4bc17-1442-48b2-a95b-3ec265c58cd8' WHERE [Id]=1700
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f' WHERE [Id]=1701
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5069d2f1-0dbe-4d29-ae69-130d560901c2' WHERE [Id]=1702
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'faff4451-6454-4dff-b4a9-6168f1edf526' WHERE [Id]=1703
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1fa27253-d770-4f50-8cc8-75122eb1e68c' WHERE [Id]=1704
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5f504070-4d93-4e8f-8cea-42bda43ef0ac' WHERE [Id]=1705
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'376cbf30-280f-4ae0-af13-129d1cd02aca' WHERE [Id]=1706
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e23511de-8c7d-4c4b-8723-f18c9e3b9240' WHERE [Id]=1707
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'966e921f-2d1b-4475-a540-87edecfb27ab' WHERE [Id]=1708
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7d159002-e21e-4829-87de-346273d5eccb' WHERE [Id]=1709
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a761f852-3928-467b-9867-7dcf3f55d8a7' WHERE [Id]=1710
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7e97bd9c-d247-4d24-97aa-cafc8535848d' WHERE [Id]=1711
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6d3a46a1-2588-4816-be63-5d2518dc6701' WHERE [Id]=1712
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1' WHERE [Id]=1713
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'658015c0-d4d6-4aa6-b199-4bfa36c25654' WHERE [Id]=1714
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'51c504b7-3fd2-4111-9652-05b295f0732f' WHERE [Id]=1715
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'299729a5-d7ed-4f30-a13c-1960d7374507' WHERE [Id]=1716
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705' WHERE [Id]=1717
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'92c5486b-f76f-4253-be9a-f679b5aaf461' WHERE [Id]=1718
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1cdd12ee-254f-4cae-9299-129c1c9651d8' WHERE [Id]=1719
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0b681d01-ff60-45e3-877b-f3b6e2e06553' WHERE [Id]=1720
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a4eb7107-2ee3-421e-9271-816939a454d0' WHERE [Id]=1721
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07' WHERE [Id]=1722
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ad8575c0-72ca-40cc-bf54-135ac2026501' WHERE [Id]=1723
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'48c4b04c-59db-43d5-baba-9b750f1d3951' WHERE [Id]=1724
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'430759b9-c9c2-4d57-8812-94b07d8271c5' WHERE [Id]=1725
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b' WHERE [Id]=1726
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131' WHERE [Id]=1727
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e96efc5b-0b85-42c0-abf3-373ad2869879' WHERE [Id]=1728
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'edb67248-51cb-46d3-99c7-1c6c50ff82e8' WHERE [Id]=1729
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e17f7b49-5da8-4c2d-84b7-7ad8314435be' WHERE [Id]=1730
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'905f69a3-b01f-4171-b4e7-6f52ef9398e2' WHERE [Id]=1731
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'419838f7-f353-4ee5-9e90-1acbc0e94db9' WHERE [Id]=1732
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c4827784-0363-4114-9d98-2c7aad82fa02' WHERE [Id]=1733
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'da31dab8-5111-4a29-8fea-a8f893479229' WHERE [Id]=1734
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0233afff-931a-48cc-86d9-c8a83b415efa' WHERE [Id]=1735
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b6875160-0302-4d15-9bd9-3431e21aeb24' WHERE [Id]=1736
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3' WHERE [Id]=1737
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'681c3f06-93ec-4d82-928a-21425d6dbb91' WHERE [Id]=1738
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0b2784fb-2158-461f-a83c-08b221cea5c7' WHERE [Id]=1739
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7' WHERE [Id]=1740
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'71b83b32-6e10-4bc8-978d-76b9ad44d135' WHERE [Id]=1741
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4b651a45-bf4c-48c8-97b7-333bb580b76e' WHERE [Id]=1742
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8016ffaf-96be-4810-8191-cd3fdbeb5399' WHERE [Id]=1743
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2e00c99b-cd88-41aa-8751-68402a23b014' WHERE [Id]=1744
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c93f50bd-2a63-4387-bf62-21098294bcc3' WHERE [Id]=1745
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b0a20ad6-7b71-4d09-a25e-3e843f847335' WHERE [Id]=1746
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4653a3cf-5480-49a3-af52-1ede7d7a5432' WHERE [Id]=1747
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9ebcf470-1da4-4448-b8f5-41d5442849ae' WHERE [Id]=1748
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'fc2da022-f055-48a0-9f91-643710950d43' WHERE [Id]=1749
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'72ab7a79-351b-4893-8b79-d4d03fa39b4b' WHERE [Id]=1750
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'97cd0360-554d-411e-98f4-21874b3396e2' WHERE [Id]=1751
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d' WHERE [Id]=1752
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'28e36f79-bac9-4340-a942-95dc9888c9d0' WHERE [Id]=1753
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'33fc3fb8-f12b-40af-acfa-be21fddbd790' WHERE [Id]=1754
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'41eabde8-52de-4c93-895e-afdd95ada7dd' WHERE [Id]=1755
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b8b11a00-55a8-4238-ba74-6c7a1c66155f' WHERE [Id]=1756
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'39aa31cd-4781-402d-a3ff-3c142a22d932' WHERE [Id]=1757
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5472cf06-def0-4062-95df-6c6abb535288' WHERE [Id]=1758
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04' WHERE [Id]=1759
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9' WHERE [Id]=1760
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8' WHERE [Id]=1761
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6b61765e-ea61-4c76-939c-6ae9cc1de26a' WHERE [Id]=1762
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ee642289-11eb-4bf4-96d7-d29cf86f8af5' WHERE [Id]=1763
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'be5d4975-be9a-498f-865d-d07f06ff89cd' WHERE [Id]=1764
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1337d415-a395-4c6f-8e50-3353d2144358' WHERE [Id]=1765
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7' WHERE [Id]=1766
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'be9a0ee8-d035-454f-9fd8-981126b40901' WHERE [Id]=1767
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8b899c93-d247-416c-a2e3-1fd4f82ffb72' WHERE [Id]=1768
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b' WHERE [Id]=1769
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78' WHERE [Id]=1770
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'73b2bfbd-8cfc-4211-b027-629ca2a98e16' WHERE [Id]=1771
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'5931328a-4842-4a55-ab4a-4ecc135dc411' WHERE [Id]=1772
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'091cdee7-2d1d-4ce7-a78c-259f714f4fbe' WHERE [Id]=1773
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ed815f54-f12c-4a06-90a0-883367d6ae5e' WHERE [Id]=1774
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'12900316-455b-457e-9608-99bd7784b5b4' WHERE [Id]=1775
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'338293ba-7779-49e3-84b9-5129e4595976' WHERE [Id]=1776
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0b100835-2d9f-4822-988d-8398825d890c' WHERE [Id]=1777
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'05b91908-5bf4-4bdd-a308-0e265b1a3eb1' WHERE [Id]=1778
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'77ecfd18-7fc5-43fa-b4d1-41e00441716d' WHERE [Id]=1779
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'81be47a9-267e-46db-b29f-176d78feb76c' WHERE [Id]=1780
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'2e273d46-f310-4045-b71c-b3d030366786' WHERE [Id]=1781
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1aebf541-0e2c-4bc5-b831-7e279c18e07f' WHERE [Id]=1782
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b1872538-a731-457c-b014-c9724c5f400a' WHERE [Id]=1783
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b1b04e81-9891-4d43-b0ea-1082b1946c1c' WHERE [Id]=1784
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c4c58629-cb0f-4677-92c4-0b996bc3e9d4' WHERE [Id]=1785
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e7f1b097-aa16-4324-876e-9fa2346c4c1d' WHERE [Id]=1786
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7768e6b6-f89a-479d-8d78-37d17a7337a0' WHERE [Id]=1787
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'df35e021-6ac4-47ef-ae79-622eee46118a' WHERE [Id]=1788
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'84cb4ba1-c6b6-4bfe-a3be-8b13ca958607' WHERE [Id]=1789
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1be65a49-42aa-4b69-ae86-3e338a534397' WHERE [Id]=1790
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4ab8a098-0fd4-49d1-b3b4-257cc77e6bde' WHERE [Id]=1791
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'87d5550c-243f-464e-b840-538984cdbcd3' WHERE [Id]=1792
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=90000, [IdFunctionality]=N'ea8dd2bf-d37e-4a9d-96e9-fc5a712c9916' WHERE [Id]=1793
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'd166dfdd-0289-40ad-af71-bf2ef8d92de7' WHERE [Id]=1794
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'59e39e77-7e34-402b-9cb7-1e5979851a45' WHERE [Id]=1795
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4c4456b1-e25a-450b-b8ed-f1754b052cf2' WHERE [Id]=1796
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8604a88c-4e5b-4f8b-80f6-80d2e64a1173' WHERE [Id]=1797
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'23c296a6-c18d-476a-9a90-dfee961b3e91' WHERE [Id]=1798
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'9ab63ad6-398c-433e-8bde-bea519eccb9b' WHERE [Id]=1799
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'1c185dc5-ffc3-4c5a-8b57-999f0ec1b8d2' WHERE [Id]=1800
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a0df3ec7-881e-47d4-bb76-7f1750945bb4' WHERE [Id]=1801
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'58383b7d-21a0-408b-9a20-227754aed94a' WHERE [Id]=1802
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e9853c97-1317-4cd0-a65a-80d46b3e6f0e' WHERE [Id]=1803
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e7e18cc9-29ef-499d-a303-20c78c9c612d' WHERE [Id]=1804
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c8a6739e-bf26-4f95-b5ec-39910ab21619' WHERE [Id]=1805
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'96764174-5f40-462c-a27d-33da5e1370b3' WHERE [Id]=1806
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'0723db00-80a1-4125-855d-499d87c4ac90' WHERE [Id]=1807
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b46bf40d-dd79-4cb7-9109-606b26d7f2a9' WHERE [Id]=1808
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'7ab868d2-7df9-43f4-ad8c-7db411841503' WHERE [Id]=1809
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8f1efa25-37cd-46b1-9f19-ca227c793d8b' WHERE [Id]=1810
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'e7503523-4b3e-4562-9a4f-b7ed827b9a29' WHERE [Id]=1811
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd' WHERE [Id]=1812
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8ae23626-4c5f-4cfb-abe9-d33c2150991b' WHERE [Id]=1813
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a869f004-0ee9-4bfd-9986-7248355c6052' WHERE [Id]=1814
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'34a0f7d3-7f88-4de8-8c29-a1827670a940' WHERE [Id]=1815
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4' WHERE [Id]=1816
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'baca0b66-1cfd-469f-8eed-5442857d76b5' WHERE [Id]=1817
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'621fe63b-cf18-454b-8404-e8bec47154b3' WHERE [Id]=1818
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf' WHERE [Id]=1819
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'c1be620f-636b-413f-b857-dab1d1fff0ac' WHERE [Id]=1820
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60' WHERE [Id]=1821
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b7128c74-3b1a-47c4-851d-c211baa1fb0e' WHERE [Id]=1822
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e' WHERE [Id]=1823
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'226744c0-2184-4c6c-aed7-4ef91d60aff6' WHERE [Id]=1824
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25' WHERE [Id]=1825
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'a1aab54d-bf1b-488d-b1f0-2435306d77fa' WHERE [Id]=1826
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'af2dfe18-6a90-406b-891d-6308772f1223' WHERE [Id]=1827
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'4e57b151-f2c9-40ff-b59d-9158fd33d899' WHERE [Id]=1828
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72' WHERE [Id]=1829
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94' WHERE [Id]=1830
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'81d9a081-25e0-40d7-866c-3ac1684c2424' WHERE [Id]=1831
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdFunctionality]=N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8' WHERE [Id]=1870
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'a5adefe0-da79-4d63-b90a-7aead7d7ed32' WHERE [Id]=1871
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70002, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-157b4a3c8466' WHERE [Id]=1872
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70003, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-167b4a3c8466' WHERE [Id]=1873
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70004, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-177b4a3c8466' WHERE [Id]=1874
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70005, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-187b4a3c8466' WHERE [Id]=1875
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70006, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-197b4a3c8466' WHERE [Id]=1876
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70007, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-207b4a3c8466' WHERE [Id]=1877
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70008, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-217b4a3c8466' WHERE [Id]=1878
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70009, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-227b4a3c8466' WHERE [Id]=1879
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=70010, [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-237b4a3c8466' WHERE [Id]=1880
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'4046572a-ab91-4548-bcfc-7747eb7df41c' WHERE [Id]=1881
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'db71cf78-8417-4fc0-aabf-4b955796d9a2' WHERE [Id]=1882
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'441c0141-35ff-4233-9945-e797233f4fa4' WHERE [Id]=1883
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32' WHERE [Id]=1884
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'7efd7fbb-8ab1-4046-8267-753db514c23b' WHERE [Id]=1885
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'090a15ef-8766-435c-89a4-78aa54fda44d' WHERE [Id]=1886
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c' WHERE [Id]=1887
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf' WHERE [Id]=1888
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d' WHERE [Id]=1889
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'a94a17a2-60ed-4bde-a307-22787ea95b96' WHERE [Id]=1890
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'3bf5cebc-d59d-4938-895d-3ec5bf19361c' WHERE [Id]=1891
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=101016, [IdFunctionality]=N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1' WHERE [Id]=1892

BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1893, 101016, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1894, 101016, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1895, 101016, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1896, 101016, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1897, 101016, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1898, 101016, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1899, 101016, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1900, 101016, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1901, 101016, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1902, 101016, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1903, 101016, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1904, 101016, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
COMMIT TRANSACTION




BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'79ce368b-ad81-4973-aae7-ff402f34cfbf', N'CRM', NULL, 1, N'CRM', N'CRM', N'CRM_AR', N'CRM_DE', N'CRM_CH', N'CRM_ES', N'icon-note', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'11690986-d81d-43b6-b47d-d930abe49776', N'CRM', N'79ce368b-ad81-4973-aae7-ff402f34cfbf', 1, N'CRM', N'CRM', N'CRM_AR', N'CRM_DE', N'CRM_CH', N'CRM_ES', N'icon-note', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-217b4a3c8477', N'Paramétres CRM', NULL, 1, N'Paramétres CRM', N'CRM settings', NULL, NULL, NULL, NULL, NULL, 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-227b4a3c8477', N'Paramétres RH', NULL, 1, N'Paramétres RH', N'HR settings', NULL, NULL, NULL, NULL, NULL, 1)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-237b4a3c8477', N'Gestion des utilisateurs', NULL, 1, N'Gestion des utilisateurs', N'User management', NULL, NULL, NULL, NULL, NULL, 1)
COMMIT TRANSACTION


BEGIN TRANSACTION
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'817d920f-48ef-4aa2-865a-cc367c37fb3b', [IdRoleConfig]=100005 WHERE [Id]=300
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', [IdRoleConfig]=11111 WHERE [Id]=301
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', [IdRoleConfig]=100006 WHERE [Id]=302
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd438fbad-7305-4dad-ab44-a4fb84318a83', [IdRoleConfig]=100006 WHERE [Id]=303
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd438fbad-7305-4dad-ab44-a4fb84318a83', [IdRoleConfig]=101018 WHERE [Id]=304
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', [IdRoleConfig]=101018 WHERE [Id]=305
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fbb149f9-4d23-43d7-8576-0078daa06f8d', [IdRoleConfig]=90000 WHERE [Id]=306
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a710d793-9662-486c-8b3b-01d2a592111b', [IdRoleConfig]=90000 WHERE [Id]=307
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', [IdRoleConfig]=90000 WHERE [Id]=308
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'87b84a91-98fd-49f1-80f3-04630d73ed79', [IdRoleConfig]=90000 WHERE [Id]=309
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'dca0e118-de89-4b9d-a25b-08964a3856b9', [IdRoleConfig]=90000 WHERE [Id]=310
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'9a66818c-8385-49fa-a6ae-08ade53622e1', [IdRoleConfig]=90000 WHERE [Id]=311
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'156c4296-861c-4633-ac28-08eac1d8a49e', [IdRoleConfig]=90000 WHERE [Id]=312
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', [IdRoleConfig]=90000 WHERE [Id]=313
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', [IdRoleConfig]=90000 WHERE [Id]=314
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'38a92b23-2180-4497-ba96-0fe49758074f', [IdRoleConfig]=90000 WHERE [Id]=315
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', [IdRoleConfig]=90000 WHERE [Id]=316
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'51bf3865-133e-4e97-9f81-13564644742d', [IdRoleConfig]=90000 WHERE [Id]=317
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', [IdRoleConfig]=90000 WHERE [Id]=318
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5c56d444-523c-4cb3-8554-1a88b3af0779', [IdRoleConfig]=90000 WHERE [Id]=319
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'60b695ae-b5bd-4257-bf76-1ad97af29c07', [IdRoleConfig]=90000 WHERE [Id]=320
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', [IdRoleConfig]=90000 WHERE [Id]=321
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e6f0b965-7b14-48f9-8682-1e7cdc019386', [IdRoleConfig]=90000 WHERE [Id]=322
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', [IdRoleConfig]=90000 WHERE [Id]=323
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e0367d41-2d4b-4f85-9e7a-244803c29221', [IdRoleConfig]=90000 WHERE [Id]=324
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ff007474-a447-4c92-8f6a-265d5c08ff10', [IdRoleConfig]=90000 WHERE [Id]=325
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'21188e34-572b-4328-bf25-268df5eb2da0', [IdRoleConfig]=90000 WHERE [Id]=326
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e30959c4-61bb-457e-b44e-271c04a9e49d', [IdRoleConfig]=90000 WHERE [Id]=327
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', [IdRoleConfig]=90000 WHERE [Id]=328
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd0ed74ae-f0a9-4be7-89df-28c2d239f69d', [IdRoleConfig]=90000 WHERE [Id]=329
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'22367de5-32f0-4fd7-9340-296c7879c03f', [IdRoleConfig]=90000 WHERE [Id]=330
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ba44579d-71ad-404e-9a65-2e380b698b19', [IdRoleConfig]=90000 WHERE [Id]=331
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', [IdRoleConfig]=90000 WHERE [Id]=332
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'49c4d264-53af-4038-8466-2ee31b3b915c', [IdRoleConfig]=90000 WHERE [Id]=333
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8b43714c-d306-45b4-8d67-311a393e9133' WHERE [Id]=334
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'9ca06367-ad8b-4aa1-8994-316241dcd5de' WHERE [Id]=335
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'13446b5b-e1be-49d0-a0d4-332f7ab7febe' WHERE [Id]=336
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd02ccb30-71cf-4a57-8327-333be69e8af4' WHERE [Id]=337
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'949f1777-0d49-4e49-b776-34e801b9da85' WHERE [Id]=338
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'997d1f54-a483-4452-be25-3b9a9eab3884' WHERE [Id]=339
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'2f7d95d8-883a-445e-9ec2-3c4a70854f68' WHERE [Id]=340
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'101da8f5-e467-4af1-9b19-3d01ca21cf7c' WHERE [Id]=341
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a' WHERE [Id]=342
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a' WHERE [Id]=343
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a' WHERE [Id]=344
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'783fe0a6-0d38-43a3-8b41-42039da2ed3f' WHERE [Id]=345
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'afd3d290-ace7-4571-9444-4334f3171856' WHERE [Id]=346
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'1bdc6aaa-db4b-4862-9758-4382fd0e656a' WHERE [Id]=347
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5eef2177-47d5-4780-b338-46e284f8ce4a' WHERE [Id]=348
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a9f72604-b294-4035-a890-479a2d17ce10' WHERE [Id]=349
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e7e94ca1-eace-4b30-88d6-48286320eae1' WHERE [Id]=350
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f' WHERE [Id]=351
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'cc4b6a10-a842-4a65-a673-4acea9fb9cac' WHERE [Id]=352
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a0092569-9901-4fea-96e1-4cd96ea0eaed' WHERE [Id]=353
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1' WHERE [Id]=354
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8' WHERE [Id]=355
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8786ac1b-297a-410c-8f2a-4fa850ecdbba' WHERE [Id]=356
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8e37e06d-9a6d-453a-a11e-56a41bb9c102' WHERE [Id]=357
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'353d9847-1d65-4ba3-8582-57883d8f0267' WHERE [Id]=358
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'0b5ab8e8-2434-4631-b03c-58bc146ac66b' WHERE [Id]=359
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f' WHERE [Id]=360
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'138fac1b-7921-4844-ae68-637a2aabb2c3' WHERE [Id]=361
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'2bc26ad8-1542-4b1f-8fb0-659133434fc1' WHERE [Id]=362
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'361806f0-f88e-4b5e-bda6-68c34fb1faea' WHERE [Id]=363
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960' WHERE [Id]=364
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'4191141d-e747-40bd-a448-733d5c23f083' WHERE [Id]=365
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9' WHERE [Id]=366
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd2343785-b0e5-4d87-8f03-78d62c876d43' WHERE [Id]=367
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38' WHERE [Id]=368
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74' WHERE [Id]=369
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'7df17a2a-bfbd-4753-a61d-7f010d64cad7' WHERE [Id]=370
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'2a5e908b-e151-4ea8-939a-8271b74b8a13' WHERE [Id]=371
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'904decde-cef0-4150-9883-83e9839387c2' WHERE [Id]=372
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'461500a8-a604-46ab-ab77-8517783aea0d' WHERE [Id]=373
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8a648529-4f11-4df5-b569-85958ea994f6' WHERE [Id]=374
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd' WHERE [Id]=375
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'22b1f11f-8129-4128-ae3e-870d327bb4ae' WHERE [Id]=376
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'964167cb-03f3-4cdb-9b52-87564f6dda2f' WHERE [Id]=377
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'94a36607-432f-483b-aecf-8c0d3d19f47b' WHERE [Id]=378
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27' WHERE [Id]=379
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'159000fc-7090-48c5-bcc2-8e8cb688e8a9' WHERE [Id]=380
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5b998e60-fe89-4578-83bf-9471bdec317d' WHERE [Id]=381
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd1f0441a-a83f-414a-a106-9539a26a58ef' WHERE [Id]=382
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ae4ae5f7-280b-4a93-9330-96033bfa303a' WHERE [Id]=383
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [Id]=384
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'de7d394d-0c2d-4819-8434-97acb048467f' WHERE [Id]=385
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5' WHERE [Id]=386
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bea10b66-d2ee-49fe-be89-98b7fb911ff6' WHERE [Id]=387
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb' WHERE [Id]=388
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'08565d6a-47e9-4554-a9d5-9abfd44e48f0' WHERE [Id]=389
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd4708d75-55ff-447c-b816-9bf8e174c28d' WHERE [Id]=390
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'9b03405e-cb73-4c79-949e-9cd216ece4c4' WHERE [Id]=391
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a209794d-4f0f-4fff-b715-a03556e3ed87' WHERE [Id]=392
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'efa1d60e-933b-4749-bac3-a15e8bba3415' WHERE [Id]=393
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3cd0984a-a8e9-4975-aa51-a23bac267db1' WHERE [Id]=394
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3a3ed20b-f313-4b1b-9879-a287af094ff0' WHERE [Id]=395
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e' WHERE [Id]=396
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'927010d6-12da-45af-9a65-a453d766cfcf' WHERE [Id]=397
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd438fbad-7305-4dad-ab44-a4fb84318a83' WHERE [Id]=398
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ab566211-44ce-44a8-a843-a6764f816249' WHERE [Id]=399
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'12e372a0-52f7-4089-a3f4-a96cf646b6fb' WHERE [Id]=400
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ae298068-a632-40b3-b2d4-aa4636697160' WHERE [Id]=401
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'deb534e2-0848-48d3-8074-acd7e2805b58' WHERE [Id]=402
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf' WHERE [Id]=403
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3545d556-108a-4d68-9c99-afc572ba34df' WHERE [Id]=404
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e55c8fd9-ac89-4986-9291-afe0d5c02490' WHERE [Id]=405
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1' WHERE [Id]=406
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'e5947a1e-9db3-486a-b26c-b33be5e0a82e' WHERE [Id]=407
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3bceb952-b852-4d24-9f76-b472b3570486' WHERE [Id]=408
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'610782eb-cc27-4bde-b2be-b86878fecbdd' WHERE [Id]=409
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'214c0463-7e29-4740-acf7-bccec1adfa43' WHERE [Id]=410
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'15404a12-4c4e-485a-a2c8-bda14d9a35d8' WHERE [Id]=411
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'eeeef661-f871-435a-badd-be1d6c96765b' WHERE [Id]=412
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'6c3de305-9178-4b15-82f1-be6e1f801cb7' WHERE [Id]=413
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc' WHERE [Id]=414
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'0d8556e4-3f5e-44ed-aea6-c00c28593219' WHERE [Id]=415
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'289338c0-09ad-46e1-a893-c1aa2ed79cf4' WHERE [Id]=416
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'f401508a-a722-4ba3-90d2-c21a2b78713c' WHERE [Id]=417
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bc471d71-863e-47a0-95f4-c2e1595c2bd9' WHERE [Id]=418
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'1755151f-da27-40ad-b605-c51624e5779a' WHERE [Id]=419
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b' WHERE [Id]=420
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8655e017-b3e2-49bd-8a4a-c84d3abed569' WHERE [Id]=421
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'25200373-be95-4c8b-8f47-ca13ef03341e' WHERE [Id]=422
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'11503286-9245-41ee-a502-caa5ea9cf776' WHERE [Id]=423
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'817d920f-48ef-4aa2-865a-cc367c37fb3b' WHERE [Id]=424
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'8cab7af9-78ef-4a95-88a6-ce059225323c' WHERE [Id]=425
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a49cd432-de82-40d6-8994-ce2f102039cc' WHERE [Id]=426
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'1b8c288b-6fb4-4816-964b-ce7b89339db9' WHERE [Id]=427
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fdc3ed27-ac8a-4256-a340-ce96961358d6' WHERE [Id]=428
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b' WHERE [Id]=429
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3' WHERE [Id]=430
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6' WHERE [Id]=431
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'f8ff6b5e-d60b-4b83-9934-d6eee590c523' WHERE [Id]=432
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb' WHERE [Id]=433
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5dcb7310-a80e-40fa-8e09-dc64537a2e10' WHERE [Id]=434
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed' WHERE [Id]=435
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bef67db7-625d-41e7-99ae-e116177d04a1' WHERE [Id]=436
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd407d85f-428f-42d2-9a7c-e7812f23fbc9' WHERE [Id]=437
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'4ab9f044-39b3-4ba2-8830-e86ab9971d49' WHERE [Id]=438
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'eb59fddc-6dd7-4629-b4d1-ea1745794a73' WHERE [Id]=439
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'081ef980-e302-4386-89fa-ea31857b1c2d' WHERE [Id]=440
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'b678b40a-e499-4961-862b-eae2ecf7baef' WHERE [Id]=441
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'7e5ac492-0987-4d51-b14e-eb0e7c58de75' WHERE [Id]=442
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'659f9dfd-ad67-4129-8d2d-ebc28cc54334' WHERE [Id]=443
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5a19bde6-fa86-4511-97ae-ec4c2fb61786' WHERE [Id]=444
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20' WHERE [Id]=445
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'3f092f7b-64cf-4ec9-b571-ee69defc3310' WHERE [Id]=446
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'd19420b6-2887-4f56-acc4-f003c33f1d89' WHERE [Id]=447
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'4609408f-7f48-4a57-8bfb-f1f0b108099b' WHERE [Id]=448
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988' WHERE [Id]=449
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'a1c1288e-6557-4a5d-b12d-f32e8d48629a' WHERE [Id]=450
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'0934b53e-48dd-4693-bca2-f6a5ce39b359' WHERE [Id]=451
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a' WHERE [Id]=452
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'bf043378-ebc1-4c83-ba68-f78da6ef36ec' WHERE [Id]=453
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'14110ae1-17a1-446a-a3db-f893a04f4794' WHERE [Id]=454
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304' WHERE [Id]=455
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'79ce368b-ad81-4973-aae3-ff402f34cfbf' WHERE [Id]=456
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'79ce368b-ad81-4973-aae3-ff402f34cfbf' WHERE [Id]=483
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'79ce368b-ad81-4973-aae7-ff402f34cfbf' WHERE [Id]=484
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'79ce368b-ad81-4973-aae7-ff402f34cfbf', [IdRoleConfig]=101016 WHERE [Id]=485
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'11690986-d81d-43b6-b47d-d930abe49776', [IdRoleConfig]=101016 WHERE [Id]=486
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-157b4a3c8477', [IdRoleConfig]=70002 WHERE [Id]=487
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-167b4a3c8477', [IdRoleConfig]=70003 WHERE [Id]=488
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', [IdRoleConfig]=70004 WHERE [Id]=489
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-187b4a3c8477', [IdRoleConfig]=70005 WHERE [Id]=490
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-197b4a3c8477', [IdRoleConfig]=70006 WHERE [Id]=491
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-207b4a3c8477', [IdRoleConfig]=70007 WHERE [Id]=492
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-217b4a3c8477', [IdRoleConfig]=70008 WHERE [Id]=493
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-227b4a3c8477', [IdRoleConfig]=70009 WHERE [Id]=494
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'fd671f2f-5b90-4de3-9a07-237b4a3c8477', [IdRoleConfig]=70010 WHERE [Id]=495
UPDATE [ERPSettings].[Functionality] SET [FunctionalityName]=N'Salary settings', [FR]=N'Paramétrage salaire', [EN]=N'Salary settings', [DefaultRoute]=N'/Salary', [ApiRole]=N'Salary settings' WHERE [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-177b4a3c8466'
UPDATE [ERPSettings].[Functionality] SET [FunctionalityName]=N'Payroll settings', [FR]=N'Paramétres paie', [EN]=N'Payroll settings', [DefaultRoute]=N'/Payroll', [ApiRole]=N'Payroll settings' WHERE [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-207b4a3c8466'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdFunctionnality]=N'a5adefe0-da79-4d63-b90a-7aead7d7ed32', [IdModule]=N'11690986-d81d-43b6-b47d-d930abe49776' WHERE [IdFunctionnalityModule]=N'0ebb9f26-b8b2-4780-a264-4f3fdeb26386'
UPDATE [ERPSettings].[Module] SET [Rank]=9 WHERE [IdModule]=N'1755151f-da27-40ad-b605-c51624e5779a'
UPDATE [ERPSettings].[Module] SET [Rank]=8 WHERE [IdModule]=N'ae4ae5f7-280b-4a93-9330-96033bfa303a'
UPDATE [ERPSettings].[Module] SET [IdModuleParent]=N'd438fbad-7305-4dad-ab44-a4fb84318a83' WHERE [IdModule]=N'ba3b0e01-71c9-4513-9d3e-2e94d681b195'
UPDATE [ERPSettings].[Module] SET [ModuleName]=N'Paramétrage salaire', [FR]=N'Paramétrage salaire', [EN]=N'Salary settings' WHERE [IdModule]=N'fd671f2f-5b90-4de3-9a07-177b4a3c8477'
UPDATE [ERPSettings].[Module] SET [ModuleName]=N'Paramétres paie', [FR]=N'Paramétres paie', [EN]=N'Payroll settings' WHERE [IdModule]=N'fd671f2f-5b90-4de3-9a07-207b4a3c8477'
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion des Achats                                ' WHERE [Id]=11111
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion de Stock                                  ', [IsDeleted]=0 WHERE [Id]=22222
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion des Ventes                                ', [IsDeleted]=0 WHERE [Id]=33333
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion des Immobilisation                        ' WHERE [Id]=44444
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'Salary_Settings                                   ', [RoleName]=N'Paramétrage salaire                               ' WHERE [Id]=70004
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'Payroll_Settings                                  ', [RoleName]=N'Paramétres paie                                   ' WHERE [Id]=70007
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion de Reglages                               ' WHERE [Id]=77777
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Assistance                                        ' WHERE [Id]=88888
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100008 WHERE [Id]=100000
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100008 WHERE [Id]=100001
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100008 WHERE [Id]=100002
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100008 WHERE [Id]=100003
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=11111 WHERE [Id]=100004
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Historique Achat                                  ', [IdRoleConfigCategory]=22222 WHERE [Id]=100005
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'Session de facturation                            ', [RoleName]=N'Session de facturation                            ', [IdRoleConfigCategory]=33333 WHERE [Id]=100006
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'Contrat de prestation                             ', [RoleName]=N'Contrat de prestation                             ', [IdRoleConfigCategory]=33333 WHERE [Id]=100007
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'Customer Relationship Management                  ', [RoleName]=N'CRM                                               ', [IdRoleConfigCategory]=100301 WHERE [Id]=101016
UPDATE [ERPSettings].[RoleConfigCategory] SET [Label]=N'Reglages' WHERE [Id]=77777
UPDATE [ERPSettings].[RoleConfigCategory] SET [Code]=N'EMPLOYEES', [Label]=N'Employés', [TranslationCode]=N'EMPLOYEES' WHERE [Id]=100008
COMMIT TRANSACTION

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-217b4a3c8499', N'fd671f2f-5b90-4de3-9a07-217b4a3c8466', N'fd671f2f-5b90-4de3-9a07-217b4a3c8477')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-227b4a3c8499', N'fd671f2f-5b90-4de3-9a07-227b4a3c8466', N'fd671f2f-5b90-4de3-9a07-227b4a3c8477')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-237b4a3c8499', N'fd671f2f-5b90-4de3-9a07-237b4a3c8466', N'fd671f2f-5b90-4de3-9a07-237b4a3c8477')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-287b4a3c8499', N'db71cf78-8417-4fc0-aabf-4b955796d9a2', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-297b4a3c8499', N'4046572a-ab91-4548-bcfc-7747eb7df41c', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-307b4a3c8499', N'441c0141-35ff-4233-9945-e797233f4fa4', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-317b4a3c8499', N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-327b4a3c8499', N'7efd7fbb-8ab1-4046-8267-753db514c23b', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-337b4a3c8499', N'090a15ef-8766-435c-89a4-78aa54fda44d', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-347b4a3c8499', N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-357b4a3c8499', N'06048d73-4dd8-42e1-b095-806c636ff9f0', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-367b4a3c8499', N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-377b4a3c8499', N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-387b4a3c8499', N'89e4f583-900b-43ec-ab63-34e838f35a81', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-397b4a3c8499', N'4046572a-ab91-4548-bcfc-7747eb7df41c', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-407b4a3c8499', N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-417b4a3c8499', N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-427b4a3c8499', N'a94a17a2-60ed-4bde-a307-22787ea95b96', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-437b4a3c8499', N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-447b4a3c8499', N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-457b4a3c8499', N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-467b4a3c8499', N'24fb6bff-bf88-4367-a5be-7a9180304283', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-477b4a3c8499', N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-487b4a3c8499', N'f683600c-bd77-495b-8baf-a76fd1df0215', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-497b4a3c8499', N'39887b12-6eee-4997-b509-b0bd643a727e', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-507b4a3c8499', N'20de167f-fde4-4fa3-a154-edb87e97bf73', N'11690986-d81d-43b6-b47d-d930abe49776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-517b4a3c8499', N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', N'11690986-d81d-43b6-b47d-d930abe49776')
COMMIT TRANSACTION

-- narcisse: Fix script lost in merge 10/06/2020

BEGIN TRANSACTION
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=274
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=275
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=276
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=277
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=278
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=279
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=280
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=281
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=282
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=283
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=284
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=285
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=286
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=287
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=288
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=289
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=290
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=291
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=292
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=293
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=294
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=295
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=296
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=297
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=304
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=305
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=664
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=665
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=666
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=667
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=901
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=902
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=903
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=904
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=905
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=906
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=907
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=908
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=909
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=910
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=911
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=912
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=913
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=914
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=915
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=916
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=917
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=918
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=919
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=920
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=921
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=922
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=923
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=924
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=925
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=926
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=927
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=928
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=929
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=930
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=931
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=932
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=933
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=934
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=935
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=936
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=937
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=938
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=939
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=940
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=941
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=942
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=943
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=944
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=945
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=946
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=947
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=948
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=949
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=950
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=951
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=952
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=953
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=954
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=955
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=956
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=957
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=958
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=959
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=960
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=961
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=962
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=963
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=964
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=965
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=966
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=967
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=968
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=969
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=970
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=971
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=972
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=973
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=974
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=975
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=976
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=977
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=978
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=979
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=980
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=981
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=982
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=983
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=984
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=985
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=1000
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=1001
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=1002
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=1003
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=1004
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3538
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3539
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3540
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3541
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3542
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3543
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3544
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3545
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3546
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3547
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3548
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3549
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=3550
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Session de facturation                            ' WHERE [Id]=101017
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Contrat de prestation                             ' WHERE [Id]=101018
GO
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101045, N'Retenue à la Source                               ', N'Retenue à la Source                               ', 0, NULL, 100300)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101046, N'Employé sans Modification                         ', N'Employé/Read                                      ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101047, N'Employé avec Modification                         ', N'Employé/Read/Write                                ', 0, NULL, 100303)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101048, N'Ordre de Virement                                 ', N'Ordre de Virement                                 ', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
GO
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]

SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4902, 101045, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4903, 101045, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4904, 101045, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4905, 101045, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4906, 101045, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4907, 101046, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4908, 101046, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4909, 101046, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4910, 101047, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4911, 101047, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4912, 101047, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4913, 101047, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4914, 101047, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4915, 101013, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4916, 101013, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4917, 101013, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4918, 101013, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4919, 101013, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4920, 101048, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4921, 101048, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4922, 101048, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4923, 101048, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4924, 101048, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4925, 101048, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4926, 101011, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4927, 101011, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4928, 101011, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4929, 101011, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4930, 101011, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4931, 101009, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4932, 101009, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4933, 101009, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4934, 101008, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4935, 101008, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4936, 101008, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4937, 101008, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4938, 101008, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4939, 100010, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4940, 100010, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4941, 100010, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4942, 100010, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4943, 100010, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4944, 100010, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4945, 100007, N'81dfe010-14a0-48a7-aa0d-48023d967286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4946, 100007, N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4947, 100007, N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4948, 100007, N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4949, 100007, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4950, 101017, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4951, 101017, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4952, 101017, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4953, 101017, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4954, 101017, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4955, 100003, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4956, 100003, N'3eb1157c-852d-43ea-a65f-7073e3897613', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4957, 100003, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4958, 100003, N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4959, 100003, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4960, 100003, N'422f1608-e641-4ec1-9163-636bb3c6962b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4961, 100003, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4962, 100003, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4963, 100003, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4964, 100003, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4965, 100003, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4966, 100003, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4967, 100003, N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4968, 100003, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4969, 100003, N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4970, 100003, N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4971, 100003, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4972, 100003, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4973, 100003, N'a1ca4007-d64e-4765-af61-42e753a61222', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4974, 100003, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4975, 100003, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4976, 100003, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4977, 100003, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4978, 100003, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4979, 100003, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4980, 100003, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4981, 100003, N'5d854334-c1b7-48c8-8811-7a37ca16dc7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4982, 100003, N'e83a0045-89c6-459f-8d99-89c25077f4ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4983, 100003, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4984, 100003, N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4985, 100003, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4986, 100003, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4987, 100003, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4988, 100003, N'12e2ecc5-d861-4680-9310-92422a3e2593', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4989, 100003, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4990, 100003, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4991, 100003, N'336fdb14-6186-41c2-b2ff-98c99ea25c5f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4992, 100003, N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4993, 100003, N'11ab7a69-a705-4f46-8821-9bb3b7815a98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4994, 100003, N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4995, 100003, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4996, 100003, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4997, 100003, N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4998, 100003, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4999, 100003, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5000, 100003, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5001, 100003, N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5002, 100003, N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5003, 100003, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5004, 100003, N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5005, 100003, N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5006, 100003, N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5007, 100003, N'322d8fea-9553-46c1-a83b-24276d046f53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5008, 100003, N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5009, 100003, N'05d45e13-6184-4085-b9b2-86015af49e11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5010, 100003, N'712d6299-495e-45ce-9010-20e4ad36834a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5011, 100003, N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5012, 100003, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5013, 100003, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5014, 100003, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5015, 100003, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5016, 100003, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5017, 100003, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5018, 100003, N'a6c247bc-d584-43a3-b995-f303e3b13c77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5019, 100003, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5020, 100003, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5021, 100003, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5022, 100003, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5023, 100003, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5024, 100003, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5025, 100003, N'831becf0-0744-4fe4-b79c-dec135cee846', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5026, 100003, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5027, 100003, N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5028, 100003, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5029, 100003, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5030, 100003, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5031, 100003, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5032, 100003, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5033, 100003, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5034, 100003, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5035, 100003, N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5036, 100003, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5037, 100003, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5038, 100003, N'06eb3687-d016-4597-9538-c1eaed785b50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5039, 100003, N'd7c9f718-49fb-41e3-88a5-0197b286cd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5040, 100003, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5041, 100003, N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5042, 100003, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5043, 100003, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5044, 100003, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
GO
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1010, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101045, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1011, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 101045, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1012, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101046, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1013, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 101046, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1014, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101047, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1015, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 101047, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1016, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1017, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1018, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101048, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1019, N'5b998e60-fe89-4578-83bf-9471bdec317d', 101048, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1020, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1021, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1022, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1023, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1024, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1025, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1026, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1027, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1028, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1029, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1030, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1031, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1032, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1033, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1034, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1035, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1036, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1037, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1038, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1039, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1040, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1041, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1042, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1043, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1044, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1045, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1046, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1047, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1048, N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1049, N'd2343785-b0e5-4d87-8f03-78d62c876d43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1050, N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1051, N'5c56d444-523c-4cb3-8554-1a88b3af0779', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1052, N'a49cd432-de82-40d6-8994-ce2f102039cc', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1053, N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1054, N'21188e34-572b-4328-bf25-268df5eb2da0', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1055, N'51bf3865-133e-4e97-9f81-13564644742d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1056, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1057, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1058, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1059, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1060, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1061, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1062, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1063, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1064, N'5b998e60-fe89-4578-83bf-9471bdec317d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1065, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1066, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 100003, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF
COMMIT TRANSACTION

-- Amine KARRAY : Add GED default folders 10-06-2020

BEGIN TRANSACTION
SET IDENTITY_INSERT [RH].[FileDrive] ON
INSERT INTO [RH].[FileDrive] ([Id], [Name], [CreatedBy], [CreationDate], [Type], [IdParent], [Size], [Path], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, N'Mes documents personnels', 2, '20200601', NULL, NULL, 0, N'C:\uploadFiles\Spark test\RH\Starkdrive\adminadmin\', 0, 0, NULL)
INSERT INTO [RH].[FileDrive] ([Id], [Name], [CreatedBy], [CreationDate], [Type], [IdParent], [Size], [Path], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, N'Mes documents administratifs', 2, '20200601', NULL, NULL, 0, N'C:\uploadFiles\Spark test\RH\Starkdrive\adminadmin\', 0, 0, NULL)
INSERT INTO [RH].[FileDrive] ([Id], [Name], [CreatedBy], [CreationDate], [Type], [IdParent], [Size], [Path], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N'Mes fiches de Paie', 2, '20200601', NULL, NULL, 0, N'C:\uploadFiles\Spark test\RH\Starkdrive\adminadmin\', 0, 0, NULL)
INSERT INTO [RH].[FileDrive] ([Id], [Name], [CreatedBy], [CreationDate], [Type], [IdParent], [Size], [Path], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, N'Documents partagés', 2, '20200601', NULL, NULL, 0, N'C:\uploadFiles\Spark test\RH\Starkdrive\adminadmin\', 0, 0, NULL)
INSERT INTO [RH].[FileDrive] ([Id], [Name], [CreatedBy], [CreationDate], [Type], [IdParent], [Size], [Path], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, N'Corbeille', 2, '20200601', NULL, NULL, 0, N'C:\uploadFiles\Spark test\RH\Starkdrive\adminadmin\', 0, 0, NULL)
SET IDENTITY_INSERT [RH].[FileDrive] OFF
COMMIT TRANSACTION

-- Fadi : add config 11-06-2020

BEGIN TRANSACTION
INSERT INTO [Shared].[JobsParameter] ([Id], [Keys], [Field], [Value], [Description], [IsDeleted], [Deleted_Token]) VALUES (1, N'AnnualReviewJob', N'notificationDays', N'[1,3,7,10,30]', N'notification days number', 0, NULL)
COMMIT TRANSACTION

-- Narcisse: Add Variable and VariableValidityPeriod 11/06/2020

SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (99, N'SMIG', 2, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF

BEGIN TRANSACTION
ALTER TABLE [Payroll].[VariableValidityPeriod] DROP CONSTRAINT [FK_VariableValidityPeriod_Variable]
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
GO
--SET IDENTITY_INSERT [Payroll].[Variable] ON
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (9, N'Brut imposable annuel', 0, 0, NULL, 80, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (12, N'Réduction sur le nombre d''enfants', 0, 0, NULL, 86, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (13, N'Net annuel', 0, 0, NULL, 88, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (14, N'Les frais réels', 0, 0, NULL, 87, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (16, N'Réduction si père de famille', 0, 0, NULL, 89, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (21, N'Varibale du credit d''habitaion', 0, 0, NULL, 91, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (22, N'Varibale du nombre d''enfant non boursier', 0, 0, NULL, 93, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (23, N'Varibale du nombre d''enfant handicapé', 0, 0, NULL, 94, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (29, N'Base imposable annuel', 0, 0, NULL, 96, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (31, N'Base de calcul de la réduction par rapport au nombre de parent', 0, 0, NULL, 98, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (32, N'Réduction sur le nombre de parent à charge', 0, 0, NULL, 97, NULL)
--INSERT INTO [Payroll].[Variable] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference], [Name]) VALUES (33, N'Salaire minimum interprofessionnel garanti', 0, 0, NULL, 99, N'SMIG')
--SET IDENTITY_INSERT [Payroll].[Variable] OFF
--GO
--SET IDENTITY_INSERT [Payroll].[VariableValidityPeriod] ON
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (21, '20180101', N'BASEIMPOSABLEANNUEL- NEnfant - NChefFamille-CreditHabitation-NBEnfantNonBoursier-NBEnfantHandicape-PARENTACHARGE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', 0, NULL, N'0', 9)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (22, '20180101', N'Si (Employee.FamilyLeader)
  --  Alors Employee.ChildrenNumber * 100
--Sinon 0
--Finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ', 0, NULL, N'0', 12)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (23, '20180101', N'BRUTIMPOSABLEANNUEL - FRAISREELS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', 0, NULL, N'0', 13)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (24, '20180101', N'Si (BRUTIMPOSABLEANNUEL > 20000)
 --   Alors 2000
--Sinon BRUTIMPOSABLEANNUEL/10
--Finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', 0, NULL, N'0', 14)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (25, '20180101', N'Si (Employee.FamilyLeader)
  --  Alors 500
--Sinon 0
--Finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 0, NULL, N'0', 16)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (26, '20180101', N'Employee.HomeLoan                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ', 0, NULL, N'0', 21)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (27, '20180101', N'Employee.ChildrenNoScholar*1000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', 0, NULL, N'0', 22)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (28, '20180101', N'Employee.ChildrenDisabled*2000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 0, NULL, N'0', 23)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (29, '20180101', N'(BASE + PRIME_IMPOSABLE - CNSS)*12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ', 0, NULL, N'0', 29)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (30, '20180101', N'BASEIMPOSABLEANNUEL * 5 / 100                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', 0, NULL, N'0', 31)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (31, '20180101', N'Si (BASECALCULPARENTACHARGE > 150)
    --Alors Employee.DependentParent * 150
--Sinon BASECALCULPARENTACHARGE * Employee.DependentParent
--Finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', 0, NULL, N'0', 32)
--INSERT INTO [Payroll].[VariableValidityPeriod] ([Id], [StartDate], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdVariable]) VALUES (32, '20180101', N'5000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ', 0, 0, NULL, 33)
--SET IDENTITY_INSERT [Payroll].[VariableValidityPeriod] OFF
--ALTER TABLE [Payroll].[VariableValidityPeriod]
  --  ADD CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY ([IdVariable]) REFERENCES [Payroll].[Variable] ([Id])
--ALTER TABLE [Payroll].[Variable]
 --   ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
--COMMIT TRANSACTION


-- Mohamed BOUZIDI add documentReportData
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('O-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('O-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('D-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('D-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('I-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('I-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('Q-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('Q-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('A-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('A-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('RQ-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('B-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('FO-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('BE-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('BS-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([ReportCode],[ReportName]) VALUES ('IA-SA','genericDocumentReport')



--10/06/2020 Ahmed 

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100046
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100047
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100042
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Validation Inventaire' WHERE [Id] = 101081
GO
COMMIT TRANSACTION 


BEGIN TRANSACTION
update [ERPSettings].[Module] set [ModuleName]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
update [ERPSettings].[Module] set [EN]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
update [ERPSettings].[Module] set [FR]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
GO
COMMIT TRANSACTION 

---11/10/2020 Ahmed
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', N'OF-CONFIRMATION-INVOICE', 4, N'Of Confirmation Invoice', N'Dévalidation Facture', NULL, NULL, NULL, NULL, N'/Stock/Innvoice', 0, N'OF-CONFIRMATION-INVOICE')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (10155, N'OF-CONFIRMATION-INVOICE', N'Dévalidation Facture', 0, NULL,33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 10155, N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564644742D',N'Reliquats',N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 12,	N'Facture',N'Invoice',	NULL,	NULL,	NULL,	NULL,	NULL,	1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F99-14564644742D', 10155, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c8499', N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', N'51BF3865-133E-4E97-9F99-14564644742D')


BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100039
GO
COMMIT TRANSACTION


--17/06/2020 Ahmed
BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [Code]= N'DevisConfig' WHERE [Id] =100011
GO
COMMIT TRANSACTION

-- 19/06/2020 Ahmed
--Purchase invoice 
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'BC471D71-863E-47A0-95F4-C2E1595C2BD9', 100029, 1)
--Purchase final order
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'8786AC1B-297A-410C-8F2A-4FA850ECDBBA', 100030, 1)
--Purchase asset
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'0AA2ABAA-8057-4BD3-8A64-D6C16552AAF6', 100028, 1)

--- Nesrin : add SalaryStructureValidityPeriod and SalaryStructureValidityPeriodSalaryRule data 02/07/2020
BEGIN TRANSACTION

GO
SET IDENTITY_INSERT [Payroll].[SalaryRule] ON
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (74, N'SALAIRE DE BASE', N'SALAIRE DE BASE', 0, 1, 1, 0, 1, 0, 0, NULL, NULL, 74, 1, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (75, N'SALAIRE BRUT', N'SALAIRE BRUT', 0, 1, 1, 1, 1, 0, 0, NULL, NULL, 75, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (76, N'SALAIRE IMPOSABLE', N'SALAIRE IMPOSABLE', 0, 1, 1, 2, 1, 0, 0, NULL, NULL, 76, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (77, N'SALAIRE NET A PAYER', N'SALAIRE NET A PAYER', 0, 1, 1, 3, 1, 0, 0, NULL, NULL, 77, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (78, N'Retenue CNSS', N'Retenue CNSS', 1, 2, 1, 1, 1, 0, 0, NULL, NULL, 81, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (89, N'Retenue IRPP', N'Retenue IRPP', 2, 2, 1, 2, 1, 0, 0, NULL, NULL, 82, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (90, N'Contribution sociale solidaire ', N'Contribution sociale solidaire ', 3, 2, 1, 2, 1, 0, 0, NULL, NULL, 83, 0, 1)
SET IDENTITY_INSERT [Payroll].[SalaryRule] OFF

UPDATE [Payroll].[SalaryStructure] SET [TransactionUserId]=0, [IdParent]= NULL WHERE [Id]=4


GO
SET IDENTITY_INSERT [Payroll].[SalaryRuleValidityPeriod] ON
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1158, '20180101', NULL, 74, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1159, '20180101', NULL, 75, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1160, '20180101', NULL, 76, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1161, '20180101', NULL, 77, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1189, '20180101', N'Si (NETANNUEL > SMIG)
Alors NETANNUEL/12*0.01
Sinon 0
finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ', 90, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1190, '20180101', N'si(Employee.IsForeign)
    Alors (NETANNUEL *30/100/12)
    sinon
        si (NETANNUEL> 50000)
            Alors ((NETANNUEL-50000)*35/100 + 50000*26,20/100)/12
        sinon
          si (NETANNUEL> 30000)
                  Alors ((NETANNUEL-30000)*32/100 + 6700)/12
            sinon
                    si (NETANNUEL> 20000)
                             Alors ((NETANNUEL-20000)*28/100 + 20000*19,5/100)/12
                     sinon
                               si (NETANNUEL> 5000) Alors ((NETANNUEL-5000)*26/100)/12
                               sinon 0
                                finsi
                     finsi
            finsi
        finsi
    finsi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 89, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryRuleValidityPeriod] ([Id], [StartDate], [rule], [IdSalaryRule], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (1191, '20180101', N'BASE * Cnss.SalaryRate/100 + PRIME_COTISABLE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 78, 0, NULL, 0)
SET IDENTITY_INSERT [Payroll].[SalaryRuleValidityPeriod] OFF


SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriod] ON
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (29, '20180101', 10, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (30, '20180101', 9, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (31, '20180101', 8, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (32, '20180101', 7, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (33, '20180101', 5, 0, NULL, 0)
INSERT INTO [Payroll].[SalaryStructureValidityPeriod] ([Id], [StartDate], [IdSalaryStructure], [IsDeleted], [Deleted_Token], [TransactionUserId]) VALUES (34, '20180101', 4, 0, NULL, 0)
SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriod] OFF
COMMIT TRANSACTION

BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriodSalaryRule] ON
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (165, 0, 0, NULL, 74, 29)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (166, 0, 0, NULL, 75, 29)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (167, 0, 0, NULL, 77, 29)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (168, 0, 0, NULL, 78, 30)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (169, 0, 0, NULL, 89, 30)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (170, 0, 0, NULL, 90, 30)
SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriodSalaryRule] OFF
COMMIT TRANSACTION


-- Narcisse: Add ROOT AND CDI affectation rules 03/07/2020 

BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriodSalaryRule] ON
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (171, 0, 0, NULL, 74, 34)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (172, 0, 0, NULL, 75, 34)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (173, 0, 0, NULL, 76, 34)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (174, 0, 0, NULL, 77, 34)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (175, 0, 0, NULL, 78, 33)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (176, 0, 0, NULL, 89, 33)
INSERT INTO [Payroll].[SalaryStructureValidityPeriodSalaryRule] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdSalaryRule], [IdSalaryStructureValidityPeriod]) VALUES (177, 0, 0, NULL, 90, 33)
SET IDENTITY_INSERT [Payroll].[SalaryStructureValidityPeriodSalaryRule] OFF
COMMIT TRANSACTION

-- update Ecommerce model 
update ERPSettings.Module set ModuleName=N'Paramétres E-commerce', FR=N'Paramétres E-commerce', EN=N'Ecommerce settings' where IdModule= 'FD671F2F-5B90-4DE3-9A07-207B4A3C8477'

-- update Ecommerce roleConfig
update ERPSettings.RoleConfig set Code=N'Ecommerce_Settings', RoleName='Paramétres E-commerce' where Id=70007

--update Ecommerce Functionality
update ERPSettings.Functionality set FunctionalityName=N'Ecommerce settings', FR=N'Paramétres E-commerce', EN=N'Ecommerce settings', ApiRole=N'Ecommerce settings' where IdFunctionality='FD671F2F-5B90-4DE3-9A07-207B4A3C8466'

--insert Payroll  
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES
(N'FD671F2F-5B90-4DE3-9A07-707B4A3C8477', N'Paramétres paie', NULL, 1, N'Paramétres paie', N'Payroll settings',null, null, null, null, null, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b55-4de3-9a07-617b4a3c8466', N'Payroll settings', 15, N'Paramétres paie', N'Payroll settings', NULL, NULL, NULL, NULL, N'/Payroll', 0, N'Payroll settings')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70012,N'Payroll_Settings', N'Paramétres paie', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'FD671F2F-5B90-4DE3-9A07-707B4A3C8499', N'fd671f2f-5b55-4de3-9a07-617b4a3c8466', N'FD671F2F-5B90-4DE3-9A07-707B4A3C8477')

-- update payroll moduleConfig
update ERPSettings.ModuleConfig set IdModule=N'FD671F2F-5B90-4DE3-9A07-707B4A3C8477', IdRoleConfig=70012 where Id = 492 
--update payroll funcConfig
update ERPSettings.FunctionalityConfig set IdRoleConfig=70012, IdFunctionality=N'fd671f2f-5b55-4de3-9a07-617b4a3c8466' where Id=1877

-- update Purchase model 
update ERPSettings.Module set ModuleName=N'Paramétrage achat', FR=N'Paramétrage achat', EN=N'Purchase settings' where IdModule= 'FD671F2F-5B90-4DE3-9A07-177B4A3C8477'

-- update Purchase roleConfig
update ERPSettings.RoleConfig set Code=N'Purchase_Settings', RoleName='Paramétrage achat' where Id=70004

--update Purchase Functionality
update ERPSettings.Functionality set FunctionalityName=N'Purchase settings', FR=N'Paramétrage achat', EN=N'Purchase settings', ApiRole=N'Purchase settings' where IdFunctionality='FD671F2F-5B90-4DE3-9A07-177B4A3C8466'

--insert Salary  
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES
(N'FD671F2F-5B90-4DE3-9A07-777B4A3C8477', N'Paramétrage salaire', NULL, 1, N'Paramétrage salaire', N'Salary settings',null, null, null, null, null, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b22-4de3-9a07-777b4a3c8522', N'Salary settings', 15, N'Paramétrage salaire', N'Salary settings', NULL, NULL, NULL, NULL, N'/Salary', 0, N'Salary settings')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70013,N'Salary_Settings', N'Paramétrage salaire', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'FD671F2F-5B20-4DE3-9A07-707B4A3C8499', N'fd671f2f-5b22-4de3-9a07-777b4a3c8522', N'FD671F2F-5B90-4DE3-9A07-777B4A3C8477')

-- update Salary moduleConfig
update ERPSettings.ModuleConfig set IdModule=N'FD671F2F-5B90-4DE3-9A07-777B4A3C8477', IdRoleConfig=70013 where Id = 489 
--update Salary funcConfig
update ERPSettings.FunctionalityConfig set IdRoleConfig=70013, IdFunctionality=N'fd671f2f-5b22-4de3-9a07-777b4a3c8522' where Id=1874

-- update roleConfigCategory (employees / comptabilité)
insert into ERPSettings.RoleConfigCategory ([Code],[Label],[TranslationCode],[IsDeleted],[TransactionUserId],[Deleted_Token]) values (N'EMPLOYEES', N'Employés', N'EMPLOYEES',0,null,null)
update ERPSettings.RoleConfig set IdRoleConfigCategory=100401 where Id in (100000,100001,100002, 100003, 101014, 101015)
update ERPSettings.RoleConfigCategory set Code=N'COMPTABILITE', Label = N'Comptabilité' ,TranslationCode=N'Comptabilite' where Id=100008

-- update functionalityConfig
update ERPSettings.FunctionalityConfig set IdRoleConfig=11111, IdFunctionality=N'C6E123FE-503B-4694-85DC-528DA3614DDF' where Id=1793
insert into ERPSettings.FunctionalityConfig ([IdRoleConfig],[IdFunctionality],[IsActive]) values (90000,N'EA8DD2BF-D37E-4A9D-96E9-FC5A712C9916',1)

 --Ahmed 08/07/2020
 --Update LabelEn in DocumentType
 update sales.DocumentType set LabelEn=N'Asset' where CodeType = 'A-PU'
 update sales.DocumentType set LabelEn=N'Asset' where CodeType = 'A-SA'
 update sales.DocumentType set LabelEn=N'Admission vouchers' where CodeType = 'BE-PU'
 update sales.DocumentType set LabelEn=N'Quotation' where CodeType ='B-PU' 
 update sales.DocumentType set LabelEn=N'BS-SA' where CodeType = 'BS-SA'
 update sales.DocumentType set LabelEn=N'Receipt' where CodeType = 'D-PU'
 update sales.DocumentType set LabelEn=N'Delivery form' where CodeType = 'D-SA'
 update sales.DocumentType set LabelEn=N'Purchase invoice' where CodeType = 'FO-PU'
 update sales.DocumentType set LabelEn=N'Client invoice asset' where CodeType = 'IA-SA'
 update sales.DocumentType set LabelEn=N'Invoice' where CodeType = 'I-PU'
 update sales.DocumentType set LabelEn=N'Invoice' where CodeType = 'I-SA'
 update sales.DocumentType set LabelEn=N'Order' where CodeType = 'O-PU'
 update sales.DocumentType set LabelEn=N'Order' where CodeType = 'O-SA'
 update sales.DocumentType set LabelEn=N'Price requests' where CodeType = 'Q-PU'
 update sales.DocumentType set LabelEn=N'Quotation' where CodeType = 'Q-SA'
 update sales.DocumentType set LabelEn=N'Purchase requests' where CodeType = 'RQ-PU'

-- update templateNameFr and TemplateNameEn in Table ReportTemplate 
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_en' where Id= 2
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 3
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 4
update ERPSettings.ReportTemplate set TemplateNameFr=N'purchasedeliveryreport_fr', TemplateNameEn=N'purchasedeliveryreport_fr' where Id= 5
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 6
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 7
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 8
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 9
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 10
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 11
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 12
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 13
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 14
update ERPSettings.ReportTemplate set TemplateNameFr=N'report_be_bs_fr', TemplateNameEn=N'report_be_bs_en' where Id= 15
update ERPSettings.ReportTemplate set TemplateNameFr=N'report_be_bs_fr', TemplateNameEn=N'report_be_bs_en' where Id= 16
update ERPSettings.ReportTemplate set TemplateNameFr=N'genericDocumentReport_fr', TemplateNameEn=N'genericDocumentReport_fr' where Id= 17

--09/07/2020 Ahmed 
update ERPSettings.RoleConfig set IsDeleted=0 where Id=100042

--- Donia add password change role config 20/07/2020
BEGIN TRANSACTION
 INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
 (N'fd671f2f-5b91-4de3-9a07-997b4a3c8477', N'Password_settings', 4, N'Modifier tous les mots de passe', N'Change all passwords', NULL, NULL, NULL, NULL, N'/User', 0, N'Password_settings')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101094, N'Password_Settings', N'Changer tous les mots de passe', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101094, N'fd671f2f-5b91-4de3-9a07-997b4a3c8477', 1)
INSERT INTO [ERPSettings].[Module] ([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564655242D',N'UserConfig',null, 12,	N'parametre Utilisateur',N'User Config',	NULL,	NULL,	NULL,	NULL,	NULL,	1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F99-14564655242D', 101094, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c5899', N'fd671f2f-5b91-4de3-9a07-997b4a3c8477', N'51BF3865-133E-4E97-9F99-14564655242D')
COMMIT TRANSACTION
--20/07/2020 Ahmed ( stabilisation rôle)

SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfigCategory ([Id],[Code],[Label],[TranslationCode],[IsDeleted],[TransactionUserId],[Deleted_Token]) values 
(100402,N'STARKDRIVE',N'Starkdrive',N'STARKDRIVE',0,null,null)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101092,N'Starkdrive',N'Starkdrive',0,null, 100402)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

update ERPSettings.RoleConfig set Code= N'Responsable_RH' where Id=100002
update ERPSettings.RoleConfig set Code= N'Responsable_PAY' where Id=100003
update ERPSettings.RoleConfig set Code= N'Employe_Read_Write' where Id= 101014
update ERPSettings.RoleConfig set Code= N'Employe_Read' where Id=101015

update ERPSettings.RoleConfig set RoleName= N'Employé avec Modification' where Id= 101014
update ERPSettings.RoleConfig set RoleName= N'Employé sans Modification' where Id=101015

update ERPSettings.RoleConfig set Code= N'Session_Paie' where Id=101011
update ERPSettings.RoleConfig set Code= N'Ordre_Virement' where Id=101012
update ERPSettings.RoleConfig set Code= N'Déclaration_CNSS' where Id= 101013
update ERPSettings.RoleConfig set Code= N'Déclaration_Employeur' where Id=101019
update ERPSettings.RoleConfig set Code= N'Retenue_Source' where Id=101045

SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfigCategory ([Id], [Code],[Label],[TranslationCode],[IsDeleted],[TransactionUserId],[Deleted_Token]) values 
(100403, N'G. de carrières',N'G. de carrières',N'Career Management',0,null,null)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102104,N'Gestion_Carrieres',N'Gestion de carriéres',0,null, 100403)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c8777', N'Gestion_Carr_Func', 4, N'Gestion de carriéres', N'Gestion de carriéres', NULL, NULL, NULL, NULL, N'/Carriéres', 0, N'Gestion_Carr_Func')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 102104, N'fd671f2f-5b91-4de3-9a07-337b4a3c8777', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564643777D',N'Gestion_Carrieres',NULL, 12,	N'Gestion de carriéres',N'Gestion de carriéres',	NULL,	NULL,	NULL,	NULL,	NULL,	1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F99-14564643777D', 102104, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c7779', N'fd671f2f-5b91-4de3-9a07-337b4a3c8777', N'51BF3865-133E-4E97-9F99-14564643777D')

update ERPSettings.RoleConfig set RoleName=N'Réclamation' where Id= 88888

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c8436', N'STARK_DRIVE', 4, N'Starkdrive', N'Starkdrive', NULL, NULL, NULL, NULL, N'/Starkdrive', 0, N'STARK_DRIVE')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101092, N'fd671f2f-5b91-4de3-9a07-337b4a3c8436', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564643332D',N'Starkdrive',NULL, 12,	N'Starkdrive',N'Starkdrive',	NULL,	NULL,	NULL,	NULL,	NULL,	1)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F99-14564643332D', 101092, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c3339', N'fd671f2f-5b91-4de3-9a07-337b4a3c8436', N'51BF3865-133E-4E97-9F99-14564643332D')

--le 21/07/2020 Ahmed 
 -- Mailing settings 
 SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101100,N'Mailing_settings',N'Paramétrage mailing',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c8123', N'Mailing_Config', 4, N'Mailing', N'Mailing', NULL, NULL, NULL, NULL, N'/Mailing', 0, N'Mailing_Config')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101100, N'fd671f2f-5b91-4de3-9a07-337b4a3c8123', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564649992D',N'Mailing',NULL, 12,N'Mailing',N'Mailing',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564649992D', 101100, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c9999', N'fd671f2f-5b91-4de3-9a07-337b4a3c8123', N'51BF3865-133E-4E97-9F99-14564649992D')

update ERPSettings.RoleConfig set Code =N'Contrat_prestation' where Id = 101018

--- Donia update timesheet entity and add information  of add timesheet comment 23/07/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Entity] SET [EntityName]=N'TimeSheet', [TableName]=N'TimeSheet', [Fr]=N'TimeSheet', [Ar]=N'TimeSheet', [En]=N'TimeSheet', [De]=N'TimeSheet', [Ch]=N'TimeSheet', [Es]=N'TimeSheet' WHERE [Id]=396
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501241, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/rh/timesheet', N'{CREATOR}  a ajouté un commentaire pour votre CRA', N'{CREATOR} has added a note to your timesheet', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_COMMENT_TIMESHEET', N'ADD_COMMENT_TIMESHEET')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION
--- 23/07/2020 Amine Ben Ayed 
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList])
VALUES (N'589d24dd-72de-4588-9891-a620c2409e29', N'Payroll History', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 1, N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'icon-note', 1)


--- Add functionnalities 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'95020697-9168-48f1-9d67-cf8b18a8f367', N'PayrollHistory-ADD', 1, N'PayrollHistory-ADD', N'PayrollHistory-ADD', NULL, NULL, NULL, NULL,NULL, 1, N'PayrollHistory-ADD')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', N'PayrollHistory-UPDATE', 1, N'PayrollHistory-UPDATE', N'PayrollHistory-UPDATE', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-UPDATE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'7eb32a97-5057-42bd-8978-bf4b34333345', N'PayrollHistory-DELETE', 1, N'PayrollHistory-DELETE', N'PayrollHistory-DELETE', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-DELETE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', N'PayrollHistory-SHOW', 1, N'PayrollHistory-SHOW', N'PayrollHistory-SHOW', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-SHOW')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'11a54559-a008-4bd7-9ace-05a0840bc70e', N'PayrollHistory-LIST', 1, N'PayrollHistory-LIST', N'PayrollHistory-LIST', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-LIST')

--- Add link between modules and functionnalities
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'353f270f-a977-4ed5-9f25-675f1b209408', N'95020697-9168-48f1-9d67-cf8b18a8f367', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'a13b020c-6e71-46e8-b8ad-0a8e99ff99a3', N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'837d4c5a-b308-4134-8ae7-ed2eba831f00', N'7eb32a97-5057-42bd-8978-bf4b34333345', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'e2a2bc76-6c25-4f78-ba8d-dcc4ff0fc5e6', N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'2afb089c-39f8-434c-ae46-47b8400d8ece', N'11a54559-a008-4bd7-9ace-05a0840bc70e', N'589d24dd-72de-4588-9891-a620c2409e29')


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101104, N'Historique de paie', N'Historique de paie', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1676, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1677, N'589d24dd-72de-4588-9891-a620c2409e29', 101104, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8206, 101104, N'11a54559-a008-4bd7-9ace-05a0840bc70e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8207, 101104, N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8208, 101104, N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8209, 101104, N'7eb32a97-5057-42bd-8978-bf4b34333345', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8210, 101104, N'95020697-9168-48f1-9d67-cf8b18a8f367', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] ON
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (1048, 101104, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (1121, 101104, 100002, 1, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] OFF

-- 23/07/2020 Ahmed
--production 
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfigCategory ([Id], [Code],[Label],[TranslationCode],[IsDeleted],[TransactionUserId],[Deleted_Token]) values 
(100404, N'Production',N'Production',N'Manufacturing',0,null,null)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
 SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101101,N'Manufacturing_Config',N'Gestion de production',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', N'Production_Config', 4, N'Production', N'Manufacturing', NULL, NULL, NULL, NULL, N'/Manufacturing', 0, N'Production_Config')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101101, N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564645642D',N'Manufacturing',NULL, 12,N'Manufacturing',N'Manufacturing',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564645642D', 101101, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c1234', N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', N'51BF3865-133E-4E97-9F99-14564645642D')


-- production settings 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101103,N'Manufacturing_Settings',N'Paramétrage de production',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', N'Manufacturing_Settings_func', 4, N'Production', N'Manufacturing', NULL, NULL, NULL, NULL, N'/Manufacturing', 0, N'Production_Config_func')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101103, N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564688632D',N'Manufacturing',NULL, 12,N'Production',N'Manufacturing',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564688632D', 101103, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c8983', N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', N'51BF3865-133E-4E97-9F99-14564688632D')

--ecommerce 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101102,N'Ecommerce_Config',N'Gestion E-commerce',0,null, 100007)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', N'Ecommerce', 4, N'Ecommerce', N'Ecommerce', NULL, NULL, NULL, NULL, N'/Ecommerce', 0, N'Ecommerce')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564687942D',N'Ecommerce',NULL, 12,N'Ecommerce',N'Ecommerce',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564687942D', 101102, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c8965', N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', N'51BF3865-133E-4E97-9F99-14564687942D')


--24/07/2020 Ahmed
-- Supp document for purchase 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102101,N'Delete_Document_Purchase',N'Supprimer un document',0,null, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Purchase', 4, N'Supprimer un document', N'Selete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Purchase')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102101, N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-11564687942D',N'Del-Document_pu',NULL, 12,N'supprimer document',N'delete document',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-11564687942D', 102101, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-811b4a3c8965', N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', N'51BF3865-133E-4E97-9F99-11564687942D')


-- Supp document for sales 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102102,N'Delete_Document_sales',N'Supprimer un document',0,null, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Sales', 4, N'Supprimer un document', N'Delete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Sales')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102102, N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-33564687942D',N'Del-Document_sa',NULL, 12,N'supprimer document',N'delete document',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-33564687942D', 102102, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-833b4a3c8965', N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', N'51BF3865-133E-4E97-9F99-33564687942D')


-- Supp document for Stock correction 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102103,N'Delete_Document_stock',N'Supprimer un document',0,null, 100100)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Stock', 4, N'Supprimer un document', N'Delete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Stock')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102103, N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227942D',N'Del-Document_st',NULL, 12,N'supprimer document',N'delete document',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227942D', 102103, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7765', N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', N'51BF3865-133E-4E97-9F99-10562227942D')






 

