
GO
ALTER TABLE [Master].[MasterUser]
    ADD [AccountNonExpired]     BIT           DEFAULT ((1)) NOT NULL,
        [AccountNonLocked]      BIT           DEFAULT ((1)) NOT NULL,
        [Enabled]               BIT           DEFAULT ((1)) NOT NULL,
        [CredentialsNonExpired] BIT           DEFAULT ((1)) NOT NULL,
        [Language]              NVARCHAR (50) NULL;


GO
PRINT N'Creating [dbo].[DBComptaConfig]...';


GO
CREATE TABLE [dbo].[DBComptaConfig] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [url]             NVARCHAR (255) NOT NULL,
    [username]        NVARCHAR (255) NOT NULL,
    [password]        NVARCHAR (255) NOT NULL,
    [driverClassName] NVARCHAR (255) NOT NULL,
    [companyCode]     NVARCHAR (255) NOT NULL,
    [env]             NVARCHAR (255) NULL,
    [module]          NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[flyway_schema_history]...';


GO
CREATE TABLE [dbo].[flyway_schema_history] (
    [installed_rank] INT             NOT NULL,
    [version]        NVARCHAR (50)   NULL,
    [description]    NVARCHAR (200)  NULL,
    [type]           NVARCHAR (20)   NOT NULL,
    [script]         NVARCHAR (1000) NOT NULL,
    [checksum]       INT             NULL,
    [installed_by]   NVARCHAR (100)  NOT NULL,
    [installed_on]   DATETIME        NOT NULL,
    [execution_time] INT             NOT NULL,
    [success]        BIT             NOT NULL,
    CONSTRAINT [flyway_schema_history_pk] PRIMARY KEY CLUSTERED ([installed_rank] ASC)
);


GO
PRINT N'Creating [dbo].[flyway_schema_history].[flyway_schema_history_s_idx]...';


GO
CREATE NONCLUSTERED INDEX [flyway_schema_history_s_idx]
    ON [dbo].[flyway_schema_history]([success] ASC);


GO
PRINT N'Creating [dbo].[oauth_access_token]...';


GO
CREATE TABLE [dbo].[oauth_access_token] (
    [token_id]          VARCHAR (MAX)   NULL,
    [token]             VARBINARY (MAX) NULL,
    [authentication_id] VARCHAR (MAX)   NULL,
    [user_name]         VARCHAR (MAX)   NULL,
    [client_id]         VARCHAR (MAX)   NULL,
    [authentication]    VARBINARY (MAX) NULL,
    [refresh_token]     VARCHAR (MAX)   NULL
);


GO
PRINT N'Creating [dbo].[oauth_client_details]...';


GO
CREATE TABLE [dbo].[oauth_client_details] (
    [client_id]               VARCHAR (255) NOT NULL,
    [client_secret]           VARCHAR (255) NULL,
    [resource_ids]            VARCHAR (255) NULL,
    [scope]                   VARCHAR (50)  NULL,
    [authorized_grant_types]  VARCHAR (255) NULL,
    [web_server_redirect_uri] VARCHAR (255) NULL,
    [authorities]             VARCHAR (255) NULL,
    [access_token_validity]   INT           NULL,
    [refresh_token_validity]  INT           NULL,
    [additional_information]  VARCHAR (255) NULL,
    [autoapprove]             VARCHAR (255) NULL,
    CONSTRAINT [PK_oauth_client_details] PRIMARY KEY CLUSTERED ([client_id] ASC)
);


GO
PRINT N'Creating [dbo].[oauth_refresh_token]...';


GO
CREATE TABLE [dbo].[oauth_refresh_token] (
    [token_id]       VARCHAR (MAX)   NULL,
    [token]          VARBINARY (MAX) NULL,
    [authentication] VARBINARY (MAX) NULL
);


GO
PRINT N'Creating [Master].[MasterModule]...';


GO
CREATE TABLE [Master].[MasterModule] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Code] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [PK_MasterModule] UNIQUE NONCLUSTERED ([Code] ASC)
);


GO
PRINT N'Creating [Master].[MasterPermission]...';


GO
CREATE TABLE [Master].[MasterPermission] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Code]        VARCHAR (255) NULL,
    [IdSubModule] INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [PK_MasterPermission] UNIQUE NONCLUSTERED ([Code] ASC)
);


GO
PRINT N'Creating [Master].[MasterRole]...';


GO
CREATE TABLE [Master].[MasterRole] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [Code]      VARCHAR (255) NULL,
    [Label]     VARCHAR (255) NULL,
    [IdCompany] INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Master].[MasterRolePermission]...';


GO
CREATE TABLE [Master].[MasterRolePermission] (
    [IdRole]       INT NOT NULL,
    [IdPermission] INT NOT NULL,
    [Id]           INT IDENTITY (1, 1) NOT NULL,
    [IsDeleted]    BIT NOT NULL,
    CONSTRAINT [PK_MasterRolePermission_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Master].[MasterRoleUser]...';


GO
CREATE TABLE [Master].[MasterRoleUser] (
    [IdMasterUser]    INT NOT NULL,
    [IdRole]          INT NOT NULL,
    [Id]              INT IDENTITY (1, 1) NOT NULL,
    [IsDeleted]       BIT NOT NULL,
    [IdMasterCompany] INT NULL,
    CONSTRAINT [PK_MasterRoleUser_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Master].[MasterSubModule]...';


GO
CREATE TABLE [Master].[MasterSubModule] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Code]     VARCHAR (255) NULL,
    [IdModule] INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [PK_MasterSubModule] UNIQUE NONCLUSTERED ([Code] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[flyway_schema_history]...';


GO
ALTER TABLE [dbo].[flyway_schema_history]
    ADD DEFAULT (getdate()) FOR [installed_on];


GO
PRINT N'Creating unnamed constraint on [Master].[MasterRolePermission]...';


GO
ALTER TABLE [Master].[MasterRolePermission]
    ADD DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating unnamed constraint on [Master].[MasterRoleUser]...';


GO
ALTER TABLE [Master].[MasterRoleUser]
    ADD DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [Master].[FK_MasterPermission_MasterSubModule]...';


GO
ALTER TABLE [Master].[MasterPermission] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterPermission_MasterSubModule] FOREIGN KEY ([IdSubModule]) REFERENCES [Master].[MasterSubModule] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterRole_MasterCompany]...';


GO
ALTER TABLE [Master].[MasterRole] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterRole_MasterCompany] FOREIGN KEY ([IdCompany]) REFERENCES [Master].[MasterCompany] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterPermission_MasterRole]...';


GO
ALTER TABLE [Master].[MasterRolePermission] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterPermission_MasterRole] FOREIGN KEY ([IdRole]) REFERENCES [Master].[MasterRole] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterRolePermission_MasterPermission]...';


GO
ALTER TABLE [Master].[MasterRolePermission] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterRolePermission_MasterPermission] FOREIGN KEY ([IdPermission]) REFERENCES [Master].[MasterPermission] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterRoleUser_MasterRole]...';


GO
ALTER TABLE [Master].[MasterRoleUser] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterRoleUser_MasterRole] FOREIGN KEY ([IdRole]) REFERENCES [Master].[MasterRole] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterRoleUser_MasterUser]...';


GO
ALTER TABLE [Master].[MasterRoleUser] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterRoleUser_MasterUser] FOREIGN KEY ([IdMasterUser]) REFERENCES [Master].[MasterUser] ([Id]);


GO
PRINT N'Creating [Master].[FK_MasterSubModule_MasterModule]...';


GO
ALTER TABLE [Master].[MasterSubModule] WITH NOCHECK
    ADD CONSTRAINT [FK_MasterSubModule_MasterModule] FOREIGN KEY ([IdModule]) REFERENCES [Master].[MasterModule] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Master].[MasterPermission] WITH CHECK CHECK CONSTRAINT [FK_MasterPermission_MasterSubModule];

ALTER TABLE [Master].[MasterRole] WITH CHECK CHECK CONSTRAINT [FK_MasterRole_MasterCompany];

ALTER TABLE [Master].[MasterRolePermission] WITH CHECK CHECK CONSTRAINT [FK_MasterPermission_MasterRole];

ALTER TABLE [Master].[MasterRolePermission] WITH CHECK CHECK CONSTRAINT [FK_MasterRolePermission_MasterPermission];

ALTER TABLE [Master].[MasterRoleUser] WITH CHECK CHECK CONSTRAINT [FK_MasterRoleUser_MasterRole];

ALTER TABLE [Master].[MasterRoleUser] WITH CHECK CHECK CONSTRAINT [FK_MasterRoleUser_MasterUser];

ALTER TABLE [Master].[MasterSubModule] WITH CHECK CHECK CONSTRAINT [FK_MasterSubModule_MasterModule];

