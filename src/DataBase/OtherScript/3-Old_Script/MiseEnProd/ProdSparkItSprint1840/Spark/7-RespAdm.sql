---- role resp administratif: id 1039

---- deactivate the menu sale order and sale delivery receipt (commande - bon de livraison)
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'783fe0a6-0d38-43a3-8b41-42039da2ed3f' and [IdRole] = 1039
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'361806f0-f88e-4b5e-bda6-68c34fb1faea' and [IdRole] = 1039

update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f'
 )
 
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea'
 )
 
---- deactivate interfaces sale order and sale delivery receipt (commande - bon de livraison)
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and  [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'783fe0a6-0d38-43a3-8b41-42039da2ed3f')))
go

update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'361806f0-f88e-4b5e-bda6-68c34fb1faea')))
go


---- deactivate the menu role 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'1bdc6aaa-db4b-4862-9758-4382fd0e656a' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and   [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'1bdc6aaa-db4b-4862-9758-4382fd0e656a')))
go

---- deactivate the menu user 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a710d793-9662-486c-8b3b-01d2a592111b' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a710d793-9662-486c-8b3b-01d2a592111b')))
go

---- deactivate the menu transfert de référentiel 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a52beb65-894c-47f0-ba55-d99e5e17ca2a' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a')))
go

---- deactivate the menu notification
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a9f72604-b294-4035-a890-479a2d17ce10' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a9f72604-b294-4035-a890-479a2d17ce10')))
go

---- deactivate the menu mvt d'entrée
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ba44579d-71ad-404e-9a65-2e380b698b19' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ba44579d-71ad-404e-9a65-2e380b698b19')))
go

---- deactivate the menu mvt de sortie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'461500a8-a604-46ab-ab77-8517783aea0d' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'461500a8-a604-46ab-ab77-8517783aea0d')))
go

---- deactivate the menu mvt de transfert
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b')))
go

---- deactivate the menu mvt d'inventaire
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ff007474-a447-4c92-8f6a-265d5c08ff10' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ff007474-a447-4c92-8f6a-265d5c08ff10')))
go

---- deactivate the menu contrat
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'214c0463-7e29-4740-acf7-bccec1adfa43' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'214c0463-7e29-4740-acf7-bccec1adfa43')))
go

---- deactivate the menu poste
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a')))
go

---- deactivate the menu grade
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'94a36607-432f-483b-aecf-8c0d3d19f47b' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'94a36607-432f-483b-aecf-8c0d3d19f47b')))
go

---- deactivate the menu echellon
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'b4cf9263-6554-4f45-a26d-22e8d58099d5' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'b4cf9263-6554-4f45-a26d-22e8d58099d5')))
go

---- deactivate the menu bulletin de paie
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd')))
go

---- deactivate the menu structure salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd2343785-b0e5-4d87-8f03-78d62c876d43' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd2343785-b0e5-4d87-8f03-78d62c876d43')))
go

---- deactivate the menu règle salariale
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'ce31e87c-a47e-4c35-a81f-16f6aa695c11' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'ce31e87c-a47e-4c35-a81f-16f6aa695c11')))
go

---- deactivate the menu constante valeur
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'5c56d444-523c-4cb3-8554-1a88b3af0779' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'5c56d444-523c-4cb3-8554-1a88b3af0779')))
go

---- deactivate the menu constante taux
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a49cd432-de82-40d6-8994-ce2f102039cc' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a49cd432-de82-40d6-8994-ce2f102039cc')))
go

---- deactivate the menu variable
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e' and [IdRole] = 1039
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] = 1039 and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e')))
go


/*desactiver les bloc primes dans interface contrat*/
---- add contract
update [ERPSettings].[ComponentByRole] set [IsActive]=1 where [IdComponent]='19181187-cd43-4f97-b4a1-79da00d7ef94' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='3ae58bd0-18a6-4ef4-a416-9efce9dded8e' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='589b760b-6fae-49df-abe6-28f1a44ca329' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='d2cac827-32fe-47a3-b21b-909770332402' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='a6b1d7f8-bebd-4d53-bb3f-5b2c73ec669b' and [IdRole] = 1039
---- update contract 
update [ERPSettings].[ComponentByRole] set [IsActive]=1 where [IdComponent]='9925663f-8b9b-4bcb-8726-a0385af9d196' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='b1f217e9-bcfb-4cba-8c6f-feb463d76b3e' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='187e5f1c-3e91-4a03-9e0d-91c223a2d5fa' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='9cac2ebf-34c0-4252-a40d-0b52f6756f22' and [IdRole] = 1039
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='27d919b1-c3e5-47d1-b3ad-809615e9b5db' and [IdRole] = 1039


/*desactiver les boutons validation*/
----devis vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='596ca3f9-4241-4e6c-961d-b808dec11e07' and [IdRole] = 1039
----commande vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='cabccbf6-3ee9-4860-9928-918da5520b26' and [IdRole] = 1039
----bl vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='0511eba6-851d-4427-a716-749bbd33fe1a' and [IdRole] = 1039
----facture vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='b78f37b7-3bcd-45d1-8499-b89064236413' and [IdRole] = 1039
----avoir vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='939d9fa7-c920-4bb7-a624-7c8afc561770' and [IdRole] = 1039

----devis achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='d03d0e5d-e0a5-4f36-8f04-99230ed5d2b7' and [IdRole] = 1039
----commande achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='db0c071b-18fb-42c2-bae4-fbb90b4058e2' and [IdRole] = 1039
----bl achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='979cbfbe-9afa-4fa9-855d-287cf69f723f' and [IdRole] = 1039
----facture achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='38f93941-80f5-4c9e-ad8f-d4d577a1ab6a' and [IdRole] = 1039
----avoir vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='1028314d-01bd-40b3-a34f-2573eec66f10' and [IdRole] = 1039

----règlement vente
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='f399cd44-bbdb-4a13-a818-14119a65cce4' and [IdRole] = 1039
----règlement achat
update [ERPSettings].[ComponentByRole] set [IsActive]=0 where [IdComponent]='6bebb783-7dca-4a79-9a0a-820d4b40d330' and [IdRole] = 1039



