
PRINT N'Creating [HangFire]...';


GO
CREATE SCHEMA [HangFire]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [HangFire].[Schema]...';


GO
CREATE TABLE [HangFire].[Schema] (
    [Version] INT NOT NULL,
    CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED ([Version] ASC)
);


GO
PRINT N'Creating [HangFire].[Job]...';


GO
CREATE TABLE [HangFire].[Job] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [StateId]        BIGINT         NULL,
    [StateName]      NVARCHAR (20)  NULL,
    [InvocationData] NVARCHAR (MAX) NOT NULL,
    [Arguments]      NVARCHAR (MAX) NOT NULL,
    [CreatedAt]      DATETIME       NOT NULL,
    [ExpireAt]       DATETIME       NULL,
    CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [HangFire].[Job].[IX_HangFire_Job_StateName]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName]
    ON [HangFire].[Job]([StateName] ASC) WHERE ([StateName] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[Job].[IX_HangFire_Job_ExpireAt]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt]
    ON [HangFire].[Job]([ExpireAt] ASC)
    INCLUDE([StateName]) WHERE ([ExpireAt] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[State]...';


GO
CREATE TABLE [HangFire].[State] (
    [Id]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [JobId]     BIGINT         NOT NULL,
    [Name]      NVARCHAR (20)  NOT NULL,
    [Reason]    NVARCHAR (100) NULL,
    [CreatedAt] DATETIME       NOT NULL,
    [Data]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED ([JobId] ASC, [Id] ASC)
);


GO
PRINT N'Creating [HangFire].[JobParameter]...';


GO
CREATE TABLE [HangFire].[JobParameter] (
    [JobId] BIGINT         NOT NULL,
    [Name]  NVARCHAR (40)  NOT NULL,
    [Value] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED ([JobId] ASC, [Name] ASC)
);


GO
PRINT N'Creating [HangFire].[JobQueue]...';


GO
CREATE TABLE [HangFire].[JobQueue] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [JobId]     BIGINT        NOT NULL,
    [Queue]     NVARCHAR (50) NOT NULL,
    [FetchedAt] DATETIME      NULL,
    CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED ([Queue] ASC, [Id] ASC)
);


GO
PRINT N'Creating [HangFire].[Server]...';


GO
CREATE TABLE [HangFire].[Server] (
    [Id]            NVARCHAR (100) NOT NULL,
    [Data]          NVARCHAR (MAX) NULL,
    [LastHeartbeat] DATETIME       NOT NULL,
    CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [HangFire].[Server].[IX_HangFire_Server_LastHeartbeat]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat]
    ON [HangFire].[Server]([LastHeartbeat] ASC);


GO
PRINT N'Creating [HangFire].[List]...';


GO
CREATE TABLE [HangFire].[List] (
    [Id]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Key]      NVARCHAR (100) NOT NULL,
    [Value]    NVARCHAR (MAX) NULL,
    [ExpireAt] DATETIME       NULL,
    CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED ([Key] ASC, [Id] ASC)
);


GO
PRINT N'Creating [HangFire].[List].[IX_HangFire_List_ExpireAt]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt]
    ON [HangFire].[List]([ExpireAt] ASC) WHERE ([ExpireAt] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[Set]...';


GO
CREATE TABLE [HangFire].[Set] (
    [Key]      NVARCHAR (100) NOT NULL,
    [Score]    FLOAT (53)     NOT NULL,
    [Value]    NVARCHAR (256) NOT NULL,
    [ExpireAt] DATETIME       NULL,
    CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED ([Key] ASC, [Value] ASC)
);


GO
PRINT N'Creating [HangFire].[Set].[IX_HangFire_Set_Score]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score]
    ON [HangFire].[Set]([Key] ASC, [Score] ASC);


GO
PRINT N'Creating [HangFire].[Set].[IX_HangFire_Set_ExpireAt]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt]
    ON [HangFire].[Set]([ExpireAt] ASC) WHERE ([ExpireAt] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[Counter]...';


GO
CREATE TABLE [HangFire].[Counter] (
    [Key]      NVARCHAR (100) NOT NULL,
    [Value]    INT            NOT NULL,
    [ExpireAt] DATETIME       NULL
);


GO
PRINT N'Creating [HangFire].[Counter].[CX_HangFire_Counter]...';


GO
CREATE CLUSTERED INDEX [CX_HangFire_Counter]
    ON [HangFire].[Counter]([Key] ASC);


GO
PRINT N'Creating [HangFire].[Hash]...';


GO
CREATE TABLE [HangFire].[Hash] (
    [Key]      NVARCHAR (100) NOT NULL,
    [Field]    NVARCHAR (100) NOT NULL,
    [Value]    NVARCHAR (MAX) NULL,
    [ExpireAt] DATETIME2 (7)  NULL,
    CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED ([Key] ASC, [Field] ASC)
);


GO
PRINT N'Creating [HangFire].[Hash].[IX_HangFire_Hash_ExpireAt]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt]
    ON [HangFire].[Hash]([ExpireAt] ASC) WHERE ([ExpireAt] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[AggregatedCounter]...';


GO
CREATE TABLE [HangFire].[AggregatedCounter] (
    [Key]      NVARCHAR (100) NOT NULL,
    [Value]    BIGINT         NOT NULL,
    [ExpireAt] DATETIME       NULL,
    CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED ([Key] ASC)
);


GO
PRINT N'Creating [HangFire].[AggregatedCounter].[IX_HangFire_AggregatedCounter_ExpireAt]...';


GO
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt]
    ON [HangFire].[AggregatedCounter]([ExpireAt] ASC) WHERE ([ExpireAt] IS NOT NULL);


GO
PRINT N'Creating [HangFire].[FK_HangFire_State_Job]...';


GO
ALTER TABLE [HangFire].[State] WITH NOCHECK
    ADD CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY ([JobId]) REFERENCES [HangFire].[Job] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [HangFire].[FK_HangFire_JobParameter_Job]...';


GO
ALTER TABLE [HangFire].[JobParameter] WITH NOCHECK
    ADD CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY ([JobId]) REFERENCES [HangFire].[Job] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO

ALTER TABLE [HangFire].[State] WITH CHECK CHECK CONSTRAINT [FK_HangFire_State_Job];

ALTER TABLE [HangFire].[JobParameter] WITH CHECK CHECK CONSTRAINT [FK_HangFire_JobParameter_Job];


GO
PRINT N'Update complete.';


GO
