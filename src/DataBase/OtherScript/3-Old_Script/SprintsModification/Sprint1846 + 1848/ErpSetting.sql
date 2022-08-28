---- Nihel : Add Api roles
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalesAsset' WHERE [IdFunctionality]=N'017a0e7d-7829-4326-bdb7-e285e7aae9bc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-OutputMovement' WHERE [IdFunctionality]=N'01bdc9eb-8f37-4b28-96f5-e661259e9291'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseInvoice' WHERE [IdFunctionality]=N'02268ec7-c879-47b8-b174-de3c359eff7a'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SupplierFinancialCommitment' WHERE [IdFunctionality]=N'0233afff-931a-48cc-86d9-c8a83b415efa'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalaryRule' WHERE [IdFunctionality]=N'05d45e13-6184-4085-b9b2-86015af49e11'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Supplier' WHERE [IdFunctionality]=N'06048d73-4dd8-42e1-b095-806c636ff9f0'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Payslip' WHERE [IdFunctionality]=N'06eb3687-d016-4597-9538-c1eaed785b50'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Customer' WHERE [IdFunctionality]=N'090a15ef-8766-435c-89a4-78aa54fda44d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Payslip' WHERE [IdFunctionality]=N'0acce7c4-1da6-4276-a199-a4db6270bfd7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SupplierSettlement' WHERE [IdFunctionality]=N'0b2784fb-2158-461f-a83c-08b221cea5c7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseDelivery' WHERE [IdFunctionality]=N'0c2413e5-e633-4d8f-94f8-56574ed1cc05'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalesAsset' WHERE [IdFunctionality]=N'0cca5b44-467a-4807-a0e0-d583c693d776'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalesDelivery' WHERE [IdFunctionality]=N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Taxe' WHERE [IdFunctionality]=N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-ConstantValue' WHERE [IdFunctionality]=N'12e2ecc5-d861-4680-9310-92422a3e2593'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Role' WHERE [IdFunctionality]=N'1370af42-416b-4af5-8416-d274643cc31b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalesAsset' WHERE [IdFunctionality]=N'1428c6ec-25d9-477d-ab4e-efae61b2377d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-OutputMovement' WHERE [IdFunctionality]=N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalesOrder' WHERE [IdFunctionality]=N'16cc4069-dc25-49d7-b272-dcfc28549301'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'Add-User' WHERE [IdFunctionality]=N'183e2cc9-2522-4463-9366-775781dcb127'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-BankAccount' WHERE [IdFunctionality]=N'1c753625-4561-4abf-aef9-7a92b01e481e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Settlement' WHERE [IdFunctionality]=N'1c969e3f-5fb9-42c1-8a39-8c84122aded1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Country' WHERE [IdFunctionality]=N'1fc23099-0aff-4d52-be49-9cbcba9405ab'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'REPORTING-Role' WHERE [IdFunctionality]=N'249ba7d6-26bc-43df-b75d-b568252cc2c9'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Currency' WHERE [IdFunctionality]=N'2589ba88-616e-4aff-b14f-ed468eed0549'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-DiscountGroupTiers' WHERE [IdFunctionality]=N'2719c551-cb62-45f0-8091-c595fccf11aa'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Item' WHERE [IdFunctionality]=N'2806f1cd-9742-4811-aff4-1ba3268ca6e2'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Taxe' WHERE [IdFunctionality]=N'28e36f79-bac9-4340-a942-95dc9888c9d0'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Warehouse' WHERE [IdFunctionality]=N'2b24a538-6ada-4cf2-8c38-69a13782bef4'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-TaxeGroupTiers' WHERE [IdFunctionality]=N'2e00c99b-cd88-41aa-8751-68402a23b014'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalesDelivery' WHERE [IdFunctionality]=N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Active' WHERE [IdFunctionality]=N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Currency' WHERE [IdFunctionality]=N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Nature' WHERE [IdFunctionality]=N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseOrder' WHERE [IdFunctionality]=N'30ed6b09-268f-4e07-9bdf-d003d7d32502'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-InventoryMovement' WHERE [IdFunctionality]=N'30fd5982-45d0-485c-a969-c672f21b7358'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Variable' WHERE [IdFunctionality]=N'322d8fea-9553-46c1-a83b-24276d046f53'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalaryRule' WHERE [IdFunctionality]=N'336fdb14-6186-41c2-b2ff-98c99ea25c5f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseAsset' WHERE [IdFunctionality]=N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-TransferMovement' WHERE [IdFunctionality]=N'34a0f7d3-7f88-4de8-8c29-a1827670a940'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Axis' WHERE [IdFunctionality]=N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Job' WHERE [IdFunctionality]=N'418d053d-d730-4577-8e25-77584384703e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-BankAccount' WHERE [IdFunctionality]=N'4248ba0b-646b-4525-a0a0-8713a10a608e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SettlementMode' WHERE [IdFunctionality]=N'42da2ebe-fb35-439a-92c5-f404c3e0a12d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Customer' WHERE [IdFunctionality]=N'441c0141-35ff-4233-9945-e797233f4fa4'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalesQuotation' WHERE [IdFunctionality]=N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Settlement' WHERE [IdFunctionality]=N'45b5e4ac-25c1-42a7-963d-2491b4d13ece'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseRequest' WHERE [IdFunctionality]=N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-TaxeType' WHERE [IdFunctionality]=N'4653a3cf-5480-49a3-af52-1ede7d7a5432'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseOrder' WHERE [IdFunctionality]=N'46e960cd-92c8-4657-b8f1-e066ed8005ff'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Grade' WHERE [IdFunctionality]=N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Employee' WHERE [IdFunctionality]=N'4915c87a-4c0a-4635-beb4-6626d46415c2'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Profile' WHERE [IdFunctionality]=N'4ad09cf5-9247-4970-9616-6e36bb2a40a5'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Prices' WHERE [IdFunctionality]=N'4b651a45-bf4c-48c8-97b7-333bb580b76e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-City' WHERE [IdFunctionality]=N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Groupe remise article' WHERE [IdFunctionality]=N'4e1a462a-70fd-4454-96f8-fe543bce337a'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseDelivery' WHERE [IdFunctionality]=N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-OutputMovement' WHERE [IdFunctionality]=N'504b7c8a-379b-45c7-9b44-6d825c30478b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SalesQuotation' WHERE [IdFunctionality]=N'5281d288-b1b4-4e3e-9a00-5d5ab4437019'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SalesDelivery' WHERE [IdFunctionality]=N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalesInvoice' WHERE [IdFunctionality]=N'5d007fd4-976f-4f44-b580-50a2afe0815f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Variable' WHERE [IdFunctionality]=N'5d854334-c1b7-48c8-8811-7a37ca16dc7b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalesQuotation' WHERE [IdFunctionality]=N'5f410902-9c3b-47db-b648-e154b97b09d6'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-InputMovement' WHERE [IdFunctionality]=N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Grade' WHERE [IdFunctionality]=N'5fa827e8-96a8-4020-9153-8755f3c3de93'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ContractServiceType' WHERE [IdFunctionality]=N'5fb337a9-70ec-46e2-a53e-9824ae05fd25'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-TransferMovement' WHERE [IdFunctionality]=N'621fe63b-cf18-454b-8404-e8bec47154b3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-InventoryMovement' WHERE [IdFunctionality]=N'63a7471e-ccea-4422-bc2b-c1acbf9066b3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseQuotation' WHERE [IdFunctionality]=N'646a1da2-f25a-4782-8430-a7c7e8762da3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SettlementMode' WHERE [IdFunctionality]=N'65e27bce-38e0-4497-b95a-39024db06652'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseRequest' WHERE [IdFunctionality]=N'66754c61-6ecd-44cf-9ae4-543635e0d460'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Axis' WHERE [IdFunctionality]=N'66b8d9f8-6043-4d79-b960-9265da657a3b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ImmoblisationCategory' WHERE [IdFunctionality]=N'6755075e-2096-45d5-9b09-48c50d51660f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SupplierSettlement' WHERE [IdFunctionality]=N'681c3f06-93ec-4d82-928a-21425d6dbb91'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Contract' WHERE [IdFunctionality]=N'68fec29f-1c31-4860-8e21-47e345398528'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'Profile-ChangePwd' WHERE [IdFunctionality]=N'6d1006f2-51ab-4aba-abc6-b597f28b1603'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalaryStructure' WHERE [IdFunctionality]=N'712d6299-495e-45ce-9010-20e4ad36834a'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Payslip' WHERE [IdFunctionality]=N'71a1d18f-85e1-4c77-ac51-fd731dcd925f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Prices' WHERE [IdFunctionality]=N'71b83b32-6e10-4bc8-978d-76b9ad44d135'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Taxe' WHERE [IdFunctionality]=N'72ab7a79-351b-4893-8b79-d4d03fa39b4b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseOrder' WHERE [IdFunctionality]=N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Role' WHERE [IdFunctionality]=N'7541f25b-34db-4ad5-a8ae-09d1dd558706'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-User' WHERE [IdFunctionality]=N'776d3e4e-c68b-43c3-a5a3-f91385bd6296'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Premium' WHERE [IdFunctionality]=N'78d5d270-ecd3-4013-a306-d881b94b0bdf'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-InputMovement' WHERE [IdFunctionality]=N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-ConstantRate' WHERE [IdFunctionality]=N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseInvoice' WHERE [IdFunctionality]=N'7ae52d61-2e8f-40c1-9b16-55a1b016a286'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Supplier' WHERE [IdFunctionality]=N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseQuotation' WHERE [IdFunctionality]=N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Customer' WHERE [IdFunctionality]=N'7efd7fbb-8ab1-4046-8267-753db514c23b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Tarifs' WHERE [IdFunctionality]=N'8016ffaf-96be-4810-8191-cd3fdbeb5399'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-MeasureUnit' WHERE [IdFunctionality]=N'81d9a081-25e0-40d7-866c-3ac1684c2424'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalaryStructure' WHERE [IdFunctionality]=N'831becf0-0744-4fe4-b79c-dec135cee846'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseInvoice' WHERE [IdFunctionality]=N'85e9bab0-c315-45b8-8922-51faeb4a7a9c'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseAsset' WHERE [IdFunctionality]=N'860db2d3-2007-4fe3-a622-96efaea97956'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-ZipCode' WHERE [IdFunctionality]=N'86894159-c1f3-44ab-bddc-a578289077a5'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SalesInvoice' WHERE [IdFunctionality]=N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Settlement' WHERE [IdFunctionality]=N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseAsset' WHERE [IdFunctionality]=N'88888a3e-9ecb-43d6-9fce-099336b2a534'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseDelivery' WHERE [IdFunctionality]=N'896b337d-445b-453a-b6ce-5a64bf11b65d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-City' WHERE [IdFunctionality]=N'8abd5fc1-be98-4340-bc15-25b76115782f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-TransferMovement' WHERE [IdFunctionality]=N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SaleSettings' WHERE [IdFunctionality]=N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalesDelivery' WHERE [IdFunctionality]=N'8e3189a1-c37a-4004-86bd-6c8189a9b764'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-MeasureUnit' WHERE [IdFunctionality]=N'926ed709-a911-4314-92c6-3ced80431915'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-InventoryMovement' WHERE [IdFunctionality]=N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-Settlement' WHERE [IdFunctionality]=N'93481abc-8bc8-4b26-b02b-d2eb935903d6'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-ImmoblisationCategory' WHERE [IdFunctionality]=N'9454ba64-87ca-4ffd-b497-bb8e5eea8639'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalaryRule' WHERE [IdFunctionality]=N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-User' WHERE [IdFunctionality]=N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-UserRight' WHERE [IdFunctionality]=N'97795e35-e1f6-4d05-afe3-6773afb2d254'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalesOrder' WHERE [IdFunctionality]=N'97dc1c97-a947-4171-95be-59fa23ac90dc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Nature' WHERE [IdFunctionality]=N'986a1121-10ba-40d0-8629-79768f5b4e89'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Contract' WHERE [IdFunctionality]=N'99916b67-3c87-4342-8eb1-8640d0d9efd1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-BankAccount' WHERE [IdFunctionality]=N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-ContractServiceType' WHERE [IdFunctionality]=N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseRequest' WHERE [IdFunctionality]=N'9e222535-8111-4ded-b5c0-2de91ae52e92'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-TaxeType' WHERE [IdFunctionality]=N'9ebcf470-1da4-4448-b8f5-41d5442849ae'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-InputMovement' WHERE [IdFunctionality]=N'9fcc79e1-fe21-4415-ad86-c35fcd318638'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SettlementMode' WHERE [IdFunctionality]=N'9ff9f2d1-8af0-4fac-a111-9acf84207453'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-InputMovement' WHERE [IdFunctionality]=N'a0fa8cb4-a958-4237-87c0-194c59f15a0c'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'VALIDATE-Role' WHERE [IdFunctionality]=N'a17f6c5f-71a4-4086-af06-43926cf30080'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-ConstantRate' WHERE [IdFunctionality]=N'a1ca4007-d64e-4765-af61-42e753a61222'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SalesAsset' WHERE [IdFunctionality]=N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SalesInvoice' WHERE [IdFunctionality]=N'a35adf1d-f4f6-494f-975a-0492fffa70db'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseDelivery' WHERE [IdFunctionality]=N'a4b6168d-3589-4dfa-8a92-523ac1d03d99'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PaymentMethod' WHERE [IdFunctionality]=N'a6192524-3d69-4a52-a92c-c564fc1baec5'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalaryStructure' WHERE [IdFunctionality]=N'a6c247bc-d584-43a3-b995-f303e3b13c77'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Role' WHERE [IdFunctionality]=N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Item' WHERE [IdFunctionality]=N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-ContractServiceType' WHERE [IdFunctionality]=N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseQuotation' WHERE [IdFunctionality]=N'aeb6253e-2532-4873-b8df-9ac559908658'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-City' WHERE [IdFunctionality]=N'af5d4af2-8810-4ba1-a628-003796357bfb'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Active' WHERE [IdFunctionality]=N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-TaxeGroupTiers' WHERE [IdFunctionality]=N'b0a20ad6-7b71-4d09-a25e-3e843f847335'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Premium' WHERE [IdFunctionality]=N'b19af782-0c9f-40b1-8228-6f6a603a0ca7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SettlementMode' WHERE [IdFunctionality]=N'b22348a4-a36e-4d01-b2e7-578697d4a8e9'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Warehouse' WHERE [IdFunctionality]=N'b3779102-6613-4722-b1dc-1dee85ba2064'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-SupplierSettlement' WHERE [IdFunctionality]=N'b6875160-0302-4d15-9bd9-3431e21aeb24'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseAsset' WHERE [IdFunctionality]=N'b7e30a6e-02bb-4b23-8762-a0121459bf94'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-ZipCode' WHERE [IdFunctionality]=N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Supplier' WHERE [IdFunctionality]=N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-MeasureUnit' WHERE [IdFunctionality]=N'ba0ec2b7-975f-4c09-bc72-194b78595bd9'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SalesQuotation' WHERE [IdFunctionality]=N'baaaea28-f16e-43d5-a4b5-a816cbcb1262'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-TransferMovement' WHERE [IdFunctionality]=N'baca0b66-1cfd-469f-8eed-5442857d76b5'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Grade' WHERE [IdFunctionality]=N'bb6ab79b-3279-487e-a321-d3deb8cba545'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'REPORTING-Administration' WHERE [IdFunctionality]=N'be0964a9-1fe6-4049-9fdc-254c8094b267'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PayementMethod' WHERE [IdFunctionality]=N'bf56f348-0a33-4ac2-ae63-5822a62a2123'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-InventoryMovement' WHERE [IdFunctionality]=N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PayementMethode' WHERE [IdFunctionality]=N'c1d44620-a496-4de0-895f-56066017a16f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-OutputMovement' WHERE [IdFunctionality]=N'c62e61c1-16ae-463c-8de8-fcc0516df031'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalesInvoice' WHERE [IdFunctionality]=N'c6e0724d-fc34-4235-b0fd-f5098312de8d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Nature' WHERE [IdFunctionality]=N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-DiscountGroupTiers' WHERE [IdFunctionality]=N'c80e6713-32ce-4c9d-ad80-704b460d0d55'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-TaxeGroupTiers' WHERE [IdFunctionality]=N'c93f50bd-2a63-4387-bf62-21098294bcc3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Job' WHERE [IdFunctionality]=N'cd30e343-60c3-4f7d-a566-72fe0718a90b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Notification' WHERE [IdFunctionality]=N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-SalesOrder' WHERE [IdFunctionality]=N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Item' WHERE [IdFunctionality]=N'd006adea-6c46-421a-96d6-2c90fc2b5679'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-PurchaseQuotation' WHERE [IdFunctionality]=N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Warehouse' WHERE [IdFunctionality]=N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-SalesOrder' WHERE [IdFunctionality]=N'd473bcce-1332-47fb-95a0-1bf7b479b5ae'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ZipCode' WHERE [IdFunctionality]=N'd604fb47-2f09-4a36-8ccc-b697fcbf3205'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Active' WHERE [IdFunctionality]=N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Job' WHERE [IdFunctionality]=N'd6b0b228-646a-47c9-a361-8efd57b2bd06'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ConstantValue' WHERE [IdFunctionality]=N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Currency' WHERE [IdFunctionality]=N'd779a487-38cd-4942-b8ea-bb16dc14c07e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-ConstantValue' WHERE [IdFunctionality]=N'd7c9f718-49fb-41e3-88a5-0197b286cd25'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-DiscountGroupItem' WHERE [IdFunctionality]=N'da6eb397-3885-493a-8a79-a63a8257b246'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Company' WHERE [IdFunctionality]=N'da8aecae-09e6-4f74-bfab-314673238ac1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-PurchaseOrder' WHERE [IdFunctionality]=N'dd748a92-303d-45fa-82c5-cb6697329f29'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseInvoice' WHERE [IdFunctionality]=N'df22e2e1-73df-459b-826b-630bf62e8394'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Country' WHERE [IdFunctionality]=N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-DiscountGroupItem' WHERE [IdFunctionality]=N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Premium' WHERE [IdFunctionality]=N'e456ef1c-a28d-42a7-8324-ab5448f9139b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-ImmobilisationCategory' WHERE [IdFunctionality]=N'e59dbc98-5393-4fc4-8996-c05fe4852558'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Pays' WHERE [IdFunctionality]=N'e5a6ccba-20d6-47db-b131-9c564f67a361'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ConstantRate' WHERE [IdFunctionality]=N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Axis' WHERE [IdFunctionality]=N'e7b3084b-711a-43e3-8ab6-a37af089281e'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Variable' WHERE [IdFunctionality]=N'e83a0045-89c6-459f-8d99-89c25077f4ef'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-DiscountGroupTiers' WHERE [IdFunctionality]=N'ed3a4a01-b363-4d81-9dd6-b736a3431293'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-SupplierSettlement' WHERE [IdFunctionality]=N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Contract' WHERE [IdFunctionality]=N'f2630114-6cf4-431d-99f4-a3c79dadd2af'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-ClientFinancialCommitment' WHERE [IdFunctionality]=N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-PurchaseRequest' WHERE [IdFunctionality]=N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-PurchaseSettings' WHERE [IdFunctionality]=N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-Employee' WHERE [IdFunctionality]=N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Notification' WHERE [IdFunctionality]=N'fb782972-bcd1-4f36-ba23-577b5e83363d'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-TaxeType' WHERE [IdFunctionality]=N'fc2da022-f055-48a0-9f91-643710950d43'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-Employee' WHERE [IdFunctionality]=N'fd418060-07ec-4e8a-8c50-705c2c224506'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/updateTiers' WHERE [IdServiceParameters]=N'1082ddad-ae39-4d95-8074-c0207c6f712b'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getListTiersWithPredicate' WHERE [IdServiceParameters]=N'24406d9b-6c36-4d40-b2cc-f7d3a10fe4a0'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/insertTiers' WHERE [IdServiceParameters]=N'275c9320-33ba-402d-85e3-56f6f1f6b67b'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/updateTiers' WHERE [IdServiceParameters]=N'2980eeb7-0cb8-44cf-9d80-4384c718c09c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getListTiersWithPredicate' WHERE [IdServiceParameters]=N'3d3854ca-f779-4f3c-9a66-6c6ed4684e4d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/deleteTiers/:id' WHERE [IdServiceParameters]=N'5b1f3635-36eb-426c-919c-af0b85bc3c1f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getListTiersWithPredicate' WHERE [IdServiceParameters]=N'616bf645-4939-4c3f-9b71-03d0610f74ea'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getTiersById/:id' WHERE [IdServiceParameters]=N'9984f127-7d4e-4949-9e89-e0035ea105a9'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/insertTiers' WHERE [IdServiceParameters]=N'9fe1daac-42b5-4551-a502-bad572f1b3f4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getTiersById/:id' WHERE [IdServiceParameters]=N'b0b59c21-0d78-4c5b-aa8b-4c4d8230c4a8'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/deleteTiers/:id' WHERE [IdServiceParameters]=N'e479457d-67e5-4428-a7cc-d5eee168dded'
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'4c196fb9-c36d-4ee3-9ef8-d8f088359963', N'PurchaseDocumentLine', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 4, N'PurchaseDocumentLine', N'PurchaseDocumentLine', N'PurchaseDocumentLine', N'PurchaseDocumentLine', N'PurchaseDocumentLine', N'PurchaseDocumentLine', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'5632c2b0-2839-4eb2-93dc-e9639a8e3e57', N'ItemWarehouse', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 7, N'ItemWarehouse', N'ItemWarehouse', N'ItemWarehouse', N'ItemWarehouse', N'ItemWarehouse', N'ItemWarehouse', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'5b0e2cca-5e09-4c7a-981a-4287ea8fb218', N'SalesDocumentLine', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 5, N'SalesDocumentLine', N'SalesDocumentLine', N'SalesDocumentLine', N'SalesDocumentLine', N'SalesDocumentLine', N'SalesDocumentLine', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'658f2678-349f-48b9-8432-db15fb7fa612', N'Contact', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 6, N'Contact', N'Contact', N'Contact', N'Contact', N'Contact', N'Contact', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', N'DetailsSettlementMode', N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 1, N'DetailsSettlementMode', N'DetailsSettlementMode', N'DetailsSettlementMode', N'DetailsSettlementMode', N'DetailsSettlementMode', N'DetailsSettlementMode', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fce419a7-a41b-4c0f-ade0-d2347b3525a8', N'AccountingAccount', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 3, N'AccountingAccount', N'AccountingAccount', N'AccountingAccount', N'AccountingAccount', N'AccountingAccount', N'AccountingAccount', N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'4c196fb9-c36d-4ee3-9ef8-d8f088359963', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'5632c2b0-2839-4eb2-93dc-e9639a8e3e57', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'5b0e2cca-5e09-4c7a-981a-4287ea8fb218', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'658f2678-349f-48b9-8432-db15fb7fa612', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'fce419a7-a41b-4c0f-ade0-d2347b3525a8', 1, 1)


INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', N'PurchaseDocumentLine-LIST', 4, N'PurchaseDocumentLine-LIST', N'PurchaseDocumentLine-LIST', N'PurchaseDocumentLine-LIST', N'PurchaseDocumentLine-LIST', N'PurchaseDocumentLine-LIST', N'PurchaseDocumentLine-LIST', N'/purchase/purchasedocumentline/list', 0, N'LIST-DocumentLine')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'49dcd5da-3149-42b7-9861-cab2aa575b63', N'DetailsSettlementMode-LIST', 4, N'DetailsSettlementMode-LIST', N'DetailsSettlementMode-LIST', N'DetailsSettlementMode-LIST', N'DetailsSettlementMode-LIST', N'DetailsSettlementMode-LIST', N'DetailsSettlementMode-LIST', N'/settlementmode/detailssettlementmode/list', 0, N'LIST-DetailsSettlementMode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'693dfee7-b819-450c-941c-2d2951c1ae6c', N'ItemWarehouse-LIST', 4, N'ItemWarehouse-LIST', N'ItemWarehouse-LIST', N'ItemWarehouse-LIST', N'ItemWarehouse-LIST', N'ItemWarehouse-LIST', N'ItemWarehouse-LIST', N'/divers/itemwarehouse/list', 0, N'LIST-ItemWarehouse')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'826ce05a-530f-4174-803c-a16f47ce3582', N'AccountingAccount-LIST', 4, N'AccountingAccount-LIST', N'AccountingAccount-LIST', N'AccountingAccount-LIST', N'AccountingAccount-LIST', N'AccountingAccount-LIST', N'AccountingAccount-LIST', N'/sales/accountingaccount/list', 0, N'LIST-AccountingAccount')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', N'Contact-LIST', 4, N'Contact-LIST', N'Contact-LIST', N'Contact-LIST', N'Contact-LIST', N'Contact-LIST', N'Contact-LIST', N'/divers/contact/list', 0, N'LIST-Contact')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f2715a17-ba0e-437b-a939-94382f648337', N'SalesDocumentLine-LIST', 4, N'SalesDocumentLine-LIST', N'SalesDocumentLine-LIST', N'SalesDocumentLine-LIST', N'SalesDocumentLine-LIST', N'SalesDocumentLine-LIST', N'SalesDocumentLine-LIST', N'/sales/salesdocumentline/list', 0, N'LIST-DocumentLine')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'826ce05a-530f-4174-803c-a16f47ce3582', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f2715a17-ba0e-437b-a939-94382f648337', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'01f789a5-5b28-4d78-a7f7-f81ada5addb3', N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', N'4c196fb9-c36d-4ee3-9ef8-d8f088359963')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'30456420-018e-44e1-bd2a-5c725915fbc9', N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', N'658f2678-349f-48b9-8432-db15fb7fa612')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6402a8c6-0ec6-4773-9e10-1ffcc8269488', N'826ce05a-530f-4174-803c-a16f47ce3582', N'fce419a7-a41b-4c0f-ade0-d2347b3525a8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a1304abd-a032-486c-8e80-27660b15d5e5', N'49dcd5da-3149-42b7-9861-cab2aa575b63', N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dc253fe8-e90e-478c-a9eb-ae074b0186cc', N'f2715a17-ba0e-437b-a939-94382f648337', N'5b0e2cca-5e09-4c7a-981a-4287ea8fb218')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f66d42d8-fa64-4893-9e0d-6c6fcae1bf1b', N'693dfee7-b819-450c-941c-2d2951c1ae6c', N'5632c2b0-2839-4eb2-93dc-e9639a8e3e57')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

---- add delete and show functionalities to all entities
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
UPDATE [ERPSettings].[DropDownListOptions] SET [height]=300 WHERE [IdDropDownListOptions]=N'8691c9b5-7239-49ed-bc1f-bc11b5015264'
UPDATE [ERPSettings].[DropDownListDataSource] SET [pageSize]=32, [serverPaging]=1, [serverFiltering]=1 WHERE [IdDropDownListOptions]=N'8691c9b5-7239-49ed-bc1f-bc11b5015264'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-DiscountGroupItem' WHERE [IdFunctionality]=N'4e1a462a-70fd-4454-96f8-fe543bce337a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'01c7e314-ef8f-4ee5-a54c-f876fc6b8759'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'07592bb2-f98b-48c4-a400-640f56cedefa'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'16d62fd5-bee1-4b78-a798-a8e591384637'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'183f7da7-b3a3-4942-bc53-05dbf2589e69'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'3347e734-92c5-4832-a12c-77404a50dfff'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'3892d6b7-dfbe-4051-af23-3a8e48c5a95d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'3d230ca0-3839-476e-b794-a70d1729328d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'3d3854ca-f779-4f3c-9a66-6c6ed4684e4d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'3fac4ad7-d0f5-48b0-933c-84ecab71a36d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'4f95acb7-dc86-44c3-b254-5146a7276e66'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'52739284-c8ab-4fce-b9c5-4dde95a1d948'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'55ad6f01-be91-41d4-b643-53e20ba0ec3f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'56188257-b754-4369-a5f6-a5214b202f72'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'5b8fe54b-6e8a-4f09-9864-03d406808383'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getPredicateTiers' WHERE [IdServiceParameters]=N'609e8b93-16f8-451e-af6b-1c41d2390f30'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'63b10f08-53b8-480b-86f7-d077d1e9c938'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getPredicateTiers' WHERE [IdServiceParameters]=N'6421e502-4743-4dc5-9f61-b515afad6162'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'691282eb-ea94-48ee-969a-41007552fb4f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'692fd601-e75d-4d01-8260-7d080f5bf326'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'6ce1205f-16b4-402c-8601-e8c265d3c6ea'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'7442b147-101d-4181-a556-2f58ee28fcd4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'77057b32-6472-47c4-8167-03978f784dfd'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'795b8536-aa16-4ded-b345-833d99c61381'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'7b776c93-fe3d-425d-bdc2-9556557c2391'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'7e00e39d-cad9-421d-9ed6-e290f993e983'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'7fa24421-7c5f-4b11-9114-237232fe1d9e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'87e69db3-799d-4729-b34a-aa0fa149d270'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'8afb677e-1dcf-47a5-832c-00e132e5b559'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'8c840692-c9e5-41f0-ae0a-7ce0542030d6'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'9185e9ea-10ca-415f-bd6c-c455bd524c3f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'92ccd750-ca1b-4203-bde9-6b38cfe7e16a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'96f20e7c-d8cb-487d-b1f1-b6cf7be41f2e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'9aea6763-81dc-439f-8fe8-7f709c2abce4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'9dfd0719-4b80-4f9d-991f-1684aa6aeb27'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'a2fdda1e-8249-47e0-a3e3-73ec0e6794b8'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/base/getDocumentById/:id' WHERE [IdServiceParameters]=N'b779eab4-6490-4dbd-8b05-929a7345e79e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'bcbe56cf-75ae-4b23-b818-de3426ecccdc'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'c4925f81-78ca-483c-a7a3-5c158e0a0885'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'c5cf0339-c52b-4013-b09a-aaec1eb5b9bd'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'c65e3174-3d6b-4700-bd9b-dc1397cd2bfd'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'c8b5bfdb-cfef-4677-b6dc-c6fd92c2f96e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'e2b41eb6-a6cc-4132-9bba-ae4d2590d59c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'e71b4c7e-c584-4569-abee-6ed73b35b656'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'e988c5de-b4de-4e67-bfe0-9cafe0257474'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'ef844257-73a6-4f73-be12-4ccaf5ad52a3'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'f4ff0925-9af2-4606-ac14-6a4236090fa2'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'fbc1fec1-6c09-4ad9-9de1-f28cbf59de69'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/tiers/getDataSourcePredicateTiers' WHERE [IdServiceParameters]=N'fe5d31a7-b3ba-4b14-a09d-69023b6964ed'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0156ec76-73ef-44c2-aa58-fc8e380e9683', N'SHOW-Contract', 1, N'SHOW-Contract', N'SHOW-Contract', N'SHOW-Contract', N'SHOW-Contract', N'SHOW-Contract', N'SHOW-Contract', N'/payroll/contract/show', 0, N'SHOW-Contract')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'04351640-3e1d-4810-a0f5-3147f12031a4', N'DELETE-Active', 1, N'DELETE-Active', N'DELETE-Active', N'Add active_AR', N'Add active_DE', N'Add active_CH', N'Add active_ES', N'/immobilisation/active/delete', 0, N'DELETE-Active')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'07d35985-0229-40c3-aaed-0fce364b33c1', N'DELETE-TransferMovement', 1, N'DELETE-TransferMovement', N'DELETE-TransferMovement', N'Ajouter Mvt de transfert_AR', N'Ajouter Mvt de transfert_DE', N'Ajouter Mvt de transfert_CH', N'Ajouter Mvt de transfert_ES', N'/stock/transfermovement/delete', 0, N'DELETE-TransferMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73', N'SHOW-SalaryRule', 1, N'SHOW-SalaryRule', N'SHOW-SalaryRule', N'Ajouter Règle Salariale_AR', N'Ajouter Règle SalarialeèDE', N'Ajouter Règle Salariale_CH', N'Ajouter Règle Salariale_ES', N'/payroll/salaryrule/show', 0, N'SHOW-SalaryRule')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', N'DELETE-Contract', 1, N'DELETE-Contract', N'DELETE-Contract', N'DELETE-Contract', N'DELETE-Contract', N'DELETE-Contract', N'DELETE-Contract', N'/payroll/contract/delete', 0, N'DELETE-Contract')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'114535ed-507b-48dd-8a35-bbdc252a82a8', N'SHOW-Axis', 1, N'SHOW-Axis', N'SHOW-Axis', N'SHOW-Axis', N'SHOW-Axis', N'SHOW-Axis', N'SHOW-Axis', N'/administration/axes/show', 0, N'SHOW-Axis')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'13a8d3ba-6471-4747-9237-43c601343ed5', N'SHOW-Settlement', 1, N'SHOW-Settlement', N'SHOW-Settlement', N'Ajouter Réglements_AR', N'Ajouter Réglements_DE', N'Ajouter Réglements_CH', N'Ajouter Réglements_ES', N'/payment/customersettlement/show', 0, N'SHOW-Settlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'14435987-a010-4981-aa0f-80d1e4498d4f', N'SHOW-SalesOrder', 1, N'SHOW-SalesOrder', N'SHOW-SalesOrder', N'Ajouter Commande_AR', N'Ajouter Commande_DE', N'Ajouter Commande_CH', N'Ajouter Commande_ES', N'/sales/order/show', 0, N'SHOW-SalesOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'17100aba-2fde-4a45-9e1c-4cf93f3b2248', N'SHOW-MeasureUnit', 1, N'SHOW-MeasureUnit', N'SHOW-MeasureUnit', N'SHOW-MeasureUnit', N'SHOW-MeasureUnit', N'SHOW-MeasureUnit', N'SHOW-MeasureUnit', N'/administration/measureunit/show', 0, N'SHOW-MeasureUnit')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7', N'SHOW-ConstantValue', 1, N'SHOW-ConstantValue', N'SHOW-ConstantValue', N'SHOW-ConstantValue', N'SHOW-ConstantValue', N'SHOW-ConstantValue', N'SHOW-ConstantValue', N'/payroll/constantvalue/show', 0, N'SHOW-ConstantValue')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'18facde4-8d07-47db-b7be-ec800b01751b', N'DELETE-Settlement', 1, N'DELETE-Settlement', N'DELETE-Settlement', N'Ajouter Réglements_AR', N'Ajouter Réglements_DE', N'Ajouter Réglements_CH', N'Ajouter Réglements_ES', N'/payment/customersettlement/delete', 0, N'DELETE-Settlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1c4dd748-6f03-430a-9d07-9b84e6a0902e', N'DELETE-Payslip', 1, N'DELETE-Payslip', N'DELETE-Payslip', N'Ajouter bulletin de paie_AR', N'Ajouter bulletin de paie_DE', N'Ajouter bulletin de paie_CH', N'Ajouter bulletin de paie_ES', N'/payroll/payslip/delete', 0, N'DELETE-Payslip')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1dc84c88-352f-488c-a927-58032f88a3f4', N'DELETE-PurchaseQuotation', 1, N'DELETE-PurchaseQuotation', N'DELETE-PurchaseQuotation', N'Ajouter Demande prix_AR', N'Ajouter Demande prix_DE', N'Ajouter Demande prix_CH', N'Ajouter Demande prix_ES', N'/purchase/purchasequotation/delete', 0, N'DELETE-PurchaseQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2', N'SHOW-PurchaseRequest', 1, N'SHOW-PurchaseRequest', N'SHOW-PurchaseRequest', N'SHOW-PurchaseRequest', N'SHOW-PurchaseRequest', N'SHOW-PurchaseRequest', N'SHOW-PurchaseRequest', N'/purchase/purchaserequest/show', 0, N'SHOW-PurchaseRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'207733d4-37a4-4b04-a973-27fcde23cc61', N'SettlementType-LIST', 4, N'SettlementType-LIST', N'SettlementType-LIST', N'SettlementType-LIST', N'SettlementType-LIST', N'SettlementType-LIST', N'SettlementType-LIST', N'/divers/settlementtype/list', 0, N'LIST-SettlementType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'21c8a894-f7d6-4747-bbc4-c2b21e733568', N'SHOW-SalesDelivery', 1, N'SHOW-SalesDelivery', N'SHOW-SalesDelivery', N'Ajouter Bon de Livraison_AR', N'Ajouter Bon de Livraison_DE', N'Ajouter Bon de Livraison_CH', N'Ajouter Bon de Livraison_ES', N'/sales/deliveryform/show', 0, N'SHOW-SalesDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4', N'DELETE-Role', 1, N'DELETE-Role', N'DELETE-Role', N'Ajouter Role_AR', N'Ajouter Role_DE', N'Ajouter Role_CH', N'Ajouter Role_ES', N'/administration/role/delete', 0, N'DELETE-Role')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'234ca81d-87b9-43a3-a215-2908500fb7c2', N'SHOW-SalaryStructure', 1, N'SHOW-SalaryStructure', N'SHOW-SalaryStructure', N'SHOW-SalaryStructure', N'SHOW-SalaryStructure', N'SHOW-SalaryStructure', N'SHOW-SalaryStructure', N'/payroll/salarystructure/show', 0, N'SHOW-SalaryStructure')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'26236d58-2ef6-493d-a936-3bb2a1efc1a3', N'SHOW-OutputMovement', 1, N'SHOW-OutputMovement', N'SHOW-OutputMovement', N'Ajouter Mvt de sortie_AR', N'Ajouter Mvt de sortie_DE', N'Ajouter Mvt de sortie_CH', N'Ajouter Mvt de sortie_ES', N'/stock/outputmovement/show', 0, N'SHOW-OutputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'26f81117-51f9-4638-aec4-801a6a296945', N'SHOW-Active', 1, N'SHOW-Active', N'SHOW-Active', N'Add active_AR', N'Add active_DE', N'Add active_CH', N'Add active_ES', N'/immobilisation/active/show', 0, N'SHOW-Active')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'273e5d24-26ed-4c78-9de1-6ac406b3529a', N'SHOW-City', 1, N'SHOW-City', N'SHOW-City', N'SHOW-City', N'SHOW-City', N'SHOW-City', N'SHOW-City', N'/administration/ville/show', 0, N'SHOW-City')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', N'DELETE-Country', 1, N'DELETE-Country', N'DELETE-Country', N'Ajouter Country_AR', N'Ajouter Country_DE', N'Ajouter Country_CH', N'Ajouter Country_ES', N'/administration/country/delete', 0, N'DELETE-Country')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', N'SHOW-PurchaseDelivery', 1, N'SHOW-PurchaseDelivery', N'SHOW-PurchaseDelivery', N'SHOW-PurchaseDelivery', N'SHOW-PurchaseDelivery', N'SHOW-PurchaseDelivery', N'SHOW-PurchaseDelivery', N'/purchase/purchasedeliveryform/show', 0, N'SHOW-PurchaseDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'324079a9-3676-4d46-9704-b6a7a707101e', N'DELETE-City', 1, N'DELETE-City', N'DELETE-City', N'DELETE-City', N'DELETE-City', N'DELETE-City', N'DELETE-City', N'/administration/ville/delete', 0, N'DELETE-City')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', N'DELETE-DiscountGroupTiers', 1, N'DELETE-DiscountGroupTiers', N'DELETE-DiscountGroupTiers', N'DELETE-DiscountGroupTiers', N'DELETE-DiscountGroupTiers', N'DELETE-DiscountGroupTiers', N'DELETE-DiscountGroupTiers', N'/administration/discountgrouptiers/delete', 0, N'DELETE-DiscountGroupTiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'34492beb-def2-4437-97a8-7afa138e17c1', N'DELETE-Employee', 1, N'DELETE-Employee', N'DELETE-Employee', N'Add Employee', N'Add Employee', N'Add Employee', N'Add Employee', N'/payroll/employee/delete', 0, N'DELETE-Employee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', N'DELETE-PurchaseInvoice', 1, N'DELETE-PurchaseInvoice', N'DELETE-PurchaseInvoice', N'Ajouter Facture_AR', N'Ajouter Facture_DE', N'Ajouter Facture_CH', N'Ajouter Facture_ES', N'/purchase/purchaseinvoice/delete', 0, N'DELETE-PurchaseInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3a77dfc3-7392-411c-aa42-078753a10e7b', N'SHOW-Taxe', 1, N'SHOW-Taxe', N'SHOW-Taxe', N'Ajouter Taxe_AR', N'Ajouter Taxe_DE', N'Ajouter Taxe_CH', N'Ajouter Taxe_ES', N'/administration/taxe/show', 0, N'SHOW-Taxe')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3e152b0f-dc4c-4416-8352-8569e8343fe9', N'SHOW-SalesQuotation', 1, N'SHOW-SalesQuotation', N'SHOW-SalesQuotation', N'Ajouter Devis_AR', N'Ajouter Devis_DE', N'Ajouter Devis_CH', N'Ajouter Devis_ES', N'/sales/quotation/show', 0, N'SHOW-SalesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', N'DELETE-PurchaseDelivery', 1, N'DELETE-PurchaseDelivery', N'DELETE-PurchaseDelivery', N'DELETE-PurchaseDelivery', N'DELETE-PurchaseDelivery', N'DELETE-PurchaseDelivery', N'DELETE-PurchaseDelivery', N'/purchase/purchasedeliveryform/delete', 0, N'DELETE-PurchaseDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4046572a-ab91-4548-bcfc-7747eb7df41c', N'SHOW-Customer', 1, N'SHOW-Customer', N'SHOW-Customer', N'Ajouter Client_AR', N'Ajouter Client_DE', N'Ajouter Client_CH', N'Ajouter Client_ES', N'/administration/customer/show', 0, N'SHOW-Customer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4095f424-c8be-4707-9e22-5cdcb62a3eba', N'DELETE-SalesQuotation', 1, N'DELETE-SalesQuotation', N'DELETE-SalesQuotation', N'Ajouter Devis_AR', N'Ajouter Devis_DE', N'Ajouter Devis_CH', N'Ajouter Devis_ES', N'/sales/quotation/delete', 0, N'DELETE-SalesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'41adc77a-62e3-4a81-8a90-c565ea54fcce', N'DELETE-Premium', 1, N'DELETE-Premium', N'DELETE-Premium', N'DELETE-Premium', N'DELETE-Premium', N'DELETE-Premium', N'DELETE-Premium', N'/payroll/premium/delete', 0, N'DELETE-Premium')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'44142e0e-7505-4961-9402-9a89fbb12ca7', N'DELETE-SettlementMode', 1, N'DELETE-SettlementMode', N'DELETE-SettlementMode', N'DELETE-SettlementMode', N'DELETE-SettlementMode', N'DELETE-SettlementMode', N'DELETE-SettlementMode', N'/sales/settlementmode/delete', 0, N'DELETE-SettlementMode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'48ae5050-184c-44e4-861e-d256272b207d', N'SHOW-TransferMovement', 1, N'SHOW-TransferMovement', N'SHOW-TransferMovement', N'Ajouter Mvt de transfert_AR', N'Ajouter Mvt de transfert_DE', N'Ajouter Mvt de transfert_CH', N'Ajouter Mvt de transfert_ES', N'/stock/transfermovement/show', 0, N'SHOW-TransferMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'49c9ef74-ab94-4204-8b9a-e935540468cf', N'SHOW-TaxeType', 1, N'SHOW-TaxeType', N'SHOW-TaxeType', N'SHOW-TaxeType', N'SHOW-TaxeType', N'SHOW-TaxeType', N'SHOW-TaxeType', N'/administration/taxetype/show', 0, N'SHOW-TaxeType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4b7535a4-dd2e-4071-9080-09a340e427f6', N'DELETE-ContractServiceType', 1, N'DELETE-ContractServiceType', N'DELETE-ContractServiceType', N'DELETE-ContractServiceType', N'DELETE-ContractServiceType', N'DELETE-ContractServiceType', N'DELETE-ContractServiceType', N'/administration/contractservicetype/delete', 0, N'DELETE-ContractServiceType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', N'DELETE-Item', 1, N'DELETE-Item', N'DELETE-Item', N'Ajouter Article_AR', N'Ajouter Article_DE', N'Ajouter Article_CH', N'Ajouter Article_ES', N'/stock/item/delete', 0, N'DELETE-Item')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', N'DELETE-PurchaseRequest', 1, N'DELETE-PurchaseRequest', N'DELETE-PurchaseRequest', N'DELETE-PurchaseRequest', N'DELETE-PurchaseRequest', N'DELETE-PurchaseRequest', N'DELETE-PurchaseRequest', N'/purchase/purchaserequest/delete', 0, N'DELETE-PurchaseRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5069d2f1-0dbe-4d29-ae69-130d560901c2', N'SHOW-Warehouse', 1, N'SHOW-Warehouse', N'SHOW-Warehouse', N'SHOW-Warehouse', N'SHOW-Warehouse', N'SHOW-Warehouse', N'SHOW-Warehouse', N'/stock/warehouse/show', 0, N'SHOW-Warehouse')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'51897e01-9b8a-473a-b20b-4d1b5f572d87', N'SHOW-SalesInvoice', 1, N'SHOW-SalesInvoice', N'SHOW-SalesInvoice', N'Ajouter Facture_AR', N'Ajouter Facture_DE', N'Ajouter Facture_CH', N'Ajouter Facture_ES', N'/sales/invoice/show', 0, N'SHOW-SalesInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'520af6c2-5f31-488a-8970-0a390b7c9c34', N'DELETE-SalesDelivery', 1, N'DELETE-SalesDelivery', N'DELETE-SalesDelivery', N'Ajouter Bon de Livraison_AR', N'Ajouter Bon de Livraison_DE', N'Ajouter Bon de Livraison_CH', N'Ajouter Bon de Livraison_ES', N'/sales/deliveryform/delete', 0, N'DELETE-SalesDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', N'SHOW-Item', 1, N'SHOW-Item', N'SHOW-Item', N'Ajouter Article_AR', N'Ajouter Article_DE', N'Ajouter Article_CH', N'Ajouter Article_ES', N'/stock/item/show', 0, N'SHOW-Item')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'54aac154-2c0a-471c-adfd-0469a65737cf', N'DELETE-ConstantRate', 1, N'DELETE-ConstantRate', N'DELETE-ConstantRate', N'DELETE-ConstantRate', N'DELETE-ConstantRate', N'DELETE-ConstantRate', N'DELETE-ConstantRate', N'/payroll/constantrate/delete', 0, N'DELETE-ConstantRate')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', N'DELETE-PayementMethode', 1, N'DELETE-PayementMethode', N'DELETE-PayementMethode', N'DELETE-PayementMethode', N'DELETE-PayementMethode', N'DELETE-PayementMethode', N'DELETE-PayementMethode', N'/payement/payementmethod/delete', 0, N'DELETE-PayementMethode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5afe23dd-03a4-4857-b96d-55b011b9af72', N'DELETE-DiscountGroupItem', 1, N'DELETE-DiscountGroupItem', N'DELETE-DiscountGroupItem', N'Ajouter Groupe remise article_AR', N'Ajouter Groupe remise article_DE', N'Ajouter Groupe remise article_CH', N'Ajouter Groupe remise article_ES', N'/administration/discountgroupitem/delete', 0, N'DELETE-DiscountGroupItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'605f60cb-09e8-41c6-9ba4-829679b00c84', N'DELETE-SalaryStructure', 1, N'DELETE-SalaryStructure', N'DELETE-SalaryStructure', N'DELETE-SalaryStructure', N'DELETE-SalaryStructure', N'DELETE-SalaryStructure', N'DELETE-SalaryStructure', N'/payroll/salarystructure/delete', 0, N'DELETE-SalaryStructure')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6a74f264-0c50-4201-8772-f71229bbf01c', N'SHOW-SettlementMode', 1, N'SHOW-SettlementMode', N'SHOW-SettlementMode', N'SHOW-SettlementMode', N'SHOW-SettlementMode', N'SHOW-SettlementMode', N'SHOW-SettlementMode', N'/sales/settlementmode/show', 0, N'SHOW-SettlementMode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6c104837-0a04-43d6-b200-177b98588522', N'SHOW-Grade', 1, N'SHOW-Grade', N'SHOW-Grade', N'SHOW-Grade', N'SHOW-Grade', N'SHOW-Grade', N'SHOW-Grade', N'/payroll/grade/show', 0, N'SHOW-Grade')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6ff78f47-541e-4bab-a71c-f0350adb3543', N'DELETE-InventoryMovement', 1, N'DELETE-InventoryMovement', N'DELETE-InventoryMovement', N'DELETE-InventoryMovement', N'DELETE-InventoryMovement', N'DELETE-InventoryMovement', N'DELETE-InventoryMovement', N'/stock/inventorymovement/delete', 0, N'DELETE-InventoryMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'722fdfcc-02ee-4680-b684-fcc7230714cc', N'SHOW-Prices', 1, N'SHOW-Prices', N'SHOW-Prices', N'SHOW-Prices', N'SHOW-Prices', N'SHOW-Prices', N'SHOW-Prices', N'/administration/prices/show', 0, N'SHOW-Prices')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b', N'SHOW-Premium', 1, N'SHOW-Premium', N'SHOW-Premium', N'SHOW-Premium', N'SHOW-Premium', N'SHOW-Premium', N'SHOW-Premium', N'/payroll/premium/show', 0, N'SHOW-Premium')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46', N'DELETE-TaxeType', 1, N'DELETE-TaxeType', N'DELETE-TaxeType', N'DELETE-TaxeType', N'DELETE-TaxeType', N'DELETE-TaxeType', N'DELETE-TaxeType', N'/administration/taxetype/delete', 0, N'DELETE-TaxeType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7eac8530-e743-4028-9434-48f8ba9a09ef', N'DELETE-ZipCode', 1, N'DELETE-ZipCode', N'DELETE-ZipCode', N'Ajouter_AR', N'Ajouter_DE', N'Ajouter_CH', N'Ajouter_ES', N'/administration/zipcode/delete', 0, N'DELETE-ZipCode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7ee79c5f-71ac-40e4-90d2-913e2671666b', N'DELETE-Grade', 1, N'DELETE-Grade', N'DELETE-Grade', N'DELETE-Grade', N'DELETE-Grade', N'DELETE-Grade', N'DELETE-Grade', N'/payroll/grade/delete', 0, N'DELETE-Grade')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', N'DELETE-Job', 1, N'DELETE-Job', N'DELETE-Job', N'DELETE-Job', N'DELETE-Job', N'DELETE-Job', N'DELETE-Job', N'/payroll/job/delete', 0, N'DELETE-Job')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', N'DELETE-InputMovement', 1, N'DELETE-InputMovement', N'DELETE-InputMovement', N'Ajouter Mvt d''entrée_AR', N'Ajouter Mvt d''entrée_DE', N'Ajouter Mvt d''entrée_CH', N'Ajouter Mvt d''entrée_ES', N'/stock/inputmovement/delete', 0, N'DELETE-InputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', N'DELETE-SalesAsset', 1, N'DELETE-SalesAsset', N'DELETE-SalesAsset', N'Ajouter Avoir_AR', N'Ajouter Avoir_DE', N'Ajouter Avoir_CH', N'Ajouter Avoir_ES', N'/sales/asset/delete', 0, N'DELETE-SalesAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8172fa8f-9ff5-475e-8d92-93fc731091eb', N'DELETE-PurchaseOrder', 1, N'DELETE-PurchaseOrder', N'DELETE-PurchaseOrder', N'Ajouter Bon de commande_AR', N'Ajouter Bon de commande_DE', N'Ajouter Bon de commande_CH', N'Ajouter Bon de commande_ES', N'/purchase/purchaseorder/delete', 0, N'DELETE-PurchaseOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', N'SHOW-PurchaseAsset', 1, N'SHOW-PurchaseAsset', N'SHOW-PurchaseAsset', N'SHOW-PurchaseAsset', N'SHOW-PurchaseAsset', N'SHOW-PurchaseAsset', N'SHOW-PurchaseAsset', N'/purchase/purchaseasset/show', 0, N'SHOW-PurchaseAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', N'DELETE-MeasureUnit', 1, N'DELETE-MeasureUnit', N'DELETE-MeasureUnit', N'DELETE-MeasureUnit', N'DELETE-MeasureUnit', N'DELETE-MeasureUnit', N'DELETE-MeasureUnit', N'/administration/measureunit/delete', 0, N'DELETE-MeasureUnit')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'86de038f-e73a-4cf8-9d0c-3c488130396e', N'SHOW-PurchaseInvoice', 1, N'SHOW-PurchaseInvoice', N'SHOW-PurchaseInvoice', N'Ajouter Facture_AR', N'Ajouter Facture_DE', N'Ajouter Facture_CH', N'Ajouter Facture_ES', N'/purchase/purchaseinvoice/show', 0, N'SHOW-PurchaseInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'89e4f583-900b-43ec-ab63-34e838f35a81', N'DELETE-Customer', 1, N'DELETE-Customer', N'DELETE-Customer', N'Ajouter Client_AR', N'Ajouter Client_DE', N'Ajouter Client_CH', N'Ajouter Client_ES', N'/administration/customer/delete', 0, N'DELETE-Customer')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66', N'DELETE-Taxe', 1, N'DELETE-Taxe', N'DELETE-Taxe', N'Ajouter Taxe_AR', N'Ajouter Taxe_DE', N'Ajouter Taxe_CH', N'Ajouter Taxe_ES', N'/administration/taxe/delete', 0, N'DELETE-Taxe')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', N'SHOW-DiscountGroupItem', 1, N'SHOW-DiscountGroupItem', N'SHOW-DiscountGroupItem', N'Ajouter Groupe remise article_AR', N'Ajouter Groupe remise article_DE', N'Ajouter Groupe remise article_CH', N'Ajouter Groupe remise article_ES', N'/administration/discountgroupitem/show', 0, N'SHOW-DiscountGroupItem')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9a7e6cfe-cd60-4ccd-8c14-af283303e936', N'DELETE-Variable', 1, N'DELETE-Variable', N'DELETE-Variable', N'', N'', N'', N'', N'/payroll/variable/delete', 0, N'DELETE-Variable')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', N'SHOW-Job', 1, N'SHOW-Job', N'SHOW-Job', N'SHOW-Job', N'SHOW-Job', N'SHOW-Job', N'SHOW-Job', N'/payroll/job/show', 0, N'SHOW-Job')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', N'DELETE-SalesOrder', 1, N'DELETE-SalesOrder', N'DELETE-SalesOrder', N'Ajouter Commande_AR', N'Ajouter Commande_DE', N'Ajouter Commande_CH', N'Ajouter Commande_ES', N'/sales/order/delete', 0, N'DELETE-SalesOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a36dadb4-a0e3-4a10-a52d-24273c131af1', N'SHOW-BankAccount', 1, N'SHOW-BankAccount', N'SHOW-BankAccount', N'SHOW-BankAccount', N'SHOW-BankAccount', N'SHOW-BankAccount', N'SHOW-BankAccount', N'/administration/bankaccount/show', 0, N'SHOW-BankAccount')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a3ea8642-aa44-45f4-9b53-060b114819e5', N'DELETE-Warehouse', 1, N'DELETE-Warehouse', N'DELETE-Warehouse', N'DELETE-Warehouse', N'DELETE-Warehouse', N'DELETE-Warehouse', N'DELETE-Warehouse', N'/stock/warehouse/delete', 0, N'DELETE-Warehouse')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a66523be-f0b3-4420-aea5-ecba26c130be', N'SHOW-InputMovement', 1, N'SHOW-InputMovement', N'SHOW-InputMovement', N'Ajouter Mvt d''entrée_AR', N'Ajouter Mvt d''entrée_DE', N'Ajouter Mvt d''entrée_CH', N'Ajouter Mvt d''entrée_ES', N'/stock/inputmovement/show', 0, N'SHOW-InputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', N'SHOW-Nature', 1, N'SHOW-Nature', N'SHOW-Nature', N'SHOW-Nature', N'SHOW-Nature', N'SHOW-Nature', N'SHOW-Nature', N'/stock/nature/show', 0, N'SHOW-Nature')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a97affbe-b4da-40f6-8055-f493cef4d9e5', N'DELETE-PurchaseAsset', 1, N'DELETE-PurchaseAsset', N'DELETE-PurchaseAsset', N'DELETE-PurchaseAsset', N'DELETE-PurchaseAsset', N'DELETE-PurchaseAsset', N'DELETE-PurchaseAsset', N'/purchase/purchaseasset/delete', 0, N'DELETE-PurchaseAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'aa016aeb-2fda-4e56-83ce-6286ab21c128', N'SHOW-Payslip', 1, N'SHOW-Payslip', N'SHOW-Payslip', N'Ajouter bulletin de paie_AR', N'Ajouter bulletin de paie_DE', N'Ajouter bulletin de paie_CH', N'Ajouter bulletin de paie_ES', N'/payroll/payslip/show', 0, N'SHOW-Payslip')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'aee4bc17-1442-48b2-a95b-3ec265c58cd8', N'SHOW-User', 1, N'SHOW-User', N'SHOW-User', N'SHOW-User', N'SHOW-User', N'SHOW-User', N'SHOW-User', N'/administration/user/show', 0, N'SHOW-User')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', N'DELETE-SalesInvoice', 1, N'DELETE-SalesInvoice', N'DELETE-SalesInvoice', N'Ajouter Facture_AR', N'Ajouter Facture_DE', N'Ajouter Facture_CH', N'Ajouter Facture_ES', N'/sales/invoice/delete', 0, N'DELETE-SalesInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b8cfb588-5071-4035-9e0f-f7f14f2856e5', N'DELETE-User', 1, N'DELETE-User', N'DELETE-User', N'DELETE-User', N'DELETE-User', N'DELETE-User', N'DELETE-User', N'/administration/user/delete', 0, N'DELETE-User')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', N'SHOW-DiscountGroupTiers', 1, N'SHOW-DiscountGroupTiers', N'SHOW-DiscountGroupTiers', N'SHOW-DiscountGroupTiers', N'SHOW-DiscountGroupTiers', N'SHOW-DiscountGroupTiers', N'SHOW-DiscountGroupTiers', N'/administration/discountgrouptiers/show', 0, N'SHOW-DiscountGroupTiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', N'DELETE-Supplier', 1, N'DELETE-Supplier', N'DELETE-Supplier', N'Ajouter Fournisseur_AR', N'Ajouter Fournisseur_DE', N'Ajouter Fournisseur_CH', N'Ajouter Fournisseur_ES', N'/administration/supplier/delete', 0, N'DELETE-Supplier')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c196270b-56d8-4eaa-8c52-69773420797a', N'DELETE-OutputMovement', 1, N'DELETE-OutputMovement', N'DELETE-OutputMovement', N'Ajouter Mvt de sortie_AR', N'Ajouter Mvt de sortie_DE', N'Ajouter Mvt de sortie_CH', N'Ajouter Mvt de sortie_ES', N'/stock/outputmovement/delete', 0, N'DELETE-OutputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c5a223f3-5d06-455a-8c50-65ad56f7059b', N'DELETE-Nature', 1, N'DELETE-Nature', N'DELETE-Nature', N'DELETE-Nature', N'DELETE-Nature', N'DELETE-Nature', N'DELETE-Nature', N'/stock/nature/delete', 0, N'DELETE-Nature')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c64cde5d-5fe9-4545-830d-4f967fdef70a', N'DELETE-Prices', 1, N'DELETE-Prices', N'DELETE-Prices', N'DELETE-Prices', N'DELETE-Prices', N'DELETE-Prices', N'DELETE-Prices', N'/administration/prices/delete', 0, N'DELETE-Prices')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', N'DELETE-SupplierSettlement', 1, N'DELETE-SupplierSettlement', N'DELETE-SupplierSettlement', N'DELETE-SupplierSettlement', N'DELETE-SupplierSettlement', N'DELETE-SupplierSettlement', N'DELETE-SupplierSettlement', N'/payment/suppliersettlement/delete', 0, N'DELETE-SupplierSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c71757fa-088e-4b46-9359-455061d6b753', N'DELETE-Currency', 1, N'DELETE-Currency', N'DELETE-Currency', N'Ajouter Currency_AR', N'Ajouter Currency_DE', N'Ajouter Currency_CH', N'Ajouter Currency_ES', N'/administration/currency/delete', 0, N'DELETE-Currency')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', N'SHOW-Currency', 1, N'SHOW-Currency', N'SHOW-Currency', N'Ajouter Currency_AR', N'Ajouter Currency_DE', N'Ajouter Currency_CH', N'Ajouter Currency_ES', N'/administration/currency/show', 0, N'SHOW-Currency')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cc715473-7abd-4b07-8458-a07daaca6e15', N'SHOW-ImmobilisationCategory', 1, N'SHOW-ImmobilisationCategory', N'SHOW-ImmobilisationCategory', NULL, NULL, NULL, NULL, N'/immobilisation/category/show', 0, N'SHOW-ImmobilisationCategory')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f', N'SHOW-Role', 1, N'SHOW-Role', N'SHOW-Role', N'Ajouter Role_AR', N'Ajouter Role_DE', N'Ajouter Role_CH', N'Ajouter Role_ES', N'/administration/role/show', 0, N'SHOW-Role')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', N'DELETE-ConstantValue', 1, N'DELETE-ConstantValue', N'DELETE-ConstantValue', N'DELETE-ConstantValue', N'DELETE-ConstantValue', N'DELETE-ConstantValue', N'DELETE-ConstantValue', N'/payroll/constantvalue/delete', 0, N'DELETE-ConstantValue')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'db71cf78-8417-4fc0-aabf-4b955796d9a2', N'SHOW-Supplier', 1, N'SHOW-Supplier', N'SHOW-Supplier', N'Ajouter Fournisseur_AR', N'Ajouter Fournisseur_DE', N'Ajouter Fournisseur_CH', N'Ajouter Fournisseur_ES', N'/administration/supplier/show', 0, N'SHOW-Supplier')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dc736454-3856-4968-9662-4c1800a85f4a', N'SHOW-InventoryMovement', 1, N'SHOW-InventoryMovement', N'SHOW-InventoryMovement', N'SHOW-InventoryMovement', N'SHOW-InventoryMovement', N'SHOW-InventoryMovement', N'SHOW-InventoryMovement', N'/stock/inventorymovement/show', 0, N'SHOW-InventoryMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'de36105a-564c-478d-ad54-a9c6e64db410', N'SHOW-ContractServiceType', 1, N'SHOW-ContractServiceType', N'SHOW-ContractServiceType', N'SHOW-ContractServiceType', N'SHOW-ContractServiceType', N'SHOW-ContractServiceType', N'SHOW-ContractServiceType', N'/administration/contractservicetype/show', 0, N'SHOW-ContractServiceType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'df7e2b4d-01f0-44d6-a7d6-8337225897c3', N'SHOW-Country', 1, N'SHOW-Country', N'SHOW-Country', N'Ajouter Country_AR', N'Ajouter Country_DE', N'Ajouter Country_CH', N'Ajouter Country_ES', N'/administration/country/show', 0, N'SHOW-Country')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e0490245-3f54-4720-b7c0-d36591f5ffed', N'DELETE-TaxeGroupTiers', 1, N'DELETE-TaxeGroupTiers', N'DELETE-TaxeGroupTiers', N'DELETE-TaxeGroupTiers', N'DELETE-TaxeGroupTiers', N'DELETE-TaxeGroupTiers', N'DELETE-TaxeGroupTiers', N'/sales/TaxeGroupTiers/delete', 0, N'DELETE-TaxeGroupTiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e31fdfff-824c-4a7d-a640-8f43a6c4f824', N'SHOW-Employee', 1, N'SHOW-Employee', N'SHOW-Employee', N'Add Employee', N'Add Employee', N'Add Employee', N'Add Employee', N'/payroll/employee/show', 0, N'SHOW-Employee')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', N'SHOW-SalesAsset', 1, N'SHOW-SalesAsset', N'SHOW-SalesAsset', N'Ajouter Avoir_AR', N'Ajouter Avoir_DE', N'Ajouter Avoir_CH', N'Ajouter Avoir_ES', N'/sales/asset/show', 0, N'SHOW-SalesAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', N'SHOW-SupplierSettlement', 1, N'SHOW-SupplierSettlement', N'SHOW-SupplierSettlement', N'SHOW-SupplierSettlement', N'SHOW-SupplierSettlement', N'SHOW-SupplierSettlement', N'SHOW-SupplierSettlement', N'/payment/suppliersettlement/show', 0, N'SHOW-SupplierSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ee347789-32ce-492c-a380-99eef0467543', N'DELETE-Axis', 1, N'DELETE-Axis', N'DELETE-Axis', N'DELETE-Axis', N'DELETE-Axis', N'DELETE-Axis', N'DELETE-Axis', N'/administration/axes/delete', 0, N'DELETE-Axis')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f', N'SHOW-Variable', 1, N'SHOW-Variable', N'SHOW-Variable', N'', N'', N'', N'', N'/payroll/variable/show', 0, N'SHOW-Variable')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f41f13d6-190d-4f8b-9432-f6423811314a', N'SHOW-TaxeGroupTiers', 1, N'SHOW-TaxeGroupTiers', N'SHOW-TaxeGroupTiers', N'SHOW-TaxeGroupTiers', N'SHOW-TaxeGroupTiers', N'SHOW-TaxeGroupTiers', N'SHOW-TaxeGroupTiers', N'/sales/TaxeGroupTiers/show', 0, N'SHOW-TaxeGroupTiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', N'DELETE-ImmobilisationCategory', 1, N'DELETE-ImmobilisationCategory', N'DELETE-ImmobilisationCategory', NULL, NULL, NULL, NULL, N'/immobilisation/category/delete', 0, N'DELETE-ImmobilisationCategory')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', N'SHOW-PurchaseQuotation', 1, N'SHOW-PurchaseQuotation', N'SHOW-PurchaseQuotation', N'Ajouter Demande prix_AR', N'Ajouter Demande prix_DE', N'Ajouter Demande prix_CH', N'Ajouter Demande prix_ES', N'/purchase/purchasequotation/show', 0, N'SHOW-PurchaseQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310', N'SHOW-ConstantRate', 1, N'SHOW-ConstantRate', N'SHOW-ConstantRate', N'SHOW-ConstantRate', N'SHOW-ConstantRate', N'SHOW-ConstantRate', N'SHOW-ConstantRate', N'/payroll/constantrate/show', 0, N'SHOW-ConstantRate')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'faff4451-6454-4dff-b4a9-6168f1edf526', N'SHOW-ZipCode', 1, N'SHOW-ZipCode', N'SHOW-ZipCode', N'Ajouter_AR', N'Ajouter_DE', N'Ajouter_CH', N'Ajouter_ES', N'/administration/zipcode/show', 0, N'SHOW-ZipCode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fb07746a-f1b1-43f6-823f-643fb9100df1', N'SHOW-PayementMethode', 1, N'SHOW-PayementMethode', N'SHOW-PayementMethode', N'SHOW-PayementMethode', N'SHOW-PayementMethode', N'SHOW-PayementMethode', N'SHOW-PayementMethode', N'/payement/payementmethod/show', 0, N'SHOW-PayementMethode')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fdc96a50-12cd-46db-9007-16ae4d4342e5', N'SHOW-PurchaseOrder', 1, N'SHOW-PurchaseOrder', N'SHOW-PurchaseOrder', N'Ajouter Bon de commande_AR', N'Ajouter Bon de commande_DE', N'Ajouter Bon de commande_CH', N'Ajouter Bon de commande_ES', N'/purchase/purchaseorder/show', 0, N'SHOW-PurchaseOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1', N'DELETE-SalaryRule', 1, N'DELETE-SalaryRule', N'DELETE-SalaryRule', N'Ajouter Règle Salariale_AR', N'Ajouter Règle SalarialeèDE', N'Ajouter Règle Salariale_CH', N'Ajouter Règle Salariale_ES', N'/payroll/salaryrule/delete', 0, N'DELETE-SalaryRule')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', N'DELETE-BankAccount', 1, N'DELETE-BankAccount', N'DELETE-BankAccount', N'DELETE-BankAccount', N'DELETE-BankAccount', N'DELETE-BankAccount', N'DELETE-BankAccount', N'/administration/bankaccount/delete', 0, N'DELETE-BankAccount')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'6332e396-93b3-41ac-9daa-2c2ec99a6c5a', N'SettlementType', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 8, N'SettlementType', N'SettlementType', N'SettlementType', N'SettlementType', N'SettlementType', N'SettlementType', N'icon-note', 0)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'03888fdf-95d1-4a1a-bc9f-501f46f89cc9', N'ee347789-32ce-492c-a380-99eef0467543', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0646462e-a23a-4b2b-925c-32a502ec40f7', N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'07d11042-963a-42e7-9236-8919b766d1c9', N'51897e01-9b8a-473a-b20b-4d1b5f572d87', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0b77c173-ef96-420b-9148-767693b04a94', N'a36dadb4-a0e3-4a10-a52d-24273c131af1', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0d37135b-5d41-4baf-ad5f-ca0cbecce7a4', N'4b7535a4-dd2e-4071-9080-09a340e427f6', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0d9bd5df-0dbb-4674-893f-aa56ea4dbda3', N'c64cde5d-5fe9-4545-830d-4f967fdef70a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0dbbcee4-a338-48c4-be3a-7f0cf7be71a2', N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0f9447ea-345e-40b2-abba-83c99270ab25', N'6c104837-0a04-43d6-b200-177b98588522', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'10567d67-9d2b-427d-bcea-4e7be49bc058', N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'139778e2-1e2a-4be1-8db2-724adb993121', N'c71757fa-088e-4b46-9359-455061d6b753', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'15ef4ea0-bdff-4732-8c96-1363dae72e5d', N'3e152b0f-dc4c-4416-8352-8569e8343fe9', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'168b9209-faa6-419c-927c-2fa7cdbab8a6', N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'174e6562-1083-49a9-bf19-e9e796a2cdc6', N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'191919f6-c540-42af-83cf-f2681a463617', N'6a74f264-0c50-4201-8772-f71229bbf01c', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1a598e46-5233-4df8-ad29-72e1a2eaa136', N'a66523be-f0b3-4420-aea5-ecba26c130be', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1d33648f-33fa-4e0f-b7f6-5f7accbfe620', N'54aac154-2c0a-471c-adfd-0469a65737cf', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1e9a9ef9-6259-48d5-8dea-af28dcd208c2', N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1fb8c6ca-2cce-4a5c-8b05-775da8f48d6c', N'04351640-3e1d-4810-a0f5-3147f12031a4', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'215818a3-2b52-49a7-9db8-e71d5a203ac5', N'faff4451-6454-4dff-b4a9-6168f1edf526', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'26b2d1e9-ba1f-4bb9-b9b8-a162e19d3f68', N'4046572a-ab91-4548-bcfc-7747eb7df41c', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2a2ee41d-a06b-454d-813a-e3307d3e2bb9', N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2dba6256-ef9c-4fdb-b503-a9c0c21876d3', N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'31206cf7-a845-4937-999b-345e2872ddad', N'1dc84c88-352f-488c-a927-58032f88a3f4', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'31daf04a-d730-43fd-af9c-4fa2754a5c1f', N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'324853bf-c6bc-49a7-8aba-5f1e67ad1888', N'e0490245-3f54-4720-b7c0-d36591f5ffed', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'340b5e11-97a5-4b94-a80a-cfc4ac88d0a0', N'605f60cb-09e8-41c6-9ba4-829679b00c84', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3675df95-a694-44cb-950b-8bd9e2a77149', N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'396cc0bb-cfed-4d3a-b2ce-ec2b50f9cab6', N'273e5d24-26ed-4c78-9de1-6ac406b3529a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'39f29d8a-c800-42f3-8448-ad32e95d4693', N'14435987-a010-4981-aa0f-80d1e4498d4f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3a8b4285-91ed-4a25-a25a-932cad9952b4', N'34492beb-def2-4437-97a8-7afa138e17c1', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3c336b13-d724-4196-ad83-cf5cf90c4764', N'df7e2b4d-01f0-44d6-a7d6-8337225897c3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3d57c858-27cb-428f-b954-f276fce76770', N'c5a223f3-5d06-455a-8c50-65ad56f7059b', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3d7399ab-e08a-42c4-88a2-325aad7803ee', N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'401769fd-218d-4e37-9b27-2ca7c6dc687a', N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'43c496e6-5c9a-4dd7-a52d-7139d8c96e4c', N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4a023d94-9bf2-4035-962d-148df192bd82', N'48ae5050-184c-44e4-861e-d256272b207d', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4c623d72-6cff-400a-84fd-439dc29b04ce', N'aee4bc17-1442-48b2-a95b-3ec265c58cd8', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4df992ea-f760-4472-8f2b-a561899683a0', N'a3ea8642-aa44-45f4-9b53-060b114819e5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4ea9f8ad-390d-42f0-bee0-fc8681f383f7', N'3a77dfc3-7392-411c-aa42-078753a10e7b', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4faf0752-2f73-4254-b35d-8ff0428961d9', N'7eac8530-e743-4028-9434-48f8ba9a09ef', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'577a2de0-8aba-4b8f-8618-e93e238e19c6', N'a97affbe-b4da-40f6-8055-f493cef4d9e5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5bd76d47-a3e2-44a6-a3ed-e1c332bf31f3', N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5c75a192-b3f7-4d03-8156-bbb838983d32', N'114535ed-507b-48dd-8a35-bbdc252a82a8', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5e0bb5b8-6e51-4552-a1b4-b8bed38bd3dc', N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5f3f2eac-d51b-4e1c-8445-5b8fff88e406', N'1c4dd748-6f03-430a-9d07-9b84e6a0902e', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'60a5deb8-84cc-4345-b5d1-0e675441097d', N'26f81117-51f9-4638-aec4-801a6a296945', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'61ea3ffb-d9fe-469f-9a81-67f85a457f9a', N'207733d4-37a4-4b04-a973-27fcde23cc61', N'6332e396-93b3-41ac-9daa-2c2ec99a6c5a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'63d1ca30-2e95-401f-88e5-9779f4b3a85a', N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'67ce7b20-5972-4e3d-b5ab-dbd9ea156c10', N'fb07746a-f1b1-43f6-823f-643fb9100df1', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6d68d5f9-2fe6-40f1-8f20-14477ed39b1d', N'44142e0e-7505-4961-9402-9a89fbb12ca7', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6fdf3db1-5813-4b58-9257-842f41b759bd', N'c196270b-56d8-4eaa-8c52-69773420797a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'743684a8-9c25-445b-ba10-62f55d464eb4', N'f41f13d6-190d-4f8b-9432-f6423811314a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'752619f7-6bb5-4933-8d20-67850597376b', N'6ff78f47-541e-4bab-a71c-f0350adb3543', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'774eeb61-0cb4-4faa-8416-98ab192479bc', N'324079a9-3676-4d46-9704-b6a7a707101e', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'79529e9a-ecf6-4ee4-a7bd-e7df16a94641', N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7d84ff22-664f-4241-a05c-66d3a6ab9e17', N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7e4430e3-5d36-4f28-bfe2-24980a2acc25', N'e31fdfff-824c-4a7d-a640-8f43a6c4f824', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7f85061a-4e66-40bb-86ca-b744d9195dfe', N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'803cbb6a-a79f-4485-a638-cf0cf7251ddb', N'4095f424-c8be-4707-9e22-5cdcb62a3eba', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8604e621-ca28-48c9-a1c3-995d8c1ec37e', N'21c8a894-f7d6-4747-bbc4-c2b21e733568', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'86dd6018-d2b1-412c-8221-5791b5c3cfef', N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8753bd80-b93b-4127-a78f-22f7ad57ab89', N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'89c60084-9983-446a-82a0-0689c3763e16', N'49c9ef74-ab94-4204-8b9a-e935540468cf', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8a9e4776-7a23-4304-b145-94b8a12dd530', N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8b66b2c1-6f11-4ebc-8644-96afbf8e8e11', N'41adc77a-62e3-4a81-8a90-c565ea54fcce', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8c6568c5-5025-48a8-9a8a-3ddb83598d1b', N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8d101bcb-1c18-40a5-bb83-b0565b883f38', N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9598aee5-6cbc-47f7-bace-ca604e3ca1c5', N'13a8d3ba-6471-4747-9237-43c601343ed5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'95e132aa-814e-41b8-8038-91bd02c10cff', N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a6214304-a55d-4dfd-8033-f51290773912', N'89e4f583-900b-43ec-ab63-34e838f35a81', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'aa44d0fb-5f9e-4b2f-9eeb-ff4b28507e24', N'0156ec76-73ef-44c2-aa58-fc8e380e9683', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ac50c35d-0d07-4a34-a952-a749ef85c459', N'db71cf78-8417-4fc0-aabf-4b955796d9a2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ac63eac3-a4d7-4bde-8cd6-982c0447eb5f', N'9a7e6cfe-cd60-4ccd-8c14-af283303e936', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b23c3cde-b083-4f75-9326-3f7958524e64', N'520af6c2-5f31-488a-8970-0a390b7c9c34', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b550ac81-efd3-49ee-812d-d1c52c80f4f6', N'722fdfcc-02ee-4680-b684-fcc7230714cc', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b673b0cb-1414-4980-9ee4-2937afedee84', N'07d35985-0229-40c3-aaed-0fce364b33c1', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b7520bf3-f7b3-4787-b3fa-3a11303a8fa5', N'8172fa8f-9ff5-475e-8d92-93fc731091eb', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bdb9607b-57c6-4de4-b9c3-538df853ee19', N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'be00ce43-8370-46d1-88ef-af1e886a5c58', N'de36105a-564c-478d-ad54-a9c6e64db410', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c1976a07-3288-4d02-86b0-a83b54360365', N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c1ac5606-b236-4cdc-931c-73fbd8fc5fe3', N'86de038f-e73a-4cf8-9d0c-3c488130396e', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c38d5b9f-6ec1-4bfe-804d-65613ef658f1', N'b8cfb588-5071-4035-9e0f-f7f14f2856e5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c4801b2a-9a81-4e98-b200-a34aa1888df9', N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c7e74ba8-0481-4b5b-a89c-bfbb76d0e452', N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c89d458b-f681-44a1-a6b5-01392f402587', N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'caff9dc4-c199-46eb-8e52-241a939014a1', N'dc736454-3856-4968-9662-4c1800a85f4a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cba94f6d-cc90-4a4f-9d17-e5f43e85b5e0', N'cc715473-7abd-4b07-8458-a07daaca6e15', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd119cfbe-8da6-4e92-a8be-b8d8c0c472c0', N'234ca81d-87b9-43a3-a215-2908500fb7c2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd2ee6e5b-1449-4045-ab52-b57f3dd9513d', N'17100aba-2fde-4a45-9e1c-4cf93f3b2248', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dca8884f-f705-4214-9e31-625c528f21a2', N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e35a28bc-94bb-4d18-96ff-9c5db138ac0b', N'18facde4-8d07-47db-b7be-ec800b01751b', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e3bb8a69-e340-4f09-bc61-83cfec30f46e', N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e5b5c4d3-7773-4b89-8f64-3304b1f7addb', N'5069d2f1-0dbe-4d29-ae69-130d560901c2', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e7a73526-cd10-4459-843e-ceb5b2b5628b', N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e847ff78-54c5-4d76-8121-a537aed01dd3', N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'eb34e665-842b-489a-a6ae-0e2f9471ad6d', N'aa016aeb-2fda-4e56-83ce-6286ab21c128', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ecc25ed5-ad8d-4fb0-9e3c-e8b5cd93b753', N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ee215f99-1475-4fa3-add3-c706cd2f6189', N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f11f8171-1d70-45cc-abe0-0bf415fcb7d0', N'26236d58-2ef6-493d-a936-3bb2a1efc1a3', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f45f0daf-6628-4270-9532-7b2a685f2172', N'7ee79c5f-71ac-40e4-90d2-913e2671666b', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f4b24f14-13c2-420b-aa02-7c71c391c383', N'5afe23dd-03a4-4857-b96d-55b011b9af72', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f82acdc7-0dce-42b4-96c7-86daca789c53', N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fa1f45d3-5a89-4184-b782-aa9cbc552128', N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fb2ae555-15d0-4cb9-b9f2-c43e42b05616', N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ff0b0ba7-e7a7-4393-937e-fb4745a78e03', N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ff6677af-bcbb-40b5-861c-ec941b1ce81c', N'fdc96a50-12cd-46db-9007-16ae4d4342e5', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fff80d3d-baec-475a-841c-07137aa5b89c', N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'54aac154-2c0a-471c-adfd-0469a65737cf', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a3ea8642-aa44-45f4-9b53-060b114819e5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4b7535a4-dd2e-4071-9080-09a340e427f6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'07d35985-0229-40c3-aaed-0fce364b33c1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5069d2f1-0dbe-4d29-ae69-130d560901c2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fdc96a50-12cd-46db-9007-16ae4d4342e5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6c104837-0a04-43d6-b200-177b98588522', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a36dadb4-a0e3-4a10-a52d-24273c131af1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'234ca81d-87b9-43a3-a215-2908500fb7c2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'04351640-3e1d-4810-a0f5-3147f12031a4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'89e4f583-900b-43ec-ab63-34e838f35a81', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'26236d58-2ef6-493d-a936-3bb2a1efc1a3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'86de038f-e73a-4cf8-9d0c-3c488130396e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'aee4bc17-1442-48b2-a95b-3ec265c58cd8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'13a8d3ba-6471-4747-9237-43c601343ed5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c71757fa-088e-4b46-9359-455061d6b753', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7eac8530-e743-4028-9434-48f8ba9a09ef', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'dc736454-3856-4968-9662-4c1800a85f4a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'17100aba-2fde-4a45-9e1c-4cf93f3b2248', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1dc84c88-352f-488c-a927-58032f88a3f4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'faff4451-6454-4dff-b4a9-6168f1edf526', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'aa016aeb-2fda-4e56-83ce-6286ab21c128', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fb07746a-f1b1-43f6-823f-643fb9100df1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c196270b-56d8-4eaa-8c52-69773420797a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'273e5d24-26ed-4c78-9de1-6ac406b3529a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'34492beb-def2-4437-97a8-7afa138e17c1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'26f81117-51f9-4638-aec4-801a6a296945', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'14435987-a010-4981-aa0f-80d1e4498d4f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'605f60cb-09e8-41c6-9ba4-829679b00c84', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'df7e2b4d-01f0-44d6-a7d6-8337225897c3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e31fdfff-824c-4a7d-a640-8f43a6c4f824', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ee347789-32ce-492c-a380-99eef0467543', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1c4dd748-6f03-430a-9d07-9b84e6a0902e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cc715473-7abd-4b07-8458-a07daaca6e15', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'de36105a-564c-478d-ad54-a9c6e64db410', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'9a7e6cfe-cd60-4ccd-8c14-af283303e936', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'324079a9-3676-4d46-9704-b6a7a707101e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'114535ed-507b-48dd-8a35-bbdc252a82a8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'41adc77a-62e3-4a81-8a90-c565ea54fcce', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'48ae5050-184c-44e4-861e-d256272b207d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'18facde4-8d07-47db-b7be-ec800b01751b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a66523be-f0b3-4420-aea5-ecba26c130be', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a97affbe-b4da-40f6-8055-f493cef4d9e5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f41f13d6-190d-4f8b-9432-f6423811314a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6a74f264-0c50-4201-8772-f71229bbf01c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b8cfb588-5071-4035-9e0f-f7f14f2856e5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1, 1, 1, NULL)


ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION
---- change document apis
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'4c196fb9-c36d-4ee3-9ef8-d8f088359963'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'5632c2b0-2839-4eb2-93dc-e9639a8e3e57'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'5b0e2cca-5e09-4c7a-981a-4287ea8fb218'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'6332e396-93b3-41ac-9daa-2c2ec99a6c5a'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'658f2678-349f-48b9-8432-db15fb7fa612'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'fce419a7-a41b-4c0f-ade0-d2347b3525a8'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'4c196fb9-c36d-4ee3-9ef8-d8f088359963'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'5632c2b0-2839-4eb2-93dc-e9639a8e3e57'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'5b0e2cca-5e09-4c7a-981a-4287ea8fb218'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'6332e396-93b3-41ac-9daa-2c2ec99a6c5a'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'658f2678-349f-48b9-8432-db15fb7fa612'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'fce419a7-a41b-4c0f-ade0-d2347b3525a8'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'01f789a5-5b28-4d78-a7f7-f81ada5addb3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'03888fdf-95d1-4a1a-bc9f-501f46f89cc9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0646462e-a23a-4b2b-925c-32a502ec40f7'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'07d11042-963a-42e7-9236-8919b766d1c9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0b77c173-ef96-420b-9148-767693b04a94'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0d37135b-5d41-4baf-ad5f-ca0cbecce7a4'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0d9bd5df-0dbb-4674-893f-aa56ea4dbda3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0dbbcee4-a338-48c4-be3a-7f0cf7be71a2'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'0f9447ea-345e-40b2-abba-83c99270ab25'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'10567d67-9d2b-427d-bcea-4e7be49bc058'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'139778e2-1e2a-4be1-8db2-724adb993121'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'15ef4ea0-bdff-4732-8c96-1363dae72e5d'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'168b9209-faa6-419c-927c-2fa7cdbab8a6'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'174e6562-1083-49a9-bf19-e9e796a2cdc6'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'191919f6-c540-42af-83cf-f2681a463617'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'1a598e46-5233-4df8-ad29-72e1a2eaa136'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'1d33648f-33fa-4e0f-b7f6-5f7accbfe620'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'1e9a9ef9-6259-48d5-8dea-af28dcd208c2'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'1fb8c6ca-2cce-4a5c-8b05-775da8f48d6c'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'215818a3-2b52-49a7-9db8-e71d5a203ac5'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'26b2d1e9-ba1f-4bb9-b9b8-a162e19d3f68'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'2a2ee41d-a06b-454d-813a-e3307d3e2bb9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'2dba6256-ef9c-4fdb-b503-a9c0c21876d3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'30456420-018e-44e1-bd2a-5c725915fbc9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'31206cf7-a845-4937-999b-345e2872ddad'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'31daf04a-d730-43fd-af9c-4fa2754a5c1f'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'324853bf-c6bc-49a7-8aba-5f1e67ad1888'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'340b5e11-97a5-4b94-a80a-cfc4ac88d0a0'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'3675df95-a694-44cb-950b-8bd9e2a77149'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'396cc0bb-cfed-4d3a-b2ce-ec2b50f9cab6'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'39f29d8a-c800-42f3-8448-ad32e95d4693'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'3a8b4285-91ed-4a25-a25a-932cad9952b4'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'3c336b13-d724-4196-ad83-cf5cf90c4764'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'3d57c858-27cb-428f-b954-f276fce76770'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'3d7399ab-e08a-42c4-88a2-325aad7803ee'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'401769fd-218d-4e37-9b27-2ca7c6dc687a'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'43c496e6-5c9a-4dd7-a52d-7139d8c96e4c'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'4a023d94-9bf2-4035-962d-148df192bd82'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'4c623d72-6cff-400a-84fd-439dc29b04ce'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'4df992ea-f760-4472-8f2b-a561899683a0'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'4ea9f8ad-390d-42f0-bee0-fc8681f383f7'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'4faf0752-2f73-4254-b35d-8ff0428961d9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'577a2de0-8aba-4b8f-8618-e93e238e19c6'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'5bd76d47-a3e2-44a6-a3ed-e1c332bf31f3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'5c75a192-b3f7-4d03-8156-bbb838983d32'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'5e0bb5b8-6e51-4552-a1b4-b8bed38bd3dc'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'5f3f2eac-d51b-4e1c-8445-5b8fff88e406'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'60a5deb8-84cc-4345-b5d1-0e675441097d'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'61ea3ffb-d9fe-469f-9a81-67f85a457f9a'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'63d1ca30-2e95-401f-88e5-9779f4b3a85a'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'6402a8c6-0ec6-4773-9e10-1ffcc8269488'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'67ce7b20-5972-4e3d-b5ab-dbd9ea156c10'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'6d68d5f9-2fe6-40f1-8f20-14477ed39b1d'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'6fdf3db1-5813-4b58-9257-842f41b759bd'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'743684a8-9c25-445b-ba10-62f55d464eb4'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'752619f7-6bb5-4933-8d20-67850597376b'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'774eeb61-0cb4-4faa-8416-98ab192479bc'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'79529e9a-ecf6-4ee4-a7bd-e7df16a94641'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'7d84ff22-664f-4241-a05c-66d3a6ab9e17'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'7e4430e3-5d36-4f28-bfe2-24980a2acc25'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'7f85061a-4e66-40bb-86ca-b744d9195dfe'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'803cbb6a-a79f-4485-a638-cf0cf7251ddb'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8604e621-ca28-48c9-a1c3-995d8c1ec37e'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'86dd6018-d2b1-412c-8221-5791b5c3cfef'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8753bd80-b93b-4127-a78f-22f7ad57ab89'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'89c60084-9983-446a-82a0-0689c3763e16'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8a9e4776-7a23-4304-b145-94b8a12dd530'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8b66b2c1-6f11-4ebc-8644-96afbf8e8e11'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8c6568c5-5025-48a8-9a8a-3ddb83598d1b'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'8d101bcb-1c18-40a5-bb83-b0565b883f38'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'9598aee5-6cbc-47f7-bace-ca604e3ca1c5'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'95e132aa-814e-41b8-8038-91bd02c10cff'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'a6214304-a55d-4dfd-8033-f51290773912'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'aa44d0fb-5f9e-4b2f-9eeb-ff4b28507e24'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ac50c35d-0d07-4a34-a952-a749ef85c459'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ac63eac3-a4d7-4bde-8cd6-982c0447eb5f'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'b23c3cde-b083-4f75-9326-3f7958524e64'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'b550ac81-efd3-49ee-812d-d1c52c80f4f6'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'b673b0cb-1414-4980-9ee4-2937afedee84'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'b7520bf3-f7b3-4787-b3fa-3a11303a8fa5'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'bdb9607b-57c6-4de4-b9c3-538df853ee19'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'be00ce43-8370-46d1-88ef-af1e886a5c58'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c1976a07-3288-4d02-86b0-a83b54360365'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c1ac5606-b236-4cdc-931c-73fbd8fc5fe3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c38d5b9f-6ec1-4bfe-804d-65613ef658f1'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c4801b2a-9a81-4e98-b200-a34aa1888df9'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c7e74ba8-0481-4b5b-a89c-bfbb76d0e452'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'c89d458b-f681-44a1-a6b5-01392f402587'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'caff9dc4-c199-46eb-8e52-241a939014a1'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'cba94f6d-cc90-4a4f-9d17-e5f43e85b5e0'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'd119cfbe-8da6-4e92-a8be-b8d8c0c472c0'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'd2ee6e5b-1449-4045-ab52-b57f3dd9513d'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'dc253fe8-e90e-478c-a9eb-ae074b0186cc'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'dca8884f-f705-4214-9e31-625c528f21a2'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'e35a28bc-94bb-4d18-96ff-9c5db138ac0b'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'e3bb8a69-e340-4f09-bc61-83cfec30f46e'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'e5b5c4d3-7773-4b89-8f64-3304b1f7addb'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'e7a73526-cd10-4459-843e-ceb5b2b5628b'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'e847ff78-54c5-4d76-8121-a537aed01dd3'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'eb34e665-842b-489a-a6ae-0e2f9471ad6d'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ecc25ed5-ad8d-4fb0-9e3c-e8b5cd93b753'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ee215f99-1475-4fa3-add3-c706cd2f6189'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'f11f8171-1d70-45cc-abe0-0bf415fcb7d0'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'f45f0daf-6628-4270-9532-7b2a685f2172'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'f4b24f14-13c2-420b-aa02-7c71c391c383'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'f66d42d8-fa64-4893-9e0d-6c6fcae1bf1b'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'f82acdc7-0dce-42b4-96c7-86daca789c53'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'fa1f45d3-5a89-4184-b782-aa9cbc552128'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'fb2ae555-15d0-4cb9-b9f2-c43e42b05616'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ff0b0ba7-e7a7-4393-937e-fb4745a78e03'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'ff6677af-bcbb-40b5-861c-ec941b1ce81c'
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'f40650cb-aa58-48a8-a4df-9744e6b81698' WHERE [IdFunctionnalityModule]=N'fff80d3d-baec-475a-841c-07137aa5b89c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'0d3c5478-4f0b-4420-8487-0253965f13e4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'0ec9414c-f61c-42e7-a6d1-d385805ea56a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'1e6085e5-016f-4559-adf1-b4faa4d7b04c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'1f3d2cfc-2e16-489c-9109-c387119d4235'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'1f73097e-bce2-4542-82c2-e5ae63da771a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'24d33f67-896e-4d8c-a144-d4b135acb1ab'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'263e8097-5d9a-4889-a400-83632de009f1'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'2834d5b9-b2ba-411b-9a31-e484127f21a6'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'30219e48-458b-4f89-a100-f531d8cbf71e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'31ccc003-e4f4-41aa-91a7-ef23d2aa50b5'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'37a6ffb3-0cc0-4a9a-a8b1-9753053d048f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'44d9d882-a17b-4d83-ba1c-c06d61c37fdb'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'4659db0e-8aa2-4986-b963-6fb4b4663a0f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'466b6a5b-7d1b-4ead-9bf9-c4b213b6c434'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'4cdf29a8-b332-47ea-b77c-8003438ad0a7'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'4d03c841-faaa-4e9a-a2e6-d79e997f9373'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'4d18eba8-86d3-4130-a2f3-2d0011120d50'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'4f8f8d45-b094-4feb-b436-268f350d00f3'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'53685571-bf4a-406b-9e8a-acce303805b3'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'55f283c6-e8f8-4b26-805c-e667340fc7e1'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'57ca3c82-8b1d-446d-98c1-91d2b7087353'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'5d3353a3-6d89-4440-8a84-e541c207a715'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'5ee624bb-7e69-4c50-be75-9525bd1ff96e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'618a96a4-d5e9-4ba9-8f1d-a54fd2752ff3'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'64adcc31-fbf1-4da1-bfdf-972475de451a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'6905e6d6-fea2-4bd3-ab94-a6ed60c5c5c0'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'6920c9c6-99ad-49e6-9984-f8058522eae2'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'6a7ed8d6-21b2-491e-86d6-fe94cd60ca73'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'7a24421e-32ea-456a-9279-56e4c966dcf8'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'8b28faf9-8aa5-449d-bbde-d6e51512e6e7'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'8ba6868d-cf19-4a81-a846-8b7dd0814d7f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'9651e4c1-e496-4761-9600-9365987e8eb0'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'96d78fde-af7a-489a-8f41-26750dd54ee2'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'a3b00915-be62-4f2c-80d0-3a88ae446d8c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'a68abbd1-18d2-4a0e-a607-da4ec8fc4f74'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'a6f06064-ed82-4654-9b67-a24cb006d7a3'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'a85dba59-9cc9-4926-9075-1f858c6a897a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'b366cb74-b19b-43fb-83d7-331c8c8052d4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'b54643fa-76a4-4efb-b3ef-b7eb562fcc99'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'b8381d57-2c07-471e-88ea-fd9a6fd11025'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/insertDocument' WHERE [IdServiceParameters]=N'ba2eb1be-1703-4cad-ba12-64a42e326e92'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'bacf808e-2ea2-4455-932a-366421eb3664'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/deleteDocument/:id' WHERE [IdServiceParameters]=N'bb7b0487-2c8b-425a-9df1-fa0cdc01b0a0'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'c02978a0-aa73-42d7-ab66-b223e40874f6'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'cca307ca-5711-4184-aada-f404ae086045'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/updateDocument' WHERE [IdServiceParameters]=N'dbfbf1fb-5147-4b91-a56d-531b3060f2f1'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'e262eed5-f18b-41a2-b52c-c08f6ebc1bf4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'e277b484-cdf5-41a3-97c8-33e60cff2ac6'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'e90fa8f8-1112-400f-8d4a-f0821a975a0a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/getDocumentById/:id' WHERE [IdServiceParameters]=N'ecd9e90f-67e5-42c1-9486-6d62ffb07a97'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', N'CurrencyRate-LIST', 4, N'CurrencyRate', N'CurrencyRate', N'CurrencyRate', N'CurrencyRate', N'CurrencyRate', N'CurrencyRate', N'/divers/diversfunctionalities/list', 0, N'LIST-CurrencyRate')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', N'DiversFunctionalities', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 9, N'DiversFunctionalities', N'DiversFunctionalities', N'DiversFunctionalities', N'DiversFunctionalities', N'DiversFunctionalities', N'DiversFunctionalities', N'icon-note', 0)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 1, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f8e3c47c-ea4b-4028-904e-7d27dbd3fab1', N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION
---- nihel: add validate and print functionalities to document
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'0156ec76-73ef-44c2-aa58-fc8e380e9683'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'04351640-3e1d-4810-a0f5-3147f12031a4'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'07d35985-0229-40c3-aaed-0fce364b33c1'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'114535ed-507b-48dd-8a35-bbdc252a82a8'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'13a8d3ba-6471-4747-9237-43c601343ed5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'14435987-a010-4981-aa0f-80d1e4498d4f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'17100aba-2fde-4a45-9e1c-4cf93f3b2248'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'18facde4-8d07-47db-b7be-ec800b01751b'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'1c4dd748-6f03-430a-9d07-9b84e6a0902e'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'1dc84c88-352f-488c-a927-58032f88a3f4'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'21c8a894-f7d6-4747-bbc4-c2b21e733568'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'234ca81d-87b9-43a3-a215-2908500fb7c2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'26236d58-2ef6-493d-a936-3bb2a1efc1a3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'26f81117-51f9-4638-aec4-801a6a296945'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'273e5d24-26ed-4c78-9de1-6ac406b3529a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'29132ca2-1891-40bd-96d3-7dcf4a2bb816'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'30d722ce-e903-4fbb-a047-b3e6f50a5d60'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'324079a9-3676-4d46-9704-b6a7a707101e'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'34492beb-def2-4437-97a8-7afa138e17c1'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'3761b8fd-6b23-4d86-81de-eb6de7891a5a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'3a77dfc3-7392-411c-aa42-078753a10e7b'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'3e152b0f-dc4c-4416-8352-8569e8343fe9'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'4046572a-ab91-4548-bcfc-7747eb7df41c'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'4095f424-c8be-4707-9e22-5cdcb62a3eba'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'41adc77a-62e3-4a81-8a90-c565ea54fcce'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'44142e0e-7505-4961-9402-9a89fbb12ca7'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'48ae5050-184c-44e4-861e-d256272b207d'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'49c9ef74-ab94-4204-8b9a-e935540468cf'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'4b7535a4-dd2e-4071-9080-09a340e427f6'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'4d5682dc-047a-4c47-8de1-b57cdd620cb4'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'5069d2f1-0dbe-4d29-ae69-130d560901c2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'51897e01-9b8a-473a-b20b-4d1b5f572d87'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'520af6c2-5f31-488a-8970-0a390b7c9c34'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'54aac154-2c0a-471c-adfd-0469a65737cf'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'5afe23dd-03a4-4857-b96d-55b011b9af72'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'605f60cb-09e8-41c6-9ba4-829679b00c84'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'6a74f264-0c50-4201-8772-f71229bbf01c'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'6c104837-0a04-43d6-b200-177b98588522'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'6ff78f47-541e-4bab-a71c-f0350adb3543'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'722fdfcc-02ee-4680-b684-fcc7230714cc'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'7eac8530-e743-4028-9434-48f8ba9a09ef'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'7ee79c5f-71ac-40e4-90d2-913e2671666b'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'7f0aac88-e922-4d37-923f-125c9cd8d5f2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'80f4e203-94e3-400b-a7e7-6c08a7e132e9'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'8172fa8f-9ff5-475e-8d92-93fc731091eb'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'86de038f-e73a-4cf8-9d0c-3c488130396e'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'89e4f583-900b-43ec-ab63-34e838f35a81'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'9a7e6cfe-cd60-4ccd-8c14-af283303e936'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'a36dadb4-a0e3-4a10-a52d-24273c131af1'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'a3ea8642-aa44-45f4-9b53-060b114819e5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'a66523be-f0b3-4420-aea5-ecba26c130be'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'a97affbe-b4da-40f6-8055-f493cef4d9e5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'aa016aeb-2fda-4e56-83ce-6286ab21c128'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'aee4bc17-1442-48b2-a95b-3ec265c58cd8'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'b8cfb588-5071-4035-9e0f-f7f14f2856e5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'c196270b-56d8-4eaa-8c52-69773420797a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'c5a223f3-5d06-455a-8c50-65ad56f7059b'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'c64cde5d-5fe9-4545-830d-4f967fdef70a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'c71757fa-088e-4b46-9359-455061d6b753'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'cc715473-7abd-4b07-8458-a07daaca6e15'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'db71cf78-8417-4fc0-aabf-4b955796d9a2'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'dc736454-3856-4968-9662-4c1800a85f4a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'de36105a-564c-478d-ad54-a9c6e64db410'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'df7e2b4d-01f0-44d6-a7d6-8337225897c3'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'e0490245-3f54-4720-b7c0-d36591f5ffed'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'e31fdfff-824c-4a7d-a640-8f43a6c4f824'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'eb8e51f1-2239-43c2-b606-3547a0f96ee7'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'ee347789-32ce-492c-a380-99eef0467543'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'f41f13d6-190d-4f8b-9432-f6423811314a'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'f6b1ec86-245f-425d-a557-18c8fbc38f9f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'faff4451-6454-4dff-b4a9-6168f1edf526'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'fb07746a-f1b1-43f6-823f-643fb9100df1'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=15 WHERE [IdFunctionality]=N'fdc96a50-12cd-46db-9007-16ae4d4342e5'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1'
UPDATE [ERPSettings].[Functionality] SET [IdRequestType]=3 WHERE [IdFunctionality]=N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', N'PRINT-PurchaseInvoice', 8, N'PRINT-PurchaseInvoice', N'PRINT-PurchaseInvoice', N'PRINT-PurchaseInvoice', N'PRINT-PurchaseInvoice', N'PRINT-PurchaseInvoice', N'PRINT-PurchaseInvoice', N'/administration/taxetype/show', 0, N'PRINT-PurchaseInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'18fbb831-3560-4576-a594-6f16ddd1df05', N'PRINT-SalesQuotation', 8, N'PRINT-SalesQuotation', N'PRINT-SalesQuotation', N'PRINT-SalesQuotation', N'PRINT-SalesQuotation', N'PRINT-SalesQuotation', N'PRINT-SalesQuotation', N'/payroll/salarystructure/show', 0, N'PRINT-SalesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'25803ebb-f8d0-4058-ae1d-29e742224932', N'PRINT-PurchasesQuotation', 8, N'PRINT-PurchasesQuotation', N'PRINT-PurchasesQuotation', N'PRINT-PurchasesQuotation', N'PRINT-PurchasesQuotation', N'PRINT-PurchasesQuotation', N'PRINT-PurchasesQuotation', N'/payment/suppliersettlement/show', 0, N'PRINT-PurchasesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2755658f-cb5e-41e9-8298-c97721bdba77', N'VALIDATE-SalesDelivery', 8, N'VALIDATE-SalesDelivery', N'VALIDATE-SalesDelivery', N'VALIDATE-SalesDelivery', N'VALIDATE-SalesDelivery', N'VALIDATE-SalesDelivery', N'VALIDATE-SalesDelivery', N'/stock/inventorymovement/show', 0, N'VALIDATE-SalesDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4724ac7e-70b1-458f-acf9-a8629521faa3', N'VALIDATE-PurchaseRequest', 8, N'VALIDATE-PurchaseRequest', N'VALIDATE-PurchaseRequest', N'VALIDATE-PurchaseRequest', N'VALIDATE-PurchaseRequest', N'VALIDATE-PurchaseRequest', N'VALIDATE-PurchaseRequest', N'/payroll/constantrate/show', 0, N'VALIDATE-PurchaseRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'53d212dd-b678-4888-9208-b66fa0042ff2', N'VALIDATE-PurchaseAsset', 8, N'VALIDATE-PurchaseAsset', N'VALIDATE-PurchaseAsset', N'VALIDATE-PurchaseAsset', N'VALIDATE-PurchaseAsset', N'VALIDATE-PurchaseAsset', N'VALIDATE-PurchaseAsset', N'/administration/measureunit/show', 0, N'VALIDATE-PurchaseAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', N'VALIDATE-PurchasesQuotation', 8, N'VALIDATE-PurchasesQuotation', N'VALIDATE-PurchasesQuotation', N'VALIDATE-PurchasesQuotation', N'VALIDATE-PurchasesQuotation', N'VALIDATE-PurchasesQuotation', N'VALIDATE-PurchasesQuotation', N'/payment/suppliersettlement/show', 0, N'VALIDATE-PurchasesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'603beed9-c3c3-46e1-8560-19706553c33c', N'VALIDATE-SalesInvoice', 8, N'VALIDATE-SalesInvoice', N'VALIDATE-SalesInvoice', N'VALIDATE-SalesInvoice', N'VALIDATE-SalesInvoice', N'VALIDATE-SalesInvoice', N'VALIDATE-SalesInvoice', N'/stock/warehouse/show', 0, N'VALIDATE-SalesInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', N'VALIDATE-PurchaseDelivery', 8, N'VALIDATE-PurchaseDelivery', N'VALIDATE-PurchaseDelivery', N'VALIDATE-PurchaseDelivery', N'VALIDATE-PurchaseDelivery', N'VALIDATE-PurchaseDelivery', N'VALIDATE-PurchaseDelivery', N'/purchase/purchaseasset/show', 0, N'VALIDATE-PurchaseDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', N'PRINT-SalesInvoice', 8, N'PRINT-SalesInvoice', N'PRINT-SalesInvoice', N'PRINT-SalesInvoice', N'PRINT-SalesInvoice', N'PRINT-SalesInvoice', N'PRINT-SalesInvoice', N'/stock/warehouse/show', 0, N'PRINT-SalesInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'888c5233-b854-478e-b3e6-860eb288a09c', N'VALIDATE-PurchaseOrder', 8, N'VALIDATE-PurchaseOrder', N'VALIDATE-PurchaseOrder', N'VALIDATE-PurchaseOrder', N'VALIDATE-PurchaseOrder', N'VALIDATE-PurchaseOrder', N'VALIDATE-PurchaseOrder', N'/payroll/constantvalue/show', 0, N'VALIDATE-PurchaseOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', N'PRINT-PurchaseOrder', 8, N'PRINT-PurchaseOrder', N'PRINT-PurchaseOrder', N'PRINT-PurchaseOrder', N'PRINT-PurchaseOrder', N'PRINT-PurchaseOrder', N'PRINT-PurchaseOrder', N'/payroll/constantvalue/show', 0, N'PRINT-PurchaseOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b8afa156-3522-420c-9118-c7fce2208fcb', N'VALIDATE-PurchaseInvoice', 8, N'VALIDATE-PurchaseInvoice', N'VALIDATE-PurchaseInvoice', N'VALIDATE-PurchaseInvoice', N'VALIDATE-PurchaseInvoice', N'VALIDATE-PurchaseInvoice', N'VALIDATE-PurchaseInvoice', N'/administration/taxetype/show', 0, N'VALIDATE-PurchaseInvoice')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', N'PRINT-SalesOrder', 8, N'PRINT-SalesOrder', N'PRINT-SalesOrder', N'PRINT-SalesOrder', N'PRINT-SalesOrder', N'PRINT-SalesOrder', N'PRINT-SalesOrder', N'/administration/ville/show', 0, N'PRINT-SalesOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', N'PRINT-PurchaseAsset', 8, N'PRINT-PurchaseAsset', N'PRINT-PurchaseAsset', N'PRINT-PurchaseAsset', N'PRINT-PurchaseAsset', N'PRINT-PurchaseAsset', N'PRINT-PurchaseAsset', N'/administration/measureunit/show', 0, N'PRINT-PurchaseAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c8ae1043-e193-410f-a0ce-51a673b812e0', N'PRINT-SalesDelivery', 8, N'PRINT-SalesDelivery', N'PRINT-SalesDelivery', N'PRINT-SalesDelivery', N'PRINT-SalesDelivery', N'PRINT-SalesDelivery', N'PRINT-SalesDelivery', N'/stock/inventorymovement/show', 0, N'PRINT-SalesDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cc05f689-5a26-4084-957f-468ffa646d39', N'VALIDATE-SalesOrder', 8, N'VALIDATE-SalesOrder', N'VALIDATE-SalesOrder', N'VALIDATE-SalesOrder', N'VALIDATE-SalesOrder', N'VALIDATE-SalesOrder', N'VALIDATE-SalesOrder', N'/administration/ville/show', 0, N'VALIDATE-SalesOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', N'VALIDATE-SalesQuotation', 8, N'VALIDATE-SalesQuotation', N'VALIDATE-SalesQuotation', N'VALIDATE-SalesQuotation', N'VALIDATE-SalesQuotation', N'VALIDATE-SalesQuotation', N'VALIDATE-SalesQuotation', N'/payroll/salarystructure/show', 0, N'VALIDATE-SalesQuotation')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', N'VALIDATE-SalesAsset', 8, N'VALIDATE-SalesAsset', N'VALIDATE-SalesAsset', N'VALIDATE-SalesAsset', N'VALIDATE-SalesAsset', N'VALIDATE-SalesAsset', N'VALIDATE-SalesAsset', N'/stock/nature/show', 0, N'VALIDATE-SalesAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e7481cae-21d5-4239-ba7a-60ead03573c3', N'PRINT-SalesAsset', 8, N'PRINT-SalesAsset', N'PRINT-SalesAsset', N'PRINT-SalesAsset', N'PRINT-SalesAsset', N'PRINT-SalesAsset', N'PRINT-SalesAsset', N'/stock/nature/show', 0, N'PRINT-SalesAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', N'PRINT-PurchaseDelivery', 8, N'PRINT-PurchaseDelivery', N'PRINT-PurchaseDelivery', N'PRINT-PurchaseDelivery', N'PRINT-PurchaseDelivery', N'PRINT-PurchaseDelivery', N'PRINT-PurchaseDelivery', N'/purchase/purchaseasset/show', 0, N'PRINT-PurchaseDelivery')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ecd91131-4e0f-4db6-9bcf-85c887427136', N'PRINT-PurchaseRequest', 8, N'PRINT-PurchaseRequest', N'PRINT-PurchaseRequest', N'PRINT-PurchaseRequest', N'PRINT-PurchaseRequest', N'PRINT-PurchaseRequest', N'PRINT-PurchaseRequest', N'/payroll/constantrate/show', 0, N'PRINT-PurchaseRequest')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'603beed9-c3c3-46e1-8560-19706553c33c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cc05f689-5a26-4084-957f-468ffa646d39', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'888c5233-b854-478e-b3e6-860eb288a09c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'53d212dd-b678-4888-9208-b66fa0042ff2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b8afa156-3522-420c-9118-c7fce2208fcb', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'2755658f-cb5e-41e9-8298-c97721bdba77', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'25803ebb-f8d0-4058-ae1d-29e742224932', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'18fbb831-3560-4576-a594-6f16ddd1df05', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'00600609-bd9c-41e6-a953-e7d81ff499c4', N'ecd91131-4e0f-4db6-9bcf-85c887427136', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'078f271e-0d42-401b-b79e-c7136f94e1d7', N'e7481cae-21d5-4239-ba7a-60ead03573c3', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'19874d0b-e5b1-4725-81b0-8f670a78646e', N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'238325de-b4c2-46cd-b768-532ed747bd26', N'4724ac7e-70b1-458f-acf9-a8629521faa3', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2738a15c-9bcf-431f-a0f6-11530ec24edd', N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'35651e56-d092-4638-bd92-84be8094c7ff', N'603beed9-c3c3-46e1-8560-19706553c33c', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3c0b44a4-160b-4887-b7e1-a219a06ecf46', N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5cc49e88-0bd5-40f2-82cc-4c2bc55b4f3e', N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'60f7f740-5f61-44e0-b2ad-0bf72a53dd46', N'b8afa156-3522-420c-9118-c7fce2208fcb', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'68d1107d-f5e0-4fc0-9bc7-85b6045d4b3c', N'888c5233-b854-478e-b3e6-860eb288a09c', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7ad8eef5-0358-49e4-ac15-eb3d7c5eaf7f', N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'8e9906a4-3009-497a-a4d0-91244bc7a1ba', N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'987a116f-7526-4493-a4cd-aabd5efb1dcc', N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9e78722b-17fb-47a2-947a-3adfbbc32149', N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a8204d0b-3c38-4750-9d03-55d628c44502', N'18fbb831-3560-4576-a594-6f16ddd1df05', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b33dbb94-d204-4f5a-901b-424021433b38', N'c8ae1043-e193-410f-a0ce-51a673b812e0', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b3dd03a8-6798-4ec8-b17d-fc05c6532407', N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b51eb79c-368d-4248-94e8-02cd82592eb3', N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cd469c30-7b94-408e-aebd-b7c3186fb976', N'2755658f-cb5e-41e9-8298-c97721bdba77', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd0f570d5-85ad-48b6-88b7-7591154fd8ec', N'53d212dd-b678-4888-9208-b66fa0042ff2', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'edb6498d-7c48-41ac-bebb-da9e4e196320', N'cc05f689-5a26-4084-957f-468ffa646d39', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ff376326-fba9-4198-9d66-48a028fbcef9', N'25803ebb-f8d0-4058-ae1d-29e742224932', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
--- nihel, secure settlment
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
DELETE FROM [ERPSettings].[FunctionalityByRole] WHERE [IdFunctionality]=N'13a8d3ba-6471-4747-9237-43c601343ed5'
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'9598aee5-6cbc-47f7-bace-ca604e3ca1c5'
DELETE FROM [ERPSettings].[Functionality] WHERE [IdFunctionality]=N'13a8d3ba-6471-4747-9237-43c601343ed5'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-OutcomingSettlement' WHERE [IdFunctionality]=N'0b2784fb-2158-461f-a83c-08b221cea5c7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'DELETE-IncomingSettlement' WHERE [IdFunctionality]=N'18facde4-8d07-47db-b7be-ec800b01751b'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-IncomingSettlement' WHERE [IdFunctionality]=N'1c969e3f-5fb9-42c1-8a39-8c84122aded1'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-IncomingSettlement' WHERE [IdFunctionality]=N'45b5e4ac-25c1-42a7-963d-2491b4d13ece'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-OutcomingSettlement' WHERE [IdFunctionality]=N'681c3f06-93ec-4d82-928a-21425d6dbb91'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-IncomingSettlement' WHERE [IdFunctionality]=N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-IncomingSettlement' WHERE [IdFunctionality]=N'93481abc-8bc8-4b26-b02b-d2eb935903d6'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'ADD-OutcomingSettlement' WHERE [IdFunctionality]=N'b6875160-0302-4d15-9bd9-3431e21aeb24'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'DELETE-OutcomingSettlement' WHERE [IdFunctionality]=N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'SHOW-OutcomingSettlement' WHERE [IdFunctionality]=N'eb8e51f1-2239-43c2-b606-3547a0f96ee7'
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'LIST-OutcomingSettlement' WHERE [IdFunctionality]=N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3'

UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters] = N'faf9b3d2-cf86-47e7-aa86-0bec0311d68f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForAddOperation' WHERE [IdServiceParameters] = N'7007afa5-0b50-4cfa-ae97-0bf1c77345dd'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForAddOperation' WHERE [IdServiceParameters] = N'610290d9-d63a-4a72-9561-1bced1ba465a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/updateSettlement' WHERE [IdServiceParameters] = N'a99e60e7-689e-4271-818b-45f187a6970e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForAddOperation' WHERE [IdServiceParameters] = N'f061e68e-ad3e-40d8-aef4-4f820bcf1e84'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters] = N'c50ae9ed-19a9-4cfa-93b8-54a5094db0ee'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters] = N'908098b5-dd07-4f1b-a1aa-62fc1464ce49'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/validate' WHERE [IdServiceParameters] = N'8fa54397-04a3-4367-974f-667edeb15327'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/insertSettlement' WHERE [IdServiceParameters] = N'4db51959-93b8-4ac5-9718-82ebf884057a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForUpdateOperation' WHERE [IdServiceParameters] = N'1c6fe761-5ae7-4337-9848-95170f47be24'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForAddOperation' WHERE [IdServiceParameters] = N'37ca45f2-cc93-47fc-93d4-a3d072d20bfe'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters] = N'42d157df-c132-49c2-b88f-a458bbe9210e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForUpdateOperation' WHERE [IdServiceParameters] = N'21c6882e-dde0-45e8-a78a-b1757c62172f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/insertSettlement' WHERE [IdServiceParameters] = N'71018828-0bc4-43fc-9468-c5dc1f29b46d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/updateSettlement' WHERE [IdServiceParameters] = N'541566fa-62db-4545-a404-c8763cc0ffba'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForUpdateOperation' WHERE [IdServiceParameters] = N'a9cdd479-a46b-426d-8a39-d7e473d3dc5f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/getCommitmentForUpdateOperation' WHERE [IdServiceParameters] = N'9c35c0ed-a011-4eb3-8c94-daffaac5b09f'
UPDATE [ERPSettings].[ServiceParameters] SET [URL] =N'/api/settlement/validate' WHERE [IdServiceParameters] = N'e404501e-8897-49da-82e3-fe81d2e7afd9'

UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/deleteSettlement/:id' WHERE [IdServiceParameters]=N'40dd7df2-2257-4f63-aeac-05d64fc5cdf7'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters]=N'42d157df-c132-49c2-b88f-a458bbe9210e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/insertSettlement' WHERE [IdServiceParameters]=N'4db51959-93b8-4ac5-9718-82ebf884057a'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/updateSettlement' WHERE [IdServiceParameters]=N'541566fa-62db-4545-a404-c8763cc0ffba'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/deleteSettlement/:id' WHERE [IdServiceParameters]=N'56045e99-0321-4609-97dc-645a34655ad4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/insertSettlement' WHERE [IdServiceParameters]=N'71018828-0bc4-43fc-9468-c5dc1f29b46d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters]=N'908098b5-dd07-4f1b-a1aa-62fc1464ce49'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlement' WHERE [IdServiceParameters]=N'a3ab7d51-734e-4d55-8bcf-e190d08e5efc'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/updateSettlement' WHERE [IdServiceParameters]=N'a99e60e7-689e-4271-818b-45f187a6970e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters]=N'c50ae9ed-19a9-4cfa-93b8-54a5094db0ee'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlement' WHERE [IdServiceParameters]=N'f092228e-e840-438c-9847-bb61e0697ecd'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/settlement/getSettlementById/:id' WHERE [IdServiceParameters]=N'faf9b3d2-cf86-47e7-aa86-0bec0311d68f'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', N'OutcomingSettlement-DELETE', 3, N'OutcomingSettlement-DELETE', N'OutcomingSettlement-DELETE', N'OutcomingSettlement-DELETE', N'OutcomingSettlement-DELETE', N'OutcomingSettlement-DELETE', N'OutcomingSettlement-DELETE', N'/divers/diversfunctionalities/delete', 0, N'DELETE-OutcomingSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', N'OutcomingSettlement-VALIDATE', 8, N'OutcomingSettlement-VALIDATE', N'OutcomingSettlement-VALIDATE', N'OutcomingSettlement-VALIDATE', N'OutcomingSettlement-VALIDATE', N'OutcomingSettlement-VALIDATE', N'OutcomingSettlement-VALIDATE', N'/divers/diversfunctionalities/validate', 0, N'VALIDATE-OutcomingSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8b5e351f-1067-4eeb-ac41-9151079de165', N'IncomingSettlement-DELETE', 3, N'IncomingSettlement-DELETE', N'IncomingSettlement-DELETE', N'IncomingSettlement-DELETE', N'IncomingSettlement-DELETE', N'IncomingSettlement-DELETE', N'IncomingSettlement-DELETE', N'/divers/diversfunctionalities/delete', 0, N'DELETE-IncomingSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b9875a52-3204-4d50-8c95-08b7018586ea', N'SettlementCommitment-LIST', 4, N'SettlementCommitment-LIST', N'SettlementCommitment-LIST', N'SettlementCommitment-LIST', N'SettlementCommitment-LIST', N'SettlementCommitment-LIST', N'SettlementCommitment-LIST', N'/divers/diversfunctionalities/list', 0, N'LIST-SettlementCommitment')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f259ce28-7dad-46f1-adf2-24e6436d79fa', N'IncomingSettlement-VALIDATE', 8, N'IncomingSettlement-VALIDATE', N'IncomingSettlement-VALIDATE', N'IncomingSettlement-VALIDATE', N'IncomingSettlement-VALIDATE', N'IncomingSettlement-VALIDATE', N'IncomingSettlement-VALIDATE', N'/divers/diversfunctionalities/validate', 0, N'VALIDATE-IncomingSettlement')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8b5e351f-1067-4eeb-ac41-9151079de165', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b9875a52-3204-4d50-8c95-08b7018586ea', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3296c4c2-9977-4c3b-8968-7c5b8ac32ab8', N'8b5e351f-1067-4eeb-ac41-9151079de165', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'396a0a6c-3ba5-4aac-8768-8f60ccb8a7ee', N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'426759b5-8fc7-425d-9812-1ddf4a67355b', N'b9875a52-3204-4d50-8c95-08b7018586ea', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a74617b1-c3ad-457a-8d48-55e7aa77110e', N'f259ce28-7dad-46f1-adf2-24e6436d79fa', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f6bf4b08-a6c8-453e-ad2e-3ded8a4639ce', N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

-- Narcisse : Functionnality by role

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_User]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_Module]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_User]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1cfd0212-4eef-4656-a703-f40f737708ab', N'Session-UPDATE', 2, N'Modifier session', N'Update session', NULL, NULL, NULL, NULL, N'/payroll/session/update', 1, N'UPDATE-Session')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'33b77acb-f6ad-4cfa-b919-99d5f5932851', N'Attendance-Show', 15, N'Visualiser pointages', N'Print attendance', NULL, NULL, NULL, NULL, N'/payroll/attendance/show', 1, N'SHOW-Attendance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'422f1608-e641-4ec1-9163-636bb3c6962b', N'PayslipDetails-ADD', 1, N'Ajouter details bulletins', N'Add payslip details', NULL, NULL, NULL, NULL, N'/payroll/payslipdetails/add', 1, N'ADD-PayslipDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', N'Payslip-DELETE', 3, N'Supprimer bulletin', N'Delete payslip', NULL, NULL, NULL, NULL, N'/payroll/payslip/delete', 1, N'DELETE-Payslip')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', N'PayslipDetails-LIST', 4, N'Liste details bulletin', N'Payslip details list', NULL, NULL, NULL, NULL, N'/payroll/payslipdetails/list', 0, N'LIST-PayslipDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'558d9955-927c-4078-91f0-d7ed9277877e', N'Bonus-DELETE', 3, N'Supprimer primes', N'Delete bonus', NULL, NULL, NULL, NULL, N'/payroll/bonus/delete', 1, N'DELETE-Bonus')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5b42320e-6062-4383-b8f6-e3100ab201bd', N'LIST-Session', 4, N'List des sessions', N'Session list', NULL, NULL, NULL, NULL, N'/payroll/session/list', 1, N'LIST-Session')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', N'Attendance-UPDATE', 2, N'Modifier pointages', N'Update attendance', NULL, NULL, NULL, NULL, N'/payroll/attendance/update', 1, N'UPDATE-Attendance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'72fff920-bbac-437e-866b-05fc4a6b5ea0', N'Session-Show', 15, N'Afficher session', N'Show session', NULL, NULL, NULL, NULL, N'/payroll/session/show', 1, N'SHOW-Session')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', N'Bonus-LIST', 4, N'Liste des primes', N'Bonus list', NULL, NULL, NULL, NULL, N'/payroll/bonus/list', 1, N'LIST-Bonus')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8724f683-d67a-46a8-8fd2-86f3f9586735', N'PayslipDetails-UPDATE', 2, N'Modifier details bulletin', N'Update paysip details', NULL, NULL, NULL, NULL, N'/payroll/payslipdetails/update', 0, N'UPDATE-PayslipDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8d6a9277-682f-4f30-ba42-44a4692fd69a', N'Bonus-Show', 15, N'Afficher bonus', N'Show bonus', NULL, NULL, NULL, NULL, N'/payroll/bonus/show', 1, N'SHOW-Bonus')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', N'Bonus-UPDATE', 2, N'Mise à jour bonus', N'Update bonus', NULL, NULL, NULL, NULL, N'/payroll/bonus/update', 1, N'UPDATE-Bonus')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a6618e04-9b2b-40c2-a947-c17f54da29de', N'Attendance-DELETE', 3, N'Supprimer pointages', N'Delete attendance', NULL, NULL, NULL, NULL, N'/payroll/attendance/delete', 1, N'DELETE-Attendance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', N'Session-ADD', 1, N'Ajout session', N'Add session', NULL, NULL, NULL, NULL, N'/payroll/session/add', 1, N'ADD-Session')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c1df5586-1d4d-477a-85bf-32a344c726ee', N'PayslipDetails-DELETE', 3, N'Supprimer details de bulletin', N'Delete payslip details', NULL, NULL, NULL, NULL, N'/payroll/payslipdetails/delete', 0, N'DELETE-PayslipDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cf9f36ce-6028-47da-9f59-da543c45ebde', N'Attendance-ADD', 1, N'Ajout pointage ', N'Add attendance', NULL, NULL, NULL, NULL, N'/payroll/attendance/add', 1, N'ADD-Attendance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', N'Attendance-LIST', 4, N'Modifier pointages', N'Update attendance', NULL, NULL, NULL, NULL, N'/payroll/attendance/list', 1, N'LIST-Attendance')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e0488c12-4dee-4420-98b1-25d91aa840f7', N'Session-DELETE', 3, N'Supprimer session', N'Delete session', NULL, NULL, NULL, NULL, N'/payroll/session/delete', 1, N'DELETE-Session')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'e5d585cd-594e-4546-baaf-885c9dca91b0', N'Payslip-Show', 15, N'Afficher bulletin', N'Show payslip', NULL, NULL, NULL, NULL, N'/payroll/payslip/show', 1, N'Show-Payslip')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', N'PayslipDetails-Show', 15, N'Visualiser details bulletins', N'Show payslip details', NULL, NULL, NULL, NULL, N'/payroll/payslipdetails/show', 0, N'SHOW-PayslipDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ef03d792-249e-4b31-b131-58f247fd399a', N'Bonus-ADD', 1, N'Ajout de bonus', N'Add bonus', NULL, NULL, NULL, NULL, N'/payroll/bonus/add', 1, N'ADD-Bonus')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', N'Bonus', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 13, N'Prime', N'Bonus', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', N'Attendance', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 14, N'Attendance', N'Attendance', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'79ce368b-ad81-4973-aae3-ff402f34cfbf', N'Session', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 12, N'Session', NULL, NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', N'PayslipDetails', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 15, N'Details bulletins', N'Payslip details', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 1, 1)

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'ef03d792-249e-4b31-b131-58f247fd399a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'558d9955-927c-4078-91f0-d7ed9277877e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1cfd0212-4eef-4656-a703-f40f737708ab', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'422f1608-e641-4ec1-9163-636bb3c6962b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'003f315f-dcf5-4cec-bfb2-2eb020db2ac8', N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', N'f8ff6b5e-d60b-4b83-9934-d6eee590c523')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0e97e938-544e-4ff3-88d8-44dd34a7dc52', N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'13a5761f-8bff-4a7a-855e-689eddf64326', N'8724f683-d67a-46a8-8fd2-86f3f9586735', N'f8ff6b5e-d60b-4b83-9934-d6eee590c523')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'19749910-52aa-4bbd-80d9-adf42384f386', N'a6618e04-9b2b-40c2-a947-c17f54da29de', N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1cc006cc-2700-474d-9873-dfed542024c5', N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', N'f8ff6b5e-d60b-4b83-9934-d6eee590c523')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2e009b58-6407-4e94-89d3-ea3548d5f77a', N'422f1608-e641-4ec1-9163-636bb3c6962b', N'f8ff6b5e-d60b-4b83-9934-d6eee590c523')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3fc28ce4-6f87-45c3-be3b-be6373b9d7b5', N'e5d585cd-594e-4546-baaf-885c9dca91b0', N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4295375a-43ba-4d34-a605-bf92d7ac6d89', N'72fff920-bbac-437e-866b-05fc4a6b5ea0', N'79ce368b-ad81-4973-aae3-ff402f34cfbf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4f1833d1-43b4-46ef-9014-64069f56dac2', N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4f6dece1-f538-45c5-920e-6f35b9621103', N'e0488c12-4dee-4420-98b1-25d91aa840f7', N'79ce368b-ad81-4973-aae3-ff402f34cfbf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5eb4c738-cbd4-4745-a963-3a416d7b5ec0', N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5fb1431b-b7db-4208-8a02-7fdf0ba58b3e', N'cf9f36ce-6028-47da-9f59-da543c45ebde', N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7f4c6503-4a5e-4bf1-ac87-1080d521fcf6', N'5b42320e-6062-4383-b8f6-e3100ab201bd', N'79ce368b-ad81-4973-aae3-ff402f34cfbf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9a1c0703-4c83-485f-a144-e6370cae6f45', N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'9c387d32-673d-47b2-933a-1278cfbd95aa', N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a13d3565-a847-4bab-ba05-1e736a222906', N'ef03d792-249e-4b31-b131-58f247fd399a', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ab1549eb-65c7-4b25-a804-c1b6d243f8c3', N'1cfd0212-4eef-4656-a703-f40f737708ab', N'79ce368b-ad81-4973-aae3-ff402f34cfbf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bd0cac0e-3b5c-4be4-9df7-8465d468b658', N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', N'79ce368b-ad81-4973-aae3-ff402f34cfbf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ddc61e07-078c-48ab-8342-a292d90b7358', N'c1df5586-1d4d-477a-85bf-32a344c726ee', N'f8ff6b5e-d60b-4b83-9934-d6eee590c523')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'efbb07c7-852c-4c86-afb9-36d4ac0eb6af', N'558d9955-927c-4078-91f0-d7ed9277877e', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f12658fc-c832-4bfe-aac2-6bdc6b89b187', N'33b77acb-f6ad-4cfa-b919-99d5f5932851', N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f66bdb8a-8822-45ab-a1cb-13587d8a6dd9', N'8d6a9277-682f-4f30-ba42-44a4692fd69a', N'15404a12-4c4e-485a-a2c8-bda14d9a35d8')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
-- notification v2: BOUBAKER
BEGIN TRANSACTION
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_INPUT_MVT', [Type]=N'INVENTORY_INTPUT_MVT_ADD' WHERE [IdInfo]=1000500009
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_OUTPUT_MVT', [Type]=N'INVENTORY_OUTPUT_MVT_ADD' WHERE [IdInfo]=1000500010
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_TRANSAFER_MVT', [Type]=N'INVENTORY_TRANSFER_MVT_ADD' WHERE [IdInfo]=1000500011
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_INVENTORY_MVT', [Type]=N'INVENTORY_INVENTORY_MVT_ADD' WHERE [IdInfo]=1000500012
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_INVOICE', [Type]=N'PURCHASE_INVOICE_ADD' WHERE [IdInfo]=1000500013
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_ASSET', [Type]=N'PURCHASE_PURCHASE_ASSET_ADD' WHERE [IdInfo]=1000500014
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_ORDER_FORM', [Type]=N'PURCHASE_PURCHASE_ORDER_ADD' WHERE [IdInfo]=1000500015
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_RECEIPT', [Type]=N'PURCHASE_RECEIPT_ADD' WHERE [IdInfo]=1000500016
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_ORDER_FORM', [Type]=N'SALES_ORDER_ADD' WHERE [IdInfo]=1000500017
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_DELIVERY_NOTE', [Type]=N'SALES_DELEVERY_NOTE_ADD' WHERE [IdInfo]=1000500018
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_INVOICE', [Type]=N'SALES_INVOICE_ADD' WHERE [IdInfo]=1000500019
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_ASSET', [Type]=N'SALES_ASSET_ADD' WHERE [IdInfo]=1000500020
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_QUOTATION', [Type]=N'SALES_QUOTATION_ADD' WHERE [IdInfo]=1000500022
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_PRICE_REQUEST', [Type]=N'SALES_PRICE_REQUEST_ADD' WHERE [IdInfo]=1000500023
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_CUSTOMERR_SETTLEMENT', [Type]=N'SALES_CUSTOMER_FINANCIAL_COMMITEMENT_REMIND' WHERE [IdInfo]=1000500024
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_SUPPLIER_SETTLEMENT', [Type]=N'SALES_SUPPLIER_FINANCIAL_COMMITEMENT_REMIND' WHERE [IdInfo]=1000500025
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_INVOICE', [Type]=N'SALES_INVOICE_VALIDATION' WHERE [IdInfo]=1000500026
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_ORDER_FORM', [Type]=N'SALES_ORDER_VALIDATION' WHERE [IdInfo]=1000500029
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_DELIVERY_NOTE', [Type]=N'SALES_DELEVERY_NOTE_VALIDATION' WHERE [IdInfo]=1000500033
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_QUOTATION', [Type]=N'SALES_QUOTATION_VALIDATION' WHERE [IdInfo]=1000500035
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_ASSET', [Type]=N'SALES_ASSET_VALIDATION' WHERE [IdInfo]=1000500039
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_RECEIPT', [Type]=N'PURCHASE_RECEIPT_VALIDATION' WHERE [IdInfo]=1000500041
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_INVOICE', [Type]=N'PURCHASE_INVOICE_VALIDATION' WHERE [IdInfo]=1000500043
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_ASSET', [Type]=N'PURCHASE_ASSET_VALIDATION' WHERE [IdInfo]=1000500045
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_QUOTATION', [Type]=N'PURCHASE_QUOTATION_VALIDATION' WHERE [IdInfo]=1000500047
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_ORDER_FORM', [Type]=N'PURCHASE_ORDER_VLIDATION' WHERE [IdInfo]=1000500048
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_INPUT_MVT', [Type]=N'INVENTORY_INTPUT_MVT_VALIDATION' WHERE [IdInfo]=1000500050
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_TRANSFER_MVT', [Type]=N'INVENTORY_TRANSFER_MVT_VALIDATION' WHERE [IdInfo]=1000500052
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_INVENTORY_MVT', [Type]=N'INVENTORY_INVENTORY_MVT_VALIDATION' WHERE [IdInfo]=1000500054
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_OUTPUT_MVT', [Type]=N'INVENTORY_OUTPUT_MVT_VALIDATION' WHERE [IdInfo]=1000500056
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_PURCHASE_REQUEST', [Type]=N'PURCHASE_PURCHASE_REQUEST_ADD' WHERE [IdInfo]=1000500060
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_PURCHASE_REQUEST', [Type]=N'PURCHASE_PURCHASE_REQUEST_REFUSE' WHERE [IdInfo]=1000500065
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_REFUSE_PURCHASE_REQUEST', [Type]=N'PURCHASE_PURCHASE_REQUEST_VALIDATION' WHERE [IdInfo]=1000500066
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_SUPPLIER_SETTLEMENT', [Type]=N'PAYMENT_SUPPLIER_SETTELEMENT_ADD' WHERE [IdInfo]=1000501065
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_SUPPLIER_SETTLEMENT', [Type]=N'PAYMENT_SUPPLIER_SETTELEMENT_VALIDATION' WHERE [IdInfo]=1000501066
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_ADD_CUSTOMERR_SETTLEMENT', [Type]=N'PAYMENT_CUSTOMER_SETTELEMENT_ADD' WHERE [IdInfo]=1000501067
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_VALIDATION_CUSTOMERR_SETTLEMENT', [Type]=N'PAYMENT_CUSTOMER_SETTELEMENT_VALIDATION' WHERE [IdInfo]=1000501068
COMMIT TRANSACTION
--fix information  translation key / BOUBAKER ECHEB
BEGIN TRANSACTION
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_REMIND_CUSTOMER_FINANTIAL_COMMITEMENT' WHERE [IdInfo]=1000500024
UPDATE [ERPSettings].[Information] SET [TranslationKey]=N'NOTIFICATION_REMIND_SUPPLIER_FINANTIAL_COMMITEMENT' WHERE [IdInfo]=1000500025
COMMIT TRANSACTION
--end fix information  translation key
--missing fonctionalities / BOUBAKER ECHIEB
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'038d55eb-5628-48f0-bc28-60e9b3a19a93', N'Document-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/DELETE-document/delete', 0, N'DELETE-Document')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1480a708-a100-4f72-9792-15232a0895c3', N'Information-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/LIST-Information/list', 0, N'LIST-Information')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1a33a525-bc0d-4974-a271-9779ba13b699', N'DiversFunctionalities-SAVE', 6, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/LIST-SettlementType/save', 0, N'SAVE-SettlementType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c', N'PaymentType-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/PaymentType-list/list', 0, N'LIST-PaymentType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4513ed01-2341-4581-b9b9-db7e81fe50c8', N'MsgNotification-LIST', 4, N'MsgNotification-LIST', N'MsgNotification-LIST', NULL, NULL, NULL, NULL, N'/divers/msgnotification/list', 0, N'LIST-MsgNotification')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'560c0361-0321-4690-a9b9-1391cb9d6451', N'PaymentMethod-SHOW', 15, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/SHOW-PaymentMethod/show', 0, N'SHOW-PaymentMethod')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', N'LIST-DiversFunctionalities', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/LIST-SettlementType/list', 0, N'LIST-SettlementType')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', N'SaleSettings-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/LIST-SaleSettings/list', 0, N'LIST-SaleSettings')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', N'MsgNotification-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/DELETE-MsgNotification/delete', 0, N'DELETE-MsgNotification')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', N'Tiers-ADD', 6, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/add-tiers/save', 0, N'ADD-Tiers')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c99db12f-b24e-4957-be1d-dd0193a23a3a', N'MsgNotification-UPDATE', 2, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/UPDATE-MsgNotification/update', 0, N'UPDATE-MsgNotification')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', N'User-ADD', 1, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/ADD-USER/add', 0, N'ADD-User')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', N'PaymentMethod-ADD', 6, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/ADD-PaymentMethod/save', 0, N'ADD-PaymentMethod')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', N'Message-SAVE', 6, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/SAVE-Massage/save', 0, N'SAVE-Message')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', N'Message-SHOW', 15, NULL, NULL, NULL, NULL, NULL, N'', N'/divers/Message-SHOW/show', 0, N'SHOW-Message')


INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'560c0361-0321-4690-a9b9-1391cb9d6451', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1a33a525-bc0d-4974-a271-9779ba13b699', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'1480a708-a100-4f72-9792-15232a0895c3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'038d55eb-5628-48f0-bc28-60e9b3a19a93', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1, 1, 1, NULL)
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
--end missing fonctionalities


BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'04b09c0e-b960-425d-9afc-32eb613b3a39', N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4239ab79-1bf5-409f-b6c6-b3ad8d4d08cc', N'c99db12f-b24e-4957-be1d-dd0193a23a3a', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'518d1647-7cb9-49c9-9d17-aee82aef2bc5', N'1a33a525-bc0d-4974-a271-9779ba13b699', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6d9bf8f8-23f9-476f-bf61-705f9a65882b', N'038d55eb-5628-48f0-bc28-60e9b3a19a93', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'91512c51-48df-4673-b4e9-2dfcc7a4c67e', N'4513ed01-2341-4581-b9b9-db7e81fe50c8', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'92a335d2-52ae-4fbb-93d0-5987f6ab8271', N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'95e1f464-3d18-4e1c-86b5-15425d688ef1', N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a21f9959-2280-4f14-b2f4-1461e356df32', N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b125eaf2-7c48-47e0-a3ee-d6da3b4582b2', N'560c0361-0321-4690-a9b9-1391cb9d6451', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b4300b20-067d-44d9-859e-470959751759', N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bfd309e7-a48f-43a7-9b7f-eee8cec0976a', N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd3c6be00-3656-41fa-96fb-ae05a6e77353', N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd6056c0b-68b3-4d9a-99a4-d66166cd93f7', N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'de57b91d-4c65-4757-bf2c-6e0396187983', N'1480a708-a100-4f72-9792-15232a0895c3', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ffc9efc5-086c-4533-bd03-3b8f3e1e4ad5', N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION

--- Marwa: modif Information table
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [Type]=N'PURCHASE_PURCHASE_REQUEST_VALIDATION' WHERE [IdInfo]=1000500065
UPDATE [ERPSettings].[Information] SET [Type]=N'PURCHASE_PURCHASE_REQUEST_REFUSE' WHERE [IdInfo]=1000500066
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', N'EmployeeDocument-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/payroll/employeedocument/list', 0, N'LIST-EmployeeDocument')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a69984ec-f11f-46aa-9b32-9d22d815fd4c', N'QualificationType-LIST', 4, N'Liste des diplômes', N'Qualifiction list', NULL, NULL, NULL, NULL, N'/payroll/qualificationtype/list', 0, N'LIST-QualificationType')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', N'QualificationType', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 16, N'Type de diplôme', N'Qualification Type', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'e7e94ca1-eace-4b30-88d6-48286320eae1', N'EmployeeDocument', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 17, N'Document employé', N'Employee Document', NULL, NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 1, 1)

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a69984ec-f11f-46aa-9b32-9d22d815fd4c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4237bc9d-a3d7-426b-a649-0e83fe80966d', N'a69984ec-f11f-46aa-9b32-9d22d815fd4c', N'3f5ce072-55c8-485e-9a09-1f2f69c043e8')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4bfd3174-1467-411f-bda7-066883a1617f', N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', N'e7e94ca1-eace-4b30-88d6-48286320eae1')
COMMIT TRANSACTION



--Fatma add purchase functionnalitys and permisson
BEGIN TRANSACTION


ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]

ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]

UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'00000000' WHERE [Id]=70
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2619edd7-d221-43d7-832b-c1c761df8ac8', N'PurchaseBudget-LIST', 4, N'LIST-PurchaseBudget', N'LIST-PurchaseBudget', NULL, NULL, NULL, NULL, N'/purchase/purchasebudget/list', 0, N'LIST-PurchaseBudget')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', N'PurchaseBudget-UPDATE', 2, N'UPDATE-PurchaseBudget', N'UPDATE-PurchaseBudget', NULL, NULL, NULL, NULL, N'/purchase/purchasebudget/update', 0, N'UPDATE-PurchaseBudget')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', N'PurchaseBudget-ADD', 1, N'ADD-PurchaseBudget', N'ADD-PurchaseBudget', NULL, NULL, NULL, NULL, N'/purchase/purchasebudget/add', 0, N'ADD-PurchaseBudget')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'1b8c288b-6fb4-4816-964b-ce7b89339db9', N'PurchaseBudget', N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 9, N'PurchaseBudget_FR', N'PurchaseBudget_EN', N'PurchaseBudget_AR', NULL, NULL, NULL, N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 1, 1)

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (26, 87, N'DocumentTypeCode', N'B-PU', 112)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1, 1, 1, NULL)

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (112, N'CodeDevisAchat', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (113, N'CaractereDevisAchat', 1, NULL, NULL, N'DE', 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (114, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (115, N'Caractere/', 3, NULL, NULL, N'/', 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (116, N'compteurDevis', 4, NULL, NULL, NULL, 112, 1, 1, N'00000044', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6abd153e-2ec7-4402-99be-d6bd99348613', N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', N'1b8c288b-6fb4-4816-964b-ce7b89339db9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a761bb63-936e-423b-b63e-178f90b72bbc', N'2619edd7-d221-43d7-832b-c1c761df8ac8', N'1b8c288b-6fb4-4816-964b-ce7b89339db9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f927148a-c69c-4cb2-9602-fe75eaea3d07', N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', N'1b8c288b-6fb4-4816-964b-ce7b89339db9')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration]) VALUES (N'B-PU', N'B-PU', N'Devis achat', N'Devis achat', NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])

ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
	
COMMIT TRANSACTION

--fatma messing functionnality
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', N'Category-UPDATE', 2, N'UPDATE-Category', N'UPDATE-Category', NULL, NULL, NULL, NULL, N'/immobilisation/category/update', 0, N'UPDATE-Category')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', N'Category-LIST', 4, N'LIST-Category', N'LIST-Category', NULL, NULL, NULL, NULL, N'/immobilisation/category/list', 0, N'LIST-Category')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', N'Category-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/immobilisation/category/delete', 0, N'DELETE-Category')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4f788f04-93df-47f5-a308-cf110df2f2f0', N'History-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/delete', 0, N'DELETE-History')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'7ab8d023-1fed-4230-98f7-e8ee50028f30', N'History-ADD', 1, N'ADD-History', N'ADD-History', NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/add', 0, N'ADD-History')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c571afdf-1f39-4715-9f4e-4f59043571b7', N'History-LIST', 4, N'LIST-History', N'LIST-History', NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/list', 0, N'LIST-History')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dcf849b9-583f-4a23-b2c0-d3298ea74865', N'Category-ADD', 1, N'ADD-Category', N'ADD-Category', NULL, NULL, NULL, NULL, N'/immobilisation/category/add', 0, N'ADD-Category')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f8309664-1867-43b7-adb8-7bd34ba687d6', N'History-UPDATE', 2, N'UPDATE-History', N'UPDATE-History', NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/update', 0, N'UPDATE-History')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'25193c87-5c32-4166-931d-22bca7a0dd64', N'dcf849b9-583f-4a23-b2c0-d3298ea74865', N'159000fc-7090-48c5-bcc2-8e8cb688e8a9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'42ac76fb-75e0-4d24-905a-3473ecc15ccd', N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', N'159000fc-7090-48c5-bcc2-8e8cb688e8a9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6b6f9691-763e-4724-b355-6f26f141d875', N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', N'159000fc-7090-48c5-bcc2-8e8cb688e8a9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6b771bab-cc09-404d-8be2-c76664c44fc5', N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', N'159000fc-7090-48c5-bcc2-8e8cb688e8a9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7771e632-cc27-4f03-a21c-9f7227a4d739', N'7ab8d023-1fed-4230-98f7-e8ee50028f30', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a32acbe4-adf2-4a09-81f0-792b1213415b', N'f8309664-1867-43b7-adb8-7bd34ba687d6', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b539d18f-ea42-4d47-ac39-1ab59429ec5c', N'c571afdf-1f39-4715-9f4e-4f59043571b7', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c41e1de5-b34e-413c-9bc0-779cf8281ae9', N'4f788f04-93df-47f5-a308-cf110df2f2f0', N'f40650cb-aa58-48a8-a4df-9744e6b81698')

ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

--- Marwa add functionnality add-Comment ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'Comment-ADD', 1, N'Comment-ADD', N'Comment-ADD', NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/add', 0, N'ADD-Comment')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6644efbf-71a8-4852-a530-a5781d666939', N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
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

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'055e9281-29db-478a-8d91-eda76013a1b2', N'Cnss-LIST', 4, N'Liste CNSS', N'CNSS List', NULL, NULL, NULL, NULL, N'/payroll/cnss/list', 1, N'LIST-Cnss')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6d02633e-d8ed-4965-ad93-125f7607ee31', N'BaseSalary-LIST', 4, N'Salaire de base', N'Base Salary', NULL, NULL, NULL, NULL, N'/payroll/basesalary/list', 1, N'LIST-BaseSalary')
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', N'BaseSalary', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 19, N'Salaire de Base', N'Base Salary', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'dca0e118-de89-4b9d-a25b-08964a3856b9', N'Cnss', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 18, N'Cnss', N'Cnss', NULL, NULL, NULL, NULL, N'icon-note', 0)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES ( 1, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 1, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0fdb90b8-16cc-4317-947c-95c3fbbb0498', N'6d02633e-d8ed-4965-ad93-125f7607ee31', N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2732bda0-fa89-4aa0-97d1-fe758c0c0128', N'055e9281-29db-478a-8d91-eda76013a1b2', N'dca0e118-de89-4b9d-a25b-08964a3856b9')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'055e9281-29db-478a-8d91-eda76013a1b2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1, 1, 1, NULL)
COMMIT TRANSACTION

---- nihel: fix update item
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Item' WHERE [IdFunctionality]=N'd006adea-6c46-421a-96d6-2c90fc2b5679'
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Narcisse : Add payslip generated roles 
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', N'Payslip-Print', 9, N'Payslip-Print', N'Payslip-Print', N'Payslip-Print', N'Payslip-Print', N'Payslip-Print', N'Payslip-Print', N'/payroll/payslip/print', 1, N'PRINT-Payslip')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'4bbfc657-e80e-4eff-b0d4-aa1ba550f32e', N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1, 1, 1, NULL)
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

-- Mohamed BOUZIDI Authorize(Roles = "IMPORT")
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
SET IDENTITY_INSERT [ERPSettings].[RequestType] ON
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (19, N'IMPORT', N'form.html', NULL, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RequestType] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', N'Employee-IMPORT', 19, N'Employee-IMPORT', N'Employee-IMPORT', NULL, NULL, NULL, NULL, N'/payroll/employee/import', 0, N'IMPORT-Employee')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'98c3a360-cb78-41b4-a9a2-362dd9c58119', N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', N'2f7d95d8-883a-445e-9ec2-3c4a70854f68')
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

---- nihel: stock document role
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Item' WHERE [IdFunctionality]=N'd006adea-6c46-421a-96d6-2c90fc2b5679'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'076ba263-00e7-4a78-9fb2-ba7f19e8acd9'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'20d398f7-5504-416e-bee1-935f6a730db6'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'25cbd368-5d19-4a12-8b3d-0a546e5d08e1'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/base/deleteStockDocument/:id' WHERE [IdServiceParameters]=N'29bd7bbd-667f-4c7f-9d90-556339cb48a9'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'3e762a8a-622a-46c2-b331-13aad659d399'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'4daf30d5-9fb7-45f2-8daa-671a89a3ce4d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/updateStockDocument' WHERE [IdServiceParameters]=N'52d75cb2-3a01-4f2b-a65b-6daf4be1e94c'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'User' WHERE [IdServiceParameters]=N'5f520a06-3a58-4a44-81aa-06e9b85fe6a3'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'6112395b-7baa-4052-96c0-bc2e26f2af21'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'User' WHERE [IdServiceParameters]=N'6d2fc4fe-988d-479e-bac9-e599f117149c'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'6deaa1c8-24b0-49f6-801b-f6947a3a8eb0'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'7135baf8-0716-4a44-a3c7-1c31b657adde'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentPredicate' WHERE [IdServiceParameters]=N'863c335d-3e52-494e-bb95-daa27364c17d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/updateStockDocument' WHERE [IdServiceParameters]=N'886b5bd0-289e-431f-809b-20620b4140d2'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'User' WHERE [IdServiceParameters]=N'8e20e3b4-2121-4e24-9d35-db10bc84cf21'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/base/deleteStockDocument/:id' WHERE [IdServiceParameters]=N'8f383e80-23da-4ef3-b843-c93121d9f78d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'923e1520-b024-4374-8e80-8a9aa5ad8b49'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/base/deleteStockDocument/:id' WHERE [IdServiceParameters]=N'931818f9-1679-4584-98d8-985563aac769'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/insertStockDocument' WHERE [IdServiceParameters]=N'9b43f2ec-d2aa-4afd-81b6-20568d9c6c8d'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/updateStockDocument' WHERE [IdServiceParameters]=N'9c461ebf-2abe-40e1-bbcc-5ba6aee314f4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentPredicate' WHERE [IdServiceParameters]=N'b7e0b996-7bc1-4962-9b53-8e965e2bfac4'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/insertStockDocument' WHERE [IdServiceParameters]=N'cc708e43-38d3-4339-8ab4-4f378c78d432'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/insertStockDocument' WHERE [IdServiceParameters]=N'd8e805ce-a3c5-4d9b-9bc3-f7fe3b66cbeb'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/getStockDocumentById/:id' WHERE [IdServiceParameters]=N'deeab873-1053-4805-aa43-85e45b8b28cf'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/base/deleteStockDocument/:id' WHERE [IdServiceParameters]=N'f4bad462-a7d2-42cc-b8e3-503bf72a67b6'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/updateStockDocument' WHERE [IdServiceParameters]=N'f7a5be82-863e-4742-a222-48c7a9947661'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/stockDocument/insertStockDocument' WHERE [IdServiceParameters]=N'fd40dcea-5cf1-4ffc-ba82-e244132128b6'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'fdee3d5d-4c7e-48ec-817e-0d65c3a3bdae'
UPDATE [ERPSettings].[ServiceParameters] SET [TModel]=N'Role' WHERE [IdServiceParameters]=N'fe16c276-7acd-4e39-a5f8-893aa356383e'
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', N'TransferMovement-VALIDATE', 8, N'TransferMovement-VALIDATE', N'TransferMovement-VALIDATE', N'TransferMovement-VALIDATE', N'TransferMovement-VALIDATE', N'TransferMovement-VALIDATE', N'TransferMovement-VALIDATE', N'/stock/transfermovement/validate', 0, N'VALIDATE-TransferMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', N'InventoryMovement-VALIDATE', 8, N'InventoryMovement-VALIDATE', N'InventoryMovement-VALIDATE', N'InventoryMovement-VALIDATE', N'InventoryMovement-VALIDATE', N'InventoryMovement-VALIDATE', N'InventoryMovement-VALIDATE', N'/stock/inventorymovement/validate', 0, N'VALIDATE-InventoryMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b5662ca1-736e-421c-b228-8b6dd972fdec', N'InputMovement-VALIDATE', 8, N'InputMovement-VALIDATE', N'InputMovement-VALIDATE', N'InputMovement-VALIDATE', N'InputMovement-VALIDATE', N'InputMovement-VALIDATE', N'InputMovement-VALIDATE', N'/stock/inputmovement/validate', 0, N'VALIDATE-InputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', N'CustomerSettlement-VALIDATE', 8, N'CustomerSettlement-VALIDATE', N'CustomerSettlement-VALIDATE', NULL, NULL, NULL, NULL, N'/payment/customersettlement/validate', 1, N'VALIDATE-CustomerSettlement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', N'OutputMovement-VALIDATE', 8, N'OutputMovement-VALIDATE', N'OutputMovement-VALIDATE', N'OutputMovement-VALIDATE', N'OutputMovement-VALIDATE', N'OutputMovement-VALIDATE', N'OutputMovement-VALIDATE', N'/stock/outputmovement/validate', 0, N'VALIDATE-OutputMovement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', N'SupplierSettlement-VALIDATE', 8, N'SupplierSettlement-VALIDATE', N'SupplierSettlement-VALIDATE', NULL, NULL, NULL, NULL, N'/payment/suppliersettlement/validate', 0, N'VALIDATE-SupplierSettlement')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'133a915d-f773-43f6-bcb3-dd4e309a3c42', N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'19598552-253a-43b8-9321-9be5e664324e', N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7e6d35a3-896e-49ad-807e-c1b828fd6c84', N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', N'ff007474-a447-4c92-8f6a-265d5c08ff10')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'afb447ed-676d-46b9-aa43-757a0d755615', N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', N'461500a8-a604-46ab-ab77-8517783aea0d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dfb80e02-72ae-4318-8417-ac18acbec1a7', N'b5662ca1-736e-421c-b228-8b6dd972fdec', N'ba44579d-71ad-404e-9a65-2e380b698b19')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd79c19f-43d8-4b2a-85a2-e7c3f146437c', N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', N'd1f0441a-a83f-414a-a106-9539a26a58ef')
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1, 1, 1, NULL)
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
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

---- nihel: axis role
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', N'AxisEntity-LIST', 4, N'LIST-AxisEntity', N'LIST-AxisEntity', N'LIST-AxisEntity', N'LIST-AxisEntity', NULL, NULL, N'/administration/axes analytiques/list', 1, N'LIST-AxisEntity')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', N'AxisValue-LIST', 4, N'LIST-AxisValue', N'LIST-AxisValue', N'LIST-AxisValue', N'LIST-AxisValue', NULL, NULL, N'/administration/axes analytiques/list', 0, N'LIST-AxisValue')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', N'Entity-LIST', 4, N'LIST-Entity', N'LIST-Entity', N'LIST-Entity', NULL, NULL, NULL, N'/administration/axes analytiques/list', 0, N'LIST-Entity')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2373dc3b-f8a4-42cb-b9fd-e8d1afe2a314', N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', N'a209794d-4f0f-4fff-b715-a03556e3ed87')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dbe4d4af-f7d8-411a-b164-e0608adf1406', N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', N'a209794d-4f0f-4fff-b715-a03556e3ed87')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e47266b1-fe30-4f43-8fa1-1a8fa964ad36', N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', N'a209794d-4f0f-4fff-b715-a03556e3ed87')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1, 1, 1, NULL)

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