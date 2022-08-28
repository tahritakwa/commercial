BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6DF8B929-CC7E-47D4-9BC3-5C795140C6F9',N'Tiers-DROPDOWNLIST',1021,NULL,NULL,NULL,NULL,NULL,NULL,N'/divers/diversfunctionalities/dropdownlist',1,N'DROPDOWNLIST-Tiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'03ce07cd-f814-499f-82b7-1f0404328b63', N'Employee-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Employee', NULL, NULL, NULL, NULL, NULL, N'/payroll/employee/dropdownlist', 1, N'DROPDOWNLIST-Employee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'11ab7a69-a705-4f46-8821-9bb3b7815a98', N'SalaryStructure-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/salarystructure/dropdownlist', 1, N'DROPDOWNLIST-SalaryStructure')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'248be8c8-6ac0-4f40-a72d-ee946afba9af', N'Warehouse-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Warehouse', NULL, NULL, NULL, NULL, NULL, N'/stock/warehouse/dropdownlist', 0, N'DROPDOWNLIST-Warehouse')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2913a29a-35b4-4f14-9b4f-34c13879ef63', N'Brand-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Brand', NULL, NULL, NULL, NULL, NULL, N'/stock/brand/dropdownlist', 0, N'DROPDOWNLIST-Brand')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'376cbf30-280f-4ae0-af13-129d1cd02aca', N'Skills-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/skills/dropdownlist', 1, N'DROPDOWNLIST-Skills')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3820fb92-f9bb-4c15-9a7f-279f97c68184', N'Candidacy-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/rh/candidacy/dropdownlist', 1, N'DROPDOWNLIST-Candidacy')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'430759b9-c9c2-4d57-8812-94b07d8271c5', N'SubFamily-DROPDOWNLIST', 1021, N'DROPDOWNLIST-SubFamily', NULL, NULL, NULL, NULL, NULL, N'/stock/subfamily/dropdownlist', 1, N'DROPDOWNLIST-SubFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'45071ef7-21bd-483b-9b88-9711dcab397f', N'DiversFunctionalities-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Tiers', NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/dropdownlist', 0, N'DROPDOWNLIST-Tiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5084a806-f1f9-4753-a856-5a82c1f8a54a', N'Job-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/job/dropdownlist', 1, N'DROPDOWNLIST-Job')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5e347146-ca72-41be-afdd-2d18472ff62f', N'Nature d''article-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Nature', NULL, NULL, NULL, NULL, NULL, N'/administration/nature d''article/dropdownlist', 0, N'DROPDOWNLIST-Nature')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6088d17b-f162-42a5-9818-f41ee5e0d16a', N'Currency-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Currency', NULL, NULL, NULL, NULL, NULL, N'/administration/currency/dropdownlist', 0, N'DROPDOWNLIST-Currency')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', N'Unite de mesure-DROPDOWNLIST', 1021, N'DROPDOWNLIST-MeasureUnit', NULL, NULL, NULL, NULL, NULL, N'/administration/unite de mesure/dropdownlist', 0, N'DROPDOWNLIST-MeasureUnit')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'71570f9c-c72a-4608-bf35-bb9adf44ef36', N'Expense-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/sales/expense/dropdownlist', 1, N'DROPDOWNLIST-Expense')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7bb9080b-247e-4a3d-b459-619677e19263', N'City-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/administration/city/dropdownlist', 1, N'DROPDOWNLIST-City')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7cd7b0b7-e644-417e-87b9-cc0281e90027', N'Contact-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/dropdownlist', 1, N'DROPDOWNLIST-Contact')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7d159002-e21e-4829-87de-346273d5eccb', N'SkillsFamily-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/skillsfamily/dropdownlist', 1, N'DROPDOWNLIST-SkillsFamily')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8403df7d-3348-400b-9946-f9f86614a4dc', N'PaymentType-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/dropdownlist', 1, N'DROPDOWNLIST-PaymentType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', N'SubModel-DROPDOWNLIST', 1021, N'DROPDOWNLIST-SubModel', NULL, NULL, NULL, NULL, NULL, N'/stock/submodel/dropdownlist', 1, N'DROPDOWNLIST-SubModel')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'928fb421-b72d-42d3-abf1-d310cdd8e790', N'Cnss-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/cnss/dropdownlist', 1, N'DROPDOWNLIST-Cnss')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'97cd0360-554d-411e-98f4-21874b3396e2', N'Taxe-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/administration/taxe/dropdownlist', 1, N'DROPDOWNLIST-Taxe')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9a9c9328-c381-48e9-9670-347caeea1761', N'Bonus-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/bonus/dropdownlist', 1, N'DROPDOWNLIST-Bonus')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ac4698dc-57d6-4952-a284-e7120e4d7eba', N'Family-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Family', NULL, NULL, NULL, NULL, NULL, N'/stock/family/dropdownlist', 0, N'DROPDOWNLIST-Family')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', N'LeaveType-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/leavetype/dropdownlist', 1, N'DROPDOWNLIST-LeaveType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b31317ba-1511-4be8-8778-e741d2803d16', N'InterviewType-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, N'', N'/rh/interviewtype/dropdownlist', 1, N'DROPDOWNLIST-InterviewType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', N'Team-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/team/dropdownlist', 1, N'DROPDOWNLIST-Team')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bb3c8465-744e-4995-b231-6714a5d25df9', N'Country-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Country', NULL, NULL, NULL, NULL, NULL, N'/administration/country/dropdownlist', 1, N'DROPDOWNLIST-Country')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bfc987ff-e9e0-4786-8bcf-557424b597b2', N'ModelOfItem-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/stock/modelofitem/dropdownlist', 1, N'DROPDOWNLIST-ModelOfItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', N'Grade-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/grade/dropdownlist', 1, N'DROPDOWNLIST-Grade')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', N'QualificationType-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, N'', N'/payroll/qualificationtype/dropdownlist', 1, N'DROPDOWNLIST-QualificationType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', N'Active-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, N'', N'/immobilisation/active/dropdownlist', 1, N'DROPDOWNLIST-Active')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eca3ffb8-c1fb-4212-a543-a04e9e396784', N'Category-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/immobilisation/category/dropdownlist', 1, N'DROPDOWNLIST-Category')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'edb77114-1960-4772-88a3-e32307dcf0a9', N'Item-DROPDOWNLIST', 1021, N'DROPDOWNLIST-Item', NULL, NULL, NULL, NULL, NULL, N'/stock/item/dropdownlist', 1, N'DROPDOWNLIST-Item')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb4545fb-c741-428f-87eb-afee3bf38e7a', N'Dropdown-LIST', 1, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/LIST-Dropdown/list', 0, N'LIST-Dropdown')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', N'Claim-DROPDOWNLIST', 1021,  N'DROPDOWNLIST-Claim', NULL, NULL, NULL, NULL, NULL, N'/helpdesk/claims/dropdownlist', 0, N'DROPDOWNLIST-Claim')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'94329f27-c3bd-45ab-8e06-60e4a0199878', N'ClaimType-DROPDOWNLIST', 1021,  N'DROPDOWNLIST-ClaimType', NULL, NULL, NULL, NULL, NULL, N'/helpdesk/claimstype/dropdownlist', 0, N'DROPDOWNLIST-ClaimType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', N'ClaimStatus-DROPDOWNLIST', 1021,  N'DROPDOWNLIST-ClaimStatus', NULL, NULL, NULL, NULL, NULL, N'/helpdesk/claimsstatus/dropdownlist', 0, N'DROPDOWNLIST-ClaimStatus')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9a7ce61c-1fb9-4a49-bc77-131cb37028ef', N'6DF8B929-CC7E-47D4-9BC3-5C795140C6F9', N'D438FBAD-7305-4DAD-AB44-A4FB84318A83')

SET IDENTITY_INSERT [ERPSettings].[RequestType] ON
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1021, N'DROPDOWNLIST', N'form.html', NULL, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RequestType] OFF

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0549c9b5-c162-4422-a30f-7073b56ee3d5', N'7d159002-e21e-4829-87de-346273d5eccb', N'38a92b23-2180-4497-ba96-0fe49758074f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0c544299-cd92-4b5e-bc09-fc638334060a', N'03ce07cd-f814-499f-82b7-1f0404328b63', N'2f7d95d8-883a-445e-9ec2-3c4a70854f68')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'130faf3d-1811-4a10-91b8-e84e71418c83', N'9a9c9328-c381-48e9-9670-347caeea1761', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'162c8792-6779-469c-b14e-55f3eefd491a', N'6088d17b-f162-42a5-9818-f41ee5e0d16a', N'5eef2177-47d5-4780-b338-46e284f8ce4a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'226e41f2-25c8-45cc-9d79-283c22515b67', N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2882a5cb-0fa0-40d7-8e8b-28af8ea0e49f', N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', N'41b49c2f-ab23-4c77-af9c-2830a759fe6a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3b2e914d-79ed-43e6-a51e-f1c18d57e016', N'97cd0360-554d-411e-98f4-21874b3396e2', N'3a3ed20b-f313-4b1b-9879-a287af094ff0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'409018e2-5a50-4a09-aaf4-4441054f06eb', N'b31317ba-1511-4be8-8778-e741d2803d16', N'927010d6-12da-45af-9a65-a453d766cfcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'43865da9-3ef9-4247-8c68-048660667a05', N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', N'3f5ce072-55c8-485e-9a09-1f2f69c043e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'460e1fb4-7cb4-4beb-b77b-2886344427d7', N'71570f9c-c72a-4608-bf35-bb9adf44ef36', N'2bc26ad8-1542-4b1f-8fb0-659133434fc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5648c643-c541-4841-8e71-dc9cd09d680a', N'376cbf30-280f-4ae0-af13-129d1cd02aca', N'bef67db7-625d-41e7-99ae-e116177d04a1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5fa6396e-82b7-4564-9308-37fd0e75d6a8', N'5e347146-ca72-41be-afdd-2d18472ff62f', N'd02ccb30-71cf-4a57-8327-333be69e8af4')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'68b6dbb7-3aa2-442b-8468-24310c159d0e', N'2913a29a-35b4-4f14-9b4f-34c13879ef63', N'997d1f54-a483-4452-be25-3b9a9eab3884')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'727dafaa-6d2c-49e0-8cb2-bdf30728c80f', N'430759b9-c9c2-4d57-8812-94b07d8271c5', N'13446b5b-e1be-49d0-a0d4-332f7ab7febe')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7706ae71-6ced-499c-b23c-069cfa401872', N'45071ef7-21bd-483b-9b88-9711dcab397f', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8674e009-7990-45fc-bd9e-d6df588b3209', N'eca3ffb8-c1fb-4212-a543-a04e9e396784', N'159000fc-7090-48c5-bcc2-8e8cb688e8a9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8f234d6a-79f7-4919-8e1f-17d8f55d6ab2', N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', N'11503286-9245-41ee-a502-caa5ea9cf776')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a4d6ee68-dc8f-44fc-a91a-829054173f59', N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', N'ae298068-a632-40b3-b2d4-aa4636697160')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a913756b-4cf6-420c-ba40-38c723730a43', N'7bb9080b-247e-4a3d-b459-619677e19263', N'22b1f11f-8129-4128-ae3e-870d327bb4ae')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a9f1e06e-35e3-4cb2-928d-6d4e8f4606bc', N'248be8c8-6ac0-4f40-a72d-ee946afba9af', N'610782eb-cc27-4bde-b2be-b86878fecbdd')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'abafa6d9-857f-41b5-9805-d9dc40e3a753', N'8403df7d-3348-400b-9946-f9f86614a4dc', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b7abd0a8-d6c4-42fc-b311-cf21ce5645a0', N'928fb421-b72d-42d3-abf1-d310cdd8e790', N'dca0e118-de89-4b9d-a25b-08964a3856b9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b7f36245-c06e-42c5-945e-f3a145d01ca7', N'bfc987ff-e9e0-4786-8bcf-557424b597b2', N'14110ae1-17a1-446a-a3db-f893a04f4794')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bca225f8-8489-494b-823b-2131cf04164b', N'7cd7b0b7-e644-417e-87b9-cc0281e90027', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bd3b9991-72a1-4164-9047-5b56eaaafe60', N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', N'94a36607-432f-483b-aecf-8c0d3d19f47b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c7ac48ed-6e97-4ae4-a6db-df21e7e3bbf9', N'bb3c8465-744e-4995-b231-6714a5d25df9', N'22367de5-32f0-4fd7-9340-296c7879c03f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ccf29d9f-7b91-4d80-b880-56aa60e44ef1', N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', N'fa2ef934-cf6b-44e6-a15d-08f924a6d903')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd57ed706-2cc5-4636-bca7-64d27712c4c1', N'edb77114-1960-4772-88a3-e32307dcf0a9', N'0934b53e-48dd-4693-bca2-f6a5ce39b359')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dbb2c4ad-6e44-467a-8e0c-c095c3ad3b01', N'5084a806-f1f9-4753-a856-5a82c1f8a54a', N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e9ae68b5-9cbb-4a10-93e3-04a39764897e', N'ac4698dc-57d6-4952-a284-e7120e4d7eba', N'b678b40a-e499-4961-862b-eae2ecf7baef')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ef6b6201-bdae-48ee-9d98-953f71ed6446', N'3820fb92-f9bb-4c15-9a7f-279f97c68184', N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ff715751-d73e-47cb-8676-150b66f9e474', N'11ab7a69-a705-4f46-8821-9bb3b7815a98', N'd2343785-b0e5-4d87-8f03-78d62c876d43')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ae030640-504f-4d56-bcb0-7e5d1edac356', N'cb4545fb-c741-428f-87eb-afee3bf38e7a', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'02b8d2b6-625a-4ead-a232-1e55a34be35e', N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'85e15cfb-0b5a-493b-bb75-6baac2aa24b2', N'94329f27-c3bd-45ab-8e06-60e4a0199878', N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3916ad0a-739d-45ab-a866-03d6bd35632d', N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed')


ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


BEGIN TRANSACTION



ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]

ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]

ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', N'PayementMethod-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/payment/payementmethod/dropdownlist', 1, N'DROPDOWNLIST-PaymentMethod')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3bcef148-2199-422d-af71-4f0d59e7fcfd', N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988')

ALTER TABLE [ERPSettings].[FunctionnalityModule]

    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])

ALTER TABLE [ERPSettings].[FunctionnalityModule]

    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])

ALTER TABLE [ERPSettings].[Functionality]

    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])

COMMIT TRANSACTION

--Rabeb : add DROPDOWNLIST-Candidate functionality

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'128ce50b-5f62-443f-96b1-3b4351542998', N'Candidate-DROPDOWNLIST', 1021, NULL, NULL, NULL, NULL, NULL, NULL, N'/rh/candidate/dropdownlist', 1, N'DROPDOWNLIST-Candidate')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'902d39aa-dfaa-4d07-bb80-00396ecfa6dd', N'128ce50b-5f62-443f-96b1-3b4351542998', N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb')

ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION