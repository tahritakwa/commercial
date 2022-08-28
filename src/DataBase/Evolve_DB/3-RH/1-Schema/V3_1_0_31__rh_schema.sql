-- 02/02/2021 Rabeb: Modify comment table

alter table [ERPSettings].[Comment] drop CONSTRAINT IF EXISTS [FK_Comment_User]




alter table [ERPSettings].[Comment]
drop column IF EXISTS [IdCreator]

IF COL_LENGTH ('ERPSettings.Comment','EmailCreator') IS NULL
BEGIN
alter table [ERPSettings].[Comment]
add [EmailCreator]      NVARCHAR (255) NULL
END;


--21/09/2020: Rabeb: delete role table and other tables


GO
PRINT N'Update complete.';


GO
PRINT N'Suppression de [dbo].[ClientDetails]...';


GO
DROP TABLE [dbo].[ClientDetails];


GO
PRINT N'Suppression de [dbo].[oauth_access_token]...';


GO
DROP TABLE [dbo].[oauth_access_token];


GO
PRINT N'Suppression de [dbo].[oauth_approvals]...';


GO
DROP TABLE [dbo].[oauth_approvals];


GO
PRINT N'Suppression de [dbo].[oauth_client_details]...';


GO
DROP TABLE [dbo].[oauth_client_details];


GO
PRINT N'Suppression de [dbo].[oauth_client_token]...';


GO
DROP TABLE [dbo].[oauth_client_token];


GO
PRINT N'Suppression de [dbo].[oauth_code]...';


GO
DROP TABLE [dbo].[oauth_code];


GO
PRINT N'Suppression de [dbo].[oauth_refresh_token]...';


GO
DROP TABLE [dbo].[oauth_refresh_token];


GO
PRINT N'Mise à jour terminée.';


GO
