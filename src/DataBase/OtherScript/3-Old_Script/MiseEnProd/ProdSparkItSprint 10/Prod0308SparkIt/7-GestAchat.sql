---- role gest achat : id 1043

---- deactivate the menu rh
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'24548e5d-76cc-4fc8-a7ee-02986b9274a7' and [IdRole] = 1043


---- deactivate the menu employee
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'2f7d95d8-883a-445e-9ec2-3c4a70854f68' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'2f7d95d8-883a-445e-9ec2-3c4a70854f68'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'2f7d95d8-883a-445e-9ec2-3c4a70854f68')))
go

---- deactivate the menu contrat
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'214c0463-7e29-4740-acf7-bccec1adfa43' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43')))
go

---- deactivate the menu poste
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a')))
go

---- deactivate the menu grade
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'94a36607-432f-483b-aecf-8c0d3d19f47b' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b')))
go

---- deactivate the menu echellon
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'b4cf9263-6554-4f45-a26d-22e8d58099d5' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5')))
go

---- deactivate the menu bulletin de paie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')))
go

---- deactivate the menu structure salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd2343785-b0e5-4d87-8f03-78d62c876d43' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43')))
go

---- deactivate the menu règle salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ce31e87c-a47e-4c35-a81f-16f6aa695c11' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11')))
go

---- deactivate the menu constante valeur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'5c56d444-523c-4cb3-8554-1a88b3af0779' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779')))
go

---- deactivate the menu constante taux
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a49cd432-de82-40d6-8994-ce2f102039cc' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc')))
go

---- deactivate the menu variable
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e')))
go

---- deactivate the menu vente
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd438fbad-7305-4dad-ab44-a4fb84318a83' and [IdRole] = 1043

---- deactivate the menu sale settings 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20' and [IdRole] = 1043 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20')))
go

---- deactivate the menu customer
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'e30959c4-61bb-457e-b44e-271c04a9e49d' and [IdRole] = 1043 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e30959c4-61bb-457e-b44e-271c04a9e49d'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e30959c4-61bb-457e-b44e-271c04a9e49d')))
go

---- deactivate the menu devis
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'e0367d41-2d4b-4f85-9e7a-244803c29221' and [IdRole] = 1043 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e0367d41-2d4b-4f85-9e7a-244803c29221'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e0367d41-2d4b-4f85-9e7a-244803c29221')))
go

---- deactivate the menu sale order 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'361806f0-f88e-4b5e-bda6-68c34fb1faea' and [IdRole] = 1043 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea')))
go

---- deactivate the menu sale delivery receipt
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'783fe0a6-0d38-43a3-8b41-42039da2ed3f' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and  [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f')))
go

---- deactivate the menu sale invoice
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'e55c8fd9-ac89-4986-9291-afe0d5c02490' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e55c8fd9-ac89-4986-9291-afe0d5c02490'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and  [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'e55c8fd9-ac89-4986-9291-afe0d5c02490')))
go

---- deactivate the menu sale Asset
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9'
 )
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and  [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9')))
go


---- deactivate the menu administration
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'efa1d60e-933b-4749-bac3-a15e8bba3415' and [IdRole] = 1043

---- deactivate the menu company 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960
' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and   [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960')))
go

---- deactivate the menu role 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'1bdc6aaa-db4b-4862-9758-4382fd0e656a' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and   [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a')))
go

---- deactivate the menu user 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a710d793-9662-486c-8b3b-01d2a592111b' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b')))
go

---- deactivate the menu axes analytiques 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a209794d-4f0f-4fff-b715-a03556e3ed87' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a209794d-4f0f-4fff-b715-a03556e3ed87'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a209794d-4f0f-4fff-b715-a03556e3ed87')))
go

---- deactivate the menu axes analytiques 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a209794d-4f0f-4fff-b715-a03556e3ed87' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a209794d-4f0f-4fff-b715-a03556e3ed87'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a209794d-4f0f-4fff-b715-a03556e3ed87')))
go

---- deactivate the menu currency 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'5eef2177-47d5-4780-b338-46e284f8ce4a' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5eef2177-47d5-4780-b338-46e284f8ce4a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5eef2177-47d5-4780-b338-46e284f8ce4a')))
go

---- deactivate the menu Taxe Type 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'9a66818c-8385-49fa-a6ae-08ade53622e1' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9a66818c-8385-49fa-a6ae-08ade53622e1'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9a66818c-8385-49fa-a6ae-08ade53622e1')))
go

---- deactivate the menu Taxe 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'3a3ed20b-f313-4b1b-9879-a287af094ff0' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3a3ed20b-f313-4b1b-9879-a287af094ff0'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3a3ed20b-f313-4b1b-9879-a287af094ff0')))
go

---- deactivate the menu Groupe remise tiers 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'12e372a0-52f7-4089-a3f4-a96cf646b6fb' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'12e372a0-52f7-4089-a3f4-a96cf646b6fb'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'12e372a0-52f7-4089-a3f4-a96cf646b6fb')))
go

---- deactivate the menu Groupe remise article 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'0d8556e4-3f5e-44ed-aea6-c00c28593219' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'0d8556e4-3f5e-44ed-aea6-c00c28593219'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'0d8556e4-3f5e-44ed-aea6-c00c28593219')))
go

---- deactivate the menu country
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'22367de5-32f0-4fd7-9340-296c7879c03f' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22367de5-32f0-4fd7-9340-296c7879c03f'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22367de5-32f0-4fd7-9340-296c7879c03f')))
go

---- deactivate the menu city
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'22b1f11f-8129-4128-ae3e-870d327bb4ae' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22b1f11f-8129-4128-ae3e-870d327bb4ae'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22b1f11f-8129-4128-ae3e-870d327bb4ae')))
go

---- deactivate the menu Unite de mesure
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'11503286-9245-41ee-a502-caa5ea9cf776' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'11503286-9245-41ee-a502-caa5ea9cf776'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'11503286-9245-41ee-a502-caa5ea9cf776')))
go

---- deactivate the menu transfert de référentiel 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a52beb65-894c-47f0-ba55-d99e5e17ca2a' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a')))
go

---- deactivate the menu ZipCode
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'3bceb952-b852-4d24-9f76-b472b3570486' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3bceb952-b852-4d24-9f76-b472b3570486'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'3bceb952-b852-4d24-9f76-b472b3570486')))
go

---- deactivate the menu bankAccount 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'4191141d-e747-40bd-a448-733d5c23f083' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'4191141d-e747-40bd-a448-733d5c23f083'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'4191141d-e747-40bd-a448-733d5c23f083')))
go

---- deactivate the menu Nature d'article 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd02ccb30-71cf-4a57-8327-333be69e8af4' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd02ccb30-71cf-4a57-8327-333be69e8af4'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd02ccb30-71cf-4a57-8327-333be69e8af4')))
go

---- deactivate the menu notification
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a9f72604-b294-4035-a890-479a2d17ce10' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10')))
go

---- deactivate the menu ContractServiceType
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'fbb149f9-4d23-43d7-8576-0078daa06f8d' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'fbb149f9-4d23-43d7-8576-0078daa06f8d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'fbb149f9-4d23-43d7-8576-0078daa06f8d')))
go


---- stock
---- deactivate the menu mvt d'entrée
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ba44579d-71ad-404e-9a65-2e380b698b19' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19')))
go

---- deactivate the menu mvt de sortie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'461500a8-a604-46ab-ab77-8517783aea0d' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d')))
go

---- deactivate the menu mvt de transfert
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b')))
go

---- deactivate the menu mvt d'inventaire
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ff007474-a447-4c92-8f6a-265d5c08ff10' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10')))
go

---- règlement

---- deactivate the menu règlement fournisseur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a')))
go

---- deactivate the menu règlement client
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd1f0441a-a83f-414a-a106-9539a26a58ef' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd1f0441a-a83f-414a-a106-9539a26a58ef'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd1f0441a-a83f-414a-a106-9539a26a58ef')))
go

---- deactivate the menu echéances fournisseur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'081ef980-e302-4386-89fa-ea31857b1c2d' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'081ef980-e302-4386-89fa-ea31857b1c2d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'081ef980-e302-4386-89fa-ea31857b1c2d')))
go

---- deactivate the menu echéances client
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ab566211-44ce-44a8-a843-a6764f816249' and [IdRole] = 1043
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ab566211-44ce-44a8-a843-a6764f816249'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1043 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ab566211-44ce-44a8-a843-a6764f816249')))
go



/*desactiver les boutons validation*/

----devis achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='d03d0e5d-e0a5-4f36-8f04-99230ed5d2b7' and [IdRole] = 1043
----commande achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='db0c071b-18fb-42c2-bae4-fbb90b4058e2' and [IdRole] = 1043
----bl achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='979cbfbe-9afa-4fa9-855d-287cf69f723f' and [IdRole] = 1043
----facture achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='38f93941-80f5-4c9e-ad8f-d4d577a1ab6a' and [IdRole] = 1043
----avoir vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='1028314d-01bd-40b3-a34f-2573eec66f10' and [IdRole] = 1043

