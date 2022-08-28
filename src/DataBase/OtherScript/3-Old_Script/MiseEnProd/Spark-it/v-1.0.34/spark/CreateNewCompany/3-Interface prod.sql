---- Item interface
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[InputComponent] SET [ng_change]=N'' WHERE [IdComponent]=N'7ed5a708-dfab-4d7e-af71-78ac5f1423e8'
UPDATE [ERPSettings].[InputComponent] SET [ng_change]=N'' WHERE [IdComponent]=N'819b000d-7145-4656-8fee-765876d04345'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'16206a93-7296-4f65-a447-6a6ff2a8162f'
UPDATE [ERPSettings].[Component] SET [rank]=5 WHERE [IdComponent]=N'1636a4b1-8bce-4b4e-821e-380ec9fea97f'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'17897ace-e300-48b3-8251-ea9c89d2fbef'
UPDATE [ERPSettings].[Component] SET [rank]=2, [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'238c6e92-ba4d-4c0d-8c36-d98601b561a0'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'3f13b9ee-8dbb-464f-9214-80d71fd7da43'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'42c08fbc-9240-4f18-a46b-68b41aea8638'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'5c194e2a-2049-4a77-ba10-349827259c14'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'647bf22f-43cb-4ba0-bda0-3ecd5e1272a1'
UPDATE [ERPSettings].[Component] SET [rank]=2, [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'64bfe185-f36d-4a7d-ade9-00b150019295'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'6f31ed36-b3f4-4c53-9642-c63072fbcec1'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'7ccc2051-b623-4dc5-b663-8a4cff49e1d8'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'7ed5a708-dfab-4d7e-af71-78ac5f1423e8'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'819b000d-7145-4656-8fee-765876d04345'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'86fa655c-6202-4762-915d-57479875ae40'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'979b95e2-a4f8-4509-8d6c-5b1d9884e53c'
UPDATE [ERPSettings].[Component] SET [ng_hide]=N'true' WHERE [IdComponent]=N'a05b46ea-7a1c-4753-b19c-24a41a5d95ad'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'a0f7fa5e-953f-4795-b1ad-eb5d5ea8e2b4'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'col-lg-12 col-md-12 col-sm12' WHERE [IdComponent]=N'a1ee8f0c-077b-45e3-a61a-53b423e1b991'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'a2f1c4b1-80f7-47f9-86e9-d5593978770a'
UPDATE [ERPSettings].[Component] SET [ng_hide]=N'true' WHERE [IdComponent]=N'a690441d-46d9-4835-a7e6-66b45c2a2c7e'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'ba0a3747-5939-445d-9263-48af42db6040'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'be057927-ab21-4796-ad09-40df2c910af6'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'c2b20fbf-5ea8-44d1-81df-86a08deb74ff'
UPDATE [ERPSettings].[Component] SET [rank]=5 WHERE [IdComponent]=N'dda18337-709c-49a0-afe3-3ba3af4a389a'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-5 col-md-5 col-sm-5' WHERE [IdComponent]=N'de48bc52-8a77-4374-a0cb-5dad678e1a63'
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- Interface Tiers
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'ac13646e-198f-4815-912a-745b854ae3c8', [classDiv]=N'form-group col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'198829ac-b44c-4e59-baf0-123db283abe1'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'32f33455-c946-4395-b0b6-455cb3ca4b47'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'583beedf-d92b-40c1-aaa1-61371fb3361c'
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'd3de77ea-e71b-4ee6-ae2e-9853f9c7b2c7', [classDiv]=N'form-group col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'6068b84b-2f5a-46ee-9877-d32f8adec279'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'71f69d49-d086-45d2-95d4-d79889e7bd98'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'7324086e-77f7-45ee-8414-a857bd136228'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'c0b1c63d-1bb8-43c4-81f5-1882a85fe7be'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'c755305c-93ea-455c-9cdc-9aec6183341e'
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'a6371619-0b55-45be-88d4-b772cd1670ff', [classDiv]=N'form-group col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'cd1619d3-f0e8-40dc-a0a8-008b4bc14198'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'd1685877-3b0e-4b06-8d6d-87fbb7f2c40e'
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'145dd732-4b4c-444e-90e5-f4ea5cc196f4', [classDiv]=N'form-group col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'dde3298d-63d4-4e6f-b966-68f226b54fb2'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'e435e412-5e78-4ece-8435-3732ccb539b1'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'ec3e8b48-9c94-41c8-8d0b-79c619900241'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'f9015eb5-7efe-4504-b13d-771b3873f6d4'
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- Interface Tarifs
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ViewConfigurationRole_ViewConfiguration]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ViewConfigurationRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Module] SET [FR]=N'Contrats', [EN]=N'Contract' WHERE [IdModule]=N'3545d556-108a-4d68-9c99-afc572ba34df'
UPDATE [ERPSettings].[Component] SET [ng_hide]=N'true' WHERE [IdComponent]=N'09b3029d-3318-40a3-81b6-e75b2b7ef9cb'
UPDATE [ERPSettings].[Component] SET [rank]=1, [IdComponentParent]=N'09b3029d-3318-40a3-81b6-e75b2b7ef9cb' WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
UPDATE [ERPSettings].[Component] SET [ng_hide]=N'true' WHERE [IdComponent]=N'214bd037-4be5-4f62-b326-d566e1361abb'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'2ad8eac5-4e37-4d94-a91e-c70c74b455bc'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'30cf30a6-8000-4e55-95a1-d11ee7897970'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'311b022f-2e18-4e4d-afda-f55061e85f42'
UPDATE [ERPSettings].[Component] SET [rank]=2, [IdComponentParent]=N'4ebaa5c0-e204-4591-83d3-efeba91c610d', [classDiv]=N'col-lg-4 col-md-4 col-sm-4', [style]=N'min-height: 230px;' WHERE [IdComponent]=N'39c5bdef-5252-464b-9a00-e02f04297291'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'40512428-e6a2-47f6-8644-025a1220cbaf'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'43427400-65bc-439c-b3a9-4afb28e0d1e8'
UPDATE [ERPSettings].[Component] SET [IdComponentParent]=N'bce3c87f-9170-40eb-80c4-1a2b86f4119f' WHERE [IdComponent]=N'492b2153-e104-40e4-955f-8dd3c7e472e0'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'4db5b01c-8c01-49ca-a9c4-3e6c57326cc9'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'57a98472-7f4a-4346-b253-f06cba54bdbc'
UPDATE [ERPSettings].[Component] SET [FR]=N'Ajouter contrat', [EN]=N'Add contract', [classDiv]=N'col-lg-8 col-md-8 col-sm-8' WHERE [IdComponent]=N'639a8c46-4769-41ba-a4f2-d052558c7b8c'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'6acf0f04-eb9f-42f0-9f5f-d3e28f25cab9'
UPDATE [ERPSettings].[Component] SET [rank]=1, [classDiv]=N'col-lg-8 col-md-8 col-sm-8' WHERE [IdComponent]=N'6da70dcb-c6c1-4611-9c84-599e382a60b1'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'6eb3a9f5-8c2a-4d21-aa8f-919d556b8f80'
UPDATE [ERPSettings].[Component] SET [rank]=1, [IdComponentParent]=N'214bd037-4be5-4f62-b326-d566e1361abb' WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'77342fe7-a91b-425c-8961-59d17c24a00c'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'79ebf858-757f-43f3-ad69-5592250e7159'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'7a896de4-a378-4068-a16d-556acd7a8a18'
UPDATE [ERPSettings].[Component] SET [rank]=2, [IdComponentParent]=N'60d15fec-ac39-44e5-af23-3217c4dee4a2' WHERE [IdComponent]=N'7b7fad15-d681-49bf-a5a2-9939e2900fb0'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'col-lg-4 col-md-4 col-sm-4' WHERE [IdComponent]=N'89715d97-b63d-413f-b861-6da661b8d042'
UPDATE [ERPSettings].[Component] SET [IdComponentParent]=N'b6002e06-421b-47fd-a79f-5129f272ead0' WHERE [IdComponent]=N'98bccf79-b489-41b1-b73b-d30262308dde'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'col-lg-4 col-md-4 col-sm-4' WHERE [IdComponent]=N'9efb312c-2f44-4a4f-8617-d47c22831b78'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'b6002e06-421b-47fd-a79f-5129f272ead0'
UPDATE [ERPSettings].[Component] SET [rank]=1, [IdComponentParent]=N'60d15fec-ac39-44e5-af23-3217c4dee4a2' WHERE [IdComponent]=N'b7f831fb-220d-414d-9aa9-753190397fc3'
UPDATE [ERPSettings].[Component] SET [class]=N'col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'bce3c87f-9170-40eb-80c4-1a2b86f4119f'
UPDATE [ERPSettings].[Component] SET [rank]=1, [IdComponentParent]=N'9b29896d-ee1a-4193-90da-35f00ca567b1' WHERE [IdComponent]=N'bdc3cb67-9fa0-44fd-88a1-23fdefe376a4'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-6 col-md-6 col-sm-6' WHERE [IdComponent]=N'c2879f33-8f9c-45c9-be38-163fdf6a9ac2'
UPDATE [ERPSettings].[Component] SET [rank]=1, [classDiv]=N'col-lg-8 col-md-8 col-sm-8' WHERE [IdComponent]=N'c57699b0-97e1-4ae2-9eeb-2d7218b7429e'
UPDATE [ERPSettings].[Component] SET [FR]=N'Modifier contrat', [EN]=N'Update contract', [classDiv]=N'col-lg-8 col-md-8 col-sm-8' WHERE [IdComponent]=N'd05ae672-1ed1-4975-98a5-dbfc81a7186b'
UPDATE [ERPSettings].[Component] SET [FR]=N'Ajouter contrat', [EN]=N'Add contract' WHERE [IdComponent]=N'd438ba6c-f3af-40d9-87f3-0204dba6b9b2'
UPDATE [ERPSettings].[Component] SET [FR]=N'Liste des contrats', [EN]=N'Contracts list' WHERE [IdComponent]=N'e24fcfab-acf8-4cb2-b52e-4a58ad073217'
UPDATE [ERPSettings].[Component] SET [rank]=2, [IdComponentParent]=N'9b29896d-ee1a-4193-90da-35f00ca567b1' WHERE [IdComponent]=N'e5ac183a-cfa2-480e-83ce-759d5d075c5e'
UPDATE [ERPSettings].[Component] SET [rank]=2, [IdComponentParent]=N'f5f0f100-f81e-4578-a2e6-13e24cbaa8a3', [classDiv]=N'col-lg-4 col-md-4 col-sm-4', [style]=N'min-height: 230px;' WHERE [IdComponent]=N'e77c7845-78b9-4fe9-ba21-96788f853cb9'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'ebb36568-da82-4af4-b7bd-1df88124d35f'
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'60d15fec-ac39-44e5-af23-3217c4dee4a2', 4, N'DIV6', 9, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', N'c57699b0-97e1-4ae2-9eeb-2d7218b7429e', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'col-lg-12 col-md-12 col-sm-12', 0, NULL, N'Prices', NULL, N'true', 1, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'9b29896d-ee1a-4193-90da-35f00ca567b1', 4, N'DIV6', 9, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', N'6da70dcb-c6c1-4611-9c84-599e382a60b1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'col-lg-12 col-md-12 col-sm-12', 0, NULL, N'Prices', NULL, N'true', 1, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'9b29896d-ee1a-4193-90da-35f00ca567b1', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'60d15fec-ac39-44e5-af23-3217c4dee4a2', 1, 1, NULL, NULL, NULL)
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ViewConfigurationRole_ViewConfiguration] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ViewConfigurationRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- Bloc provisoire facture
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[ReportComponent] DROP CONSTRAINT [FK_ReportViewerComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5b683dd9-e331-4b5b-a9dc-f2bfebc042ef', 1, N'DocumentVarchar3', 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'96ec892e-6334-46c4-b222-0bcd36361acc', N'Période de prestation', N'Delivery period', NULL, NULL, NULL, NULL, N'a05e911d-0c78-4e30-a62a-d4e81e0a9f3e', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'8264252b-262c-4054-8297-e3f0ef616e99', 2, N'Provisoire', 17, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', N'2ca2efd5-2e7d-480b-9428-e601d672e249', N'Provisoire', N'Provisional', NULL, NULL, NULL, NULL, NULL, N'col-lg-12 col-md-12 col-sm-12', N'', N'col-lg-12 col-md-12 col-sm-12', 0, NULL, N'Document', NULL, NULL, 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'96ec892e-6334-46c4-b222-0bcd36361acc', 2, N'Provisoire', 17, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'08c1992b-0d09-41e7-9bdc-5593092a50ef', N'Provisoire', N'Provisional', NULL, NULL, NULL, NULL, NULL, N'col-lg-12 col-md-12 col-sm-12', N'', N'col-lg-12 col-md-12 col-sm-12', 0, NULL, N'Document', NULL, NULL, 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'9bf6adad-d626-4d0a-9e29-5407c0b48359', 2, N'DocumentVarchar2', 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'96ec892e-6334-46c4-b222-0bcd36361acc', N'N° marché', N'market number', NULL, NULL, NULL, NULL, N'a05e911d-0c78-4e30-a62a-d4e81e0a9f3e', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'b85a811e-5c68-4269-ab43-3e69b2c968a7', 1, N'DocumentVarchar3', 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', N'8264252b-262c-4054-8297-e3f0ef616e99', N'Période de prestation', N'Delivery period', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'e23139d9-078c-4688-94dc-d9fefed2e677', 2, N'DocumentVarchar2', 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', N'8264252b-262c-4054-8297-e3f0ef616e99', N'N° marché', N'market number', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'5b683dd9-e331-4b5b-a9dc-f2bfebc042ef', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''5b683dd9-e331-4b5b-a9dc-f2bfebc042ef'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'9bf6adad-d626-4d0a-9e29-5407c0b48359', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''9bf6adad-d626-4d0a-9e29-5407c0b48359'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'b85a811e-5c68-4269-ab43-3e69b2c968a7', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''b85a811e-5c68-4269-ab43-3e69b2c968a7'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'e23139d9-078c-4688-94dc-d9fefed2e677', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''e23139d9-078c-4688-94dc-d9fefed2e677'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'f354c784-fd75-4461-a59d-1a46ccb353ea', N'02da692f-3146-45ac-b857-618ae49a6e1d', N'DocumentLineTaxe', NULL, 0, NULL)
UPDATE [ERPSettings].[Component] SET [FR]=N'Période prestation' WHERE [IdComponent]=N'5b683dd9-e331-4b5b-a9dc-f2bfebc042ef'
UPDATE [ERPSettings].[Component] SET [FR]=N'Période prestation' WHERE [IdComponent]=N'b85a811e-5c68-4269-ab43-3e69b2c968a7'
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'04019a4f-4c08-430f-8564-80ee818d41e1', 4, N'DocumentVarchar8', 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'96ec892e-6334-46c4-b222-0bcd36361acc', N'Code Projet', N'Project Code', NULL, NULL, NULL, NULL, N'a05e911d-0c78-4e30-a62a-d4e81e0a9f3e', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'52da3708-9099-4176-a33f-63dcd91fd981', 3, N'DocumentVarchar7', 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'96ec892e-6334-46c4-b222-0bcd36361acc', N'Code BU', N'BU Code', NULL, NULL, NULL, NULL, N'a05e911d-0c78-4e30-a62a-d4e81e0a9f3e', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5dfa4ea6-203c-4c8a-9eae-7bdeb6ddfad4', 4, N'DocumentVarchar8', 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'c224eb69-d958-493d-a60d-6932444a94d4', N'Code Projet', N'Project Code', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'672c0edb-d4ff-42a1-b9d3-a9f63884ccc9', 3, N'DocumentVarchar7', 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', N'8264252b-262c-4054-8297-e3f0ef616e99', N'Code BU', N'BU Code', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6d51bac4-2f67-469f-8e16-6e47cddeeb8d', 1, N'DocumentVarchar3', 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'c224eb69-d958-493d-a60d-6932444a94d4', N'Période prestation', N'Delivery period', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'c224eb69-d958-493d-a60d-6932444a94d4', 2, N'Provisoire', 17, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'dbbf7d00-32ef-4035-81d0-a4bee72f19ac', N'Provisoire', N'Provisional', NULL, NULL, NULL, NULL, NULL, N'col-lg-12 col-md-12 col-sm-12', N'', N'col-lg-12 col-md-12 col-sm-12', 0, NULL, N'Document', NULL, NULL, 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd39ac35c-f408-4b4f-9f13-373811d55d67', 3, N'DocumentVarchar7', 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'c224eb69-d958-493d-a60d-6932444a94d4', N'Code BU', N'BU Code', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'ea8b90bc-ac36-49ed-8445-42c60e3d82e0', 4, N'DocumentVarchar8', 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', N'8264252b-262c-4054-8297-e3f0ef616e99', N'Code Projet', N'Project Code', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f8ad0ac7-e8e2-407e-8332-a845f711e59c', 2, N'DocumentVarchar2', 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'c224eb69-d958-493d-a60d-6932444a94d4', N'N° marché', N'market number', NULL, NULL, NULL, NULL, N'409b0259-04a3-4fe5-a455-3cdf18d08c6c', N'form-group col-lg-6 col-md-6 col-sm-6', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'Document', NULL, NULL, 1, N'a35adf1d-f4f6-494f-975a-0492fffa70db', NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'04019a4f-4c08-430f-8564-80ee818d41e1', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''04019a4f-4c08-430f-8564-80ee818d41e1'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'52da3708-9099-4176-a33f-63dcd91fd981', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''52da3708-9099-4176-a33f-63dcd91fd981'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'5dfa4ea6-203c-4c8a-9eae-7bdeb6ddfad4', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''5dfa4ea6-203c-4c8a-9eae-7bdeb6ddfad4'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'672c0edb-d4ff-42a1-b9d3-a9f63884ccc9', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''672c0edb-d4ff-42a1-b9d3-a9f63884ccc9'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'6d51bac4-2f67-469f-8e16-6e47cddeeb8d', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''6d51bac4-2f67-469f-8e16-6e47cddeeb8d'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'd39ac35c-f408-4b4f-9f13-373811d55d67', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''d39ac35c-f408-4b4f-9f13-373811d55d67'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'ea8b90bc-ac36-49ed-8445-42c60e3d82e0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''ea8b90bc-ac36-49ed-8445-42c60e3d82e0'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept]) VALUES (N'f8ad0ac7-e8e2-407e-8332-a845f711e59c', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''f8ad0ac7-e8e2-407e-8332-a845f711e59c'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ReportComponent]
    ADD CONSTRAINT [FK_ReportViewerComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- set purchase invoice date modifiable in update interface
BEGIN TRANSACTION
UPDATE [ERPSettings].[InputComponent] SET [ng_readonly]=0 WHERE [IdComponent]=N'f8392fe3-0527-425f-8028-d1dac3b667f7'
COMMIT TRANSACTION

BEGIN TRANSACTION
 
UPDATE [ERPSettings].[DropDownListDataSource] SET pageSize=32 ;
UPDATE [ERPSettings].[DropDownListOptions] SET height=200
 
COMMIT TRANSACTION


