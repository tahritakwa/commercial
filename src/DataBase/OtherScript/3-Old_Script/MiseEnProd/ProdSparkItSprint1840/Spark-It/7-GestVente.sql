---- role gest vante: id 1040

---- deactivate the menu sale order and sale delivery receipt (commande - bon de livraison)
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'783fe0a6-0d38-43a3-8b41-42039da2ed3f' and [IdRole] = 1040
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'361806f0-f88e-4b5e-bda6-68c34fb1faea' and [IdRole] = 1040

update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f'
 )
 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea'
 )
 
---- deactivate interfaces sale order and sale delivery receipt (commande - bon de livraison)
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and  [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f')))
go

update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea')))
go


---- deactivate the menu role 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'1bdc6aaa-db4b-4862-9758-4382fd0e656a' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and   [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a')))
go

---- deactivate the menu user 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a710d793-9662-486c-8b3b-01d2a592111b' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b')))
go

---- deactivate the menu transfert de référentiel 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a52beb65-894c-47f0-ba55-d99e5e17ca2a' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a')))
go

---- deactivate the menu notification
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a9f72604-b294-4035-a890-479a2d17ce10' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10')))
go

---- deactivate the menu mvt d'entrée
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ba44579d-71ad-404e-9a65-2e380b698b19' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19')))
go

---- deactivate the menu mvt de sortie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'461500a8-a604-46ab-ab77-8517783aea0d' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d')))
go

---- deactivate the menu mvt de transfert
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b')))
go

---- deactivate the menu mvt d'inventaire
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ff007474-a447-4c92-8f6a-265d5c08ff10' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10')))
go

---- deactivate the menu employee
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'2f7d95d8-883a-445e-9ec2-3c4a70854f68' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'2f7d95d8-883a-445e-9ec2-3c4a70854f68'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'2f7d95d8-883a-445e-9ec2-3c4a70854f68')))
go

---- deactivate the menu contrat
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'214c0463-7e29-4740-acf7-bccec1adfa43' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43')))
go

---- deactivate the menu poste
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a')))
go

---- deactivate the menu grade
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'94a36607-432f-483b-aecf-8c0d3d19f47b' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b')))
go

---- deactivate the menu echellon
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'b4cf9263-6554-4f45-a26d-22e8d58099d5' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5')))
go

---- deactivate the menu bulletin de paie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')))
go

---- deactivate the menu structure salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd2343785-b0e5-4d87-8f03-78d62c876d43' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43')))
go

---- deactivate the menu règle salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ce31e87c-a47e-4c35-a81f-16f6aa695c11' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11')))
go

---- deactivate the menu constante valeur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'5c56d444-523c-4cb3-8554-1a88b3af0779' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779')))
go

---- deactivate the menu constante taux
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a49cd432-de82-40d6-8994-ce2f102039cc' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc')))
go

---- deactivate the menu variable
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e')))
go

---- deactivate the menu règlement fournisseur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a')))
go

---- deactivate the menu règlement client
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd1f0441a-a83f-414a-a106-9539a26a58ef' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd1f0441a-a83f-414a-a106-9539a26a58ef'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd1f0441a-a83f-414a-a106-9539a26a58ef')))
go

---- deactivate the menu echéances fournisseur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'081ef980-e302-4386-89fa-ea31857b1c2d' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'081ef980-e302-4386-89fa-ea31857b1c2d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'081ef980-e302-4386-89fa-ea31857b1c2d')))
go

---- deactivate the menu echéances client
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ab566211-44ce-44a8-a843-a6764f816249' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ab566211-44ce-44a8-a843-a6764f816249'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ab566211-44ce-44a8-a843-a6764f816249')))
go

---- deactivate the menu paramètrage achat
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'4609408f-7f48-4a57-8bfb-f1f0b108099b' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'4609408f-7f48-4a57-8bfb-f1f0b108099b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'4609408f-7f48-4a57-8bfb-f1f0b108099b')))
go

---- deactivate the menu fournisseur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'9b03405e-cb73-4c79-949e-9cd216ece4c4' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9b03405e-cb73-4c79-949e-9cd216ece4c4'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'9b03405e-cb73-4c79-949e-9cd216ece4c4')))
go

---- deactivate the menu demande prix
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1')))
go

---- deactivate the menu bon de commande
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018')))
go

---- deactivate the menu bon de réception
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a0092569-9901-4fea-96e1-4cd96ea0eaed' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a0092569-9901-4fea-96e1-4cd96ea0eaed'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a0092569-9901-4fea-96e1-4cd96ea0eaed')))
go

---- deactivate the menu facture
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'bc471d71-863e-47a0-95f4-c2e1595c2bd9' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bc471d71-863e-47a0-95f4-c2e1595c2bd9'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bc471d71-863e-47a0-95f4-c2e1595c2bd9')))
go

---- deactivate the menu avoir
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6' and [IdRole] = 1040
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1040 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6')))
go




---- deactivate the menu achat
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'817d920f-48ef-4aa2-865a-cc367c37fb3b' and [IdRole] = 1040
---- deactivate the menu rh
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'24548e5d-76cc-4fc8-a7ee-02986b9274a7' and [IdRole] = 1040


/*desactiver les bloc primes dans interface contrat*/
---- add contract
update [ERPSettings].[ComponentByRole] set [IsActive]=1 where [IdComponent]='19181187-cd43-4f97-b4a1-79da00d7ef94' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='3ae58bd0-18a6-4ef4-a416-9efce9dded8e' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='589b760b-6fae-49df-abe6-28f1a44ca329' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='d2cac827-32fe-47a3-b21b-909770332402' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='a6b1d7f8-bebd-4d53-bb3f-5b2c73ec669b' and [IdRole] = 1040
---- update contract 
update [ERPSettings].[ComponentByRole] set [IsActive]=1 where [IdComponent]='9925663f-8b9b-4bcb-8726-a0385af9d196' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='b1f217e9-bcfb-4cba-8c6f-feb463d76b3e' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='187e5f1c-3e91-4a03-9e0d-91c223a2d5fa' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='9cac2ebf-34c0-4252-a40d-0b52f6756f22' and [IdRole] = 1040
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='27d919b1-c3e5-47d1-b3ad-809615e9b5db' and [IdRole] = 1040


/*desactiver les boutons validation*/
----devis vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='596ca3f9-4241-4e6c-961d-b808dec11e07' and [IdRole] = 1040
----commande vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='cabccbf6-3ee9-4860-9928-918da5520b26' and [IdRole] = 1040
----bl vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='0511eba6-851d-4427-a716-749bbd33fe1a' and [IdRole] = 1040
----facture vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='b78f37b7-3bcd-45d1-8499-b89064236413' and [IdRole] = 1040
----avoir vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='939d9fa7-c920-4bb7-a624-7c8afc561770' and [IdRole] = 1040

