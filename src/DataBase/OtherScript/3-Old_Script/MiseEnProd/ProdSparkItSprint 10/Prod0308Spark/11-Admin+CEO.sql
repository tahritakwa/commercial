---- deactivate the menu transfert de référentiel 
update [ERPSettings].[ModuleByRole] set [IsActive]=0 where [IdModule]=N'a52beb65-894c-47f0-ba55-d99e5e17ca2a' and [IdRole] IN (1, 1041)
update [ERPSettings].[FunctionalityByRole]
   set [IsActive] = 0
 where [IdRole] IN (1, 1041) and IdFunctionality in (
	select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a'
 ) 
go
update [ERPSettings].[ComponentByRole]
   set [IsActive] = 0
 where [IdRole] IN (1, 1041) and [IdComponent] in (select IdComponent from ERPSettings.Component where (IdFunctionalityform in (select IdFunctionnality from ERPSettings.FunctionnalityModule where IdModule = N'a52beb65-894c-47f0-ba55-d99e5e17ca2a')))
go