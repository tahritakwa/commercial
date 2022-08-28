BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'4a7d7203-f6da-44f1-8e1b-3adacaef2821'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'93a998e3-2389-4ce2-ad0f-db3c8e7741f7'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'13c2d205-c89d-45c3-a6c5-fdb3e5a61540'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'6fa32f58-8fab-47a8-893a-904187366ea2'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'706e3770-8a99-46aa-b182-a7b527e14248'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'c8c1bbca-4bea-4c21-9a40-2fd4ecca0c5d'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'4a7d7203-f6da-44f1-8e1b-3adacaef2821'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'93a998e3-2389-4ce2-ad0f-db3c8e7741f7'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'4a7d7203-f6da-44f1-8e1b-3adacaef2821'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'93a998e3-2389-4ce2-ad0f-db3c8e7741f7'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'7b7fad15-d681-49bf-a5a2-9939e2900fb0'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'bdc3cb67-9fa0-44fd-88a1-23fdefe376a4'
DELETE FROM [ERPSettings].[CheckBoxComponent] WHERE [IdComponent]=N'b7f831fb-220d-414d-9aa9-753190397fc3'
DELETE FROM [ERPSettings].[CheckBoxComponent] WHERE [IdComponent]=N'e5ac183a-cfa2-480e-83ce-759d5d075c5e'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'4a7d7203-f6da-44f1-8e1b-3adacaef2821'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'7b7fad15-d681-49bf-a5a2-9939e2900fb0'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'93a998e3-2389-4ce2-ad0f-db3c8e7741f7'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'b7f831fb-220d-414d-9aa9-753190397fc3'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'bdc3cb67-9fa0-44fd-88a1-23fdefe376a4'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'e5ac183a-cfa2-480e-83ce-759d5d075c5e'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'1e58a518-ac2e-4653-a969-845ff819e959'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'4a7d7203-f6da-44f1-8e1b-3adacaef2821'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'6f46b48a-ec3b-4aad-af57-127762f54ac8'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'7b7fad15-d681-49bf-a5a2-9939e2900fb0'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'93a998e3-2389-4ce2-ad0f-db3c8e7741f7'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'b7f831fb-220d-414d-9aa9-753190397fc3'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'bdc3cb67-9fa0-44fd-88a1-23fdefe376a4'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'e5ac183a-cfa2-480e-83ce-759d5d075c5e'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'492b2153-e104-40e4-955f-8dd3c7e472e0'
UPDATE [ERPSettings].[Component] SET [rank]=5 WHERE [IdComponent]=N'815de775-c7bf-4282-8f7f-2bb573e845cb'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'98bccf79-b489-41b1-b73b-d30262308dde'
UPDATE [ERPSettings].[Component] SET [rank]=5 WHERE [IdComponent]=N'd64ab800-5e88-41b1-8b89-2c20929a863f'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'50dfef5c-9b13-4441-a822-f983e15dd7cd'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'84caf570-ae84-4b75-afe7-12793753c5fb'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'86a9c344-43f1-4a45-9c40-4daeb255b6e0'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'abfbaa05-cb04-48bb-b9d4-e74ca5e0c425'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'ecb7c06e-2d11-4b32-b9ff-0845f56269ec'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'f735fb6e-ef8d-4f5b-9f2e-e2335019d418'
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION